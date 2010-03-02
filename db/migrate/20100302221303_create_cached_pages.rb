class CreateCachedPages < ActiveRecord::Migration
  def self.up
    create_table :cached_pages do |t|
      t.string :url
      t.text :contents
      t.timestamps
    end
  end

  def self.down
    drop_table :cached_pages
  end
end
