#!/usr/bin/env zsh
# -------------------------------------------------------------------------------
#         Author: Robbie -- dunolie (at) gmail (dot) com
#      File name: .zsh_functions  ($HOME/.functions)
#        Created: Fri 11 Jun 2010 03:05:37 am BST
#  Last Modified: Thu May 09, 2013  08:03am
#    Description: my zsh functions ~/.functions
#       Comments: mostly taken from my bash functions omitting the ones which did
#                 not play nice.
# -------------------------------------------------------------------------------

# find the location of an IP
function geoip() {
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
function ff    { find . -name $@ -print; };

function psu   { ps  ux $@; };

function lpsa  { ps aux $@ | p; };
function lpsu  { ps  ux $@ | p; };

function dub   { du -sclb $@; };
function duk   { du -sclk $@; };
function dum   { du -sclm $@; };
function duh   { du -sclh $@; };

function dfk   { df -PTak $@; };
function dfm   { df -PTam $@; };
function dfh   { df -PTah $@; };
function dfi   { df -PTai $@; };

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
# quick change directories.  “cd …./dir”
zle -N rationalise-dot
bindkey . rationalise-dot
rationalise-dot() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}

# zip a file/folder
function zipit {
	 ditto -c -k -V "$@" "${1}.zip";
}

# ---------------------------------------------
# Uppercase only the first letter of all *.mp3 files
function mp3-case () {
	autoload zmv
	zmv '([a-z])(*).mp3' '${(C)1}$2.mp3'
}

# ---------------------------------------------
# fcd: cd's to frontmost window of Finder
function fcd () {
    currFolderPath=$( /usr/bin/osascript <<"    EOT"
        tell application "Finder"
            try
		set currFolder to (folder of the front window as alias)
            on error
		set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
    EOT
    )
    # echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

# ---------------------------------------------
# locateql: search using Spotlight and show a "Quick Look" of matching files
locateql ()
{
    locatemd "$@" | enquote | xargs qlmanage -p >& /dev/null &
}
# ---------------------------------------------
# Kill the line with the given number in the ssh known hosts file.
# Useful after a host public key change.
function kill-ssh-known-hosts-line () {
	sed -ie "$1d" ~/.ssh/known_hosts
}
# ---------------------------------------------

# fuzzy 'cd': cd into first directory matching the substring, case insensitive
function cdfuz () {
	shopt -q nocasematch || resetcase=1
	shopt -s nocasematch
	for i in *; do [ -d "$i" ] && [[ "$i" == *"$1"* ]] && cd "$i" && echo "$i" && break; done
	[ $resetcase ] && shopt -u nocasematch
}
# ---------------------------------------------
<<<<<<< HEAD
=======

function mdlocate () {
	echo mdfind "kMDItemFSName == '$1'"
	mdfind "kMDItemFSName == '$1'"
}

function spot () { mdfind "kMDItemDisplayName == '$@'wc"; }

function clearquarantine () {
	[ "$1" -a -d "$1" ] || { echo need a directory argument; return 1; }
	echo find "'$1'" -type f -print0 \| xargs -n 100 -0 sudo xattr -d com.apple.quarantine
	find "$1" -type f -print0 | xargs -n 100 -0 sudo xattr -d com.apple.quarantine
}
# ---------------------------------------------
function yt () {
	youtube-dl -o '/Volumes/Visual/YouTubes/New/%(uploader)s/%(title)s-%(id)s.%(ext)s' -f 22/35/34 --console-title --no-part --restrict-filenames --sub-format en "$@";
	growlnotify -t "Youtube DL's Finished" -m "/Volumes/Visual/YouTubes/New"
}

# ---------------------------------------------
# generate a password. ie: $ gp 64
function gp () {
    local l=$1
    [ "$l" == "" ] && l=20
    tr -dc A-Za-z0-9\-_~\!@#$%^\&*\(\)\\\`\+\[\{\]\}\|\;:\",\/?\= < /dev/urandom | head -c ${l} | xargs
}


function JPG-2-jpg () {
	find $PWD -name '*.JPG' -exec bash -c 'mv "$1" "${1/%.JPG/.jpg}"' -- {} \;
}
# ---------------------------------------------
function targpg () {
for f in "$@"
do
dir=`dirname "${f}"`
name=`basename "${f}"`
cd "${dir}"
# export GPGKEYID="123ZZ321" ~ for your .bashrc
tar pcvf - "${name}" | gpg --encrypt --batch -z 6 -r robbie -o "${name}.tgz.gpg"
done
}

# ---------------------------------------------
# mktar - tarball wrapper
# usage: mktar <filename | dirname>
function mktar () {
    tar pcvf "${1%%/}.tgz" "${1%%/}/"
}
# ---------------------------------------------

# showTimes: show the modification, metadata-change, and access times of a file
function show-times () {
	stat -f "%N:   %m %c %a" "$@" ;
}

# finderComment: show the SpotLight comment for a file
function finder-comment () {
	mdls "$1" | grep kMDItemFinderComment ;
}
>>>>>>> e9e0e12b3880e15b6fb8ef7418e65a4aacf531ca

function mdlocate () {
	echo mdfind "kMDItemFSName == '$1'"
	mdfind "kMDItemFSName == '$1'"
}

function spot () { mdfind "kMDItemDisplayName == '$@'wc"; }

function clearquarantine () {
	[ "$1" -a -d "$1" ] || { echo need a directory argument; return 1; }
	echo find "'$1'" -type f -print0 \| xargs -n 100 -0 sudo xattr -d com.apple.quarantine
	find "$1" -type f -print0 | xargs -n 100 -0 sudo xattr -d com.apple.quarantine
}
# ---------------------------------------------
<<<<<<< HEAD
function yt () {
	youtube-dl -o '/Volumes/Visual/YouTubes/New/%(uploader)s/%(title)s-%(id)s.%(ext)s' -f 22/35/34 --console-title --no-part --restrict-filenames --sub-format en "$@";
	growlnotify -t "Youtube DL's Finished" -m "/Volumes/Visual/YouTubes/New"
}

# ---------------------------------------------
# generate a password. ie: $ gp 64
function gp () {
    local l=$1
    [ "$l" == "" ] && l=20
    tr -dc A-Za-z0-9\-_~\!@#$%^\&*\(\)\\\`\+\[\{\]\}\|\;:\",\/?\= < /dev/urandom | head -c ${l} | xargs
}


function JPG-2-jpg () {
	find $PWD -name '*.JPG' -exec bash -c 'mv "$1" "${1/%.JPG/.jpg}"' -- {} \;
}
# ---------------------------------------------
function targpg () {
for f in "$@"
do
dir=`dirname "${f}"`
name=`basename "${f}"`
cd "${dir}"
# export GPGKEYID="123ZZ321" ~ for your .bashrc
tar pcvf - "${name}" | gpg --encrypt --batch -z 6 -r robbie -o "${name}.tgz.gpg"
done
}

# dict wordnet
function wn () {
	 dict -d wn $@ | sed '1,4d'
}

function define () {
	dict -d wn $@ | sed '1,4d'
}
# ---------------------------------------------
# mktar - tarball wrapper
# usage: mktar <filename | dirname>
function mktar () {
    tar pcvf "${1%%/}.tgz" "${1%%/}/"
}
# ---------------------------------------------

# showTimes: show the modification, metadata-change, and access times of a file
function show-times () {
	stat -f "%N:   %m %c %a" "$@" ;
}

# finderComment: show the SpotLight comment for a file
function finder-comment () {
	mdls "$1" | grep kMDItemFinderComment ;
}

# ---------------------------------------------
# http://brettterpstra.com/2013/02/10/the-joy-of-sshfs/
# Remote Mount (sshfs)
# creates mount folder and mounts the remote filesystem
rmount() {
	local host folder mname
	host="${1%%:*}:"
	[[ ${1%:} == ${host%%:*} ]] && folder='' || folder=${1##*:}
	if [[ -n $2 ]]; then
		mname=$2
	else
		mname=${folder##*/}
		[[ "$mname" == "" ]] && mname=${host%%:*}
	fi
	if [[ $(grep -i "host ${host%%:*}" ~/.ssh/config) != '' ]]; then
		mkdir -p ~/Shell/mounts/$mname > /dev/null
		sshfs $host$folder ~/Shell/mounts/$mname -oauto_cache,reconnect,defer_permissions,negative_vncache,volname=$mname,noappledouble && echo "mounted ~/Shell/mounts/$mname"
	else
		echo "No entry found for ${host%%:*}"
		return 1
	fi
}

# Remote Umount, unmounts and deletes local folder (experimental, watch you step)
rumount() {
	if [[ $1 == "-a" ]]; then
		ls -1 ~/Shell/mounts/|while read dir
		do
			[[ -d $(mount|grep "mounts/$dir") ]] && umount ~/Shell/mounts/$dir
			[[ -d $(ls ~/Shell/mounts/$dir) ]] || rm -rf ~/Shell/mounts/$dir
		done
	else
		[[ -d $(mount|grep "mounts/$1") ]] && umount ~/Shell/mounts/$1
		[[ -d $(ls ~/Shell/mounts/$1) ]] || rm -rf ~/Shell/mounts/$1
	fi
}

# -------------------------------------------------------------------
# nice mount (http://catonmat.net/blog/anoth...
# displays mounted drive information in a nicely formatted manner
# -------------------------------------------------------------------
function nicemount () { 
	(echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; 
}

=======
# http://brettterpstra.com/2013/02/10/the-joy-of-sshfs/
# Remote Mount (sshfs)
# creates mount folder and mounts the remote filesystem
rmount() {
	local host folder mname
	host="${1%%:*}:"
	[[ ${1%:} == ${host%%:*} ]] && folder='' || folder=${1##*:}
	if [[ -n $2 ]]; then
		mname=$2
	else
		mname=${folder##*/}
		[[ "$mname" == "" ]] && mname=${host%%:*}
	fi
	if [[ $(grep -i "host ${host%%:*}" ~/.ssh/config) != '' ]]; then
		mkdir -p ~/Shell/mounts/$mname > /dev/null
		sshfs $host$folder ~/Shell/mounts/$mname -oauto_cache,reconnect,defer_permissions,negative_vncache,volname=$mname,noappledouble && echo "mounted ~/Shell/mounts/$mname"
	else
		echo "No entry found for ${host%%:*}"
		return 1
	fi
}

# Remote Umount, unmounts and deletes local folder (experimental, watch you step)
rumount() {
	if [[ $1 == "-a" ]]; then
		ls -1 ~/Shell/mounts/|while read dir
		do
			[[ -d $(mount|grep "mounts/$dir") ]] && umount ~/Shell/mounts/$dir
			[[ -d $(ls ~/Shell/mounts/$dir) ]] || rm -rf ~/Shell/mounts/$dir
		done
	else
		[[ -d $(mount|grep "mounts/$1") ]] && umount ~/Shell/mounts/$1
		[[ -d $(ls ~/Shell/mounts/$1) ]] || rm -rf ~/Shell/mounts/$1
	fi
}

# -------------------------------------------------------------------
# nice mount (http://catonmat.net/blog/anoth...
# displays mounted drive information in a nicely formatted manner
# -------------------------------------------------------------------
function nicemount () { 
	(echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; 
}

>>>>>>> e9e0e12b3880e15b6fb8ef7418e65a4aacf531ca
function reload () {
	if [[ $SHELL = /usr/local/bin/zsh ]]; then
		echo -e "${CYAN}Reloading your ~/.zshrc!${NC}" ;source ~/.zshrc
	fi
	if [[ $SHELL = /bin/bash ]]; then
		echo -e "${CYAN}Reloading your ~/.bashrc!${NC}" ;source ~/.bashrc
	fi
}


#f5# List files which have been accessed within the last {\it n} days, {\it n} defaults to 1
accessed() {
    emulate -L zsh
    print -l -- *(a-${1:-1})
}

#f5# List files which have been changed within the last {\it n} days, {\it n} defaults to 1
changed() {
    emulate -L zsh
    print -l -- *(c-${1:-1})
}

#f5# List files which have been modified within the last {\it n} days, {\it n} defaults to 1
modified() {
    emulate -L zsh
    print -l -- *(m-${1:-1})
}

# Find history events by search pattern and list them by date.
whatwhen()  {
    emulate -L zsh
    local usage help ident format_l format_s first_char remain first last
    usage='USAGE: whatwhen [options] <searchstring> <search range>'
    help='Use `whatwhen -h'\'' for further explanations.'
    ident=${(l,${#${:-Usage: }},, ,)}
    format_l="${ident}%s\t\t\t%s\n"
    format_s="${format_l//(\\t)##/\\t}"
    # Make the first char of the word to search for case
    # insensitive; e.g. [aA]
    first_char=[${(L)1[1]}${(U)1[1]}]
    remain=${1[2,-1]}
    # Default search range is `-100'.
    first=${2:-\-100}
    # Optional, just used for `<first> <last>' given.
    last=$3
    case $1 in
        ("")
            printf '%s\n\n' 'ERROR: No search string specified. Aborting.'
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (-h)
            printf '%s\n\n' ${usage}
            print 'OPTIONS:'
            printf $format_l '-h' 'show help text'
            print '\f'
            print 'SEARCH RANGE:'
            printf $format_l "'0'" 'the whole history,'
            printf $format_l '-<n>' 'offset to the current history number; (default: -100)'
            printf $format_s '<[-]first> [<last>]' 'just searching within a give range'
            printf '\n%s\n' 'EXAMPLES:'
            printf ${format_l/(\\t)/} 'whatwhen grml' '# Range is set to -100 by default.'
            printf $format_l 'whatwhen zsh -250'
            printf $format_l 'whatwhen foo 1 99'
        ;;
        (\?)
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (*)
            # -l list results on stout rather than invoking $EDITOR.
            # -i Print dates as in YYYY-MM-DD.
            # -m Search for a - quoted - pattern within the history.
            fc -li -m "*${first_char}${remain}*" $first $last
        ;;
    esac
}

# show the most recently changed file
latest()
{
    local count=1               # how many files to print
    local promptlines=5         # how many lines to leave for the prompt
                                # when printing a screenful with -s
    local usage="Usage: latest [-n <number>] [-s] [--] [pattern]"
    while test $# -gt 0
    do
        case $1 in
        # -- = stop processing options
        --)
            shift
            break
            ;;
        # -n <number> = <number> files
        -n)
            if test -n "$2"
            then
                count=$2
                shift 2
            else
                echo "$usage" 1>&2
                return 1
            fi
            ;;
        # -s = one screenful
        -s)
            count=$((LINES - promptlines))
            shift
            ;;
        # -<number> = <number> files
        -[0-9]*)
            count=${1#-}
            shift
            ;;
        # anything else starting with a minus is a usage error
        -*)
            echo "$usage" 1>&2
            return 1
            ;;
        *)
            break
            ;;
        esac
    done

    if test $# -ne 0
    then
        /bin/ls -t -1 -d "$@" | head -n $count
    else
        /bin/ls -t -1 -d * | head -n $count
    fi
}
# ---------------------------------------------
# KEEP AS LAST FUNCTION IT BREAKS THE SYNTAX COLOURING!!!
# ---------------------------------------------
# teach shell to treat aliases like symbolic links rather than files
# http://www.macosxhints.com/article.php?story=20050828054129701
function cda () {
	if [ ${#1} == 0 ]; then
		builtin cd
	elif [[ -d "${1}" || -L "${1}" ]]; then	# regular link or directory
		builtin cd "${1}"
	elif [ -f "${1}" ]; then	# file: is it an alias?
		# Redirect stderr to dev null to suppress OSA environment errors
		exec 6>&2 # Link file descriptor 6 with stderr so we can restore stderr later
		exec 2>/dev/null # stderr replaced by /dev/null
		path=$(osascript << EOF
tell application "Finder"
set theItem to (POSIX file "${1}") as alias
if the kind of theItem is "alias" then
get the posix path of ((original item of theItem) as text)
end if
end tell
EOF
)
		exec 2>&6 6>&-      # Restore stderr and close file descriptor #6.
		
		if [ "$path" == '' ];then # probably not an alias, but regular file
			builtin cd "${1}"	# will trigger regular shell error about cd to regular file
		else	# is alias, so use the returned path of the alias
			builtin cd "$path"
		fi
	else	# should never get here, but just in case.
		builtin cd "${1}"
	fi
}