class RenameStartDateColumnToReservation < ActiveRecord::Migration[6.1]
  def change
    rename_column :reservations, :start_date, :start_time
  end
end
