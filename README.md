## BodyFat-Analysis Porject
**Shiwei Cao**, **Shurong Gu**, **Yuwei Sun**

This is a course project aims at coming up with a simple, precise, and accurate way of determining body fat percentage of males based on readily available clinical measurements. *BodyFat Analysis.ipynb* is an executive summary of the data analysis process and findings in Jupyter Notebook pattern. The result of analysis shows that the percentage of body fat of a male is strongly related with *Weight*, *Wrist* and *Abdomen*.

There are three folders providing more details in our main project, *code*, *image* and *data*
### code
There are 4 R code files *pre-clean.R*, *models.R*, *lasso.R* and *"multiplot.R"* in this folder. *pre-clean.R* is the file which cleans original data, removes outliers and comes up with a new dataset *new_BodyFat.Rdata*. *models.R* shows the process of using *new_BodyFat* to analyze and select models. *lasso.R* contains other methods like Lasso to do variable selection. *"multiplot.R"* is a reference plotting code helping us to make better graghs. 

### image
This is an image folder containing all the figures/images/tables produced in our analysis.

### data
*BodyFat.csv* is the original 252 records of available measurements include age, weight, height, bmi, and various body circumference measurements. In particular, the variables listed below (from left to right in the data set) are: 

Percent body fat from Siri's (1956) equation  
Density determined from underwater weighing  
Age (years)  
Weight (lbs)  
Height (inches)  
Adioposity (bmi)
Neck circumference (cm)  
Chest circumference (cm)  
Abdomen 2 circumference (cm)  
Hip circumference (cm)  
Thigh circumference (cm)  
Knee circumference (cm)  
Ankle circumference (cm)  
Biceps (extended) circumference (cm)  
Forearm circumference (cm)  
Wrist circumference (cm)  

*new_BodyFat.Rdata* is the Rdata after removing all outliers from the original dataset.

