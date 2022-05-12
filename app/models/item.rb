class Item < ApplicationRecord
  attachment :image
  has_many :cart_items
  has_many :order_items
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
end
