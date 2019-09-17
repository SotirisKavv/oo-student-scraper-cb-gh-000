require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("student-card").each do |card|
      students << {
        name: card.css("h4.student-name").text,
        location: card.css("p.student-location").text,
        profile_url: "#{card.css("a").attribute("href")}"
      }
      binding.pry
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
