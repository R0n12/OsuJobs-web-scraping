require 'nokogiri'
require 'mechanize'
require 'rubygems'
require 'open-uri'
require_relative 'WebScraping.rb'
require_relative 'JobPosting.rb'

# File created 2/14/2020 by Jas Bawa

=begin
 Class ParseResultData initialized 2/14/2020 by Jas Bawa
 Edited by Lang Xu, Created class variables to print out progress messages
=end
class ParseResultsData
  
  @@page_num = 1
  # Edited by Lang Xu 2/17/2020
  # attribute getters for testings
  attr_reader :scraper
  attr_accessor :page

  # Postings is made an attr_accessor for easier unit testing, but attr_reader for deployment
  attr_reader :postings
  # attr_accessor :postings

  # Created 2/14/2020 by Jas Bawa
  def initialize(url)
    @scraper = WebScraping.new url
    @page = scraper.page
    @postings = Array.new
  end

=begin
  Created 2/14/2020 by Jas Bawa
  Edited 2/17/2020 by Jas Bawa to add more comments and documentation
  Edited 2/19/2020 by Jas Bawa to add pagination capabilities and fixed assumptions made for regexp
  Using the mechanize page variable, a list of links to each job page on the results page is made
=end
  def parse_all_results
    @postings = Array.new
    posting_link = Array.new

    # Gets the div that contains all of the postings in the results
    search_results = @page.css("div#search_results").to_s
    #puts search_results
    # Uses a regex to find a link to every posting, assuming they follow the standard and the numbers are 6 digits
    new_posting_link = search_results.scan(/<a href="\/postings\/\d{6}">.+<\/a>/)
    posting_link = posting_link + new_posting_link
    #puts posting_link
    # Goes through each link, creates an instance of the result page to scrape and passes it to the parse_result method
    posting_link.each do |link|
      posting_page_scraper = WebScraping.new("https://www.jobsatosu.com/postings/" + link[18..25])
      parse_result posting_page_scraper.page
    end
  end

=begin
  Created 2/14/2020 by Jas Bawa
  Edited 2/17/2020 by Daniel Lim and Lang Xu: parse the result table
  Edited 2/17/2020 by Jas Bawa to follow some ruby conventions
  Edited 2/17/2020 by Lang Xu, include JobPosting initialization
  Edited 2/17/2020 by Lang Xu, deleted extra 3 arguments for importing date
  Edited 2/17/2020 by Lang Xu, documentation added
  Edited 2/17/2020 by Daniel Lim: fixed the method
  Ediyed 2/20/2020 by Jas Bawa: Removed extra paranthesis
=end
  def parse_result (posting_page)

    # grabs the whole table html
    table = posting_page.xpath("//table").first
    #puts table


    # grabs the whole table tr/th
    header = table.xpath "tr/th"
    headers = []
    header.each do |head|
      headers.push head.text
    end

    # grabs the whole table tr/td
    result = table.xpath "tr/td"
    results = []
    result.each do |result|
      results.push result.text
    end
    i = 0
    attribute_array = Array.new
    # Go through all array and checks if it a header that we need
    headers.each do |th|
      # checks and store in new array
      case th
        # assign the data into attribute array
        when "University Title"
          attribute_array[0] = results[i].to_s
        when "Working Title"
          attribute_array[1] = results[i].to_s
         when "Job Category"
          attribute_array[2] = results[i].to_s
        when "Department"
          attribute_array[3] = results[i].to_s
        when "Department Location"
          attribute_array[4] = results[i].to_s
        when "Full/Part Time"
          attribute_array[5] = results[i].to_s
        when "Posting End Date"
          attribute_array[6] = results[i].to_s 
        when "Requisition Number"
          attribute_array[7] = results[i].to_s
        when "Target Salary"
          attribute_array[8] = results[i].to_s
        when "Quick Link"
          attribute_array[9] = results[i].to_s
      end
      i += 1
    end
    # create JobPosting project into object array
    @postings.push(JobPosting.new attribute_array)

  end

=begin
  Created 2/16/2020 by Daniel Lim
  Edited 2/18/2020 by Juhee Park: use @postings instead of parameter
  Sorts the job postings in alphabetical order
=end
  def alpha_sort
    # sorts the list of jobs by the university title of the job 
    @postings.sort_by! { |post| post.university_title.to_s } 
  end

=begin
  Created 2/18/2020 by Jas Bawa
  Edited 2/18/2020 by Juhee Park: use @postings instead of parameter
  Edited 2/20/2020 by Juhee Park: Removed extra paranthesis
  Function goes through all postings and takes out whatever doesn't follow the filter
=end
  def salary_filter(salary_choice)
    updated_job_list = Array.new
    # Checks for different text based on filter, goes through every posting and adds it to a temp array if it matches filter
    if salary_choice == 1
      @postings.each do |job|
        if job.salary.include? "Annually"
          updated_job_list.push job
        end
      end
    else
      @postings.each do |job|
        if job.salary.include? "Hourly"
          updated_job_list.push job
        end
      end
    end
    # Updates postings to whatever has passed the filter
    @postings = updated_job_list
  end

=begin

  Filters results array for job posts whose apps are due after the
  date given by user_date (String format mm/dd/yyyy).

  Created 2/16/2020 by Juhee Park
  Edited 2/18/2020 by Juhee Park: change number and type of parameter for date input
  Edited 2/18/2020 by Juhee Park: use @postings instead of parameter
  Edited 2/20/2020 by Juhee Park: Removed extra paranthesis

=end
  def filter_due_date (user_date)
    # Create date object from user input
    earliest = Date.strptime user_date, '%m/%d/%Y'
    # Array to store filtered results
    filtered = Array.new
    @postings.each do |job|
      # Only include jobs with due dates on or after earliest
      if (job.application_deadline <=> earliest) >= 0
        filtered.push job
      end
    end
    @postings = filtered
  end

=begin
  Created 2/15/2020 by Daniel Lim
  Scrape next page
  Edited 2/16/2020 by Daniel Lim: get the next page for all searches
  Moved 2/19/2020 by Juhee Park from WebScraping.rb to here
=end
  def next_page
    if link = @page.at('[rel=next]')
        @page = @scraper.agent.get ("https://www.jobsatosu.com"+link[:href])
    end
    @page
  end

=begin
  Created 2/16/2020 by Daniel Lim
  Scrape previous page
  Edited 2/16/2020 by Daniel Lim: get the previous page for all searches
  Moved 2/19/2020 by Juhee Park from WebScraping.rb to here
=end
  def previous_page
    if link = @page.at('[rel=prev]')
        @page = @scraper.agent.get ("https://www.jobsatosu.com"+link[:href])
    end
    @page
  end

=begin
  Created 2/16/2020 by Daniel Lim
  Scrape previous page
  Edited 2/16/2020 by Daniel Lim: get the last page for testing
  Moved 2/19/2020 by Juhee Park from WebScraping.rb to here
=end
  def last_page
    while link = @page.at('[rel=next]')
      @page = @scraper.agent.get ("https://www.jobsatosu.com"+link[:href])
    end
    @page
  end

=begin
  Created 2/19/2020 by Juhee Park
  returns true if prev button should be disabled, false if enabled
=end
  def prev_disable
    !(@page.css("div#content_inner").to_s.include? "<div class=\"pagination\">") || (@page.css("div#content_inner").to_s.include? "<span class=\"previous_page disabled\">")
  end

=begin
  Created 2/19/2020 by Juhee Park
  returns true if next button should be disabled, false if enabled
=end
  def next_disable
    !(@page.css("div#content_inner").to_s.include? "<div class=\"pagination\">") || (@page.css("div#content_inner").to_s.include? "<span class=\"next_page disabled\">")
  end

end