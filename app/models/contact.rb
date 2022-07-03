class Contact < ApplicationRecord
  validates :email, :name, :content, presence: true
end
