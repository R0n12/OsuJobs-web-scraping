require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/WebScraping.rb'

PAGE_URL = "https://www.jobsatosu.com/postings/search"

# Created 2/17/2020 by Juhee Park
describe "search" do

	# Test cases for no input searches
	context "No input" do
		it "should update page url to show all field names with no value" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=&579=&commit=Search")
		end
	end

	context "Keyword searches" do
		# input is one word
		it "should update page url to query = manager" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Keywords"=>"manager"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=manager&query_v0_posted_at_date=&577=&578=&579=&commit=Search")
		end
		# input is multiple words
		it "should update page url to query = market manager" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Keywords"=>"market manager"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=market+manager&query_v0_posted_at_date=&577=&578=&579=&commit=Search")
		end
	end

	context "Posted within searches" do
		
		it "should get entries posted within last day" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Posted Within"=>"Last Day"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=day&577=&578=&579=&commit=Search")
		end

		it "should get entries posted within last week" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Posted Within"=>"Last Week"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=week&577=&578=&579=&commit=Search")
		end

		it "should get entries posted within last week" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Posted Within"=>"Last Month"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=month&577=&578=&579=&commit=Search")
		end
	end

	context "Location searches" do
		
		it "should get jobs in Columbus" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Location"=>"Columbus"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&591%5B%5D=1&577=&578=&579=&commit=Search")
		end

		it "should get jobs in Lima" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Location"=>"Lima"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&591%5B%5D=2&577=&578=&579=&commit=Search")
		end

		it "should get jobs in Mansfield" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Location"=>"Mansfield"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&591%5B%5D=3&577=&578=&579=&commit=Search")
		end
	end

	context "Working title searches" do
		
		it "should get jobs with manager in working title" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Working Title"=>"manager"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=manager&578=&579=&commit=Search")
		end

		it "should get jobs with counselor in working title" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Working Title"=>"counselor"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=counselor&578=&579=&commit=Search")
		end
	end

	context "University title searches" do
		
		it "should get jobs with manager in university title" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"University Title"=>"manager"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=manager&579=&commit=Search")
		end

		it "should get jobs with counselor in university title" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"University Title"=>"counselor"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=counselor&579=&commit=Search")
		end
	end

	context "Job opening number searches" do
		
		it "should get job with opening number 457736" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Job Opening Number"=>"457736"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=&579=457736&commit=Search")
		end

		it "should get job with opening number 454393" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Job Opening Number"=>"454393"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=&579=454393&commit=Search")
		end
	end

	context "Job category searches" do
		
		it "should get jobs in Instructional/Faculty category" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Job Category"=>"Instructional/Faculty"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=&579=&580%5B%5D=2&commit=Search")
		end

		it "should get jobs in Information Technology (IT) category" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Job Category"=>"Information Technology (IT)"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=&579=&580%5B%5D=4&commit=Search")
		end
	end

	context "Full/part time searches" do
		
		it "should get full time jobs" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Full/Part Time"=>"Full-time"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=&579=&581%5B%5D=4&commit=Search")
		end

		it "should get temporary jobs" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Full/Part Time"=>"Temporary"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&577=&578=&579=&581%5B%5D=6&commit=Search")
		end
	end

	context "Combination of different queries" do
		
		it "should get full-time jobs with keyword post in Marion" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Full/Part Time"=>"Full-time", "Keywords"=>"post", "Location"=>"Marion"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=post&query_v0_posted_at_date=&591%5B%5D=4&577=&578=&579=&581%5B%5D=4&commit=Search")
		end

		it "should get jobs with assistant working title in Research category posted within last month" do
			
    		web = WebScraping.new(PAGE_URL)

			input = {"Working Title"=>"assistant", "Job Category"=>"Research", "Posted Within"=>"Last Month"}
			results = web.search input
			expect(results.uri.to_s).to eq("https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=month&577=assistant&578=&579=&580%5B%5D=5&commit=Search")
		end
	end
end