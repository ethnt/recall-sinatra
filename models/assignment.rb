class Assignment
  include Mongoid::Document

  field :text, type: String

  validates_presence_of :text

  belongs_to :course
end
