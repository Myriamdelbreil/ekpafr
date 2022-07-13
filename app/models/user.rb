class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
end
