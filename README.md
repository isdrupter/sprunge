# sprunge
A Smart Sprunge Client in Bash

## Wget Sprunge Forked Service Now Available (Thanks OSS) : http://compst.io
=====

### Examples:

Paste  the file "some.file" from a bash prompt on a system with no curl: <br><br>
<pre>
root@rooted:~ $ echo "Testing this shit" |base64  >some.file ; paste=$(wget http://compst.io --post-data="p=$(cat some.file)" -qO-);echo "$paste";wget -qO- "$paste"|base64 -d 
compst.io/Bhrg
Testing this shit
</pre>
