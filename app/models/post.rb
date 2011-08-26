class Post < ActiveRecord::Base
  extend FriendlyId

  validates_presence_of :title, :content
  belongs_to :user

  before_save :set_published_date

  scope :published, where(:published => true)
  scope :draft, where(:published => false)

  friendly_id :title, :use => :slugged

  def set_published_date
    self.published_at = Time.zone.now if self.published? && self.published_at.blank?
  end

  def publish!
    self.published = true
    self.published_at = Time.zone.now
    self.save
  end

  def unpublish!
    self.published = false
    self.published_at = nil
    self.save
  end

end
