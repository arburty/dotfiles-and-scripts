# Commands That Helped Me Do Something I May Want Again.

## Find commands
`find / -name burtar* 2> >(grep -v 'Permission denied' >&2) #HELPFUL`
: This command found all files burtar\* starting in the root directory and taking out 
every instance of 'Permission denied".  There were a lot.

`find / -name stopwatch* 2> >(grep -vie 'not permitted' -ve 'Permission denied' >&2)`
: Same as ^ but now also removes *not permitted*

`find / -iname '*spcm*' >> findspcm 2> /dev/null &`

## Normies
`history | tac | less`

`date '+%m/%d/%y %H:%M'`
: Month/day/year hour:minute

`ln -s /home/vladislav/git/dotfiles/helpful_commands.md .helpful_commands.md`
: This symlink example is run from the home directory.

`du -h -d 1 | sort -h | less`
: sort in human readable format

`bash < <(curl -sL https://raw.githubusercontent.com/arburty/dotfiles-and-scripts/master/bin/install.sh)`
: call my install script off of github

## Tmux Related
`echo -n 'tmux session: '; tmux ls | grep attached | cut -d ':' -f 1`
: simple find the attached tmux session

`tmux ls | grep -e "^workspace" -e "(attached)$"`
: simple grep for if attached to workspace

## Vim Related Fun
`:source $VIMRUNTIME/syntax/hitest.vim`
: creates a file colorcoded with names

`RedirMessages(hi Search, '')`
: return the hilight values for 'Search'. 
.vim/personal/redir_messages.vim

`map <leader>h :call RedirMessages("hi " . expand("<cWORD>"),'b 4 \| exe "norm G"')<cr>:bm<cr>`\``
: a beaut to map a keybinding to call hi on the word under the cursor, and paste it into
the first buffer at the bottom and return to start

## Printing Color
```awk
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
```
Prints a line of '/\' to show true color, or 256 color.  I did not write this.

## Just4Fun
`say -v afrikaans -p 80 "indefinitely and indubitable is industrialization"`
: will speak, in the afrikaans voice with a pitch of 80 (default 50, 99 max)
    say is an alias for espeak. flag `--voices` to se the list of voices

## Random Math/Number and Looping Stuff
`for i in {2..8}; do echo -n "420 / $i ="; let a=420/$i; echo $a; done`
: almost works. Prints ints

`for i in {2..8}; do echo -n "420 / $i ="; echo "scale=4;420/$i" | bc -l; done`
: the scale=4 with bc -l prints floats with 4 digits after the decimal.
    "420 is the smallest number evenly divisible by 2,3,4,5,6 and 7;
    but you can't easily divide it into 8ths."

`cat maths | grep [.]00 | cut -d "/" -f 2 | cut -d "=" -f1 | tr -d '[:blank:]'`
: last command with loop to 210 and scale=2 with output into maths.
    this finds all numbers evenly divisible and trims the whitespace before and after the result.

`foo() { for i in {1..12};do echo -e "\t$i"; for k in {15..45..15};do echo -e "\t\t$k";done;done }`

`foo() { for i in {1..12};do echo -e "\t$i"; for k in {15..45..15};do echo -e "\t\s\s$k";done;done }`

`a=130;b=0; while [[ 0 -gt 0 ]]; do if [[ 10 -eq 10 ]];then b=0; fi;echo -n 10; ((a--)); ((b++));done`

`cat ~/sampleNames | while read line; do touch "$line";done`
: create files from lines in a file

`while read font; do echo $font; figlet -f $font $font; done < <(ls | grep flf) | less`
: print the name of a font and a sample

## Commands For Changing Audio Output
`pactl list short sinks`

`pactl list short sink-inputs`

`pactl move-sink-input 8 2`
: commands to change audio output

## Random


<dl>
    <dt>
        <pre>
    <code>curl wttr.in/Denver</code></code>
    <code>curl wttr.in/Denver\?format="%l:+%C:+%t+%m"</code>
        </pre>
    </dt>
    <dd>The command line way to get the weather.  A lot of option to modify the output.<br>
    Visit: [wttr.in](https://github.com/chubin/wttr.in)
    </dd>
</dl>

`geth --datadir ./ --rpc --rpccorsdomain '\*'`
: starts a private chain  

`history | tac | awk '/gpg/ && !/history/ {$1=""; print $0;}' | less`
: use awk to find recent 'gpg' commands and not the command(s) like above

`ffmpeg -i VID_20200921_225850_LS.mp4 -vcodec libx265 -crf 30 RL-is-broken.mp4`
: Compresses vidoes.  Change the `-crf 30` to different values for different compressed sizes.
(larger # = smaller size) link in: `~/notes/helpful_Links`

## Came from HomeAdvisor/General Mac related
`docker run -dt -p 80:80 -p 443:443 -e HOSTIP=host.docker.internal -v ~/apps/sm-content:/usr/local/sm-apache/htdocs --name apache apache:2.4.3 #HELPFUL`

`a=$(wc -l spd-update | tr -s [:blank:] | cut -d " " -f 2); let b=$a-2; tail -n $b spd-update`
: this trims the top two lines off of the file when cating it.


`echo "11509662|11509662" | /opt/kafka/bin/kafka-console-producer.sh --broker-list d0kafpr003:9092 --topic directory.es.load.AB --property parse.key=true --property key.separator=\|`
: uhhhh kafka stuff

`defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder`
: show hidden files in finder

`say "what you want what you really really want"`
: Mac will talk to you.  Talk dirty if thats what you like

`nc towel.blinkenlights.nl 23 - Star wars movie`
: Star Wars IV: A New Hope, remastered

## Not Organized Yet (Recently Added)
`awk '{for (i=1;i<100/2;i++){b=100-i; print $i ". (" $i "+" $b") =",$i+$(100-i)}}' file`
: Will print 1+99, 2+88 etc using a file with 1-99 on one line. Use an empty file to
show what happens without data.

<dl>
    <dt>
        <pre>
    <code>alphanum=( {a..z} {A..Z} {0..9})</code>
    <code>for ((i=0;i<=${#alphanum[@]};i++))</code>
    <code>do</code>
    <code>    printf '%s' "${alphanum[@]:$((RANDOM%255)):1}";</code>
    <code>done; echo</code>
        </pre> 
    </dt>
    <dd>Generates new passwords
    </dd>
</dl>


<dl>
    <dt>
        <pre>
    <code>echo $PATH | awk -F ':' -vOFS='\n' '$1=$1'`</code></code>
    <code>echo $PATH | awk -vFS=':' -vOFS='\n' '$1=$1'</code>
    <code>echo $PATH | awk -vRS=':' '{print $1}'</code>
    <code>echo $PATH | sed 's/:/\n/g'</code>
    <code>echo ${PATH//:/\\n}</code>
    <code>echo $PATH | tr ':' '\n'</code>
    <code>tr ':' '\n' <<< $PATH</code>
        </pre>
    </dt>
    <dd>
    Pretty prints the PATH variable
    </dd>
</dl>

`pandoc -s ./path/to/fakeResume.docx -o hi.txt && markd hi.txt`
: Turn document (.docx, .odt, etc.) into markdown and open with lynx.
