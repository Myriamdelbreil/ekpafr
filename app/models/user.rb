class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :confirmation_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Minimum eight characters, at least one letter and one number:
  validates :password, format: { with: /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\z/ }
  validates :email, format: { with: /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/}
  has_many :inscriptions
  has_one_attached :photo
  DIPLOMES = ["BEP/CAP", "Baccalauréat professionnel", "Baccalauréat général/technologique", "Bac +2", "Licence", "Master", "Doctorat"]
  validates :diplome, inclusion: DIPLOMES
  SITE_CONNU = ["Google", "Facebook", "Twitter", "Instagram", "Autre réseau social", "Email", "Bouche à oreille", "Autre"]
  validates :site_connu, inclusion: { in: SITE_CONNU }

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
