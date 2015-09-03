require "card"
require "rspec"


describe Card do
  subject(:card) {Card.new(7, :spades)}

  describe "::initialize" do
    it "instantiates a value and suit for the card" do
      expect(card.suit).to eq(:spades)
      expect(card.value).to eq(7)
    end
  end

end
