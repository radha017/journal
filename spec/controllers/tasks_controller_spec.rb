# spec/controllers/tasks_controller_spec.rb
RSpec.describe TasksController, type: :controller do
  let(:user) { create_user }
  let(:category) { create_category }
  let(:valid_attributes) { { task: { name: "Test Task", body: "Task details", date: Date.today, category_id: category.id } } }
  let(:invalid_attributes) { { task: { name: nil, body: "Task details", date: Date.today, category_id: category.id } } }

  def create_user
    User.create(email: "user@example.com", password: "password123")
  end

  def create_category
    Category.create(name: "Test Category", user: user)
  end

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(assigns(:tasks)).to eq(user.tasks)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
      expect(assigns(:task)).to be_a_new(Task)
      expect(assigns(:categories)).to eq(user.categories)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new task" do
        expect {
          post :create, params: valid_attributes
        }.to change(Task, :count).by(1)

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:success]).to eq("Task created!")
      end
    end

    context "with invalid parameters" do
      it "does not create a new task" do
        expect {
          post :create, params: invalid_attributes
        }.to_not change(Task, :count)

        expect(response).to have_http_status(422)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    let(:task) { Task.create(name: "Test Task", body: "Task details", date: Date.today, category: category, user: user) }

    it "returns a success response" do
      get :show, params: { id: task.id }
      expect(response).to be_successful
      expect(assigns(:task)).to eq(task)
      expect(assigns(:tasks)).to eq(user.tasks)
    end
  end

  describe "GET #edit" do
    let(:task) { Task.create(name: "Test Task", body: "Task details", date: Date.today, category: category, user: user) }

    it "returns a success response" do
      get :edit, params: { id: task.id }
      expect(response).to be_successful
      expect(assigns(:task)).to eq(task)
      expect(assigns(:categories)).to eq(user.categories)
    end
  end

  describe "PATCH #update" do
    let(:task) { Task.create(name: "Test Task", body: "Task details", date: Date.today, category: category, user: user) }

    context "with valid parameters" do
      let(:new_name) { "Updated Task Name" }
      let(:valid_attributes) { { id: task.id, task: { name: new_name } } }

      it "updates the task" do
        patch :update, params: valid_attributes
        expect(response).to redirect_to(dashboard_path)
        expect(task.reload.name).to eq(new_name)
        expect(flash[:success]).to eq("Task updated!")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { id: task.id, task: { name: nil } } }

      it "does not update the task" do
        patch :update, params: invalid_attributes
        expect(response).to have_http_status(422)
        expect(response).to render_template(:edit)
        expect(task.reload.name).not_to be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    let(:task) { Task.create(name: "Test Task", body: "Task details", date: Date.today, category: category, user: user) }

    it "destroys the task" do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(dashboard_path)
      expect(Task.exists?(task.id)).to be_falsey
    end
  end
end
