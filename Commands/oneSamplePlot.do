// ==========================================================================

// Minimal Working Example - One Sample T-Test Plot

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

// one sample t-test
ttest mpg==25

// store value of t
local t = round(r(t),.001)

// store value of p - p < 0.0001 in this example
// local p = round(r(p),.001)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// collapse dataset
collapse (mean) meanMpg = mpg (sd) sdMpg = mpg (count) n=mpg

// calculate standard error
generate seMpg = sdMpg/sqrt(n)

// generate categorical variable
generate cat = 1

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// simple serrbar example
serrbar meanMpg seMpg cat, scale(1.96) scheme(s2mono)

graph export fig1a.png, as(png) width(1000) height(750) replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// complex serrbar example
serrbar meanMpg seMpg cat, scale(1.96) ///
	yline(25, lcolor(red)) yscale(r(18.9 26.1)) ///
	ylabel(19(1)26, grid) ytitle("Mean Miles per Gallon") ///
	xlabel(none) xtitle("") ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235") ///
	title("One Sample T-Test: Miles per Gallon and {&mu}=25") ///
	subtitle("1978 Automobiles") ///
	text(25.1 1 "{&mu}", place(n)) ///
	note("Results: {it:t} = `t', {it:p} < 0.001") ///
	caption("Produced by Christopher Prener, Ph.D.; Data via Stata")

graph export fig1b.png, as(png) width(1000) height(750) replace

// ==========================================================================

exit
