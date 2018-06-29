class CreateCodeUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :code_uploads do |t|
      t.integer :player_id
      t.text :code

      t.timestamps
    end
  end
end
