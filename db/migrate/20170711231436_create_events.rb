class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :command
      t.string :user_id

      t.timestamps
    end
  end
end
