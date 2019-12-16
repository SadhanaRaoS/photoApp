require 'mini_magick'
class Photo < ApplicationRecord
  has_one_attached :image
  enum status: [:draft,:published]
  belongs_to :user 
  validate :image_validation
  # validate :image_dimensions

  MAX_IMAGE_HEIGHT=200
  MAX_IMAGE_WIDTH=200

  def image_validation
  	if image.attached?
      if image.blob.byte_size > 2000000
        errors[:base] << 'Allowed size is 2MB'
      end
      if !image.blob.content_type.starts_with?('image/')
        errors[:base] << 'Format not allowed'
      end
    end
  end

  def publish_photo
  	published_at = Time.now 
  	status = :published
  	save
  end

 #  def image_dimensions 
 #  	if image.attached?
	#   	org_image= MiniMagick::Image.open(image.path)
	# 	if org_image.height > MAX_IMAGE_HEIGHT  ||
	# 	  org_image.width >MAX_IMAGE_WIDTH
	# 	  errors[:base] << 'Exceeds allowed dimensions'
	# 	  clean_file_path(org_image.path)
	# 	end
	# end
 #  end


  private 

  def clean_image_from_path(path)
  	File.delete(path)
  end

end
