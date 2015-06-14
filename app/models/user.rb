class User < ActiveRecord::Base
  has_many :surveys
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: /\w+@\w+.\w+/}
  validates :password, length: { in: 4..20 }
end
