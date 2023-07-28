class PagesController < ApplicationController
    before_action :authenticate_user!, except:  [:home]
    def home
    end

    def dashboard
        @user = current_user
        @selected_date = params[:selected_date] ? Date.parse(params[:selected_date]) : Date.current
        @tasks_by_category = current_user.tasks.where(date: @selected_date.beginning_of_day..@selected_date.end_of_day).group_by(&:category)
    end
end
