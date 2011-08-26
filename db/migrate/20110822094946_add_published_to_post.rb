class AddPublishedToPost < ActiveRecord::Migration
  def change
    remove_column :posts, :draft
    add_column :posts, :published, :boolean, :default => false
  end
end
