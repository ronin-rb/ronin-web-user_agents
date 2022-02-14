require 'spec_helper'
require 'ronin/web/user_agents/os/windows'

describe Ronin::Web::UserAgents::OS::Windows do
  describe "VERSIONS" do
    subject { described_class::VERSIONS }

    it "must map :xp to '5.2'" do
      expect(subject[:xp]).to eq('5.2')
    end

    it "must map :vista to '6.0'" do
      expect(subject[:vista]).to eq('6.0')
    end

    it "must map 7 to '6.1'" do
      expect(subject[7]).to eq('6.1')
    end

    it "must map 8 to '6.2'" do
      expect(subject[8]).to eq('6.2')
    end

    it "must map 8.1 to '6.3'" do
      expect(subject[8.1]).to eq('6.3')
    end

    it "must map 10 to '10.0'" do
      expect(subject[10]).to eq('10.0')
    end
  end

  describe "ARCHES" do
    subject { described_class::ARCHES }

    it "must map :wow64 to 'WOW64'" do
      expect(subject[:wow64]).to eq('WOW64')
    end

    it "must map :win64 to 'Win64; x64'" do
      expect(subject[:win64]).to eq('Win64; x64')
    end

    it "must map :x86_64 to 'Win64; x64'" do
      expect(subject[:x86_64]).to eq('Win64; x64')
    end

    it "must map nil to nil" do
      expect(subject[nil]).to be(nil)
    end
  end
end
