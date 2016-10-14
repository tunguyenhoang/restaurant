class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  attr_accessor :coupon_code
    # before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  private

    def update_subtotal
      self[:subtotal] = subtotal
    end
end
