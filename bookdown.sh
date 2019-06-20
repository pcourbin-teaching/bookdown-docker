#!/bin/sh
#set -ev
temp="ALL"
type=${1:-$temp}
cd /book

if [ "$type" = "ALL" ]; then
  Rscript -e "bookdown::render_book('$mainFile', 'all')"
elif [ "$type" = "help" ] || [ "$type" = "--help" ] ; then
    echo "**********************************************************"
    echo "You can use:"
    echo "\thelp -> Display this help message"
    echo "\tbookdown -> create a HTML, PDF and EPUB version"
    echo "\tbookdown TYPE -> run \"bookdown::render_book\" for your TYPE, i.e.:"
    echo "\t\tbookdown gitbook -> create a HTML gitbook version"
    echo "\t\tbookdown pdf_book -> create a PDF version"
    echo "\t\tbookdown epub_book -> create a EPUB version"
    echo "**********************************************************"
else
  Rscript -e "bookdown::render_book('$mainFile', 'bookdown::$type')"
fi
