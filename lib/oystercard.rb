require 'journey'

class Oystercard 
  attr_reader :balance, :journies
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
    !(@journies[-1].nil? || !@journies[-1].exit_station.nil?)
  end

  def touch_in(entry_station)
    raise "You don't have enough funds" if min_balance
    journey = Journey.new
    journey.start(entry_station)
    @journies << journey
    #there is no condition for multiple touch ins charging
  end

  def touch_out(exit_station)
    @journies[-1].end(exit_station)
    deduct(@journies[-1].fare)
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

