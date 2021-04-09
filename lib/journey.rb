# require_relative 'station'
require_relative 'oystercard'

class Journey
  attr_reader :entry_station, :exit_station

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare 
    incomplete_journey? ? PENALTY_FARE : MIN_FARE
  end

  def incomplete_journey?
    !(@entry_station && @exit_station) 
  end

  private 

  
end