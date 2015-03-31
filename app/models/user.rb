class User < ActiveRecord::Base
    has_secure_password
    validates :email,
    presence: true,
    uniqueness: true

    has_many :alerts


  def confirm(password_param)
    authenticate(password_param)
  end

end
