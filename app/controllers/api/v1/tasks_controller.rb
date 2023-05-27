module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :edit, :update, :destroy]
      # 動作確認用にCSRFを無効化しています
      skip_before_action :verify_authenticity_token

      # GET /api/v1/task
      def index
        render json: Task.all
      end

      # GET /api/v1/task/1
      def show
        render json: taskResource.new(task.find(params[:id]))
      end

      def edit
        @categories = Category.order(:name)
        render json: @task, include: :categories
      end

      # POST /api/v1/task
      def create
        @task = Task.new(task_params)
        if @task.save
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/task/1
      def update
        if @task.update(task_params)
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/task/1
      def destroy
        @task.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_task
        @task = Task.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def task_params
        params.require(:task).permit(:title, :body, { category_ids: [] }, :limit, :status, :priority)
      end
    end
  end
end
