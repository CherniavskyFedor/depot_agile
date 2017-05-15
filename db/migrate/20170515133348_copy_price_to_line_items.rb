class CopyPriceToLineItems < ActiveRecord::Migration
  def up
    Product.all.each do |product|
      product.line_items.each do |line_item|
        line_item.price = product.price
        line_item.save
      end
    end
  end

  def down
  end
end
