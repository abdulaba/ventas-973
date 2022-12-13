class Product < ApplicationRecord
  belongs_to :user
  has_many :sales

  validates :name, :description, :price, presence: true
end
