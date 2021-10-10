class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password_digest
      t.belongs_to :member, index: { unique: true }, foreign_key: true

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
