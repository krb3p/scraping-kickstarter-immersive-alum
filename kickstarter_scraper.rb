require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = kickstarter.css('.project-card')
  project_hash = {}
  projects.each do |post|
    title = post.css('h2 a').text
    project_hash[title] = {
      :description => post.css('.bbcard_blurb').text,
      :image_link => post.css("div.project-thumbnail a img").attribute("src").value,
      :location => post.css('.project-meta li a span.location-name').text,
      :percent_funded => post.css('.project-stats li.first.funded strong').text.to_i,
    }

  end
  project_hash
end
