class AddSearchToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :search, :boolean, :default => false
  end
end
