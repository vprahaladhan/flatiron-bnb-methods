class AcceptedReservationValidator < ActiveModel::Validator
  def validate(record)
    if record.reservation.nil? then 
      record.errors[:reservation] << "Cannot review a reservation which doesn't exist!"
    else
      if record.reservation.status != 'accepted' then
        record.errors[:status] << "Cannot review a reservation which is not accepted!"
      end

      if record.reservation.checkout >= Date.today then
        record.errors[:checkout] << "Cannot review a reservation which is not over!"
      end
    end
  end
end