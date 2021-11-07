class AddDonningLocation < ActiveRecord::Migration[6.0]
  def change
    add_reference :donnings, :location, null: false, foreign_key: true
  end
end
