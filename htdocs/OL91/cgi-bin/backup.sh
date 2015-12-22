find_cmd_val()
{
if [ -n "$QUERY_STRING" ]
then
    query1=$(echo "$QUERY_STRING" | cut -d"&" -f1)
    cmd=$(echo "$query1" | cut -d"=" -f1)
    if [ "$cmd" = "cmd" ]
    then
        echo "$(echo "$query1" | cut -d"=" -f2)"
    else
        echo "Unknown cmd"
    fi
else
    echo "No query string"
fi
}

print_footer()
{
    echo "<p>Footer - All environment variables:<br>"
    for p in $(printenv); do echo "$p" "<br>"; done
    echo "Parsing cmd result: " "$(find_cmd_val)" "<br>"
    if [ ${CONTENT_LENGTH=0} -gt 0 ]
    then
        cat <&0 >../tmp/tmp.dat
        echo "Got content via POST and saved it in tmp/tmp.dat<br>"
    fi
    echo "<br><br><br></p>"
}

SRC_PATH="/usr/el"
DST_PATH="../tmp"

#cp $SRC_PATH/bin/elSystemConfig.xml $DST_PATH/syscfg.xml
#cp $SRC_PATH/bin/elGuiConfig.xml $DST_PATH/guicfg.xml
#cp $SRC_PATH/bin/ $DST_PATH/sysdescr.txt
#cp $SRC_PATH/123.txt $DST_PATH/info.txt
#cp $SRC_PATH/123.txt $DST_PATH/verinfo.txt
#cp $SRC_PATH/123.txt $DST_PATH/fwver.txt
#cp $SRC_PATH/123.txt $DST_PATH/fwrev.txt

echo "<s>Hello cfg</s>" > $DST_PATH/syscfg.xml
echo "<g>Hello gui</g>" > $DST_PATH/guicfg.xml
echo "1234" > $DST_PATH/sysdescr.txt
echo "5678" > $DST_PATH/info.txt
echo "9012" > $DST_PATH/verinfo.txt
echo "3456" > $DST_PATH/fwver.txt
echo "7890" > $DST_PATH/fwrev.txt
        
cat << EOF
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- <meta http-equiv="refresh" content="0"> -->
     	<link href="/OL91/style/style.css" rel="stylesheet" type="text/css" />
        <title>Backup</title>
    </head>
    <body>
        <header>
        </header>
        <div id="head">
            <h1><img src="/OL91/img/header_logo_gradient_75x75.jpg" alt="Logo" width="75" height="75" border="0">&nbsp;OL 91</h1>
        </div>
        <div id="statusbar">
            <h2>Backup</h2>
            <h3>The requested backup data are ready to download.</h3>
	</div>
      	<div id="container">
            <div id="navbar">
                <ul>
                    <li><a href="/OL91/tmp/syscfg.xml" type="application/xml">System config file</a></li>
                    <li><a href="/OL91/tmp/guicfg.xml" type="application/xml">GUI config file</a></li>
                    <li><a href="/OL91/tmp/sysdescr.txt" type="text/plain">SW description file</a></li>
                    <li><a href="/OL91/tmp/info.txt" type="text/plain">SW info file</a></li>
                    <li><a href="/OL91/tmp/verinfo.txt" type="text/plain">SW version info file</a></li>
                    <li><a href="/OL91/tmp/fwver.txt" type="text/plain"> FW version info file</a></li>
                    <li><a href="/OL91/tmp/fwrev.txt" type="text/plain"> FW revision info file</a></li>
                    <li class="backMain"><a href="/OL91/cgi-bin/main.sh">Back to main page ..</a></li>
                </ul>
            </div>  
        </div>
        <footer>
        </footer>
    </body>
</html>
EOF





        
