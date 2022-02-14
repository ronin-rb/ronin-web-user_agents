require 'spec_helper'
require 'ronin/web/user_agents/google_bot'

describe Ronin::Web::UserAgents::GoogleBot do
  describe ".build" do
    context "whne given no keyword arguments" do
      it "must return 'GoogleBot/#{described_class::VERSION} (+#{described_class::URL})'" do
        expect(subject.build).to eq(
          "GoogleBot/#{described_class::VERSION} (+#{described_class::URL})"
        )
      end

      context "when given `crawler: :image`" do
        it "must return 'Googlebot-Image/1.0'" do
          expect(subject.build(crawler: :image)).to eq(
            "Googlebot-Image/1.0"
          )
        end
      end

      context "when given `crawler: :video`" do
        it "must return 'Googlebot-Video/1.0'" do
          expect(subject.build(crawler: :video)).to eq(
            "Googlebot-Video/1.0"
          )
        end
      end

      context "when given `crawler: :search`" do
        it "must return 'GoogleBot/#{described_class::VERSION} (+http://www.google.com/bot.html)'" do
          expect(subject.build(crawler: :search)).to eq(
            "GoogleBot/#{described_class::VERSION} (+#{described_class::URL})"
          )
        end

        context "and when also given `compatible: :desktop`" do
          it "must return 'Mozilla/5.0 (compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL})'" do
            expect(
              subject.build(
                crawler: :search,
                compatible: :desktop
              )
            ).to eq(
              "Mozilla/5.0 (compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL})"
            )
          end

          context "and when also given the `chrome_version:` keyword argument" do
            let(:chrome_version) { '1.2.3' }

            it "must return 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL}) Chrome/... Safari/537.36'" do
              expect(
                subject.build(
                  crawler:        :search,
                  compatible:     :desktop,
                  chrome_version: chrome_version
                )
              ).to eq(
                "Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL}) Chrome/#{chrome_version} Safari/537.36"
              )
            end
          end
        end

        context "and when also given `compatible: :mobile`" do
          context "and the `chrome_version:` keyword argument is also given" do
            let(:chrome_version) { '1.2.3' }

            it "must return 'Mozilla/5.0 (Linux; Android #{described_class::ANDROID_VERSION}; #{described_class::ANDROID_DEVICE}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/... Mobile Safari/537.36 (compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL})'" do
              expect(
                subject.build(
                  crawler:        :search,
                  compatible:     :mobile,
                  chrome_version: chrome_version
                )
              ).to eq(
                "Mozilla/5.0 (Linux; Android #{described_class::ANDROID_VERSION}; #{described_class::ANDROID_DEVICE}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36 (compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL})"
              )
            end
          end

          context "but the `chrome_version:` keyword argument is not given" do
            it do
              expect {
                subject.build(crawler: :search, compatible: :mobile)
              }.to raise_error(ArgumentError,"compatible: :mobile also requires the chrome_version: keyword argument")
            end
          end
        end
      end
    end

    context "and when also given `compatible: :desktop`" do
      it "must return 'Mozilla/5.0 (compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL})'" do
        expect(subject.build(compatible: :desktop)).to eq(
          "Mozilla/5.0 (compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL})"
        )
      end

      context "and when also given the `chrome_version:` keyword argument" do
        let(:chrome_version) { '1.2.3' }

        it "must return 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL}) Chrome/... Safari/537.36'" do
          expect(
            subject.build(
              compatible:     :desktop,
              chrome_version: chrome_version
            )
          ).to eq(
            "Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL}) Chrome/#{chrome_version} Safari/537.36"
          )
        end
      end
    end

    context "and when also given `compatible: :mobile`" do
      context "and the `chrome_version:` keyword argument is also given" do
        let(:chrome_version) { '1.2.3' }

        it "must return 'Mozilla/5.0 (Linux; Android #{described_class::ANDROID_VERSION}; #{described_class::ANDROID_DEVICE}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/... Mobile Safari/537.36 (compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL})'" do
          expect(
            subject.build(
              compatible:     :mobile,
              chrome_version: chrome_version
            )
          ).to eq(
            "Mozilla/5.0 (Linux; Android #{described_class::ANDROID_VERSION}; #{described_class::ANDROID_DEVICE}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36 (compatible; GoogleBot/#{described_class::VERSION}; +#{described_class::URL})"
          )
        end
      end

      context "but the `chrome_version:` keyword argument is not given" do
        it do
          expect {
            subject.build(compatible: :mobile)
          }.to raise_error(ArgumentError,"compatible: :mobile also requires the chrome_version: keyword argument")
        end
      end
    end
  end

  describe ".random" do
    let(:version_pattern) { Regexp.escape(described_class::VERSION) }
    let(:url_pattern)     { Regexp.escape(described_class::URL)     }

    let(:android_version_pattern) do
      Regexp.escape(described_class::ANDROID_VERSION)
    end

    let(:android_device_pattern) do
      Regexp.escape(described_class::ANDROID_DEVICE)
    end

    it "must return a random GoogleBot User-Agent string" do
      expect(subject.random).to match(
        %r{
          ^(?:
            Googlebot-Image/1\.0|
            Googlebot-Video/1\.0|
            Mozilla/5\.0\ AppleWebKit/537\.36\ \(KHTML,\ like\ Gecko;\ compatible;\ GoogleBot/#{version_pattern};\ \+#{url_pattern}\)\ Chrome/\d+(?:\.\d+)*\ Safari/537\.36|
            Mozilla/5\.0\ \(compatible;\ GoogleBot/#{version_pattern};\ \+#{url_pattern}\)|
            Mozilla/5\.0\ \(Linux;\ Android\ #{android_version_pattern};\ #{android_device_pattern}\)\ AppleWebKit/537\.36\ \(KHTML,\ like\ Gecko\)\ Chrome/\d+(?:\.\d+)*\ Mobile\ Safari/537\.36\ \(compatible;\ GoogleBot/#{version_pattern};\ \+#{url_pattern}\)|
            GoogleBot/#{version_pattern}\ \(\+#{url_pattern}\)
          )$
        }x
      )
    end

    context "when `crawler: :image` is given" do
      it "must return 'Googlebot-Image/1.0'" do
        expect(subject.build(crawler: :image)).to eq(
          "Googlebot-Image/1.0"
        )
      end
    end

    context "when `crawler: :video` is given" do
      it "must return 'Googlebot-Video/1.0'" do
        expect(subject.build(crawler: :video)).to eq(
          "Googlebot-Video/1.0"
        )
      end
    end

    context "when `crawler: :search ` is given" do
      it "must return a random GoogleBot User-Agent string" do
        expect(subject.random(crawler: :search)).to match(
          %r{
            ^(?:
            Mozilla/5\.0\ AppleWebKit/537\.36\ \(KHTML,\ like\ Gecko;\ compatible;\ GoogleBot/#{version_pattern};\ \+#{url_pattern}\)\ Chrome/\d+(?:\.\d+)*\ Safari/537\.36|
            Mozilla/5\.0\ \(compatible;\ GoogleBot/#{version_pattern};\ \+#{url_pattern}\)|
            Mozilla/5\.0\ \(Linux;\ Android\ #{android_version_pattern};\ #{android_device_pattern}\)\ AppleWebKit/537\.36\ \(KHTML,\ like\ Gecko\)\ Chrome/\d+(?:\.\d+)*\ Mobile\ Safari/537\.36\ \(compatible;\ GoogleBot/#{version_pattern};\ \+#{url_pattern}\)|
            GoogleBot/#{version_pattern}\ \(\+#{url_pattern}\)
            )$
          }x
        )
      end

      context "and when `compatible: :desktop` is given" do
        it "must return a random GoogleBot desktop compatible User-Agent string" do
          expect(
            subject.random(
              crawler:    :search,
              compatible: :desktop
            )
          ).to match(
            %r{
              ^(?:
                Mozilla/5\.0\ AppleWebKit/537\.36\ \(KHTML,\ like\ Gecko;\ compatible;\ GoogleBot/#{version_pattern};\ \+#{url_pattern}\)\ Chrome/\d+(?:\.\d+)*\ Safari/537\.36|
                Mozilla/5\.0\ \(compatible;\ GoogleBot/#{version_pattern};\ \+#{url_pattern}\)
              )$
            }x
          )
        end
      end

      context "and when `compatible: :mobile` is given" do
        it "must return a random GoogleBot mobile compatible User-Agent string" do
          expect(
            subject.random(
              crawler:    :search,
              compatible: :mobile
            )
          ).to match(
            %r{^Mozilla/5\.0 \(Linux;\ Android #{android_version_pattern}; #{android_device_pattern}\) AppleWebKit/537\.36 \(KHTML, like\ Gecko\) Chrome/\d+(?:\.\d+)*\ Mobile\ Safari/537\.36 \(compatible; GoogleBot/#{version_pattern}; \+#{url_pattern}\)$}
          )
        end
      end
    end
  end
end
