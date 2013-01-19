class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :path
      t.string :cursor
      t.string :rev

      t.timestamps
    end

    add_index :photos, :rev
  end
end
