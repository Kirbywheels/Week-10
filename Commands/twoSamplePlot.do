// ==========================================================================

// Minimal Working Example - Independent Sample T-Test Plot

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
  cd "/Users/`c(username)'/Desktop"
}
else if "`c(os)'" == "Windows" {
  cd "E:/Users/`c(username)'/Desktop"
}

// ==========================================================================

// open auto.dta dataset preinstalled with Stata
sysuse auto.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// independent sample t-test
ttest mpg, by(foreign)

// store value of t
local t = round(r(t),.001)

// store value of p
local p = round(r(p),.0001)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// cohen's d effect size
esize twosample mpg, by(foreign) cohensd

// store value of d
local d = round(r(d),.001)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// collapse dataset
collapse (mean) meanMpg = mpg (sd) sdMpg = mpg (count) n=mpg, by(foreign)

// calculate standard error
generate seMpg = sdMpg/sqrt(n)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// simple serrbar example
serrbar meanMpg seMpg foreign, scale(1.96) ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235")

graph export fig2a.png, as(png) width(1000) height(750) replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// complex serrbar example
serrbar meanMpg seMpg foreign, scale(1.96) ///
	ytitle("Mean Miles per Gallon") ///
	xscale(r(-.2 1.2)) ///
	xlabel(0 "domestic" 1 "foreign") xtitle("Car Origin") ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235") ///
	title("Two Sample T-Test: Miles per Gallon by Car Type") ///
	subtitle("1978 Automobiles") ///
	note("Results: {it:t} = `t', {it:p} = `p', Cohen's {it:d} = `d'") ///
	caption("Produced by Christopher Prener, Ph.D.; Data via Stata")

graph export fig2b.png, as(png) width(1000) height(750) replace

// ==========================================================================

exit
