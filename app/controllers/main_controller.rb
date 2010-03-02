require "open-uri"
require 'nokogiri'
require 'iconv'
#require 'net/http'

class MainController < ApplicationController
  def index
    @source_url = params[:source_url]
    if (not request.post?) or @source_url.blank?
      return
    end
    
    if params[:css_selector].blank?
      @css_selector = "html"
    else
      @css_selector = params[:css_selector].strip
    end
    
    cached_page = CachedPage.find(:first, :conditions => { :url => @source_url })
    if cached_page.nil?
      page_contents = Net::HTTP.get(URI(@source_url))
      cached_page = CachedPage.create(:url => @source_url, :contents => page_contents)
    end

    doc = Nokogiri(cached_page.contents)
    search_results = doc.search(@css_selector)

    @snippets = []
    xsl = Nokogiri::XSLT(File.read("app/controllers/pp.xsl"))
    search_results.each do |snippet|
      html = xsl.apply_to(snippet).to_s
      html = Iconv.new("utf-8", "iso-8859-1").iconv(html)
      @snippets << html
    end
  end
end
