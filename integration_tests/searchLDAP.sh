## check if ldap server is reachable
host=localhost
##port=10389
port=10389


## working
##dapsearch -x -D "cn=annie,ou=production,o=mycompany" -w secret -p ${port} -h ${host}  -s sub "(objectclass=*)"

## working
##ldapsearch -x -D "cn=annie,ou=production,o=mycompany" -w secret  -H ldap://${host}:${port}

##ldapsearch -x -h $host  -p ${port} -D "cn=annie,ou=people,o=sevenseas"  -w secret -b "o=sevenseas"  -s sub "(cn=*)" cn mail sn
ldapsearch -x -D "uid=admin,ou=system" -w secret -p ${port} -h ${host}  -s sub "(objectclass=*)"
