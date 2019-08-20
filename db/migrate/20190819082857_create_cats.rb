class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.string :name
      t.string :description
      t.integer :sex
      t.integer :age
      t.string :photo
      t.text :health
      t.string :microchip_id
      t.integer :status, default: 0
      t.float :longitude
      t.float :latitude
      t.references :colony, foreign_key: true

      t.timestamps
    end
  end
end
