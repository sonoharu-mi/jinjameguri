class AddUserIdToCalendars < ActiveRecord::Migration[6.1]
  def change
    add_reference :calendars, :user, foreign_key: true
  end
end
