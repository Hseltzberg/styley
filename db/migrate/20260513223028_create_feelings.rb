class CreateFeelings < ActiveRecord::Migration[8.0]
  def change
    create_table :feelings do |t|
      t.string :name

      t.timestamps
    end
  end
end
