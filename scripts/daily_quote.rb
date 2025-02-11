require 'net/http'
require 'json'
require 'yaml'

url = 'https://zenquotes.io/api/today'
uri = URI(url)
response = Net::HTTP.get(uri)
quote_data = JSON.parse(response).first

quote = quote_data['q']
author = quote_data['a']

data = {
  'quote' => quote,
  'author' => author
}

File.open('data/daily_quote.yml', 'w') do |file|
  file.write(data.to_yaml)
end
