class AddStyleDescriptionToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :style_description, :text
  end
end
