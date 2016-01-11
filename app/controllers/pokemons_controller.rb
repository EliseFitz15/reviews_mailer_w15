class PokemonsController < ApplicationController
before_action :authenticate_user!

  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @reviews = @pokemon.reviews
    @review = Review.new
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    
    if @pokemon.save
      flash[:notice] = "Pokemon successfully added!"
      redirect_to pokemons_path
    else
      flash[:errors] = @pokemon.errors.full_messages.join(". ")
      render :new
    end
  end

  private
  def pokemon_params
    params.require(:pokemon).permit(:name, :ability, :poketype, :strength, :age, :user_id)
  end
end
