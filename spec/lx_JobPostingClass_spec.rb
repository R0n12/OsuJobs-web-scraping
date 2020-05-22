require 'rspec'
require_relative '../OsuJobs/JobPosting.rb'

#Created by Lang Xu on 2/17/2020
#Testing for JobPosting class
describe "JobPosting Class" do

    let (:test_array) {["university title", "working title", 
        "job category", "department", 
        "location", "full/part-time", 
        "03/01/2019","10000", "20k-30k",
        "link"]}

    context "Initializing using an array" do
        it "should initialize university title as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.university_title).to eq(test_array[0])
        end

        it "should initialize working title as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.working_title).to eq(test_array[1])
        end

        it "should initialize job category as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.job_category).to eq(test_array[2])
        end

        it "should initialize department as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.department).to eq(test_array[3])
        end

        it "should initialize location as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.location).to eq(test_array[4])
        end

        it "should initialize full_part_time as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.full_part_time).to eq(test_array[5])
        end

        it "should initialize application deadline as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.application_deadline).to eq(Date.strptime(test_array[6],'%m/%d/%Y'))
        end

        it "should initialize job number as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.job_number).to eq(test_array[7])
        end

        it "should initialize salary as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.salary).to eq(test_array[8])
        end

        it "should initialize link as it should in the array" do
            test_JobPosting = JobPosting.new test_array
            expect(test_JobPosting.link).to eq(test_array[9])
        end
    end

end