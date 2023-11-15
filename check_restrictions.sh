#!/usr/bin/env bash

# no restrictions on tests
rm -rf tests

# first check the usage of sys
grep -E -r -o --include \*.py 'sys\..+' | sort | uniq
grep -E -r -o --include \*.py 'from sys import .+' | sort | uniq

printf \\n
echo sys.argv and sys.exit are allowed
echo check if there is anything strange
echo press Enter to continue
read

# gather all imports
grep -E -r -o --include \*.py '(from .+ ){0,1}import .+' | sort | uniq > /tmp/all.txt

# filter the library name only
cat /tmp/all.txt | cut -d':' -f2 | cut -d' ' -f2 | sort | uniq > /tmp/lib.txt

# write the whitelist
cat << EOF > /tmp/whitelist.txt
pathlib
random
signal
socket
sys
time
typing
EOF

echo sus modules:
# filter the whitelist out
comm -1 -3 /tmp/whitelist.txt /tmp/lib.txt | tee inspect.txt

# manually remove student made modules
printf \\n
echo edit inspect.txt and remove student s customised modules
echo then press Enter to continue
read

# remove any empty lines
sed -i '/^$/d' inspect.txt

echo sus occurrences
# print unallowed module occurrences
# no deduction if the library is not used
grep -E -r -n --include \*.py -f inspect.txt
