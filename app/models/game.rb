class Game < ApplicationRecord
  has_many :frames
  has_and_belongs_to_many :players, -> { distinct }
end
