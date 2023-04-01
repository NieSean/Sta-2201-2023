/* Simple linear regression */
data {
  int<lower=0> N_data;                // number of observations
  int<lower=0> N_sex;                 // number of sex levels
  int<lower=0> N_type;                // number of animal types
  int<lower=0, upper=1> y[N_data];    // outcome: 0 not adopted, 1 adopted,
  int<lower=1, upper=4> sex[N_data];  // sex: 1 intact female, 2 spayed female, 
                                      //      3 intact male, 4 neutered male
  int<lower=1, upper=2> type[N_data]; // type: 1 cat, 2 dog
  int<lower=0> month[N_data];         // nth month starting at 2013/10
  int<lower=0> age[N_data];           // age in days
}

parameters {
  real beta_0;
  real beta_type[N_type];
  real beta_sex[N_sex];
  real beta_age;
  real beta_month;
  
  real mu_cat;
  real mu_dog;
  real mu_female;
  real mu_male;
  
  real<lower = 0> sigma_cat;
  real<lower = 0> sigma_dog;
  real<lower = 0> sigma_female;
  real<lower = 0> sigma_male;
}

transformed parameters{
  vector[N_data] phi;
  
  for (i in 1:N_data) {
    phi[i] = beta_0 + beta_type[type[i]] + beta_sex[sex[i]] + beta_age*age[i] + beta_month*month[i];
  }
}

model {
  // priors
  beta_0 ~ normal(0, 1);
  beta_type[1] ~ normal(mu_cat, sigma_cat);
  beta_type[2] ~ normal(mu_dog, sigma_dog);
  beta_sex[1:2] ~ normal(mu_female, sigma_female);
  beta_sex[3:4] ~ normal(mu_male, sigma_male);
  beta_age ~ normal(0, 1);
  beta_month ~ normal(0, 1);
  
  mu_cat ~ normal(0, 1);
  mu_dog ~ normal(0, 1);
  mu_female ~ normal(0, 1);
  mu_male ~ normal(0, 1);
  
  sigma_cat ~ normal(0, 1);
  sigma_dog ~ normal(0, 1);
  sigma_female ~ normal(0, 1);
  sigma_male ~ normal(0, 1);
  
  // model
  y ~ bernoulli_logit(phi);
}




generated quantities {

}
