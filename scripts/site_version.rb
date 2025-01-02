require 'yaml'

file_path = 'data/site_version.yml'
version = `git rev-parse HEAD`.strip[0, 7]

begin
  File.open(file_path, 'w') do |file|
    file.write({ 'version' => version }.to_yaml)
  end
rescue StandardError => e
  puts "Failed to write to file: #{e.message}"
end
