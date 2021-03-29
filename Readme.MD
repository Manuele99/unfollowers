In order to be able to user these scripts you need to get your user_id and session token ( obv :) ).
You just need to go to your  feed at www.instagram.com, open up the inspector (on chrome with F12),
switch to 'network' tab and filter for HXR (on the toolbar on top of the inspector's window).
Once you're ready, go on your profile.This should trigger some HTTP requests to be sent, containing the data we need.
Check all the network calls, and find any labelled like '?query_hash=[...]'.
Under the 'Request Header' section, you can find the user ID and session ID into the "cookie" section
respectively iwth label "ds_user_id" and sessionid. Copy them without lable and `"`.

Now you are ready to go. Just execute the script you need like
`./followed.sh 123456 abc123` where '123456' is the user ID and 'abc123' is the session ID.

You may want to save the list to a file to compare followers and followed.
In this case just pipe the output to a file with

`./followed.sh 123456 abc123 | sort -u > followed.txt`.


Be careful, these scripts were tested on accounts with relatively few followers and followed (#nerd).
For large numbers (eg more than 10k) it could take a while to list all the users.