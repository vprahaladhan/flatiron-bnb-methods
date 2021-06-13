class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def self.highest_ratio_res_to_listings
    max_count = 0
    neighborhood_name = nil
    self.all.each do |neighborhood| 
      neighborhood.listings.each do |listing|
        if listing.reservations.size > max_count then
          max_count = listing.reservations.size
          neighborhood_name = neighborhood
        end
      end
    end
    neighborhood_name
  end

  def self.most_res
    max_count = 0
    neighborhood_name = nil
    self.all.each do |neighborhood| 
      total_reservations = 0
      neighborhood.listings.each do |listing|
        total_reservations += listing.reservations.size
      end
      if total_reservations > max_count then
        max_count = total_reservations
        neighborhood_name = neighborhood
      end
    end
    neighborhood_name
  end

  def all_available_listings(checkin, checkout)
    available_listings = []
    self.listings.each do |listing|
      available = true
      listing.reservations.each do |res|
        if checkin.between?(res.checkin, res.checkout) || checkout.between?(res.checkin, res.checkout) then
          available = false
        end
      end
      available ? available_listings << listing : nil
    end
    available_listings
  end

  def neighborhood_openings(checkin, checkout)
    all_available_listings(checkin.to_date, checkout.to_date)
  end
end