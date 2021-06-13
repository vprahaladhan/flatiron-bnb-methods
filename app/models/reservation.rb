class Reservation < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  validates :checkin, presence: true
  validates :checkout, presence: true
  validates :listing, presence: true

  validates_with OwnListingReservationValidator
  validates_with CheckinBeforeCheckoutValidator
  validates_with ListingAvailableValidator

  def duration
    (self.checkout - self.checkin).to_i
  end

  def total_price
    duration * self.listing.price
  end

  def to_s
    puts "Checkin: #{self.checkin} > Checkout: #{self.checkout} > Listing: #{self.listing} > Guest: #{self.guest}"
  end
end
