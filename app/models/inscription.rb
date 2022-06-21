class Inscription < ApplicationRecord
  belongs_to :user
  belongs_to :formation
end
