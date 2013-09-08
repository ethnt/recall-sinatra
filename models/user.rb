require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  attr_accessor :password

  field :email,   type: String
  field :crypted, type: String

  validates_presence_of :email

  before_save :encrypt_password!

  has_many :courses

  def self.authenticate(e, p)
    u = User.where(email: e).first
    u && Password.new(u.crypted) == p ? u : nil
  end

  private

  def encrypt_password!
    self.crypted = Password.create(@password)
  end
end
