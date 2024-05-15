module Api
  class TasksController < ApplicationController
    before_action :validate_user

    def show
      user = User.find_by(id: params[:api_key])
      @task = user.tasks.find_by(id: params[:id])

      if @task
        render 'show', status: :ok
      else
        render 'not_found', status: :not_found
      end
    end

    def index
      user = User.find_by(id: params[:api_key])
      @tasks = user.tasks.all
      render 'index', status: :ok
    end

    def create
      user = User.find_by(id: params[:api_key])
      @task = user.tasks.new(task_params)

      if @task.save
        render 'show', status: :ok
      else
        render 'bad_request', status: :bad_request
      end
    end

    def destroy
      user = User.find_by(id: params[:api_key])
      @task = user.tasks.find_by(id: params[:id])

      if @task
        @task.destroy
        render json: { success: true }, status: :ok
      else
        render 'not_found', status: :not_found
      end
    end

    def update
      user = User.find_by(id: params[:api_key])
      @task = user.tasks.find_by(id: params[:id])

      if @task && @task.update(task_params)
        render 'show', status: :ok
      else
        render 'bad_request', status: :bad_request
      end
    end

    def mark_complete
      user = User.find_by(id: params[:api_key])
      @task = user.tasks.find_by(id: params[:id])

      if @task && @task.update(completed: true)
        render 'show', status: :ok
      else
        render 'bad_request', status: :bad_request
      end
    end

    def mark_active
      user = User.find_by(id: params[:api_key])
      @task = user.tasks.find_by(id: params[:id])

      if @task && @task.update(completed: false)
        render 'show', status: :ok
      else
        render 'bad_request', status: :bad_request
      end
    end

  private

    def task_params
      params.require(:task).permit(:content, :due)
    end

    def validate_user
      @user = User.find_by(id: params[:api_key])
      unless @user
        render json: {
          status: '401',
          title: 'Unauthorized User',
          detail: 'User is not found.'
        }, status: :unauthorized
      end
    end
  end
end
