class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name

      t.timestamps
    end
    add_reference :users, :school, index: true
    add_foreign_key :users, :schools
  end
end
