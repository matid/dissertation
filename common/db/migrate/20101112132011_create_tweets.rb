class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :status_id, :null => false
      t.string :language, :null => false
      t.string :text, :null => false
      t.string :sentiment
      t.text :json, :null => false
    end

    add_index :tweets, :status_id, :unique => true
    add_index :tweets, :language
    add_index :tweets, :sentiment
  end

  def self.down
    drop_table :tweets
  end
end