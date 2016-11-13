class AddGravatarToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :gravatar, :boolean, default: false
    add_column :users, :gravatar, :boolean, default: true
    add_column :users, :color, :integer, default: 1
  end
end
