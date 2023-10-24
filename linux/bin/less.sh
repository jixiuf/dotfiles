#!/bin/bash

# Call emacsclient as a pager.
# First, read in the content of stdin into a temporary file
mkdir -p /tmp/pager

# t='/tmp/pager/*pager*'
t=$(mktemp /tmp/pager/*pager-XXXXXX*) || exit 1

# Remove terminal escape sequences (color and move, as well as some funky starship stuff)
# cat - \
#    | sed 's/\x1b\[[0-9;:]*[mGKH]//g' \
#    | sed 's/\x1b\][0-9;:]*[AC]\x1b\\//g' \
#     >> $t
cat - > "$t"
emacsclient   -t "$t"
rm -f $t
