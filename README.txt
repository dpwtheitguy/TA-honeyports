# README.txt

# TA-honeyports
### Description
Executes a bash scripted input to keep netcat listening. TCP handshakes are logged. 

### Installation/Platform
Splunk 8.0.2 tested
CentOS7 x64 with lsof and netcat installed. 

Create an index
Set index on inputs.conf
Tune Timezone another elements as needed in props.conf
Install on Universal Forwarders, restart (eventbreaker needs set)
Install on Heavy Forwarders. if you want but disable the input, restart.(props.conf needs work)
Install on Indexers, restart. if you want but disable the input.  (props.conf needs work)
Install of search heads, restart, if you want but distable the input. (props.conf)

### Usage
Tags for attack and ids are added. Fields are natually CIM'd and a bit verbose. 

### History
5.12.2020.1 - daniel, initial version 

### Credits
Daniel Wilson <daniel.p.wilson@live.com>

### License
None

### TO DO/BUGS
1) Move some of the hardcoded fields to search time
2) Add Debian support
3) remove hard coded bin paths
4) Create a seperate token table file for ports and various configs. 
5) Add a GUI
