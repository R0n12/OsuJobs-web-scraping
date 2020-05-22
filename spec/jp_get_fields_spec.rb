require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/WebScraping.rb'


# Created 2/16/2020 by Juhee Park
describe "get_fields" do

	# Test case for html with no search fields
	context "Webpage with no search fields" do
		it "should return empty hash" do
			
			html_dir = File.dirname(__FILE__)
    		web = WebScraping.new("file:///#{html_dir}/noSearch.html")

			fields = web.get_fields
			expect(fields).to eq(Hash.new)
		end
	end

	#Test case for html with one search field
	context "Webpage with one search field" do
		it "should return hash with one key-value pair" do
			
			expected = {"Keywords"=>"query"}

			html_dir = File.dirname(__FILE__)
    		web = WebScraping.new("file:///#{html_dir}/oneSearchField.html")

			fields = web.get_fields
			expect(fields).to eq(expected)
		end
	end

	# Test case for webpage with all original search fields
	context "Webpage with all search fields" do
		it "should return an hash with eight field labels and names" do

			expected = {"Keywords"=>"query", "Posted Within"=>"query_v0_posted_at_date", "Location"=>"591[]", "Working Title"=>"577", "University Title"=>"578", "Job Opening Number"=>"579", "Job Category"=>"580[]", "Full/Part Time"=>"581[]"}

			html_dir = File.dirname(__FILE__)
    		web = WebScraping.new("file:///#{html_dir}/fullSearchAndResultsPage.html")

			fields = web.get_fields
			expect(fields).to eq(expected)
		end
	end
end