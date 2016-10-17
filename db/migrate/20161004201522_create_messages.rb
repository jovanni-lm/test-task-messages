
class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :body
      t.string :destroy_option
      t.integer :countdown
      t.string :password
      t.string :url_alias
      t.integer :expiration_time
    end
  end

  def self.down
    drop_table :messages
  end
end
