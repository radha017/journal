# spec/controllers/categories_controller_spec.rb
RSpec.describe CategoriesController, type: :controller do
  let(:user) { create_user }
  let(:valid_attributes) { { category: { name: "Test Category" } } }
  let(:invalid_attributes) { { category: { name: nil } } }

  def create_user
    User.create(email: "user@example.com", password: "password123")
  end

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(assigns(:categories)).to eq(user.categories)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new category" do
        expect {
          post :create, params: valid_attributes
        }.to change(Category, :count).by(1)

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:success]).to eq("Category created!")
      end
    end

    context "with invalid parameters" do
      it "does not create a new category" do
        expect {
          post :create, params: invalid_attributes
        }.to_not change(Category, :count)

        expect(response).to have_http_status(422)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    let(:category) { Category.create(name: "Test Category", user: user) }

    it "returns a success response" do
      get :show, params: { id: category.id }
      expect(response).to be_successful
      expect(assigns(:category)).to eq(category)
      expect(assigns(:tasks)).to eq(category.tasks)
    end
  end

  describe "GET #edit" do
    let(:category) { Category.create(name: "Test Category", user: user) }

    it "returns a success response" do
      get :edit, params: { id: category.id }
      expect(response).to be_successful
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "PATCH #update" do
    let(:category) { Category.create(name: "Test Category", user: user) }

    context "with valid parameters" do
      let(:new_name) { "Updated Category Name" }
      let(:valid_attributes) { { id: category.id, category: { name: new_name } } }

      it "updates the category" do
        patch :update, params: valid_attributes
        expect(response).to redirect_to(categories_path)
        expect(category.reload.name).to eq(new_name)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { id: category.id, category: { name: nil } } }

      it "does not update the category" do
        patch :update, params: invalid_attributes
        expect(response).to have_http_status(422)
        expect(response).to render_template(:edit)
        expect(category.reload.name).not_to be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    let(:category) { Category.create(name: "Test Category", user: user) }

    it "destroys the category" do
      delete :destroy, params: { id: category.id }
      expect(response).to redirect_to(dashboard_path)
      expect(Category.exists?(category.id)).to be_falsey
    end
  end
end
