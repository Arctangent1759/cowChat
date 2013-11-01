COWSERVERADDR="http://localhost:4567"
if [ -z $cowchatUID ]; 
then export cowchatUID=$(curl -s "$COWSERVERADDR/new/$1")
fi
