application_z_nginx Cookbook CHANGELOG
======================================
This file is used to list changes made in each version of the application_z_nginx cookbook.

v3.0.2
------

- Renamed fork to application_z_nginx - surprise! application requires sub-resources to be found in cookbooks prefixed with application_.

v3.0.0
------

- Renamed fork to z_application_nginx

v2.0.2
------
### Improvement
- [COOK-2730] - pass along reasonable Host, X-Forwarded-For & X-Real-IP


v2.0.0
------
- [COOK-3306]: Multiple Memory Leaks in Application Cookbook

v1.1.0
------
- [COOK-2579]: `application_nginx` cookbook should accept "`application_port`" as string for unix sockets

v1.0.4
------
- [COOK-2402]: cookbook attribute expects argument to be a string

v1.0.2
-------
- [COOK-1590] - add ssl support

v1.0.0
------
- [COOK-1244] - Initial release - relates to COOK-634.
