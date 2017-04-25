### Exercise 5 ###
library(jsonlite)
library(dplyr)
library(httr)

# Write a function that allows you to specify a movie, that does the following:
GetReview <- function(movie) {
  base <- "https://api.nytimes.com/svc/movies/v2/reviews/search.json?"
  api.key <- "ef8dd7e64f2f45e7b0bb0846930275e7"
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # Your parameters should include a "query" and an "api_key"
  # Note: the HTTR library will take care of spaces in the arguments
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  
  # Request data using your search query
  r <- GET(base, query = list(query = movie, api_key = api.key))
  content <- content(r, "text")
  result <- fromJSON(content)
  # What type of variable does this return?
  
  # Flatten the data stored in the `$results` key of the data returned to you
  flattened <- flatten(result$results)
    # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  most.recent <- flattened[1,]
  headline <- most.recent["headline"] 
  summary <- most.recent["summary_short"]
  link <-most.recent["link.url"]
  # Return an list of the three pieces of information from above
  return(list(headline, summary, link))
}

# Test that your function works with a movie of your choice
GetReview("The Dark Knight")
