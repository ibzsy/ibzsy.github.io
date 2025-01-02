require 'yaml'
require 'rss'
require 'open-uri'

books_read_url = 'https://www.goodreads.com/review/list_rss/153416087?shelf=read'
file_path = 'data/goodreads_books.yml'

read_books = []

URI.parse(books_read_url).open do |rss|
  feed = RSS::Parser.parse(rss)
  feed.items.each do |item|
    read_books << { 'title' => item.title.downcase, 'link' => item.link }
  end
end

File.open(file_path, 'w') do |file|
  file.write({ 'read_books' => read_books }.to_yaml)
end
