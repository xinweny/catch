class AddLngLatToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :longitude, :float
    add_column :events, :latitude, :float
  end
end
