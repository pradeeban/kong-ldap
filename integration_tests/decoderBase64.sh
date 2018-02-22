
str=$*

echo `echo $str | base64 --decode`
