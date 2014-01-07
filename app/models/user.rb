class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }

end
