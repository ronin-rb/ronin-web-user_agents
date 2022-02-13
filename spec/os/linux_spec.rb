require 'spec_helper'
require 'ronin/web/user_agents/os/linux'

describe Ronin::Web::UserAgents::OS::Linux do
  describe "DISTROS" do
    subject { described_class::DISTROS }

    it "must map :ubuntu to 'Ubuntu'" do
      expect(subject[:ubuntu]).to eq('Ubuntu')
    end

    it "must map :fedora to 'Fedora'" do
      expect(subject[:fedora]).to eq('Fedora')
    end

    it "must map :arch to 'Arch'" do
      expect(subject[:arch]).to eq('Arch')
    end

    it "must map nil to nil" do
      expect(subject[nil]).to be(nil)
    end
  end

  describe "ARCHES" do
    subject { described_class::ARCHES }

    it "must map :x86_64 to 'x86_64'" do
      expect(subject[:x86_64]).to eq('x86_64')
    end

    it "must map :aarch64 to 'aarch64'" do
      expect(subject[:aarch64]).to eq('aarch64')
    end

    it "must map :arm64 to 'aarch64'" do
      expect(subject[:arm64]).to eq('aarch64')
    end

    it "must map :i686 to 'i686'" do
      expect(subject[:i686]).to eq('i686')
    end

    it "must map :x86 to 'i686'" do
      expect(subject[:x86]).to eq('i686')
    end
  end
end
