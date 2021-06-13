class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood, presence: true
  after_save :change_user_status_to_host
  after_destroy :change_user_status_to_regular

  def change_user_status_to_host
    self.host.host?(true)
  end

  def change_user_status_to_regular
    if (self.host.listings.size == 0) then
      self.host.host?(false)
    end 
  end

  def average_review_rating
    sum_of_ratings = 0
    self.reviews.each {|review| sum_of_ratings += review.rating}
    sum_of_ratings.to_f / self.reviews.size
  end

  def to_s
    puts "Title: #{self.title}"
  end
end