class AddStatusAndPublishedAtInPhoto < ActiveRecord::Migration[6.0]
  def change
  	add_column :photos , :status, :integer, default: 0  
  	add_column :photos , :published_at, :datetime
  end
end
