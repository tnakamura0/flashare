class DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to deck_path(@deck), notice: t("defaults.flash_message.created", item: Deck.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Deck.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @deck = current_user.decks.find(params[:id])
  end

  def edit
    @deck = current_user.decks.find(params[:id])
  end

  def update
    @deck = current_user.decks.find(params[:id])
    if @deck.update(deck_params)
      redirect_to deck_path(@deck), notice: t("defaults.flash_message.updated", item: Deck.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Card.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    deck = current_user.decks.find(params[:id])
    deck.destroy!
    redirect_to decks_path, status: :see_other, notice: t("defaults.flash_message.deleted", item: Deck.model_name.human)
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :description, :public)
  end
end
