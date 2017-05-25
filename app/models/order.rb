class Order < ActiveRecord::Base
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  has_many :line_items, dependent: :destroy
  #belongs_to :product

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def to_json
    {
        id: id, address: address, total_price: line_items.map(&:total_price).sum, pay_type: pay_type,
        line_items: line_items.map{|i| [i.product.title, i.quantity, i.total_price]}
     }.to_json + "\n"
  end
end
