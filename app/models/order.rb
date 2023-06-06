class Order < ApplicationRecord
  belongs_to :user
  belongs_to :driver, optional: true
  
  validates :pickup_address, presence: true
  validates :pickup_at, presence: true
  validates :dropoff_address, presence: true

  validate :check_address

  geocoded_by :pickup_address, latitude: :pickup_latitude, longitude: :pickup_longitude
  after_validation :geocode_pickup_location, if: :pickup_address_changed?

  geocoded_by :dropoff_address, latitude: :dropoff_latitude, longitude: :dropoff_longitude
  after_validation :geocode_dropoff_location, if: :dropoff_address_changed?

  def check_address
   errors.add(:dropoff_address, "can't be the same as pick up address") if pickup_address == dropoff_address
  end
  
  def distance
    if pickup_latitude && pickup_longitude && dropoff_latitude && dropoff_longitude
      @order.distance = Geocoder::Calculations.distance_between([pickup_latitude, pickup_longitude], [dropoff_latitude, dropoff_longitude])
    else
      nil
    end
  end

  private

  def geocode_pickup_location
    geocoded = Geocoder.search(pickup_address).first
    if geocoded
      self.pickup_latitude = geocoded.latitude
      self.pickup_longitude = geocoded.longitude
    end
  end

  def geocode_dropoff_location
    geocoded = Geocoder.search(dropoff_address).first
    if geocoded
      self.dropoff_latitude = geocoded.latitude
      self.dropoff_longitude = geocoded.longitude
    end
end
