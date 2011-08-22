class Post < ActiveRecord::Base
  extend FriendlyId

  validates_presence_of :title, :content

  scope :published, where(:published => true)
  scope :draft, where(:published => false)

  friendly_id :title, :use => :slugged

  def publish!
    self.published = true
    self.published_at = Time.zone.now
  end

  def unpublish!
    self.published = false
    self.published_at = nil
  end

end
