class Note < ActiveRecord::Base
  attr_accessible :content, :title

  validates_presence_of :content, :title
  validates_length_of :content, :maximum => 50

  self.per_page = 3

  def self.search(keywords)
    where('lower(title) like :keywords OR lower(content) like :keywords', :keywords => "%#{keywords.downcase}%")
  end

  def as_json(opts={})
    { :title => self.title, :content => self.content }
  end
end
