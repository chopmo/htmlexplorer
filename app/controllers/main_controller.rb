require "open-uri"
require 'nokogiri'

class MainController < ApplicationController
  
  def index
    @source_url = params[:source_url]
    if (not request.post?) or @source_url.blank?
      return
    end
    
    @css_selector1 = params[:css_selector1].strip
    @css_selector2 = params[:css_selector2].strip

    if @css_selector1.blank?
      @css_selector1 = "html"
    end
    
    cached_page = CachedPage.find(:first, :conditions => { :url => @source_url })
    if cached_page.nil?
      page_contents = Net::HTTP.get(URI(@source_url))
      cached_page = CachedPage.create(:url => @source_url, :contents => page_contents)
    end

    doc = Nokogiri(cached_page.contents)
    search_results = doc.search(@css_selector1)

    @snippets = []
    search_results.each do |snippet|

      if @css_selector2.blank?
        html_sub_snippets = [snippet.to_html]
      else
        sub_snippets = snippet.search(@css_selector2)
        html_sub_snippets = sub_snippets.map { |s| s.to_html }
      end
      
      @snippets << html_sub_snippets
    end

  end
end
