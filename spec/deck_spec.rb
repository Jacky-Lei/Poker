require "deck"
require "rspec"


describe Deck do
  subject(:first_deck) { Deck.new }

  describe "::initialize" do
    it "instantiates a deck with 52 cards" do
      expect(first_deck.deck.length).to eq(52)
    end
  end

  describe "#shuffle!" do
    it "shuffles the deck in a random order" do
      unshuffled_deck = first_deck.deck.dup
      expect(first_deck.shuffle!).to_not eq(unshuffled_deck)
    end
  end

  describe "#draw_card" do
    let!(:first_card) { first_deck.deck.first }
    it "removes one card from the deck, returns chosen card" do

      expect(first_deck.draw_card).to eq(first_card)
    end

    it "reduces the size of the deck" do
      first_deck.draw_card
      expect(first_deck.deck.length).to eq(51)
    end
  end

end
