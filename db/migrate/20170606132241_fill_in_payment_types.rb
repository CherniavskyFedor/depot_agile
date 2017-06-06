class FillInPaymentTypes < ActiveRecord::Migration
  def up
    ["Check", "Credit card", "Purchase order"].each do |i|
      PaymentType.find_or_create_by(name: i)
    end
  end

  def down
    ["Check", "Credit card", "Purchase order"].each do |i|
      PaymentType.where(name: i).each(&:destroy)
    end
  end
end
