
require 'rails_helper'

RSpec.describe Category, type: :model do
    describe 'associations' do
        it 'belongs to a user' do
          # Create a User and Category instance
          user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
          category = Category.new(name: 'Test Category', user: user)
    
          # Check if the category is associated with the user
          expect(category.user).to eq(user)
        end
      end

      describe 'validations' do
        it 'is valid with valid attributes' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.new(name: 'Test Category', user: user)
            expect(category).to be_valid
        end

        it 'is not valid without a name' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.new(name: nil, user: user)
            expect(category).to_not be_valid
            expect(category.errors[:name]).to include('can\'t be blank')
        end
    end

 


end
