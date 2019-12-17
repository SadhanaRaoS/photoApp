require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do 

  	it 'is valid with valid attributes' do 
  		expect(User.new(username: 'testname', password: 'testpassword')).to be_valid
  	end

  	it 'is not valid without username' do 
  		expect(User.new(password: 'test')).to_not be_valid
  	end

  	it 'is not valid without password' do 
  		expect(User.new(username: 'test')).to_not be_valid
  	end

  	it 'should have unique users' do 
  		user1 = User.create(username: 'test',password: 'test')
  		user2 = User.new(username: 'test',password: 'test2')
  		expect(user2).to_not be_valid
  	end
  end
end
