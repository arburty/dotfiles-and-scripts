# Commands that helped me do something I may want again.

`find / -name burtar* 2> >(grep -v 'Permission denied' >&2) #HELPFUL`
: This command found all files burtar\* starting in the root directory and taking out 
every instance of 'Permission denied".  There were a lot.

`find / -name stopwatch* 2> >(grep -vie 'not permitted' -ve 'Permission denied' >&2)`
: Same as ^ but now also removes *not permitted*

`find / -iname '*spcm*' >> findspcm 2> /dev/null &`\

`history | tac | less`\

`date '+%m/%d/%y %H:%M'`  
: Month/day/year hour:minute\

`geth --datadir ./ --rpc --rpccorsdomain '\*'`\
: starts a private chain  

`for i in {2..8}; do echo -n "420 / $i ="; let a=420/$i; echo $a; done`\
: almost works. Prints ints\

`for i in {2..8}; do echo -n "420 / $i ="; echo "scale=4;420/$i" | bc -l; done`\
: the scale=4 with bc -l prints floats with 4 digits after the decimal.
    "420 is the smallest number evenly divisible by 2,3,4,5,6 and 7;
    but you can't easily divide it into 8ths."\

`cat maths | grep [.]00 | cut -d "/" -f 2 | cut -d "=" -f1 | tr -d '[:blank:]'`\
: last command with loop to 210 and scale=2 with output into maths.
    this finds all numbers evenly divisible and trims the whitespace before and after the result.\

`foo() { for i in {1..12};do echo -e "\t$i"; for k in {15..45..15};do echo -e "\t\t$k";done;done }`\

`foo() { for i in {1..12};do echo -e "\t$i"; for k in {15..45..15};do echo -e "\t\s\s$k";done;done }`\

`cat ~/sampleNames | while read line; do touch "$line";done`\

`while read font; do echo $font; figlet -f $font $font; done < <(ls | grep flf) | less`\

`a=130;b=0; while [[ 0 -gt 0 ]]; do if [[ 10 -eq 10 ]];then b=0; fi;echo -n 10; ((a--)); ((b++));done`\

`a="coherence\ncore\nguava"; while read word; do mvn dependency:tree | grep client-$word ;done < <(echo -e $a)`  
: this command can run the mvn command multiple times grepping for a different dependency each time
    if there is a better way to loop through each word in a string this could be nicer.

`echo -n 'tmux session: '; tmux ls | grep attached | cut -d ':' -f 1`\

`a=$(wc -l spd-update | tr -s [:blank:] | cut -d " " -f 2); let b=$a-2; tail -n $b spd-update`
: this trims the top two lines off of the file when cating it.
docker run -dt -p 80:80 -p 443:443 -e HOSTIP=host.docker.internal -v ~/apps/sm-content:/usr/local/sm-apache/htdocs --name apache apache:2.4.3 #HELPFUL

`echo "11509662|11509662" | /opt/kafka/bin/kafka-console-producer.sh --broker-list d0kafpr003:9092 --topic directory.es.load.AB --property parse.key=true --property key.separator=\|`
: uhhhh kafka stuff

`defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder`
: show hidden files in finder

`say "what you want what you really really want"`
: Mac will talk to you.  Talk dirty if thats what you like

`nc towel.blinkenlights.nl 23 - Star wars movie`
: Star Wars IV: A New Hope, remastered
This example is run from the home directory.
ln -s /home/vladislav/git/dotfiles/helpful_commands.md .helpful_commands.md
