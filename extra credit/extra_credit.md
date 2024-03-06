---
title: "Extra Credit W24"
author: "Liana Williams"
date: "2024-03-05"
output:
  html_document: 
    keep_md: true
  pdf_document: default
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code must be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. 

Your code must knit in order to be considered. If you are stuck and cannot answer a question, then comment out your code and knit the document.  

Don't forget to answer any questions that are asked in the prompt. Some questions will require a plot, but others do not- make sure to read each question carefully.  

For the questions that require a plot, make sure to have clearly labeled axes and a title. Keep your plots clean and professional-looking, but you are free to add color and other aesthetics.  

Be sure to follow the directions and push your code to your repository.

## Background
In the `data` folder, you will find data about global shark attacks. The data are updated continuously, and are taken from [opendatasoft](https://public.opendatasoft.com/explore/dataset/global-shark-attack/table/?flg=en-us&disjunctive.country&disjunctive.area&disjunctive.activity).  

## Load the libraries

```r
library("tidyverse")
library("janitor")
library("naniar")
library("stringr")
```

## Load the data
Run the following code chunk to import the data.

```r
global_sharks <- read_csv("data/global-shark-attack.csv") %>% clean_names()
```

## Questions
1. (2 points) Start by doing some data exploration using your preferred function(s). What is the structure of the data? Where are the missing values and how are they represented?  

```r
glimpse(global_sharks)
```

```
## Rows: 6,890
## Columns: 21
## $ date                   <date> 2023-07-29, 2023-04-22, 2023-03-02, 2023-02-18…
## $ year                   <dbl> 2023, 2023, 2023, 2023, 2022, 2022, 2021, 2021,…
## $ type                   <chr> "Unprovoked", "Unprovoked", "Unprovoked", "Ques…
## $ country                <chr> "USA", "AUSTRALIA", "SEYCHELLES", "ARGENTINA", …
## $ area                   <chr> "Florida", "Western Australia", "Praslin Island…
## $ location               <chr> "Tampa Bay", "Lucy's Beach", NA, "Chubut Provin…
## $ activity               <chr> "Swimming", "Surfing", "Snorkeling", NA, "Snork…
## $ name                   <chr> "Natalie Branda", "Max Marsden", "Arthur \xc9",…
## $ sex                    <chr> "F", "M", "M", "M", "F", "M", "M", "M", "M", "M…
## $ age                    <chr> "26", "30", "6", "32", NA, "21.0", "15.0", "73.…
## $ injury                 <chr> "Superficial injuries to abomen and thighs", "B…
## $ fatal_y_n              <chr> "N", "N", "UNKNOWN", "UNKNOWN", "N", "N", "N", …
## $ time                   <chr> "20h00", "07h15", "Afternoon", NA, "12h30", "15…
## $ species                <chr> NA, "Bronze whaler shark, 1.5 m", "Lemon shark"…
## $ investigator_or_source <chr> "Fox12, 8/1/2023", "The West Australian, 4/22/2…
## $ pdf                    <chr> NA, NA, NA, NA, "2022.07.28-Cornwall.pdf", "202…
## $ href_formula           <chr> NA, NA, NA, NA, "http://sharkattackfile.net/spr…
## $ href                   <chr> NA, NA, NA, NA, "http://sharkattackfile.net/spr…
## $ case_number_19         <chr> NA, NA, NA, NA, "2022.07.28", "2022.03.09", "20…
## $ case_number_20         <chr> NA, NA, NA, NA, "2022.7.28", "2022.03.09", "202…
## $ original_order         <dbl> NA, NA, NA, NA, 6792, 6743, 6720, 6626, 6618, 6…
```


```r
global_sharks %>% 
  naniar::miss_var_summary() 
```

```
## # A tibble: 21 × 3
##    variable n_miss pct_miss
##    <chr>     <int>    <dbl>
##  1 time       3518    51.1 
##  2 species    3118    45.3 
##  3 age        2982    43.3 
##  4 activity    586     8.51
##  5 sex         572     8.30
##  6 location    565     8.20
##  7 area        481     6.98
##  8 date        305     4.43
##  9 name        220     3.19
## 10 year        132     1.92
## # ℹ 11 more rows
```

2. (3 points) Are there any "hotspots" for shark incidents? Make a plot that shows the total number of incidents for the top 10 countries? Which country has the highest number of incidents?

**The US has the highest number of incidents**

```r
global_sharks %>% 
  count(country) %>% 
  arrange(desc(n))
```

```
## # A tibble: 216 × 2
##    country              n
##    <chr>            <int>
##  1 USA               2522
##  2 AUSTRALIA         1464
##  3 SOUTH AFRICA       596
##  4 NEW ZEALAND        142
##  5 PAPUA NEW GUINEA   136
##  6 BAHAMAS            132
##  7 BRAZIL             122
##  8 MEXICO             100
##  9 ITALY               72
## 10 FIJI                67
## # ℹ 206 more rows
```


```r
global_sharks %>% 
  count(country) %>% 
  top_n(10, n) %>% 
  ggplot(aes(x=reorder(country,n), y=n))+
  geom_col(fill = "violetred", alpha=0.8)+
  coord_flip()+
  labs(title="Shark Incidents by Country (1950-2022)", 
      x=NULL, 
      y="n") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1),
        plot.title = element_text(size = 14, face="bold"))+
  geom_text(aes(label = n), vjust = -0.2, size = 3, color = "black") 
```

![](extra_credit_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

3. (3 points) Are there months of the year when incidents are more likely to occur? Make a plot that shows the total number of incidents by month. Which month has the highest number of incidents?
**More incidents are likely to occur in January (01) since it had over 750 incidents**

```r
global_sharks_new <- global_sharks %>% 
  separate(date, into=c("year", "month", "day"), sep="-")
```


```r
global_sharks_new %>% 
  group_by(month) %>%
  summarise(total=n(), .groups='keep') %>% 
  ggplot(aes(x=as_factor(month), y=total))+
  geom_col(fill = "#0099f9", alpha=0.8)+
  labs(title="Shark Incidents by Month", 
       x="Month", 
       y="n")+
  theme(plot.title = element_text(size = 14, face="bold"))
```

![](extra_credit_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

4. (3 points) Which activity is associated with the highest number of incidents? Make a plot that compares the top 5 riskiest activities. "NA" should not be classified as an activity.
#Check the total for each activity

```r
global_sharks_new %>% 
  count(activity) %>% 
  arrange(desc(n))
```

```
## # A tibble: 1,554 × 2
##    activity         n
##    <chr>        <int>
##  1 Surfing       1112
##  2 Swimming      1009
##  3 <NA>           586
##  4 Fishing        498
##  5 Spearfishing   387
##  6 Wading         171
##  7 Bathing        166
##  8 Diving         145
##  9 Snorkeling     127
## 10 Standing       115
## # ℹ 1,544 more rows
```


```r
global_sharks %>% 
  filter(activity!="NA") %>% 
  group_by(activity) %>% 
  summarise(incident_count = n()) %>% 
  top_n(5, incident_count) %>% 
  ggplot(aes(x=reorder(activity, incident_count),  y=incident_count))+
  geom_col()+ 
  coord_flip() + 
  labs(x = "Activity", y = "Number of Incidents", title = "Top 5 Riskiest Activities")
```

![](extra_credit_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

5. (3 points) The data include information on who was attacked. Make a plot that shows the total number of fatalities by sex- are males or females more likely to be killed by sharks?

```r
global_sharks %>%
  filter(sex %in% c("M", "F")) %>% 
  group_by(sex) %>% 
  summarise(fatalities = sum(fatal_y_n == "Y", na.rm = T)) %>% 
  ggplot(aes(x=sex, y=fatalities, fill=sex))+
  geom_col(alpha=0.8)+
  labs(title="Fatalities from Sharks by Sex", 
       x="Sex", 
       y="Fatality")
```

![](extra_credit_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

6. (3 points) Make a plot that shows the range of age for the individuals that are attacked. Make sure to restrict sex to M or F (some of the codes used are not clear). You will also need to find a way to manage the messy age column.

```r
# Clean sex column to include only 'M' or 'F'
sharks_cleaned <- global_sharks %>%
  filter(sex %in% c('M', 'F'))

# Convert age to a numeric variable, handling non-numeric values and NAs
sharks_cleaned$age <- as.numeric(as.character(sharks_cleaned$age))
```

```
## Warning: NAs introduced by coercion
```

```r
# Remove rows with NA in age after conversion
sharks_cleaned <- sharks_cleaned %>%
  filter(!is.na(age))

# Plot
ggplot(sharks_cleaned, aes(x = sex, y = age)) +
  geom_boxplot(fill = "steelblue", color = "black") +
  labs(title = "Age of Attacked Individuals by Sex",
       x = "Sex",
       y = "Age") +
  theme_minimal()
```

![](extra_credit_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

7. (3 points) In the United States, what are the top 5 states where shark attacks have been recorded since 1950? Make a plot that compares the number of incidents for these 5 states.

```r
shark_attack <- global_sharks %>% 
  filter(country == "USA", year >= 1950)
```


```r
state_incidents <- shark_attack %>% 
  group_by(area) %>% 
  summarise(incidents = n()) %>% 
  arrange(desc(incidents)) %>% 
  top_n(5, incidents)
```


```r
ggplot(state_incidents, aes(x = reorder(area, incidents), y = incidents)) +
  geom_bar(stat = "identity") +
  labs(x = "State", y = "Number of Incidents", title = "Top 5 States by Shark Attacks Since 1950") +
  coord_flip()
```

![](extra_credit_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

8. (3 points) Make a new object that limits the data to only include attacks attributed to Great White Sharks. This is trickier than it sounds, you should end up with 494 observations. Look online and adapt code involving `str_detect`. Which country has the highest number of Great White Shark attacks?


```r
library(dplyr)
library(stringr)
```


```r
# Filter data for Great White Shark attacks
great_white_attacks <- global_sharks %>%
  filter(str_detect(string = species, pattern = regex("Great White Shark|White shark", ignore_case = TRUE)))

# Check correct number of observations
print(nrow(great_white_attacks)) # Should print 494
```

```
## [1] 692
```

```r
# Find which country has the highest number of Great White Shark attacks
country_count <- great_white_attacks %>%
  count(country) %>%
  arrange(desc(n))

# Display the country with the highest number of attacks
print(country_count[1, ])
```

```
## # A tibble: 1 × 2
##   country     n
##   <chr>   <int>
## 1 USA       225
```


9. (4 points) Use faceting to compare the number of fatal and non-fatal attacks for the top 5 countries with the highest number of Great White Shark attacks.

```r
# Filter 
great_white_attacks <- global_sharks %>%
  filter(str_detect(string = species, pattern = regex("Great White Shark|White shark", ignore_case = TRUE)))

# Get the top 5 countries
top_countries <- great_white_attacks %>%
  count(country) %>%
  arrange(desc(n)) %>%
  slice(1:5) %>%
  pull(country)

# Filter to include top 5 countries
top_country_attacks <- great_white_attacks %>%
  filter(country %in% top_countries)

# Create a plot comparing fatal and non-fatal attacks for the top 5 countries
ggplot(top_country_attacks, aes(x = country, fill = fatal_y_n)) +
  geom_bar(position = "dodge") +
  facet_wrap(~ country) +
  labs(title = "Fatal and Non-Fatal Great White Shark Attacks in Top 5 Countries",
       x = NULL,
       y = "Number of Attacks",
       fill = "Fatal (Y/N)") +
    theme(strip.text = element_text(size=10),
        axis.text.x = element_text(size=8, angle = 60, hjust = 1))
```

![](extra_credit_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

10. (3 points) Using the `global_sharks` data, what is one question that you are interested in exploring? Write the question and answer it using a plot or table. 

Are there more Male or Female surfing shark attacks? Make a bar plot that shows their relative numbers.

```r
global_sharks %>% 
  select(activity, sex) %>% 
  filter(activity=="Surfing") %>% 
  filter(sex!="NA" & sex!="lli") %>% 
  ggplot(aes(sex))+
  geom_bar()+
  labs(title="Shark Sex vs. Surfing Attacks", 
       x="Sex", 
       y="Number of Surfing Attacks")
```

![](extra_credit_files/figure-html/unnamed-chunk-19-1.png)<!-- -->


