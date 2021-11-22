#! /bin/awk -f

# internetSpeedParse.awk
# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   : 09/29/20
#
# Not pretty but it parses my ~/bin/nordspeedtest script output to give averages

BEGIN {
    #denverOpenTotal=1
    city="none"
    tech="none"
}

# Set the location and City
/^== NONE/ { tech="none";city="none"} 
/^== Denver/ { city="denver"} 
/^== Perth/ { city="perth"} 
/^== NordLynx/ { tech="nord"} 
/^== OpenVPN/ { tech="open"} 

#
# Collect Values
#

# none , none
/^Ping/     {
    if (city=="none" && tech=="none" ) {
        noneTotal++;
        nonePing+=$2 ;
    }

    if (city=="denver" && tech=="nord" ) {
        denverNordTotal++;
        denverNordPing+=$2;
    }

    if (city=="denver" && tech=="open" ) {
        denverOpenTotal++;
        denverOpenPing+=$2 ;
    }

    if (city=="perth" && tech=="nord" ) {
        perthNordTotal++;
        perthNordPing+=$2 ;
    }

    if (city=="perth" && tech=="open" ) {
        perthOpenTotal++;
        perthOpenPing+=$2 ;
    }

} 

/^Download/ {
    if (city=="none" && tech=="none" )   noneDown+=$2 ;
    if (city=="denver" && tech=="nord" ) denverNordDown+=$2 ;
    if (city=="denver" && tech=="open" ) denverOpenDown+=$2 ;
    if (city=="perth" && tech=="nord" ) perthNordDown+=$2 ;
    if (city=="perth" && tech=="open" ) perthOpenDown+=$2 ;
}

/^Upload/   {
    if (city=="none" && tech=="none" )   noneUp=$2 ;
    if (city=="denver" && tech=="nord" ) denverNordUp+=$2 ;
    if (city=="denver" && tech=="open" ) denverOpenUp+=$2 ;
    if (city=="perth" && tech=="nord" ) perthNordUp+=$2 ;
    if (city=="perth" && tech=="open" ) perthOpenUp+=$2 ;
}

    END{ 
        print "NT="noneTotal,"DNT="denverNordTotal,"DOT="denverOpenTotal,"PNT="perthNordTotal,"POT="perthOpenTotal


        nonePingAvg=nonePing/noneTotal;
        noneDownAvg=noneDown/noneTotal;
        noneUpAvg=noneUp/noneTotal;

        denverNordPingAvg=denverNordPing/denverNordTotal;
        denverNordDownAvg=denverNordDown/denverNordTotal;
        denverNordUpAvg=denverNordUp/denverNordTotal;

        denverOpenPingAvg=denverOpenPing/denverOpenTotal;
        denverOpenDownAvg=denverOpenDown/denverOpenTotal;
        denverOpenUpAvg=denverOpenUp/denverOpenTotal;

        perthNordPingAvg=perthNordPing/perthNordTotal;
        perthNordDownAvg=perthNordDown/perthNordTotal;
        perthNordUpAvg=perthNordUp/perthNordTotal;

        perthOpenPingAvg=perthOpenPing/perthOpenTotal;
        perthOpenDownAvg=perthOpenDown/perthOpenTotal;
        perthOpenUpAvg=perthOpenUp/perthOpenTotal;

        print "The totals are in!";
        print "Here they are:";

        print "";
        print "With no VPN:";
        print "Ping: "nonePingAvg;
        print "Download: "noneDownAvg;
        print "Upload: "noneUpAvg;
        
        print "";
        print "Denver with NordLynx:";
        print "Ping: "denverNordPingAvg;
        print "Download: "denverNordDownAvg;
        print "Upload: "denverNordUpAvg;

        print "";
        print "Denver with OpenVPN:";
        print "Ping: "denverOpenPingAvg;
        print "Download: "denverOpenDownAvg;
        print "Upload: "denverOpenUpAvg;

        print "";
        print "Perth with NordLynx:";
        print "Ping: "perthNordPingAvg;
        print "Download: "perthNordDownAvg;
        print "Upload: "perthNordUpAvg;

        print "";
        print "Perth with OpenVPN:";
        print "Ping: "perthOpenPingAvg;
        print "Download: "perthOpenDownAvg;
        print "Upload: "perthOpenUpAvg;
    }
