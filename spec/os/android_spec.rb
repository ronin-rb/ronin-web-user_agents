require 'spec_helper'
require 'ronin/web/user_agents/os/android'

describe Ronin::Web::UserAgents::OS::Android do
  describe "VERSIONS" do
    subject { described_class::VERSIONS }

    it { expect(subject).to_not be_empty }
    it { expect(subject).to include('10') }
    it { expect(subject).to include('10.0') }
    it { expect(subject).to include('11') }
    it { expect(subject).to include('11.0') }
    it { expect(subject).to include('12') }
    it { expect(subject).to include('12.1') }
    it { expect(subject).to include('4.0.4') }
    it { expect(subject).to include('4.1.2') }
    it { expect(subject).to include('4.2.2') }
    it { expect(subject).to include('4.4.2') }
    it { expect(subject).to include('4.4.4') }
    it { expect(subject).to include('5.0') }
    it { expect(subject).to include('5.0.2') }
    it { expect(subject).to include('5.1') }
    it { expect(subject).to include('5.1.1') }
    it { expect(subject).to include('6.0') }
    it { expect(subject).to include('6.0.1') }
    it { expect(subject).to include('7.0') }
    it { expect(subject).to include('7.1.1') }
    it { expect(subject).to include('7.1.2') }
    it { expect(subject).to include('8.0') }
    it { expect(subject).to include('8.0.0') }
    it { expect(subject).to include('8.1') }
    it { expect(subject).to include('8.1.0') }
    it { expect(subject).to include('9') }
    it { expect(subject).to include('9.0') }
  end

  describe "ARCHES" do
    subject { described_class::ARCHES }

    it "must map :arm to 'arm'" do
      expect(subject[:arm]).to eq('arm')
    end

    it "must map :arm64 to 'arm_64'" do
      expect(subject[:arm64]).to eq('arm_64')
    end
  end

  describe "DEVICES" do
    subject { described_class::DEVICES }

    it { expect(subject).to_not be_empty }
    it { expect(subject).to all(be_kind_of(String)) }
  end
end
