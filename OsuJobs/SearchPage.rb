require 'fox16'
include Fox
require_relative 'WebScraping.rb'
require_relative 'ParseSearch.rb'
require_relative 'ParseResultsData.rb'

PAGE_URL = "https://www.jobsatosu.com/postings/search"

# File Created 2/17/2020 by Ern Chi Khoo

# Make SearchPage a subclass of fxruby's FXMainWindow class 
class SearchPage < FXMainWindow

=begin
	Created 2/17/2020 by Ern Chi Khoo
	Edited 2/18/2020 by Juhee Park: fixed bugs with using SearchField objects
	Edited 2/18/2020 by Jas Bawa: Added Salary filter feature
	Edited 2/18/2020 by Lang Xu: adjusted to appropriate height
	Edited 2/19/2020 by Juhee Park: Added call to make_query and fixed bugs
	Edited 2/19/2020 by Daniel Lim: Added alphabetize and comments to code
	Parameters: app => FXApp object, queries => hash of the queries and their input options
=end
  	def initialize(app)
  		@search_page = super app, "OSU Jobs Search" , :width => 800, :height => 450

  		# create new web scraper and parse search queries 
		agent = WebScraping.new PAGE_URL
		parse = ParseSearch.new agent.page
		# parse search page
		queries = parse.parse_page
		#puts queries.inspect

	    # create a horizontal frame for each text or query
	    hFrame1 = FXHorizontalFrame.new self
	    label1 = FXLabel.new hFrame1, "OSU Job Postings Site. Enter a search criteria to view available job postings."
	    # get an array of all the keys in the hash 
	    keys = queries.keys
	    fields = Hash.new
	    keys.each do |k|
	    	hFrame = FXHorizontalFrame.new self
	    	label = FXLabel.new hFrame, k
	    	# if the value of the key is an empty string, it is text input
	    	if queries[k].type == "input"
	    		fields[k] = FXTextField.new hFrame, 20
	    	else 
	    		fields[k] = FXListBox.new hFrame
	    		fields[k].numVisible = queries[k].options.size
	    		# place every option into drop down list
	    		queries[k].options.each_key do |opt|
	    			fields[k].appendItem opt
	    		end
	    	end
	    end
	    # create new horizontal frame for sorting
	   	hFrame3 = FXHorizontalFrame.new self
    	alph_check = FXCheckButton.new hFrame3, "Sort Each Page Alphabetically"
	   	hFrame4 = FXHorizontalFrame.new self
	   	# creates textbox for date
	   	due_date = FXLabel.new hFrame4, "Earliest application deadline (mm/dd/yyyy)"
		date = FXTextField.new hFrame4, 20
			hFrame5 = FXHorizontalFrame.new self
			FXLabel.new hFrame5, "Salary Preference"
			salary_dropdown = FXListBox.new(hFrame5)
			salary_dropdown.numVisible = 3
			salary_dropdown.appendItem "All"
			salary_dropdown.appendItem "Salaried"
			salary_dropdown.appendItem "Waged"
	    hFrame2 = FXHorizontalFrame.new self
	    button = FXButton.new hFrame2, "Search"
	    # when user clicks on button
	    button.connect(SEL_COMMAND) do
			#puts salary_dropdown.currentItem.to_s
			make_query app, agent, fields, date, alph_check.checked?, salary_dropdown.currentItem
	    end
	end

=begin
	Created 2/18/2020 by Juhee Park
	Edited on 2/18/2020 by Jas Bawa: Added salary filter feature
	Edited on 2/19/2020 by Juhee Park: Added due date filter feature, and call display_window method
	Edited on 2/19/2020 by Juhee Park: fix bugs
	Calls the methods to make query and open window for results
=end
	def make_query (app, agent, fields, date, alph_check, salary_choice)
		# store search criteria in hash with field label and input
		input = Hash.new
		fields.each do |label, field|
			if field.class == Fox::FXTextField
				input[label] = field.text
			else
				input[label] = field.getItemText field.currentItem
			end
		end

		result_page = ParseResultsData.new agent.search(input).uri.to_s
		result_page.parse_all_results

		if date.text.match /(0?[1-9]|1[012])[-\/](0?[1-9]|[12][0-9]|3[01])[-\/]\d{4}/
			result_page.filter_due_date date.text
		end

		if alph_check
			result_page.alpha_sort
		end
		if salary_choice > 0
			result_page.salary_filter salary_choice
		end

		window = setup_display result_page, date, alph_check, salary_choice
		# open the new table window
		window.create
		window.show
	end

=begin
	Created 2/19/2020 by Lang Xu
	Edited 2/19/2020 by Lang Xu, copied initialization results method from previous ResultPage.rb
	Edited 2/19/2020 by Juhee Park: fix bugs so that table is displayed
	Sets up the new window for displaying results
=end	
	def setup_display(parse, date, alph_check, salary_choice)
		display_window = FXMainWindow.new app,"Search Results", :width => 1800, :height => 900
	    
		hframe = FXHorizontalFrame.new display_window
		prev_button = FXButton.new hframe, "prev"
		next_button = FXButton.new hframe, "next"

		# if no prev/next page, disable corresponding button
		if parse.prev_disable
			prev_button.disable
		else
			prev_button.enable
		end
		if parse.next_disable
			next_button.disable
		else
			next_button.enable
		end

		# initialize table general
		table = FXTable.new display_window, :opts => LAYOUT_FILL|TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE|TABLE_READONLY

		# when user clicks on button
		prev_button.connect(SEL_COMMAND) do
			parse.previous_page
			parse.parse_all_results
			if date.text.match /(0?[1-9]|1[012])[-\/](0?[1-9]|[12][0-9]|3[01])[-\/]\d{4}/
	      		parse.filter_due_date date.text
			end
			if alph_check
				parse.alpha_sort
			end
			if salary_choice > 0
				parse.salary_filter salary_choice
			end
			
			update_display parse, display_window, table, next_button, prev_button
		end

		next_button.connect(SEL_COMMAND) do
			parse.next_page
			parse.parse_all_results
			if date.text.match /(0?[1-9]|1[012])[-\/](0?[1-9]|[12][0-9]|3[01])[-\/]\d{4}/
	      		parse.filter_due_date date.text
			end
			if alph_check
				parse.alpha_sort
			end
			if salary_choice > 0
				parse.salary_filter salary_choice
			end
			update_display parse, display_window, table, next_button, prev_button
		end

		update_display parse, display_window, table, next_button, prev_button

		display_window
	end

=begin
    Created 2/19/2020 by Lang Xu, Juhee Park: code mostly moved from Lang's setup_display method
    Updates the results display with new page of job posts.
=end
	def update_display(parse, display_window, table, next_button, prev_button)
		# if no prev/next page, disable corresponding button
		if parse.prev_disable
			prev_button.disable
		else
			prev_button.enable
		end
		if parse.next_disable
			next_button.disable
		else
			next_button.enable
		end

		job_array = parse.postings

		table.clearItems
		# set table size including columns
		table.setTableSize job_array.length, 10
		for j in 0..9 do
			table.setColumnWidth j, 200
			table.setColumnJustify j,FXHeaderItem::CENTER_X
			table.setColumnJustify j,FXHeaderItem::CENTER_Y
		end

		# mark out row headers
		table.rowHeaderMode = LAYOUT_FIX_WIDTH
		table.rowHeaderWidth = 0
		table.columnHeaderHeight = 50

		# set header contents
		table.setColumnText 0, "University Title"
		table.setColumnText 1, "Working Title"
		table.setColumnText 2, "Job Category"
		table.setColumnText 3, "Department"
		table.setColumnText 4, "Location"
		table.setColumnText 5, "Full/Part\nTime"
		table.setColumnText 6, "App\nDue Date"
		table.setColumnText 7, "Job \#"
		table.setColumnText 8, "Salary"
		table.setColumnText 9, "Link"
	      
		# specify each row
		for r in 0..job_array.length-1 do
			table.setItemText r,0,job_array[r].university_title
			table.setItemText r,1,job_array[r].working_title
			table.setItemText r,2,job_array[r].job_category
			table.setItemText r,3,job_array[r].department
			table.setItemText r,4,job_array[r].location
			table.setItemText r,5,job_array[r].full_part_time
			table.setItemText r,6,job_array[r].application_deadline.strftime("%m/%d/%Y")
			table.setItemText r,7,job_array[r].job_number
			table.setItemText r,8,job_array[r].salary
			table.setItemText r,9,job_array[r].link

			# format each row
			for i in 0..9 do
				table.setItemJustify r, i, FXTableItem::CENTER_X
				table.setItemJustify r, i, FXTableItem::CENTER_Y
			end
		end

		# format row and column spacing for readability
		table.fitColumnsToContents 0, table.numColumns

		for r in 0...table.numRows
			table.setRowHeight r, table.getRowHeight(r) + 20
		end
		for c in 0..9
			w = 30
			if job_array.length == 0
				w = 150
			end
			table.setColumnWidth c, table.getColumnWidth(c) + w
		end
    	
	end


    # Created 2/17/2020 by Ern Chi Khoo
	def create
		super
		show PLACEMENT_SCREEN
	end
end


# create GUI
app = FXApp.new
SearchPage.new app
app.create
app.run