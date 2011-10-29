module UploadsHelper

  def cents_to_dollars(cents)
    number_to_currency("%d.%02d" % cents.divmod(100)) unless cents.nil?
  end

end
