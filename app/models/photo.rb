class Photo < ApplicationRecord
  has_one_attached :image
  enum status: [:draft,:published]
  belongs_to :user 

  def publish_photo
  	published_at = Time.now 
  	status = :published
  	save
  end
end
