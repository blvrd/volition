class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :unique_token
      t.string :stripe_charge_id
      t.string :recipient_email
      t.text :message
      t.string :recipient_name

      t.timestamps
    end
    add_index :gifts, :unique_token, unique: true
  end
end
