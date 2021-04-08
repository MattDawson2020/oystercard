class Oystercard 
  attr_reader :balance, :entry_station, :exit_station, :journies
  ::MAX_BALANCE = 90
  ::MIN_BALANCE = 1
  ::MIN_FARE = 1

  def initialize
    @balance = 20
    @journies = []
  end

  def top_up(amount)
    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if max_balance
  end

  def in_journey?
    @journies[-1].size == 1 
  end

  def touch_in(entry_station)
    raise "You don't have enough funds" if min_balance
    journey = { entry_station: entry_station}
    @journies << journey
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journies[-1][:exit_station]= exit_station
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

