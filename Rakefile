require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler"
  exit -1
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'rubygems/tasks'
Gem::Tasks.new(sign: {checksum: true, pgp: true})

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :test    => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
task :docs => :yard

require 'kramdown/man/task'
Kramdown::Man::Task.new

require 'user_agent_parser'
require 'csv'

directory 'data/user_agents'

Dir['data/user_agents/*.txt'].each do |txt_path|
  csv_path = "#{txt_path.chomp('.txt')}.csv"

  file csv_path => txt_path do
    File.open(txt_path) do |txt_file|
      File.open(csv_path,'w') do |csv_file|
        csv = CSV.new(csv_file, write_headers: true)
        csv << %w[
          user_agent
          family
          version
          version_major
          version_minor
          version_patch
          version_patch_minor
          os_family
          os_version
          os_version_major
          os_version_minor
          os_version_patch
          os_version_patch_minor
          device_family
          device_model
          device_brand
        ]

        txt_file.each_line do |line|
          user_agent_string = line.chomp
          user_agent        = UserAgentParser.parse(user_agent_string)

          csv << [
            user_agent_string,
            user_agent.family,
            user_agent.version,
            (user_agent.version.major if user_agent.version),
            (user_agent.version.minor if user_agent.version),
            (user_agent.version.patch if user_agent.version),
            (user_agent.version.patch_minor if user_agent.version),
            user_agent.os.family,
            user_agent.os.version,
            (user_agent.os.version.major if user_agent.os.version),
            (user_agent.os.version.minor if user_agent.os.version),
            (user_agent.os.version.patch if user_agent.os.version),
            (user_agent.os.version.patch_minor if user_agent.os.version),
            user_agent.device.family,
            user_agent.device.model,
            user_agent.device.brand
          ]
        end
      end
    end
  end

  task 'user_agents:build' => csv_path
end

desc "Generates the data/user_agents/ CSV files"
task 'user_agents:build'
