class AddPhotoToColonies < ActiveRecord::Migration[5.2]
  def change
    add_column :colonies, :photo, :string
  end
end
