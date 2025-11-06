# Voting Data Analysis - Tristan Smith's Campaign for Lynn School Committee

## Overview

Since September of 2025, I have been contributing to [Tristan Smith's campaign for a seat on the school committee](https://www.smithforlynn.com/) of Lynn, Massachusetts, a mid-size city north of Boston. To inform Mr. Smith's campaign strategy, using Python, Excel, and R, I have analyzed both historical voting data and the geographical distribution of his supporters to  pinpoint the most optimal portions of the city to target in canvassing efforts.

## Background

I first met Tristan Smith in 2015 as a 7th grader at Swampscott Middle School, where he was working as a substitute teacher and coaching track and field while taking pursuing a degree at nearby Salem State University. I got to know him better when he subbed for our social studies classes and when I participated in the hurdles, high jump, and dabbled in shot put on the track team.

![mstrack](mstrack.png)
*Mr. Smith (circled, lying in front) was a T&F coach as well as a substitute teacher for me (circled, standing in back left) and my classmates from 2015 to 2018.*

Many yeras later, when I got word that Mr. Smith had [announced his candidacy for State Representative of Massachusetts' 8th Essex district](https://lynnjournal.com/2022/05/25/tristan-smith-campaign-kickoff-for-state-representative/) in May of 2022, I knew I had to help lend him a hand in any way I could. So, after getting off work each afternoon, I would canvass the district's voters, knocking on doors and phone banking to gauge interest in Mr. Smith's candidacy and to field questions about his stances on issues such as healthcare, education, environmental policy, and how to allocate the state budget surplus. Throughout the summer, Mr. Smith, who, at the time, was fresh out of law school with no experience holding public office, ran an extremely effective campaign that vaulted him from being regarded as a relative underdog to actually being given a real shot at securing the Democratic nomination. Despite widespread criticism regarding his inexperience, Mr. Smith's platform clearly resonated with voters. While Mr. Smith ultimately [fell just short of Jenny Armini](https://ballotpedia.org/Tristan_Smith) in the Democratic primary, I am extremely proud of him for the campaign he ran and for never wavering from what he believed in.

All of these experiences motivated me to reach back out to Mr. Smith when I learned of his candidacy for a seat on the Lynn School Committee. This time around, my 
role as a volunteer for his campaign has been far more behind-the-scenes. In lieu of canvassing, I have been assisting is campaign by conducting analyses of both present and 
historical voting data to provide recommendations for voter strategies.

## My Role

Using historical election result data provided to me by Mr. Smith's team, as well as results from the 2025 Lynn Preliminary Election in early September, I have been tasked with identifying areas of the city that have historically high voter turnout rates as well as identifying the most optimal areas to focus campaigning efforts. I have written Python programs to extract the relevant voting data from all elections held in the city of Lynn going back to 2015. This proved to be a significant challenge, as the data was given to me as a series of PDFs containing irregularly shaped tables. Due to these challenges, I found myself having to undertake some cleaning and organization in Excel, though I was able to format the data neatly enough for export into other statistical analysis platforms. I then composed an extensive report outlining my findings using R Markdown, implementing a variety of helpful interactive data visualizations.

I conducted additional analytial work for Mr. Smith's campaign by dividing each of Lynn's 7 wards into "turfs" of 50 households with reliable voters in the DNC VoteBuilder platform (which was no fun at all to use). I was tasked with determining which turfs should be considered "broad" (reliable voters are evenly spread throughout the turf) or "precise" (reliable voters are concentrated in a turf). The turfs were ultimately sorted based on judgement calls, though I did attempt to account for the housing density of each of the turfs in each of my decisions by consulting a city zoning map. Much of this work was completed in Google Sheets so it could be easily shared with the rest of the campaign team.

## Update - November 5, 2025

I am happy to announce that, on the evening of November 4, 2025, [Mr. Smith won a seat on Lynn School Committee](https://itemlive.com/2025/11/04/smith-tops-school-race/). Not only did he secure a seat, but he received the most votes of any candidate in the race. Overall, his campaign was a resounding success.

I have posted the finalized report in the Materials section below. I will post all data files and extraction and cleaning programs tomorrow.

In the coming days, the results of the 2025 Lynn General Election (broken down by precinct) should be open to the public. Once this data is available, I plan to analyze these results and assess the accuracy of the predictions I made in my report. I would also like to see how much he was able to improve turnout or how many additional votes he won in precincts where I recommended he focus his campaign. I hope to have this post-analysis up as soon as possible. I unfortunately can't give a set date because there is no set date for the release of the 2025 election results.

## Materials
- [📄 Download Report PDF](voting_data_analysis.pdf)



