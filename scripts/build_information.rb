require 'yaml'
require 'date'

file_path = 'data/build_information.yml'

version = `git rev-parse HEAD`.strip[0, 7]
date = DateTime.now.strftime '%d/%m/%Y %H:%M'

begin
  File.open(file_path, 'w') do |file|
    file.write({ 'build' => version, 'date' => date }.to_yaml)
  end
rescue StandardError => e
  puts "Failed to write to file: #{e.message}"
end
