class PublicDecksController < ApplicationController
  def index
    other_person_decks = Deck.where.not(user_id: session[:user_id])
    @public_decks = other_person_decks.where(public: true)
  end
end
