require 'station'

describe Station do
  let(:subject) { Station.new('Station Name', :zone_one) }

  it { is_expected.to respond_to(:name) }

  it { is_expected.to respond_to(:zone) }
end
