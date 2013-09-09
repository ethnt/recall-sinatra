class Assignment
  include Mongoid::Document

  field :text,     type: String
  field :complete, type: Boolean, default: false

  validates_presence_of :text

  belongs_to :course

  def viewable_by?(u)
    self.course.user == u
  end

  def updatable_by?(u)
    self.viewable_by?(u)
  end

  def destroyable_by?(u)
    self.viewable_by?(u)
  end
end
