class CreateSchema < ActiveRecord::Migration

  def change

    create_table :purchasers do |t|
      t.string :name, :limit => 100, :null => false
      t.timestamps
    end

    add_index :purchasers, :name

    create_table :merchants do |t|
      t.string :name, :limit => 100, :null => false
      t.string :address, :limit => 250, :null => false
      t.timestamps
    end

    add_index :merchants, [ :name, :address ]

    create_table :items do |t|
      t.string :description, :limit => 500, :null => false
      t.integer :price, :null => false # stored as cents
    end

    add_index :items, [ :description, :price ]

    create_table :purchases do |t|
      t.references :purchaser, :null => false
      t.references :item, :null => false
      t.integer :count, :null => false
    end

    add_index :purchases, :purchaser_id
    add_index :purchases, :item_id

    create_table :upload do |t|
      t.string :file_uid, :string, :limit => 500, :null => false
      t.string :file_name, :string, :limit => 100, :null => false
      t.timestamp :created_at, :null => false
      t.timestamp :start_time, :null => true
      t.timestamp :end_time, :null => true
    end

    create_table :upload_message do |t|
      t.references :upload, :null => false
      t.string :message, :limit => 500, :null => false
      t.integer :row_number, :null => true
      t.string :type, :limit => 15, :null => false
    end

  end

end
