class Deck
  attr_accessor :deck

  @@suits = [:diamonds, :clubs, :hearts, :spades]

  def initialize
    @deck = make_deck
  end

  def shuffle!
    deck.shuffle!
  end

  def draw_card
    card = deck.shift
  end

  private

  def make_deck
    deck = []
    @@suits.each do |suit|
      (2..14).each do |val|
        deck << Card.new(val,suit)
      end
    end
    deck
  end

end
