class Order < ApplicationRecord
  belongs_to :user
  belongs_to :formation
  belongs_to :inscription
end
