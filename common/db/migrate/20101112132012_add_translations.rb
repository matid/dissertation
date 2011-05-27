class AddTranslations < ActiveRecord::Migration
  def self.up
    add_column :tweets, :translation, :text
  end

  def self.down
    remove_column :tweets, :translation
  end
end