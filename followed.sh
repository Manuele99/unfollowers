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
    --data-urlencode 'query_hash=3dec7e2c57367ef3da3d987d89f9dbc8' \
    --data-urlencode 'variables={"id":"'$1'","include_reel":false,"fetch_mutual":false,"first":40, "after":"'${AFTER}'"}' \
    -H 'cookie: sessionid='$2';' \
    --compressed`
  
  HAS_NEXT=`echo ${RESPONSE} | jq -r '.data.user.edge_follow.page_info.has_next_page'`
  AFTER=`echo ${RESPONSE} | jq -r '.data.user.edge_follow.page_info.end_cursor'`
  echo $RESPONSE | jq -r '.data.user.edge_follow.edges[].node.username'
done
