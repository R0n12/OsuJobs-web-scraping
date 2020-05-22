require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/ParseResultsData.rb'

# 6 pages
TF = "https://www.jobsatosu.com/postings/search"
FT = "https://www.jobsatosu.com/postings/search?page=6"
FF = "https://www.jobsatosu.com/postings/search?page=3"
TT = "https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=job&query_v0_posted_at_date=&577=&578=&579=&commit=Search"

# Created 2/19/2020 by Juhee Park
describe "prev and next page button disable" do

	context "Div pagination class tag exists" do
		it "should return true for prev and false for next" do
			# Initialize instance of ParseResultsData
			parse_results = ParseResultsData.new(TF)
			
			expect(parse_results.prev_disable).to be true
			expect(parse_results.next_disable).to be false
		end

		it "should return false for prev and true for next" do
			# Initialize instance of ParseResultsData
			parse_results = ParseResultsData.new(FT)
			
			expect(parse_results.prev_disable).to be false
			expect(parse_results.next_disable).to be true
		end

		it "should return true for prev and true for next" do
			# Initialize instance of ParseResultsData
			parse_results = ParseResultsData.new(FF)
			
			expect(parse_results.prev_disable).to be false
			expect(parse_results.next_disable).to be false
		end
	end

	context "Div pagination class tag does not exist" do

		it "should return false for prev and false for next" do
			# Initialize instance of ParseResultsData
			parse_results = ParseResultsData.new(TT)
			
			expect(parse_results.prev_disable).to be true
			expect(parse_results.next_disable).to be true
		end

	end

end