module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: [:show, :edit, :update, :destroy]
      # 動作確認用にCSRFを無効化しています
      skip_before_action :verify_authenticity_token

      # GET /api/v1/category
      def index
        render json: Category.all
      end

      # GET /api/v1/category/1
      def show
        render json: categoryResource.new(category.find(params[:id]))
      end

      def edit
        @categories = Category.order(:name)
      end

      # POST /api/v1/category
      def create
        @category = category.new(category_params)
        if @category.save
          render json: @category
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/category/1
      def update
        if @category.update(category_params)
          render json: @category
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/category/1
      def destroy
        @category.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def category_params
        params.require(:category).permit(:name)
      end

      def set_category
        @category = Category.find(params[:id])
      end
    end
  end
end
