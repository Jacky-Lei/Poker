require "byebug"

class Hand

  attr_accessor :cards, :rank

  def initialize(cards)
    @cards = cards
    @suits = get_suits
    @values = get_values
    @values_hash = get_values_hash

    @rank = get_rank
  end

  def >(hand)
    self.rank > hand.rank
  end

  def <(hand)
    self.rank < hand.rank
  end

  def ==(hand)
    self.rank == hand.rank
  end

  def get_values_hash
    values_hash = Hash.new { |h,k| h[k] = 0 }
    @values.each do |val|
      values_hash[val] += 1
    end
    values_hash
  end

  def get_suits
    @cards.map do |card|
      card.suit
    end
  end

  def get_values
    @cards.map do |card|
      card.value
    end
  end

  def discard_cards(card_array)
    card_array.each do |card|
      @cards.delete(card)
    end
  end

  def add_cards(card_array)
    @cards + card_array
  end


  def get_rank
    if is_straight_flush?
      @rank = 8
    elsif is_four_of_a_kind?
      @rank = 7
    elsif is_full_house?
      @rank = 6
    elsif is_flush?
      @rank = 5
    elsif is_straight?
      @rank = 4
    elsif is_three_of_a_kind?
      @rank = 3
    elsif is_two_pair?
      @rank = 2
    elsif is_one_pair?
      @rank = 1
    else
      @rank = 0
    end
  end



  def is_straight?
    sorted_values = @values.sort
    return false if sorted_values.uniq.length != 5
    
    sorted_values.each_index do |i|
      break if sorted_values[i] == sorted_values.last
      return false if (sorted_values[i] != sorted_values[i+1] - 1)
    end
    true
  end

  def is_flush?
    @suits.uniq.length == 1
  end

  def is_straight_flush?
    is_straight? && is_flush?
  end

  def is_four_of_a_kind?
    @values.any? { |val| @values.count(val) == 4 }
  end

  def is_full_house?
    @values.any? { |val| @values.count(val) == 2 } && @values.any? { |val| @values.count(val) == 3 }
  end

  def is_three_of_a_kind?
    @values.any? { |val| @values.count(val) == 3 } && ! is_full_house?
  end

  def is_two_pair?
    @values_hash.select { |k,v| v == 2 }.length == 2
  end

  def is_one_pair?
    @values_hash.select { |k,v| v == 2 }.length == 1 && !is_full_house?
  end

  def high_card
    highest_card = @cards.first
    higest_val = high_card.value
    @cards.each do |card|
      if card.value > highest_card.value
        highest_card = card
        highest_value = card.value
      end
    end
  end
end

# if __FILE__ == $PROGRAM_NAME
#   load './card.rb'
#   load './deck.rb'
#
#   deck1 = Deck.new
#   cards1 = deck1.deck.sample(5)
#   cards2 = deck1.deck.sample(5)
#
#   hand1 = Hand.new(cards1)
#   hand2 = Hand.new(cards2)
#   puts hand1.rank
#   puts hand2.rank
#
#   puts hand1 > hand2
#   puts hand1 == hand2
#   puts hand1 < hand2
# end
