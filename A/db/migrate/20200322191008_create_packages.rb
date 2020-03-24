class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.string :carrier_id
      t.string :status
      t.string :description
      t.string :carrier

      t.timestamps
    end
  end
end
