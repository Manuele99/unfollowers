#!/bin/bash -e

if [[ $# -ne 2 ]] ;
then
  echo "Usage: $0 [id] [sessionid]"
  exit 1
fi

HAS_NEXT='true'
AFTER=''

while [ $HAS_NEXT == 'true' ] ;
do
  RESPONSE=`curl -s -G 'https://www.instagram.com/graphql/query/' \
    --data-urlencode 'query_hash=5aefa9893005572d237da5068082d8d5' \
    --data-urlencode 'variables={"id":"'$1'","include_reel":false,"fetch_mutual":false,"first":40, "after":"'${AFTER}'"}' \
    -H 'cookie: sessionid='$2';' \
    --compressed`
  
  HAS_NEXT=`echo ${RESPONSE} | jq -r '.data.user.edge_followed_by.page_info.has_next_page'`
  AFTER=`echo ${RESPONSE} | jq -r '.data.user.edge_followed_by.page_info.end_cursor'`
  echo $RESPONSE | jq -r '.data.user.edge_followed_by.edges[].node.username'
done
