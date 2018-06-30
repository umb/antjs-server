class AddExternalGameIdToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :external_id, :string
  end
end
