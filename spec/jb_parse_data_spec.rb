require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/ParseResultsData.rb'

# Created 2/16/2020 by Jas Bawa
describe "parse_all_results" do

  context "A sample test file with no results" do

    it 'should return an empty array' do
      results = ParseResultsData.new("file://noPostingsSearchAndResultsPage.html")
      links = results.parse_all_results
      expect(links.to_s).to eq("[]")
    end
  end

  context "A sample test file with a set number of results" do

    it 'should return an array with one element with one post' do
      html_dir = File.dirname(__FILE__)
      results = ParseResultsData.new("file:///#{html_dir}/onePostingsSearchAndResultsPage.html")

      links = results.parse_all_results
      expected_array = Array.new
      expected_array.push("<a href=\"/postings/101489\">Program Manager</a>")
      expect(links.to_s).to eq(expected_array.to_s)
    end

    it 'should return an array with two elements with two post' do
      html_dir = File.dirname(__FILE__)
      results = ParseResultsData.new("file:///#{html_dir}/twoPostingsSearchAndResultsPage.html")

      links = results.parse_all_results
      expected_array = Array.new
      expected_array.push("<a href=\"/postings/101489\">Program Manager</a>")
      expected_array.push("<a href=\"/postings/101488\">Post Doctoral Scholar</a>")
      expect(links.to_s).to eq(expected_array.to_s)
    end

    it 'should return an array with 30 elements with 30 post' do
      html_dir = File.dirname(__FILE__)
      results = ParseResultsData.new("file:///#{html_dir}/fullSearchAndResultsPage.html")

      links = results.parse_all_results
      expect(links.length).to eq(30)
    end

  end
end