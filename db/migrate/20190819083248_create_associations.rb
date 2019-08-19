class CreateAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :associations do |t|
      t.boolean :admin, default: false
      t.references :colony, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
