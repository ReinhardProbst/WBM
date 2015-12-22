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

cat << EOF
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- <meta http-equiv="refresh" content="0"> -->
     	<link href="/OL91/style/style.css" rel="stylesheet" type="text/css" />
        <title>Upgrade</title>
    </head>
    <body>
        <header>
        </header>
        <div id="head">
            <h1><img src="/OL91/img/header_logo_gradient_75x75.jpg" alt="Logo" width="75" height="75" border="0">&nbsp;OL 91</h1>
        </div>
        <div id="statusbar">
            <h2>Restore</h2>
        </div>
        <div id="container">
             <div id="navbar">
                 <form action="/OL91/cgi-bin/upload.sh" method="post" enctype="multipart/form-data" id="upload">
                 <input type="file" name="filename">
            	 <input type="submit" value="Restore">
                 </form>
             </div>
             <div id="navbar">
                 <ul>
                    <li class="backMain"><a href="/OL91/cgi-bin/main.sh">Back to main page ..</a></li>
                </ul>
            </div>
     	</div>
        <footer>
        </footer>
    </body>
</html>
EOF

