class Note < ActiveRecord::Base
  attr_accessible :content, :title

  def self.search(keywords)
    where('lower(title) like :keywords OR lower(content) like :keywords', :keywords => "%#{keywords.downcase}%")
  end
end
