// ==========================================================================

// Lab 10 Replication

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// confirm necessary packages present

which markdoc

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
  cd "/Users/`c(username)'/Desktop"
}
else if "`c(os)'" == "Windows" {
  cd "E:/Users/`c(username)'/Desktop"
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if source data exists

// does not work with online files

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if appropriate directories exist

global projName "Lab-10-Replication"
capture mkdir $projName

capture mkdir "$projName/CodeArchive"
capture mkdir "$projName/Plots"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using "$projName/$projName.txt", text replace

// ==========================================================================

/*
file name - master.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Replicate's Lab 10 - Difference of Means (2)

created - 05 Nov 2016

updated - 05 Nov 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file replicates Lab 10, which involves running a number of different
one-sample, independent samples, and dependent samples t-tests.
*/

/*
updates -
none
*/

// ==========================================================================

/*
superordinates  -
- hsb2.dta
*/

/*
subordinates -
- data.do
- analysis.do
*/

// ==========================================================================

// copy source data to new directory

use "http://www.ats.ucla.edu/stat/stata/notes/hsb2", clear
global newData "standardTestData.dta"
save "$projName/$newData", replace

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. execute data cleaning file
// do "data.do"

// 2. execute data analysis / markdoc file
do "analysis.do"

// ==========================================================================
// ==========================================================================
// ==========================================================================

// copy code to code archive

copy "master.do" "$projName/CodeArchive/master.do", replace
// copy "data.do" "$projName/CodeArchive/data.do", replace
copy "analysis.do" "$projName/CodeArchive/analysis.do", replace

// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
