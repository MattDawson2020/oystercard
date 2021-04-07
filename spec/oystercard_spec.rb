require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }

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

  context '#touch_out' do
    it 'responds to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end
  
    it 'deducts from the card on touch out' do
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by -(::MIN_FARE)
    end
  
    it "should raise an error if not enough at least GBP1" do
      20.times { subject.touch_out }
      expect { subject.touch_in }.to raise_error("You don't have enough funds")
    end
  end

  it 'has a default false state' do
    expect(subject).not_to be_in_journey
  end

  it 'can be in a journey' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'a journey can be ended' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
end