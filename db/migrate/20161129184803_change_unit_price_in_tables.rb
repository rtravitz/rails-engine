class ChangeUnitPriceInTables < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :unit_price, :bigint
    change_column :invoice_items, :unit_price, :bigint
    change_column :transactions, :credit_card_number, :bigint
  end
end
