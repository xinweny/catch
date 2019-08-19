class CreateColonies < ActiveRecord::Migration[5.2]
  def change
    create_table :colonies do |t|
      t.string :name
      t.string :address
      t.string :description
      t.float :radius
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
