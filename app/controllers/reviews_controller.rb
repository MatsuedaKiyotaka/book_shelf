class ReviewsController < ApplicationController
  before_action :set_book, only: [:show, :new]
  before_action :set_review, only: :show
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.attributes = {
      book_id: params[:book_id],
      user_id: current_user.id
    }
    if @review.save
      redirect_to @review.book, notice: "レビューを登録しました。"
    else
      render :new
    end
  end

  def show
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :evaluation)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
