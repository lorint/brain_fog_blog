class AddPostToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :post, index: true
    add_foreign_key :photos, :posts
  end
end
