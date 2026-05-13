class CreateOccasions < ActiveRecord::Migration[8.0]
  def change
    create_table :occasions do |t|
      t.string :name

      t.timestamps
    end
  end
end
