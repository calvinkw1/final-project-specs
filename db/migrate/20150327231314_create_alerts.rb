class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :uid
      t.integer :max_price
      t.date :date_outbound
      t.date :date_inbound
      t.string :origin
      t.string :destination
      t.boolean :round_trip, default: true
      t.integer :adults
      t.integer :children
      t.string :cabin_type
      t.string :airline
      t.integer :stops
      t.time :outbound_time
      t.time :inbound_time

      t.timestamps null: false
    end
  end
end
