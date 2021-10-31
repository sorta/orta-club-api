class CreateDonnings < ActiveRecord::Migration[6.0]
  def change
    create_table :donnings do |t|
      t.references :gay_apparel, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.references :year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
