setwd("/Users/saiarvind/Box Sync/Spring2018/CMSC320/Projects/FinalProject")

library(tidyr)

rent_data_path <- "./saiarvindg.github.io/Apartment-List-Rent-Data-City_2018-2.csv"

library(stringr)
airbnb_dir_data <- "./airbnbdatatemp"
airbnb_url <- "http://insideairbnb.com/get-the-data.html"
airbnb_html <- paste(readLines(airbnb_url), collapse = "\n")

airbnb_link_regex <- "http://data\\.insideairbnb\\.com/united-states/ny/new-york-city/\\d{4}-\\d{2}-\\d{2}/data/listings\\.csv\\.gz"

matched_data_links <- str_match_all(airbnb_html, airbnb_link_regex)
links_vector <- matched_data_links[[1]][,1] %>% unique()
two_links <- c("http://data.insideairbnb.com/united-states/ny/new-york-city/2018-02-02/data/listings.csv.gz",
			   "http://data.insideairbnb.com/united-states/ny/new-york-city/2018-01-10/data/listings.csv.gz")

library(lubridate)
library(R.utils)
invisible(sapply(two_links, function(link) {
	extracted_date <- str_extract(link,"\\d{4}-\\d{2}-\\d{2}")
	parsed_date <- ymd(extracted_date)
	tarfile_name <- paste(month(parsed_date,abbr = FALSE, label = TRUE),year(parsed_date),sep = "_")
	tarfile_path <- paste0(airbnb_dir_data,"/",tarfile_name,"_listings.csv.gz")
	file.create(tarfile_path)
	download.file(link, tarfile_path)
	gunzip(tarfile_path)
}))



rent_raw_data <- read.csv(rent_data_path)



