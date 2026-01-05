class DeckCardsController < ApplicationController
  before_action :set_deck

  def index
    @cards = current_user.cards.where.not(id: @deck.card_ids)
  end

  def create
    @card = Card.find(params[:card_id])
    @deck.cards << @card

    redirect_to deck_deck_cards_path(@deck), notice: t("defaults.flash_message.added", item: Card.model_name.human)
  end

  def destroy
    @deck_card = @deck.deck_cards.find(params[:id])
    @deck_card.destroy!
    redirect_to deck_path(@deck), status: :see_other, notice: t("defaults.flash_message.delete_from_deck")
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end
end
