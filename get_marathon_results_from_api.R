library(data.table)
library(rvest)
library(chron)
library(rjson)

n=14549 # hardcoded, the amount of runners. Could also run API once and read from API.
count=50
offset=0
k=1
result = vector('list',ceiling(n/count))

# Replace all NULL in a list with NA
nullToNa <- function(mylist)
{
  lapply(mylist, function(x) ifelse(is.null(x), NA, x))
}

# Rotterdam2016='https://eventresults-api.sporthive.com/api/events/6313744045601533952/races/366347/classifications/search?count='
# n_2016=12813
# Rotterdam2017='https://eventresults-api.sporthive.com/api/events/6313740656865725952/races/400510/classifications/search?count='
# n_2017=13139
# Rotterdam2018='https://eventresults-api.sporthive.com/api/events/6386505967023513344/races/419161/classifications/search?count='
# n_2018=13997
# Rotterdam2019=https://eventresults-api.sporthive.com/api/events/6509035005995656960/races/450996/classifications/search?count='
# n_2019=14549 


for(k in 1:ceiling(n/count))
{
  # API URL
  url <- paste0('https://eventresults-api.sporthive.com/api/events/6509035005995656960/races/450996/classifications/search?count=',
                min(count,n-(offset)),'&offset=',offset)
  print(url)
  offset=count+offset
  page <- read_html(url)
  json_data <- fromJSON(file=url)
  
  l = vector('list',count)
  
  for(i in 1:length(json_data[[3]]))
  {
   runner_data <- list(
      'Name' = json_data[[3]][[i]]$athlete$name,
      'bib' = json_data[[3]][[i]]$classification$bib,
      'Agegroup' = json_data[[3]][[i]]$classification$category,
      'genderRank' = json_data[[3]][[i]]$classification$genderRank,
      'Place' = json_data[[3]][[i]]$classification$rank,
      'Agegrouprank' = json_data[[3]][[i]]$classification$categoryRank,
      'Guntime' = json_data[[3]][[i]]$classification$gunTime,
	'Chiptime' = json_data[[3]][[i]]$classification$chipTime,
      'Name' = json_data[[3]][[i]]$classification$name,
      'countryCode' = json_data[[3]][[i]]$classification$countryCode,
      'gender' = json_data[[3]][[i]]$classification$gender,
      'city' = json_data[[3]][[i]]$classification$city)
      
      split_data <- sapply(1:10,function(x){
        my_list <- nullToNa(list(json_data[[3]][[i]]$classification$splits[[x]]$name,
                          json_data[[3]][[i]]$classification$splits[[x]]$cumulativeTime))
        return(setNames(my_list,c(paste0('split',x), paste0('split',x,'_time'))))
      },simplify=F)
      
    l[[i]] = nullToNa(c(runner_data,unlist(split_data)))
  }
  result[[k]] = rbindlist(l)
}

result = rbindlist(result)
for(column in colnames(result)[grepl('time',colnames(result),ignore.case = T)])
{
 result[[column]] <- chron::times(result[[column]]) 
}

saveRDS(result,'c:/users/ivo/data/uitslagen_2019.RDS')
write.csv(result, file = "c:/users/ivo/data/uitslagen_2019_test.csv")
