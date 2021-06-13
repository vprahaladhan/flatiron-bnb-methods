class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"
  validates :rating, presence: true
  validates :description, presence: true
  validates :reservation, presence: true
  include ActiveModel::Validations
  validates_with AcceptedReservationValidator
end
