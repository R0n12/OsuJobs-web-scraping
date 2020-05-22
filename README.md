# OSUJobs-Scraping
### Goal
Our goal in this project was to allow users to search the jobsatosu.com website and allow them to have additional search criteria and see relevant information of each job post without having to individually click on each link. After the user makes a query, for each page of the results that is scraped, there will be maximum of 30 individual job post pages that are scraped for information. 
### Running the program 
1. Install FXRuby. Go to https://www.rubydoc.info/gems/fxruby for installation instructions.
2. In the terminal, go to the Project-3-Groovy-Ruby/OsuJobs directory.
3. Run the command 'ruby SearchPage.rb'
### Testing instructions
1. In the terminal, go to the Project-3-Groovy-Ruby directory. You must be in this directory. 
2. Run the command 'rspec spec/test_file_spec.rb' for each test file.
### Roles
* Overall Project Manager: Ern Chi Khoo
* Coding Manager: Juhee Park
* Testing Manager: Lang Xu
* Documentation: Jasmohan Bawa

### Contributions


Ern Chi Khoo: Implemented ParseSearch class to parse all queries on the search page, implemented GUI for the search page, worked with Juhee to debug WebScraping

Juhee Park: Implemented WebScraping class to get the page, implemented SearchField class to store the information of each search field, implemented due date filter functionality

Lang Xu: Implemented JobPosting class, ResultPage GUI with FXRuby, Printed out notification messages, and worked with Daniel to parse results into JobPosting objects. Done all related testings.

Jasmohan Bawa: Implemented function to parse through the scraped results HTML page and get all search results, and added the salary filter functionality and the GUI elements for it.

Daniel Lim: Implemented function to scrape the next and previous page and implemented function to parse the result and added sorting function to the GUI.

### Helpful Tips
Our program does take some time because it is loading through a lot of pages to get all the data, we promise it hasn't crashed or frozen. Also, the program may automically dim after some time, but that depends on the laptop the program is running on, as this has happened for certain members when testing the program. However, the program dimming is not an indication that it is shutting down. 
