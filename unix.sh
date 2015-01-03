# get set (unique)
# most common, useful if need counts (-c)
sort FILE | uniq
# get counts of duplicates
sort FILE | uniq -c
# faster if a lot of I/O (large files and a lot of duplicates)
sort -u FILE
# guaranteed safe (read before overwriting)
sort -u -o FILE FILE
# detects only consecutive repeated lines
uniq FILE

# extract URLs
lynx -dump -listonly my.html | awk ‘{print $2}’ | sort | uniq

# delete all tdb.lock files
find . -name "tdb.lock" -exec rm '{}' \;

# scientific notation to decimal
awk '{total = total + $5}END{printf("%8d\n", total/2373)}'

# split file: all lines starting with line number 102 (to the end)
tail -n +102 myfile
sed -n ‘102,$p’ myfile
# split file into 5000-line chunks
split -l 5000 myfile

# remove last (identical) char (:) of string
sed s/:$//

# show line number 270 only (doesn’t modify the file)
# large files
sed '270q;d' file
# others
sed -n ‘270p’ file

# delete line number 270 only (doesn’t modify file)
sed ‘270d’ file
# in place (modifies)
sed -i ‘270d’ file
# in place with backup
sed -i.bak ‘270d’ file
# search and replace in place without backup
sed -i '' 's/hello/bonjour' greetings.txt

# gzip/unzip not-in-place
gzip -c file > file.gz
gunzip -c file.gz > file

# count # of empty/blank lines
grep -cv -P ‘\S’ file.nt
# if no -P option
grep -cv -E '[^[:space:]]' file.nt

# count # of non-empty lines
grep -c -P ‘\S’ file.nt

# time commands and redirect output
/usr/bin/time -v -o script.time script.py &> script.log

# count a large # of files
find . -name ‘*.owl’ -type f -print0 | xargs -0 ls | wc -l
# mv a large # of files
find . -name ‘*.owl’ -type f -print0 | xargs -0 mv -t owl

# zip/unzip all *.gz files in a dir
gzip -r ./
gunzip -r ./

# delete first 5 lines of a file in-place
sed -i '1,5d' myfile

# prepend multiple lines to a file “in place” (sed uses temp file)
sed -i "1i @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n@prefix y: <http://www.mpii.de/yago/resource/> .\n@prefix x: <http://www.w3.org/2001/XMLSchema#> ." ./connected_ntriples

# show only differences (no context)
diff -c file1 file2 | grep -e "^- "
# or
diff --side-by-side --suppress-common-lines FILE_A FILE_B
# or (just different text)
diff --side-by-side --suppress-common-lines | awk ‘{print $2}’ FILE_A FILE_B

# delete blank lines
sed '/^$/d' input.txt > output.txt

# to produce core files, check
ulimit -a
# and then set
ulimit -c unlimited

# calculate the average of the division of two numbers
# (find sum first and then divide by the value from the second line)
# find sum
paste log-allocated-30-1.gpsi30-1 log-siglistlen-30-1.gpsi30-1 |awk '{print $4 / $6}'| awk '{total = total + $1}END{print total}'
# find total
wc -l log-allocated-30-1.gpsi30-1

# merge lines of files
paste file1 file2

# add up the numbers in a column
cat log.sig-size-all34s|awk '{total = total + $1}END{print total}'

# match files modified in December
ls -l | awk '$6 == "Dec"'

# the number of the times a pattern matches (counts multiple matches per line)
grep -o and tmp/a/longfile.txt | wc -l

# list the type of each file on a separate line
ls -1 | xargs file

# unpack a tar archive in another dir
tar xvf -C tmp/a/b/c newarc.tar.gz

# lines only in file1
comm -23 file1 file2
# lines only in file2
comm -13 file1 file2

# handy for capturing web pages
tcpdump -s0 -i en1 -A

# put a semicolon at the end of each line
sed 's/$/;/' untitled.txt > temp

# remove CRLF
tr -d '\r\n' < temp > jk-students.txt
# windows-to-unix (remove CR)
tr -d '\r' < temp > jk-students.txt
# replace CRs with LFs
tr '\r' '\n' < inputfile > outputfile

# label interfaces
ifconfig bnx0 description outside

# test smtp auth
telnet mail.me.com 25
ehlo
auth login
# base64 username
# base64 password
# Authentication successful
mail from: me@me.com
rcpt to: you@you.com
data
subject: you

you are me
.

# don't wait for a shell
ssh -N user@host

# delete cr-s
tr -d '\r' < infile.csv > outfile.csv

# OpenBSD: burn iso on blank CD
mkhybrid -V "important backups" -l -J -L -r -T -o backup.iso ~/mp3
cdio tao backup.iso

# list total disk usage for every home dir in staff
du -d 1 -ch staff > file.log

# first cd to dir; equivalent to -d 0; k instead of h: suitable for sort-ing
du -cks * | sort -gr

# shred/wipe a hard drive hda: overwrite 2 times, one pass of zeroes
shred -n 2 -z -v /dev/hda

# improve throughput
hdparm -X66 -d1 -u1 -m16 -c3 /dev/hda

# see if DMA is enabled
hdparm -I /dev/hdc
# or
hdparm -d /dev/hdc

# see all the owners of processes (no dups)
ps axuw | awk '{print $1}' | sort | uniq

# see all the dirs in the cur dir
ls -l | grep ^d

# reverse sort
du -h ~/ | sort -rn

# find files modified during the last 24 h
find . -mtime -1 -print

# find dotfiles changed since .fetchmailrc was changed
find . -type f -name ".*" -newer .fetchmailrc -print

# find files not accessed in the last 7 days OR bigger than 10Mb
find . -atime +7 -o -size +20480 -print

# find num of files in cur dir ?subtract 1?
find . -print | wc -l

# find files with extension "old" and delete them
find . -name "*.old" -delete

# find files with extension "old" and prompt user for confirmation for
# deletion
find . -name "*.old" -ok rm {} \;

# find num of subdirs in cur dir ?subtract 1?
find . -type d -print | wc -l

# find all subdirs and display them in long format (head shows 1st 10)
find . -type d -ls | head

# find files w/ perms 777 (use 4000 for files w/ SUID set)
find . -perm 777 -print

# back up eth in cur dir except tmp ?dump?
find . -type d -name tmp -prune -o -print | cpio -dump /backup

# gets the ssh-agent PID (pay attention to 'grep "[s]sh-agent"')
ps uxw | grep "[s]sh-agent" | awk '{print $2}'

# authorized_keys2 == id_dsa.pub
scp ~/.ssh/authorized_keys2 prelomen@ibm:~/.ssh/.

# get the size of the current dir in M
du -h | tail -2

# create multi-volume archive and put it on floppies
# don't mount the floppy first; once it contains the backup I won't be
# able to mount it
tar cvMf /dev/fd0 .

# doesn't work with openbsd's tar:
# exclude dirs; put list of dirs to be excluded in file "exclude"; those
# dirs are subdirs of www; order of switches IS important (fX)
tar cvfX backup.tar exclude www

# tar uses relative path names by default (strips the leading slash)

# restores a particular file (Makefile); re-creates the dir structure
tar xvf ~/temp/backup.tar www/mutt/Makefile

# delete file "-f"
rm -- -f
rm ./-f

# echo script commands
sh -x cleancache

# incremental backup (backup files that have changed since 11PM on June
# 1st
touch -t 06012300 June1
find . -d -newer June1 -print | cpio -ova > backup.cpio

# copy dir structure (preserving original times--m, and user--R; -u is
# for overwriting last restore)
find -d . -print | cpio -pvduam -R vgs ~vgs/tmp

man vgrind

man mdoc.samples

# dhcp w/o reboot
sudo route -n flush
sudo sh /etc/netstart

# volumeto na max (use this V, or xmmix, xmix)
audioctl -w play.gain=255

# tar -cf - <directory>; - means standard output

# rcs initial
mkdir RCS
ci -u file.html
# rcs continual
co -l file.html
vi file.html
ci -u file.html

# print changelog
rlog RCS/*

# make dirs readable after messing with permissions
find . -type d -exec chmod a+x {}\;

# don't do chmod -R 0644 to read-only files, but do (in order not to
# mess up the permissions on the dirs
chmod -R u+w

# finding what's taking up too much space
sudo du -k / > /tmp/du
sort -rn < /tmp/du | less

# script(1) - make typescript of terminal session

# umask 22: 666->644, 777->755; umask 77: 666->600, 777->700

# installation of additional packages forgotten in the initial install
cd /
sudo tar xzvpf /usr/local/src/comp29.tgz

man mdoc.samples

# Windows File Sharing: proto {tcp,udp}; port {137,139}?

# backup tape drive: DDS-3/DDS-4?

pkg_delete -n mutt-1.4

cd /usr/ports/PORTCAT/PORTNAME/
sudo make install | /usr/ports/infrastructure/build/portslogger

# see system performance
# columns r, b, w show if the CPU, disk, or memory are bottlenecks
vmstat -w 5

vmstat -s

# kernel panic
ddb> ps
ddb> trace

ktrace

# measure the time it takes to run make buildkernel on FreeBSD
sudo date >> timestamps && make buildkernel && date >> timestamps

# 150M are the minimum for a minimum OpenBSD install (etc, base, bsd)

# download and OpenBSD's www/faq
cvs get www/faq		# initial--be in ~/
cvs -q up -PAd www/faq	# subsequent

# read pflog
sudo tcpdump -n -e -ttt -r /var/log/pflog
# realtime
sudo tcpdump -i pflog0
# narrow to port 80
sudo tcpdump -e -i pflog0 port 80

# list allowed sudo commands
sudo -l

# open a root shell
sudo -s

# ports ?
cd /usr/ports/www/php4
make show=FLAVORS
sudo env FLAVOR="mysql" make
sudo env FLAVOR="mysql" make install
# search in ports
cd /usr/ports
sudo make index
make print-index
# or use
make search key=php
# to disregard checksum mismatches
make NO_CHECKSUM=YES

# tools for synchronizing data b/w machines
# http://www.backupcentral.com/hostdump.html
rsync, ssync

# image to adjust the monitor
xtestpicture

# does the following show the correct interface?
route -n get 192.168.1.1

# return to previous working dir
cd -

# separation of stdout and stderr in tcsh
(cc helloworld.c > compile.out) >& compile.err

# see PID of a parent process
ps l

# see exit code of previously executed command
echo $status

# great cli tools--sort, grep, uniq, awk, sed

# substitute ":" on line 1 with "#!/bin/sh" in all files in current dir
perl -pi.bak -e 'if(!$a){ s%:%#!/bin/sh%};$a++;if(eof){$a=0}' `grep -l "^:$" *`

# add a .sh suffix to names of files w/o one
for f in `ls | grep -v ".sh"`; do mv ${f} ${f}.sh ; done

# installing packages from ftp prompt
ftp> get m4-1.4.tgz "|pkg_add -v -"

# last step of re-compiling the kernel (config(8) lists ALL the steps)
make depend && make

# to configure kernel throuth UKC either type "boot -c" at the boot>
# prompt or type "config -e /bsd" as root

# to set kernel buffer sizes (NKMEMPAGES and NMBCLUSTERS) w/o recompiling
config -ef /bsd
ukc> nmbclust 8192
ukc> quit

# organization of pf.conf:
#
# a section for each network interface (the external interface(s) being
# first); each section consists of the following:
# -block out quick "some"
# -pass	 out quick "some" keep state
# -block out quick "all"
#
# -block in quick "some"
# -pass	 in quick "some" keep state
# -block in quick "all"
#
# NOTICE:
# "out" rules define filtering policy for packets leaving the firewall
# and entering some network; "in" rules define filtering policy for
# packets sent from networks to the firewall

man crash
man netintro

# to see PPID, nice value, and resource the process is waiting for (WCHAN)
ps lax

sudo quot /home

# view network interface names
netstat -i

# view routing tables
netstat -rn

lower < inputfile > outputfile

# similar to script(1)
csh -i | & tee outputfile

# redirect both error and status messages to ERRS.LOG (USAH, p. 236)
make |& tee ERRS.LOG

# to convert b/w KBps (kilobytes/second) to Mbps (megabits/second):
# 528KBps * 8bits = 4224Kbps / 1024?bytes? = 4.125Mbps
# 802.11b: 4.125Mbps (but advertised as 11Mbps)
# 802.11a: 8.88Mbps - 23.12Mbps effective data rate

# modifying a disk image file
vnconfig /dev/svnd0c /tmp/floppy32.fs	# tie to a device node
mount /dev/svnd0c /mnt			# mount
umount /mnt				# unmount
vnconfig -u /dev/svnd0c			# unconfigure vnode device

# show memory management statistics
netstat -m

# check out versions of object modules used to construct a file
what pfctl

# to configure X
# good video cards: ATI xpert 98, 8mb agp/pci; Matrox G400, agp
xf86cfg -textmode
startx
# or this followed by tweaking of XF86Config
X -configure
XFree86 -xf86config /root/XF86Config.new
# or (freebsd handbook tip) as root do
XFree86 -configure
XFree86 -xf86config /root/XF86Config.new
vi /root/XF86Config.new
cp /root/XF86Config.new /etc/X11/XF86Config
# check the version
X -version
# set a particular color depth
startx -- -bpp 16

# authenticating another sendmail server/user (on the road)
man starttls

# before you run a configuration script do
./configure --help | more

# In Windows applications, a new line in the text is normally stored as
# a pair of CR LF (carriage return, line feed) characters. In Unix
# applications, a new line is normally stored as a LF character. Some
# applications use only a CR character to store a new line.

# to see which shared libraries a program needs
ldd /usr/local/bin/xmms

# to see the rcsid in a binary
ident /usr/bin/ssh

# ?
tar czvf numanalysis-ma.tgz -C /mnt/cdrom/programs/ ma

# spam tips: spamd + relaydb + mbf

diff -c
# or
diff -u

# octal, decimal, and hexadecimal ASCII character sets
man ascii

# text files in UNIX: lines of ASCII characters separated by a single
# new line character (linefeed in ASCII)

# line ending encodings
# UNIX: character linefeed (0x0a)
# Windows: CP/M marking carriage-return linefeed (0x0d 0x0a)
# Mac OS: carriage return (0x0d)

# -geometry explained in GEOMETRY SPECIFICATIONS in
man X

# encrypt passwords from cli or stdin
man 1 encrypt

# to scp a dir
scp -r /path/to/dir/ host:

# to provide CVS-only access to remote developers or to do remote,
# unattended backups:
# put restrictions in their public keys on the server
# (see examples in ssh-tutorial.pdf)

# for use of public key authentication outside X, on multiple terminals
ssh-agent screen
ssh-add

# simple unattended backup
ssh host "cd /tmp; tar cvf - ./* | bzip2 -9" > tmp.tar.bz2

# rsync test
rsync -nvazuLH -e ssh user@host:~/dir/ ~/dir/
#      ^
# rsync now
rsync -vazuLH -e ssh user@host:~/dir/ ~/dir/

# to put public ssh key on server
ssh host "umask 077; cat >> .ssh/authorized_keys2" < ~/.ssh/id_dsa.pub

# check loaded keys
ssh-add -l

# delete loaded keys
ssh-add -D

# to install new program on handspring
pilot-xfer -p /dev/utty1 -i program.prc

# Eric Raymond in "How to Become a Real Hacker" on languages to learn:
# - start with Python and Java because they are easy
# - learn C to hack UNIX
# - learn Perl for sysadmin and cgi scripts
# - learn Lisp to be a better programmer

# making extensions lower case
mmv -n '*.JPG' '=1.jpg'
file.JPG -> file.jpg
mmv '*.JPG' '=1.jpg'
# rename uppercase files to lowercase
mmv -n '*.htm' '=l1.php'

# get size of swap in MB
env BLOCKSIZE=1m pstat -s

# print sequential or random data
man jot

# make an OpenBSD iso
mkisofs -A "OpenBSD 3.3 i386" -V "OpenBSD 3.3 i386" -J -R -v -T -o \
../openbsd33.iso -b i386/cdrom33.fs -c boot.catalog \
-log-file=../openbsd33iso.log ./

# make a Gentoo iso (UNTESTED)
mkisofs -c isolinux/boot.catalog -b isolinux/isolinux.bin \
-no-emul-boot -boot-load-size 4 -boot-info-table -o \
021502-gentoo-partimage-disk.iso -v temp/

# cdrecord on Gentoo (?blank?)
cdrecord -v -eject blank=fast dev=0,0,0 speed=8 -data file.iso

# cdrecord on OpenBSD
cdrecord -v dev=/dev/rcd1c speed=8 -data file.iso

# redirect output when using make
make install >& makeinstall.log

# If you're using thin coax:
# one RG58/U thin coax cable for each PC (max length: 607 feet)
# one T-connector for each PC
# two 50-ohm terminators (one for each end of the network)

# standard URL notation; only "server" is required:
username:password@server:port

# send popup message
smbclient -M WINSname

# smbclient tips: use prompt and recurse before mput/mget

# do a name query for "hostname" and check node status
nmblookup -S hostname

# check the name associated with the IP and check node status
nmblookup -A 1.2.3.4

# set an env var of ftp or http mirror
setenv PKG_PATH "ftp://ftp.usa.openbsd.org/pub/OpenBSD/3.3/packages/i386/"
sudo pkg_add -v ${PKG_PATH}tcsh-6.12.00-static.tgz

# BIND = Berkeley Internet Name *Domain*

# pf rules for personal desktop/laptop:
# scrub everything in
# pass things out keeping state
# block everything in

xvinfo
xvctl

atactl /dev/wd0c identify

# using gs to convert ps to pdf
gs -dBATCH -dFIXEDMEDIA -dNOPAUSE -sDEVICE=pdfwrite \
-sOutputFile=file.pdf -sPAPERSIZE=letter files??.ps

# to mount usb smart media card, plugin device WITH card inside
mount -t msdos /dev/sd0i /mnt/sm

# to mount compact flash card on ibmx24
mount -t msdos /dev/wd1i /mnt/cf

# to mount pny attache
mount_msdos -l /dev/sd0c /mnt/pny

# ?to format pny attache (good to be FAT32)
newfs_msdos -F 32 sd0i

# to turn off sound of modem
ppp
term
AT &F M0

# umask works like this: mode & ~umask

# list open files for processes
lsof -i

# send message to another user
write user ttyp0

# crypto key storage:
# use dd to create large file, vnconfig -k to use the file as a fs w/
# encryption key, mount vnd0 device as a disk

# extract interactively files from dumps
restore -i -f /path/to/dump/file
restore > cd somedir
...
restore > add file
restore > extract
...
set owner/mode for '.'? [yn] n

# restore dumps--first level 0 and then the incremental backups
newfs /dev/wd0g
mount /dev/wd0g /home
cd /home
restore -r -f dumpfile

# generate A LOT of traffic
host1% yes AAAAAAAAAAAAAAAAAAAAAAA | nc -v -v -l 2222 > /dev/null
host2% yes BBBBBBBBBBBBBBBBBBBBBBB | nc host1 2222 > /dev/null

# to go through a proxy (NOT TRIED); compile nc with gap_sec_hole
hostoutsideproxy# nc -vv -l 80
hostbehindproxy% nc hostoutsideproxy 80 -x proxyip:80 -e /bin/sh

# transfer file from client to server
server% nc -v -w 30 -l 5600 > file
client% nc -v -w 2 server 5600 < file

# aterm
aterm -tr -g 125x10+0+0 -trsb -fn nexus -fg white -sb -e chklog

# expand tabs to spaces and vice versa
expand file

# for supported wifi cards see
man wi

# don't use sudo make in /usr/ports; set it in /etc/mk.conf (SUDO=sudo)

# mount_null ?= mount loop in linux

man ports
man release

# display information about an image
identify -verbose picture.jpg

# download only the gnuplot directory (?-p?)
wget -p --convert-links -nH --cut-dirs=1 http://www.cs.uni.edu/Help/gnuplot/

# download new OpenBSD release
wget http://rt.fm/pub/OpenBSD/3.5/i386/
wget -c -F -i index.html -B http://rt.fm/pub/OpenBSD/3.5/i386/

# groff tips
# papers with images
groff -me -ep -U file.troff > file.ps
# papers with tables: troff -> ps -> pdf
tbl file.troff | groff -me > file.ps

# download a subsite for offline viewing
wget -m -np -nH --cut-dirs=4 -k -p http://www.catb.org/~esr/writings/taoup/html/

# set mouse speed (xset %acceleration %threshold)
xset m 5 1
# reset to default
xset m default

# rotate images w/o change of quality
jpegtran -rotate 90 image.jpg > imagev.jpg
# or (will have to rotate on camera first--to set the Exif rotation tag)
jhead -autorot image.jpg

# if you have to use su, do
su -

# for messed up file systems
scan_ffs(8)

# searching for macro definitions
find . -name "*.[ch]" -print | xargs grep NICE_TO_TICKS | grep define

# searching
grep -r . -H -I -i -n -e "foobar"

# see fxp0 media types
ifconfig -m fxp0

# set fxp0 media and media options
ifconfig fxp0 media 100baseTX mediaopt full-duplex

# ?
find / | grep -v -e ^/proc/ -e ^/tmp/ -e ^/dev/ > joe-preinstall.list

# see graphical disk usage
du -a | xdu

# man sections
1	User-level commands and applications
2	System calls and kernel error codes
3	Library calls
4	Device drivers and network protocols
5	Standard file formats
6	Games and demonstrations
7	Miscellaneous files and documents
8	Systeam administration commands
9	Obscure kernel specs and interfaces

# generate random password (pronouncable)
# must have letters, numbers, and special chars
apg -q -a 0 -M LNS -m 8 -x 8
# generate strong random password (non-pronouncable)
apg -a 1 -M LNS -m 16 -x 16 -s
apg -M L -t

# change maxfiles in sh
ulimit -Hn 8192

# change maxfiles in csh/tcsh
limit ? descriptors 8192

/usr/bin/*stat
/usr/sbin/*stat

systat

# find all files in the currect directory and reset permissions
# to 644
find ./ -type f -exec chmod 644 {} \;

# recursive copy files/link and retain permision/date
mkdir newdir
cd dir-to-be-tar
tar cvf - . | (cd newdir ; tar xvf -)

# tunnel imap and smtp over ssh
ssh -N -L 143:mail:143 -L 25:mail:25 user@glider

# remove all files in /tmp which are more than 1 day old
cd /tmp
find  /tmp -user yourlogin  -mtime +1 -exec rm -rf '{}' \; > /dev/null 2>&1

# display total size of current folder only
du -sh

# redirection
command -[options] [arguments] < input file  > output file

# redirect standard error only
who 2> /dev/null

# csh
Character	Action
>		Redirect standard output
>&		Redirect standard output and standard error
<		Redirect standard input
>!		Redirect standard output; overwrite file if it exists
>&!		Redirect standard output and standard error; overwrite
		file if it exists
|		Redirect standard output to another command (pipe)
>>		Append standard output
>>&		Append standard output and standard error

# bash
# (0 standard input, 1 standard output, 2 standard error)
Character	Action
>		stdout to file
2>		stderr to file
1>&2		stdout to stderr
2>&1		stderr to stdout
&>		stdout and stderr to file

<		Redirect standard input
|		Pipe standard output to another command
>>		Append to standard output
2>&1|		Pipe standard output and standard error to another command

# redirect stdout and stderr to separate files
(((./cmd | tee stdout.txt) 3>&1 1>&2 2>&3 | tee stderr.txt) 3>&1 1>&2 2>&3) 1>out.txt 2>err.txt

# redirect stderr to one file and both stdout and stderr to another
(((echo out >&1; echo err >&2) 3>&2 2>&1 1>&3 | tee stderr.txt ) 3>&2 2>&1 1>&3 ) > combined.txt 2>&1

# get SSL certificate
openssl s_client -connect mail.example.org:443 -showcerts
openssl s_client -connect mail.example.org:995 -showcerts -starttls pop3

# find IMAP capability
openssl s_client -crlf -quiet -connect imap.gmail.com:993

# hear Linksys PAP IP address
# press the asterisk (*) key four times
# dial 110#

# use this instead of ncftp
wget --passive-ftp ftp://ftp.host.com/file

# start up snort in daemon mode
sudo snort -D -h 10.0.0.0/8 -t /var/snort -u _snort -i bnx1 -A fast -c /etc/snort/snort.conf -l /var/snort/log

# update/merge/reload hints file
ldconfig -m /usr/X11R6/lib

# list hints file
ldconfig -r

# compiling ntop on Suse requires a bunch of crap, including net-snmp and
# tcpd (for -lwrap); Suse sucks big time!

ntop -m "10.0.0.0/255.0.0.0" -n -i bnx1
ntop -P /home/ntop -u ntop -i eth0

# sort IP addresses
sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4

# discard crontab jobs output
myscript.py 2>&1 | tee > /dev/null

# more inodes
fdisk?
disklabel?
# default blocksize is 16384 and fragment size is 2048
newfs -b 8192 -f 1024 sd1a

md5 file_to_check | grep checksum_of_file

# sbin
/etc/csh.cshrc

# EDITOR
/etc/env.d/00basic

# network settings
/etc/conf.d/net

# ?
env-update

# make most changes in
/etc/make.conf

# use this at WJC to get latest portage tree
emerge-webrsync

# see PCMCIA card info
cardctl ident

# see how to clean up config confusion
sudo emerge --help config

# mplayer
# redhat (not exact; have to test):
mplayer -ao sdl -afm ffmpeg -vfm ffmpeg -framedrop -vop scale=640:480 -autosync 30 -dvd 1
# gentoo
mplayer -vo x11 -ao alsa9 -framedrop -dvd 1
gmplayer -vo x11 -quiet -dvd-device /dev/rcd0c -cache 32000 -slang en -dvd 1

# list fonts
xlsfonts

# ?
xset

/sbin/lspci -v
cat /proc/pci

# to check for pcmcia cards do
/sbin/probe
probe

# rpm
rpm -i
rpm -e
rpm -qa

# change MAC address of NIC
ifconfig eth0 hw ether 08:00:02:13:DE:9A

# getting rid of grub leftover after removing redhat: boot win 2k or xp
# go to recovery console and type "fixmbr"

# get sha1 checksum
openssl dgst -sha1 file.iso

# compile openbsd kernel after patching
cd /usr/src/sys/arch/i386/conf
config GENERIC
cd ../compile/GENERIC
make clean && make depend && make
make install

# search for 'string' recursively
grep -ir string /var/log/*

# ipaudit on OpenBSD: in ipaudit.c, comment all references to DLT_LINUX_SLL
# mrtg on OpenBSD requires xbase (through gd)

# generate ssh keys
ssh-keygen -t rsa -C "my comment" -f mykey

# show nfs exports
showmount -e server

# list services
smbclient -N -L '\\10.1.1.1'

# report rpc info
rpcinfo -p 10.1.1.1

# replace LF?
?cat file | tr -d "\r" > newfile

# setup a listener on port 5168 and record all the packets
sudo tcpdump -i eth0 -s0 -nn -w trend-of-evil.pcap tcp port 5168  &
screen -S trend
while true
do
    # use gnu nc
    netcat -x -o monitoring-the-trend-of-evil.hex.txt -vv -l -p 5168 >>
    monitoring-the-trend-of-evil.txt

    date +%Y%m%d-%H%M%S >> monitoring-the-trend-of-evil.txt
done
# generate a random sequence of 8 chars
jot -r -c 8 a z | rs -g 0 8
