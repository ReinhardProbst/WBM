#!/bin/sh

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
        echo "Got content via POST and saveed it in tmp/tmp.dat<br>"
    fi
    echo "<br><br><br></p>"
}

cat << EOF
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="content-type" content="text/html;charset=utf-8">
        <!-- <meta http-equiv="refresh" content="0"> -->
        <link rel="stylesheet" type"text/css" href="/DO82/styles/styles.css">
        <title>DO82 main</title>
    </head>
    <body>
        <header>
            <img src="/DO82/ellogo.jpg" alt="E+L"/>
            <h1>DO82 main</h1>
        </header>
        <div>
            <p>The camera system has been stopped.</p>
            <p>Service functions are enabled.</p>
            
            <form method="post" action="/DO82/cgi-bin/backup.sh">
                <input type="submit" value="Backup camera system data ...">
            </form>           
            
            <form method="post" action="/DO82/cgi-bin/restore.sh">
                <input type="submit" value="Restore camera system data ...">
            </form>
                        
            <form method="post" action="/DO82/cgi-bin/upgrade.sh">
                <input type="submit" value="Upgrade camera system software ...">
            </form>
            
            <p>After service actions the camera system has to be restarted.</p>
            
            <form method="post" action="/DO82/cgi-bin/restart.sh">
                <input type="submit" value="Restart camera system ...">
            </form>
        </div>
        <footer>
EOF

#        print_footer
        
cat << EOF
        </footer>
    </body>
</html>
EOF




        
