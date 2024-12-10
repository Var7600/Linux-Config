#!/usr/bin/env bash

# Encrypt a file
function encrypt() { openssl enc -aes-256-cbc -salt -a -in "$1" -out "$2"; }

  # Decrypt a file
function  decrypt() { openssl enc -aes-256-cbc -d -a -in "$1" -out "$2"; }

  # Fetch weather forecast
function  weather() { curl "http://wttr.in/$1"; }

  # Convert input text into a QR code
function  qrify() { curl "http://qrenco.de/$1"; }

  # Fetch information about a stock
function  stock() { curl -s "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$1&apikey=KPCCCRJVMOGN9L6T" | awk '/\. / {$1=""; gsub("\"|,",""); print $0}'; }

  # Conversion rate between currencies
function currency() { curl -s "http://api.fixer.io/latest?base=${1^^}&symbols=${2^^}" | grep -Eo "[0-9]*[.][0-9]*"; }

  # Fetch cheatsheet
function  cheat() { curl "http://cheat.sh/$1"; }

  # Fetches DNS nameserver
function  dns_nameserver() { awk '/nameserver/ {print $2}' /etc/resolv.conf; }

  # Fetches WAN ip address
function  wan_search() { dig +short myip.opendns.com @resolver1.opendns.com; }

  # Show actual destination of a tinyurl. Eg: untiny "tinyurl.com/savepii"
function  untiny() { curl -s "http://x.datasig.io/short?url=http://$1" | awk -F '"' '/dest/ {print $4}'; }

  # Get your remote IP addr
function  myip() { curl -s http://x.datasig.io/me | awk -F"\"" '/ip/ {print $4}'; }

  # Fetch movie info
function  movie() { curl -s "http://www.omdbapi.com/?t=${1/ /+}&apikey=946f500a" | jq ". | {Ratings:[.Ratings[1].Source, .Ratings[1].Value ], Plot, Actors, Director, Genre, Rated, Year, Title}" | sed -e '/Ratings/{N;N;N;s/\n/ /g;s/"Ratings": \[     //;s/,    /:/;s/   ]//}' | awk -F'"' '/: / {print $2 ": " $4}'; }
