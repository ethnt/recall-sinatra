class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  include Canable::Ables

  field :name, type: String
  field :code, type: String

  validates_presence_of :name

  belongs_to :user

  has_many :assignments

  def self.as_options(u)
    courses = where(user_id: u.id).all

    arr = []
    courses.each do |c|
      arr << [c.name, c.id]
    end

    return arr
  end

  def pending
    self.assignments.where(complete: false).count
  end

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
