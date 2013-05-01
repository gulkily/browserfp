OVERVIEW

a framework for identifying web clients based on commonly available datapoints
currently in prototype stage, don't expect any pretty code

PURPOSE

to demonstrate ease of tracking web clients using commonly divulged data

POSSIBLE USES

* reduce impact of ballot stuffing in voting systems
* gain better understanding of users' habits
* identify unusual activity
* induce paranoia

DATAPOINTS SUPPORTED

* useragent
  * os
* client ip
  * client ip block
* accepted languages

* browser height
* browser width

* cookie

FILES

database.php
  just the database config
ez_sql_core.php
ez_sql_mysql.php
  parts of ezSQL for easy prototyping (thanks jv!)
index.php
  just a wrapper
purge.php
  purges all tracking data from the db - no warning!
sherlock.php
  where all the fun stuff happens
tables.sql
  database structure and some random data
updatesession.php
  used to log tokened datapoins from js, img tags, and the like

KNOWN ISSUES

before importing tables.sql, you have to remove all instances of this line:
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */

SEE ALSO

* http://samy.pl/evercookie/
* https://panopticlick.eff.org/browser-uniqueness.pdf
* http://en.wikipedia.org/wiki/Device_fingerprint
* http://fingerprint.pet-portal.eu/
