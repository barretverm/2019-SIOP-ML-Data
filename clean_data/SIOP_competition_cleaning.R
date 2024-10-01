######## SIOP 2019 Machine Learning Competition Full Dataset Cleaning ########


# Load datasets ----
full <- read.csv('Full_Complete_DS_01_14_19 - Full_Complete_DS_01_14_19.csv')
public <- read.csv('2019_siop_ml_comp_data.csv')

# Compare dimensions
dim(full)    # n = 1960
dim(public)  # n = 1688

# Prepare dataset ----
# Match respondent ID names for merger
colnames(full)[colnames(full) == "Respondent.ID"] <- "Respondent_ID"

# Map the raw dataset to the public competition dataset
df <- merge(full, public, "Respondent_ID")
dim(df) # 1688 - sample sizes now match

# Reorder data to match 'Respondent_IDs' in public data for consistency checks
df <- df[match(public$Respondent_ID, df$Respondent_ID), ]
all(public$Respondent_ID == df$Respondent_ID) # verify

# Check that all IDs from the public dataset are in the merged dataset
setdiff(public$Respondent_ID, df$Respondent_ID)


# Process BFI-2 items ----
names(df)
scale_scores <- df[,c(14:78)] # isolate scale scores for processing
dim(scale_scores) # item numbers don't match - need to omit attention checks

## Remove attention checks ----
# Match and remove items containing "attention"
names(scale_scores)
scale_scores <- scale_scores[, !grepl("attention", names(scale_scores))]
dim(scale_scores) # 3 left
# Index/remove the rest
names(scale_scores) # cases 19, 39, and 62 are attention checks
scale_scores <- scale_scores[,-c(19, 39, 62)]
dim(scale_scores)

## Change item names ----
# Read in file with items and scoring key
scale_key <- read.csv('BFI-2 Items.csv')

# Create item ID vector
reverse_code <- ifelse(scale_key$reverse==1,"R", NA) # change "1" to "R"
reverse_code[is.na(reverse_code)] <- "" # replace NA with ""
item_ids <- paste(scale_key$item_id, reverse_code, sep="") # concatenate
names(scale_scores) <- item_ids # rename items
names(scale_scores)

## Reverse code ----
library(dplyr)
# Reverse code items that end with "R"
scale_scores <- scale_scores %>% 
  mutate(across(ends_with("R"), ~ 6 -.)) 

## Separate by trait ----
open <- scale_scores[,startsWith(names(scale_scores), "O")]
cons <- scale_scores[,startsWith(names(scale_scores), "C")]
extra <- scale_scores[,startsWith(names(scale_scores), "E")]
agree <- scale_scores[,startsWith(names(scale_scores), "A")]
neuro <- scale_scores[,startsWith(names(scale_scores), "N")]

## Mean score ----
O_Scale_score <- rowMeans(open)
C_Scale_score <- rowMeans(cons)
E_Scale_score <- rowMeans(extra)
A_Scale_score <- rowMeans(agree)
N_Scale_score <- rowMeans(neuro)

## Verify ----
all.equal(df$O_Scale_score, O_Scale_score, check.names=F)
all.equal(df$C_Scale_score, C_Scale_score, check.names=F)
all.equal(df$E_Scale_score, E_Scale_score, check.names=F)
all.equal(df$A_Scale_score, A_Scale_score, check.names=F)
all.equal(df$N_Scale_score, N_Scale_score, check.names=F)

# The mean scores were compared to the competition dataset, and verify that the 
# items were labeled and reverse-scored correctly.
# I'll retain the original competition mean scores in the final dataset.

# Prepare final dataset ----
## Rename variables ----
df <- df %>%
  rename(
    gender = What.is.your.gender.,
    country = In.what.country.do.you.currently.reside.,
    country_other = Other..please.specify.,
    race = Are.you.White..Black.or.African.American..American.Indian.or.Alaskan.Native..Asian..Native.Hawaiian.or.other.Pacific.islander..or.some.other.race..,
    race_other = Some.other.race..please.specify.,
    age = What.is.your.age.,
    education = What.is.the.highest.level.of.education.you.have.completed.,
    # labeling the open-ended question traits
    A_open_ended_Q1 = open_ended_1,
    C_open_ended_Q2 = open_ended_2,
    E_open_ended_Q3 = open_ended_3,
    N_open_ended_Q4 = open_ended_4,
    O_open_ended_Q5 = open_ended_5
  )

## Order variables ----
order1 <- df[, c("Respondent_ID","A_open_ended_Q1",
                "C_open_ended_Q2","E_open_ended_Q3",
                "N_open_ended_Q4","O_open_ended_Q5",
                "A_Scale_score","C_Scale_score",                                                                                                                          
                "E_Scale_score","N_Scale_score",                                                                                                                          
                "O_Scale_score"
                )]

order2 <- as.data.frame(c(agree, cons, extra, neuro, open))

order3 <- df[, c("Q1_length","Q2_length",
                "Q3_length","Q4_length",
                "Q5_length","gender","country",
                "country_other","race","race_other",
                "age","education","Dataset"
                )]

clean <- cbind(order1, order2, order3)

# Write final dataset to csv ----
write.csv(clean, "2019_SIOP_ML_Full_Clean.csv", row.names = F)




# Prepared by Barret J. Vermilion
# barret.vermilion@gmail.com




