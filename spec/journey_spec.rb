require 'journey'

describe Journey do
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
  let(:subject) { Journey.new }
  before do
    subject.start(entry_station)
  end

  it 'can start a journey' do
    expect(subject.entry_station).to equal(entry_station)
  end

  it 'can end a journey' do
    subject.end(exit_station)
    expect(subject.exit_station).to equal(exit_station)
  end

  context '#fare' do

    it 'can respond to fare' do
      expect(subject).to respond_to(:fare)
    end

    it 'can return minimum fare' do
      subject.end(exit_station)
      expect(subject.fare).to eq(1)
    end

    it 'can return penalty fare on touch_out while not touched in' do 
      empty_journey = described_class.new 
      expect(empty_journey.fare).to eq(6)
    end

    it 'can return penalty fare on touch_in while not touched out' do 
      expect(subject.fare).to eq(6)
    end
  end
end