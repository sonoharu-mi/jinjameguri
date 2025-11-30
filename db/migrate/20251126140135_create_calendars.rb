class CreateCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|
      t.string :event
      t.string :prefecture
      t.string :city
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
