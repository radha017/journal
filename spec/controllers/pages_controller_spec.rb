# spec/controllers/pages_controller_spec.rb
RSpec.describe PagesController, type: :controller do
    let(:user) { create_user }
  
    def create_user
      User.create(email: "user@example.com", password: "password123")
    end
  
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end
  
    describe "GET #home" do
      it "returns a success response" do
        get :home
        expect(response).to be_successful
      end
    end
  
    describe "GET #dashboard" do
      it "returns a success response" do
        get :dashboard
        expect(response).to be_successful
      end
  
      it "assigns the user" do
        get :dashboard
        expect(assigns(:user)).to eq(user)
      end
  
      it "assigns the selected date as Date.current when no date is provided" do
        get :dashboard
        expect(assigns(:selected_date)).to eq(Date.current)
      end
  
      it "assigns the selected date when a date is provided in params" do
        selected_date = Date.current - 1.day
        get :dashboard, params: { selected_date: selected_date }
        expect(assigns(:selected_date)).to eq(selected_date)
      end
  
      it "assigns tasks grouped by category for the selected date" do
        category = Category.create(name: "Test Category", user: user)
        task1 = Task.create(name: "Task 1", body: "Task 1 details", date: Date.current, category: category, user: user)
        task2 = Task.create(name: "Task 2", body: "Task 2 details", date: Date.current, category: category, user: user)
  
        get :dashboard
        expect(assigns(:tasks_by_category)).to eq({ category => [task1, task2] })
      end
  
      it "does not include tasks from other dates in the tasks_by_category" do
        category = Category.create(name: "Test Category", user: user)
        task1 = Task.create(name: "Task 1", body: "Task 1 details", date: Date.current, category: category, user: user)
        task2 = Task.create(name: "Task 2", body: "Task 2 details", date: Date.tomorrow, category: category, user: user)
  
        get :dashboard
        expect(assigns(:tasks_by_category)).to eq({ category => [task1] })
      end
    end
  end
  