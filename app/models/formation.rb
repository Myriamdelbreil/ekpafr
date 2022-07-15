class Formation < ApplicationRecord
  belongs_to :theme
  has_many :inscriptions
  has_many :orders
  has_many_attached :photos
  has_many_attached :videos
  enum liste_prix: %i[500 750 1000 1500 2000 3000 4000 5000]
  scope :filter_by_sujet, ->(sujet) { where sujet: sujet }
  scope :filter_by_lieu, ->(lieu) { where('lieu ILIKE ?', "#{lieu}%") }
end
