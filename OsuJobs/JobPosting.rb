#Created by Lang Xu 2/16/2020
#Class for Job Posting

require 'date'

class JobPosting

    #attribute readers
    attr_reader :university_title, :working_title, :job_category, :department, :location, :full_part_time, :application_deadline, :job_number, :salary, :link

    # Initialize the class with university_title, working_title, job_category, department, location, full_part_time, application_deadline, job_number, salary and link
    # Passed in as an array and access information using indexing
    # Edited by Lang Xu, on 2/17/2020, changed implementation for creating data object
    # Edited by Lang Xu, on 2/17/2020, added conversion to string for each attribute in the array
 def initialize( job_info_array )
     
     @university_title = job_info_array[0].to_s

     @working_title = job_info_array[1].to_s

     @job_category = job_info_array[2].to_s

     @department = job_info_array[3].to_s

     @location = job_info_array[4].to_s

     @full_part_time = job_info_array[5].to_s

     @application_deadline = Date.strptime(job_info_array[6].to_s,'%m/%d/%Y')

     @job_number = job_info_array[7].to_s

     @salary = job_info_array[8].to_s

     @link = job_info_array[9].to_s
 end

end