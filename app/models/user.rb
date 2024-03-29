class User < ActiveRecord::Base
  # has_secure_password will give us functionalities needed for user authentication:
  # 1 - It will add attributes accessors: password, password_confirmation
  # 2 - It will add a validation for password presence and length of password (4..72)
  # 3 - If password_confirmation is set, it will validate that it's the same as password
  # 4 - It will add handy methods for us to automatically hash the password the password_digest field
        # and compare a given password

  has_secure_password

  has_many :questions, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_create :generate_api_key

  def full_name
    "#{first_name} #{last_name}"
  end


private

  def generate_api_key
    # begin
    #   self.api_key = SecureRandom.urlsafe_base64
    # end while User.exists?(api_key: api_key)
    loop do
      self.api_key = SecureRandom.urlsafe_base64
      break unless User.exists?(api_key: api_key)
    end
  end
end
