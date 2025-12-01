require 'rss'
require 'open-uri'
require 'yaml'

books_read_url = 'https://www.goodreads.com/review/list_rss/153416087?shelf=read'
currently_reading_url = 'https://www.goodreads.com/review/list_rss/153416087?shelf=currently-reading'

file_path = 'data/goodreads_books.yml'

currently_reading_book = []
read_books = []

# Regular expressions to extract the author's name and book link from the description
author_regex = %r{author:\s*(.*?)<br/>}
book_link_regex = /<a href="(.*?)">/

# Fetch and parse the RSS feed for read books
URI.parse(books_read_url).open do |rss|
  feed = RSS::Parser.parse(rss)
  items = feed.items.sort_by { |item| Time.parse(item.pubDate.to_s) }.reverse
  items.first(3).each do |item|
    author_match = item.description.match(author_regex)
    author = author_match ? author_match[1] : 'unknown'
    book_link_match = item.description.match(book_link_regex)
    book_link = book_link_match ? book_link_match[1] : item.link
    read_books << {
      'title' => item.title.downcase,
      'link' => book_link,
      'author' => author.downcase
    }
  end
end

# Fetch and parse the RSS feed for currently reading book
URI.parse(currently_reading_url).open do |rss|
  feed = RSS::Parser.parse(rss)
  items = feed.items.sort_by { |item| Time.parse(item.pubDate.to_s) }.reverse
  items.first(3).each do |item|
    author_match = item.description.match(author_regex)
    author = author_match ? author_match[1] : 'unknown'
    book_link_match = item.description.match(book_link_regex)
    book_link = book_link_match ? book_link_match[1] : item.link
    currently_reading_book << {
      'title' => item.title.downcase,
      'link' => book_link,
      'author' => author.downcase
  }
end

# Write the data to the YAML file
File.open(file_path, 'w') do |file|
  file.write({
    'read_books' => read_books,
    'current_book' => currently_reading_book
  }.to_yaml)
end

puts "Book information written to #{file_path}"
