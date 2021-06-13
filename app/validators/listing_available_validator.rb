class ListingAvailableValidator < ActiveModel::Validator
  def validate(record)
    reservations = record.listing.reservations

    reservations.each do |res|
      if (record.checkin.nil? || record.checkout.nil?) then 
        record.errors[:reservation] << "Invalid checkin/checkout date!"
      elsif record.checkin < res.checkin then
        if record.checkout > res.checkin then 
          record.errors[:reservation] << "Listing not available for the requested dates!"
        end
      else
        if record.checkin < res.checkout then
          record.errors[:reservation] << "Listing not available for the requested dates!"
        end
      end
    end
  end
end