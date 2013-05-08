#!/usr/bin/env zsh
# -------------------------------------------------------------------------------
#         Author: Robbie -- dunolie (at) gmail (dot) com
#      File name: .zsh_functions  ($HOME/.functions)
#        Created: Fri 11 Jun 2010 03:05:37 am BST
#  Last Modified: Wed May 08, 2013  01:39am
#    Description: my zsh functions ~/.functions
#       Comments: mostly taken from my bash functions omitting the ones which did
#                 not play nice.
# -------------------------------------------------------------------------------

# find the location of an IP
geoip() {
		wget -qO - http://freegeoip.net/xml/$1 | sed '3,12!d;s/<//g;s/>/: /g;s/\/.*//g' ;
}

# restart an OS X application
function relaunch () {
	for app in $*; do
		osascript -e 'quit app "'$app'"';
		sleep 2;
		open -a $app
	done
}

# Quit an OS X application
function quitapp () {
	for app in $*; do
		osascript -e 'quit app "'$app'"'
	done
}

# textmate manpage
function tman () {
	MANWIDTH=160 MANPAGER='col -bx' man $@ | mate
}

# google image search & dl, with the folder name as query, good for album art :)
function gart {
	echo `basename -a $PWD` | pbcopy; gimage `pbpaste`
}

# Search with awk
function s () {
	ack $@ --color-match=green --color-filename=blue --smart-case
}
function sw () {
	ack $@ --color-match=green --color-filename=blue --word-regexp --smart-case
}
#alias f='find . -iname'
function sf () {
	ack -i -g .*$@[^\/]*$ | highlight blue ".*/" green "$@[^/]"
}

# print all paths in perlpath
function perl-path () {
	perl -e 'print join "\n", @INC'
}

# open app = $ oa textedit foo.txt
function oa () {
	if [[ -f ~/bin/launch ]]; then
		launch -a "$@"
	else
		$app=`find /Applications/ -name “*.app” | grep $1`;
		shift;
		open -a “$app/” “$2″;
	fi
}

# use the growl notification to alert on completed make
function make () {
if [[ -f ~/bin/gns ]]; then
	gns make
else
	make
fi
}

# Find a file with pattern $1 in name and Execute $2 on it:
function fe () {
	find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ;
}

# fuzzy 'cd': cd into first directory matching the substring, case insensitive
function cdff {
	shopt -q nocasematch || resetcase=1
	shopt -s nocasematch
	for i in *; do [ -d "$i" ] && [[ "$i" == *"$1"* ]] && cd "$i" && echo "$i" && break; done
	[ $resetcase ] && shopt -u nocasematch
}

# http://code.google.com/p/wkhtmltopdf
function web2pdf {
	wkhtmltopdf -q --ignore-load-errors "$1" "$2"
}

function wiki-search () {
	dig +short txt "$*".wp.dg.cx;
}

function 500-500 () {
	sips -z 500 500 "$@" > /dev/null 2>&1
}


function 600-600 () {
	sips -z 600 600 "$@" > /dev/null 2>&1
}

function mirror () {
	rsync -avh "$1" "$2"
}

function mk-dir-date () {
	mkdir "$@"\ `date +%Y-%m-%d`
}

function mp3-add-cover () {
	eyeD3 --remove-images "$@" *.mp3 >/dev/null 2>&1
	cp "$@" tmpCover.jpg 
	#eyeD3 --add-image :FRONT_COVER *.mp3 >/dev/null 2>&1
	eyeD3 --add-image=tmpCover.jpg:FRONT_COVER *.mp3 >/dev/null 2>&1
	#
	echo "Cover images have been successfully added."
	growlnotify --image=tmpCover.jpg -s -t "Album art added" -m "$(echo $PWD)"
	#
	rm tmpCover.jpg
}

function cover-grab () {
	mkdir Art
	eyeD3 --write-images="`pwd`/Art/" "$@"
	if [[ -f "`pwd`/Art/FRONT_COVER.*" ]]; then
		cp `pwd`/Art/FRONT_COVER.* ../Cover.jpg
	fi
	if [[ -f "`pwd`/Art/OTHER.*" ]]; then
		cp `pwd`/Art/OTHER.* ../Cover.jpg
	fi
	growlnotify --image=Cover.jpg -t "Album art grabbed" -m "$(echo $PWD)"
}

function genre-mp3 () {
	eyeD3 -G "$@" *.mp3
}

function year-mp3 () {
	eyeD3 -Y "$@" *.mp3
}

function rm-images-mp3 () {
	eyeD3 --remove-images "$@" *.mp3
}

function rm-comments-mp3 () {
	eyeD3 --remove-comments "$@" *.mp3
}

# rename (debian) http://git.debian.org/?p=perl/perl.git;a=blob_plain;f=debian/rename;hb=HEAD
function space2underscore () {
	rename -v 's/\ /\_/g' "$@"
}

function underscore2space () {
	rename -v 's/\_/\ /g' "$@"
}

function moc () {
	jackd -T -d coreaudio &
	sleep 5
	mocp
}

# use the gimage script to download images from google to the $PWD
function gim () {
	gimage "$@"
	#ql *jpg
	#l *.jpg
}

function paste () {
	cat "$@" | pastebinit | pbcopy && echo "Link is in the clipboard"
}

function pasteclip () {
	pbpaste | pastebinit | pbcopy && echo "Link is in the clipboard"
}

# usage: helpme <program>
function helpme () {
	"$@" --help 2>&1 |less -S;
}

# ---------------------------------------------
# github clone  sorts close by /github-user/project
# http://openmonkey.com/articles/2009/07/fast-github-clone-bash-function
function ghclone () {
  gh_url=${1:-`pbpaste`}
  co_dir=${HOME}/Code/sources/$(echo $gh_url | sed -e 's/^https:\/\/github.com\///; s/\//-/; s/\.git$//')
  if [ -d $co_dir ]; then
    cd $co_dir && git pull origin master
  else
    git clone "${gh_url}" "${co_dir}" && cd "${co_dir}"
  fi
}

# ---------------------------------------------
function rename-ext () {
   local filename
   for filename in *."$1"; do
	   mv "$filename" "${filename%.*}"."$2"
   done
}

# ---------------------------------------------
function calculator () {
	awk "BEGIN{ print $*}" ;
}

# ---------------------------------------------
# view manpages with vim (manpageviewer vim script required)
function vman () {
	/usr/bin/whatis "$@" >/dev/null
if [ $? -eq 0 ]; then
	vim -c "Man $*" -c 'silent! only' -c 'nmap q :q<CR>'
else
	 man "$@"
fi
}

# ---------------------------------------------
fpp () {
	osascript -e 'tell application "Finder" to get POSIX path of (target of window 1 as alias)' | pbcopy;
}

fpwd () {
	osascript -e 'tell application "Finder" to get POSIX path of (target of window 1 as alias)';
}

# ---------------------------------------------
# make dir and cd into it
md () {
	mkdir -p "$1" && cd "$1";
}

# ---------------------------------------------
# various find function
function    ff               { find . -name $@ -print; };

function    psa              { ps aux $@; };
function    psu              { ps  ux $@; };

function    lpsa             { ps aux $@ | p; };
function    lpsu             { ps  ux $@ | p; };

function    dub              { du -sclb $@; };
function    duk              { du -sclk $@; };
function    dum              { du -sclm $@; };
function    duh              { du -sclh $@; };

function    dfk              { df -PTak $@; };
function    dfm              { df -PTam $@; };
function    dfh              { df -PTah $@; };
function    dfi              { df -PTai $@; };

# ---------------------------------------------
# create a directory and make it the working directory
function mkcd {
	mkdir -p $1
	cd $1
}

# ---------------------------------------------
# download and untargz
function dtgz {
if [ $# -gt 0 ]; then
	for l in $@; do
		curl $l | tar -xz
	done
	else
		echo "Usage: dtgz url [url2, url3, ...]" 1>&2
fi
}

# ---------------------------------------------
# Displays the titles and their length in a VIDEO_TS folder
function dvdinfo() {
	mplayer dvd:// -dvd-device $1 -identify -ao null -vo -null -frames 0 | grep '^ID_DVD'
}

# ---------------------------------------------
# grepfind: to grep through files found by find, e.g. grepf pattern '*.c'
# note that 'grep -r pattern dir_name' is an alternative if want all files
grepfind () { find . -type f -name "$2" -print0 | xargs -0 grep "$1" ; };

# enquote: surround lines with quotes (useful in pipes) - from mervTormel
enquote () { /usr/bin/sed 's/^/"/;s/$/"/' ; };

# fixlines: edit files in place to ensure Unix line-endings
fixlines () { /usr/bin/perl -pi~ -e 's/\r\n?/\n/g' "$@" ; };

# ffs: to find a file whose name starts with a given string
ffs () { /usr/bin/find . -name "$@"'*' ; };

# ffe: to find a file whose name ends with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; };

# zipf: to create a ZIP archive of a folder
zipf () { zip -r "$1".zip "$1" ; };

word () { grep $1 /usr/share/dict/web2 grep $1 /usr/share/dict/web2a ; };

# ---------------------------------------------
# GNU GPG
encrypt (){
	gpg -se -r $USER "$1"
}

decrypt (){
	gpg -d "$1"
}

# ---------------------------------------------

# Automatically do an ls after each cd
function d () {
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}

# ---------------------------------------------
# visual cp using pv (for large files NOT dirs)
function cpv (){
#pv -p "$1" > "$2"
	if [ -d $2 ]; then
		pv -p $1 > $2/$1
	else
		pv -p $1 > $2
	fi
}

# ---------------------------------------------
# quick lunching of different screen profiles
# ~/.screen/screenrc.*foo*
function sc () {
	RED='\e[0;31m'
	NC='\e[0m'
	CYAN='\e[1;36m'
	SC_SESSION=$(screen -ls | egrep -e "\.$1.*Detached" | \
	awk '{ print $1 }' | head -1);
	if [ -n "$SC_SESSION" ]; then
		xtitle $1;
		screen -R $SC_SESSION;
	elif [ -f ~/.screen/.screenrc.$1 ]; then
    	xtitle $1;
    	screen -S $1 -c ~/.screen/.screenrc.$1
	else
		echo -e "${RED}Unknown screen session:${CYAN} '$1'${NC}"
	fi
}

# ---------------------------------------------
# Get size of folder
function ds() {
	echo 'size of directories in MB'
	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		echo 'you did not specify a directy, using pwd'
		DIR=$(pwd)
		find $DIR -maxdepth 1 -type d -exec du -sm \{\} \; | sort -nr
	else
		find $1 -maxdepth 1 -type d -exec du -sm \{\} \; | sort -nr
	fi
}

# ---------------------------------------------
# show running processes
function psg () {
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
	echo grep running processes
	echo usage: psg [process]
	else
	ps aux | grep USER | grep -v grep
	ps aux | grep -i $1 | grep -v grep
fi
}

# ---------------------------------------------
# whois for websites
function whoisg () {
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
	echo grep whois lookups for status
	echo usage: whoisg [domain name]
	else
	whois $1 | grep -i -B 3 -A 3 status
fi
}

# ---------------------------------------------
# cal with coloured day
function month() {
	/usr/bin/cal | sed -E -e 's/^/ /' -e 's/$/ /' -e "s/ $(/bin/date +%e) /$(printf '\033[1;31m&\033[m')/"
return 0
}

# ---------------------------------------------
# extract most file types
function extract () {
if [ -f $1 ] ; then
	case $1 in
		*.tar.bz2)   tar xjf "$@"     ;;
		*.tar.gz)    tar xzf "$@"     ;;
		*.bz2)       bunzip2 "$@"     ;;
		*.rar)       unrar e -ad "$@" ;;
		*.gz)        gunzip "$@"      ;;
		*.tar)       tar xf "$@"      ;;
		*.tbz2)      tar xjf "$@"     ;;
		*.tgz)       tar -xvf "$@"    ;;
		*.zip)       unzip "$@"       ;;
		*.Z)         uncompress "$@"  ;;
		*.7z)        7z x "$@"        ;;
		*)           echo "'$1' cannot be extracted via extract ()" ;;
	esac
else
	echo "'$1' is not a valid file"
fi
}

# ---------------------------------------------
# search the vim reference manual for a keyword
# usage: vh <keyword>
function vh () {
	vim --cmd ":silent help $@" --cmd "only";
}

# ---------------------------------------------
# back up file as filename(time&date).bak
function bak () {
for i in file; do
	cp "$1" "$1"_`date +%H-%M%p_%d_%m_%y`.bak
done
}

# ---------------------------------------------

# ---------------------------------------------

