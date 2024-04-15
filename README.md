# Masters Shiny App Dashboard

This repository contains my final project for my graduate data visualization class at Willamette University. The goal of this project was to create a better tool for avid golf fans to access and understand important tournament data through an interactive data dashboard synthesizing PGA Tour Tournament statistics. This project was completed using an R Shiny App which can be viewed at this [link](https://aweirth.shinyapps.io/shiny_masters/).


## Table of Contents

- [About](#about)
- [Contents](#contents)
- [Skills](#skills)
- [Usage](#usage)
- [License](#license)
- [Contact](#contact)

## About

#### The Problem

As an avid fan of the PGA Tour, one might be interested in diving deeper into results and statistics from certain tournaments regularly, however, the PGA Tour does a poor job of presenting and making data visualization accessible for fans ([see here](https://www.pgatour.com/stats)). On the official website, there is no way to easily view individual data and understand important trends from tournament results. 

As an alternative, Data Golf is an online platform that collects PGA Tour data, runs a visualization blog, and maintains extensive machine learning models attempting to predict tournament outcomes. I constantly view this page as their machine learning models are interesting to track and monitor favorites for a given tournament. The issue with the Data Golf website is that for an audience with no background in data science, the dashboard can be extremely overwhelming especially for a golf audience that has a majority of middle aged people.

#### The Goal

These problems led to clear definition of this projects goal: **Design an informative dashboard capable of conveying critical insights from individual tournaments, including important aspects of a winner's performance and overarching gameplay trends. Communicate this while prioritizing a clean, concise, and user-friendly interface accessible for all golf enthusiasts.**

#### The Data

The data for this project comes from [Data Golf's Free PGA Archive](https://datagolf.com/raw-data-archive), where a free sample CSV of 2021 Masters Tournament data was aqquired. Again, raw golf data is not easily accessible and since the scope of this project was visualization and not a data pipeline, the free sample CSV was data used for this project.

#### The Product

The final product was a Shiny App Dashboard that can be viewed at this [link](https://aweirth.shinyapps.io/shiny_masters/). The dashboard achieved the goal of communicating critical insights by showing the dominant performance of Hideki Matsuyama's Strokes Gained Statistics across the board and especially Tee to Green. The dashboard was also able to be understood by peers in my graduate class who are not golf fans. This Shiny App represents how less is more sometimes when communicating data. Only two best graphics from my EDA stage were chosen which cleany and cleary communicate important findings without the dashboard turning into something that resembles an airplane cockpit (example: comparing one data point to a boxplot can communicate a lot of informatin with few pixels).

## Contents

In this repository you will see the following files:

Data:
- **raw_pga_2021.csv:** This is the raw CSV from Data Golf's Archive.
- **masters2021_cleaned111.csv:** This is the cleaned full 2021 Masters CSV from Data Golf, cleaned by the masters_wrangling.R script.
- **masters2021_lb.csv:** This is a wrangled dataframe from the above masters2021_cleaned111 file. This is the data being sent to the leaderboard on the homepage.

Cleaning Script:
- **masters_cleaning.R:** This is the script responsible for cleaning the raw csv and prodicing the cleaned CSV's.

The App:
- **App.R:** This is the R script responsible for producing the R Shiny App. It contains custom HTML/CSS styling and the GGplot code for generating the graphics.

## Skills

Data Cleaning:
- Processed the raw CSV file to handle missing values, inconsistencies, and manipulated the data strucutre to work with my project.
- Engineered new features helpful for construction of the dashboard and communicating insights.
  
Data Visualization:
- Utilized R Shiny App's visualization libraries (e.g., ggplot2, plotly) to create interactive and informative charts, graphs, and tables.
- Designed the dashboard layout to effectively present the insights derived from the data.
- Successfully selected the most effective visualizations from my EDA process.
  
Data Analysis:
- Conducted exploratory data analysis (EDA) to uncover patterns, trends, and relationships within the dataset.
- Employed statistical techniques to derive meaningful insights from the data.
  
Web Development:
- Developed a user-friendly and responsive web interface using HTML, CSS, and JavaScript within the R Shiny framework.
- Customized the appearance and layout of the dashboard to enhance user experience.

## Usage

Instructions on how to use the dashboard are in the "About" tab of the top ribbon. There, you will find helpful tips as well as hints to find the key insights I found in the graphics.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Feel free to reach out to me if you have questions or comments!

