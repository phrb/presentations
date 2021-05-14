find */img -type f -exec sha256sum {} + | sort | uniq -u --check-chars 40 | cut -c 67-
