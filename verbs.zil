"VERBS for
			       PLANETFALL
	  (c) COPYRIGHT 1983 INFOCOM INC. ALL RIGHTS RESERVED"

<GLOBAL VERBOSE <>>

<GLOBAL SUPER-BRIEF <>>

;<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Super-brief descriptions." CR>>

<ROUTINE V-LOOK ()
	 <SETG C-ELAPSED 9>
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-CRETIN ()
	 <TELL
"This isn't a primitive two-word-parser adventure game. If you want
to look AT that object, please say so." CR>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF>
		       <DESCRIBE-OBJECTS>)>)>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<AND <NOT <HERE? ,PRSO>>
		     <NOT <IN? ,PRSO ,GLOBAL-OBJECTS>>
		     <NOT <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		     <NOT <AND <IN? ,PRSO ,LOCAL-GLOBALS>
			       <GLOBAL-IN? ,PRSO ,HERE>>>
		     <NOT <EQUAL? ,PRSO ,GRUE>>>
		<TELL "You can't see any">
		<PRSO-PRINT>
		<TELL " here!" CR>)>>		

<ROUTINE V-EXAMINE ()
	 <SETG C-ELAPSED 32>
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "The " D ,PRSO " is closed." CR>)>)
	       (T
		<TELL "I see nothing special about the " D ,PRSO "." CR>)>>

<GLOBAL LIT <>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL "It is pitch black. You might be eaten by a grue." CR>
		<COND (<EQUAL? ,HERE ,TRANSPORTATION-SUPPLY>
		       <TELL "There is light to the south." CR>)>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS>
		<TELL D ,HERE>
		<COND (<FSET? <LOC ,ADVENTURER> ,VEHBIT>
		       <TELL ", in the " D <LOC ,ADVENTURER>>)>
		<CRLF>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<SET AV <LOC ,ADVENTURER>>
		;<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are in the " D .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T 
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>>
			    <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (T
		<TELL "You can't see anything in the dark." CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<EQUAL? .OBJ ,SPOUT-PLACED>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<AND <0? .LEVEL>>
		<TELL "There is ">
		<COND (<FSET? .OBJ ,VOWELBIT>
		       <TELL "an ">)
		      (T
		       <TELL "a ">)>
		<TELL D .OBJ " here.">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<COND (<FSET? .OBJ ,VOWELBIT>
		       <TELL "An ">)
		      (T
		       <TELL "A ">)>
		<TELL D .OBJ>
		<COND (<FSET? .OBJ ,WORNBIT> <TELL " (being worn)">)>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,ADVENTURER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? AV STR (PV? <>) (INV? <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>>
		<RTRUE>)>
	 <COND (<AND <SET AV <LOC ,ADVENTURER>>
		     <FSET? .AV ,VEHBIT>>
		T)
	       (T
		<SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,ADVENTURER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (T
		<REPEAT ()
			<COND (<NOT .Y> <RETURN <NOT .1ST?>>)
			      (<EQUAL? .Y .AV> <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,ADVENTURER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ " is:" CR>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL "The " D .OBJ " is holding:" CR>)
		      (T
		       <TELL "The " D .OBJ " contains:" CR>)>)>>


;"scoring"

<GLOBAL INTERNAL-MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL DAY 1>

<ROUTINE SCORE-OBJ (OBJ)
	 <COND (<G? <GETP .OBJ ,P?VALUE> 0>
		<FSET .OBJ ,TOUCHBIT>
		<SETG SCORE <+ ,SCORE <GETP .OBJ ,P?VALUE>>>
		<PUTP .OBJ ,P?VALUE 0>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 <TELL "Your score ">
	 <COND (.ASK?
		<TELL "would be ">)
	       (T
		<TELL "is ">)>
	 <TELL N ,SCORE>
	 <TELL " (out of 80 points). It is Day ">
	 <TELL N, DAY>
	 <TELL " of your adventure. Current Galactic Standard Time ">
	 <COND (<IN? ,CHRONOMETER ,ADVENTURER>
		<TELL "(adjusted to your local day-cycle) is ">
		<COND (<FSET? ,CHRONOMETER ,MUNGEDBIT>
		       <TELL N ,MUNGED-TIME>)
		      (T
		       <TELL N ,INTERNAL-MOVES>)>)
	       (T
		<TELL
"is impossible to determine, since you're not wearing your chronometer">)>
	 <TELL "." CR>
	 <TELL "This score gives you the rank of ">
	 <COND (<EQUAL? ,SCORE 80> <TELL "Galactic Overlord">)
	       (<G? ,SCORE 72> <TELL "Cluster Admiral">)
	       (<G? ,SCORE 64> <TELL "System Captain">)
	       (<G? ,SCORE 48> <TELL "Planetary Commodore">)
	       (<G? ,SCORE 36> <TELL "Lieutenant">)
	       (<G? ,SCORE 24> <TELL "Ensign First Class">)
	       (<G? ,SCORE 12> <TELL "Space Cadet">)
	       (T <TELL "Beginner">)>
	 <TELL "." CR>
	 ,SCORE>

<ROUTINE FINISH (DIED "OPTIONAL" (REPEATING <>))
	 <CRLF>
	 <COND (<NOT .REPEATING>
		<V-SCORE>
		<COND (.DIED
		       <TELL CR
"Oh, well. According to the Treaty of Gishen IV, signed in 8747 GY, all
adventure game players must be given another chance after dying. In the
interests of interstellar peace..." CR>)>
		;<V-SCORE>
		;<CRLF>)>
	 <PUTB ,P-INBUF 0 10> ;"so you can't input too many characters"
	 <TELL CR
"Would you like to restart the game from the beginning, restore a saved game
position, or end this session of the game? (Type RESTART, RESTORE, or QUIT.)"
CR CR ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <PUTB ,P-INBUF 0 80>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTAR>
	        <RESTART>
		<TELL "Failed." CR>
		<FINISH <> T>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?RESTOR>
		<COND (<RESTORE>
		       <TELL "Ok." CR>)
		      (T
		       <TELL "Failed." CR>
		       <FINISH <> T>)>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
		;<TELL "You took " N ,ELAPSED-MOVES " moves." CR>
		<QUIT>)
	       (T
		<FINISH <> T>)>>

<ROUTINE V-QUIT ;("OPTIONAL" (ASK? T) "AUX" SCOR) ()
	 <V-SCORE>
	 <COND (<AND <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,RLANDBIT>>
		<SETG FLOYD-SPOKE T>
		<TELL CR "Floyd grins impishly. \"Giving up, huh?\"" CR>)>
	 <TELL CR "Do you wish to leave the game? (Y is affirmative): ">
	 <COND (<YES?>
		<QUIT>)
	       (T
		<TELL "Ok." CR>)>>

<ROUTINE YES? ()
	 <PUTB ,P-INBUF 0 10> ;"so you can't input too many characters"
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <PUTB ,P-INBUF 0 80>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	 <TELL
"PLANETFALL|
Infocom interactive fiction - a science fiction story|
Copyright (c) 1983 by Infocom, Inc. All rights reserved.|
">
	 ;<COND (<NOT <EQUAL? <BAND <GETB 0 1> 8> 0>>
		<TELL "Licensed to Tandy Corporation.|">)>
	 <TELL
"PLANETFALL is a registered trademark of Infocom, Inc.|
Release ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>
	 <COND (<AND <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,RLANDBIT>>
		<SETG FLOYD-SPOKE T>
		<TELL CR
"\"Last version was better,\" says Floyd. \"More bugs. Bugs make
game fun.\"" CR>)>>

<ROUTINE V-AGAIN ("AUX" OBJ)
	 <COND (<NOT ,L-PRSA>
		<ANYMORE>)
	       (<AND <NOT <EQUAL? ,HERE ,LAST-PSEUDO-LOC>>
		     <EQUAL? ,PSEUDO-OBJECT ,L-PRSO ,L-PRSI>>
		<SETG L-PRSA <>>
		<ANYMORE>)
	       (<EQUAL? ,L-PRSA ,V?WALK>
		<DO-WALK ,L-PRSO>)
	       (T
	        <SET OBJ
		     <COND (<AND ,L-PRSO
				 <EQUAL? <LOC ,L-PRSO> <>>>
			    ,L-PRSO)
			   (<AND ,L-PRSI
				 <EQUAL? <LOC ,L-PRSI> <>>>
			    ,L-PRSI)>>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
		       <ANYMORE>
		       <RFATAL>)
		      (T
		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>
		       <RTRUE>)>)>>


;"death"

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 <TELL .DESC CR>
	 <TELL CR
"    ****  You have died  ****" CR>
	 <FINISH T>>

<ROUTINE V-RESTORE ()
	 <COND (<AND <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,RLANDBIT>>
		<SETG FLOYD-SPOKE T>
		<TELL
"Floyd looks disappointed, but understanding. \"That part of the game was more
fun than this part,\" he admits." CR CR>)>
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		;<V-FIRST-LOOK>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<AND <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,RLANDBIT>>
		<SETG FLOYD-SPOKE T>
		<TELL
"Floyd's eyes light up. \"Oh boy! Are we gonna try something
dangerous now?\"" CR CR>)>
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <COND (<AND <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,RLANDBIT>>
		<SETG FLOYD-SPOKE T>
		<TELL "Floyd looks sad. \"Going away?\" he asks." CR>)>
	 <TELL CR "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<ROUTINE V-WALK-AROUND ()
	 <USE-DIRECTIONS>>

<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<TELL "It's here!" CR>)
	       (T
		<USE-DIRECTIONS>)>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM TEMP-ELAPSED)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<SET TEMP-ELAPSED <GETP ,HERE ,P?C-MOVE>>
		       <SET TEMP-ELAPSED <GET .TEMP-ELAPSED 
					      <- ,PRSO ,LOW-DIRECTION>>>)>
		<COND (<EQUAL? .TEMP-ELAPSED 0>
		       <SET TEMP-ELAPSED ,DEFAULT-MOVE>)>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <SETG C-ELAPSED .TEMP-ELAPSED>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <SETG C-ELAPSED .TEMP-ELAPSED>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "You can't go that way." CR>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <SETG C-ELAPSED .TEMP-ELAPSED>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <NOT ,LIT>
		     <PROB 75>>
		<JIGS-UP
"Oh, no! You have walked into the slavering fangs of a lurking grue!">)
	       (T
		<TELL "You can't go that way." CR>
		<RFATAL>)>>

<ROUTINE V-INVENTORY ()
	 <SETG C-ELAPSED 18>
	 <COND (<FIRST? ,ADVENTURER>
		<PRINT-CONT ,ADVENTURER>)
	       (T
		<TELL "You are empty-handed." CR>)>>

<GLOBAL INDENTS
	<PTABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>


;"object manipulation"

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,ADVENTURER>
		<TELL "You already have it." CR>)
	       (<AND <EQUAL? ,PRSO ,GOOD-BOARD>
		     <FSET? ,GOOD-BOARD ,NDESCBIT>>
		<RFALSE>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "You can't reach into a closed container." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
		       <COND (<AND <EQUAL? ,PRSO ,KEY>
				   <NOT <FSET? ,KEY ,TOUCHBIT>>>
			      <RFALSE>)
			     (<AND <EQUAL? ,PRSO ,CELERY>
				   <EQUAL? ,PRSI ,AMBASSADOR>>
			      <RFALSE>)
			     (T
			      <TELL "It's not in that!" CR>)>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,ADVENTURER>>
		<TELL "You are in it, asteroid-brain!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<TELL "Taken." CR>)>>

<GLOBAL FUMBLE-NUMBER 7>

<GLOBAL FUMBLE-PROB 8>

<ROUTINE TRYTAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<RTRUE>)
	       (<AND <FSET? ,PRSO ,TRYTAKEBIT>
		     <GETP ,PRSO ,P?ACTION>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (T
		<ITAKE>)>>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,ADVENTURER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,ADVENTURER>>
			 ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load is too heavy." CR>)>
		<RFATAL>)
	       (<AND <G? <SET CNT <CCOUNT ,ADVENTURER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		 <SET OBJ <FIRST? ,ADVENTURER>>
		 <REPEAT ()
			<COND (<FSET? .OBJ ,WORNBIT>
			       <SET OBJ <NEXT? .OBJ>>)
			      (T
			       <RETURN>)>>
		;"This must go!  Chomping compiler strikes again"
		<TELL
"Oh, no. The " D .OBJ " slips from your arms while taking the " D ,PRSO
" and both tumble to the ground." CR>
		<COND (<AND <EQUAL? ,FLASK .OBJ ,PRSO>
			    <IN? ,CHEMICAL-FLUID ,FLASK>>
		       <REMOVE ,CHEMICAL-FLUID>
		       <TELL
"Unfortunately, the chemical spills out of the flask and evaporates." CR>)>
	        <COND (<AND <EQUAL? ,CANTEEN .OBJ ,PRSO>
			    <IN? ,HIGH-PROTEIN ,CANTEEN>
			    <FSET? ,CANTEEN ,OPENBIT>>
		       <REMOVE ,HIGH-PROTEIN>
		       <TELL
"To make matters worse, the high-protein liquid spills all over
the place and then evaporates." CR>)>
		<MOVE .OBJ ,HERE>
		<MOVE ,PRSO ,HERE>
		<RFATAL>)
	       (T
		<MOVE ,PRSO ,ADVENTURER>
		<FCLEAR ,PRSO ,NDESCBIT>
		<SCORE-OBJ ,PRSO>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<EQUAL? ,PRSO ,SPOUT-PLACED>
		       <SETG SPOUT-PLACED ,GROUND>)>
		<RTRUE>)>>

<ROUTINE PRE-PUT ()
	 <COND (<NOT ,PRSO>
		<RFALSE>)>
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<TELL "You can't while you're wearing it." CR>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)>>

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "You can't do that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "The " D ,PRSI " isn't open." CR>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "The " D ,PRSO " is already in the " D ,PRSI "." CR>)
	       (<IN? ,PRSI ,PRSO>
		<TELL
"How can you put the " D ,PRSO " in the " D ,PRSI
" when the " D ,PRSI " is already in the " D ,PRSO "?" CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <TRYTAKE>>>
		<RTRUE>)
	       (T
		<SCORE-OBJ ,PRSO>
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-SLIDE ()
	 <TELL <PICK-ONE ,YUKS> CR>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<NOT-HOLDING>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "You can't give ">
		<A-AN>
		<TELL D ,PRSO " to ">
		<COND (<FSET? ,PRSI ,VOWELBIT>
		       <TELL "an ">)
		      (T
		       <TELL "a ">)>
		<TELL D ,PRSI "!" CR>)
	       (T
		<TELL "The " D ,PRSI " declines your offer." CR>)>>

<ROUTINE V-SGIVE ()
	 <TELL "Foo!" CR>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Dropped." CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<TELL "Thrown." CR>)>>

<ROUTINE IDROP ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL "You're not carrying the " D ,PRSO "." CR>
		<RFALSE>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TAKE-IT-OFF>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "The " D ,PRSO " is closed." CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO ,HERE>
		<RTRUE>)>>


;"plain old verbs"

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL
"You must be very clever to do that to the " D ,PRSO "." CR>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY "open">)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <COND (<FSET? ,PRSO ,DOORBIT>
			      <TELL "The " D ,PRSO " is now open." CR>)
			     (<OR <NOT <FIRST? ,PRSO>>
				  <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "The " D ,PRSO " opens." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening the " D ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (T
		<TELL "The " D ,PRSO " cannot be opened." CR>)>>

<ROUTINE V-OPEN-WITH ()
	 <COND (<EQUAL? ,PRSI ,HANDS>
		<PERFORM ,V?OPEN ,PRSO>
		<RTRUE>)
	       (T
		<TELL "That doesn't work." CR>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST?
			       <SET 1ST? <>>)
			      (T
			       <TELL ", ">
			       <COND (<NOT .N>
				      <TELL "and ">)>)>
			<TELL "a " D .F>
			<COND (<AND <NOT .IT?>
				    <NOT .TWO?>>
			       <SET IT? .F>)
			      (T
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT?
					   <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE V-CLOSE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		    <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL "You can't do that to ">
		<A-AN>
		<TELL D ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <OR <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>
			 <FSET? ,PRSO ,DOORBIT>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>)
		      (T
		       <ALREADY "closed">)>)
	       (T
		<TELL "You cannot close that." CR>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<SET CNT <+ .CNT 1>>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

"WEIGHT:  Get sum of SIZEs of supplied object, recursing to the nth level."

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .CONT ,WORNBIT>>
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

<GLOBAL COPR-NOTICE
" a transcript of interaction with PLANETFALL.|
PLANETFALL is a registered trademark of Infocom, Inc.|
Copyright (c) 1983 Infocom, Inc.  All rights reserved.|">

<ROUTINE V-SCRIPT ()
	<COND (<AND <IN? ,FLOYD ,HERE>
		    <FSET? ,FLOYD ,RLANDBIT>>
	       <SETG FLOYD-SPOKE T>
	       <TELL
"Floyd hops around excitedly. \"Oh boy! I've never seen my name in print
before!\"" CR CR>)>
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" ,COPR-NOTICE CR>>

<ROUTINE V-UNSCRIPT ()
	<COND (<AND <IN? ,FLOYD ,HERE>
		    <FSET? ,FLOYD ,RLANDBIT>>
	       <SETG FLOYD-SPOKE T>
	       <TELL
"\"Can I have a copy of the printout?\" asks Floyd,
looking up at you." CR CR>)>
	<TELL "Here ends" ,COPR-NOTICE CR>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Why juggle objects?" CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving the " D ,PRSO " reveals nothing." CR>)
	       (T
		<TELL "You can't move the " D ,PRSO "." CR>)>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <ALREADY "on">)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "The " D ,PRSO " is now on." CR>)>)
	       (T
		<TELL "You can't turn that on." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <ALREADY "off">)
		      (T
		       <FCLEAR ,PRSO ,ONBIT>
		       <TELL "The " D ,PRSO " is now off." CR>)>)
	       (T
		 <TELL "You can't turn that off." CR>)>
	 <RTRUE>>

<ROUTINE V-WAIT () ;("OPTIONAL" (NUM 3))
	 <SETG C-ELAPSED 40>
	 <TELL "Time passes..." CR>
	 ;<REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>
		 <SETG INTERNAL-MOVES <+ ,INTERNAL-MOVES 1>>>
	 ;<SETG CLOCK-WAIT T>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,ADVENTURER>>
	 <COND (<EQUAL? ,PRSO ,GROUND ,GLOBAL-SHUTTLE>
		<RFALSE>)
	       (<FSET? ,PRSO ,VEHBIT>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "You are already in it!" CR>)
		      (T
		       <RFALSE>)>)
	       (T
		<TELL "I suppose you have a theory on boarding ">
 	        <A-AN>
		<TELL D ,PRSO "." CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("AUX" AV)
	 <TELL "You are now in the " D ,PRSO "." CR>
	 <MOVE ,ADVENTURER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-DISEMBARK ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<COND (<IN? ,ADVENTURER ,SAFETY-WEB>
		       <PERFORM ,V?DISEMBARK ,SAFETY-WEB>
		       <RTRUE>)
		      (<IN? ,ADVENTURER ,BED>
		       <OWN-FEET>)
		      (<IN? ,ADVENTURER ,SHUTTLE-CAR-ALFIE>
		       <DO-WALK ,P?NORTH>)
		      (<IN? ,ADVENTURER ,SHUTTLE-CAR-BETTY>
		       <DO-WALK ,P?SOUTH>)
		      (<IN? ,ADVENTURER ,BRIG>
		       <PERFORM ,V?ZESCAPE>
		       <RTRUE>)
		      (T
		       <DO-WALK ,P?OUT>)>)
	       (<NOT <EQUAL? <LOC ,ADVENTURER> ,PRSO>>
		<TELL "You're not in that!" CR>
		<RFATAL>)
	       (T
		<OWN-FEET>)>>

<ROUTINE OWN-FEET ()
	 <MOVE ,ADVENTURER ,HERE>
	 <TELL "You're on your own feet again." CR>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,ADVENTURER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,ADVENTURER>>
		<RTRUE>)
	       (T
		<TELL "You are already standing, I think." CR>)>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" (WLOC <LOC ,WINNER>) OLIT)
	 <SET OLIT ,LIT>
	 <MOVE ,ADVENTURER .RM>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <NOT .OLIT>
		     <NOT ,LIT>
		     <PROB 75>>
		<JIGS-UP
"Oh, no! Something (a grue?) slithered into the room and devoured you!">
		<RTRUE>)>
	 <COND (<EQUAL? <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER> 2>
		<RTRUE>)>
	 <COND (.V?
		<V-FIRST-LOOK>)>
	 <SCORE-OBJ .RM>
	 <RTRUE>>

<ROUTINE V-EAT ()
	 <TELL "I don't think that the " D ,PRSO " would agree with you." CR>>

<ROUTINE V-EAT-FROM ("AUX" X)
	 <SET X <FIRST? ,PRSO>>
	 <COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's closed." CR>)
	       (<NEXT? .X>
		<TELL "There's more than one thing in the " D ,PRSO "." CR>)
	       (.X
		<PERFORM ,V?EAT .X>
		<RTRUE>)
	       (T
		<TELL "It's empty!" CR>)>>

<ROUTINE V-CURSE ()
	 <TELL "Such language from an Ensign in the Stellar Patrol!" CR>>

<ROUTINE V-LISTEN ()
	 <SETG C-ELAPSED 18>
	 <TELL "The " D ,PRSO " makes no sound." CR>>

<ROUTINE V-FOLLOW ()
	 <TELL "The " D ,PRSO " is right here!" CR>>

<ROUTINE V-LEAP ()
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
"The " D ,PRSO " is too big to jump over." CR>)
			     (T
			      <V-SKIP>)>)
		      (T
		       <TELL "That would be a good trick." CR>)>)
	       (T
		<V-SKIP>)>>

<ROUTINE V-SKIP ()
	 <TELL <PICK-ONE ,WHEEEEE> CR>>

<ROUTINE V-LEAVE () 
	 <COND (<IN? ,ADVENTURER ,BED>
		<PERFORM ,V?DISEMBARK ,BED>
		<RTRUE>)
	       (<IN? ,ADVENTURER ,SAFETY-WEB>
		<PERFORM ,V?DISEMBARK ,SAFETY-WEB>
		<RTRUE>)
	       (T
		<DO-WALK ,P?OUT>)>>

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<TELL
"Until now, I've only heard demented Denebian Devils say \"Hello\" to ">
		<A-AN>
		<TELL D ,PRSO "." CR>)
	       (T
		<TELL <PICK-ONE ,HELLOS> CR>)>>

<GLOBAL HELLOS
	<PLTABLE "Hello."
	         "Nice weather we're having."
	         "Goodbye.">>

<ROUTINE V-HELP ()
	 <TELL
"If you're really stuck, you can order a complete map and InvisiClues
Hint Booklet using the order form in your game package." CR>>

<GLOBAL WHEEEEE
	<PLTABLE
"You've spent too much time among the Leaping Loon-toads of Leonia."
"Having fun?"
"Wheeeeeee!!!">>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL "It is impossible to read in the dark." CR>
		<RTRUE>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "How can I read ">
		<A-AN>
		<TELL D ,PRSO "?" CR>)
	       (T
		<TELL <GETP ,PRSO ,P?TEXT> CR>
		<SETG C-ELAPSED 18>)>>

<ROUTINE V-LOOK-UNDER ()
	 <TELL "There is nothing but ">
	 <COND (<EQUAL? ,PRSO ,AMBASSADOR>
		<TELL "slime">)
	       (T
		<TELL "dust">)>
	 <TELL " there." CR>>

<ROUTINE V-LOOK-BEHIND ()
	 <V-LOOK-UNDER>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "There is nothing special to be seen." CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"The " D ,PRSO " is open, but I can't tell what's beyond it">)
		      (T
		       <TELL "The " D ,PRSO " is closed">)>
		<TELL "." CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO>
				   <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     (<FSET? ,PRSO ,SURFACEBIT>
			      <TELL
"There is nothing on the " D ,PRSO "." CR>)
			     (T
			      <TELL "The " D ,PRSO " is empty." CR>)>)
		      (T
		       <TELL "The " D ,PRSO " is closed." CR>)>)
	       (<FSET? ,PRSO ,TRANSBIT>
		<TELL "You can see dimly through the " D ,PRSO "." CR>)
	       (T
		<TELL "You can't look inside ">
		<A-AN>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT> <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE V-LOOK-DOWN ()
	 <PERFORM ,V?EXAMINE ,GROUND>
	 <RTRUE>>

<ROUTINE V-TURN ()
	 <TELL "You can't do that." CR>>

<ROUTINE V-LOCK ()
	 <V-TURN>>

<ROUTINE V-UNLOCK ()
	 <V-TURN>>

<ROUTINE V-ATTACK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "The " D ,PRSO " is frightened and backs away." CR>)
	       (T
		<TELL "I've known strange beings, but attacking ">
		<A-AN>
		<TELL D ,PRSO "???" CR>)>>
 
<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking the ">>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Waving the ">>

<ROUTINE V-RUB ()
	 <HACK-HACK "Fiddling with the ">>

<ROUTINE V-PUSH ()
	 <COND (<AND <NOT ,PRSI>
		     <EQUAL? ,PRSO ,INTNUM>>
		<COND (<EQUAL? ,HERE ,LIBRARY-LOBBY ,MINI-BOOTH>
		       <TELL
"You probably want to use the TYPE command. Check your documentation." CR>)
		      (<EQUAL? ,P-NUMBER 1>
		       <COND (<EQUAL? ,HERE ,BOOTH-2 ,BOOTH-3>
			      <PERFORM ,V?PUSH ,TELEPORTATION-BUTTON-1>
			      <RTRUE>)
			     (<EQUAL? ,HERE ,BOOTH-1>
			      <NO-BUTTON ,BOOTH-1>)
			     (T
			      <TELL "Push a number?!?" CR>)>)
		      (<EQUAL? ,P-NUMBER 2>
		       <COND (<EQUAL? ,HERE ,BOOTH-1 ,BOOTH-3>
			      <PERFORM ,V?PUSH ,TELEPORTATION-BUTTON-2>
			      <RTRUE>)
			     (<EQUAL? ,HERE ,BOOTH-2>
			      <NO-BUTTON ,BOOTH-2>)
			     (T
			      <TELL "Push a number?!?" CR>)>)
		      (<EQUAL? ,P-NUMBER 3>
		       <COND (<EQUAL? ,HERE ,BOOTH-1 ,BOOTH-2>
			      <PERFORM ,V?PUSH ,TELEPORTATION-BUTTON-3>
			      <RTRUE>)
			     (<EQUAL? ,HERE ,BOOTH-3>
			      <NO-BUTTON ,BOOTH-3>)
			     (T
			      <TELL "Push a number?!?" CR>)>)
		      (T
		       <TELL "Push a number?!?" CR>)>)
	       (T
		<HACK-HACK "Pushing the ">)>>

<ROUTINE NO-BUTTON (NUMBER)
	 <TELL "There's no button here that's labelled with the number ">
	 <COND (<EQUAL? .NUMBER ,BOOTH-1>
		<TELL "1">)
	       (<EQUAL? .NUMBER ,BOOTH-2>
		<TELL "2">)
	       (<EQUAL? .NUMBER ,BOOTH-3>
		<TELL "3">)>
	 <TELL "." CR>>

<ROUTINE V-PUSH-UP ()
	 <HACK-HACK "Pushing up the ">>

<ROUTINE V-PUSH-DOWN ()
	 <HACK-HACK "Pushing down the ">>

<ROUTINE V-PULL ()
	 <HACK-HACK "Pulling the ">>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to destroy the ">>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR D ,PRSO <PICK-ONE ,HO-HUM> CR>>

<GLOBAL HO-HUM
	<PLTABLE
	 " isn't notably helpful."
	 " has no effect."
	 " is as worthwhile as cleaning a Grotch cage.">>

<ROUTINE WORD-TYPE (OBJ WORD "AUX" SYNS)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE V-KNOCK ()
	 <COND (<WORD-TYPE ,PRSO ,W?DOOR>
		<TELL "Nobody's home." CR>)
	       (T
		<TELL "Why knock on ">
		<A-AN>
		<TELL D ,PRSO "?" CR>)>>

<ROUTINE V-YELL ()
	 <TELL "Aarrrrggggggghhhhhhhh!" CR>>

<ROUTINE BATTERY-FALLS ()
	 <TELL "The battery falls out." CR>>

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<AND <NOT <HELD? ,PRSO>>
		     <NOT <EQUAL? ,PRSO ,HANDS>>>
		<NOT-HOLDING>)
	       (<EQUAL? ,PRSO ,LASER>
		<COND (<IN? ,OLD-BATTERY ,LASER>
		       <MOVE ,OLD-BATTERY ,HERE>
		       <BATTERY-FALLS>)
		      (<IN? ,NEW-BATTERY ,LASER>
		       <MOVE ,NEW-BATTERY ,HERE>
		       <BATTERY-FALLS>)
		      (T
		       <TELL "Shaken." CR>)>)
	       (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
		     <FIRST? ,PRSO>>
		<TELL
"It sounds as if there is something inside the " D ,PRSO "." CR>)
	       (<FSET? ,PRSO ,OPENBIT>
		<COND (<AND <EQUAL? ,PRSO ,FOOD-KIT>
			    <OR <IN? ,RED-GOO ,FOOD-KIT>
				<IN? ,GREEN-GOO ,FOOD-KIT>
				<IN? ,BROWN-GOO ,FOOD-KIT>>>
		       <REMOVE ,RED-GOO>
		       <REMOVE ,GREEN-GOO>
		       <REMOVE ,BROWN-GOO>
		       <TELL
"Colored goo flies all over everything. Yechh!" CR>)
		      (<FIRST? ,PRSO>
		       <REPEAT ()
			       <COND (<SET X <FIRST? ,PRSO>>
			              <COND (<EQUAL? .X ,HIGH-PROTEIN
					                ,CHEMICAL-FLUID>
				             <REMOVE .X>)
				            (T
				             <MOVE .X ,HERE>)>)
			             (T
				      <RETURN>)>>
		       <TELL
"The contents of the " D ,PRSO " spill onto the floor." CR>)
		      (T
		       <TELL "You have shaken the " D ,PRSO "." CR>)>)
	       (<FSET? ,PRSO ,CONTBIT>
		<TELL "The " D ,PRSO " sounds empty." CR>)
	       (T
		<TELL "Shaken." CR>)>>

<ROUTINE V-SHAKE-WITH ()
	 <COND (<EQUAL? ,PRSO ,HANDS>
		<COND (<FSET? ,PRSI ,ACTORBIT>
		       <PERFORM ,V?SHAKE ,HANDS>
		       <RTRUE>)
		      (T
		       <TELL "You can't shake hands with ">
		       <A-AN>
		       <TELL D ,PRSI "!" CR>)>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-SMELL ()
	 <TELL "It smells just like ">
	 <A-AN>
	 <TELL D ,PRSO "." CR>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TEE <- <PTSIZE .TEE> 1>>)>>

<ROUTINE V-SWIM ()
	 <COND (<EQUAL? ,HERE ,UNDERWATER>
		<TELL
"Not much else you can do here. Might try a direction next time, though." CR>)
	       (T
		<TELL "You can't swim here!" CR>)>>

<ROUTINE V-SWIM-DIR ()
	 <COND (<EQUAL? ,HERE ,UNDERWATER>
		<TELL "Okay. You're still underwater." CR>)
	       (T
		<PERFORM ,V?SWIM>
		<RTRUE>)>>

<ROUTINE V-SWIM-UP ()
	 <COND (<EQUAL? ,HERE ,UNDERWATER>
	        <DO-WALK ,P?UP>)
	       (<PERFORM ,V?SWIM>
		<RTRUE>)>>

<ROUTINE V-ALARM ()
	 <TELL "The " D ,PRSO " isn't sleeping." CR>>

<ROUTINE V-ZORK ()
	 <TELL "Gesundheit!" CR>>

<ROUTINE V-SIT ()
	 <COND (<EQUAL? ,HERE ,ESCAPE-POD>
		<TELL "(in the web)" CR>
		<PERFORM ,V?BOARD ,SAFETY-WEB>
		<RTRUE>)
	       (<OR <EQUAL? ,HERE ,DORM-A ,DORM-B ,DORM-C>
		    <EQUAL? ,HERE ,DORM-D ,INFIRMARY>>
		<TELL "(on the bed)" CR>
		<PERFORM ,V?BOARD ,BED>
		<RTRUE>)
	       (T
		<SETG C-ELAPSED 31>
		<TELL
"You recline on the floor for a bit, and then stand up again." CR>)>>

<ROUTINE V-SIT-DOWN ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?SIT>
		<RTRUE>)
	       (T
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)>>

<ROUTINE V-GO-UP ()
	 <DO-WALK ,P?UP>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You can't climb onto the " D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-FOO ()
	 <COND (<FSET? ,PRSO ,CLIMBBIT>
		<V-CLIMB-UP ,P?UP T>)
	       (T
		<PERFORM ,V?CLIMB-ON ,PRSO>
		<RTRUE>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X)
	 <COND (<GETPT ,HERE .DIR>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<NOT .OBJ>
		<TELL "You can't go that way." CR>)
	       (T
		<TELL "Bizarre!" CR>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<V-CLIMB-ON>
		<RTRUE>)
	       (T
		<V-CLIMB-UP ,P?DOWN>)>>

<ROUTINE PRE-PUT-UNDER ()
	 <COND (<NOT <HELD? ,PRSO>>
		<NOT-HOLDING>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TAKE-IT-OFF>)>>
		
<ROUTINE V-PUT-UNDER ()
	 <TELL "You can't do that." CR>>

<ROUTINE V-ENTER ()
	 <DO-WALK ,P?IN>>

<ROUTINE V-EXIT ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-SEARCH ()
	 <SETG C-ELAPSED 32>
	 <TELL "You find nothing unusual." CR>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <SETG C-ELAPSED 18>
	 <COND (<EQUAL? ,PRSO ,ME ,HANDS>
		<TELL "You're around here somewhere..." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "You find it." CR>)
	       (<IN? ,PRSO ,ADVENTURER>
		<TELL "You have it." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<TELL "It's right here." CR>)
	       (<FSET? .L ,ACTORBIT>
		<TELL "The " D .L " has it." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "It's in the " D .L "." CR>)
	       (ELSE
		<TELL "Beats me." CR>)>>

<ROUTINE V-TELL ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<RFATAL>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL
"The " D, PRSO " looks at you expectantly, as though he thought you were
about to talk." CR>)>)
	       (T
		<TELL "Talking to ">
		<COND (<AND <EQUAL? ,HERE ,DECK-NINE>
			    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		       <TELL "the ">)
		      (T
		       <A-AN>)>
		<TELL
D ,PRSO "? Dr. Quarnsboggle, the Feinstein's psychiatrist, would ">
		<COND (<EQUAL? ,BLOWUP-COUNTER 5>
		       <TELL "have been">)
		      (T
		       <TELL "be">)>
		<TELL " fascinated to hear that." CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-ASK-FOR ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (<IN? ,PRSI ,PRSO>
		      <TELL
"The " D ,PRSO " doesn't seem inclined to give up the " D ,PRSI "." CR>)
		     (T
		      <TELL
"The " D ,PRSO " isn't holding the " D ,PRSI "." CR>)>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<SETG P-CONT <>>
		<TELL "You must address the " D .V " directly." CR>)
	       (T
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<PERFORM ,V?TELL ,ME>)>>

<ROUTINE V-TALK ()
	 <PERFORM ,V?TELL ,PRSO>
	 <RTRUE>>	 

<ROUTINE V-ANSWER ()
	 <TELL "Nobody is awaiting your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that the " D ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-KISS ()
	 <TELL "I'd sooner kiss a pile of Antarian swamp mold." CR>>

<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE V-DIAGNOSE ()
	 <SETG C-ELAPSED 18>
	 <COND (<EQUAL? ,SICKNESS-LEVEL 0>
		<TELL "You are in perfect health." CR>)
	       (T
		<TELL "You are ">
		<COND (<G? ,SICKNESS-LEVEL 7>
		       <TELL "severely">)
		      (<G? ,SICKNESS-LEVEL 5>
		       <TELL "very">)
		      (<G? ,SICKNESS-LEVEL 3>
		       <TELL "somewhat">)
		      (T
		       <TELL "a bit">)>
		<TELL " sick and feverish." CR>)>
	 <COND (<EQUAL? ,SLEEPY-LEVEL 0>
		<TELL "You feel well-rested." CR>)
	       (T
		<TELL "You feel ">
		<COND (<G? ,SLEEPY-LEVEL 2>
		       <TELL "phenomenally">)
		      (<G? ,SLEEPY-LEVEL 1>
		       <TELL "quite">)
		      (T
		       <TELL "sort of">)>
		<TELL " tired." CR>)>
	 <COND (<EQUAL? ,HUNGER-LEVEL 0>
		<TELL "You seem to be well-fed." CR>)
	       (T
		<TELL "You seem to be ">
		<COND (<G? ,HUNGER-LEVEL 4>
		       <TELL "awesomely phenomenally">)
		      (<G? ,HUNGER-LEVEL 2>
		       <TELL "noticeably">)
		      (T
		       <TELL "fairly">)>
		<TELL " thirsty and hungry." CR>)>>

<ROUTINE V-WEAR ()
	 <COND (<FSET? ,PRSO ,WEARBIT> 
		<TELL "You are wearing the " D ,PRSO "." CR>
		<SETG C-ELAPSED 18>
		<FSET ,PRSO ,WORNBIT>)
	       (T
		<TELL
"They're out of fashion, and besides, it wouldn't fit." CR>)>>

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL "You are no longer wearing the " D ,PRSO "." CR>
		<SETG C-ELAPSED 18>
		<FCLEAR ,PRSO ,WORNBIT>)
	       (T
		<TELL "You aren't wearing that." CR>)>>

<ROUTINE V-STEP-ON ()
	 <TELL "That's a silly thing to do." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSO ,MAGNET ,LADDER>
		<PERFORM ,V?ATTRACT ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-NO ()
	 <TELL "You sound rather negative." CR>>

<ROUTINE V-YES ()
	 <TELL "You sound rather positive." CR>>

<ROUTINE V-MAYBE ()
	 <TELL "You sound rather indecisive." CR>>

<ROUTINE V-POINT ()
	 <COND (<IN? ,FLOYD ,HERE>
		<FLOYDS-FAMOUS-DOOR-ROUTINE>)
	       (T
		<TELL "It's usually impolite to point." CR>)>>

<ROUTINE V-SET ()
	 <COND (<NOT ,PRSI>
		<COND (<EQUAL? ,PRSO ,COMBINATION-DIAL ,LASER-DIAL>
		       <TELL
"You must specify a number to set the dial to." CR>)
		      (T
		       <TELL
"Turning the " D ,PRSO " accomplishes nothing." CR>)>)
	       (T
		<TELL "Setting ">
		<A-AN>
		<TELL D ,PRSO " is a strange concept." CR>)>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <EQUAL? ,PRSO ,INTNUM>
		     <EQUAL? ,P-NUMBER 502>>
		<TELL N ,SERIAL CR>)
	       (T
		<TELL "Verifying..." CR>
	 	<COND (<VERIFY>
		       <TELL "Game correct. (YAY!)" CR>)
		      (T
		       <TELL CR "** Game File Failure **" CR>)>)>>

<CONSTANT SERIAL 0>

<ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-$RANDOM ()
	 <COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		<TELL "Illegal call to #RANDOM." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

<ROUTINE V-$RECORD ()
	 <DIROUT ,D-RECORD-ON> ;"all READS and INPUTS get sent to command file"
	 <RTRUE>>

<ROUTINE V-$UNRECORD ()
	 <DIROUT ,D-RECORD-OFF>
	 <RTRUE>>

<ROUTINE V-STAND-ON ()
	 <TELL "Standing on ">
	 <A-AN>
	 <TELL D ,PRSO " seems like a waste of time." CR>>

<ROUTINE V-REACH ()
	 <COND (<FIRST? ,PRSO>
		<TELL "There is something">)
	       (T
		<TELL "There is nothing">)>
	 <TELL " inside the " D ,PRSO "." CR>>

<ROUTINE V-REACH-FOR ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<IN? ,PRSO ,HERE>
		<TELL "It's here! Now what?" CR>)
	       (T
		<TELL "It is out of reach." CR>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>
	 <RTRUE>>

<ROUTINE V-FLUSH ()
	 <TELL "Flush ">
	 <A-AN>
	 <TELL D ,PRSO "?" CR>>

<ROUTINE V-FLY ()
	 <TELL "Humans are not usually equipped for flying." CR>>

<ROUTINE V-SMILE ()
	 <TELL "How pleasant!" CR>>

<ROUTINE V-SALUTE ()
	 <TELL "The " D ,PRSO " fails to return your salute." CR>>

%<COND (<NOT <GASSIGNED? PREDGEN>>
	<ROUTINE V-ESCAPE ()
	         <QUITTER <ASCII 7> ,INCHAN>>)>

<ROUTINE V-ATTRACT ()
	 <TELL "Nothing interesting happens." CR>>

<ROUTINE V-ZATTRACT ()
	 <PERFORM ,V?ATTRACT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SPAN ()
	 <TELL "You can't." CR>>

<ROUTINE NUMBERS-ONLY ()
	 <TELL
"This keyboard only has numeric keys. You can type numbers on it, but
not words." CR>>

<ROUTINE V-TYPE ()
	 <COND (<EQUAL? ,HERE ,MINI-BOOTH>
		<COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		       <NUMBERS-ONLY>)
		      (,MINI-ACTIVATED
		       <COND (<EQUAL? ,P-NUMBER 384>
			      <TELL
"You notice the walls of the booth sliding away in all directions, followed
by a momentary queasiness in the pit of your stomach..." CR CR>
			      <GOTO ,STATION-384>
			      <SETG BEEN-HERE T>)
			     (<L? ,P-NUMBER 10>
			      <TELL
"After a pause a recorded voice says \"There are no one-digit computer
sectors...clearing entry...please type damaged sector number.\"" CR>)
			     (<G? ,P-NUMBER 1024>
			      <TELL 
"A recorded voice says \"Databanks indicate no computer sector corresponding
to that number. Please check with your supervisor.\"" CR>)
			     (T
			      <JIGS-UP
"Ooops! You seem to have transported yourself into an active sector of the
computer. You are fried by powerful electric currents.">)>)
		      (T
		       <TELL
"A recording says \"Internal computer repair booth not activated.\"" CR>)>)
	       (<EQUAL? ,HERE ,LIBRARY-LOBBY>
		<LIBRARY-TYPE>)
	       (T
		<TELL "Type on what???" CR>)>>

<ROUTINE PRE-SZAP ()
	 <PERFORM ,V?ZAP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-ZAP ()
	 <COND (,PRSI
		<RFALSE>)
	       (<EQUAL? ,PRSO ,LASER>
		<RFALSE>)
	       (<IN? ,LASER ,ADVENTURER>
		<PERFORM ,V?ZAP ,LASER ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have nothing to shoot it with." CR>)>>

<ROUTINE V-ZAP ()
	 <COND (<NOT <HELD? ,PRSO>>
		<NOT-HOLDING>)
	       (<NOT <EQUAL? ,PRSO ,LASER>>
		<TELL "You can't shoot that." CR>)
	       (<NOT ,PRSI>
		<TELL "At what?">)
	       (T
		<TELL "Nothing happens." CR>)>>

<ROUTINE V-SZAP ()
	 <TELL "Zap!" CR>> 

<ROUTINE V-SCRUB ()
	 <COND (<AND <NOT ,PRSI>
		     <NOT <IN? ,SCRUB-BRUSH ,ADVENTURER>>
		     <NOT <IN? ,TOWEL ,ADVENTURER>>>
		<TELL "You don't have anything to scrub with!" CR>)
	       (<AND ,PRSI
		     <NOT <EQUAL? ,PRSI ,SCRUB-BRUSH ,TOWEL>>>
		<TELL "You can't scrub something with that!" CR>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "The " D ,PRSO " prefers cleaning himself." CR>)
	       (T
		<TELL "The " D ,PRSO " is a bit shinier now." CR>)>>

<ROUTINE V-POUR ()
	 <TELL "Pouring or spilling non-liquids is specifically forbidden
by section 17.9.2 of the Galactic Adventure Game Compendium of Rules." CR>>

<ROUTINE V-EMPTY ("AUX" X)
	 <COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "You can't empty it when it's closed!" CR>)
	       (<FIRST? ,PRSO>
		       <REPEAT ()
			       <COND (<SET X <FIRST? ,PRSO>>
			              <COND (<EQUAL? .X ,HIGH-PROTEIN
					                ,CHEMICAL-FLUID>
				             <REMOVE .X>)
				            (T
				             <MOVE .X ,HERE>)>)
			             (T
				      <RETURN>)>>
		       <TELL "The " D ,PRSO " is now empty." CR>)
	       (T
		<TELL "There's nothing in the " D ,PRSO "." CR>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "It's difficult to see how that can be done." CR>>

<ROUTINE V-SLEEP ()
	 <COND (<EQUAL? ,SLEEPY-LEVEL 0>
		<TELL "You're not tired!" CR>)
	       (<GET <INT I-FALL-ASLEEP> ,C-ENABLED?>
		<TELL "You'll probably be asleep before you know it." CR>)
	       (T
		<TELL
"Civilized members of society usually sleep in beds." CR>)>>

<ROUTINE V-FIX-IT ()
	 <TELL
"You shouldn't expect sweeping general commands like this to work. If you
want to repair something, you must perform the specific steps required." CR>>

<ROUTINE V-OIL ()
	 <COND (<NOT ,PRSI>
		<COND (<IN? ,OIL-CAN ,ADVENTURER>
		       <PERFORM ,V?OIL ,PRSO ,OIL-CAN>
		       <RTRUE>)
		      (T
		       <TELL "Oil it with what?" CR>)>)
	       (<EQUAL? ,PRSI ,OIL-CAN>
		<COND (<AND <EQUAL? ,PRSO ,FLOYD>
			    <FSET? ,FLOYD ,RLANDBIT>>
		       <TELL "Floyd thanks you for your thoughtfulness." CR>)
		      (T
		       <TELL "The " D, PRSO " doesn't need oiling." CR>)>)
	       (T
		<TELL "You can't use ">
		<COND (<FSET? ,PRSI ,VOWELBIT>
		       <TELL "an ">)
		      (T
		       <TELL "a ">)>
		<TELL D ,PRSI " as an oil can!" CR>)>>

<ROUTINE V-SHOW ()
	 <COND (<NOT <HELD? ,PRSO>>
		<NOT-HOLDING>)
	       (<EQUAL? ,PRSI ,ME>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<TELL "The " D ,PRSI " looks at the " D ,PRSO "." CR>)
	       (T
		<TELL "Why would you want to show something to ">
		<A-AN>
		<TELL D ,PRSO "?" CR>)>>

<ROUTINE V-INSERT ()
	 <COND (<EQUAL? ,HERE ,LIBRARY>
		<TELL "(into the spool reader)" CR>
		<PERFORM ,V?PUT ,PRSO ,SPOOL-READER>
		<RTRUE>)
	       (<EQUAL? ,HERE ,KITCHEN>
		<TELL "(into the niche)" CR>
		<PERFORM ,V?PUT ,PRSO ,DISPENSER>
		<RTRUE>)
	       (T
		<TELL
"You'll have to specify where you want to put the " D ,PRSO "." CR>)>>

<ROUTINE V-TASTE ()
	 <COND (<OR <EQUAL? ,PRSO ,HIGH-PROTEIN ,RED-GOO>
		    <EQUAL? ,PRSO ,BROWN-GOO ,GREEN-GOO>>
		<TELL "It tastes edible." CR>)
	       (<EQUAL? ,PRSO ,CHEMICAL-FLUID>
		<TELL "It burns your tongue." CR>)
	       (T
		<TELL "It tastes just like ">
		<A-AN>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE V-ZESCAPE ()
	 <COND (<EQUAL? ,HERE ,BRIG>
		<TELL "Houdini himself would be stumped by this cell." CR>)
	       (T
		<TELL
"There is no escape. We control the horizontal. We control the vertical.
We control the disk drives..." CR>)>>

<ROUTINE V-TIME ()
	 <COND (<IN? ,CHRONOMETER ,ADVENTURER>
		<TELL-TIME>
		<CRLF>)
	       (T
		<TELL
"It's hard to say, since you've removed your chronometer." CR>)>>

<ROUTINE V-PLAY ()
	 <TELL "How does one play ">
	 <A-AN>
         <TELL D ,PRSO "?" CR>>

<ROUTINE V-PLAY-WITH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?PLAY ,GLOBAL-GAMES>
		<RTRUE>)
	       (T
		<TELL "I sometimes wonder about your mental health." CR>)>>

<ROUTINE V-SCOLD ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"For some reason, the " D, PRSO " doesn't seem too chagrined." CR>)>>

<ROUTINE ROB (WHO WHERE "AUX" N X)
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RTRUE>)
		       (T
			<SET N <NEXT? .X>>
			<MOVE .X .WHERE>
			<SET X .N>)>>>

;<ROUTINE V-CRAG ()
	 <DISABLE <INT I-BLATHER>>
	 <DISABLE <INT I-AMBASSADOR>>
	 <DISABLE <INT I-BLOWUP-FEINSTEIN>>
	 <MOVE ,FOOD-KIT ,ADVENTURER>
	 <MOVE ,TOWEL ,ADVENTURER>
	 <SETG C-ELAPSED 1000>
	 <SETG BLOWUP-COUNTER 5>
	 <SETG TRIP-COUNTER 15>
	 <TELL "What a wimp!" CR CR>
	 <GOTO ,CRAG>>

;<ROUTINE V-FORK ()
	 <TELL "Is this trip really necesary?" CR>
	 <GOTO ,FORK>>

;<ROUTINE V-BOOTH ()
	 <TELL "Yeah, okay..." CR>
	 <GOTO ,BOOTH-2>>

;<ROUTINE V-CARDS ()
	 <TELL "You want 'em, you got 'em..." CR>
	 <MOVE ,LOWER-ELEVATOR-CARD ,ADVENTURER>
	 <MOVE ,UPPER-ELEVATOR-CARD ,ADVENTURER>
	 <MOVE ,SHUTTLE-CARD ,ADVENTURER>
	 <MOVE ,KITCHEN-CARD ,ADVENTURER>
	 <MOVE ,TELEPORTATION-CARD ,ADVENTURER>>
	 
;<ROUTINE V-FIX ()
	 <SETG COMM-FIXED T>
	 <SETG STEPS-TO-GO 0>
	 <SETG CHEMICAL-REQUIRED 10>
	 <SETG DEFENSE-FIXED T>
	 <REMOVE ,GOOD-BOARD>
	 <SETG COURSE-CONTROL-FIXED T>
	 <TELL
"Mother-stabbing father-raping mega-wimp!!!" CR>>


;"useful utility routines"

<GLOBAL YUKS
	<PLTABLE
	 "Fat chance."
	 "A valiant attempt."
	 "You can't be serious."
	 "Not bloody likely."
	 "An interesting idea..."
	 "What a concept!">>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 <SETG P-IT-LOC ,HERE>>

<ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player TOUCH object?"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)	       
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player SEE object"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE A-AN ()
	 <COND (<FSET? ,PRSO ,VOWELBIT>
		<TELL "an ">)
	       (T
		<TELL "a ">)>>

<ROUTINE ALREADY (ON-OFF "OPTIONAL" (OBJ <>))
	 <COND (.OBJ
		<TELL "The " D .OBJ " is ">)
	       (T
		<TELL "It's ">)>
	 <TELL "already " .ON-OFF "." CR>>

<ROUTINE NOT-HOLDING ()
	 <TELL "You're not holding the " D ,PRSO "." CR>>

<ROUTINE TAKE-IT-OFF ()
	 <TELL "You'll have to take it off, first." CR>>

<ROUTINE ANYMORE ()
	 <TELL "You can't see that anymore." CR>>

<ROUTINE FIXED-FONT-ON () ;"turns on fixed spacing for the Macintosh"
	 <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF () ;"turns off fixed spacing for the Macintosh"
	 <PUT 0 8 <BAND <GET 0 8> -3>>>