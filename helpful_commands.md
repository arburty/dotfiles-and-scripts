# Commands That Helped Me Do Something I May Want Again.

## Find commands

<a href="https://quickref.me/find">Find Command Cheat Sheet & Quick Reference</a>
`find / -name burtar* 2> >(grep -v 'Permission denied' >&2) #HELPFUL`
: This command found all files burtar\* starting in the root directory and taking out
every instance of 'Permission denied".  There were a lot.

`find / -name stopwatch* 2> >(grep -vie 'not permitted' -ve 'Permission denied' >&2)`
: Same as ^ but now also removes *not permitted*

`find / -iname '*spcm*' >> findspcm 2> /dev/null &`

`find ./ -iname "*.crt" -exec echo "{}" \;  -exec openssl x509 -in {} -text \; | less`
: helped to check if my new PEM certificates were valid.


## Normies
`history | tac | less`

`date '+%m/%d/%y %H:%M'`
: Month/day/year hour:minute

`date -d@$seconds -u +%H:%M:%S`
: This is a little hack to turn seconds into H:M:S. Only works on GNU, and is
not portable (Mac you bastard) so not good for scripts.

`printf '%02d:%02d:%02d\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))`
: One liner to adapt seconds to H:M:S

`ln -s /home/vladislav/git/dotfiles/helpful_commands.md .helpful_commands.md`
: This symlink example is run from the home directory.

`du -h -d 1 | sort -h | less`
: sort in human readable format

`bash < <(curl -sL https://raw.githubusercontent.com/arburty/dotfiles-and-scripts/master/bin/install.sh)`
: call my install script off of github

`rsync -av --progress ~/.mutt/ ~/usb/mutt/ --exclude=cache --backup --backup-dir=BACKUPDIR`
: use rsync backup my mutt files, and backing up changes (only one backup)


# Zsh 

## Zsh Expansion

    array=(long longer longest short brief) o
    print ${array[(r)${(l.${#${(O@)array//?/X}[1]}..?.)}]} # START
    print ${(M)array:#${~${(O@)array//?/?}[1]}} # ALTERNATIVE, this one is better
: Useful if you understand it
[A_User's_Guide_to_the_Z-Shell](https://zsh.sourceforge.io/Guide/zshguide05.html)


## Tmux Related
`echo -n 'tmux session: '; tmux ls | grep attached | cut -d ':' -f 1`
: simple find the attached tmux session

`tmux ls | grep -e "^workspace" -e "(attached)$"`
: simple grep for if attached to workspace


## Vim Related Fun
`exec $e +'$r!date "+\%a \%F \%R "' +startinsert! "$file"`
: open editor '$e' (i.e. vim) and on the last line print the date and start in insert mode

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


## SSH & Friends

`ssh admin@192.168.1.24 -p2222`
: Normally ssh into phone

`rsync -e ssh -p2222 --stats --progress -vr admin@192.168.1.24:/data/data/com.arachnoid.sshelper/files/home/SDCard/theChive /home/vladislav/shared_drive/laptop-backup/phone_transer_03.10.21`
: SSH/File Transer from my phone: Using sshhelper 
(seems like it won't work forever due to permission changes)

heredoc exmples:
[https://www.howtogeek.com/719058/how-to-use-here-documents-in-bash-on-linux/]

rsync examples:
[https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/]


## Random

linux - Merge / convert multiple PDF files into one PDF - Stack Overflow
[https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf]

`pdfunite input1.pdf input2.pdf inputN.pdf lastIsOutputFile.pdf`
: Combine multiple PDFs into one PDF.


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


## Script to take huge output and open in vim conveniently.

<pre><code>
logfile=gradle.log
ddd=$(date +'[%F %H:%M:%S] STARTME' | tee -a $logfile)
./gradlew --stacktrace \
    --scan \
    tasks \
    -Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts \
    -Djavax.net.ssl.keyStore=/etc/ssl/certs/java/cacerts \
    -Djavax.net.ssl.trustStorePassword=changeit \
    -Djavax.net.ssl.keyStorePassword=changeit \
    --no-daemon &>> $logfile
vim $logfile +/"\V$ddd" -c "norm! G"
</code></pre>



# Using ffmpeg

### ffmpeg Compress Video

`ffmpeg -i VID_20200921_225850_LS.mp4 -vcodec libx265 -crf 30 RL-is-broken.mp4`
: Compresses vidoes.  Change the `-crf 30` to different values for different compressed sizes.
(larger # = smaller size) link in: `~/notes/helpful_Links`


### ffmpeg Screenshots and Thumbnails

[Thumbnails & Screenshots using FFmpeg - 3 Efficient Techniques - OTTVerse](https://ottverse.com/thumbnails-screenshots-using-ffmpeg/#ScreenshotThumbnail_every_10_seconds)

`ffmpeg -i inputVideo.mp4 -ss 00:00:05.000 -frames:v 1 foobar.jpeg`
: take a picture at the 5 second mark of the video and name it foobar.jpeg


<dl>
    <dt>
        <pre>
    <code>ffmpeg -i input1080p.mp4 -r 1 -s 1280x720 -f image2 screenshot-%03d.jpg</code>
    <code>ffmpeg -i myVideo.mp4 -r 1 -f image2 screenshot-%03d.jpg</code>
        </pre>
    </dt>
    <dd>Create screenshots every 1 second.
    </dd>
</dl>

`ffmpeg -i inputvideo.mp4 -vf "select='not(mod(n,300))',setpts='N/(30*TB)'" -f image2 thumbnail-%03d.jpg`
: create an image every 10 seconds. this is for a 30fps video. mod(n,250) and
N/25 for 25fps. Adjust the mod(n,300) number to take images where a
smaller/larger number is faster/slower.

`ffmpeg -ss 00:00:00.000 -to 00:01:00.000 -i original.mp4 -vf "select='not(mod(n,5))',setpts='N/(30*TB)'" -f image2 01-%04d.jpg`
: Specify time range to make a selection of screenshots.  This should do 6 images a second for a 30fps video.

`ffprobe -show_entries format=duration myVideo.mp4 2>&1| grep "fps" | sed -e 's/^.*\, \([[:digit:]]\{2,\} fps\).*/\1/g'`
: helped me grab the FPS for the video.


### ffmpeg Create GIF

[How to Create a GIF from Images using FFmpeg? - OTTVerse](https://ottverse.com/how-to-create-gif-from-images-using-ffmpeg/)

`ffmpeg -f image2 -framerate 10 -i 01-%04d.jpg -loop -1 01-10fps.gif`
: Create a gif with 10 frames a second of a series of images named like
screenshot-001.jpg. (~5 min video / 1 screenshot per second = ~50 seconds for a 10x speed)


### ffmpeg Clipping

`ffmpeg -i -ss 00:03:00 myVideo.mp4 -ss 00:00:53 -t 00:01:00 VideoClip6.mp4`
: create a shorter clip: fast seek to 3:00, exact seek 53s more, and take a clip 1 minute long from 3:53.

`ffmpeg -i myVideo.mp4 -ss 00:02:09 -to 00:03:00 VideoClipto1.mp4`
: clip from 2:09 to 3:00 for a 51 second video.

`ffmpeg -f concat -safe 0 -i listtocat.txt -c copy concatenated.mp4`
: One way to concatenate 2 videos together. Where listtocat.txt contains lines
like: `file '/path/to/file'`


## Exiv2 commands to add/modify metadata to images.

`exiv2  -M"set Exif.Image.Artist John Smith" mypic.jpg`
: set the Artist tag.

`exiv2  -g Exif.Image.A mypic.jpg | awk '{$1=$2=$3="";print $0}' | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//"`
: grep for all Exif.Image tags.  i.e. Artist or ImageDesctprion.  then print just the answer, stripping whitespace.

`exiv2  -K Exif.Image.ImageDescription mypic.jpg`
: look for specific key

`exiv2 -M"set Exif.Photo.UserComment charset=Ascii Comment made by arburty" mypic.jpg`
: add a comment. this prints when using exiv2 with no flags.


# Came from HomeAdvisor/General Mac related
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


# Saved me | Troubleshooting

`sudo apt-get purge bcmwl-kernel-source broadcom-sta-common broadcom-sta-dkms`
: for whatever reason after the upgrade to 22.04 the wifi adapter broke, and
this is what finally succeeded in uninstalling the packages and after a
restart and `saiyd bcmwl-kernel-source` we were back.  May have been that the
packages had been fixed in the intervening days.
[Reddit_comments_w/me!](https://www.reddit.com/r/linux4noobs/comments/ujbcqy/bcmwlkernelsource_not_working_on_517/i8i2wuj/?%24deep_link=true&correlation_id=c34ee2c7-72a9-4fb4-9bc8-9c0d095c16f4&ref=email_comment_reply&ref_campaign=email_comment_reply&ref_source=email&%243p=e_as&_branch_match_id=1053862608778522343&utm_medium=Email%20Amazon%20SES&_branch_referrer=H4sIAAAAAAAAA31O0WrDMAz8muwtSWu7TVMoYzD2G8ZRlNaNY3uKjde%2Fn0K714EEp9OddLeU4npuW8JxtKkxMTbO%2BrmV8b0SSsYLarO%2BMQxkr9YbpzO5y21zVfKjEl9cpZTm5YewMEHcfCX%2FKB%2FCsPLE%2FII%2BbTDfB%2Fh%2BMBhgKW5G8ujWkAlQ%2B5B0CTRbf9XB68O%2BY5k9WVHyfXsl%2BZsaEaPeMlbyM1HGShwhEKEzybLJjsyDVIgCuroTpq%2FVNKi6H%2BBU97Abd%2F0B9sdJsY9wYjEuxjr9SqgJo3s8dxrMEo29%2Bn9Fz%2Bx%2Fkl9WQ6EfUAEAAA%3D%3D)


# Gum

[Github](https://github.com/charmbracelet/gum)

Spinner types
: line, dot, minidot, jump, pulse, points, globe, moon, monkey, meter, hamburger

```bash
for mytype in $(echo {line,dot,minidot,jump,pulse,points,globe,moon,monkey,meter,hamburger} )
do
  echo "> $mytype"
  gum spin --spinner $mytype --title.bold --title "Buying Bubble Gum..." -- sleep 5
done
```


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

`ping google.com | awk '{if (NR>1) {split($8, a, "=");split($6, b, "="); print b[2]")",a[1],"taken to ping",$4":",a[2]} else print $0}'`
: Example to show the use of a split in awk.

`for i in {1..84}; do tmux send -t mutt "d";done`
: Scripts actions in mutt through tmux, deleting the next 84 emails in this case.

`cat ~/filesToWall.txt | xargs -i"{}" echo -e "{}.jpg" | sxiv -as f -`
: print a file with image names (with no exension) and open them in sxiv.

`awk '/^Date/{$1=""; a=system("date -d \"" $0."\""); $0="test:" $a } {print $0}' emailtmp.txt`
: Not perfect. Working on changing the date in Mutt, this is getting there but needs more to work.

    echo "----- STEP 1 ----------" && \
    sudo add-apt-repository ppa:neovim-ppa/unstable && \
    echo "----- STEP 2 ----------" && \
    sudo apt-get update && \
    echo "----- STEP 3 ----------" && \
    sudo apt-get install neovim && \
    echo "----- STEP 4 ----------" && \
    sudo apt-get install python3-dev python3-pip

<dd>This will install the master version for neovim</dd>

`xrandr --dryrun --output DP-1 --primary --mode 2560x1440 --rate 99.95 --output HDMI-1 --mode 2560x1440 --rate 99.95 --right-of DP-1`
: set my screen monitors and resolution.

`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause #HELPFUL`
: Control media through the dbus directly.  Play/Pause Spotify.
https://specifications.freedesktop.org/mpris-spec/latest/Player_Interface.html

java -Xmx2048M -agentlib:jdwp=transport=dt_socket,address=8888,server=y,suspend=n -jar aem-author-p4502.jar #DEBUG AEM
: aem debug starter command.


