ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def assert_validates_nil(object, attribute)
    object.send(attribute.to_s + '=', nil)
    assert !object.valid?, "A nil value was allowed for #{attribute}."
  end

  def assert_validates_blank(object, attribute)
    object.send(attribute.to_s + '=', ' ')
    assert !object.valid?, "A blank value was allowed for #{attribute}."
    assert_validates_nil(object, attribute)
  end

  def assert_validates_length(object, attribute, max_length, min_length=0)
    
    object.send(attribute.to_s + '=', ('-' * max_length ) )
    assert object.valid?, "A value of #{max_length} was not allowed for #{attribute}."

    object.send(attribute.to_s + '=', ('-' * (max_length + 1) ) )
    assert !object.valid?, "A value greater than #{max_length} was allowed for #{attribute}."
    
    if min_length > 0
      object.send(attribute.to_s + '=', ('-' * (min_length - 1) ) )
      assert !object.valid?, "A value less than #{min_length} was allowed for #{attribute}."
    end
    
  end
  
  def assert_validates_numericality(object, attribute)
    value = 'foo'
    object.send(attribute.to_s + '=', value)
    assert !object.valid?, "A non-numerical value, #{value}, was allowed for #{attribute}."
  end
  
  def assert_validates_integer(object, attribute)
    
    assert_validates_numericality(object, attribute)
    
    value = 4.5
    object.send(attribute.to_s + '=', value)
    assert !object.valid?, "A non-integer value, #{value}, was allowed for #{attribute}."
    
  end

end
