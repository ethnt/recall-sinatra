class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :admin, type: Boolean, default: false

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable#, :omniauthable, omniauth_providers: [ :google_oauth2, :twitter ]

  field :encrypted_password, type: String, default: ''

  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  field :remember_created_at, type: Time

  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  # field :provider, type: String
  # field :uid,      type: String

  has_many :courses
end
