class AddUrlExpiresAtToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :url_expires_at, :datetime
  end
end
