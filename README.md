# This is my personal project for analyzing the results of the runners of the Rotterdam Marathon.

I have this marathon four times myself and was curious to learn more about the runners, the times and best pacing for personal bests. Further goal was to teach myself data science using different tools and concepts such as python, pandas, tidydata, visualization.


Using mostly Python (and a little bit of R) to scrape the results from uitslagen.nl (2009-2017) and sporthyves.com (2018 and 2019).

# Rotterdam Marathon Stats

[Rotterdam Marathon](https://www.nnmarathonrotterdam.org/) is an annual marathon (42.195 km) that courses through the city of Rotterdam, The Netherlands.

This repo contains combined, cleaned and anonymized results of this marathon for 2009-2019. You can find out these results at [data/all_results.csv](data/all_results.csv) file.

## Cleaning Original Source Data
Utilizing Python Pandas library to clean original data source from Kaggle for [Finishers Rotterdam Marathon 2009 - 2019] 

Items to clean:

Remove unnecessary columns
Remove unwanted "-" cells
Remove blank cells
Remove NaN cells
Reorganized Data Frames
Combined Data Frames
Reformate time format to "second"
Create tidydatasets
Export out cleaned data sets into csv files

## General statistics

How many finsihers over the years?
What the percentages of female runners?
How about the age groups?
How many different nationalisites are present?
From which countries do the majority of the runners come from?
