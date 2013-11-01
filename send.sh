COWSERVERADDR="http://localhost:4567"
if [ -z $cowchatUID ]; 
then . login.sh guest
fi
if [ -z $2 ]; 
then curl -s "$COWSERVERADDR/sendmsg/$cowchatUID/${1// /%20}"
else curl -s "$COWSERVERADDR/sendmsg/$cowchatUID/${1// /%20}/$2"
fi
