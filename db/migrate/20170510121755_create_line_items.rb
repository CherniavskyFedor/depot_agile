class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :product, index: true # referencet eto toje samoe 4to i belongs_to
      t.belongs_to :cart, index: true #sozdaet celo4islenoe pole s imenem cart_id
      t.timestamps
    end
  end
end
