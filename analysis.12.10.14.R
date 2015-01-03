
# SR PAST REL.

setwd("~/Google Drive/Columbia/RESEARCH/CURRENT/SR_Rel.Prime.Youjung/mturk study 1. nov 20")
srp <- read.csv(file="SR.Past.Rel.12.10.14.csv")

#ALREADY EXCLUDED (pre-coding):
#11 participants - suspicion check (mentioned doubt about existence of partner when asked “would you work with this person again, why or why not”)
#17 participants - attention check  (failed to write “survey” in answer to the questions attention check)
#1 participant - Excluded number 69 (in 12.08.14 data) who didn't produce recall (just re-stated partner's opinion of Michael)

#### EXCLUSIONS ####
#exclude 5 who copied the Michael text verbatim (exclcopied=1)
srp <- srp[ which(is.na(srp$exclcopied) == TRUE ), ]
#exclude 11 who used 'Michael' in their message (didn't follow directions) (exclmich=1)
srp <- srp[ which(is.na(srp$exclmich) == TRUE ), ]

####### COMPUTING VARIABLES ##########
attach(srp)
## rmq
srp$loc <- (rmq_1 + rmq_3 + rmq_4 + rmq_5 + rmq_8 + rmq_16 + rmq_21 + rmq_25 + rmq_28 + rmq_29 + (7-rmq_13) + (7-rmq_24))/12
srp$ass <- ((7-rmq_2) + rmq_6 + rmq_7 + rmq_9 + (7-rmq_10) + rmq_11 + rmq_15 + rmq_19 + rmq_20 + rmq_22 + (7-rmq_27) + rmq_30)/12
srp$locomassess = srp$loc-srp$ass

srp$prom = (6-rfq_1) + rfq_3 + rfq_7 + (6-rfq_9) + rfq_10 + (6-rfq_11)
srp$prev = (6-rfq_2) + (6-rfq_4) + rfq_5 + (6-rfq_6) + (6-rfq_8)
srp$prommprev = srp$prom-srp$prev

# closeness measure
srp$closeness <- (((8-close_1) + (8-close_2) + close_3 + close_4 + (8-close_5) + (8-close_6) + close_7 + close_8)/8)

# ntoBelong
srp$belong = ((6-NTB_1) + (6-NTB_3) + (6-NTB_7) + NTB_2 + NTB_4 + NTB_5 + NTB_6 + NTB_8 + NTB_9 + NTB_10)/10

# Relational Trust
srp$reltrust = (reltrust_1 + reltrust_2 + reltrust_3 + reltrust_4)/4

# Epistemic Trust
srp$epistrust = (epistrust_1 + epistrust_2 + epistrust_3 + epistrust_4)/4

# message trust
srp$messtrust = (messtrust_1 + messtrust_2 + messtrust_3 + messtrust_4)/4

# ECR
srp$anx = (ECR.S_2 + ECR.S_4 + ECR.S_6 + (8-ECR.S_8) + ECR.S_10 + ECR.S_12)
srp$avoid = ((8-ECR.S_1) + ECR.S_3 + (8-ECR.S_5) + ECR.S_7 + ECR.S_9 + ECR.S_11)

#SCS
srp$independence = (((8-SCS_1) + (8-SCS_2) + (8-SCS_3) + (8-SCS_4) + (8-SCS_5) + (8-SCS_6) + (8-SCS_7) + (8-SCS_8) + (8-SCS_9) + (8-SCS_10) + (8-SCS_11)+ (8-SCS_12)+ SCS_13+ SCS_14+ SCS_15+ SCS_16+ SCS_17+ SCS_18+ SCS_19+ SCS_20+ SCS_21+ SCS_22+ SCS_23+ SCS_24)/24)

detach(srp)

#F-Scale
srp$authority = (((srp$F.Scale_1) + (srp$F.Scale_2) + (srp$F.Scale_3) + (srp$F.Scale_4) + (srp$F.Scale_5) + (srp$F.Scale_6) + (srp$F.Scale_7) + 
                    (srp$F.Scale_8) + (srp$F.Scale_9) + (srp$F.Scale_10) + (srp$F.Scale_11)+ (srp$F.Scale_12)+ srp$F.Scale_13+ srp$F.Scale_14 +
                    srp$F.Scale_15+ srp$F.Scale_16+ srp$F.Scale_17+ srp$F.Scale_18+ srp$F.Scale_19+ srp$F.Scale_20+ srp$F.Scale_21+ srp$F.Scale_22)/22)


#### RECODING ####

####renaming manipulations 
#install.packages("reshape")
#library(reshape)
srp <- rename(srp, c(DO.BR.FL_19="relprime")) #dissolved=1, stable=2
srp <- rename(srp, c(DO.BR.FL_20="attitude")) #like=2, dislike=1

# dummy coding manipulations
srp$relprimedum[srp$relprime == "Stable Relationship Priming"] <- 0
srp$relprimedum[srp$relprime == "Dissolved Relationship Priming"] <- 1

srp$attitudedum[srp$attitude == "Michael-Dislike"] <- 0
srp$attitudedum[srp$attitude == "Michael-Like"] <- 1

###### SUBSETTING ####
srlike <- subset(srp, attitudedum==1)
srdislike <- subset(srp, attitudedum==0)
srstable <- subset(srp, relprimedum==0)
srdissolve <- subset(srp, relprimedum==1)

#### HISTOGRAMS ####
#install.packages("ggplot2")
#library(ggplot2)
theme_set(theme_bw(base_size = 14)) #for all graphs to have bw background & same font size

ggplot(srlike, aes(x=vmessage)) + 
  geom_density()
ggplot(srdislike, aes(x=vmessage)) + 
  geom_density()
ggplot(srstable, aes(x=vmessage)) + 
  geom_density()
ggplot(srdissolve, aes(x=vmessage)) + 
  geom_density()

ggplot(srlike, aes(x=vrecall)) + 
  geom_density()
ggplot(srdislike, aes(x=vrecall)) + 
  geom_density()
ggplot(srstable, aes(x=vrecall)) + 
  geom_density()
ggplot(srdissolve, aes(x=vrecall)) + 
  geom_density()

##### ANOVAS: MESSAGE & RECALL VALENCE ########

##correlation of message & recall in stable vs dissolved 
cor.test(srstable$vmessage, srstable$vrecall) #0.66
cor.test(srdissolve$vmessage, srdissolve$vrecall) #0.63

## ONE-WAY ANOVAS: main effects
sr.att.mess <- aov(vmessage ~ attitudedum, data=srp)
summary(sr.att.mess) #main effect of attitude

sr.att.rec <- aov(vrecall ~ attitudedum, data=srp)
summary(sr.att.rec) #main effect of attitude

sr.rel.mess <- aov(vmessage ~ relprimedum, data=srp)
summary(sr.rel.mess) #ns

sr.rel.rec <- aov(vrecall ~ relprimedum, data=srp)
summary(sr.rel.rec) #ns

## TWO-WAY ANOVAS: interactions
sr.rel.att.mess <- aov(vmessage ~ attitudedum * relprimedum, data=srp)
summary(sr.rel.att.mess) #main effect of attitude (interaction ns)

sr.rel.att.rec <- aov(vrecall ~ attitudedum * relprimedum, data=srp)
summary(sr.rel.att.rec) #main effect of attitude (interaction ns)

#means estimated by two-way anovas
#install.packages("doBy")
#library(doBy)
summaryBy(vmessage ~ attitude + relprime, FUN = c(mean,sd), data=srp)
summaryBy(vrecall ~ attitude + relprime, FUN = c(mean,sd), data=srp)

#### BOXPLOTS ####

### Attitude 
# message
ggplot(srp, aes(attitude, vmessage)) + 
  geom_boxplot(aes(fill=attitude), alpha=I(0.5)) + 
  geom_jitter(aes(color=attitude), size=2, position = position_jitter(width = .2)) + 
  stat_summary(aes(group=attitude), fun.y = mean, geom="point", colour="white", size=3) +
  theme(legend.position='none')

# valence
ggplot(srp, aes(attitude, vrecall)) + 
  geom_boxplot(aes(fill=attitude), alpha=I(0.5)) + 
  geom_jitter(aes(color=attitude), size=2, position = position_jitter(width = .2)) + 
  stat_summary(aes(group=attitude), fun.y = mean, geom="point", colour="white", size=3) +
  theme(legend.position='none')

## WITHIN LIKE
# message
ggplot(srlike, aes(relprime, vmessage)) + 
  geom_boxplot(aes(fill=relprime), alpha=I(0.5)) + 
  geom_jitter(aes(color=relprime), size=2, position = position_jitter(width = .2)) + 
  stat_summary(aes(group=relprime), fun.y = mean, geom="point", colour="white", size=3) +
  theme(legend.position='none')
# recall
ggplot(srlike, aes(relprime, vrecall)) + 
  geom_boxplot(aes(fill=relprime), alpha=I(0.5)) + 
  geom_jitter(aes(color=relprime), size=2, position = position_jitter(width = .2)) + 
  stat_summary(aes(group=relprime), fun.y = mean, geom="point", colour="white", size=3) +
  theme(legend.position='none')

## WITHIN DISLIKE
# message
ggplot(srdislike, aes(relprime, vmessage)) + 
  geom_boxplot(aes(fill=relprime), alpha=I(0.5)) + 
  geom_jitter(aes(color=relprime), size=2, position = position_jitter(width = .2)) + 
  stat_summary(aes(group=relprime), fun.y = mean, geom="point", colour="white", size=3) +
  theme(legend.position='none')
# recall 
ggplot(srdislike, aes(relprime, vrecall)) + 
  geom_boxplot(aes(fill=relprime), alpha=I(0.5)) + 
  geom_jitter(aes(color=relprime), size=2, position = position_jitter(width = .2)) + 
  stat_summary(aes(group=relprime), fun.y = mean, geom="point", colour="white", size=3) +
  theme(legend.position='none')


##### MULTIPLE REGRESSIONS: MESSAGE & RECALL VALENCE ####

#interaction of relprime x audience attitude, controlling for independence
sr.rel.att.mess <- lm(vmessage ~ attitudedum * relprimedum + independence, data=srp)
summary(sr.rel.att.mess) #main effect of attitude 

sr.rel.att.rec <- lm(vrecall ~ attitudedum * relprimedum + independence, data=srp)
summary(sr.rel.att.rec) #main effect of attitude 


#interaction of audience attitude x independence
sr.rel.att.mess <- lm(vmessage ~ attitudedum * independence, data=srp)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ attitudedum * independence, data=srp)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ attitudedum + independence, data=srp)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ attitudedum + independence, data=srp)
summary(sr.rel.att.rec) #ns 


sr.rel.att.mess <- lm(vmessage ~ attitudedum * anx, data=srp)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ attitudedum * anx, data=srp)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ attitudedum * avoid, data=srp)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ attitudedum * avoid, data=srp)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ attitudedum * ass, data=srp)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ attitudedum * ass, data=srp)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ attitudedum * loc, data=srp)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ attitudedum * loc, data=srp)
summary(sr.rel.att.rec) #ns 

####

#looking at independence withith each audience attitude condition:
sr.rel.att.mess <- lm(vmessage ~ independence, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~independence, data=srlike)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ independence, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~independence, data=srdislike)
summary(sr.rel.att.rec) #ns 

#looking at ass withith each audience attitude condition ***
sr.rel.att.mess <- lm(vmessage ~ ass, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ ass, data=srlike)
summary(sr.rel.att.rec) #SIG*

sr.rel.att.mess <- lm(vmessage ~ ass, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ ass, data=srdislike)
summary(sr.rel.att.rec) #ns 

#looking at loc withith each audience attitude condition:
sr.rel.att.mess <- lm(vmessage ~ loc, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ loc, data=srlike)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ loc, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ loc, data=srdislike)
summary(sr.rel.att.rec) #ns 


#looking at locomassess withith each audience attitude condition:
sr.rel.att.mess <- lm(vmessage ~ locomassess, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ locomassess, data=srlike)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ locomassess, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ locomassess, data=srdislike)
summary(sr.rel.att.rec) #ns 


#looking at prommprev withith each audience attitude condition ***
sr.rel.att.mess <- lm(vmessage ~ prommprev, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ prommprev, data=srlike)
summary(sr.rel.att.rec) #SIG*

sr.rel.att.mess <- lm(vmessage ~ prommprev, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ prommprev, data=srdislike)
summary(sr.rel.att.rec) #ns 

#looking at prom withith each audience attitude condition:
sr.rel.att.mess <- lm(vmessage ~ prom, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ prom, data=srlike)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ prom, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ prom, data=srdislike)
summary(sr.rel.att.rec) #ns 

#looking at prev withith each audience attitude condition ***
sr.rel.att.mess <- lm(vmessage ~ prev, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ prev, data=srlike)
summary(sr.rel.att.rec) # SIG*

sr.rel.att.mess <- lm(vmessage ~ prev, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ prev, data=srdislike)
summary(sr.rel.att.rec) #ns 


#looking at belong withith each audience attitude condition:
sr.rel.att.mess <- lm(vmessage ~ belong, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ belong, data=srlike)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ belong, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ belong, data=srdislike)
summary(sr.rel.att.rec) #ns 

#looking at authority withith each audience attitude condition:
sr.rel.att.mess <- lm(vmessage ~ authority, data=srlike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ authority, data=srlike)
summary(sr.rel.att.rec) #ns 

sr.rel.att.mess <- lm(vmessage ~ authority, data=srdislike)
summary(sr.rel.att.mess) #ns
sr.rel.att.rec <- lm(vrecall ~ authority, data=srdislike)
summary(sr.rel.att.rec) #ns 



##### PRIME MAIN EFFECTS ####

prime.close <- aov(closeness ~ relprimedum, data=srp)
summary(prime.close) #ns

prime.ntb <- aov(belong ~ relprimedum, data=srp)
summary(prime.ntb) #ns

prime.reltrust <- aov(reltrust ~ relprimedum, data=srp)
summary(prime.reltrust) #ns
prime.epistrust <- aov(epistrust ~ relprimedum, data=srp)
summary(prime.epistrust) #ns
prime.messtrust <- aov(messtrust ~ relprimedum, data=srp)
summary(prime.messtrust) #ns

prime.anx <- aov(anx ~ relprimedum, data=srp)
summary(prime.anx) #ns
prime.avoid <- aov(avoid ~ relprimedum, data=srp)
summary(prime.avoid) #ns

#prime effects on independence ***
prime.independence <- aov(independence ~ relprimedum, data=srp)
summary(prime.independence) #sig*

summaryBy(independence ~ relprime, FUN = c(mean,sd), data=srp) #dissolved=4.325, stable=4.01

#graph of effect of rel prime on independence
ggplot(srp, aes(relprime, independence)) + 
  geom_boxplot(aes(fill=relprime), alpha=I(0.5)) + 
  geom_jitter(aes(color=relprime), size=2, position = position_jitter(width = .2)) + 
  stat_summary(aes(group=relprime), fun.y = mean, 
               geom="point", colour="white", size=4) +
  theme(legend.position='none')

#prime effects on Regmode ***
prime.loc <- aov(loc ~ relprimedum, data=srp)
summary(prime.loc) #sig*

summaryBy(loc ~ relprime, FUN = c(mean,sd), data=srp) #dissolved=4.525, stable=4.27

ggplot(srp, aes(relprime, loc)) + 
  geom_boxplot(aes(fill=relprime), alpha=I(0.5)) + 
  geom_jitter(aes(color=relprime), size=2, position = position_jitter(width = .2)) + 
  stat_summary(aes(group=relprime), fun.y = mean, 
               geom="point", colour="white", size=4) +
  theme(legend.position='none')


prime.ass <- aov(ass ~ relprimedum, data=srp)
summary(prime.ass) #ns

prime.authority <- aov(authority ~ relprimedum, data=srp)
summary(prime.authority) #ns

#### REGRESSIONS: Scales ####

#regressions other dvs with mode ***
sr.test <- lm(independence ~ ass, data=srp)
summary(sr.test) #ns
sr.test <- lm(independence ~ loc, data=srp)
summary(sr.test) #SIG*

sr.test <- lm(loc ~ relprime + independence, data=srp)
summary(sr.test) #ns, just indep (so this might be evidence of partial mediation???)
sr.test <- lm(independence ~ relprime + loc, data=srp)
summary(sr.test) #SIG*

#regressions other dvs with mode
sr.test <- lm(epistrust ~ ass, data=srp)
summary(sr.test) #ns
sr.test <- lm(epistrust ~ loc, data=srp)
summary(sr.test) #ns

sr.test <- lm(closeness ~ ass, data=srp)
summary(sr.test) #ns
sr.test <- lm(closeness ~ loc, data=srp)
summary(sr.test) #ns

sr.test <- lm(reltrust ~ ass, data=srp)
summary(sr.test) #ns
sr.test <- lm(reltrust ~ loc, data=srp)
summary(sr.test) #ns

sr.test <- lm(messtrust ~ ass, data=srp)
summary(sr.test) #ns
sr.test <- lm(messtrust ~ loc, data=srp)
summary(sr.test) #ns


#regressions other dvs with focus
sr.test <- lm(epistrust ~ prom, data=srp)
summary(sr.test) #ns
sr.test <- lm(epistrust ~ prev, data=srp)
summary(sr.test) #ns

sr.test <- lm(closeness ~ prom, data=srp)
summary(sr.test) #ns
sr.test <- lm(closeness ~ prev, data=srp)
summary(sr.test) #ns

sr.test <- lm(reltrust ~ prom, data=srp)
summary(sr.test) #ns
sr.test <- lm(reltrust ~ prev, data=srp)
summary(sr.test) #ns

sr.test <- lm(messtrust ~ prom, data=srp)
summary(sr.test) #ns
sr.test <- lm(messtrust ~ prev, data=srp)
summary(sr.test) #ns


#regressions other dvs with independence ***
sr.test <- lm(epistrust ~ independence, data=srp)
summary(sr.test) #ns

sr.test <- lm(closeness ~ independence, data=srp)
summary(sr.test) #SIG*

sr.test <- lm(reltrust ~ independence, data=srp)
summary(sr.test) #SIG*

sr.test <- lm(messtrust ~ independence, data=srp)
summary(sr.test) #SIG*

#regressions other dvs with authority ***
sr.test <- lm(epistrust ~ authority, data=srp)
summary(sr.test) #ns

sr.test <- lm(closeness ~ authority, data=srp)
summary(sr.test) #SIG*

sr.test <- lm(reltrust ~ authority, data=srp)
summary(sr.test) #ns

sr.test <- lm(messtrust ~ authority, data=srp)
summary(sr.test) #ns

#regressions other dvs with attachment
sr.test <- lm(epistrust ~ anx, data=srp)
summary(sr.test) #ns
sr.test <- lm(epistrust ~ avoid, data=srp)
summary(sr.test) #ns

sr.test <- lm(closeness ~ anx, data=srp)
summary(sr.test) #ns
sr.test <- lm(closeness ~ avoid, data=srp)
summary(sr.test) #ns

sr.test <- lm(reltrust ~ anx, data=srp)
summary(sr.test) #ns
sr.test <- lm(reltrust ~ avoid, data=srp)
summary(sr.test) #ns

sr.test <- lm(messtrust ~ anx, data=srp)
summary(sr.test) #ns
sr.test <- lm(messtrust ~ avoid, data=srp)
summary(sr.test) #ns


