class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :line_one
      t.string :line_two
      t.string :city
      t.string :pin
      t.string :country
      t.integer :employee_id
      t.string :status

      t.timestamps
    end
  end
end
