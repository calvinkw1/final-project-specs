class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :uid
      t.string :searchParams
      t.string :origin
      t.string :destination
      t.string :departDate
      t.string :returnDate
      t.integer :adultCount
      t.integer :childCount
      t.string :maxPrice
      t.string :preferredCabin
      t.string :permittedCarrier
      t.string :prohibitedCarrier
      
      t.timestamps null: false
    end
  end
end
