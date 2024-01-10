REM
REM Run using SQLcl as ORAMON schema from instance where app is installed
REM
REM apex export -expWorkspace -workspaceid <id>
REM apex export -applecationid <id> -skipExportDate -expOriginalIds -expSupportingObjects Y -expType APPLICATION_SOURCE -split
REM
apex export  -expWorkspace -workspaceid 5694472783606833
apex export -applicationid 102 -skipExportDate -expOriginalIds -expSupportingObjects Y -expType APPLICATION_SOURCE -split
