class Order < ApplicationRecord
  belongs_to :customer
  has_many :orde_items
  enum payment_method: { credit_card: 0, transfer: 1 }
end
