
require 'rails_helper'

RSpec.describe Task, type: :model do
    describe 'CRUD operations' do
        it 'should be able to Create new task' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.create(name: 'Test Category', user: user)
            task = Task.new(
              name: 'Test Task',
              body: 'This is a test task description.',
              date: Date.today,
              user: user,
              category: category
            )
            
            expect(task.save).to eq(true)
        end


        it 'should be able to edit existing task' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.create(name: 'Test Category', user: user)
            task = Task.new(
              name: 'Test Task',
              body: 'This is a test task description.',
              date: Date.today,
              user: user,
              category: category
            )
            
            task.name = 'Test Task edited by John Doe'
            task.body = 'This is a test task description edited by John Doe'
            task.date = Date.tomorrow
            task.save

            expect(task.name).to eq('Test Task edited by John Doe')
            expect(task.body).to eq('This is a test task description edited by John Doe')
            expect(task.date).to eq(Date.tomorrow)
        end

        it 'should be able to edit existing task' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.create(name: 'Test Category', user: user)
            task = Task.new(
              name: 'Test Task',
              body: 'This is a test task description.',
              date: Date.today,
              user: user,
              category: category
            )
            
            task.name = 'Test Task edited by John Doe'
            task.body = 'This is a test task description edited by John Doe'
            task.date = Date.tomorrow
            task.save

            expect(task.name).to eq('Test Task edited by John Doe')
            expect(task.body).to eq('This is a test task description edited by John Doe')
            expect(task.date).to eq(Date.tomorrow)
        end

        it 'should be able to delete existing task' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.create(name: 'Test Category', user: user)
            task = Task.new(
              name: 'Test Task',
              body: 'This is a test task description.',
              date: Date.today,
              user: user,
              category: category
            )
            
            task.destroy

            expect(Task.exists?(task.id)).to be false
        end
    end


    describe 'validations' do
        it 'is valid with valid attributes' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.create(name: 'Test Category', user: user)
            task = Task.new(
              name: 'Test Task',
              body: 'This is a test task description.',
              date: Date.today,
              user: user,
              category: category
            )
            expect(task).to be_valid
          end


          it 'is not valid without a name' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.create(name: 'Test Category', user: user)
            task = Task.new(
              name: '',
              body: 'This is a test task description.',
              date: Date.today,
              user: user,
              category: category
            )
            expect(task).to_not be_valid
            expect(task.errors[:name]).to include('can\'t be blank')
        end

        it 'is not valid without a description' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.create(name: 'Test Category', user: user)
            task = Task.new(
              name: 'Task Test',
              body: '',
              date: Date.today,
              user: user,
              category: category
            )
            expect(task).to_not be_valid
            expect(task.errors[:body]).to include('can\'t be blank')
        end

        it 'is not valid without a date' do
            user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
            category = Category.create(name: 'Test Category', user: user)
            task = Task.new(
              name: 'Task Test',
              body: 'This is a test task description.',
              date: '',
              user: user,
              category: category
            )
            expect(task).to_not be_valid
            expect(task.errors[:date]).to include('can\'t be blank')
        end

      end


end
