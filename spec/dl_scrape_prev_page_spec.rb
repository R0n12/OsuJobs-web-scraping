require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/ParseResultsData.rb'


# Created 2/3/2020 by Daniel Lim
# Edited 2/19/2020 by Daniel Lim: change the class name
describe "prev page" do
	
	#Test case for using prev on the last page
	context "Webpage on the last page" do
		it "should return the one before url" do
			
			html_dir = File.dirname(__FILE__)
    		web = ParseResultsData.new("file:///#{html_dir}/noSearch.html")
			# Card with the default values
			web.last_page			
			web.previous_page
			expect("https://www.jobsatosu.com/postings/search?page=5").to eq(web.page.uri.to_s)

		end
	end

	#Test case for using the prev twice on last page
	context "Webpage on the last page twice" do
		it "should return the two before url" do
			
			html_dir = File.dirname(__FILE__)
    		web = ParseResultsData.new("file:///#{html_dir}/noSearch.html")

			web.last_page			
			web.previous_page
			web.previous_page
			expect("https://www.jobsatosu.com/postings/search?page=4").to eq(web.page.uri.to_s)

		end
	end

end