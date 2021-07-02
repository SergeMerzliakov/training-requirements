# Tic Tac Toe

This is a basic Tic-Tac-Toe game written in R. It can be run from inside R studio or from the command
line.



## Running The Game

From the repository base directory run:

        Rscript start.R 


## Running the Unit Tests

This will execute all tests from the repository. From the repository base directory run:

        Rscript run_tests.R 


And provide output similar to:

    ✔ |  OK F W S | Context
    ✔ |  18       | ai [0.1 s]
    ✔ |  32       | model
    
    ══ Results ═══════════════════
    Duration: 0.3 s
    
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 50 ]

The number of unit tests is not exhaustive, and provides guidance for a more complete set of unit
tests to be written.

**Note**: There are no automated functional tests to automate the testing of all 765 different positions, or
the 26,830 possible games.

## Project File Structure


| Directory/File | Details |
|----------|-------------------------------|
| /src | source code |
| /tests | unit test code |
| start.R | script to start main game loop |
| run_tests.R | test harness to run all "testthat" unit test |


## Limitations and Outstanding Issues

* Some control characters (Control-C) not handled on some of the inputs on Unix based operating systems, and will terminate the program prematurely.
* Not fully tested in Windows operating systems.


## Software Version Details

    R version 4.1.0 (2021-05-18)
 
    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base
    
    other attached packages:
    [1] testthat_3.0.3
