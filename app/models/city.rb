class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def self.highest_ratio_res_to_listings
    max_count = 0
    city_name = nil
    self.all.each do |city| 
      city.listings.each do |listing|
        if listing.reservations.size > max_count then
          max_count = listing.reservations.size
          city_name = city
        end
      end
    end
    city_name
  end

  def self.most_res
    max_count = 0
    city_name = nil
    self.all.each do |city| 
      total_reservations = 0
      city.listings.each do |listing|
        total_reservations += listing.reservations.size
      end
      if total_reservations > max_count then
        max_count = total_reservations
        city_name = city
      end
    end
    city_name
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

  def city_openings(checkin, checkout)
    all_available_listings(checkin.to_date, checkout.to_date)
  end
end