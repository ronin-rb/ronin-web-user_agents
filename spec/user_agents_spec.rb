require 'spec_helper'
require 'ronin/web/user_agents'

describe Ronin::Web::UserAgents do
  it "must define a VERSION constant" do
    expect(subject.const_defined?('VERSION')).to be(true)
  end

  describe ".chrome" do
    it "must return Ronin::Web::UserAgents::Chrome" do
      expect(subject.chrome).to eq(Ronin::Web::UserAgents::Chrome)
    end
  end

  describe ".google_chrome" do
    it "must return Ronin::Web::UserAgents::Chrome" do
      expect(subject.google_chrome).to eq(Ronin::Web::UserAgents::Chrome)
    end
  end

  describe ".firefox" do
    it "must return Ronin::Web::UserAgents::Firefox" do
      expect(subject.firefox).to eq(Ronin::Web::UserAgents::Firefox)
    end
  end

  describe ".google_bot" do
    it "must return Ronin::Web::UserAgents::GoogleBot" do
      expect(subject.google_bot).to eq(Ronin::Web::UserAgents::GoogleBot)
    end
  end

  describe ".random" do
    it "must return a random User-Agent string" do
      expect(subject.random).to match(
        %r{
          ^(?:
             Mozilla/5\.0\ \([^\)]+\)\ AppleWebKit/537\.36\ \(KHTML,\ like\ Gecko\)\ Chrome/\d+(\.\d+)*\ (?:Mobile\ )?Safari/537\.36|
             Mozilla/5\.0\ \([^\)]+\)\ Gecko/(?:20100101|\d+(?:\.\d+)*)\ Firefox/\d+(\.\d+)*
           )$
          }x
      )
    end

    it "must return a random User-Agent string each time" do
      expect(subject.random).to_not eq(subject.random)
    end
  end
end
