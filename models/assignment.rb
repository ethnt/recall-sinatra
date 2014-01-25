class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps
  include ::Padrino::Helpers::FormatHelpers

  field :text,     type: String
  field :due,      type: Date,    default: Date.tomorrow
  field :complete, type: Boolean, default: false

  validates_presence_of :text

  belongs_to :user
  belongs_to :course

  def due_in_words
    words = distance_of_time_in_words(Date.today, self.due, only: [:days])

    week = Date.today..(Date.today + 7)

    if !words.include?('day')
      return 'today'
    elsif words == '1 day'
      return 'tomorrow'
    elsif week.include?(self.due)
      self.due.strftime('%A')
    else
      self.due.strftime('%A, %B %d, %Y')
    end
  end

  def render
    Quesadilla.extract(self.text,
      markdown_links: true,
      markdown_emphasis: true,
      markdown_double_emphasis: true,
      autolinks: true
    )
  end

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
