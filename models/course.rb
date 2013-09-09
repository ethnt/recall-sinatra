class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  include Canable::Ables

  field :name, type: String

  validates_presence_of :name

  belongs_to :user

  has_many :assignments

  def viewable_by?(u)
    self.user == u
  end

  def updatable_by?(u)
    self.viewable_by?(u)
  end

  def destroyable_by?(u)
    self.viewable_by?(u)
  end
end
