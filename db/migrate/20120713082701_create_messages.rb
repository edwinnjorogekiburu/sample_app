class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :reciepient_id
      t.integer :sender_id
      t.string :subject
      t.string :message
      t.boolean :read , default: false

      t.timestamps
    end
  end
end
