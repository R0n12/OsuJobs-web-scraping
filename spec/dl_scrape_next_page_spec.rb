require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/ParseResultsData.rb'


# Created 2/3/2020 by Daniel Lim
# Edited 2/19/2020 by Daniel Lim: change the class name
describe "next page" do

	# Test case for the first page
	context "Webpage on the first page" do
		it "should return /postings/search?page=2 at the end" do

			html_dir = File.dirname(__FILE__)
    		web = ParseResultsData.new("file:///#{html_dir}/noSearch.html")
			web.next_page
			expect("https://www.jobsatosu.com/postings/search?page=2").to eq(web.page.uri.to_s)
		end
	end

	#Test case for using next on the last page
	context "Webpage on the last page" do
		it "should return the same url" do
			
			html_dir = File.dirname(__FILE__)
    		web = ParseResultsData.new("file:///#{html_dir}/noSearch.html")
			web.last_page			
			web.next_page
			expect("https://www.jobsatosu.com/postings/search?page=6").to eq(web.page.uri.to_s)

		end
	end

	#Test case for using the next twice
	context "Webpage on the last page" do
		it "should return the same url" do
			
			html_dir = File.dirname(__FILE__)
    		web = ParseResultsData.new("file:///#{html_dir}/noSearch.html")
			web.next_page
			web.next_page
			expect("https://www.jobsatosu.com/postings/search?page=3").to eq(web.page.uri.to_s)

		end
	end

end