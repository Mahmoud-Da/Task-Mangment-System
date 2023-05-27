class TasksController < ApplicationController
  before_action :logged_in_user, :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result.page(params[:page]).per(10).order(:id).not_completed
  end

  def show; end

  def new
    @task = Task.new
    @categories = Category.order(:name)
  end

  def edit
    @categories = Category.order(:name)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: t(:successfully_created)
    else
      flash.now[:notice] = t(:failer_to_create)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: t(:successfully_edited)
    else
      flash.now[:notice] = t(:failer_to_edit)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      redirect_to root_path, notice: t(:successfully_deleted)
    else
      flash.now[:notice] = t(:failer_to_delete)
      render :show, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :body, { category_ids: [] }, :limit, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
