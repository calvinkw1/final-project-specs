class User < ActiveRecord::Base
    has_secure_password
    validates :email,
    presence: true,
    uniqueness: true


  def confirm(password_param)
    authenticate(password_param)
  end

end
