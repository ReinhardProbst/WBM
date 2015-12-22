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


echo "<s>Hello cfg</s>" > ../tmp/syscfg.xml
echo "<g>Hello gui</g>" > ../tmp/guicfg.xml
echo "1234" > ../tmp/sysdescr.txt
echo "5678" > ../tmp/info.txt
echo "9012" > ../tmp/verinfo.txt
echo "3456" > ../tmp/fwver.txt
echo "7890" > ../tmp/fwrev.txt
        
cat << EOF
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="content-type" content="text/html;charset=UTF-8">
        <!-- <meta http-equiv="refresh" content="0"> -->
        <link rel="stylesheet" type"text/css" href="/DO82/styles/styles.css">
        <title>DO82 backup</title>
    </head>
    <body>
        <header>
	        <img src="/DO82/ellogo.jpg" alt="E+L"/>
            <h1>DO82 backup</h1>
        </header>
        <div>
            <p>The requested backup data are ready to download:</p>

            <a href="../tmp/syscfg.xml" type="application/xml"> System config file</a><br>
            <a href="../tmp/guicfg.xml" type="application/xml"> GUI config file</a><br>
            <a href="../tmp/sysdescr.txt" type="text/plain"> SW description file</a><br>
            <a href="../tmp/info.txt" type="text/plain"> SW info file</a><br>
            <a href="../tmp/verinfo.txt" type="text/plain"> SW version info file</a><br>
            <a href="../tmp/fwver.txt" type="text/plain"> FW version info file</a><br>
            <a href="../tmp/fwrev.txt" type="text/plain"> FW revision info file</a><br>

            <p></p>

            <form method="post" action="/DO82/cgi-bin/main.sh">
                <input type="submit" value="Back to main page ...">
            </form>
        </div>
        <footer>
EOF

#            print_footer
        
cat << EOF
        </footer>
    </body>
</html>
EOF





        
