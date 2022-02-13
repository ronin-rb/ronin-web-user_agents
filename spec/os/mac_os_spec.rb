require 'spec_helper'
require 'ronin/web/user_agents/os/mac_os'

describe Ronin::Web::UserAgents::OS::MacOS do
  describe "VERSIONS" do
    subject { described_class::VERSIONS }

    it { expect(subject).to_not be_empty }
    it { expect(subject).to include('10.10') }
    it { expect(subject).to include('10.10.3') }
    it { expect(subject).to include('10.10.4') }
    it { expect(subject).to include('10.11.6') }
    it { expect(subject).to include('10.12.0') }
    it { expect(subject).to include('10.12.1') }
    it { expect(subject).to include('10.12.6') }
    it { expect(subject).to include('10.13.4') }
    it { expect(subject).to include('10.13.6') }
    it { expect(subject).to include('10.14.0') }
    it { expect(subject).to include('10.14.1') }
    it { expect(subject).to include('10.14.2') }
    it { expect(subject).to include('10.14.5') }
    it { expect(subject).to include('10.14.6') }
    it { expect(subject).to include('10.14.8') }
    it { expect(subject).to include('10.15.1') }
    it { expect(subject).to include('10.15.2') }
    it { expect(subject).to include('10.15.4') }
    it { expect(subject).to include('10.15.6') }
    it { expect(subject).to include('10.15.7') }
    it { expect(subject).to include('10.16') }
    it { expect(subject).to include('10.16.0') }
    it { expect(subject).to include('10.31.7') }
    it { expect(subject).to include('10.4') }
    it { expect(subject).to include('10.55') }
    it { expect(subject).to include('10.7.0') }
    it { expect(subject).to include('11.0.0') }
    it { expect(subject).to include('11.15') }
    it { expect(subject).to include('11.6.3') }
    it { expect(subject).to include('12.2.0') }
    it { expect(subject).to include('16.55') }
  end

  describe "VERSIONS_UNDERSCORED" do
    subject { described_class::VERSIONS_UNDERSCORED }

    it "must map known X.Y versions to X_Y notation" do
      expect(subject['10.10']).to eq('10_10')
    end

    it "must map known X.Y.Z versions to X_Y_Z notation" do
      expect(subject['10.10.3']).to eq('10_10_3')
    end

    it "must map unknwon X.Y versions to X_Y notation" do
      expect(subject['20.20']).to eq('20_20')
    end

    it "must map unknwon X.Y.Z versions to X_Y_Z notation" do
      expect(subject['20.20.20']).to eq('20_20_20')
    end
  end

  describe "ARCHES" do
    subject { described_class::ARCHES }

    it "must map :intel to 'Intel'" do
      expect(subject[:intel]).to eq('Intel')
    end

    it "must map :x86_64 to 'Intel'" do
      expect(subject[:x86_64]).to eq('Intel')
    end
  end
end
