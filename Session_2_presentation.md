Stats Workshop 2.0
========================================================
author: Travis Riddle
date: 1/XX/2015

Strategy
========================================================

Last time, we used Mark's data to illustrate loading data, some details about variable/object types, basic use of the `reshape2` package, and a few preliminary plots, made with ggplot.

Today, Maya has been nice enough to donate her data to the cause.  We're going to use her data to accomplish our objectives.  Specifically, we're going to

- Clean it up a bit
- Make some plots to discover some relationships
- think about ANOVA

Material
========================================================

Practically, we're going to rehash some of the stuff from last time.  As far as R is concerned, I don't think thre's anything in here that isn't stuff we didn't cover last time, but feel free to stop me with questions.

Load in data
========================================================

In Maya's R script, she first loads in her data:

```r
srp <- read.csv('Data/SR.Past.Rel.12.10.14.csv')
```

After this, she goes on to calculate some index measures and clean the file up a bit.  I've omitted that code here.  However, I'll highlight one thing she did



Rename manipulations
========================================================


```r
srp$relprimedum[srp$relprime == "Stable Relationship Priming"] <- 0
srp$relprimedum[srp$relprime == "Dissolved Relationship Priming"] <- 1

srp$attitudedum[srp$attitude == "Michael-Dislike"] <- 0
srp$attitudedum[srp$attitude == "Michael-Like"] <- 1
```

Here, we're making a new variable which is a dummy code of another variable (i.e. code the two categories as 1 and zero).  Let's look a little more closely at what's going on here.

Rename manipulations
========================================================


```r
srp$relprimedum[srp$relprime == "Stable Relationship Priming"] <- 0
srp$relprimedum[srp$relprime == "Dissolved Relationship Priming"] <- 1
```

Here, we're making a new variable which is a dummy code of another variable (i.e. code the two categories as 1 and zero).  Let's look a little more closely at what's going on here.


