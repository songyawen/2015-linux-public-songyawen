
#!/bin/bash

echo "-------------------------------------------------------------------"
grep -oP '^(\w+\.)+[A_Za-z]+' web_log.tsv | sort -n  | uniq -c | sort -nr -k1 | head -10
echo "-------------------------------------------------------------------"
grep -oP '(\d+\.){3}\d+\s' web_log.tsv | sort -nr | uniq -c | sort -nr -k1 | head -10
echo "-------------------------------------------------------------------"
grep -oP '(\/[^\s]+)+' web_log.tsv | sort -n  | uniq -c | sort -nr -k1 | head -10
echo "-------------------------------------------------------------------"
grep -oP '\s+\d{3}\s+(?=\d+)' web_log.tsv | sort | uniq -c | sort -k1 -nr | awk  '{array[$2]=$1; sum+=$1} END { for (i in array) printf "%-20s %-15d %6.6f%%\n", i, array[i], array[i]/sum*100}'
echo "-------------------------------------------------------------------"
grep -oP '\s+4\d{2}\s+(?=\d+)' web_log.tsv | sort -u | xargs -i sh -c "grep  -P '\s+{}(?=\d+)'  web_log.tsv  | awk '{printf \"%s %d \n\",\$5,\$6 }'| sort | uniq -c | sort -nr -k1 |head -10"
echo "-------------------------------------------------------------------"
grep -P $1'\s+' web_log.tsv | awk '{printf "%s \n",$1}'| sort | uniq -c | sort -nr -k1 | head -10
echo "-------------------------------------------------------------------"
