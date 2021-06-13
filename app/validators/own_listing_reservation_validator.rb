class OwnListingReservationValidator < ActiveModel::Validator
  def validate(record)
    unless record.listing.host_id != record.guest_id
      record.errors[:guest] << "Can't make a reservation for own listing!"
    end
  end
end