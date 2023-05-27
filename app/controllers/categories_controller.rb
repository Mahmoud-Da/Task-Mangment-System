class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  def index
    @categories = Category.all.page(params[:page]).per(5).order(:id)
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit
    @categories = Category.order(:name)
  end

  def search
    # categoryのnameを曖昧検索
    @categories = Category.where('categories.name LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
    # フォームに入力した内容を取ってくる
    @search_result = params[:search].to_s
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: t(:successfully_created)
    else
      flash.now[:notice] = t(:failer_to_create)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: t(:successfully_edited)
    else
      flash.now[:notice] = t(:failer_to_edit)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: t(:successfully_deleted)
    else
      flash.now[:notice] = t(:failer_to_delete)
      render :index, status: :unprocessable_entity
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
