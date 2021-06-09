# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # validates :unit_price, :quantity, :tax_rate, presence: true

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.unit_price
    end
  end

  def total
    unit_price * quantity
  end

  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_total
    self[:total] = total * quantity
  end
end
