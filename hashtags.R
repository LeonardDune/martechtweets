#Check if all libraries are available.
list.of.packages <- c("twitteR","stringi", "stringr", "tm", "plyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Load Libraries
library(twitteR)
library(stringi)
library(stringr)
library(tm)
library(plyr)

#Fill in these details with your personal consumer en access keys that you received on apps.twitter.com
consumer_key <- "qqHfvWg7nlPDCmBeTMMbQ9GGs"
consumer_secret <- "BNiQ5HngkZG9VtC2Umfa1GXg0xC68k4E8frQ8arNoHYyg2JEWi"
access_token <- "875652423372517379-KDO3jjbeAegZxyn4KGZKRVuN1nLHixK"
access_secret <- "xoTKRb3eepMsk8c7grRaDC9ESGrheW2T1HedvSeHw5zBh"

#Initial authentication to twitter
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#What are we looking for on twitter?
search_term <- "#MarTech"
#How many tweets do you want to receive
number_of_tweets <- 1000

#Search on Twitter
tweets <- searchTwitter(search_term, number_of_tweets )

#convert received data to something PowerBi understands
df_tweets <- twListToDF(tweets)
28
#column cleanup
#df_tweets <- df_tweets[,c("text","favorited","favoriteCount","created","retweetCount","isRetweet","retweeted")]
df_tweets$text <- stri_encode(df_tweets$text, "", "UTF-8")
df_tweets <- mutate(df_tweets, hashtags = paste(str_extract_all(df_tweets$text, "#\\w+")))


