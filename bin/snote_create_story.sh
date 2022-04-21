#! /bin/bash

# Author : Austin Burt
# Email  : austin@burt.us.com
# Date   :

[[ -z $PROGRAM ]] && declare -r PROGRAM=$(basename $0)
[[ -f $HOME/bin/colorValues ]] && source $HOME/bin/colorValues

API_TOKEN=''
USERNAME='austin.burt@invesco.com'
ASSIGNEE='61c0f043e67ea2006b07e134'

curl \
  -D- \
  -u $USERNAME:$API_TOKEN \
  -X GET \
  -H "Content-Type: application/json" \
  https://invesco.atlassian.net/rest/api/2/search?jql=assignee="$ASSIGNEE" \
  # https://invesco.atlassian.net/rest/api/2/issue/IUWE-2843
  ;
exit 0

curl \
  -v \
  -D- \
  -u burtar:If@Mhsidthm3f23 \
  -X GET \
  -H "Content-Type: application/json" \
  https://invesco.atlassian.net/browse/IUWE-2492

#https://invesco.atlassian.net/jira/software/c/projects/IUWE/boards/1027?selectedIssue=IUWE-2490&quickFilter=3665
#https://invesco.atlassian.net/browse/IUWE-2492
   #https://invesco.atlassian.net/jira/rest/api/2/search?jql=assignee=austin+burt+order+by+duedate
  # https://invesco.atlassian.net/rest/api/2/search?jql=assignee="$ASSIGNEE" \
