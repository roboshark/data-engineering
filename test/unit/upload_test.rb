require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class UploadTest < ActiveSupport::TestCase

  test "file_uid validation" do
    upload = Factory.build(:upload)
    assert_validates_blank upload, 'file_uid'
    assert_validates_length upload, 'file_uid', 200
  end
  
  test "file_name validation" do
    upload = Factory.build(:upload)
    assert_validates_blank upload, 'file_name'
    assert_validates_length upload, 'file_name', 100
  end
  
end
