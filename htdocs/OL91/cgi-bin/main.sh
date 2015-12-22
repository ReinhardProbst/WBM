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

if [ -z $(pidof -x phoenix) ]
then

cat << EOF
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- <meta http-equiv="refresh" content="0"> -->       
     	<link href="/OL91/style/style.css" rel="stylesheet" type="text/css" />
        <title>Main</title>
    </head>
    <body>
        <header>
        </header>
        <body>
            <div id="head">
                <h1><img src="/OL91/img/header_logo_gradient_75x75.jpg" alt="Logo" width="75" height="75" border="0">&nbsp;OL 91</h1>
            </div>
            <div id="statusbar">
                <h2>Main</h2>
                <h3>The camera system has been stopped.</h3>
                <h3>Service functions are enabled.</h3>
            </div>
            <div id="container">
                <div id="navbar">
                    <ul>
                        <li class="backup"> <a href="/OL91/cgi-bin/backup.sh">Backup camera system data ..</a></li>
                        <li class="restore"><a href="/OL91/cgi-bin/restore.sh">Restore camera system data ..</a></li>
                        <li class="upgrade"><a href="/OL91/cgi-bin/upgrade.sh">Upgrade camera system software ..</a></li>
                    </ul>
                </div> 
                <h4>After service actions the camera system has to be restarted.</h4>
                <div id="navbar">
                    <ul>
                        <li class="restart"><a href="/OL91/cgi-bin/restart.sh">Restart camera system ..</a></li>
                    </ul>
                </div>
            </div>
	</body>
        <footer>
        </footer>
    </body>
</html>
EOF

else

cat << EOF
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- <meta http-equiv="refresh" content="0"> -->       
     	<link href="/OL91/style/style.css" rel="stylesheet" type="text/css" />
        <title>Main</title>
    </head>
    <body>
        <header>
        </header>
            <div id="head">
                <h1><img src="/OL91/img/header_logo_gradient_75x75.jpg" alt="Logo" width="75" height="75" border="0">&nbsp;OL 91</h1>
            </div>
            <div id="statusbar">
                <h2>Main</h2>
                <h3>The camera system is running.</h3>
                <h3>For service actions the camera system has to be stopped.</h3>
            </div>
            <div id="container">
                <div id="navbar">
                    <ul>
                        <li class="restart"><a href="/OL91/cgi-bin/await_stop.sh">Stop camera system ..</a></li>
                    </ul>
                </div>
                <h4>Force kill if camera will not stop.</h4>
                <div id="navbar">
                    <ul>
                        <li class="restart"><a href="/OL91/cgi-bin/await_kill.sh">Kill camera system ..</a></li>
                    </ul>
                </div>

            </div>
        <footer>
        </footer>
    </body>
</html>
EOF

fi



        
