class ModifyFieldsInExchangeRates < ActiveRecord::Migration[5.0]
  def change
    change_column :exchange_rates, :rate, :decimal
  end
end
