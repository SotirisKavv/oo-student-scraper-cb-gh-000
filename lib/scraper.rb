require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |card|
      students << {
        name: card.css("h4.student-name").text,
        location: card.css("p.student-location").text,
        profile_url: "#{card.css("a").attribute("href")}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    links = doc.css(".social-icon-container a")
    links.each do |link|
      media = link.attribute("href").text
      if media.match(/.twitter./)
        student[:twitter] = media
      elsif media.match(/.linkedin./)
        student[:linkedin] = media
      elsif media.match(/.github./)
        student[:twitter] = media
      else
        student[:blog] = media
      end
    end
    student[:twitter] = "#{links[0].attribute("href")}"
    student[:linkedin] = "#{links[1].attribute("href")}"
    student[:github] = "#{links[2].attribute("href")}"
    student[:blog] = "#{links[3].attribute("href")}"
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".bio-content .description-holder p").text
    student
  end

end
