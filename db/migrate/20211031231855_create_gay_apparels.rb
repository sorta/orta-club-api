class CreateGayApparels < ActiveRecord::Migration[6.0]
  def change
    create_table :gay_apparels do |t|
      t.string :name

      t.timestamps
    end
  end
end
