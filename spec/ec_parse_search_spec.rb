require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/WebScraping.rb'
require_relative '../OsuJobs/ParseSearch.rb'
require_relative '../OsuJobs/SearchField.rb'

# Constant values
PAGE_URL = "https://www.jobsatosu.com/postings/search"

# Hash of all the options and the values of their attr: values 
POSTED_WITHIN = {
	"Any time period"=>"",
	"Last Day"=>"day",
	"Last Week"=>"week",
	"Last Month"=>"month"
}
LOCATION = {
	"No Selection"=>"any",
	"Columbus"=>"1",
	"Lima"=>"2",
	"Mansfield"=>"3",
	"Marion"=>"4",
	"Newark"=>"5",
	"Wooster"=>"6",
	"Delaware"=>"8",
	"Springfield"=>"9",
	"Piketon"=>"10",
	"Dayton"=>"11",
}
CATEGORY = {
	"No Selection"=>"any",
	"Instructional/Faculty"=>"2",
	"Administrative and Professional"=>"3",
	"Information Technology (IT)"=>"4",
	"Research"=>"5",
	"Civil Service"=>"6",
}
TIME = {
	"No Selection"=>"any",
	"Full-time"=>"4",
	"Part-time"=>"5",
	"Temporary"=>"6",
	"Term"=>"7"
}

# Expected hash result from the parse_page method
EXPECTED = {
		"Keywords"=>SearchField.new("Keywords", "query", "input", {}),
		"Posted Within"=>SearchField.new("Posted Within","query_v0_posted_at_date", "select", POSTED_WITHIN),
		"Location"=>SearchField.new("Location","591[]", "select", LOCATION),
		"Working Title"=>SearchField.new("Working Title", "577", "input", {}),
		"University Title"=>SearchField.new("University Title", "578", "input", {}),
		"Job Opening Number"=>SearchField.new("Job Opening Number", "579", "input", {}),
		"Job Category"=>SearchField.new("Job Category","580[]", "select", CATEGORY),
		"Full/Part Time"=>SearchField.new("Full/Part Time","581[]", "select", TIME)
	}

# Created 2/16/2020 by Ern Chi Khoo
# Edited 2/16/2020 by Ern Chi Khoo: Change result to hash of label=>SearchField object 
# Test case for the parse_search method
describe "ParseSearch Class" do
	context "Checking for correct results" do
		it "should return the correct SearchField objects for each label" do
			agent = WebScraping.new(PAGE_URL)
			search = ParseSearch.new(agent.page)
			search = search.parse_page
			res = EXPECTED
			bool = (
				res["Keywords"].cmp(search["Keywords"]) &&
				res["Posted Within"].cmp(search["Posted Within"]) &&
				res["Location"].cmp(search["Location"]) &&
				res["Working Title"].cmp(search["Working Title"]) &&
				res["University Title"].cmp(search["University Title"]) &&
				res["Job Opening Number"].cmp(search["Job Opening Number"]) &&
				res["Job Category"].cmp(search["Job Category"]) &&
				res["Full/Part Time"].cmp(search["Full/Part Time"])
				)
			expect(bool).to eq(true)
		end
		it "should return all the labels in the page" do
			agent = WebScraping.new(PAGE_URL)
			search = ParseSearch.new(agent.page)
			search = search.parse_page
			expect(search.keys).to eq(EXPECTED.keys)
		end
	end
	context "Checking for false results" do
		it "should return false because there is one missing label" do 
			agent = WebScraping.new(PAGE_URL)
			search = ParseSearch.new(agent.page)
			search = search.parse_page
			res = EXPECTED
			res.delete("Keywords") 
			expect(search.keys).not_to eq(res.keys)		
		end
		it "should return false because there is one missing label" do 
			agent = WebScraping.new(PAGE_URL)
			search = ParseSearch.new(agent.page)
			search = search.parse_page
			res = EXPECTED
			res["Keywords"] = SearchField.new("Keyword", "query", "select", {}) # change an attr in SearchField 
			bool = (
				res["Keywords"].cmp(search["Keywords"]) &&
				res["Posted Within"].cmp(search["Posted Within"]) &&
				res["Location"].cmp(search["Location"]) &&
				res["Working Title"].cmp(search["Working Title"]) &&
				res["University Title"].cmp(search["University Title"]) &&
				res["Job Opening Number"].cmp(search["Job Opening Number"]) &&
				res["Job Category"].cmp(search["Job Category"]) &&
				res["Full/Part Time"].cmp(search["Full/Part Time"])
				)
			expect(bool).to eq(false)		
		end
	end
end