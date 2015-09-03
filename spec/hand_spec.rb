require "hand"
require "rspec"

describe Hand do

  describe "::initialize" do
    let(:cards) { Array.new(5) { Card.new(2,:spades) } }
    let(:ex_hand) { Hand.new(cards) }

    it "sets up a hand of 5 cards" do
      expect(ex_hand.cards.length).to eq(5)
      expect(ex_hand.cards.all? {|card| card.is_a?(Card)}).to be_truthy
    end
  end

  let!(:cards) do
    cards = []
    (2..6).each { |i| cards << Card.new(i,:spades)}
    cards
  end
  let(:ex_hand) { Hand.new(cards) }

  describe "#discard_cards" do
    it "discards the cards from a hand" do
      ex_hand.discard_cards(cards.take(3))
      expect(ex_hand.cards.length).to eq(2)
    end
  end

  describe "#add_cards" do
    it "adds the same number of cards that were discarded" do
      ex_hand.add_cards(cards.take(3))
      expect(ex_hand.cards.length).to eq(5)
    end
  end

  describe "Rank comparisons" do
    cards1 = ((2..6)).map { |i| Card.new(i,:hearts) }
    cards2 = (7..9).map { |i| Card.new(i,:hearts) } + [Card.new(10,:spades), Card.new(10,:clubs)]
    let!(:our_hand) { Hand.new(cards1) }
    let!(:opp_hand) { Hand.new(cards2) }

    describe "#rank" do
      it "returns correct rank" do
        expect(our_hand.rank).to eq(8)
      end
    end

    describe "#rank" do
      it "returns correct rank" do
        expect(opp_hand.rank).to eq(1)
      end
    end

    describe "#>" do
      it "returns true if oppoent's hand is a worse hand" do
        expect(our_hand > opp_hand).to be true
      end
    end

    describe "#==" do
      it "returns false if hands are not equal" do
        expect(our_hand== opp_hand).to be false
      end
    end

    describe "#<" do
      it "returns false if self is a better hand" do
        expect(our_hand < opp_hand).to be false
      end
    end
  end


end
