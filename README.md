# clean-share-scrips

None of the following scripts are finished in any way. More like drafts.

find_unclean_files.sh
Finds unclean files in the given (share) directory. Puts lists of the unclean files in './logs/'.

Use it with:
./find_unclean_files.sh /my_share_disk/

scan_against_srrdb.py
Checks a given (share) directory against the srrdb site. Downloads mismatched stuff etc. More info will come.

Requirements:
rhash
python

Use it with:
./scan_against_srrdb.py /my_share_disk/
