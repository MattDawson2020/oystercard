require_relative 'journey'

class Oystercard 
  attr_reader :balance, :journies
  ::MAX_BALANCE = 90
  ::MIN_BALANCE = 1
  ::MIN_FARE = 1
  ::PENALTY_FARE = 6

  def initialize(journey: Journey.new)
    @balance = 20
    @journies = []
    @journey = journey
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
    add_journey(entry_station)
    # need deduct on incorrect touch_in
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

  def add_journey(entry_station)
    @journey.start(entry_station)
    @journies << @journey
  end
end

