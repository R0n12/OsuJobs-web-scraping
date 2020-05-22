require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/ParseResultsData.rb'
require_relative '../OsuJobs/JobPosting.rb'

# Created 2/16/2020 by Ern Chi Khoo
# Edited 2/18/2020 by Daniel Lim: wrote the test cases
# Test case for the alpha_sort method in ParseResultsData class
describe "alpha_sort method in ParseResultsData class" do
	last = JobPosting.new(["university title", "working title", "job category", "department", "location", "full/part-time", "03/01/2019","10000", "20k-30k","link"])
	first = JobPosting.new(["college title", "working title","job category", "department", "location", "full/part-time", "03/01/2019","10000", "20k-30k","link"])
	middle = JobPosting.new(["institution title", "working title", "job category", "department", "location", "full/part-time", "03/01/2019","10000", "20k-30k","link"])

	# page with one job posting should return the same array
	context "with one job posting" do
		it "should return an array with the job post" do
      		results = ParseResultsData.new("https://www.jobsatosu.com/postings/search")
      		expected_array = [last]
   	     	sorted = results.alpha_sort(expected_array)
	     	expect(expected_array.to_s).to eq(sorted.to_s)
		end
	end

	# page with two job posting should return the sorted array
	context "with two job postings" do
		it "should return an array with the job post" do
      		results = ParseResultsData.new("https://www.jobsatosu.com/postings/search")
      		test_array = [last ,first]
   	     	sorted_array = results.alpha_sort(test_array)
   	     	expected_array = [first, last]
	     	expect(expected_array.to_s).to eq(sorted_array.to_s)
		end
	end

	# page with three job posting should return the sorted array
	context "with three job postings" do
		it "should return an array with the job post" do
      		results = ParseResultsData.new("https://www.jobsatosu.com/postings/search")
      		test_array = [last, middle,first]
   	     	sorted_array = results.alpha_sort(test_array)
   	     	expected_array = [first, middle, last]
	     	expect(expected_array.to_s).to eq(sorted_array.to_s)
		end
	end
end
