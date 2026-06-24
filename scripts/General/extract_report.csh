#!/bin/csh
#####################################################################################
# Description:  Extracting Timing Report Script
#####################################################################################
if ($#argv != 1) then
    echo "Usage: extract_report.csh <directory>"
    exit 1
endif

set directory = $argv[1]

cd $directory

foreach file (*.gz)
    gzip -df "$file"
end
