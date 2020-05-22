# Web Scraping - Project 3
# Author: Jas Bawa, Lang Xu, Juhee Park, Ern Chi Khoo, Daniel Lim

# File created 2/13/2020 by Juhee Park

require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'open-uri'
require_relative 'ParseSearch.rb'
require_relative 'SearchField.rb'

# Created 2/13/2020 by Juhee Park
class WebScraping

	attr_accessor :page, :agent


	# Created 2/13/2020 by Juhee Park
	def initialize (url)
		# get page
		@agent = Mechanize.new

		@page = @agent.get url

		# test
		# puts get_fields.to_s
	end

=begin
	Makes a query based on user's input.
	Parameter input should be a hash, key values is field label, which
	identifies which input field, and value is user input for that field
	Created 2/14/2020 by Juhee Park
	Edited 2/16/2020 by Juhee Park: get form, added comments, call get_fields
	Edited 2/18/2020 by Juhee Park: integrate SearchField class
=end
	def search(input)
		# Get form (search fields)
		form = @page.forms[0]
		parse = ParseSearch.new @page
		# Get hash of labels and SearchField objects
		all_fields = parse.parse_page
		input.each_key do |fld|
			# If user input is not empty, update search field value
			if input.fetch fld
				search_field = all_fields.fetch fld
				value = input.fetch fld
				if search_field.type == "select"
					value = search_field.options.fetch value
				end
				form[search_field.name] = value
			end
		end
		form["commit"] = "Search"
		# Click search to make query. @page is updated.
		form.submit
	end
end

