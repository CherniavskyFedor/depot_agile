class CombineItemsInCart < ActiveRecord::Migration
  def up
    #zamena neskol`kix zapisei dlya odnonogo i togo je tovara v korziny odnoi zapis`u
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          #ydalenie otdel`nix zapisei
          cart.line_items.where(product_id: product_id).delete_all
          #zamena odnoi zapis`u
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    #razbiranie zapisei s quantity >1 na neskol`ko zapisei
    LineItem.where("quantity > 1").each do |line_item|
      # dobovlenie idnvidyal`nogo s4e4ika itmes
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
      end
      #ydalenie isxodnoi zapisi
      line_item.destroy
    end
  end
end
