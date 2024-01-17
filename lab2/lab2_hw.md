---
title: "Lab 2 Homework"
author: "Liana Williams"
date: "`r Sys.Date()`"
output:
  html_document:
    theme: spacelab
    toc: false
  pdf_document:
    toc: false
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

1. What is a vector in R?  

```{r}
#A vector is a data structure in R.  
#It is essentially multiple variables of the same type grouped together under a single piece of memory. 
```


2. What is a data matrix in R?  

```{r}
#Data matrices are a series of stacked vectors, similar to a data table.
```

3. Below are data collected by three scientists (Jill, Steve, Susan in order) measuring temperatures of eight hot springs. Run this code chunk to create the vectors.  

```{r}
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

```{r}
hotspring_temp <- c(spring_1, spring_2, spring_3, spring_4, spring_5, spring_6, spring_7, spring_8)
hotspring_temp
#Create a new object called 'hotspring_temp' using the `c` command to combine the vectors into one.
```

```{r}
hotspring_temp_matrix <- matrix(hotspring_temp, nrow = 8, byrow = T)
hotspring_temp_matrix
#Create a 'hotspring_temp_matrix' using the 'matrix()' command. Then tell R how to organize
#'hotspring_temp' vector organized by nrow and byrow commands. 
```

5. The names of the springs are 1.Bluebell Spring, 2.Opal Spring, 3.Riverside Spring, 4.Too Hot Spring, 5.Mystery Spring, 6.Emerald Spring, 7.Black Spring, 8.Pearl Spring. Name the rows and columns in the data matrix. Start by making two new vectors with the names, then use `colnames()` and `rownames()` to name the columns and rows.

```{r}
scientists <- c("Jill", "Steve", "Susan")
scientists
#scientists gets the column names of the three scientists 
```

```{r}
springs <- c("Bluebell_Spring","Opal_Spring","Riverside_Spring","Too_Hot_Spring","Mystery_Spring","Emerald_Spring","Black_Spring","Pearl_Spring")
springs
#springs gets the row names for each respective spring number
```

```{r}
colnames(hotspring_temp_matrix) <- scientists
#name the columns using 'colnames()' with the vector scientists
```

```{r}
rownames(hotspring_temp_matrix) <- springs
#Name the rows using `rownames()` with the vector springs.
```

```{r}
hotspring_temp_matrix
```

6. Calculate the mean temperature of all eight springs.


```{r}
avg_temp <- rowMeans(hotspring_temp_matrix)
avg_temp
#avg_temp get the sum of all the rows in the hotspringmatrix; output is 8 springs each with the mean
```

7. Add this as a new column in the data matrix.  
 Add this information to the data matrix. Hint: you are adding a row, not a column.  
```{r}
cbind(hotspring_temp_matrix, avg_temp)
#c is for column so therefore bind avg_temp to the hotspringmatrix
```

8. Show Susan's value for Opal Spring only.

```{r}
hotspring_temp_matrix[2,3]
#the first number is the column and the second number is the row
```

9. Calculate the mean for Jill's column only.  

```{r}
Jill_col <- hotspring_temp_matrix[ ,1]
mean(Jill_col)
#calculate the mean of Jill's column
```

10. Use the data matrix to perform one calculation or operation of your interest.

```{r}
hotspring_temp_matrix[1:8]
#Use a colon `:` to selects the temperatures for each of the springs in Jill's column. 
```


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  