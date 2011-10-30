class Upload < ActiveRecord::Base
  
  validates :file_uid, :length => { :maximum => 200 }
  validates :file_name, :length => { :maximum => 100 }

  has_many :upload_messages, :dependent => :destroy

  file_accessor :file

  # Return the next upload that needs to be processed
  def self.next
    where('uploads.start_time is null').order('uploads.created_at asc').first
  end

  # Run as a daemon processing new uploads.  This method is executed in a separate process.
  def self.run

    while true

      upload = Uplaod.next

      if upload.nil?
        sleep(5)
      else
        upload.process
      end
      
    end

  end

  def process

    # Save the start time so we know this one is in process
    self.start_time = Time.now
    save!

    # Any unexpected errors should roll back the whole upload
    ActiveRecord::Base.transaction do

      row_num = 2 # first data line is after header

      CSV.foreach(file.path, :headers => true, :col_sep => "\t") do |row|

        purchaser = Purchaser.find_or_create(:name => row['purchaser name'])
        add_error_messages(row_num, purchaser)

        merchant = Merchant.find_or_create(:name => row['merchant name'], :address => row['merchant address'])
        add_error_messages(row_num, merchant)

        if purchaser.valid? && merchant.valid?

          # Turn the price into cents

          price = row['item price']

          if price =~ /^\d*\.\d{1,2}$/
            dollars, cents = price.split('.')
            price = (dollars.to_i * 100) + cents.to_i
          end

          item = Item.find_or_create(:description => row['item description'], :merchant => merchant, :price => price)
          add_error_messages(row_num, item)

          if item.valid?
            purchase = Purchase.create(:item => item, :purchaser => purchaser, :count => row['purchase count'], :upload => self)
            add_error_messages(row_num, purchase)
          end

        else

        end

        row_num += 1

      end 

      # Save the end time so we know this one is finished
      self.end_time = Time.now
      save!

    end

  end

  def gross_revenue
    Upload.connection.select_value("select sum(purchases.count*items.price) from purchases join items on items.id = purchases.item_id where purchases.upload_id = #{self.id}")
  end

  private

  def add_error_messages(row_num, record)
    record.errors.full_messages.each do |error|
      self.upload_messages << UploadMessage.new(:message => error, :row_number => row_num)
    end
  end

end
