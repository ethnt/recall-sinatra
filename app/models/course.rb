class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,   type: String
  field :code,   type: String
  field :hidden, type: Boolean, default: false

  validates :name, presence: true

  belongs_to :user

  has_many :assignments
end
