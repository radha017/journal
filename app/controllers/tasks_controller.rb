class TasksController < ApplicationController
    before_action :authenticate_user!

    def index
        @tasks = current_user.tasks
    end

    def new
        @task = Task.new
        @categories = current_user.categories
    end

    def create
            @task = current_user.tasks.build(task_params)
            if @task.save
                redirect_to dashboard_path
                flash[:success] = "Task created!"
            else
                render :new, status: 422
            end
        end

    def show
        @task = Task.find(params[:id])
        @tasks = current_user.tasks
    end
 
    def edit
        @task = Task.find(params[:id])
        @categories = current_user.categories
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            redirect_to dashboard_path
            flash[:success] = "Task updated!"
        else
            render :edit, status: 422
        end

    end
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to dashboard_path
    end

    private

    def task_params
        params.require(:task).permit(:name, :body, :date, :user_id, :category_id)
    end
end
