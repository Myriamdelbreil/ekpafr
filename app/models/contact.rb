class Contact
  include ActiveModel::Model
  attr_accessor :name, :email, :phone_number, :body, :nickname, :captcha
  validates :name, :email, :phone_number, :body, presence: true
end
