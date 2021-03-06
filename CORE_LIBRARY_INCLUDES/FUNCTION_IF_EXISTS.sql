CREATE OR REPLACE FUNCTION 
IF_EXISTS ( pName SYS.ALL_OBJECTS.OBJECT_NAME%type, 
				pType SYS.ALL_OBJECTS.OBJECT_TYPE%type DEFAULT 'ALL',
				pOwner SYS.ALL_OBJECTS.OWNER%type DEFAULT 'USER' ) RETURN NUMBER AS
				
	vCount INTEGER;
	vExists NUMBER(1,0) := 0;
  
BEGIN

	IF pType = 'ALL' AND pOwner = 'ALL' THEN
	
		SELECT COUNT(*) INTO vCount FROM SYS.ALL_OBJECTS
			WHERE OBJECT_NAME = UPPER(pName);
      
	ELSIF pType = 'ALL' THEN
	
		SELECT COUNT(*) INTO vCount FROM SYS.ALL_OBJECTS
			WHERE OBJECT_NAME = UPPER(pName)
			AND OWNER = UPPER(pOwner);
	
	ELSIF pOwner = 'ALL' THEN
	
		SELECT COUNT(*) INTO vCount FROM SYS.ALL_OBJECTS
			WHERE OBJECT_NAME = UPPER(pName)
			AND OBJECT_TYPE = UPPER(pType);
			
	ELSE
	
		SELECT COUNT(*) INTO vCount FROM SYS.ALL_OBJECTS
			WHERE OBJECT_NAME = UPPER(pName)
			AND OBJECT_TYPE = UPPER(pType)
			AND OWNER = UPPER(pOwner);

    END IF;

	IF vCount > 0 THEN
		vExists := 1;
	END IF;
      
   	RETURN vExists;
end;