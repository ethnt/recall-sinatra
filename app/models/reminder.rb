class Reminder
  include Mongoid::Document

  field :time, type: Time

  validates :time, presence: true

  belongs_to :assignment

  def email
    self.assignment.course.user.email
  end
end
