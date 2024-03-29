  CREATE TABLE "ORAMON"."ORAMON_BUFFER_PIN_GET_HIT_RATIO" 
   (	"SNAP_ID" NUMBER NOT NULL ENABLE,
	"SNAP_TIME" VARCHAR2(19) NOT NULL ENABLE,
	"PINHITRATE" VARCHAR2(6),
	"GETHITRATE" VARCHAR2(6),
	"HOST_NAME" VARCHAR2(64),
	"INSTANCE_NAME" VARCHAR2(4000),
	CONSTRAINT "ORAMON_BUFFER_PIN_GET_HIT_RATIO_PK" PRIMARY KEY ("SNAP_ID","SNAP_TIME")
  USING INDEX
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"