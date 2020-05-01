class ReviewsController < ApplicationController
    before_action :authenticate_user! 
    before_action :find_review, only: [:destroy, :toggle_hidden]
    before_action :authorize!, only: [:edit, :update, :destroy]
    before_action :authorize_toggle!, only: [:toggle_hidden]

    def create 
        @product = Product.find(params[:product_id])
        @review = Review.new review_params
        @review.product = @product 
        @review.user = @current_user
        if @review.save 
            # redirect_to product_path(@product) # or you can use the below short-hand
            redirect_to @product
        else 
            if can? :manage, @product
                @reviews = @product.reviews.order(created_at: :desc)
            else 
                @reviews = @product.reviews.where(hidden: false).order(created_at: :desc)
            end
            render 'products/show'
        end
    end

    def destroy
        @review.destroy 
        redirect_to @review.product
    end

    def toggle_hidden 
        # update the boolean field 'hidden' to whatever it isn't currently 
        @review.update(hidden: !@review.hidden?)
        redirect_to product_path(@review.product), notice: "Review #{@review.hidden ? 'hidden' : 'shown'}"
    end

    private 

    def review_params 
        params.require(:review).permit(:rating, :body)
    end

    def find_review 
        @review = Review.find params[:id]
    end

    def authorize! 
        redirect_to root_path, alert: "Access denied" unless can? :manage, @review 
    end

    def authorize_toggle! 
        redirect_to root_path, alert: "Access denied" unless can? :manage, @review.product 
    end 
end
