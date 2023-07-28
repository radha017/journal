class CategoriesController < ApplicationController
    before_action :set_category, only: %i[ show edit update destroy ]
    before_action :authenticate_user!

    def index
        @categories = current_user.categories
    end

    def new
        @category = Category.new
    end

    def create
        @category = current_user.categories.build(category_params)
        
        if @category.save
            redirect_to dashboard_path
            flash[:success] = "Category created!"
        else
            render :new, status: 422
        end
    end

    def show
        @category = Category.find(params[:id])
        @tasks = @category.tasks
    end
  
    
    def edit
            @category = Category.find(params[:id])
    end

    def destroy
            @category = Category.find(params[:id])
            @category.destroy
            redirect_to dashboard_path
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            redirect_to categories_path
         else
            render :edit, status: 422
         end

    end

    private

    def category_params
        params.require(:category).permit(:name)
    end

    def set_category
        @category = Category.find(params[:id])
      end
        
end
