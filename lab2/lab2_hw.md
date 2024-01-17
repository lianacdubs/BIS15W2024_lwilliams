---
title: "Lab 2 Homework"
author: "Liana Williams"
date: "2024-01-16"
output:
  html_document: 
    theme: spacelab
    keep_md: true
  pdf_document:
    toc: false
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

1. What is a vector in R?  


```r
#A vector is a data structure in R.  
#It is essentially multiple variables of the same type grouped together under a single piece of memory. 
```


2. What is a data matrix in R?  


```r
#Data matrices are a series of stacked vectors, similar to a data table.
```

3. Below are data collected by three scientists (Jill, Steve, Susan in order) measuring temperatures of eight hot springs. Run this code chunk to create the vectors.  


```r
spring_1 <- c(36.25, 35.40, 35.30)
spring_2 <- c(35.15, 35.35, 33.35)
spring_3 <- c(30.70, 29.65, 29.20)
spring_4 <- c(39.70, 40.05, 38.65)
spring_5 <- c(31.85, 31.40, 29.30)
spring_6 <- c(30.20, 30.65, 29.75)
spring_7 <- c(32.90, 32.50, 32.80)
spring_8 <- c(36.80, 36.45, 33.15)
```
## ^ I ran the code above! :)



4. Build a data matrix that has the springs as rows and the columns as scientists.  


```r
hotspring_temp <- c(spring_1, spring_2, spring_3, spring_4, spring_5, spring_6, spring_7, spring_8)
hotspring_temp
```

```
##  [1] 36.25 35.40 35.30 35.15 35.35 33.35 30.70 29.65 29.20 39.70 40.05 38.65
## [13] 31.85 31.40 29.30 30.20 30.65 29.75 32.90 32.50 32.80 36.80 36.45 33.15
```

```r
#Create a new object called 'hotspring_temp' using the `c` command to combine the vectors into one.
```


```r
hotspring_temp_matrix <- matrix(hotspring_temp, nrow = 8, byrow = T)
hotspring_temp_matrix
```

```
##       [,1]  [,2]  [,3]
## [1,] 36.25 35.40 35.30
## [2,] 35.15 35.35 33.35
## [3,] 30.70 29.65 29.20
## [4,] 39.70 40.05 38.65
## [5,] 31.85 31.40 29.30
## [6,] 30.20 30.65 29.75
## [7,] 32.90 32.50 32.80
## [8,] 36.80 36.45 33.15
```

```r
#Create a 'hotspring_temp_matrix' using the 'matrix()' command. Then tell R how to organize
#'hotspring_temp' vector organized by nrow and byrow commands. 
```

5. The names of the springs are 1.Bluebell Spring, 2.Opal Spring, 3.Riverside Spring, 4.Too Hot Spring, 5.Mystery Spring, 6.Emerald Spring, 7.Black Spring, 8.Pearl Spring. Name the rows and columns in the data matrix. Start by making two new vectors with the names, then use `colnames()` and `rownames()` to name the columns and rows.


```r
scientists <- c("Jill", "Steve", "Susan")
scientists
```

```
## [1] "Jill"  "Steve" "Susan"
```

```r
#scientists gets the column names of the three scientists 
```


```r
springs <- c("Bluebell_Spring","Opal_Spring","Riverside_Spring","Too_Hot_Spring","Mystery_Spring","Emerald_Spring","Black_Spring","Pearl_Spring")
springs
```

```
## [1] "Bluebell_Spring"  "Opal_Spring"      "Riverside_Spring" "Too_Hot_Spring"  
## [5] "Mystery_Spring"   "Emerald_Spring"   "Black_Spring"     "Pearl_Spring"
```

```r
#springs gets the row names for each respective spring number
```


```r
colnames(hotspring_temp_matrix) <- scientists
#name the columns using 'colnames()' with the vector scientists
```


```r
rownames(hotspring_temp_matrix) <- springs
#Name the rows using `rownames()` with the vector springs.
```


```r
hotspring_temp_matrix
```

```
##                   Jill Steve Susan
## Bluebell_Spring  36.25 35.40 35.30
## Opal_Spring      35.15 35.35 33.35
## Riverside_Spring 30.70 29.65 29.20
## Too_Hot_Spring   39.70 40.05 38.65
## Mystery_Spring   31.85 31.40 29.30
## Emerald_Spring   30.20 30.65 29.75
## Black_Spring     32.90 32.50 32.80
## Pearl_Spring     36.80 36.45 33.15
```

6. Calculate the mean temperature of all eight springs.



```r
avg_temp <- rowMeans(hotspring_temp_matrix)
avg_temp
```

```
##  Bluebell_Spring      Opal_Spring Riverside_Spring   Too_Hot_Spring 
##         35.65000         34.61667         29.85000         39.46667 
##   Mystery_Spring   Emerald_Spring     Black_Spring     Pearl_Spring 
##         30.85000         30.20000         32.73333         35.46667
```

```r
#avg_temp get the sum of all the rows in the hotspringmatrix; output is 8 springs each with the mean
```

7. Add this as a new column in the data matrix.  
 Add this information to the data matrix. Hint: you are adding a row, not a column.  

```r
cbind(hotspring_temp_matrix, avg_temp)
```

```
##                   Jill Steve Susan avg_temp
## Bluebell_Spring  36.25 35.40 35.30 35.65000
## Opal_Spring      35.15 35.35 33.35 34.61667
## Riverside_Spring 30.70 29.65 29.20 29.85000
## Too_Hot_Spring   39.70 40.05 38.65 39.46667
## Mystery_Spring   31.85 31.40 29.30 30.85000
## Emerald_Spring   30.20 30.65 29.75 30.20000
## Black_Spring     32.90 32.50 32.80 32.73333
## Pearl_Spring     36.80 36.45 33.15 35.46667
```

```r
#c is for column so therefore bind avg_temp to the hotspringmatrix
```

8. Show Susan's value for Opal Spring only.


```r
hotspring_temp_matrix[2,3]
```

```
## [1] 33.35
```

```r
#the first number is the column and the second number is the row
```

9. Calculate the mean for Jill's column only.  


```r
Jill_col <- hotspring_temp_matrix[ ,1]
mean(Jill_col)
```

```
## [1] 34.19375
```

```r
#calculate the mean of Jill's column
```

10. Use the data matrix to perform one calculation or operation of your interest.


```r
hotspring_temp_matrix[1:8]
```

```
## [1] 36.25 35.15 30.70 39.70 31.85 30.20 32.90 36.80
```

```r
#Use a colon `:` to selects the temperatures for each of the springs in Jill's column. 
```


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
