class User < ActiveRecord::Base
  has_secure_password

  before_validation :downcase_email

  has_many :review
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, :password_confirmation, presence: true, length: {minimum: 6}

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by(email: email.downcase.strip)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end


end
