## check if ldap server is reachable
##host=ldap.forumsys.com
host=localhost
##port=10389
#3port=10389
port=389


## working
##dapsearch -x -D "cn=annie,ou=production,o=mycompany" -w secret -p ${port} -h ${host}  -s sub "(objectclass=*)"

## working
##ldapsearch -x -D "cn=annie,dc=openmicroscopy,dc=org" -w 1234567890  -H ldap://${host}:${port}

##ldapsearch -x -h $host  -p ${port} -D "cn=annie,ou=people,o=sevenseas"  -w secret -b "o=sevenseas"  -s sub "(cn=*)" cn mail sn
##ldapsearch -x -D "cn=annie,dc=openmicroscopy,dc=org" -w 1234567890 -p ${port} -h ${host}  -s sub "(objectclass=*)"
##ldapsearch -x -D "uid=admin,ou=system" -w secret -p ${port} -h ${host}  -s sub "(objectclass=*)"
ldapsearch -x -D "uid=admin,ou=system" -w secret -p ${port} -h ${host}  -s sub "(objectclass=*)"
