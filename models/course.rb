class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  validates_presence_of :name

  belongs_to :user

  has_many :assignments
end
