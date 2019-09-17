require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = {}
    doc.css("student-card").each do |card|
      students[card.css("h4.student-name").text] = {}
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
