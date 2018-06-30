class Player < ApplicationRecord
  has_many :code_uploads
  has_and_belongs_to_many :games, -> { distinct }
end
