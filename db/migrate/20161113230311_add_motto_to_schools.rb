class AddMottoToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :motto, :string
  end
end
