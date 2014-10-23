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

  def creatable_by?(u)
    self.course.user == u || u.admin?
  end

  def viewable_by?(u)
    self.creatable_by?(u)
  end

  def updatable_by?(u)
    self.creatable_by?(u)
  end

  def destroyable_by?(u)
    self.creatable_by?(u)
  end
end
