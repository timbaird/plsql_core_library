create or replace PROCEDURE  DROP_IF_EXISTS 
			(
			 pObjectName SYS.ALL_OBJECTS.OBJECT_NAME%TYPE,
			 pCascadeConstraints BOOLEAN DEFAULT FALSE,
             pDebugMode BOOLEAN DEFAULT FALSE
													) AUTHID CURRENT_USER AS

	vCount INTEGER;
	vObjType SYS.ALL_OBJECTS.OBJECT_TYPE%TYPE;
	vDropString VARCHAR2(500);
	
	CURSOR vCur IS 
		SELECT OBJECT_NAME, OBJECT_TYPE
		FROM SYS.ALL_OBJECTS
		WHERE OWNER = USER
		ORDER BY OBJECT_TYPE DESC;
		
BEGIN
----------------------------------------------------
-- FIRST SECTION DEALS WITH DROPPING 'ALL'
----------------------------------------------------

	IF UPPER(pObjectName) = 'ALL' THEN
	
		IF pDebugMode = TRUE THEN
			dbms_output.put_line('---------------------------------------------------');
			dbms_output.put_line('LISTING OF DROP STATEMENTS EXECUTED APPEARS BELOW');
			dbms_output.put_line('---------------------------------------------------');
		END IF;
	
		FOR vRec IN vCur 
		LOOP
    
			IF (vRec.OBJECT_NAME NOT IN (
			
				-- ########################################################
				-- ###### OBJECTS NAMED BELOW WILL NOT BE DROPPED WHEN 'ALL' IS PASSED AS AN ARGUMENT.
        		-- ######
        		-- ###### ENTRIES MUST BE COMMA DELIMITED
				-- ###### EXCEPT LAST ENTRY WHICH MUST HAVE NO COMMA
				
        		'DROP_IF_EXISTS',
				'IF_EXISTS',
				'STRIP_CONSTRAINT_NAME',
				'STRIP_CONSTRAINT',
				'DOPL',
        		'DWDATE'
				) 
				-- ends IN collection
				
        		-- EXCLUDES OBJECTS WHICH HAVE A COMMON PREFIX / NAMING CONVENTION
        		And Upper(Vrec.Object_Name) Not Like 'A1M%' -- ASSIGNMENT 1 MARKING SCRIPT
        		And Upper(Vrec.Object_Name) Not Like 'A2%'  -- ASSIGNMENT 2 MARKING SCRIPT
        		And Upper(Vrec.Object_Name) Not Like 'MS%'   
        		
				-- ###### DO NOT ALTER CODE BELOW THIS POINT
				-- ########################################################
				-- ########################################################
				-- ########################################################
				
				AND UPPER(VREC.OBJECT_NAME) NOT LIKE 'BIN%' -- SYSTEM OBJECTS - DO NOT REMOVE
				And Upper(Vrec.Object_Type) <> 'INDEX' -- SYSTEM OBJECTS - DO NOT REMOVE 
				
				) THEN
		
				vDropString := 'DROP ' || vRec.OBJECT_TYPE || ' ' || vRec.OBJECT_NAME;
		
		    	IF vRec.OBJECT_TYPE = 'TABLE' THEN
		      		vDropString := vDropString || ' CASCADE CONSTRAINTS';
		    	END IF;
		
        BEGIN
          EXECUTE IMMEDIATE vDropString;
        EXCEPTION
          WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('PROBLEM EXECUTING FOLLOWING COMMAND ' || VDROPSTRING);
        END;
				
				IF pDebugMode = TRUE THEN
					dbms_output.put_line(vDropString);
				END IF;
	    		
			END IF;
      
		END LOOP;

		IF pDebugMode = TRUE THEN
			dbms_output.put_line('---------------------------------------------------');
			dbms_output.put_line('DROPPING COMPLETED');
			dbms_output.put_line('---------------------------------------------------');
		END IF;
----------------------------------------------------	
	ELSE -- SECOND SECTION DEALS WITH DROPPING A SPECIFICLY NAMED OBJECT
----------------------------------------------------
		SELECT OBJECT_TYPE INTO vObjType 
			FROM SYS.ALL_OBJECTS
			WHERE OBJECT_NAME = UPPER(pObjectName)
			AND OWNER = USER;	
	 
		vDropString := 'DROP ' || vObjType || ' ' || UPPER(pObjectName);
			
		IF pCascadeConstraints = TRUE and vObjType = 'TABLE' THEN
			vDropString := vDropString || ' CASCADE CONSTRAINTS';
    	END IF;

    	EXECUTE IMMEDIATE vDropString;

    	IF pDebugMode = TRUE THEN
      		dbms_output.put_line(vObjType || ' ' || UPPER(pObjectName) || ' DROPPED');
    	END IF; 
	END IF;

EXCEPTION

	WHEN NO_DATA_FOUND THEN
	    IF pDebugMode = TRUE THEN
      		dbms_output.put_line('NO OBJECT NAMED ' || UPPER(pObjectName) || ' EXISTS');
		END IF; 
		
END;
/

GRANT EXECUTE ON TBAIRD.DROP_IF_EXISTS TO PUBLIC;