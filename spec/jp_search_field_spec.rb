require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/SearchField.rb'

PAGE_URL = "https://www.jobsatosu.com/postings/search"

# Created 2/18/2020 by Juhee Park
describe "SearchField class" do

	context "Initialize" do

		it "should initialize Favorite animal searchField" do
			# Initialize SearchField
			f1 = SearchField.new("Favorite animal", "123[]", "select", {"dog"=>0, "cat"=>10})
			
			expect(f1.label).to eq("Favorite animal")
			expect(f1.name).to eq("123[]")
			expect(f1.type).to eq("select")
			expect(f1.options).to eq({"dog"=>0, "cat"=>10})

		end


	end

	context "cmp method" do

		f1 = SearchField.new("Favorite animal", "123[]", "select", {"dog"=>0, "cat"=>10})

		it "should return false, different label" do

			expect(f1.cmp(SearchField.new("Wrong", "query", "input", {}))).to be_falsy

		end
		it "should return false, different name" do

			expect(f1.cmp(SearchField.new("Keyword", "wrong", "input", {}))).to be_falsy

		end

		it "should return false, different name" do

			expect(f1.cmp(SearchField.new("Keyword", "query", "wrong", {}))).to be_falsy

		end

		it "should return false, different name" do

			expect(f1.cmp(SearchField.new("Keyword", "query", "input", {"dog"=>0}))).to be_falsy

		end

		it "should return true" do
			expect(f1.cmp(SearchField.new("Favorite animal", "123[]", "select", {"dog"=>0, "cat"=>10}))).to be_truthy

		end

	end
end