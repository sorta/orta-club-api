class AddMemberSlugUniqueIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :members, :slug, unique: true
  end
end
