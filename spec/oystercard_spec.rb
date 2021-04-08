require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

  context '#balance' do
    it 'responds to balance' do
      expect(subject).to respond_to(:balance)
    end
  
    it 'has a balance' do
      expect(subject.balance).to eq(20)
    end

    it 'raises an error if balance exceeds £90' do
      max_bal = ::MAX_BALANCE
      expect { subject.top_up(max_bal) }.to raise_error { "Maximum balance of #{max_bal} exceeded" }
    end
  end
  
  context '#top_up' do
    it 'responds to top up' do
      expect(subject).to respond_to(:top_up)
    end
  
    it 'top_up takes arguments' do
      expect(subject).to respond_to(:top_up).with(1).arguments
    end
  
    it 'tops up the card' do
      expect { subject.top_up 5 }.to change{ subject.balance }.by 5
    end
  end

  context "#touch_in" do
    
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'can respond to journies' do
      expect(subject).to respond_to(:journies)
    end

    it 'journey storage defaults to empty' do
      expect(subject.journies).to be_empty
    end

    it 'can store an entry station' do
      subject.touch_in(entry_station)
      expect(subject.journies).not_to be_empty
    end

    it 'can store an exit station' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journies[-1][:exit_station]).to equal(exit_station)
    end

    it 'can store entry and exit as a hash' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journies[-1]).to be_instance_of(Hash)
    end
  end


  context '#touch_out' do
    it 'responds to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end
  
    it 'deducts from the card on touch out' do
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station)}.to change { subject.balance }.by -(::MIN_FARE)
    end
  
    it "should raise an error if not enough at least GBP1" do
      20.times do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      end
      expect { subject.touch_in(entry_station) }.to raise_error("You don't have enough funds")
    end
  end

  context "#journies" do
    it 'has a default false state' do
      expect(subject.journies).to be_empty
    end
  
    it 'can be in a journey' do
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
  
    it 'a journey can be ended' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
  end
end

  