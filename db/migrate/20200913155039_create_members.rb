class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :name_first, null: false
      t.string :name_middle
      t.string :name_last
      t.date :birthdate
      t.boolean :is_approved, default: false
      t.string :slug, null: false

      t.timestamps
    end
  end
end
