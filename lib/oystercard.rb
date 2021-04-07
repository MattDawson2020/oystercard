class Oystercard 
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 20
    @journey = false
  end

  def top_up(amount)
    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance > MAX_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @journey
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end
end