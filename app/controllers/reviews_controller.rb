class ReviewsController < ApplicationController

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @review = Review.new(review_params)
    @review.pokemon = @pokemon
    @review.user = current_user

    if @review.save
      flash[:notice] = "Review added"
      redirect_to pokemon_path(@pokemon)
    else
      flash[:errors] = @review.errors.full_messages.join(". ")
      render "pokemons/show"
    end
  end

  private
  def review_params
    params.require(:review).permit(:body, :rating, :user_id, :pokemon_id)
  end
end
