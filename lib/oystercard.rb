class Oystercard 
  attr_reader :balance, :entry_station
  ::MAX_BALANCE = 90
  ::MIN_BALANCE = 1
  ::MIN_FARE = 1

  def initialize
    @balance = 20
  end

  def top_up(amount)
    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if max_balance
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def touch_in(entry_station)
    raise "You don't have enough funds" if min_balance
    @entry_station = entry_station 
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  private 

  def min_balance
    @balance < MIN_BALANCE
  end

  def max_balance
    @balance > MAX_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end