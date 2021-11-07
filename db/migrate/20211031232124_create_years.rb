class CreateYears < ActiveRecord::Migration[6.0]
  def change
    create_table :years do |t|
      t.integer :num

      t.timestamps
    end
  end
end
