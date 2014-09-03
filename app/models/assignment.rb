class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text,     type: String
  field :due,      type: Date,    default: Date.tomorrow
  field :complete, type: Boolean, default: false

  validates :text, presence: true

  belongs_to :course
end
