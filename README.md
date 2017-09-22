# plsql_core_library
PLSQL Core Library - a couple of procedures / functions to make life easier in PLSQL

#################################

CONTENTS

#################################

1.	WARRANTY AND SUPPORT
2.	INSTALLATION INSTRUCTIONS
3.	INCLUDED PROCEDURES / FUNCTIONS


#################################

1.	WARRANTY & SUPPORT

#################################

This work / library is offered without warranty either express of implied.

It is a condition of use of this library that both the original author,
and any other contributing authors are absolved of responsibility for 
any damages real or imagined which arise from the use of this work.

Support is not provided.


#################################

2.	INSTALLATION INSTRUCTIONS

#################################

The library comes with an installation script called INSTALLER.sql 

To use INSTALLER.sql its reference to the file system must be maintained.

This means you need to either:
a. open it though the IDE (e.g. SQL Developer) File menu
OR
b. drag and drop it into the IDE (if the IDE supports this)

DO NOT open the installer script, and copy paste the script from a text editor into your IDE 
as it will lose its reference to its place in the file system and not function correctly.

Once it is open in your IDE run the script and it will install the core library procedures and functions to your database.

#################################

3.	INCLUDED PROCEDURES / FUNCTIONS

#################################

IF_EXISTS	FUNCTION 	PROVIDES A MEANS TO CHECK IF A DATABASE OBJECT OF A PARTICULAR NAME, TYPE AND OR OWNER EXISTS

			RETURNS:   	1 ( FOR TRUE -> OBJECT EXISTS ) OR 0 ( FOR FALSE -> OBJECT DOES NOT EXIST)

			USAGE: 		IF_EXISTS(object_name, object_type DEFAULT 'ALL', object_owner DEFAULT 'USER')
			

DOPL		PROCEDURE    A SIMPLE SHORTCUT TO TYPING DBMS_OUTPUT.PUT_LINE

	 		USAGE:		DOPL(text_to_output);



STRIP_CONSTRAINT_NAME	FUNCTION    PROVIDES A WAY TO MORE EASILY IDENTIFY AND DEAL WITH EXCEPTIONS ARISING FROM 
	 								(NAMED) CONSTRAINTS IN AN EXCEPTION SECTION BY STRIPPING ALL THE EXCESS FROM AN
									SQLERRM AND RETURNING THE NAME OF THE CONSTRAINT THAT WAS VIOLATED.

			RETURNS:     THE NAME OF THE CONSTRAINT VIOLATED e.g. PK_MYTABLE
			
			USAGE: 		 vConstraintName := STRIP_CONSTRAINT_NAME(SQLERRM);
			
			
DROP_IF_EXISTS		PROCEDURE		PROVIDES 2 KEY FUNCTIONS
									1.	ALLOWS THE CONDITIONAL DROPPING OF A SPEFICIED DATABASE OBJECTS IF IT EXISTS
									2.  ALLOWS THE DROPPING OF ALL DATABASE OBJECTS (NOT NAMED IN EXCLUSION LIST)
									
					USAGE 1:		DROP_IF_EXISTS(object_name, cascade_constraints DEFAULT FALSE, verbose_mode DEFAULT FALSE);
					
					USAGE 2: 		DROP_IF_EXISTS('ALL', cascade_constraints DEFAULT FALSE, verbose_mode DEFAULT FALSE);
					
					WARNING: Usage 2 will delete everything in the current users account unless it is specified in the 
							 exclusions within the procedure. the section is clearly indicted with comments in the function.
							 
							 


