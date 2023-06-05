class Order < ApplicationRecord
  belongs_to :user
  belongs_to :driver, optional: true
end
