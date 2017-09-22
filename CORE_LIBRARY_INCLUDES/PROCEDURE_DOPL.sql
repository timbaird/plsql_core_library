/*
	PROCEDURE DOPL
	--------------
	TAKES ONE VARCHAR2 ARGUMENT AND OUTPUTS IT USING 
	DBMS_OUTPUT.PUT_LINE(pArg);
*/

CREATE OR REPLACE PROCEDURE DOPL(pString VARCHAR2) AS
BEGIN
	dbms_output.put_line(pString);
END;
/