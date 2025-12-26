class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    card = current_user.cards.build(card_params)
    if card.save
      redirect_to cards_path, notice: t("defaults.flash_message.created", item: Card.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Card.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  private

  def card_params
    params.require(:card).permit(:name, :meaning)
  end
end
