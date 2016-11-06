Lab 11
======

-   SOC 5050: Quantitative Analysis
-   05 Nov 2016
-   CHRIS

### Part 1 - One-Sample T-Test

```stata
.  ttest socst==54

One-sample t test
------------------------------------------------------------------------------
Variable |     Obs        Mean    Std. Err.   Std. Dev.   [95% Conf. Interval]
---------+--------------------------------------------------------------------
   socst |     200      52.405    .7591352    10.73579    50.90802    53.90198
------------------------------------------------------------------------------
    mean = mean(socst)                                            t =  -2.1011
Ho: mean = 54                                    degrees of freedom =      199

    Ha: mean < 54               Ha: mean != 54                 Ha: mean > 54
 Pr(T < t) = 0.0184         Pr(|T| > |t|) = 0.0369          Pr(T > t) = 0.9816
 ```

![fig1](https://raw.githubusercontent.com/slu-soc5050/Week-10/master/Lab/Lab-10-Replication/Plots/fig1.png)

**1.** The results of the one-sample t-test (t = -2.101; p = .037) indicate that these data are not drawn from where the average score is 54.


```stata
. ttest science==54

One-sample t test
------------------------------------------------------------------------------
Variable |     Obs        Mean    Std. Err.   Std. Dev.   [95% Conf. Interval]
---------+--------------------------------------------------------------------
 science |     200       51.85    .7000987    9.900891    50.46944    53.23056
------------------------------------------------------------------------------
    mean = mean(science)                                          t =  -3.0710
Ho: mean = 54                                    degrees of freedom =      199

    Ha: mean < 54               Ha: mean != 54                 Ha: mean > 54
 Pr(T < t) = 0.0012         Pr(|T| > |t|) = 0.0024          Pr(T > t) = 0.9988
 ```

![fig2](https://raw.githubusercontent.com/slu-soc5050/Week-10/master/Lab/Lab-10-Replication/Plots/fig2.png)

**2.** Like question **1**, the results of the one-sample t-test (t = -3.071; p = .002) indicate that these data are not drawn from where the average score is 54.

### Part 2 - Independent T-Test

```
.  sdtest science, by(female)

Variance ratio test
------------------------------------------------------------------------------
   Group |     Obs        Mean    Std. Err.   Std. Dev.   [95% Conf. Interval]
---------+--------------------------------------------------------------------
    male |      91    53.23077    1.125037    10.73217    50.99569    55.46585
  female |     109    50.69725    .8657315    9.038503    48.98122    52.41328
---------+--------------------------------------------------------------------
combined |     200       51.85    .7000987    9.900891    50.46944    53.23056
------------------------------------------------------------------------------
    ratio = sd(male) / sd(female)                                 f =   1.4099
Ho: ratio = 1                                    degrees of freedom =  90, 108

    Ha: ratio < 1               Ha: ratio != 1                 Ha: ratio > 1
  Pr(F < f) = 0.9562         2*Pr(F > f) = 0.0876           Pr(F > f) = 0.0438
  ```



**3.** The results of the Levene's test (f = 1.410; p = 0.088) indicate that the assumption of homogenetiy of variance holds for these data. The variance of science scores for men is not significantly different from the variance of science scores for women.

```stata
. ttest science, by(female)

Two-sample t test with equal variances
------------------------------------------------------------------------------
   Group |     Obs        Mean    Std. Err.   Std. Dev.   [95% Conf. Interval]
---------+--------------------------------------------------------------------
    male |      91    53.23077    1.125037    10.73217    50.99569    55.46585
  female |     109    50.69725    .8657315    9.038503    48.98122    52.41328
---------+--------------------------------------------------------------------
combined |     200       51.85    .7000987    9.900891    50.46944    53.23056
---------+--------------------------------------------------------------------
    diff |            2.533522    1.397901                -.223164    5.290207
------------------------------------------------------------------------------
    diff = mean(male) - mean(female)                              t =   1.8124
Ho: diff = 0                                     degrees of freedom =      198

    Ha: diff < 0                 Ha: diff != 0                 Ha: diff > 0
 Pr(T < t) = 0.9643         Pr(|T| > |t|) = 0.0714          Pr(T > t) = 0.0357


.  esize twosample science, by(female) cohensd

Effect size based on mean comparison

                               Obs per group:
                                        male =         91
                                      female =        109
---------------------------------------------------------
        Effect Size |   Estimate     [95% Conf. Interval]
--------------------+------------------------------------
          Cohen's d |    .257353    -.0224299    .5364914
---------------------------------------------------------
```

![fig3](https://raw.githubusercontent.com/slu-soc5050/Week-10/master/Lab/Lab-10-Replication/Plots/fig3.png)

**5.** The results of the independent t-test (t = 1.812; p = .0714; d = .257) indicate that there is not a substantive difference in mean science scores between males and fe males in this sample.

**6.** The results of the Cohen's d test (d = .257) are consistent with there not being a substantive difference in mean science scores by gender - the reported effect size is small.

### Part 3 - Dependent T-test

```stata
.  ttest write==socst

Paired t test
------------------------------------------------------------------------------
Variable |     Obs        Mean    Std. Err.   Std. Dev.   [95% Conf. Interval]
---------+--------------------------------------------------------------------
   write |     200      52.775    .6702372    9.478586    51.45332    54.09668
   socst |     200      52.405    .7591352    10.73579    50.90802    53.90198
---------+--------------------------------------------------------------------
    diff |     200         .37    .6403638    9.056112   -.8927696     1.63277
------------------------------------------------------------------------------
     mean(diff) = mean(write - socst)                             t =   0.5778
 Ho: mean(diff) = 0                              degrees of freedom =      199

 Ha: mean(diff) < 0           Ha: mean(diff) != 0           Ha: mean(diff) > 0
 Pr(T < t) = 0.7180         Pr(|T| > |t|) = 0.5641          Pr(T > t) = 0.2820
 ```

![fig4](https://raw.githubusercontent.com/slu-soc5050/Week-10/master/Lab/Lab-10-Replication/Plots/fig4.png)

**8.** The results of the dependent t-test (t = .578; p = 0.564; d = .257) indicate that there is not a substantive difference between mean writing and social science s cores in this sample.

### Part 4 - Power Analyses

```stata
. local effectSize = 9.900891*.2

. local lowerMean = 53-`effectSize'

. power twomeans 53 `lowerMean', sd(9.900891) power(0.8)

Performing iteration ...

Estimated sample sizes for a two-sample means test
t test assuming sd1 = sd2 = sd
Ho: m2 = m1  versus  Ha: m2 != m1

Study parameters:

        alpha =    0.0500
        power =    0.8000
        delta =   -1.9802
           m1 =   53.0000
           m2 =   51.0198
           sd =    9.9009

Estimated sample sizes:

            N =       788
  N per group =       394
  ```

**10.** Based on the output above in question **5**, we estimate a mean science score for men as 53, for women as 51.020, with a standard deviation of 9.901, as pilot data to construct the power analysis. To detect a small effect size with a power of 0.8, a sample size of 788 would be required with a minimum of 394 in each group.

```stata
. local effectSize = 9.900891\*.5

. local lowerMean = 53-`effectSize'

.  power twomeans 53 `lowerMean', sd(9.900891) power(0.9)

Performing iteration ...

Estimated sample sizes for a two-sample means test
t test assuming sd1 = sd2 = sd
Ho: m2 = m1  versus  Ha: m2 != m1

Study parameters:

      alpha =    0.0500
      power =    0.9000
      delta =   -4.9504
         m1 =   53.0000
         m2 =   48.0496
         sd =    9.9009

Estimated sample sizes:

          N =       172
N per group =        86
```

**11.** Based on the output above in question **5**, we estimate a mean science score for men as 53, for women as 48.050, with a standard deviation of 9.901, as pilot data to con struct the power analysis. To detect a moderate effect size with a power of 0.9, a sample size of 172 would be required with a minimum of 86 in each group.

```stata
. local effectSize = 9.900891\*.8

. local lowerMean = 53-`effectSize'

.  power twomeans 53 `lowerMean', sd(9.900891) power(0.9)

Performing iteration ...

Estimated sample sizes for a two-sample means test
t test assuming sd1 = sd2 = sd
Ho: m2 = m1  versus  Ha: m2 != m1

Study parameters:

        alpha =    0.0500
        power =    0.9000
        delta =   -7.9207
           m1 =   53.0000
           m2 =   45.0793
           sd =    9.9009

Estimated sample sizes:

            N =        68
  N per group =        34
```

**12.** Based on the output above in question **5**, we estimate a mean science score for men as 53, for women as 45.079, with a standard deviation of 9.901as pilot data to con struct the power analysis. To detect a large effect size with a power of 0.8, a sample size of 68 would be required with a minimum of 34 in each group. 
