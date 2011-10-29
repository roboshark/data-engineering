Factory.sequence :name do |n|
  "Test Name #{n}"
end

Factory.define :purchaser, :class => Purchaser do |f|
  f.name { Factory.next(:name) }
end

Factory.define :merchant, :class => Merchant do |f|
  f.name { Factory.next(:name) }
  f.address '123 Test Road, Durham, NC 27701'
end

Factory.define :item, :class => Item do |f|
  f.merchant { Factory.create(:merchant) }
  f.description { Factory.next(:name) }
  f.price 5000
end

Factory.define :purchase, :class => Purchase do |f|
  f.purchaser { Factory.create(:purchaser) }
  f.item { Factory.create(:item) }
  f.upload { Factory.create(:upload) }
  f.count 2
end

Factory.define :upload, :class => Upload do |f|
  f.file_uid '1234567'
  f.file_name 'Test File'
  f.start_time Time.now-100
  f.end_time Time.now
end

Factory.define :upload_message, :class => UploadMessage do |f|
  f.upload { Factory.create(:upload) }
  f.message 'The purchaser name is missing'
  f.row_number 2
end

