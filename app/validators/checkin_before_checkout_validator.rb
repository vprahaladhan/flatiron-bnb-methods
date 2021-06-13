class CheckinBeforeCheckoutValidator < ActiveModel::Validator
  def validate(record)
    if (record.checkin.nil?) then
      record.errors[:checkin] << "Invalid/empty checkin date!"
    end
    if (record.checkout.nil?) then
      record.errors[:checkout] << "Invalid/empty checkout date!"
    end
    if (!record.checkin.nil? && !record.checkout.nil? && record.checkin >= record.checkout)
      record.errors[:checkout] << "Checkout can't be before or on the day of checkin!"
    end
  end
end