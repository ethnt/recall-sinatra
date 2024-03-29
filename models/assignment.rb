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
    est = ActiveSupport::TimeZone.new('Eastern Time (US & Canada)')

    today = DateTime.now.in_time_zone(est)
    today = Date.new(today.year, today.month, today.day)

    words = distance_of_time_in_words(today, self.due, only: [:days])

    week = today..(today + 7)

    if !words.include?('day')
      return 'today'
    elsif words == '1 day'
      if self.due > today
        return 'tomorrow'
      else
        return 'yesterday'
      end
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
