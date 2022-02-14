require 'spec_helper'
require 'ronin/web/user_agents/firefox'

describe Ronin::Web::UserAgents::Firefox do
  describe ".build" do
    let(:firefox_version) { '91.3.0' }
    let(:gecko_version)   { described_class::DESKTOP_GECKO_VERSION }

    context "when given `os: :windows`" do
      let(:os) { :windows }

      context "but os_version: is not given" do
        it do
          expect {
            subject.build(firefox_version: firefox_version, os: os)
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
                firefox_version: firefox_version,
                os: os,
                os_version: os_version
              )
            ).to eq("Mozilla/5.0 (Windows NT #{windows_version}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
          end

          Ronin::Web::UserAgents::OS::Windows::ARCHES.each do |arch_id,arch_string|

            context "and when `arch: #{arch_id.inspect}` is given" do
              let(:arch)         { arch_id     }
              let(:windows_arch) { arch_string }

              if arch_id
                it "must appned '#{arch_string}' after the Windows version" do
                  expect(
                    subject.build(
                      firefox_version: firefox_version,
                      os: os,
                      os_version: os_version,
                      arch:       arch
                    )
                  ).to eq("Mozilla/5.0 (Windows NT #{windows_version}; #{windows_arch}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
                end

                context "and when given the `firefox_version:` keyword argument" do
                  let(:firefox_version) { '1.2.3' }

                  it "must use the specified `firefox_version:` value" do
                    expect(
                      subject.build(
                        firefox_version: firefox_version,
                        os: os,
                        os_version: os_version,
                        arch: arch
                      )
                    ).to eq("Mozilla/5.0 (Windows NT #{windows_version}; #{windows_arch}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
                  end
                end
              else # `arch: nil` edge-case
                it "must not appned any additional fields" do
                  expect(
                    subject.build(
                      firefox_version: firefox_version,
                      os: os,
                      os_version: os_version,
                      arch:       arch
                    )
                  ).to eq("Mozilla/5.0 (Windows NT #{windows_version}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
                end

                context "and when given the `firefox_version:` keyword argument" do
                  let(:firefox_version) { '1.2.3' }

                  it "must use the specified `firefox_version:` value" do
                    expect(
                      subject.build(
                        firefox_version: firefox_version,
                        os: os,
                        os_version: os_version,
                        arch: arch
                      )
                    ).to eq("Mozilla/5.0 (Windows NT #{windows_version}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
                  end
                end
              end
            end
          end

          context "and when given the `firefox_version:` keyword argument" do
            let(:firefox_version) { '1.2.3' }

            it "must use the specified `firefox_version:` value" do
              expect(
                subject.build(
                  firefox_version: firefox_version,
                  os: os,
                  os_version: os_version
                )
              ).to eq("Mozilla/5.0 (Windows NT #{windows_version}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
            end
          end
        end
      end
    end

    context "when given `os: :macos`" do
      let(:os) { :macos }

      context "and when given the `os_version:` keyword argument" do
        let(:os_version) { '12.0.0' }

        it "must include 'Macintosh; Intel Mac OS X.X.Y.Z' in the extensions" do
          expect(
            subject.build(
              firefox_version: firefox_version,
              os: os,
              os_version: os_version
            )
          ).to eq("Mozilla/5.0 (Macintosh; Intel Mac OS X #{os_version}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
        end

        context "and when given the `firefox_version:` keyword argument" do
          let(:firefox_version) { '1.2.3' }

          it "must use the specified `firefox_version:` value" do
            expect(
              subject.build(
                firefox_version: firefox_version,
                os: os,
                os_version: os_version
              )
            ).to eq("Mozilla/5.0 (Macintosh; Intel Mac OS X #{os_version}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
          end
        end
      end

      context "but `os_version:` is not given" do
        it do
          expect {
            subject.build(firefox_version: firefox_version, os: os)
          }.to raise_error(ArgumentError,"os: #{os.inspect} also requires an os_version: value")
        end
      end
    end

    context "when given `os: :linux`" do
      let(:os) { :linux }

      it "must add 'X11; Linux; rv:...' to the extensions" do
        expect(
          subject.build(
            firefox_version: firefox_version,
            os: os
          )
        ).to eq("Mozilla/5.0 (X11; Linux; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
      end

      Ronin::Web::UserAgents::OS::Linux::ARCHES.each do |arch_id,arch_string|
        context "when given `arch: #{arch_id.inspect}`" do
          let(:arch)       { arch_id }
          let(:linux_arch) { arch_string }

          it "must add 'Linux #{arch_string}' to the extensions" do
            expect(
              subject.build(
                firefox_version: firefox_version,
                os: os,
                arch: arch
              )
            ).to eq("Mozilla/5.0 (X11; Linux #{linux_arch}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
          end

          Ronin::Web::UserAgents::OS::Linux::DISTROS.each do |distro_id,distro_string|
            context "and when given `linux_distro: #{distro_id.inspect}" do
              if distro_id
                let(:linux_distro) { distro_string }

                it "must add the '; #{distro_string}' to the extensions" do
                  expect(
                    subject.build(
                      firefox_version: firefox_version,
                      os: os,
                      linux_distro: linux_distro,
                      arch: arch
                    )
                  ).to eq("Mozilla/5.0 (X11; #{linux_distro}; Linux #{linux_arch}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
                end
              else # `linux_distro: nil` edge-case
                it "must omit the Linux Distro from the extensions" do
                  expect(
                    subject.build(
                      firefox_version: firefox_version,
                      os: os,
                      arch: arch
                    )
                  ).to eq("Mozilla/5.0 (X11; Linux #{linux_arch}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
                end
              end
            end
          end

          context "and when given the `firefox_version:` keyword argument" do
            let(:firefox_version) { '1.2.3' }

            it "must use the specified `firefox_version:` value" do
              expect(
                subject.build(
                  firefox_version: firefox_version,
                  os: os,
                  arch: arch
                )
              ).to eq("Mozilla/5.0 (X11; Linux #{linux_arch}; rv:#{firefox_version}) Gecko/#{gecko_version} Firefox/#{firefox_version}")
            end
          end
        end
      end
    end

    context "when given `os: :android`" do
      let(:os) { :android }

      it "must add 'Android; Mobile; rv:...' to the extensions" do
        expect(
          subject.build(
            firefox_version: firefox_version,
            os: os
          )
        ).to eq("Mozilla/5.0 (Android; Mobile; rv:#{firefox_version}) Gecko/#{firefox_version} Firefox/#{firefox_version}")
      end

      context "when `device_type: :mobile` is given" do
        let(:device_type) { :mobile }

        it "must add 'Android; Mobile; rv:...' to the extensions" do
          expect(
            subject.build(
              firefox_version: firefox_version,
              os: os,
              device_type: device_type
            )
          ).to eq("Mozilla/5.0 (Android; Mobile; rv:#{firefox_version}) Gecko/#{firefox_version} Firefox/#{firefox_version}")
        end
      end

      context "when `device_type: :tablet` is given" do
        let(:device_type) { :tablet }

        it "must add 'Android; Tablet; rv:...' to the extensions" do
          expect(
            subject.build(
              firefox_version: firefox_version,
              os: os,
              device_type: device_type
            )
          ).to eq("Mozilla/5.0 (Android; Tablet; rv:#{firefox_version}) Gecko/#{firefox_version} Firefox/#{firefox_version}")
        end
      end

      context "when `device_type: nil` is given" do
        let(:device_type) { nil }

        it "must add 'Android; Mobile; rv:...' to the extensions" do
          expect(
            subject.build(
              firefox_version: firefox_version,
              os: os,
              device_type: device_type
            )
          ).to eq("Mozilla/5.0 (Android; Mobile; rv:#{firefox_version}) Gecko/#{firefox_version} Firefox/#{firefox_version}")
        end
      end
    end

    context "when given `os: :other`" do
      let(:os) { :other }

      it do
        expect {
          subject.build(firefox_version: firefox_version, os: os)
        }.to raise_error(ArgumentError,"unsupported os: value (#{os.inspect})")
      end
    end
  end

  describe ".random" do
    it "must return a random Chrome User-Agent string" do
      expect(subject.random).to match(
        %r{^Mozilla/5\.0 \([^\)]+\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
      )
    end

    it "must generate a new random Chrome User-Agent string each time" do
      expect(subject.random).to_not eq(subject.random)
    end

    context "when `os: :windows`" do
      let(:os) { :windows }

      it "must return a random Windows Chrome User-Agent string" do
        expect(subject.random(os: os)).to match(
          %r{^Mozilla/5\.0 \(Windows NT \d+(?:\.\d+)*(?:; (?:WOW64|Win64; x64))?; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
        )
      end

      context "and when given `os_version:`" do
        let(:os_version) { 10 }

        it "must return a random Windows Chrome User-Agent string for that version of Windows" do
          expect(subject.random(os: os, os_version: os_version)).to match(
            %r{^Mozilla/5\.0 \(Windows NT 10\.0(?:; (?:WOW64|Win64; x64))?; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
          )
        end
      end

      context "and when given `arch: :wow64`" do
        let(:arch) { :wow64 }

        it "must return a random Windows Chrome User-Agent string for the WOW64 architecture" do
          expect(subject.random(os: os, arch: arch)).to match(
            %r{^Mozilla/5\.0 \(Windows NT \d+(?:\.\d+)*; WOW64; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
          )
        end
      end

      context "and when given `arch: :win64`" do
        let(:arch) { :win64 }

        it "must return a random Windows Chrome User-Agent string for the WOW64 architecture" do
          expect(subject.random(os: os, arch: arch)).to match(
            %r{^Mozilla/5\.0 \(Windows NT \d+(?:\.\d+)*; Win64; x64; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
          )
        end
      end
    end

    context "when `os: :macos` is given" do
      let(:os) { :macos }

      it "must return a macOS Chrome User-Agent string" do
        expect(subject.random(os: os)).to match(
          %r{^Mozilla/5\.0 \(Macintosh; Intel Mac OS X \d+(\.\d+){1,2}; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
        )
      end

      context "and when `os_version:` is given" do
        let(:os_version) { '10.11.12' }

        it "must return a macOS Chrome User-Agent string for that macOS version" do
          expect(subject.random(os: os, os_version: os_version)).to match(
            %r{^Mozilla/5\.0 \(Macintosh; Intel Mac OS X 10\.11\.12; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
          )
        end
      end
    end

    context "when `os: :linux` is given" do
      let(:os) { :linux }

      it "must return a Linux Chrome User-Agent string" do
        expect(subject.random(os: os)).to match(
          %r{^Mozilla/5\.0 \(X11(?:; (?:Ubuntu|Fedora|Arch))?; Linux (?:x86_64|aarch64|i686)(?:; [a-z]+(?:-[A-Z]+)?)?; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
        )
      end

      context "and when `linux_distro:` is given" do
        let(:linux_distro) { :ubuntu }

        it "must return a Linux Chrome User-Agent string for that Linux Distro" do
          expect(subject.random(os: os, linux_distro: linux_distro)).to match(
          %r{^Mozilla/5\.0 \(X11; Ubuntu; Linux (?:x86_64|aarch64|i686)(?:; [a-z]+(?:-[A-Z]+)?)?; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
          )
        end
      end

      context "and when `arch:` is given" do
        let(:arch) { :arm64 }

        it "must return a Linux Chrome User-Agent string for that architecture" do
          expect(subject.random(os: os, arch: arch)).to match(
            %r{^Mozilla/5\.0 \(X11(?:; (?:Ubuntu|Fedora|Arch))?; Linux aarch64(?:; [a-zA-Z-]+)?; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
          )
        end
      end
    end
 
    context "when `os: :android` is given" do
      let(:os) { :android }

      it "must return a Android Chrome User-Agent string" do
        expect(subject.random(os: os)).to match(
          %r{^Mozilla/5\.0 \(Android(?:; (?:Mobile|Tablet))?; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
        )
      end

      context "and when `device_type:` is given" do
        let(:device_type) { :tablet }

        it "must return a Linux Firefox User-Agent string with that device type" do
          expect(subject.random(os: os, device_type: device_type)).to match(
            %r{^Mozilla/5\.0 \(Android; Tablet; rv:\d+(?:\.\d+)*\) Gecko/(?:20100101|\d+(?:\.\d+)*) Firefox/\d+(\.\d+)*$}
          )
        end
      end
    end
  end
end
