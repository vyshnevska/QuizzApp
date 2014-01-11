class HistoryTimelinesController < ApplicationController
  def index
    # require 'nokogiri'
    require 'open-uri'
      # doc = Nokogiri::XML(File.open("#{Rails.root}/public/xml_templates/new.xml"))
      # @links = doc.xpath('//breakfast_menu/food').map do |i|
      #   {'name' => i.xpath('name').inner_text, 'price' => i.xpath('price').inner_text, 'description' => i.xpath('description').inner_text}
      # end

      doc = Nokogiri::XML(File.open("#{Rails.root}/public/xml_templates/timelines.xml"))

      @timelines = doc.xpath('//periods/century').map do |period|
        {'name' => period.xpath('name').inner_text, 'description' => period.xpath('description').inner_text}
      end
  end
end
