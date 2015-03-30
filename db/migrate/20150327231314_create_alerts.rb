class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :uid
      t.string :searchParams

      t.timestamps null: false
    end
  end
end
