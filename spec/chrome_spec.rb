require 'spec_helper'
require 'ronin/web/user_agents/chrome'

describe Ronin::Web::UserAgents::Chrome do
  describe ".build" do
    let(:chrome_version) { '100.0.4758.80' }

    context "when given `os: :windows`" do
      let(:os) { :windows }

      context "but os_version: is not given" do
        it do
          expect {
            subject.build(chrome_version: chrome_version, os: os)
          }.to raise_error(ArgumentError,"os: #{os.inspect} also requires an os_version: value")
        end
      end

      Ronin::Web::UserAgents::OS::Windows::VERSIONS.each do |version_id,version_string|
        context "when given `os_version: #{version_id.inspect}`" do
          let(:os_version)      { version_id }
          let(:windows_version) { version_string }

          it "must include 'Windows NT #{version_string}' in the extensions" do
            expect(
              subject.build(
                chrome_version: chrome_version,
                os: os,
                os_version: os_version
              )
            ).to eq("Mozilla/5.0 (Windows NT #{windows_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
          end

          Ronin::Web::UserAgents::OS::Windows::ARCHES.each do |arch_id,arch_string|
            context "and when `arch: #{arch_id.inspect}` is given" do
              let(:arch)         { arch_id     }
              let(:windows_arch) { arch_string }

              if arch_id
                it "must appned '#{arch_string}' after the Windows version" do
                  expect(
                    subject.build(
                      chrome_version: chrome_version,
                      os: os,
                      os_version: os_version,
                      arch:       arch
                    )
                  ).to eq("Mozilla/5.0 (Windows NT #{windows_version}; #{windows_arch}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
                end

                context "and when given the `chrome_version:` keyword argument" do
                  let(:chrome_version) { '1.2.3' }

                  it "must use the specified `chrome_version:` value" do
                    expect(
                      subject.build(
                        chrome_version: chrome_version,
                        os: os,
                        os_version: os_version,
                        arch: arch
                      )
                    ).to eq("Mozilla/5.0 (Windows NT #{windows_version}; #{windows_arch}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
                  end
                end
              else # `arch: nil` edge-case
                it "must not appned any additional fields" do
                  expect(
                    subject.build(
                      chrome_version: chrome_version,
                      os: os,
                      os_version: os_version,
                      arch:       arch
                    )
                  ).to eq("Mozilla/5.0 (Windows NT #{windows_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
                end

                context "and when given the `chrome_version:` keyword argument" do
                  let(:chrome_version) { '1.2.3' }

                  it "must use the specified `chrome_version:` value" do
                    expect(
                      subject.build(
                        chrome_version: chrome_version,
                        os: os,
                        os_version: os_version,
                        arch: arch
                      )
                    ).to eq("Mozilla/5.0 (Windows NT #{windows_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
                  end
                end
              end
            end
          end

          context "and when given the `chrome_version:` keyword argument" do
            let(:chrome_version) { '1.2.3' }

            it "must use the specified `chrome_version:` value" do
              expect(
                subject.build(
                  chrome_version: chrome_version,
                  os: os,
                  os_version: os_version
                )
              ).to eq("Mozilla/5.0 (Windows NT #{windows_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
            end
          end
        end
      end
    end

    context "when given `os: :macos`" do
      let(:os) { :macos }

      Ronin::Web::UserAgents::OS::MacOS::VERSIONS_UNDERSCORED.each do |version,underscored_version|
        context "and when given `os_version: '#{version}'`" do
          let(:os_version) { version }

          it "must include 'Macintosh; Intel Mac OS X #{underscored_version}' in the extensions" do
            expect(
              subject.build(
                chrome_version: chrome_version,
                os: os,
                os_version: os_version
              )
            ).to eq("Mozilla/5.0 (Macintosh; Intel Mac OS X #{underscored_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
          end

          context "when given `chrome_version: ...`" do
            let(:chrome_version) { '1.2.3' }

            it "must use the specified `chrome_version:` value" do
              expect(
                subject.build(
                  chrome_version: chrome_version,
                  os: os,
                  os_version: os_version
                )
              ).to eq("Mozilla/5.0 (Macintosh; Intel Mac OS X #{underscored_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
            end
          end
        end
      end

      context "and when given an unknown `os_version:` value" do
        let(:os_version)          { '12.0.0'               }
        let(:underscored_version) { os_version.tr('.','_') }

        it "must include 'Macintosh; Intel Mac OS X X_Y_Z' in the extensions" do
          expect(
            subject.build(
              chrome_version: chrome_version,
              os: os,
              os_version: os_version
            )
          ).to eq("Mozilla/5.0 (Macintosh; Intel Mac OS X #{underscored_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
        end

        context "and when given the `chrome_version:` keyword argument" do
          let(:chrome_version) { '1.2.3' }

          it "must use the specified `chrome_version:` value" do
            expect(
              subject.build(
                chrome_version: chrome_version,
                os: os,
                os_version: os_version
              )
            ).to eq("Mozilla/5.0 (Macintosh; Intel Mac OS X #{underscored_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
          end
        end
      end

      context "but `os_version:` is not given" do
        it do
          expect {
            subject.build(chrome_version: chrome_version, os: os)
          }.to raise_error(ArgumentError,"os: #{os.inspect} also requires an os_version: value")
        end
      end
    end

    context "when given `os: :linux`" do
      let(:os) { :linux }

      context "but `arch:` is not given" do
        it do
          expect {
            subject.build(chrome_version: chrome_version, os: os)
          }.to raise_error(ArgumentError,"os: #{os.inspect} also requires an arch: value")
        end
      end

      Ronin::Web::UserAgents::OS::Linux::ARCHES.each do |arch_id,arch_string|
        context "when given `arch: #{arch_id.inspect}`" do
          let(:arch)       { arch_id }
          let(:linux_arch) { arch_string }

          it "must add 'Linux #{arch_string}' to the extensions" do
            expect(
              subject.build(
                chrome_version: chrome_version,
                os: os,
                arch: arch
              )
            ).to eq("Mozilla/5.0 (X11; Linux #{linux_arch}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
          end

          Ronin::Web::UserAgents::OS::Linux::DISTROS.each do |distro_id,distro_string|
            context "and when given `linux_distro: #{distro_id.inspect}" do
              if distro_id
                let(:linux_distro) { distro_string }

                it "must add the '; #{distro_string}' to the extensions" do
                  expect(
                    subject.build(
                      chrome_version: chrome_version,
                      os: os,
                      linux_distro: linux_distro,
                      arch: arch
                    )
                  ).to eq("Mozilla/5.0 (X11; #{linux_distro}; Linux #{linux_arch}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
                end
              else # `linux_distro: nil` edge-case
                it "must omit the Linux Distro from the extensions" do
                  expect(
                    subject.build(
                      chrome_version: chrome_version,
                      os: os,
                      arch: arch
                    )
                  ).to eq("Mozilla/5.0 (X11; Linux #{linux_arch}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
                end
              end
            end
          end

          context "and when given the `chrome_version:` keyword argument" do
            let(:chrome_version) { '1.2.3' }

            it "must use the specified `chrome_version:` value" do
              expect(
                subject.build(
                  chrome_version: chrome_version,
                  os: os,
                  arch: arch
                )
              ).to eq("Mozilla/5.0 (X11; Linux #{linux_arch}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Safari/537.36")
            end
          end
        end
      end
    end

    context "when given `os: :android`" do
      let(:os) { :android }

      context "but os_version: is not given" do
        it do
          expect {
            subject.build(chrome_version: chrome_version, os: os)
          }.to raise_error(ArgumentError,"os: #{os.inspect} also requires an os_version: value")
        end
      end

      context "when given an `os_version:` keyword argument" do
        let(:os_version)      { '4.0.4'    }
        let(:android_version) { os_version }

        it "must add 'Linux; Android ...' to the extensions" do
          expect(
            subject.build(
              chrome_version: chrome_version,
              os: os,
              os_version: os_version
            )
          ).to eq("Mozilla/5.0 (Linux; Android #{android_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36")
        end

        Ronin::Web::UserAgents::OS::Android::ARCHES.each do |arch_id,arch_string|
          context "and when given `arch: #{arch_id.inspect}`" do
            let(:arch)         { arch_id }
            let(:android_arch) { arch_string }

            if arch_id
              it "must add 'Linux; #{arch_string}' to the extensions" do
                expect(
                  subject.build(
                    chrome_version: chrome_version,
                    os: os,
                    os_version: os_version,
                    arch: arch
                  )
                ).to eq("Mozilla/5.0 (Linux; #{android_arch}; Android #{android_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36")
              end

              context "and when given `chrome_version: ...`" do
                let(:chrome_version) { '1.2.3' }

                it "must use the specified `chrome_version:` value" do
                  expect(
                    subject.build(
                      chrome_version: chrome_version,
                      os: os,
                      os_version: os_version,
                      arch: arch
                    )
                  ).to eq("Mozilla/5.0 (Linux; #{android_arch}; Android #{android_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36")
                end
              end
            else # `arch: nil` edge-case
              it "must omit th Android architecture from the extensions" do
                expect(
                  subject.build(
                    chrome_version: chrome_version,
                    os: os,
                    os_version: os_version,
                    arch: arch
                  )
                ).to eq("Mozilla/5.0 (Linux; Android #{android_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36")
              end

              context "and when given the `chrome_version:` keyword argument" do
                let(:chrome_version) { '1.2.3' }

                it "must use the specified `chrome_version:` value" do
                  expect(
                    subject.build(
                      chrome_version: chrome_version,
                      os: os,
                      os_version: os_version,
                      arch: arch
                    )
                  ).to eq("Mozilla/5.0 (Linux; Android #{android_version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36")
                end
              end
            end
          end
        end

        context "when the `android_device:` keyword argument is given" do
          let(:android_device) { 'SM-A307FN' }

          it "must include the Android device in the extensions" do
            expect(
              subject.build(
                chrome_version: chrome_version,
                os: os,
                os_version: os_version,
                android_device: android_device
              )
            ).to eq("Mozilla/5.0 (Linux; Android #{android_version}; #{android_device}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/#{chrome_version} Mobile Safari/537.36")
          end
        end
      end
    end

    context "when given `os: :other`" do
      let(:os) { :other }

      it do
        expect {
          subject.build(chrome_version: chrome_version, os: os)
        }.to raise_error(ArgumentError,"unsupported os: value (#{os.inspect})")
      end
    end
  end

  describe ".random" do
    it "must return a random Chrome User-Agent string" do
      expect(subject.random).to match(
        %r{\AMozilla/5\.0 \([^\(\)]+(?:\([^\)]+\)[^\)]+)?\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
      )
    end

    it "must generate a new random Chrome User-Agent string each time" do
      expect(subject.random).to_not eq(subject.random)
    end

    context "when `os: :windows`" do
      let(:os) { :windows }

      it "must return a random Windows Chrome User-Agent string" do
        expect(subject.random(os: os)).to match(
          %r{\AMozilla/5\.0 \(Windows NT \d+(?:\.\d+)*(?:; (?:WOW64|Win64; x64))?\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
        )
      end

      context "and when given `os_version:`" do
        let(:os_version) { 10 }

        it "must return a random Windows Chrome User-Agent string for that version of Windows" do
          expect(subject.random(os: os, os_version: os_version)).to match(
            %r{\AMozilla/5\.0 \(Windows NT 10\.0(?:; (?:WOW64|Win64; x64))?\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end

      context "and when given `arch: :wow64`" do
        let(:arch) { :wow64 }

        it "must return a random Windows Chrome User-Agent string for the WOW64 architecture" do
          expect(subject.random(os: os, arch: arch)).to match(
            %r{\AMozilla/5\.0 \(Windows NT \d+(?:\.\d+)*; WOW64\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end

      context "and when given `arch: :win64`" do
        let(:arch) { :win64 }

        it "must return a random Windows Chrome User-Agent string for the WOW64 architecture" do
          expect(subject.random(os: os, arch: arch)).to match(
            %r{\AMozilla/5\.0 \(Windows NT \d+(?:\.\d+)*; Win64; x64\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end
    end

    context "when `os: :macos` is given" do
      let(:os) { :macos }

      it "must return a macOS Chrome User-Agent string" do
        expect(subject.random(os: os)).to match(
          %r{\AMozilla/5\.0 \(Macintosh; Intel Mac OS X \d+(_\d+){1,2}\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
        )
      end

      context "and when `os_version:` is given" do
        let(:os_version) { '10.11.12' }

        it "must return a macOS Chrome User-Agent string for that macOS version" do
          expect(subject.random(os: os, os_version: os_version)).to match(
            %r{\AMozilla/5\.0 \(Macintosh; Intel Mac OS X 10_11_12\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end
    end

    context "when `os: :linux` is given" do
      let(:os) { :linux }

      it "must return a Linux Chrome User-Agent string" do
        expect(subject.random(os: os)).to match(
          %r{\AMozilla/5\.0 \(X11(?:; (?:Ubuntu|Fedora|Arch))?; Linux (?:x86_64|aarch64|i686)\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
        )
      end

      context "and when `linux_distro:` is given" do
        let(:linux_distro) { :ubuntu }

        it "must return a Linux Chrome User-Agent string for that Linux Distro" do
          expect(subject.random(os: os, linux_distro: linux_distro)).to match(
            %r{\AMozilla/5\.0 \(X11; Ubuntu; Linux (?:x86_64|aarch64|i686)\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end

      context "and when `arch:` is given" do
        let(:arch) { :arm64 }

        it "must return a Linux Chrome User-Agent string for that architecture" do
          expect(subject.random(os: os, arch: arch)).to match(
            %r{\AMozilla/5\.0 \(X11(?:; (?:Ubuntu|Fedora|Arch))?; Linux aarch64\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end
    end

    context "when `os: :android` is given" do
      let(:os) { :android }

      it "must return a Android Chrome User-Agent string" do
        expect(subject.random(os: os)).to match(
          %r{\AMozilla/5\.0 \(Linux(?:; (?:arm|arm_64))?; Android \d+(?:\.\d+)*(?:; [^\(\)]+(?:\([^\)]+\)[^\(\)]+)?)?\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
        )
      end

      context "and when `os_version:` is given" do
        let(:os_version) { '8.1' }

        it "must return a Android Chrome User-Agent string for that Android version" do
          expect(subject.random(os: os, os_version: os_version)).to match(
            %r{\AMozilla/5\.0 \(Linux(?:; (?:arm|arm_64))?; Android 8\.1(?:; [^\(\)]+(?:\([^\)]+\)[^\(\)]+)?)?\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end

      context "and when `arch:` is given" do
        let(:arch) { :arm64 }

        it "must return a Linux Chrome User-Agent string for that architecture" do
          expect(subject.random(os: os, arch: arch)).to match(
            %r{\AMozilla/5\.0 \(Linux; arm_64; Android (?:\d+(?:\.\d+)*)(?:; [^\(\)]+(?:\([^\)]+\)[^\(\)]+)?)?\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end

      context "and when `android_device:` is given" do
        let(:android_device) { 'SM-A307FN' }

        it "must return a Linux Chrome User-Agent string with that Android device" do
          expect(subject.random(os: os, android_device: android_device)).to match(
            %r{\AMozilla/5\.0 \(Linux(?:; (?:arm|arm_64))?; Android (?:\d+(?:\.\d+)*); #{android_device}\) AppleWebKit/537\.36 \(KHTML, like Gecko\) Chrome/\d+(\.\d+)* (?:Mobile )?Safari/537\.36\z}
          )
        end
      end
    end
  end
end
