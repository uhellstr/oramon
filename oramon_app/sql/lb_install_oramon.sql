REM
REM Run this scripot using SQLcmdline connected as oramon apex ws schema
REM
cd ../oramon
pwd
lb update --changelog-file controller.xml
lb tag -tag version_1.0
cd ../sql
pwd
