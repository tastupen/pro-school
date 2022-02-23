class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.float :rate, null: false, default: 0
      
      t.references :lesson, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
