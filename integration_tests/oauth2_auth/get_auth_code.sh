
#!/bin/bash

source ../common_functions.sh
set -x

url="http://127.0.0.1:3000/authorize?response_type=code&scope=email%20address&client_id=helloWorldApp_id"

/usr/bin/open -a "/Applications/Google Chrome.app" "$url"