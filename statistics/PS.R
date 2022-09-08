# ------------------------------------------------------------------------------
# Verification of the referential used by motor control in reaching movements
#
# Description: This code will perform the statistical analysis of this project,
# checking if there is a significant difference between the three reference
# systems through a mixed linear model, where we compare the fixed effects
# (i.e. the change of the reference) taking into account the random effects
# (caused by the presence of different individuals).
#
#
# ------------------------------------------------------------------------------


# Necessary packages -----------------------------------------------------------

library(lme4)

# Performing the statistical analysis for W-------------------------------------

indices_MED <- read.csv("../output/random_PS_MED.csv")                          # Reading output table

model_W <- lme4::lmer(w ~ cs + (1|ind),                                         # Making the linear model with mixed effects (Fixed effect being
                      indices_MED)                                              # the referential and random effect being the difference between individuals)

null_model_W <- lme4::lmer(w ~  1  + (1|ind), indices_MED)                      # Making the linear model without the fixed effect (null-model)

summary(model_W)

anova(model_W, null_model_W)                                                    # Model selection to verify which model better explains the data

# For R^2 ----------------------------------------------------------------------

model_R2 <- lme4::lmer(r2 ~ cs + (1|ind),                                       # Making the linear model with mixed effects (Fixed effect being
                       indices_MED)                                             # the referential and random effect being the difference between individuals)

null_model_R2 <- lme4::lmer(r2 ~  1  + (1|ind), indices_MED)                    # Making the linear model without the fixed effect (null-model)

summary(model_R2)

anova(model_R2, null_model_R2)                                                  # Model selection to verify which model better explains the data
