class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text,     type: String
  field :due,      type: Date,    default: Date.tomorrow
  field :complete, type: Boolean, default: false
  field :notes,    type: String

  validates :text, presence: true

  belongs_to :course

  has_many :reminders
end
