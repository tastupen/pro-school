class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.datetime :start_date

      t.timestamps
    end
  end
end
