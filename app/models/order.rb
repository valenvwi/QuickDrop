class Order < ApplicationRecord
  belongs_to :user
  belongs_to :driver, optional: true

  validates :pickup_address, presence: true
  validates :pickup_at, presence: true
  validates :dropoff_address, presence: true

  validate :check_address

  def check_address
    errors.add(:dropoff_address, "can't be the same as pick up address") if pickup_address == dropoff_address
  end
end
