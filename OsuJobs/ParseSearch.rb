require 'nokogiri'
require 'mechanize'
require 'rubygems'
require 'open-uri'
require_relative 'SearchField.rb'

# File created 2/14/2020 by Ern Chi Khoo

=begin
 Class ParseSearch framework initialized 2/14/2020 by Ern Chi Khoo
 Parses the data of the search page that is scraped from the scraper 
=end
class ParseSearch

=begin
	Created 2/14/2020 by Ern Chi Khoo
	Edited 2/16/2020 by Ern Chi Khoo: Changed the instance variable value
	Parameter is a Mechanize::Page object
=end
	def initialize(search_page)
		@page = search_page
	end

=begin
	Created 2/15/2020 by Ern Chi Khoo
	Edited 2/16/2020 by Ern Chi Khoo: Made function dynamic
	Edited 2/18/2020 by Juhee Park: Integrated SearchField class
	Edited 2/18/2020 by Ern Chi Khoo and Juhee Park: Bug fix
  Edited 2/20/2020 by Jas Bawa: Removed extra paranthesis
	Parses the search page and returns a hash of the labels and SearchField objects
=end
	def parse_page
		queries = Hash.new
		@page.labels.each do |l|
			type = "select"
			options = Hash.new
			# get html tags that are either input or select
			tag = l.node.parent.next_element.css 'input', 'select'
			field_name = tag.attr('name').to_s
			# if the css element is input then the query is a text box, else it is a selection menu
			if tag.to_s.match /<input /
				type = "input"
				queries[l.text] = SearchField.new l.text, field_name, type, options
			else
				# get the options of the selection menu
				tag.css("option").each do |opt|
					options[opt.text] = opt.attr 'value'
				end
				queries[l.text] = SearchField.new l.text, field_name, type, options
			end
		end
		queries
	end
end