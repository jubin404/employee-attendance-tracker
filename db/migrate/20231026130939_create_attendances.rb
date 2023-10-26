class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.integer :employee_id
      t.date :date
      t.time :punch_in_time
      t.time :punch_out_time
      t.string :attendance_status

      t.timestamps
    end
  end
end
