## https://hub.docker.com/r/pantsel/konga/
## https://github.com/pantsel/konga/blob/master/README.md

## docker pull pantsel/konga

##docker run --link kong:kong  \
##            --name kong-dashboard \
##            --rm -p 8080:8080 \
##            pgbi/kong-dashboard \
##           start --kong-url http://kong:8001

docker run -d --link kong:kong \
    --rm -p 1337:1337 \
    --link kong:kong \
    --name kong-dashboard \
    pantsel/konga

## Konga GUI will be available at http://localhost:1337

url=http://localhost:1337
echo "open $url"

/usr/bin/open -a "/Applications/Google Chrome.app" "$url"

echo "login: admin | password: adminadminadmin"
echo "login: demo | password: demodemodemo"


