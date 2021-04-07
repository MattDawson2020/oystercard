class Oystercard 
  attr_reader :balance
  ::MAX_BALANCE = 90
  ::MIN_BALANCE = 1

  def initialize
    @balance = 20
    @journey = false
  end

  def top_up(amount)
    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if max_balance
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @journey
  end

  def touch_in
    raise "You don't have enough funds" if min_balance

    @journey = true
  end

  def touch_out
    @journey = false
  end

  private 

  def min_balance
    @balance < MIN_BALANCE
  end

  def max_balance
    @balance > MAX_BALANCE
  end
end