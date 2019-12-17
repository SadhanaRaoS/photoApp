require 'rails_helper'

RSpec.describe Photo, type: :model do
  let!(:image_file) { File.open(Rails.root.join('spec/fixtures','dummy.jpg')) }
  describe '#validations' do 
  	let(:user) { User.create(username: 'test',password: 'test')}
  	subject {Photo.new }
  	it 'is valid with valid attributes' do 
  		photo = Photo.new(user: user)
  		photo.image.attach(io: image_file, filename: 'attachment.jpg', content_type: 'image/jpg')
  		expect(photo).to be_valid
  	end

  	it 'is not valid without a user' do 
  		expect(subject).to_not be_valid
  	end
  end

  describe '#attachment' do 
  	it 'should check for attachment' do 
	  	subject.image.attach(io: image_file,
	  						 filename: 'attachment.jpg', content_type: 'image/jpg')
		expect(subject.image).to be_attached
	end
  end


end
