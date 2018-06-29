class CreateFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :frames do |t|
      t.integer :game_id
      t.text :value
      t.timestamps
    end
  end
end
