LDAP
====

A collection of scripts for managing LDAP trees on LDAP servers
created by this repository. Available scripts include:

- [clear](clear) clears an existing LDAP tree
- [initialize](initialize) initializes a new LDAP tree
- [user](user) manages LDAP users (addition, group membership/ownership)
- [group](group) manages LDAP groups (addition)
- [search](search) searches the LDAP tree specified by the input domain

The connection credentials and the LDAP tree domain are defined and can be
overriden using four environment variable: `LDAPHOST`, `LDAPPORT`, `LDAPPASS` 
and `LDAPDOMAIN`.
