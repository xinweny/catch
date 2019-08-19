class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :address
      t.datetime :start
      t.datetime :end
      t.text :description
      t.integer :phase
      t.references :colony, foreign_key: true

      t.timestamps
    end
  end
end
