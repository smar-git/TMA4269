---
editor: 
  markdown: 
    wrap: 72
---

## Project 1: Intro

### About the data

The dataset contains data from two traffic monitoring points in Frogner,
Oslo: one monitoring motor vehicles and one monitoring bicycles. You
will also be given a weather data from a nearby location.

The data are provided in the same structure and format as when they are
downloaded directly from Statens Vegvesen. The traffic data cover the
period from 1 January 2026 to 1 June 2026.

### Overall aim

The overall aim is modelling of traffic load (number of vehicles per 30
minutes) using the two different data sources (traffic monitoring and
weather).

You will use multiple linear regression and can apply all variations of
this that you have learnt so far, or add new elements.

Before you can arrive at a suitable model, you will have to make several
**choices**. Some choices are quite free (no right / wrong), but for
most problems there are more and less reasonable choices to make.

### Grading

In general, we are looking for both **correctness** in use of methods,
and your **understanding/reflections** regarding the data, you choices
and your results.

**AI-use**: We expect you to take advantage of all available resources,
but the challenge is to use them in a good way.

**Documenting progress**: One of the hand-ins for the project is a
(brief) timeline. At the end of *each* session you will make a short
reflective note that by the final delivery will contribute to the
timeline.

## Part 1: Getting to know the data, data cleaning, and prepare for modelling

### The data sets

The file `frogner_traffic.csv` contains data from both the motor vehicle
and bicycle monitoring points. Details regarding the data collection and
presentation can be found (in Norwegian) at
https://trafikkdata.atlas.vegvesen.no/om-trafikkdata

Here is a brief overview of selected columns:

`Trafikkmengde` is the count of of vehicles in a 30 minute interval
(traffic load), per lane (`Felt`) and in total. The columns
`Dekningsgrad`, `Antall timer totalt`, `Antall timer ugyldig`, gives an
indication of the quality of the count. The count of motor vehicles is
further split into counts at different vehicle lengths, with the 5.6 m
threshold used to distinguish between light and heavy vehicles.

The data has not been cleaned for you, and you need to e.g. handle
missing data and make sure columns of numbers are not represented as
characters.

An important **choice** you will have to make is what traffic load to
model. Total? Lane one? Bicycles? Light vehicles? Note that there is no
right and wrong choice, but some choices might be more suited for a
linear regression model than others.

The data set gives the date and time of the counts, and from this you
can **choose** to construct temporal variables that enter the model,
e.g. weekday of weekend. You can also **choose** to model only certain
time periods.

The file `frogner_weather.xlsx` gives weather data from a weather
station nearby the traffic monitoring point. You need to deal with
different time resolution when you combine the two data sources, and
what weather variables to enter into your model.

### Deliverables Part 1

2 reflection sheets (Wednesday and Friday)

1 modelling pipeline (Friday)

#### Modelling pipeline

1.  Modelling Aim. Decide on an aim for your model of traffic, what do
    you as a group want to strive for? How will you balance
    interpretability (usually few covariates / features) and model fit
    (the models ability to explain variability in the outcome)? Is your
    study exploratory, or do you have a specific hypothesis that you
    want to investigate?

2.  Visualizations. Present figures of your chosen response (traffic
    count), the figures can be drafts that you improve later on.

3.  Select weather variables, explain your choice and discuss how they
    might be added to your model (linear effect, transformations,
    categorical variables, splines?)

4.  Create temporal variables based on the date and time of the traffic
    counts. Which variables did you create, and how will you try
    entering them into your regression model?

*Note*: The pipeline is a draft, and you might need to adapt it later
on.
