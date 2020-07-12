#!/bin/sh

# To-do list:
# 1. Better at finding what is a release
# 2. Empty directories
# 3. Subs with only one file

# -----------------------------------------------------------------

mkdir -p "./logs/$1"

# -----------------------------------------------------------------
# Missing samples
# -----------------------------------------------------------------

find $1 -type d -links 2 | egrep '/[^/]+\.[^/]+\.[^/]*-[^/]+' | egrep -iv '/(((CD)[0-999])|Extras|Proof|Sample|Subs|Vobsubs|)$' | egrep -iv '(FIX(\.|-)|SUBPACK)' | sort > "./logs/$1/missing_samples"

find $1 -type d -links 2 | sed -r 's|/[^/]+$||' | uniq | sort > 'temp1'
find $1 -type d -links 2 | egrep -i '/Sample$' | sed -r 's|/[^/]+$||' | sort > 'temp2'

comm -23 'temp1' 'temp2' | egrep '/[^/]+\.[^/]+\.[^/]*-[^/]+' | uniq >> "./logs/$1/missing_samples"

rm 'temp1'
rm 'temp2'

# -----------------------------------------------------------------
# Multiple files
# -----------------------------------------------------------------

find -E $1 -type f | egrep -i '.*\.(nfo)$' | sed -r 's|/[^/]+$||' | sort | uniq -d > "./logs/$1/multiple_files"
find -E $1 -type f | egrep -i '.*\.(sfv)$' | sed -r 's|/[^/]+$||' | sort | uniq -d >> "./logs/$1/multiple_files"
find -E $1 -type f | egrep -i '.*\.(avi|mkv|mp4|mpg)$' | sed -r 's|/[^/]+$||' | sort | uniq -d >> "./logs/$1/multiple_files"
find -E $1 -type f | egrep -i '.*\.(jpg)$' | sed -r 's|/[^/]+$||' | sort | uniq -d >> "./logs/$1/multiple_files"

# -----------------------------------------------------------------
# Unwanted files
# -----------------------------------------------------------------

find -E $1 -type f -not -regex '.*\.(avi|jpg|mkv|mp4|mpg|nfo|r[0-9]+|rar|sfv)$' | sort > "./logs/$1/unwanted_files"
find $1 -type f | egrep -i '.*\.(jpg)$' | egrep -iv '/Proof/' | sort >> "./logs/$1/unwanted_files"
find $1 -type f | egrep -i '.*\.(avi|mkv|mp4|mpg)$' | egrep -i '((/.*(SVCD|VCD|XViD).*/.*.mkv)|(/.*(x264).*/.*.(avi|mp4|mpg)))$' >> "./logs/$1/unwanted_files"
find $1 -type f | egrep -i '.*/Proof/.*' | egrep -iv '.*\.(jpg)$' | sort >> "./logs/$1/unwanted_files"
find $1 -type f | egrep -i '.*/Sample/.*' | egrep -iv '.*\.(avi|mkv|mp4|mpg)$' | sort >> "./logs/$1/unwanted_files"
find $1 -type f | egrep -i '.*/Subs/.*' | egrep -iv '.*\.(r[0-9]+|rar|sfv)$' | sort >> "./logs/$1/unwanted_files"

# -----------------------------------------------------------------
# Unwanted capitalizations
# -----------------------------------------------------------------

find $1 -type d -links 2 | egrep '/[^/]+\.[^/]+\.[^/]*-[^/]+' | egrep -i '/(((CD)[0-999])|Extras|Proof|Subs|Sample|Vobsubs|)$' | egrep -v '/(((CD)[0-999])|Extras|Proof|Subs|Sample|Vobsubs|)$' | sort > "./logs/$1/unwanted_capitalizations"

# -----------------------------------------------------------------

find "./logs/$1/" -type f -empty -delete

# -----------------------------------------------------------------
