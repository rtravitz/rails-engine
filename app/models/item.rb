class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  validates :name, :description, :unit_price, presence: true

  def self.random
    offset = rand(Item.count)
    rand_record = Item.offset(offset).first
  end

end
