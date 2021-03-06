Predicting Instagram Likes
========================================================
author: Cristina Guzman
date: June 14, 2015

Motivation
========================================================

Whether you're a political candidate, retail brand, restaurant, celebrity or just an regular person, reaching people through social media is extremely important. Instagram is one of the big players in the field with projected increasing infuence, and their currency is measures in "likes". This app predicts how many likes your picture will get given the following criteria:

- number of followers
- hashtags
- mentions
- location
- categories
- day and time

We will now look into the details of the prediction algorithm.


Hashtags, Mentions and Location
========================================================
- On average [4% of followers](http://clicknathan.com/web-design/instagram-statistics/) give a like 
- Including even a [single hashtag recieves on average 12.6%](http://www.adweek.com/news/technology/14-instagram-data-findings-every-marketer-needs-know-160969) more engagement 
- [mentions recieve 56%](http://sproutsocial.com/insights/5-instagram-stats/) more likes
- [locations recieve 79%](http://sproutsocial.com/insights/5-instagram-stats/) more likes

```r
    predict <- followers * 0.04
    if (hashtag == "yes") {predict <- predict + (followers * 0.126)}
    if (mention == "yes") {predict <- predict + (followers * 0.56)}
    if (location == "yes") {predict <- predict + (followers * 0.79)}
```

Categories, Day and Time
========================================================
- Some [categories](http://rakaposhi.eas.asu.edu/instagram-icwsm.pdf) like selfies are more popular
- [Mondays and Wednesday](http://lab.softwarestudies.com/2014/11/when-do-people-share-comparing.html) are low on Instagram activity, while Saturday and Sundays are highs
- [Late Night and early morning](http://lab.softwarestudies.com/2014/11/when-do-people-share-comparing.html) see much lower activity than afternoons and evenings

```r
    if (sum(category %in% c("pet","fashion"))>0) {predict <- predict - (followers * 0.07)}
    if (sum(category %in% c("friends","selfie"))>0){predict <- predict + (followers * 0.05)}
    if ("activity" %in% category){predict <- predict + (followers * 0.1)}
    if (day %in% c("Monday","Wednesday")) {predict <- predict - (followers * 0.10)}
    else if (day %in% c("Saturday","Sunday")){predict <- predict + (followers * 0.2)}
    if (time %in% c("Late Night","Morning")) {predict <- predict - (followers * 0.4)}
```
Example
========================================================
Now that we have gone through the details, let's calculate two scenarios with the same number of followers. All the code from above is a function called likes with signature: `likes <- function(followers, hashtag, mention, location, category, day, time)`


```r
likes(500,"no","no","no",c("Selfie"),"Monday","Morning")
```

```
[1] 10
```

```r
likes(500,"yes","yes","yes",c("Selfie"),"Sunday","Afternoon")    
```

```
[1] 54
```
