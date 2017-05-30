class AddQuantityToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :quantity, :integer, default: 1
    #add_column - metod kotorii dobavlyaet ya4eiky v bazy
    #1argyment - eto imya tablici v kotoryu ya4eika bydet dobavlena
    #2argyment - imya ya4eiki
    #3argyment - tip danix etoi ya4eiki
    #4argyment - dopolnitel`nie parametri
  end
end
