require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/ParseResultsData.rb'
require_relative '../OsuJobs/JobPosting.rb'

PAGE_URL = "https://www.jobsatosu.com/postings/search"

# Created 2/16/2020 by Juhee Park
describe "filter_due_date" do

	context "Five job posts with different due dates" do
		# Initialize JobPosting objects with different due date attributes
		j1 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "", ""])
		j2 = JobPosting.new(["", "", "", "", "", "", "03/25/2020", "", "", ""])
		j3 = JobPosting.new(["", "", "", "", "", "", "06/30/2020", "", "", ""])
		j4 = JobPosting.new(["", "", "", "", "", "", "11/22/2020", "", "", ""])
		j5 = JobPosting.new(["", "", "", "", "", "", "04/17/2021", "", "", ""])
		# Store objects in array
		postings = [j1, j2, j3, j4, j5]

		it "should return all postings" do
			# Initialize instance of ParseResultsData
			parse_results = ParseResultsData.new(PAGE_URL)
			# Initialize earliest due date
			date = "01/01/2020"

			expect(parse_results.filter_due_date(postings, date)).to eq(postings)
		end

		it "should return three postings" do
			# Initialize instance of ParseResultsData
			parse_results = ParseResultsData.new(PAGE_URL)
			# Initialize earliest due date
			date = "06/30/2020"
			
			expect(parse_results.filter_due_date(postings, date)).to eq([j3, j4, j5])
		end

		it "should return one posting" do
			# Initialize instance of ParseResultsData
			parse_results = ParseResultsData.new(PAGE_URL)
			# Initialize earliest due date
			date = "11/23/2020"
			
			expect(parse_results.filter_due_date(postings, date)).to eq([j5])
		end

		it "should return no postings" do
			# Initialize instance of ParseResultsData
			parse_results = ParseResultsData.new(PAGE_URL)
			# Initialize earliest due date
			date = "01/01/2023"
			
			expect(parse_results.filter_due_date(postings, date)).to eq([])
		end
	end

end