class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_initial
      t.string :pet
      t.string :dob
      t.string :favorite_color

      t.timestamps
    end
  end
end
