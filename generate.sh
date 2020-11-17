rm -f covid19-jokyo
wget https://opendata.pref.saitama.lg.jp/data/dataset/covid19-jokyo
wget `perl extract_csv_urls.pl < covid19-jokyo | tail -1`
nkf -w8 -Lu `ls -1 jokyo*.csv|tail -1` > latest.csv
perl district.pl < latest.csv > date_district_diff.csv
