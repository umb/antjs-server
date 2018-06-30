class AddCompletedToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :completed, :boolean
  end
end
