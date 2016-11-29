class ChangeUnitPriceAgain < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :unit_price, :string
    change_column :invoice_items, :unit_price, :string
  end
end
