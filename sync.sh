git add .
read -p "Message: " message 
git commit -m "$message"
git pull origin master --rebase
git push origin master
