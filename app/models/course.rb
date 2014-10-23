class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,   type: String
  field :code,   type: String
  field :hidden, type: Boolean, default: false

  validates :name, presence: true

  belongs_to :user

  has_many :assignments, dependent: :destroy

  def creatable_by?(u)
    self.user == u || u.admin?
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
