class VisitBerlinService
  require 'nokogiri'
  require 'httparty'

  class << self
    def process url
      begin
        doc = HTTParty.get(url)
        events = []
        parse_page ||= Nokogiri::HTML(doc)
        per_page = parse_page.css('.search').css('ul').count
        total = parse_page.css('div.view-footer__tools').text.strip.scan(/\d+/).first
        last_page = (total.to_f / per_page.to_f).round
        page = 1
        while page <= last_page
          pagination_url = "https://www.visitberlin.de/en/event-calendar-berlin?page={page}"
          pagination_doc = HTTParty.get(pagination_url)
          pagination_parse_page ||= Nokogiri::HTML(pagination_doc)
          pagination_data = pagination_parse_page.css('.search').css('ul.l-list').css('li.l-list__item')
          pagination_data.each do |data|
            event_info = {
                      title: data.css('p.teaser-search__heading').css(".heading-highlight__inner").children[0]&.text,
                      date: data.css('p.teaser-search__date').css('.heading-highlight__inner').children[1]&.text,
                      place:  data.css('.me__content').css('.nopr')&.text,
                      description: data.css('div.teaser-search__text')&.text&.strip
                    }
            events << event_info
          end
            page += 1
        end
          parsed_event = events.map do |attrs|
            Event.new(attrs)
          end
          Event.import(parsed_event)
        rescue Exception => e
        end
      end
    end
end