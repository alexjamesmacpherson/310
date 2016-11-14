class AddChangedToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :users_changed, :boolean, default: false
  end
end
