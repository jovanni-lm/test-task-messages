class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :body
      t.string :destroy_option
      t.integer :countdown
      t.string :password
      t.datetime :published_on, :required => true
    end
  end

  def self.down
    drop_table :messages
  end
end
