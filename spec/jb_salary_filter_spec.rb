require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/ParseResultsData.rb'
require_relative '../OsuJobs/JobPosting.rb'

PAGE_URL = "https://www.jobsatosu.com/postings/search"

# Created 2/18/2020 by Jas Bawa
# Edited 2/19/2020 by Jas Bawa to update test cases based on updated code
# ATTN: To successfully test the salary filter, you must make @postings an attr_accessor, but change it back after testing
describe "salary filter" do

  context "Given 5 job posts with varying salary" do

    it "should return 2 postings when the user wants salaried salary" do
      # Initialize JobPosting objects with different salary attributes
      j1 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$13.50 - $15.00 Hourly", ""])
      j2 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$95,000.00 - $110,000.00 Annually", ""])
      j3 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$16.00 - $19.63 Hourly", ""])
      j4 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$11.10 - $13.00 Hourly", ""])
      j5 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$53,000.00 - $59,000.00 Annually", ""])
      # Store objects in array
      postings = [j1, j2, j3, j4, j5]
      # Initialize instance of ParseResultsData
      parse_results = ParseResultsData.new(PAGE_URL)
      parse_results.postings = postings
      # Initialize salaried filter value
      salary_filter_value = 1

      parse_results.salary_filter(salary_filter_value)

      expect(parse_results.postings).to eq([j2, j5])
    end

    it "should return 3 postings when the user wants waged salary" do
      # Initialize JobPosting objects with different salary attributes
      j1 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$13.50 - $15.00 Hourly", ""])
      j2 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$95,000.00 - $110,000.00 Annually", ""])
      j3 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$16.00 - $19.63 Hourly", ""])
      j4 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$11.10 - $13.00 Hourly", ""])
      j5 = JobPosting.new(["", "", "", "", "", "", "01/01/2020", "", "$53,000.00 - $59,000.00 Annually", ""])
      # Store objects in array
      postings = [j1, j2, j3, j4, j5]
      # Initialize instance of ParseResultsData
      parse_results = ParseResultsData.new(PAGE_URL)
      parse_results.postings = postings
      # Initialize waged filter value
      salary_filter_value = 2
      parse_results.salary_filter(salary_filter_value)
      expect(parse_results.postings).to eq([j1, j3, j4])
    end
  end
end
