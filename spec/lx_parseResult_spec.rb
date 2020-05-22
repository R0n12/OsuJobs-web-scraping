require 'rspec'
require_relative 'spec_helper.rb'
require_relative '../OsuJobs/ParseResultsData.rb'

# Created by Lang Xu 2/17/2020
# Testing file for parse result
# Edited by Lang Xu 2/18/2020, testing multiple objects into array

describe "parse_result" do
    context "Parsing one job posting contents" do
        it "should initialize a one-object array as it should to the @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect(results.postings.length).to eq(1)
        end

        it "should initialize university title as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].university_title).to eq("Program Manager")
        end

        it "should initialize working title as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].working_title).to eq("Prog Mgr, Multicltrl Inclsn")
        end

        it "should initialize job category as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].job_category).to eq("Administrative and Professional")
        end

        it "should initialize department as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].department).to eq("FCOB UG Stdt Svc-Ldrshp&Engmnt")
        end

        it "should initialize location as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].location).to eq("Columbus")
        end

        it "should initialize full_part_time as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].full_part_time).to eq("Full-time")
        end

        it "should initialize application deadline as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].application_deadline).to eq(Date.new(2020,3,1))
        end

        it "should initialize job number as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].job_number).to eq("457739")
        end

        it "should initialize salary as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].salary).to eq("$48,000.00 - $52,000.00 Annually")
        end

        it "should initialize link as it should to the objects in @postings" do
            results = ParseResultsData.new("https://www.jobsatosu.com/postings/101489")
            results.parse_result results.page
            expect((results.postings)[0].link).to eq("http://www.jobsatosu.com/postings/101443")
        end
    end

end