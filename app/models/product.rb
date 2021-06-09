# frozen_string_literal: true

class Product < ApplicationRecord
  # has_and_belongs_to_many :category
  belongs_to :category

  validates :product_name, :unit_price, :stock, :image, presence: true
  validates :unit_price, numericality: { only_decimal: true }

  has_one_attached :product_image

  def thumbnail
    product_image.variant(resize: '500x500!').processed
  end
end
