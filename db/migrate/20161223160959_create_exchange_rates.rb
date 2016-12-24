class CreateExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_rates do |t|
      t.integer :rate
      t.datetime :date

      t.timestamps
    end
  end
end
