class AddChangedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gravatar_changed, :boolean, default: false
  end
end
