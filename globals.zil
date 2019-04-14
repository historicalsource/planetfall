"GLOBALS for PLANETFALL
(C) COPYRIGHT 1983 INFOCOM INC. ALL RIGHTS RESERVED

This file contains Global Objects and their associated routines,
as well as all routines associated with BOTH complexes. It also
contains the opening sequence which occurs prior to planetfall."

<CONSTANT DEFAULT-MOVE 20>

;"REM OFFSETS 31  30  29  28   27  26  25  24 23  22  21  20  ,LOW-DIRECTION "
<DIRECTIONS NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

"SUBTITLE GLOBAL OBJECTS"

<GLOBAL LOAD-ALLOWED 100>

<OBJECT GLOBAL-OBJECTS
	(FLAGS INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT MUNGBIT MUNGEDBIT
	       SCRAMBLEDBIT WORNBIT OPENBIT SEARCHBIT TRANSBIT WEARBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK)
	(VALUE 0)
	(CONTFCN 0)
	(DESCFCN 0)
	(SIZE 0)
	(PSEUDO "FOO")>

;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

<OBJECT ROOMS>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(DESC "number")>

<OBJECT PSEUDO-OBJECT
	(DESC "pseudo")
	(ACTION GO)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THAT THIS HIM)
	(DESC "random object")
	(FLAGS NDESCBIT)>

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(SYNONYM STAIRS STEPS GANGWAY STAIRWAY)
	(DESC "stairway")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM GROUND EARTH FLOOR DECK)
	(DESC "floor")
	(FLAGS NDESCBIT)
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,GROUND>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? CLIMB-ON BOARD>
		<SETG C-ELAPSED 28>
		<TELL
"You sit down on the floor. After a brief rest, you stand again." CR>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,ADMIN-CORRIDOR-S>>
		<TELL "A narrow, jagged crevice runs across the floor." CR>)>>

<OBJECT WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW PORT VIEWPORT)
	(ADJECTIVE VIEW)
	(FLAGS NDESCBIT)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,BIO-LOCK-EAST>
		       <TELL
"You can see a large laboratory, dimly illuminated. A blue glow comes from
a crack in the northern wall of the lab. Shadowy, ominous shapes move about
within the room.">
		       <COND (<NOT <FSET? ,MINI-CARD ,TOUCHBIT>>
			      <TELL
" On the floor, just inside the door, you can see a magnetic-striped card.">)>
		       <CRLF>)
		      (<EQUAL? ,HERE ,BIO-LAB>
		       <TELL "You see the Bio Lock." CR>)
		      (<OR
			<EQUAL? ,HERE ,ALFIE-CONTROL-EAST ,ALFIE-CONTROL-WEST>
		        <EQUAL? ,HERE ,BETTY-CONTROL-EAST ,BETTY-CONTROL-WEST>>
		       <TELL "You see ">
		       <DESCRIBE-VIEW>
		       <TELL CR>)
	              (<EQUAL? ,HERE ,BALCONY>
		       <TELL "Water. Lots and lots of water." CR>)
		      (<EQUAL? ,HERE ,HELICOPTER>
		       <TELL "You see the helipad and the ocean beyond." CR>)
		      (<EQUAL? ,HERE ,ESCAPE-POD>
		       <COND (<L? ,TRIP-COUNTER 2>
			      <TELL
"You can see debris from the exploding Feinstein." CR>)
		             (<G? ,TRIP-COUNTER 8>
		              <TELL
"You can see a planet, hopefully a hospitable one." CR>)
		             (T
		              <TELL
"The window has polarized to blackness." CR>)>)
		      (<EQUAL? ,HERE ,LARGE-OFFICE>
		       <TELL
"You can see the dormitories and other parts of the
complex in the distance. Water is visible in every direction." CR>)>)
	       (<AND <VERB? THROUGH>
		     <EQUAL? ,HERE ,BALCONY>>
		<JIGS-UP
"You slice yourself to ribbons on the broken windows and then plummet
into the swirling ocean below. Very clever.">)
	       (<VERB? OPEN>
		<TELL "This window doesn't open." CR>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,BALCONY>>
		<TELL "They're shattered." CR>)
	       (<VERB? MUNG>
		<COND (<EQUAL? ,HERE ,BALCONY>
		       <TELL "They're already broken." CR>)
		      (T
		       <TELL "It's made of tough Zynoid plastic." CR>)>)>>

<OBJECT CLIFF
	(IN LOCAL-GLOBALS)
	(DESC "cliff")
	(SYNONYM CLIFF)
	(FLAGS NDESCBIT)
	(ACTION CLIFF-F)>

<ROUTINE CLIFF-F ()
	 <COND (<EQUAL? ,HERE ,WEST-WING>
		<COND (<VERB? LEAP>
		       <JIGS-UP "Brilliant idea!">)
		      (<VERB? THROW-OFF>
		       <COND (<EQUAL? ,PRSO ,LASER>
			      <DISABLE <INT I-WARMTH>>)>
		       <REMOVE ,PRSO>
		       <TELL
"The " D ,PRSO " falls into the ocean below." CR>)>)
	       (T
		<COND (<VERB? CLIMB-UP CLIMB-FOO>
		       <DO-WALK ,P?UP>)
		      (<VERB? CLIMB-DOWN>
		       <DO-WALK ,P?DOWN>)>)>>

<OBJECT OCEAN
	(IN LOCAL-GLOBALS)
	(DESC "ocean")
	(SYNONYM OCEAN)
	(ADJECTIVE ENDLESS)
	(FLAGS VOWELBIT NDESCBIT)
	(ACTION OCEAN-F)>

<ROUTINE OCEAN-F ()
	 <COND (<VERB? TAKE THROUGH RUB>
		<TELL "You can't reach the ocean from here." CR>)
	       (<VERB? EXAMINE>
		<TELL "It stretches as far as you can see." CR>)>>

<OBJECT TABLES
	(IN LOCAL-GLOBALS)
	(DESC "table")
	(SYNONYM TABLE TABLES)
	(FLAGS NDESCBIT)
	(ADJECTIVE ROUND CONFERENCE SMALL WIDE LONG)
	(ACTION TABLES-F)>

<ROUTINE TABLES-F ()
	 <COND (<AND <VERB? LOOK-UNDER>
		     <EQUAL? ,HERE ,MESS-HALL>>
		<TELL
"Wow!!! Under the table are three keys, a sack of food, a reactor elevator
access pass, one hundred gold pieces ... Just kidding. Actually, there's
nothing there." CR>)
	       (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSI ,TABLES>>
		<TELL
"That would accomplish nothing useful." CR>)>> 

<OBJECT SHELVES
	(IN LOCAL-GLOBALS)
	(SYNONYM SHELF SHELVES)
	(DESC "shelf")
	(FLAGS NDESCBIT)
	(ACTION SHELVES-F)>

<ROUTINE SHELVES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The shelves are pretty dusty." CR>)
	       (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSI ,SHELVES>>
		<TELL "That would be a waste of time." CR>)>>

<OBJECT LIGHTS
	(IN LOCAL-GLOBALS)
	(SYNONYM LIGHT LIGHTS)
	(ADJECTIVE RED DAZZLI GLOWIN BLINKI WARNIN BRIGHT COLORE FLASHI)
	(DESC "light")
	(FLAGS NDESCBIT)
	(ACTION LIGHTS-F)>

<ROUTINE LIGHTS-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,COMPUTER-ROOM>>
		<TELL
"The red light would seem to indicate a malfunction in the computer." CR>)>>

<OBJECT GLOBAL-DOORWAY
	(IN GLOBAL-OBJECTS)
	(SYNONYM DOORWA PORTAL OPENIN)
	(ADJECTIVE NORTH SOUTH EAST WEST NE SE NW SW)
	(DESC "doorway")
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-DOORWAY-F)>

<ROUTINE GLOBAL-DOORWAY-F ()
	 <COND (<VERB? THROUGH>
		<USE-DIRECTIONS>)
	       (<VERB? OPEN CLOSE>
		<TELL "It's just an opening; you can't open or close it." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Can't see much from here. Try going there." CR>)>>

<ROUTINE USE-DIRECTIONS ()
	 <TELL "Use compass directions for movement." CR>>

<ROUTINE NO-CLOSE ()
	 <TELL "There's no way to close it." CR>>

<OBJECT CONTROLS
	(IN LOCAL-GLOBALS)
	(SYNONYM CONTRO PANEL DIALS GAUGES)
	(ADJECTIVE CONTRO COMPLEX)
	(DESC "set of controls")
	(FLAGS NDESCBIT)
	(ACTION CONTROLS-F)>

<ROUTINE CONTROLS-F ()
	<COND (<OR <EQUAL? ,HERE ,UPPER-ELEVATOR ,LOWER-ELEVATOR ,BOOTH-1>
		   <EQUAL? ,HERE ,REACTOR-ELEVATOR ,BOOTH-2 ,BOOTH-3>>
	       <COND (<VERB? EXAMINE>
		      <TELL
"The control panel is a simple one, as described. Just a small slot
and two buttons." CR>)>)
	      (<VERB? RUB MOVE TURN SET TAKE EXAMINE PUSH PULL>
	       <COND (<EQUAL? ,HERE ,HELICOPTER>
		      <TELL
"The controls are covered and locked." CR>)
		     (<EQUAL? ,HERE ,ESCAPE-POD>
		      <TELL
"The controls are entirely automated." CR>)
		     (T
		      <TELL
"The controls are incredibly complicated and you shouldn't even
be thinking about touching them." CR>)>)
	      (<AND <EQUAL? ,HERE ,HELICOPTER>
		    <VERB? OPEN UNLOCK>>
	       <TELL
"You don't even have the orange key!" CR>)>>

<OBJECT GLOBAL-GAMES
	(IN GLOBAL-OBJECTS)
	(DESC "game")
	(SYNONYM BOCCI CHESS HIDER- HUCKA-)
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-GAMES-F)>

<ROUTINE GLOBAL-GAMES-F ()
	 <COND (<VERB? PLAY>
		<COND (<IN? ,FLOYD ,HERE>
		       <PERFORM ,V?PLAY-WITH ,FLOYD>
		       <RTRUE>)
		      (T
		       <TELL "Okay. Gee, that was fun." CR>)>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM PAIR HANDS)
	(ADJECTIVE BARE)
	(DESC "pair of hands")
	(FLAGS NDESCBIT)
	(ACTION HANDS-F)>

<ROUTINE HANDS-F ()
	 <COND (<VERB? SHAKE>
		<COND (<IN? ,AMBASSADOR ,HERE>
		       <TELL "A repulsive idea." CR>)
		      (<IN? ,BLATHER ,HERE>
		       <TELL "Saluting might be a better idea." CR>)
		      (<AND <IN? ,FLOYD ,HERE>
			    <FSET? ,FLOYD ,RLANDBIT>>
		       <TELL
"You shake one of Floyd's grasping extensions." CR>)
		      (T
		       <TELL "There's no one to shake hands with." CR>)>)>>

<OBJECT SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sacred act of sleeping")
	(SYNONYM SLEEP)
	(FLAGS NDESCBIT)
	(ACTION SLEEP-F)>

<ROUTINE SLEEP-F ()
	 <COND (<VERB? WALK-TO>
		<V-SLEEP>)>>

<OBJECT ADVENTURER
	(IN DECK-NINE)
	(SYNONYM ADMIRA SMITHE SPAM EGGS)
	(ADJECTIVE ORANGE OPENER)
	(DESC "player")
        (FLAGS NDESCBIT INVISIBLE)>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF SELF WE)
	(DESC "you")
	(FLAGS ACTORBIT)
	(ACTION CRETIN-F)>

<ROUTINE CRETIN-F ()
	 <COND (<VERB? GIVE>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<VERB? SCRUB>
		<TELL
"If only you'd done that before the last inspection, you wouldn't have
gotten 300 demerits." CR>)
	       (<VERB? DROP>
		<TELL "Huh?" CR>)
	       (<VERB? SMELL>
		<TELL "Phew!" CR>)
	       (<VERB? FOLLOW>
		<TELL "It would be hard not to." CR>)
	       (<VERB? EAT>
		<TELL "Auto-cannibalism is not the answer." CR>)
	       (<VERB? ATTACK MUNG>
		<COND (<==? ,PRSO ,ME>
		       <JIGS-UP "If you insist.... Poof, you're dead!">)
		      (ELSE <TELL "What a silly idea!" CR>)>)
	       (<VERB? TAKE>
		<TELL "How romantic!" CR>)
	       (<VERB? DISEMBARK>
		<TELL "You'll have to do that on your own." CR>)
	       (<VERB? EXAMINE>
		<TELL "That's difficult unless your eyes are prehensile."
		      CR>)>>

;<GLOBAL DUMMY
	<PLTABLE "Look around."
		"You think it isn't?"
		"I think you've already done that.">>

<ROUTINE DDESC (DOOR)
	 <COND (<FSET? .DOOR ,OPENBIT>
		<TELL "open">)
	       (T
		<TELL "closed">)>>

<ROUTINE ALREADY-OPEN ()
	 <TELL "It's already open!" CR>>

<ROUTINE IS-CLOSED ()
	 <TELL "It is closed!" CR>>

<ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)
	<COND (<AND <NOT .OBJ> <FSET? ,PRSO ,VEHBIT>>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<AND <NOT .OBJ> <NOT <FSET? ,PRSO ,TAKEBIT>>>
	       <TELL
"You hit your head against the " D ,PRSO " as you attempt this feat." CR>)
	      (.OBJ
	       <TELL "You can't do that!" CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

;<ROUTINE ROOM? (OBJ "AUX" NOBJ)
	 <REPEAT ()
		 <SET NOBJ <LOC .OBJ>>
		 <COND (<NOT .NOBJ> <RFALSE>)
		       (<==? .NOBJ ,WINNER> <RFALSE>)
		       (<==? .NOBJ ,ROOMS> <RETURN .OBJ>)>
		 <SET OBJ .NOBJ>>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W> <RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT> <RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RETURN <>>)>>>

;<ROUTINE FIND-ROOM (X)
	 <REPEAT ()
		 <COND (<NOT .X> ;"this can't happen, of course"
			<RETURN ,ROOMS>)
		       (<IN? .X ,ROOMS> <RETURN .X>)>
		 <SET X <LOC .X>>>>

;"Stuff added for the NOT-HERE object"

<OBJECT NOT-HERE-OBJECT
	(DESC "such thing" ;"[not here]")
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)
	;"Protocol: return T if case was handled and msg TELLed,
			  <> if PRSO/PRSI ready to use"
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (.PRSO?
		<COND (<VERB? TYPE>
		       <PERFORM ,V?TYPE ,FLOYD>
		       <RTRUE>)
		      (<OR <VERB? EXAMINE>
			   <AND <EQUAL? ,WINNER ,FLOYD>
				<VERB? TAKE FIND>>>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)>
	 ;"Here is the default 'cant see any' printer"
	 <COND (<EQUAL? ,WINNER ,ADVENTURER>
		<TELL "You can't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!" CR>
		<COND (<VERB? TELL>
		       <SETG P-CONT <>>
		       <SETG QUOTE-FLAG <>>
		       <RFATAL>)>)
	       (T
		<TELL "The " D ,WINNER " seems confused. \"I don't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <RTRUE>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	;"Protocol: return T if case was handled and msg TELLed,
	    ,NOT-HERE-OBJECT if 'can't see' msg TELLed,
			  <> if PRSO/PRSI ready to use"
	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
	   the 0 and >1 cases alike or different. It doesn't matter. Always
	   return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	;<COND (<AND <G? .M-F 1>
		    <SET OBJ <GETP <1 .TBL> ,P?GLOBAL>>>
	       <SET M-F 1>
	       <SETG P-MOBY-FOUND .OBJ>)>
	<COND (<==? 1 .M-F>
	       <COND (.PRSO? <SETG PRSO ,P-MOBY-FOUND>)
		     (T <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<NOT .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
 <COND (<OR ,P-OFLAG ,P-MERGED>
	<COND (,P-XADJ <TELL " "> <PRINTB ,P-XADJN>)>
	<COND (,P-XNAM <TELL " "> <PRINTB ,P-XNAM>)>)
       (.PRSO?
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
       (T
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

^L

;"Begin-game stuff aboard the Feinstein"

<ROOM BRIG
      (IN ROOMS)
      (DESC "Brig")
      (LDESC
"You are in the Feinstein's brig. Graffiti cover
the walls. The cell door to the south is locked.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH "The cell door is locked.")
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "GRAFFITI" GRAFFITI-PSEUDO "DOOR" DOOR-PSEUDO)>

<ROOM DECK-NINE
      (IN ROOMS)
      (DESC "Deck Nine")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST"15 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST"15 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO REACTOR-LOBBY IF CORRIDOR-DOOR IS OPEN)
      (WEST TO ESCAPE-POD IF POD-DOOR IS OPEN)
      (IN TO ESCAPE-POD IF POD-DOOR IS OPEN)
      (UP TO GANGWAY IF GANGWAY-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL POD-DOOR CORRIDOR-DOOR GANGWAY-DOOR STAIRS GLOBAL-POD)
      (PSEUDO "TRANSL" TRANSLATOR-PSEUDO "SLIME" SLIME-PSEUDO)
      (ACTION DECK-NINE-F)>

<ROUTINE DECK-NINE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a featureless corridor similar to every other corridor on the ship.
It curves away to starboard, and a gangway leads up">
		<COND (<FSET? ,GANGWAY-DOOR ,OPENBIT>
		       <TELL ".">)
		      (T
		       <TELL
", but both of these are blocked by closed bulkheads.">)>
		<TELL
" To port is the entrance to one of the ship's primary escape pods. The
pod bulkhead is ">
		<DDESC ,POD-DOOR>
		<TELL "." CR>)>>

<OBJECT SCRUB-BRUSH
	(IN ADVENTURER)
	(DESC "Patrol-issue self-contained multi-purpose scrub brush")
	(SYNONYM BRUSH SCRUBB SCRUBR)
	(ADJECTIVE SCRUB PATROL SELF-CONTAINED MULTI)
	(FLAGS TAKEBIT)
	(SIZE 10)>

<OBJECT CHRONOMETER
	(IN ADVENTURER)
	(DESC "chronometer")
	(SYNONYM CHRONOMETER WRISTWATCH WATCH)
	(ADJECTIVE WRIST)
	(SIZE 10)
	(FLAGS MUNGBIT TAKEBIT WEARBIT WORNBIT)
	(ACTION CHRONOMETER-F)>

<ROUTINE CHRONOMETER-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"It is a standard wrist chronometer with a digital display. ">
		<TELL-TIME>
		<TELL " The back is engraved with
the message \"Good luck in the Patrol! Love, Mom and Dad.\"" CR>)>>

<ROUTINE TELL-TIME ()
	 <TELL "According to the chronometer, the current time is ">
	 <COND (<FSET? ,CHRONOMETER ,MUNGEDBIT>
		<TELL N ,MUNGED-TIME>)
	       (T
		<TELL N ,INTERNAL-MOVES>)>
	 <TELL ".">>

<GLOBAL MUNGED-TIME 0>

<OBJECT ID-CARD
	(IN PATROL-UNIFORM)
	(DESC "ID card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PATROL ID IDENTIFICATION)
	(FLAGS VOWELBIT TAKEBIT READBIT)
	(SIZE 3)
	(TEXT
"\"STELLAR PATROL|
Special Assignment Task Force|
ID Number:  6172-531-541\"")>  

<OBJECT PATROL-UNIFORM
	(IN ADVENTURER)
	(DESC "Patrol uniform")
	(LDESC
"A slightly wrinkled Patrol uniform is lying here.")
	(SYNONYM UNIFORM POCKET SUIT)
	(ADJECTIVE PATROL WRINKLED)
        (FLAGS TAKEBIT WORNBIT WEARBIT CONTBIT SEARCHBIT OPENBIT)
	(CAPACITY 10)
	(ACTION PATROL-UNIFORM-F)>

<ROUTINE PATROL-UNIFORM-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is a standard-issue one-pocket Stellar Patrol uniform, a miracle of modern
technology. It will keep its owner warm in cold climates and cool in warm
locales. It provides protection against mild radiation, repels all insects,
absorbs sweat, promotes healthy skin tone, and on top of everything else,
it is super-comfy.">
		<COND (<EQUAL? ,TRIP-COUNTER 15>
		       <TELL
" There are definitely worse things to find yourself wearing when stranded
on a strange planet.">)>
		<TELL CR>)
	       (<AND <VERB? WEAR>
		     <FSET? ,LAB-UNIFORM ,WORNBIT>>
		<TELL
"It won't fit over the lab uniform." CR>)
	       (<AND <VERB? TAKE-OFF>
		     <FSET? ,PATROL-UNIFORM ,WORNBIT>>
		<FCLEAR ,PATROL-UNIFORM ,WORNBIT>
		<TELL "You have removed your Patrol uniform.">
		<COND (<EQUAL? ,TRIP-COUNTER 15>
		       <TELL
" You suddenly realize how warm it is. You also feel naked and vulnerable.">)>
		<COND (<IN? ,BLATHER ,HERE>
		       <TELL
" \"Removing your uniform while on duty? Five hundred demerits!\"">)
		      (<IN? ,FLOYD ,HERE>
		       <TELL
" Floyd giggles. \"You look funny without any clothes on.\"">)>
		<TELL CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"There's no way to open or close the pocket of the " D ,PRSO "." CR>)>>

<ROOM REACTOR-LOBBY
      (IN ROOMS)
      (DESC "Reactor Lobby")
      (LDESC
"The corridor widens here as it nears the main drive area. To starboard is
the Ion Reactor that powers the vessel, and aft of here is the Auxiliary
Control Room. The corridor continues to port.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST"15 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO DECK-NINE IF CORRIDOR-DOOR IS OPEN)
      (SOUTH "Ensign Blather pushes you roughly back toward your post.")
      (EAST "Ensign Blather blocks your way, snarling angrily.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CORRIDOR-DOOR)>

<ROOM GANGWAY
      (IN ROOMS)
      (DESC "Gangway")
      (LDESC
"This is a steep metal gangway connecting Deck Eight, above, and Deck
Nine, below.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN"10  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (UP TO DECK-EIGHT)
      (DOWN TO DECK-NINE IF GANGWAY-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GANGWAY-DOOR STAIRS)
      (ACTION GANGWAY-F)>

<ROUTINE GANGWAY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <PROB 15>
			    <EQUAL? ,BLOWUP-COUNTER 0>>
		       <TELL
"You hear a distant bellowing ... something about an Ensign Seventh Class
whose life is in danger." CR>)>)>>

<ROOM DECK-EIGHT
      (IN ROOMS)
      (DESC "Deck Eight")
      (LDESC
"This is a featureless corridor leading port and starboard. A gangway leads
down, and to fore is the Hyperspatial Jump Machinery Room.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN"10  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (DOWN TO GANGWAY)
      (EAST "Blather throws you to the deck and makes you do 20 push-ups.")
      (WEST "Blather throws you to the deck and makes you do 20 push-ups.")
      (NORTH "Blather blocks your path, growling about extra galley duty.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STAIRS)>

;<OBJECT MEASLE
	(DESC "Lt. Measle")
	(LDESC
"The Feinstein's record officer, Lieutenant Measle, is here.")
	(SYNONYM MEASLE OFFICER)
	(ADJECTIVE LT LIEUTENANT RECORD)
	(FLAGS ACTORBIT)
	(ACTION MEASLE-F)>

;<ROUTINE MEASLE-F ()
	 <COND (<VERB? ATTACK KICK>
		<TELL "Lt. Measle summons Ensign Blather, who throws
you in the brig." CR>
		<GOTO ,BRIG>)>> 

<GLOBAL BLATHER-LEAVE 0>

<GLOBAL BRIGS-UP 0>

<ROUTINE I-BLATHER ()
	 <COND (<EQUAL? ,HERE ,DECK-EIGHT ,REACTOR-LOBBY>
		<COND (<IN? ,BLATHER ,HERE>
		       <SETG BRIGS-UP <+ ,BRIGS-UP 1>>
		       <COND (<G? ,BRIGS-UP 3>
			      <TELL CR
"Blather loses his last vestige of patience and drags you to the Feinstein's
brig. He throws you in, and the door clangs shut behind you." CR CR>
			      <GOTO ,BRIG>
			      <ROB ,ADVENTURER ,CRAG>
			      <MOVE ,PADLOCK ,HERE>
			      <FCLEAR ,PADLOCK ,TAKEBIT>)
			     (T
			      <TELL CR
"\"I said to return to your post, Ensign Seventh Class!\" bellows Blather,
turning a deepening shade of crimson." CR>)>)
		      (<EQUAL? ,BLOWUP-COUNTER 0>
		       <MOVE ,BLATHER ,HERE>
		       <THIS-IS-IT ,BLATHER>
		       <TELL CR
"Ensign Blather, his uniform immaculate, enters and notices you are away
from your post. \"Twenty demerits, Ensign Seventh Class!\" bellows Blather.
\"Forty if you're not back on Deck Nine in five seconds!\" He curls his face
into a hideous mask of disgust at your unbelievable negligence." CR>)>) 
	       (<EQUAL? ,HERE ,DECK-NINE>
		<COND (<AND <EQUAL? ,BLATHER-LEAVE 3>
			    <IN? ,BLATHER ,HERE>>
		       <SETG BLATHER-LEAVE 0>
		       <REMOVE ,BLATHER>
		       <TELL CR
"Blather, adding fifty more demerits for good measure, moves off in search
of more young ensigns to terrorize." CR>)
		      (<IN? ,BLATHER ,DECK-NINE>
		       <SETG BLATHER-LEAVE <+ ,BLATHER-LEAVE 1>>
		       <RFALSE>)
		      (<AND <NOT <IN? ,AMBASSADOR ,HERE>>
			    <EQUAL? ,BLOWUP-COUNTER 0>
			    <PROB 5>>
		       <MOVE ,BLATHER ,HERE>
		       <THIS-IS-IT ,BLATHER>
		       <TELL CR
"Ensign First Class Blather swaggers in. He studies your work with half-closed
eyes. \"You call this polishing, Ensign Seventh Class?\" he sneers. \"We have
a position for an Ensign Ninth Class in the toilet-scrubbing division,
you know. Thirty demerits.">
		       <COND (<NOT <FSET? ,PATROL-UNIFORM ,WORNBIT>>
			      <TELL
" And another sixty for improper dress!">)>
		       <TELL
"\" He glares at you, his arms crossed." CR>)>)>>

<OBJECT BLATHER
	(DESC "Ensign First Class")
	(LDESC 
"Ensign First Class Blather is standing before you, furiously scribbling
demerits onto an oversized clipboard.")
	(SYNONYM ENSIGN BLATHER)
	(ADJECTIVE ENSIGN FIRST CLASS)
	(SIZE 150)
	(FLAGS VOWELBIT ACTORBIT)
	(ACTION BLATHER-F)>

<ROUTINE BLATHER-F ()
	 <COND (<VERB? TALK TELL HELLO>		
		<TELL
"Blather shouts \"Speak when you're spoken to, Ensign Seventh Class!\" He
breaks three pencil points in a frenzied rush to give you more demerits." CR>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<RFATAL>)
	       (<VERB? ATTACK KICK>
		<JIGS-UP
"Blather removes several of your appendages and internal organs.">)
	       (<VERB? SALUTE>
		<TELL
"Blather's sneer softens a bit. \"First right thing you've done today. Only
five demerits.\"" CR>)
	       (<AND <VERB? THROW>
		     <EQUAL? ,BLATHER ,PRSI>>
		<MOVE ,PRSO ,HERE>
		<TELL
"The " D ,PRSO " bounces off Blather's bulbous nose. He becomes livid, orders
you to do five hundred push-ups, gives you ten thousand demerits, and assigns
you five years of extra galley duty." CR>)
	       (<VERB? EXAMINE>
		<TELL
"Ensign Blather is a tall, beefy officer with a tremendous, misshapen nose.
His uniform is perfect in every respect, and the crease in his trousers
could probably slice diamonds in half." CR>)
	       (<VERB? TAKE>
		<TELL
"Blather brushes you away, muttering about suspended shore leave." CR>)>>

<OBJECT AMBASSADOR
	(DESC "alien ambassador")
	(LDESC 
"A high-ranking ambassador from a newly-contacted alien race is standing
here on three of his legs, and watching you with seven of his eyes.")
	(SYNONYM AMBASSADOR)
	(ADJECTIVE VERY IMPORTANT ALIEN HIGH-RANKING HIGH RANKING)
	(SIZE 150)
	(FLAGS VOWELBIT ACTORBIT)
	(ACTION AMBASSADOR-F)>

<OBJECT CELERY
	(DESC "piece of celery")
	(SYNONYM CELERY PIECE STALK)
	(FLAGS NDESCBIT FOODBIT)
	(ACTION CELERY-F)>

<ROUTINE CELERY-F ()
	 <COND (<VERB? EAT>
		<JIGS-UP
"Oops. Looks like Blow'k-Bibben-Gordoan metabolism is not
compatible with our own. You die of all sorts of convulsions.">)
	       (<VERB? TAKE>
		<TELL
"The ambassador seems perturbed by your lack of normal protocol." CR>)>>

<GLOBAL AMBASSADOR-LEAVE 0>

<ROUTINE I-AMBASSADOR ()
	 <COND (<AND <G? ,AMBASSADOR-LEAVE 2>
		     <IN? ,AMBASSADOR ,HERE>>
		<REMOVE ,AMBASSADOR>
		<REMOVE ,CELERY>
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <TELL CR
"The ambassador grunts a polite farewell, and disappears up the gangway,
leaving a trail of dripping slime." CR>)>
		<DISABLE <INT I-AMBASSADOR>>)
	       (<IN? ,AMBASSADOR ,DECK-NINE>
		<SETG AMBASSADOR-LEAVE <+ ,AMBASSADOR-LEAVE 1>>
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <TELL CR "The ambassador ">
		       <TELL <PICK-ONE ,AMBASSADOR-QUOTES> CR>)
		      (T
			<RFALSE>)>)
	       (<EQUAL? ,HERE ,DECK-NINE>
		<COND (<AND <NOT <IN? ,AMBASSADOR ,HERE>>
			    <NOT <IN? ,BLATHER ,HERE>>
			    <EQUAL? ,BLOWUP-COUNTER 0>
			    <PROB 15>>
		       <MOVE ,AMBASSADOR ,HERE>
		       <MOVE ,CELERY ,HERE>
		       <THIS-IS-IT ,AMBASSADOR>
		       <MOVE ,BROCHURE ,ADVENTURER>
		       <TELL CR
"The alien ambassador from the planet Blow'k-bibben-Gordo ambles toward you
from down the corridor. He is munching on something resembling an enormous
stalk of celery, and he leaves a trail of green slime on the deck. He stops
nearby, and you wince as a pool of slime begins forming beneath him on your
newly-polished deck. The ambassador wheezes loudly and hands you a brochure
outlining his planet's major exports."CR>)>)>>

<OBJECT BROCHURE
	(DESC "brochure")
	(LDESC
"Unfortunately, one of those stupid Blow'k-bibben-Gordo brochures is here.")
	(SYNONYM BROCHURE PAMPHLET LEAFLET)
	(FLAGS ACIDBIT TAKEBIT READBIT)
	(SIZE 4)
	(TEXT
"\"The leading export of Blow'k-bibben-Gordo is the adventure game|
|
          *** PLANETFALL ***|
|
written by S. Eric Meretzky.|
Buy one today. Better yet, buy a thousand.\"")>

<GLOBAL AMBASSADOR-QUOTES
	<PLTABLE
	 "introduces himself as Br'gun-te'elkner-ipg'nun."
	 "asks if you are performing some sort of religious ceremony."
	 "inquires whether you are interested in a game of Bocci."	
	 "recites a plea for coexistence between your races."
	 "asks where Admiral Smithers can be found."
	 "remarks that all humans look alike to him."
	 "offers you a bit of celery.">>

<ROUTINE AMBASSADOR-F ()
	 <COND (<VERB? TALK TELL HELLO>
		<TELL
"The ambassador taps his translator, and then touches his center knee to his
left ear (the Blow'k-bibben-Gordoan equivalent of shrugging)." CR>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<RFATAL>)
	       (<AND <VERB? ASK-FOR>
		     <EQUAL? ,PRSI ,CELERY>>
		<TELL
"The ambassador seems willing to let you eat some of it, but I doubt he wants
to part with the entire stalk." CR>)
	       (<VERB? ATTACK KICK>
		<TELL
"The ambassador is startled, and emits an amazing quantity of slime which
spreads across the section of the deck you just polished." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The ambassador has around twenty eyes, seven of which are currently
open. Half of his six legs are retracted. Green slime oozes from
multiple orifices in his scaly skin. He speaks through a mechanical
translator slung around his neck." CR>)
	       (<VERB? LISTEN>
		<TELL
"The alien makes a wheezing noise as he breathes." CR>)>>

<ROOM ESCAPE-POD
      (IN ROOMS)
      (DESC "Escape Pod")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST PER POD-EXIT-F)
      (OUT PER POD-EXIT-F)
      (UP PER POD-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (VALUE 3)
      (GLOBAL POD-DOOR CONTROLS LIGHTS GLOBAL-POD WINDOW)
      (ACTION ESCAPE-POD-F)>

<OBJECT GLOBAL-POD
	(IN LOCAL-GLOBALS)
	(DESC "escape pod")
	(SYNONYM POD)
	(ADJECTIVE EMERGENCY ESCAPE PRIMARY)
	(FLAGS VOWELBIT VEHBIT NDESCBIT)
	(ACTION GLOBAL-POD-F)>

<ROUTINE GLOBAL-POD-F ()
	 <COND (<VERB? THROUGH BOARD WALK-TO>
		<COND (<EQUAL? ,HERE ,ESCAPE-POD>
		       <TELL "You're already in it!" CR>)
		      (T
		       <DO-WALK ,P?WEST>
		       <RTRUE>)>)
	       (<VERB? EXIT DISEMBARK DROP>
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <TELL "You're not in it!" CR>)
		      (T
		       <DO-WALK ,P?OUT>
		       <RTRUE>)>)
	       (<VERB? OPEN>
		<PERFORM ,V?OPEN ,POD-DOOR>
		<RTRUE>)>>

<ROUTINE POD-EXIT-F ()
	 <COND (<G? ,BLOWUP-COUNTER 4>
		<COND (<EQUAL? ,PRSO ,P?EAST>
		       <TELL ,CANT-GO CR>
		       <RFALSE>)
		      (<NOT <FSET? ,POD-DOOR ,OPENBIT>>
		       <TELL "The pod door is closed." CR>
		       <RFALSE>)
		      (T
		       <SETG C-ELAPSED 30>
		       ,UNDERWATER)>)
	       (T
		<COND (<EQUAL? ,PRSO ,P?UP>
		       <TELL ,CANT-GO CR>
		       <RFALSE>)
		      (<NOT <FSET? ,POD-DOOR ,OPENBIT>>
		       <TELL "The pod door is closed." CR>
		       <RFALSE>)
		      (T
		       ,DECK-NINE)>)>>

<OBJECT SAFETY-WEB
	(IN ESCAPE-POD)
	(DESC "safety web")
	(SYNONYM MASS WEB WEBBING NET)
	(ADJECTIVE SAFETY)
	(FLAGS CLIMBBIT VEHBIT NDESCBIT)
	(ACTION SAFETY-WEB-F)>

<ROUTINE SAFETY-WEB-F ("OPTIONAL" (RARG ,M-OBJECT))
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? .RARG ,M-OBJECT>>
		<TELL
"The safety webbing fills most of the pod. It could accomodate
from one to, perhaps, twenty people." CR>)
	       (<AND <VERB? TAKE>
		     <EQUAL? .RARG ,M-OBJECT>>
		<TELL
"The safety web seems to be more intended for getting into than
grabbing onto." CR>)
	       (<AND <VERB? BOARD CLIMB-ON>
		     <EQUAL? .RARG ,M-OBJECT>>
		<MOVE ,ADVENTURER ,SAFETY-WEB>
		<TELL
"You are now safely cushioned within the web." CR>)
	       (<AND <VERB? OPEN TAKE>
		     <EQUAL? .RARG ,M-BEG>>
		<COND (<EQUAL? ,PRSO ,SAFETY-WEB>
		       <TELL "You're in it!" CR>)
		      (T
		       <TELL "You can't reach it from here." CR>)>)
	       (<AND <VERB? WALK>
		     <EQUAL? .RARG ,M-BEG>>
		<TELL "You'll have to stand up, first." CR>)
	       (<AND <VERB? EXIT DISEMBARK DROP STAND>
		     <EQUAL? .RARG ,M-OBJECT>
		     <IN? ,ADVENTURER ,SAFETY-WEB>>
		<MOVE ,ADVENTURER ,HERE>
		<COND (<AND <G? ,TRIP-COUNTER 14>
			    <EQUAL? <GET <INT I-SINK-POD> ,C-ENABLED?> 0>>
		       <ENABLE <QUEUE I-SINK-POD -1>>
		       <TELL
"As you stand, the pod shifts slightly and you feel it falling.
A moment later, the fall stops with a shock, and you see water
rising past the viewport." CR>)
		      (T
		       <TELL "You are standing again." CR>)>)>> 

<OBJECT TOWEL
	(DESC "towel")
	(SYNONYM TOWEL)
	(SIZE 10)
	(FLAGS READBIT TAKEBIT)
	(TEXT
"\"S.P.S. FEINSTEIN|
  Escape Pod #42|
   Don't Panic!\"")
	(ACTION TOWEL-F)>

<ROUTINE TOWEL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"A pretty ordinary towel. Something is written in its corner." CR>)>>

<OBJECT FOOD-KIT
	(DESC "survival kit")
	(SYNONYM PROVISIONS KIT)
	(ADJECTIVE SURVIVAL EMERGENCY)
	(SIZE 10)
	(CAPACITY 25)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION FOOD-KIT-F)>

<ROUTINE FOOD-KIT-F ()
	 <COND (<VERB? EMPTY>
		<COND (<NOT <FSET? ,FOOD-KIT ,OPENBIT>>
		       <TELL "The kit is closed!" CR>)
		      (<FIRST? ,PRSO>
		       <TELL
"The goo, being gooey, sticks to the inside of the kit. You would probably
have to shake the kit to get the goo out." CR>)>)>>

<OBJECT RED-GOO
	(IN FOOD-KIT)
	(DESC "blob of red goo")
	(SYNONYM GOO BLOB FOOD PIE)
	(ADJECTIVE RED CHERRY)
	(FLAGS ACIDBIT FOODBIT)
	(ACTION GOO-F)>

<OBJECT BROWN-GOO
	(IN FOOD-KIT)
	(DESC "blob of brown goo")
	(SYNONYM GOO BLOB FOOD STEW)
	(ADJECTIVE BROWN BEEF)
	(FLAGS ACIDBIT FOODBIT)
	(ACTION GOO-F)>

<OBJECT GREEN-GOO
	(IN FOOD-KIT)
	(DESC "blob of green goo")
	(SYNONYM GOO BLOB FOOD BEANS)
	(ADJECTIVE GREEN LIMA)
	(FLAGS ACIDBIT FOODBIT)
	(ACTION GOO-F)>

<ROUTINE GOO-F ()
	<COND (<VERB? EAT>
	       <COND (<EQUAL? ,HUNGER-LEVEL 0>
		      <TELL ,NOT-HUNGRY CR>)
		     (<NOT <IN? ,FOOD-KIT ,ADVENTURER>>
		      <SETG PRSO ,FOOD-KIT>
		      <NOT-HOLDING>
		      <THIS-IS-IT ,FOOD-KIT>)
		     (T
		      <REMOVE ,PRSO>
		      <SETG C-ELAPSED 15>
		      <SETG HUNGER-LEVEL 0>
		      <ENABLE <QUEUE I-HUNGER-WARNINGS 1450>>
		      <TELL "Mmmm...that tasted just like ">
		      <COND (<EQUAL? ,PRSO ,BROWN-GOO>
			     <TELL "delicious Nebulan fungus pudding">)
			    (<EQUAL? ,PRSO ,RED-GOO>
			     <TELL "scrumptious cherry pie">)
			    (T
			     <TELL "yummy lima beans">)>
		      <TELL "." CR>)>)
	      (<VERB? TAKE DROP>
	       <COND (<VERB? DROP>	
	       	      <TELL "The goo, being gooey, sticks where it is">)
	             (<VERB? TAKE>
	              <TELL "It would ooze through your fingers">)>
	       <TELL
". You'll have to eat it right from the survival kit." CR>)>>

<ROUTINE ESCAPE-POD-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is one of the Feinstein's primary escape pods, for use in extreme
emergencies. A mass of safety webbing, large enough to hold several dozen
people, fills half the pod. The controls are entirely automated. The
bulkhead leading out is ">
		<DDESC ,POD-DOOR>
		<TELL "." CR>)>>

<OBJECT POD-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "escape pod bulkhead")
	(SYNONYM DOOR BULKHEAD)
	(ADJECTIVE EMERGENCY ESCAPE POD)
	(FLAGS VOWELBIT DOORBIT NDESCBIT)
	(ACTION POD-DOOR-F)>

<ROUTINE POD-DOOR-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,POD-DOOR ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<G? ,TRIP-COUNTER 14>
		       <FSET ,POD-DOOR ,OPENBIT>
		       <TELL 
"The bulkhead opens and cold ocean water rushes in!" CR>)
		      (<G? ,BLOWUP-COUNTER 0>
		       <COND (<EQUAL? ,HERE ,DECK-NINE>
			      <TELL
"Too late. The pod's launching procedure has already begun." CR>)
			     (T
			      <TELL
"Opening the door now would be a phenomenally stupid idea." CR>)>)
		      (T
		       <TELL
"Why open the door to the emergency escape pod if there's no emergency?" CR>)>)
	       (<VERB? CLOSE>
		<COND (<NOT <FSET? ,POD-DOOR ,OPENBIT>>
		       <IS-CLOSED>)
		      (T
		       <TELL "You can't close it yourself." CR>)>)
	       (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <DO-WALK ,P?WEST>)
		      (T
		       <DO-WALK ,P?OUT>)>)>>

<OBJECT CORRIDOR-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "wide bulkhead")
	(SYNONYM DOOR BULKHEAD)
	(ADJECTIVE EMERGENCY WIDE)
	(FLAGS INVISIBLE DOORBIT OPENBIT NDESCBIT)
	(ACTION GANGWAY-DOOR-F)>

<OBJECT GANGWAY-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "narrow bulkhead")
	(SYNONYM DOOR BULKHEAD)
	(ADJECTIVE EMERGENCY NARROW)
	(FLAGS INVISIBLE DOORBIT OPENBIT NDESCBIT)
	(ACTION GANGWAY-DOOR-F)>

<ROUTINE GANGWAY-DOOR-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (T
		       <TELL
"There doesn't seem to be any way to open it." CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "You can't close it yourself." CR>)
		      (T
		       <IS-CLOSED>)>)>>

<GLOBAL BLOWUP-COUNTER 0>

<ROUTINE I-BLOWUP-FEINSTEIN ()
	 <ENABLE <QUEUE I-BLOWUP-FEINSTEIN -1>>
	 <SETG BLOWUP-COUNTER <+ ,BLOWUP-COUNTER 1>>
	 <COND (<EQUAL? ,BLOWUP-COUNTER 5>
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <JIGS-UP
"|
An enormous explosion tears the walls of the ship apart. If only you
had made it to an escape pod...">)
		      (T
		       <TELL CR
"Through the viewport of the pod you see the Feinstein dwindle as you head
away. Bursts of light dot its hull. Suddenly, a huge explosion blows the
Feinstein into tiny pieces, sending the escape pod tumbling away! " CR>
		       <ENABLE <QUEUE I-POD-TRIP -1>>
		       <DISABLE <INT I-BLOWUP-FEINSTEIN>>
		       <COND (<AND <NOT <IN? ,WINNER ,SAFETY-WEB>>
				   <PROB 20>>
			      <JIGS-UP
"|
You are thrown against the bulkhead, head first. It seems that getting in
the safety webbing would have been a good idea.">)
			     (<NOT <IN? ,WINNER ,SAFETY-WEB>>
			      <TELL CR
"You are thrown against the bulkhead, bruising a few limbs. The safety
webbing might have offered a bit more protection." CR>)>)>)
	       (<EQUAL? ,BLOWUP-COUNTER 4>
		<DISABLE <INT I-BLATHER>>
		<DISABLE <INT I-AMBASSADOR>>
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <TELL CR "Explosions continue to rock the ship." CR>)
		      (T
		       <TELL CR
"You feel the pod begin to slide down its ejection tube as explosions shake
the mother ship." CR>)>)
	       (<EQUAL? ,BLOWUP-COUNTER 3>
		<FCLEAR ,POD-DOOR ,OPENBIT>
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <TELL CR
"More powerful explosions buffet the ship. The lights flicker madly,
and the escape-pod bulkhead clangs shut." CR>)
		      (<EQUAL? ,HERE ,ESCAPE-POD>
		       <TELL CR
"The pod door clangs shut as heavy explosions continue to buffet the
Feinstein." CR>)
		      (T
		       <JIGS-UP
"|
The ship rocks from the force of multiple explosions. The lights go out, and
you feel a sudden drop in pressure accompanied by a loud hissing. Too bad you
weren't in the escape pod...">)>)
	       (<EQUAL? ,BLOWUP-COUNTER 2>
		<FCLEAR ,CORRIDOR-DOOR ,OPENBIT>
		<FCLEAR ,CORRIDOR-DOOR ,INVISIBLE>
		<FCLEAR ,GANGWAY-DOOR ,OPENBIT>
		<FCLEAR ,GANGWAY-DOOR ,INVISIBLE>
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <TELL CR
"More distant explosions! A narrow emergency bulkhead at the base of the
gangway and a wider one along the corridor to starboard both crash shut!" CR>)
		      (<EQUAL? ,HERE ,ESCAPE-POD ,BRIG>
		       <TELL CR
"The ship shakes again. You hear, from close by, the sounds of emergency
bulkheads closing." CR>)
		      (<EQUAL? ,HERE ,GANGWAY>
		       <TELL CR
"Another explosion. A narrow bulkhead at the base of the
gangway slams shut!" CR>)
		      (T
		       <TELL CR
"You are deafened by more explosions and by the sound of emergency bulkheads
slamming closed. ">
		       <COND (<IN? ,BLATHER ,HERE>
			      <TELL
"Blather, foaming slightly at the mouth, screams at you to swab the decks">)
			     (T
			      <MOVE ,BLATHER ,HERE>
			      <TELL
"Blather enters, looking confused, and begins ranting madly at you">)>
		       <TELL "." CR>)>)
	       (<EQUAL? ,BLOWUP-COUNTER 1>
		<SETG BRIGS-UP 0>
		<FSET ,POD-DOOR ,OPENBIT>
		<TELL CR
"A massive explosion rocks the ship. Echoes from the explosion resound
deafeningly down the halls. ">
		<COND (<EQUAL? ,HERE ,DECK-NINE>
		       <TELL "The door to port slides open. ">
		       <COND (<IN? ,AMBASSADOR ,HERE>
			      <REMOVE ,AMBASSADOR>
			      <REMOVE ,CELERY>
			      <TELL
"The ambassador squawks frantically, evacuates a massive load of gooey
slime, and rushes away." CR>)
			     (<IN? ,BLATHER ,HERE>
			      <REMOVE ,BLATHER>
			      <TELL
"Blather, confused by this non-routine occurrence, orders you to continue
scrubbing the floor, and then dashes off." CR>)
			     (T
			      <TELL CR>)>)
		      (<EQUAL? ,HERE ,ESCAPE-POD ,GANGWAY ,BRIG>
		       <TELL CR>)
		      (T
		       <TELL
"Blather, looking slightly disoriented, barks at you to resume your assigned
duties." CR>)>)>>

<GLOBAL TRIP-COUNTER 0>

<ROUTINE I-POD-TRIP ()
	 <SETG TRIP-COUNTER <+ ,TRIP-COUNTER 1>>
	 <COND (<EQUAL? ,TRIP-COUNTER 1>
		<TELL CR
"As the escape pod tumbles away from the former location of the Feinstein, its
gyroscopes whine. The pod slowly stops tumbling. Lights on the control panel
blink furiously as the autopilot searches for a reasonable destination." CR>)
	       (<EQUAL? ,TRIP-COUNTER 2>
		<TELL CR
"The auxiliary rockets fire briefly, and a nearby planet swings into view
through the port. It appears to be almost entirely ocean, with just a few
visible islands and an unusually small polar ice cap. A moment later, the
system's sun swings into view, and the viewport polarizes into a featureless
black rectangle." CR>)
	       (<EQUAL? ,TRIP-COUNTER 3>
		<TELL CR
"The main thrusters fire a long, gentle burst. A monotonic voice issues
from the control panel. \"Approaching planet...human-habitable.\"" CR>)
	       (<EQUAL? ,TRIP-COUNTER 7>
		<TELL CR
"The pod is buffeted as it enters the planet's atmosphere." CR>)
	       (<EQUAL? ,TRIP-COUNTER 8>
		<TELL CR
"You feel the temperature begin to rise, and the pod's climate
control system roars as it labors to compensate." CR>)
	       (<EQUAL? ,TRIP-COUNTER 9>
		<TELL CR
"The viewport suddenly becomes transparent again, giving you a view of
endless ocean below. The lights on the control panel flash madly as
the pod's computer searches for a suitable landing site. The thrusters fire
long and hard, slowing the pod's descent." CR>)
	       (<EQUAL? ,TRIP-COUNTER 10>
		<TELL CR
"The pod is now approaching the closer of a pair of islands. It appears
to be surrounded by sheer cliffs rising from the water, and is topped by
a wide plateau. The plateau seems to be covered by a sprawling complex
of buildings." CR>)
	       (<EQUAL? ,TRIP-COUNTER 11>
		<COND (<IN? ,WINNER ,SAFETY-WEB>
		       <MOVE ,FOOD-KIT ,HERE>
		       <MOVE ,TOWEL ,HERE>
		       <TELL CR
"The pod lands with a thud. Through the viewport you can see a rocky cleft
and some water below. The pod rocks gently back and forth as if it was
precariously balanced. A previously unseen panel slides open, revealing
some emergency provisions, including a survival kit and a towel." CR>
		       <SETG TRIP-COUNTER 15>
		       <DISABLE <INT I-POD-TRIP>>)
		      (T
		       <JIGS-UP
"|
The pod, whose automated controls were unfortunately designed by computer
scientists, lands with a good deal of force. Your body sails across the pod
until it is stopped by one of the sharper corners of the control panel.">)>)>>

<GLOBAL SINK-COUNTER 0>

<ROUTINE I-SINK-POD ()
	 <SETG SINK-COUNTER <+ ,SINK-COUNTER 1>>
	 <COND (<AND <EQUAL? ,SINK-COUNTER 3>
		     <EQUAL? ,HERE ,ESCAPE-POD>>
		<TELL CR 
"The pod is now completely submerged, and you feel it smash against underwater
rocks. Bubbles streaming upward past the window indicate that the pod is
continuing to sink." CR>)
	       (<AND <EQUAL? ,SINK-COUNTER 4>
		     <EQUAL? ,HERE ,ESCAPE-POD>
		     <NOT <FSET? ,POD-DOOR ,OPENBIT>>>
		<TELL CR 
"The pod creaks ominously from the increasing pressure." CR>)
	       (<AND <EQUAL? ,SINK-COUNTER 5>
		     <EQUAL? ,HERE ,ESCAPE-POD>>
		<COND (<FSET? ,POD-DOOR ,OPENBIT>
		       <JIGS-UP
"|
Between the swirling waters and the increasing pressure, it's curtains
for you. Perhaps you should have left the pod a bit sooner.">)
		      (T
		       <JIGS-UP
"|
The pod splits open, and water pours in.">)>)>>

^L
"The next bunch of stuff is for the cards, slots, and associated junk."

<OBJECT SLOT
	(IN LOCAL-GLOBALS)
	(DESC "slot")
	(SYNONYM SLOT)
	(ADJECTIVE SMALL)
	(FLAGS NDESCBIT)
	(ACTION SLOT-F)>

<ROUTINE SLOT-F ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,SLOT ,PRSI>>
		<TELL
"The slot is shallow, so you can't put anything in it. It may be possible to
slide something through the slot, though." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The slot is about ten centimeters wide, but only about two centimeters deep.
It is surrounded on its long sides by parallel ridges of metal." CR>)
	       (<AND <VERB? SLIDE>
		     <EQUAL? ,SLOT ,PRSI>>
		<MOVE ,PRSO ,ADVENTURER>
		<COND (<FSET? ,PRSO ,SCRAMBLEDBIT>
		       <TELL
"A sign flashes \"Magnetik striip randumiizd...konsult Prajekt Handbuk abowt
propur kaar uv awtharazaashun kardz.\"" CR>)
		      (<EQUAL? ,PRSO ,KITCHEN-CARD>
		       <COND (<EQUAL? ,HERE ,MESS-HALL>
			      <COND (<FSET? ,KITCHEN-DOOR ,OPENBIT>
				     <TELL "Nothing happens." CR>)
				    (T
				     <FSET ,KITCHEN-DOOR ,OPENBIT>
				     <ENABLE <QUEUE I-KITCHEN-DOOR-CLOSES 50>>
				     <TELL
"The kitchen door quietly slides open." CR>
				     <FLOYD-REVEAL-CARD-F>
				     <RTRUE>)>)
			     (T
			      <TELL ,WRONG-CARD CR>)>)
		      (<EQUAL? ,PRSO ,UPPER-ELEVATOR-CARD>
		       <COND (<EQUAL? ,HERE ,UPPER-ELEVATOR>
			      <SETG UPPER-ELEVATOR-ON T>
			      <ENABLE <QUEUE I-TURNOFF-UPPER-ELEVATOR 180>>
			      <TELL ,ELEVATOR-ENABLED CR>
			      <FLOYD-REVEAL-CARD-F>
			      <RTRUE>)
			     (T
			      <TELL ,WRONG-CARD CR>)>)
		      (<EQUAL? ,PRSO ,LOWER-ELEVATOR-CARD>
		       <COND (<EQUAL? ,HERE ,LOWER-ELEVATOR>
			      <SETG LOWER-ELEVATOR-ON T>Y
			      <ENABLE <QUEUE I-TURNOFF-LOWER-ELEVATOR 200>>
			      <TELL ,ELEVATOR-ENABLED CR>)
			     (T
			      <TELL ,WRONG-CARD CR>)>)
		      (<EQUAL? ,PRSO ,TELEPORTATION-CARD>
		       <COND (<EQUAL? ,HERE ,BOOTH-1 ,BOOTH-2 ,BOOTH-3>
			      <SETG TELEPORTATION-ON T>
			      <ENABLE <QUEUE I-TURNOFF-TELEPORTATION 30>>
			      <TELL
"Nothing happens for a moment. Then a light flashes \"Redee.\"" CR>)
			     (T
			      <TELL ,WRONG-CARD CR>)>)
		      (<EQUAL? ,PRSO ,SHUTTLE-CARD>
		       <SHUTTLE-ACTIVATE>)
		      (<EQUAL? ,PRSO ,MINI-CARD>
		       <COND (<EQUAL? ,HERE ,MINI-BOOTH>
			      <SETG MINI-ACTIVATED T>
			      <ENABLE <QUEUE I-TURNOFF-MINI 30>>
			      <TELL
"A melodic high-pitched voice says \"Miniaturization and teleportation booth
activated. Please type in damaged sector number.\"" CR>)
			     (T
			      <TELL ,WRONG-CARD CR>)>)
		      (<EQUAL? ,PRSO ,ID-CARD>
		       <TELL ,WRONG-CARD CR>)>)>>

<GLOBAL ELEVATOR-ENABLED "A recorded voice chimes \"Elevator enabled.\"">

<GLOBAL WRONG-CARD 
"A sign flashes \"Inkorekt awtharazaashun kard...akses deeniid.\"">

<GLOBAL CARD-REVEALED <>> ;"checks whether Floyd has already revealed his card"

<ROUTINE FLOYD-REVEAL-CARD-F ()
	 <COND (<AND <IN? ,FLOYD ,HERE>
		     <NOT ,CARD-REVEALED>
		     <OR <AND <EQUAL? ,DAY 2>
			      <L? ,INTERNAL-MOVES 5000>
			      <PROB 5>>
			 <AND <EQUAL? ,DAY 2>
			      <G? ,INTERNAL-MOVES 4999>
			      <PROB 10>>
			 <AND <EQUAL? ,DAY 3>
			      <L? ,INTERNAL-MOVES 5000>
			      <PROB 20>>
			 <AND <EQUAL? ,DAY 3>
			      <G? ,INTERNAL-MOVES 4999>
			      <PROB 40>>
			 <G? ,DAY 3>>>
		<SETG CARD-REVEALED T>
		<SETG FLOYD-SPOKE T>
		<COND (<NOT ,CARD-STOLEN>
		       <MOVE ,LOWER-ELEVATOR-CARD ,FLOYD>
		       <TELL
"Floyd claps his hands with excitement. \"Those cards are really neat, huh?
Floyd has one for himself--see?\" He reaches behind one of his panels and
retrieves a magnetic-striped card. He waves it exuberantly in the air." CR>)
		      (T
		       <TELL
"Floyd bobs up and down with excitement. \"Those cards are really neat! Floyd
has one, too.\" He begins searching through his compartments, but finds
nothing. He scratches his head and looks confused." CR>)>)>>

<ROUTINE I-KITCHEN-DOOR-CLOSES ()
	 <COND (<EQUAL? ,HERE ,KITCHEN>
		<ENABLE <QUEUE I-KITCHEN-DOOR-CLOSES -1>>
		<RFALSE>)
	       (T
		<FCLEAR ,KITCHEN-DOOR ,OPENBIT>
		<DISABLE <INT I-KITCHEN-DOOR-CLOSES>>
		<COND (<EQUAL? ,HERE ,MESS-HALL>
		       <TELL CR
"The kitchen door slides quietly closed." CR>)>)>>
^L

;"teleportation stuff"

<OBJECT TELEPORTATION-BUTTON-1
	(IN LOCAL-GLOBALS)
	(DESC "brown button")
	(SYNONYM BUTTON)
	(ADJECTIVE BROWN FIRST)
	(FLAGS NDESCBIT)
	(ACTION TELEPORTATION-BUTTON-1-F)>

<OBJECT TELEPORTATION-BUTTON-2
	(IN LOCAL-GLOBALS)
	(DESC "beige button")
	(SYNONYM BUTTON)
	(ADJECTIVE BEIGE SECOND)
	(FLAGS NDESCBIT)
	(ACTION TELEPORTATION-BUTTON-2-F)>

<OBJECT TELEPORTATION-BUTTON-3
	(IN LOCAL-GLOBALS)
	(DESC "tan button")
	(SYNONYM BUTTON)
	(ADJECTIVE TAN THIRD)
	(FLAGS NDESCBIT)
	(ACTION TELEPORTATION-BUTTON-3-F)>

<GLOBAL TELEPORTATION-ON <>>

<ROUTINE TELEPORT (BOOTH)
	 <COND (<VERB? PUSH>
		<COND (<EQUAL? ,TELEPORTATION-ON T>
		       <TELL
"You experience a strange feeling in the pit of your stomach." CR>
		       <COND (<IN? ,FLOYD ,HERE>
			      <TELL
"Floyd gives a terrified squeal, and clutches at his guidance mechanism." CR>
			      <SETG FLOYD-SPOKE T>
			      <ENABLE <QUEUE I-FLOYD 1>>)>
		       <ROB ,HERE .BOOTH>
		       <GOTO .BOOTH <>>
		       <DISABLE <INT I-TURNOFF-TELEPORTATION>>
		       <SETG TELEPORTATION-ON <>>
		       <RTRUE>)
		      (T
		       <TELL
"A sign flashes \"Teleportaashun buux not aktivaatid.\"" CR>)>)>>

<ROUTINE TELEPORTATION-BUTTON-1-F ()
	 <TELEPORT ,BOOTH-1>>

<ROUTINE TELEPORTATION-BUTTON-2-F ()
	 <TELEPORT ,BOOTH-2>>

<ROUTINE TELEPORTATION-BUTTON-3-F ()
	 <TELEPORT ,BOOTH-3>>

<ROUTINE I-TURNOFF-TELEPORTATION ()
	 <SETG TELEPORTATION-ON <>>
	 <COND (<EQUAL? ,HERE ,BOOTH-1 ,BOOTH-2 ,BOOTH-3>
		<TELL CR "The ready light goes dark." CR>)>>

^L

;"shuttle system"

<OBJECT GLOBAL-SHUTTLE
	(IN LOCAL-GLOBALS)
	(DESC "shuttle car")
	(SYNONYM CAR SHUTTL)
	(ADJECTIVE SHUTTL)
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-SHUTTLE-F)>

<ROUTINE GLOBAL-SHUTTLE-F ()
	 <COND (<VERB? ENTER THROUGH WALK-TO BOARD>
		<COND (<OR <EQUAL? ,HERE ,SHUTTLE-CAR-ALFIE
				         ,ALFIE-CONTROL-EAST
					 ,ALFIE-CONTROL-WEST>
			   <EQUAL? ,HERE ,SHUTTLE-CAR-BETTY
				         ,BETTY-CONTROL-EAST
					 ,BETTY-CONTROL-WEST>>
		       <TELL "You ARE in the shuttle car." CR>)
		      (T
		       <TELL "Use 'north' or 'south'." CR>)>)
	       (<VERB? EXIT DISEMBARK DROP>
		<COND (<EQUAL? ,HERE ,SHUTTLE-CAR-ALFIE>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,SHUTTLE-CAR-BETTY>
		       <DO-WALK ,P?SOUTH>)
		      (<OR <EQUAL? ,HERE ,BETTY-CONTROL-EAST
					 ,BETTY-CONTROL-WEST>
			   <EQUAL? ,HERE ,ALFIE-CONTROL-EAST
				         ,ALFIE-CONTROL-WEST>>
		       <TELL "You can't exit the shuttle car from here." CR>)
		      (T
		       <TELL "You're not in the shuttle car!" CR>)>)>>

<ROOM SHUTTLE-CAR-ALFIE
      (IN ROOMS)
      (DESC "Shuttle Car Alfie")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH PER SHUTTLE-EXIT-F)
      (EAST TO ALFIE-CONTROL-EAST)
      (WEST TO ALFIE-CONTROL-WEST)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-SHUTTLE SHUTTLE-DOOR)
      (ACTION SHUTTLE-CAR-F)>

<ROOM ALFIE-CONTROL-EAST
      (IN ROOMS)
      (DESC "Alfie Control East")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO SHUTTLE-CAR-ALFIE IF SHUTTLE-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SLOT WINDOW LEVER SHUTTLE-DOOR GLOBAL-SHUTTLE)
      (ACTION CONTROL-CABIN-F)>

<ROOM ALFIE-CONTROL-WEST
      (IN ROOMS)
      (DESC "Alfie Control West")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO SHUTTLE-CAR-ALFIE IF SHUTTLE-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SLOT LEVER WINDOW SHUTTLE-DOOR GLOBAL-SHUTTLE)
      (ACTION CONTROL-CABIN-F)>

<OBJECT LEVER
	(IN LOCAL-GLOBALS)
	(DESC "lever")
	(SYNONYM LEVER)
	(FLAGS NDESCBIT)
	(ACTION LEVER-F)>

<OBJECT SHUTTLE-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR)
	(FLAGS DOORBIT OPENBIT INVISIBLE)
	(ACTION SHUTTLE-DOOR-F)>

<ROUTINE SHUTTLE-CAR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the cabin of a large transport, with seating for around 20 people
plus space for freight. There are open doors at the eastern and western ends
of the cabin, and a doorway leads out to a wide platform to the ">
		<COND (<EQUAL? ,HERE ,SHUTTLE-CAR-ALFIE>
		       <TELL "north">)
		      (T
		       <TELL "south">)>
		<TELL "." CR>)>>

<ROOM SHUTTLE-CAR-BETTY
      (IN ROOMS)
      (DESC "Shuttle Car Betty")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH PER SHUTTLE-EXIT-F)
      (EAST TO BETTY-CONTROL-EAST)
      (WEST TO BETTY-CONTROL-WEST)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-SHUTTLE SHUTTLE-DOOR)
      (ACTION SHUTTLE-CAR-F)>

<ROOM BETTY-CONTROL-EAST
      (IN ROOMS)
      (DESC "Betty Control East")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO SHUTTLE-CAR-BETTY IF SHUTTLE-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-SHUTTLE SLOT WINDOW LEVER SHUTTLE-DOOR)
      (ACTION CONTROL-CABIN-F)>

<ROOM BETTY-CONTROL-WEST
      (IN ROOMS)
      (DESC "Betty Control West")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO SHUTTLE-CAR-BETTY IF SHUTTLE-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-SHUTTLE SLOT LEVER WINDOW SHUTTLE-DOOR)
      (ACTION CONTROL-CABIN-F)>

<ROUTINE CONTROL-CABIN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"This is a small control cabin. A control panel contains a slot, a lever,
and a display. The lever can be set at a central position, or it could be
pushed up to a position labelled \"+\", or pulled down to a position
labelled \"-\". It is currently at the ">
		<COND (<EQUAL? ,LEVER-SETTING 0>
		       <TELL "center">)
		      (<EQUAL? ,LEVER-SETTING 1>
		       <TELL "upper">)
		      (T
		       <TELL "lower">)>
		<TELL
" setting. The display, a digital readout, currently reads ">
		<TELL N ,SHUTTLE-VELOCITY>
		<TELL ". Through the cabin window you can see ">
		<DESCRIBE-VIEW>
		<TELL CR>)>>

<ROUTINE DESCRIBE-VIEW ()
	 <COND (<OR <AND <EQUAL? ,HERE ,ALFIE-CONTROL-WEST>
			  ,ALFIE-AT-KALAMONTEE>
		     <AND <EQUAL? ,HERE ,BETTY-CONTROL-WEST>
			  ,BETTY-AT-KALAMONTEE>
		     <AND <EQUAL? ,HERE ,ALFIE-CONTROL-EAST>
			  <NOT ,ALFIE-AT-KALAMONTEE>>
		     <AND <EQUAL? ,HERE ,BETTY-CONTROL-EAST>
			  <NOT ,BETTY-AT-KALAMONTEE>>>
		 <TELL "a featureless concrete wall.">)
		(<AND ,SHUTTLE-MOVING
		      <EQUAL? ,SHUTTLE-COUNTER 23>>
		 <TELL
"parallel rails ending at a brightly-lit station ahead.">)
		(T
		 <TELL "parallel rails running along the floor of a long
tunnel, vanishing in the distance.">)>>
		
<ROUTINE SHUTTLE-DOOR-F ()
	 <COND (<VERB? OPEN>
		<COND (,SHUTTLE-MOVING
		       <TELL
"A recorded voice says \"Operator should remain in control cabin while shuttle
car is between stations.\"" CR>)
		      (T
		       <TELL "Are you sure it isn't?" CR>)>)>>

<ROUTINE SHUTTLE-ENTER-F ()
	 <COND (<EQUAL? ,HERE ,KALAMONTEE-PLATFORM>
		<COND (<EQUAL? ,PRSO ,P?NORTH>
		       <COND (,BETTY-AT-KALAMONTEE
			      ,SHUTTLE-CAR-BETTY)
			     (T
			      <TELL ,CANT-GO CR>
			      <RFALSE>)>)
		      (<EQUAL? ,PRSO ,P?SOUTH>
		       <COND (,ALFIE-AT-KALAMONTEE
			      ,SHUTTLE-CAR-ALFIE)
			     (T
			      <TELL ,CANT-GO CR>
			      <RFALSE>)>)>)
	       (<EQUAL? ,HERE ,LAWANDA-PLATFORM>
		<COND (<EQUAL? ,PRSO, P?NORTH>
		       <COND (,BETTY-AT-KALAMONTEE
			      <TELL ,CANT-GO CR>
			      <RFALSE>)
			     (T
			      ,SHUTTLE-CAR-BETTY)>)
		      (<EQUAL? ,PRSO ,P?SOUTH>
		       <COND (,ALFIE-AT-KALAMONTEE
			      <TELL ,CANT-GO CR>
			      <RFALSE>)
			     (T
			      ,SHUTTLE-CAR-ALFIE)>)>)>>

<GLOBAL CANT-GO "You can't go that way.">

<ROUTINE SHUTTLE-EXIT-F ()
	 <COND (<EQUAL? ,HERE ,SHUTTLE-CAR-ALFIE>
		<COND (,ALFIE-AT-KALAMONTEE
		       ,KALAMONTEE-PLATFORM)
		      (T
		       ,LAWANDA-PLATFORM)>)
	       (<EQUAL? ,HERE ,SHUTTLE-CAR-BETTY>
		<COND (,BETTY-AT-KALAMONTEE
		       ,KALAMONTEE-PLATFORM)
		      (T
		       ,LAWANDA-PLATFORM)>)>>

<GLOBAL ALFIE-AT-KALAMONTEE T> ;"true if Alfie is at Kalamontee Station"

<GLOBAL BETTY-AT-KALAMONTEE <>> ;"true if Betty is at Kalamontee Station"

<GLOBAL SHUTTLE-MOVING <>> ;"true if Shuttle is between Stations"

<GLOBAL SHUTTLE-ON <>> ;"true if shuttle is activated"

<GLOBAL SHUTTLE-VELOCITY 0>

<GLOBAL SHUTTLE-COUNTER 0> ;"number of moves in shuttle trip so far"

<ROUTINE SHUTTLE-ACTIVATE ()
	 <COND (<AND <NOT <EQUAL? ,HERE ,ALFIE-CONTROL-EAST
				        ,ALFIE-CONTROL-WEST>>
		     <NOT <EQUAL? ,HERE ,BETTY-CONTROL-EAST
				        ,BETTY-CONTROL-WEST>>>
		<TELL ,WRONG-CARD CR>
		<RTRUE>)
	       (<OR <AND ,ALFIE-BROKEN
		     <EQUAL? ,HERE ,ALFIE-CONTROL-EAST ,ALFIE-CONTROL-WEST>>
		    <AND ,BETTY-BROKEN
		     <EQUAL? ,HERE ,BETTY-CONTROL-EAST ,BETTY-CONTROL-WEST>>>
		<TELL
"A garbled recording mentions that the shuttle car has undergone some
damage and that the repair robot has been summoned." CR>
		<RTRUE>)
	       (<G? ,INTERNAL-MOVES 6000>
		<TELL
"A recorded voice explains that using the shuttle car during the evening
hours requires special authorization." CR>
		<RTRUE>)>
	 <COND (<EQUAL? ,HERE ,ALFIE-CONTROL-EAST>
		<COND (,SHUTTLE-ON
		       <TELL ,SHUTTLE-RECORDING-1 CR>)
		      (<NOT ,ALFIE-AT-KALAMONTEE>
		       <TELL ,SHUTTLE-RECORDING-2 CR>)
		      (T
		       <SETG SHUTTLE-ON T>
		       <ENABLE <QUEUE I-TURNOFF-SHUTTLE 80>>
		       <TELL ,SHUTTLE-RECORDING-3 CR>)>)
	       (<EQUAL? ,HERE ,ALFIE-CONTROL-WEST>
		<COND (,SHUTTLE-ON
		       <TELL ,SHUTTLE-RECORDING-1 CR>)
		      (,ALFIE-AT-KALAMONTEE
		       <TELL ,SHUTTLE-RECORDING-2 CR>)
		      (T
		       <SETG SHUTTLE-ON T>
		       <ENABLE <QUEUE I-TURNOFF-SHUTTLE 80>> 
		       <TELL ,SHUTTLE-RECORDING-3 CR>)>)
	       (<EQUAL? ,HERE ,BETTY-CONTROL-EAST>
		<COND (,SHUTTLE-ON
		       <TELL ,SHUTTLE-RECORDING-1 CR>)
		      (<NOT ,BETTY-AT-KALAMONTEE>
		       <TELL ,SHUTTLE-RECORDING-2 CR>)
		      (T
		       <SETG SHUTTLE-ON T>
		       <ENABLE <QUEUE I-TURNOFF-SHUTTLE 80>>
		       <TELL ,SHUTTLE-RECORDING-3 CR>)>)
	       (<EQUAL? ,HERE ,BETTY-CONTROL-WEST>
		<COND (,SHUTTLE-ON
		       <TELL ,SHUTTLE-RECORDING-1 CR>)
		      (,BETTY-AT-KALAMONTEE
		       <TELL ,SHUTTLE-RECORDING-2 CR>)
		      (T
		       <SETG SHUTTLE-ON T>
		       <ENABLE <QUEUE I-TURNOFF-SHUTTLE 80>>
		       <TELL ,SHUTTLE-RECORDING-3 CR>)>)
	       (T
		<TELL ,WRONG-CARD CR>)>>

<GLOBAL SHUTTLE-RECORDING-1 
"A recorded voice says \"Shuttle controls are already activated.\"">

<GLOBAL SHUTTLE-RECORDING-2
"A recorded voice says \"Use other control cabin. Control activation
overridden.\"">

<GLOBAL SHUTTLE-RECORDING-3
"A recording of a deep male voice says \"Shuttle controls activated.\"">

<GLOBAL SHUTTLE-RECORDING-4
"A recorded voice says \"Shuttle controls are not currently activated.\"">

<ROUTINE I-TURNOFF-SHUTTLE ()
	 <COND (,SHUTTLE-MOVING
		<ENABLE <QUEUE I-TURNOFF-SHUTTLE 80>>)
	       (T
		<SETG SHUTTLE-ON <>>)>
	 <RFALSE>>

<GLOBAL LEVER-SETTING 0> ;"0 is the center position, 1 the upper, -1 the lower"

<ROUTINE LEVER-F ()
	 <COND (<VERB? PUSH PUSH-UP>
		<COND (,SHUTTLE-ON
		       <COND (<EQUAL? ,LEVER-SETTING 1>
			      <TELL
"The lever is already in the upper position." CR>)
			     (<EQUAL? ,LEVER-SETTING 0>
			      <SETG LEVER-SETTING 1>
			      <ENABLE <QUEUE I-SHUTTLE 1>>
			      <TELL
"The lever is now in the upper position." CR>)
			     (T
			      <SETG LEVER-SETTING 0>
			      <TELL
"The lever is now in the central position." CR>)>)
		      (T
		       <TELL ,SHUTTLE-RECORDING-4 CR>)>)
	       (<VERB? PULL PUSH-DOWN>
		<COND (,SHUTTLE-ON
		       <COND (<EQUAL? ,LEVER-SETTING 1>
			      <SETG LEVER-SETTING 0>
			      <TELL
"The lever is now in the central position." CR>)
			     (<EQUAL? ,LEVER-SETTING 0>
			      <COND (<EQUAL? ,SHUTTLE-VELOCITY 0>
				     <TELL
"The lever immediately pops back to the central position." CR>)
				    (T
				     <SETG LEVER-SETTING -1>
				     <ENABLE <QUEUE I-SHUTTLE 1>>
				     <TELL
"The lever is now in the lower position." CR>)>)
			     (T
			      <TELL
"The lever is already in the lower position." CR>)>)
		      (T
		       <TELL ,SHUTTLE-RECORDING-4 CR>)>)>>

<ROUTINE I-SHUTTLE ()
	 <ENABLE <QUEUE I-SHUTTLE -1>>
	 <COND (<NOT ,SHUTTLE-MOVING>
		<SETG SHUTTLE-MOVING T>
		<FCLEAR ,SHUTTLE-DOOR ,OPENBIT>
		<FCLEAR ,SHUTTLE-DOOR ,INVISIBLE>
		<TELL
"The control cabin door slides shut and the shuttle car begins to move ">
		<COND (<EQUAL? ,LEVER-SETTING 1>
		       <SETG SHUTTLE-VELOCITY <+ ,SHUTTLE-VELOCITY 5>>
		       <TELL
"forward! The display changes to 5." CR>)
		      ;(<EQUAL? ,LEVER-SETTING -1>
		       <TELL "backward. You hear a loud crunch as the
shuttle car runs into the rear wall of the station.">
		       <SETG SHUTTLE-ON <>>
		       <SETG SHUTTLE-MOVING <>>
		       <SETG LEVER-SETTING 0>
		       <SETG SHUTTLE-ON <>>
		       <FSET ,SHUTTLE-DOOR ,INVISIBLE>
		       <FSET ,SHUTTLE-DOOR ,OPENBIT>
		       <DISABLE <INT I-SHUTTLE>>)>)
	       (T
		<COND (<G? ,SHUTTLE-VELOCITY 0>
		       <SETG SHUTTLE-COUNTER <+ ,SHUTTLE-COUNTER 1>>)>
		<COND (<EQUAL? ,LEVER-SETTING 1>
		       <SETG SHUTTLE-VELOCITY <+ ,SHUTTLE-VELOCITY 5>>)
		      (<EQUAL? ,LEVER-SETTING -1>
		       <COND (<G? ,SHUTTLE-VELOCITY 0>
			      <SETG SHUTTLE-VELOCITY <- ,SHUTTLE-VELOCITY 5>>)
			     (T
			      <SETG LEVER-SETTING 0>
			      <TELL
"The shuttle car comes to a stop and the lever pops back to the central
position." CR>)>)>
		<COND (<EQUAL? ,SHUTTLE-COUNTER 24>
		       <DESCRIBE-SHUTTLE-ARRIVE>)
		      (<G? ,SHUTTLE-VELOCITY 0>
		       <DESCRIBE-SHUTTLE-TRIP>
		       <RTRUE>)>)>>

<ROUTINE DESCRIBE-SHUTTLE-TRIP ()
	 <TELL
"The shuttle car continues to move. The display ">
	 <COND (<EQUAL? ,LEVER-SETTING 0>
		<TELL "still reads ">)
	       (T
		<TELL "blinks, and now reads ">)>
	 <TELL N ,SHUTTLE-VELOCITY>
	 <TELL "." CR>
	 <COND (<EQUAL? ,SHUTTLE-COUNTER 2>
		<TELL
"You pass a sign which says \"Limit 45.\"" CR>)>
	 <COND (<EQUAL? ,SHUTTLE-COUNTER 12>
		<TELL
"The tunnel levels out and begins to slope upward. A sign flashes by which
reads \"Hafwaa Mark -- Beegin Deeseluraashun.\"" CR>)>
	 <COND (<EQUAL? ,SHUTTLE-COUNTER 20>
		<TELL ,SIGN-PASS>
		<TELL "\"15.\"" CR>)>
	 <COND (<EQUAL? ,SHUTTLE-COUNTER 21>
		<TELL ,SIGN-PASS>
		<TELL "\"10.\"" CR>)>
	 <COND (<EQUAL? ,SHUTTLE-COUNTER 22>
		<TELL ,SIGN-PASS>
		<TELL "\"5.\"" CR>)>
	 <COND (<EQUAL? ,SHUTTLE-COUNTER 23>
		<TELL
"The shuttle car is approaching a brightly-lit area. As you near it, you
make out the concrete platforms of a shuttle station." CR>)>>

<GLOBAL ALFIE-BROKEN <>>

<GLOBAL BETTY-BROKEN <>>

<ROUTINE DESCRIBE-SHUTTLE-ARRIVE ()
	 <COND (<EQUAL? ,SHUTTLE-COUNTER 24>
		<COND (<EQUAL? ,SHUTTLE-VELOCITY 0>
		       <TELL
"The shuttle car glides into the station and comes to rest at the concrete
platform. You hear the cabin doors slide open." CR>)
		      (<L? ,SHUTTLE-VELOCITY 20>
		       <COND (<EQUAL? ,HERE ,ALFIE-CONTROL-EAST
				            ,ALFIE-CONTROL-WEST>
			      <SETG ALFIE-BROKEN T>)
			     (T
			      <SETG BETTY-BROKEN T>)>
		       <TELL
"The shuttle car rumbles through the station and smashes into the wall at
the far end. You are thrown forward into the control panel. Both you
and the shuttle car produce unhealthy crunching sounds as the cabin
doors creak slowly open." CR>)
		      (T
		       <JIGS-UP
"The shuttle car hurtles past the platforms and rams into the wall at the
far end of the station. The shuttle car is destroyed, but you're in no
condition to care.">)>
		<SETG SHUTTLE-VELOCITY 0>
		<SETG SHUTTLE-MOVING <>>
		<SETG SHUTTLE-COUNTER 0>
		<SETG LEVER-SETTING 0>
		<SETG SHUTTLE-ON <>>
		<FSET ,SHUTTLE-DOOR ,INVISIBLE>
		<FSET ,SHUTTLE-DOOR ,OPENBIT>
		<DISABLE <INT I-SHUTTLE>>
		<COND (<EQUAL? ,HERE ,ALFIE-CONTROL-EAST ,ALFIE-CONTROL-WEST>
		       <COND (,ALFIE-AT-KALAMONTEE
			      <SETG ALFIE-AT-KALAMONTEE <>>)
			     (T
			      <SETG ALFIE-AT-KALAMONTEE T>)>)
		      (T
		       <COND (,BETTY-AT-KALAMONTEE
			      <SETG BETTY-AT-KALAMONTEE <>>)
			     (T
			      <SETG BETTY-AT-KALAMONTEE T>)>)>)>>

<GLOBAL SIGN-PASS
"You pass a sign, surrounded by blinking red lights, which says ">

^L

"To sleep, perchance to dream..."

<GLOBAL SLEEPY-LEVEL 0>

<ROUTINE I-SLEEP-WARNINGS ()
	 <SETG SLEEPY-LEVEL <+ ,SLEEPY-LEVEL 1>>
	 <COND (<IN? ,ADVENTURER ,BED>
		<TELL CR
"You suddenly realize how tired you were and how comfortable the bed is.
You should be asleep in no time." CR>
		<DISABLE <INT I-SLEEP-WARNINGS>>
		<ENABLE <QUEUE I-FALL-ASLEEP 16>>
		<RTRUE>)>
	 <COND (<EQUAL? ,SLEEPY-LEVEL 1>
		<TELL CR
"You begin to feel weary. It might be time to think about finding
a nice safe place to sleep." CR>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 400>>)
	       (<EQUAL? ,SLEEPY-LEVEL 2>
		<TELL CR
"You're really tired now. You'd better find a place to sleep real soon." CR>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 135>>)
	       (<EQUAL? ,SLEEPY-LEVEL 3>
		<TELL CR
"If you don't get some sleep soon you'll probably drop." CR>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 60>>)
	       (<EQUAL? ,SLEEPY-LEVEL 4>
		<TELL CR "You can barely keep your eyes open." CR>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 50>>)
	       (<EQUAL? ,SLEEPY-LEVEL 5>
		<COND (<EQUAL? ,HERE ,BED>
		       <TELL CR
"You slowly sink into a deep and blissful sleep." CR>
		       <DREAMING>)
		      (<OR <EQUAL? ,HERE ,DORM-A ,DORM-B>
			   <EQUAL? ,HERE ,DORM-C ,DORM-D>>
		       <TELL CR
"You climb into one of the bunk beds and immediately fall asleep." CR>
		       <MOVE ,ADVENTURER ,BED>
		       <DREAMING>)
		      (T
		       <TELL CR
"You can't stay awake a moment longer. You drop to the ground and fall
into a deep but fitful sleep." CR>
		       <COND (<OR <AND <EQUAL? ,DAY 1>
				       <EQUAL? ,HERE ,CRAG>>
				  <AND <EQUAL? ,DAY 3>
				       <EQUAL? ,HERE ,BALCONY>>
				  <AND <EQUAL? ,DAY 5>
				       <EQUAL? ,HERE ,WINDING-STAIR>>>
			      <JIGS-UP
"|
|
|
Suddenly, in the middle of the night, a wave of water washes over you. Before
you can quite get your bearings, you drown.">)
			     (<PROB 30>
			      <JIGS-UP
"|
|
|
Suddenly, in the middle of the night, you awake as several ferocious beasts
(could they be grues?) surround and attack you. Perhaps you should have found
a slightly safer place to sleep.">)
			     (T
			      <DREAMING>)>)>)>>

<OBJECT BED
	(IN LOCAL-GLOBALS)
	(DESC "bed")
	(SYNONYM BUNK BED)
	(ADJECTIVE MULTI TIERED BUNK)
	(FLAGS NDESCBIT CLIMBBIT VEHBIT)
	(ACTION BED-F)>

<ROUTINE BED-F ("OPTIONAL" (RARG ,M-OBJECT))
	 <COND (<AND <VERB? WALK>
		     <EQUAL? .RARG ,M-BEG>>
		<TELL "You'll have to stand up, first." CR>)
	       (<AND <VERB? TAKE OPEN CLOSE RUB>
		     <EQUAL? .RARG ,M-BEG>
		     <NOT <EQUAL? ,PRSO ,BED>>>
		<TELL "You can't reach it from here." CR>)
	       (.RARG
		<RFALSE>)
	       (<VERB? THROUGH BOARD WALK-TO>
		<COND (<EQUAL? ,HERE ,INFIRMARY>
		       <JIGS-UP
"You climb into the bed. It is soft and comfortable. After a few moments, a
previously unseen panel opens, and a diagnostic robot comes wheeling out. It
is very rusty and sways unsteadily, bumping into several pieces of infirmary
equipment as it crosses the room. As the robot straps you to the bed, you
notice some smoke curling from its cracks. Beeping happily, the robot injects
you with all 347 serums and medicines it carries. The last thing you notice
before you pass out is the robot preparing to saw your legs off.">)
		      (<G? ,SLEEPY-LEVEL 0>
		       <MOVE ,ADVENTURER ,BED>
		       <ENABLE <QUEUE I-FALL-ASLEEP 16>>
		       <DISABLE <INT I-SLEEP-WARNINGS>>
		       <TELL 
"Ahhh...the bed is soft and comfortable. You should be asleep in short
order." CR>)
		      (T
		       <MOVE ,ADVENTURER ,BED>
		       <TELL "You are now in bed." CR>)>)
	       (<AND <VERB? DISEMBARK STAND EXIT DROP>
		     <GET <INT I-FALL-ASLEEP> ,C-TICK>>
		<TELL
"How could you suggest such a thing when you're so tired and this
bed is so comfy?" CR>)
	       (<VERB? LEAVE EXIT DROP>
		<PERFORM ,V?DISEMBARK ,BED>
		<RTRUE>)
	       (<AND <VERB? PUT> <EQUAL? ,BED ,PRSI>>
		<MOVE ,PRSO ,HERE>
		<TELL
"The " D ,PRSO " bounces off the bed and lands on the floor." CR>)>>

<ROUTINE I-FALL-ASLEEP ()
	 <TELL CR "You slowly sink into a deep and restful sleep." CR>
	 <DISABLE <INT I-FALL-ASLEEP>>
	 <DREAMING>>

<ROUTINE DREAMING ()
	 <COND (<AND <FSET? ,FORK ,TOUCHBIT>
		     <PROB 13>>
		<TELL
"You are in a busy office crowded with people. The only one you
recognize is Floyd. He rushes back and forth between the desks, carrying
papers and delivering coffee. He notices you, and asks how your project
is coming, and whether you have time to tell him a story. You look into
his deep, trusting eyes..." CR>)
	       (<PROB 60>
		<CRLF>
		<TELL <PICK-ONE ,DREAMS> CR>)>
	 <WAKING-UP>>

<GLOBAL DREAMS
	<PLTABLE

"...You find yourself on the bridge of the Feinstein. Ensign Blather is here,
as well as Admiral Smithers. You are diligently scrubbing the control panel.
Blather keeps yelling at you to scrub harder. Suddenly you hit the ship's
self-destruct switch! Smithers and Blather howl at you as the ship begins
exploding! You try to run, but your feet seem to be fused to the deck..."

"...You gulp down the last of your Ramosian Fire Nectar and ask the
andro-waiter for another pitcher. This pub makes the finest Nectar on
all of Ramos Two, and you and your shipmates are having a pretty rowdy
time. Through the windows of the pub you can see a mighty, ancient castle,
shining in the light of the three Ramosian moons. The Fire Nectar spreads
through your blood and you begin to feel drowsy..."

"...Strangely, you wake to find yourself back home on Gallium. Even more
strangely, you are only eight years old again. You are playing with your
pet sponge-cat, Swanzo, on the edge of the pond in your backyard. Mom is
hanging orange towels on the clothesline. Suddenly the school bully jumps
out from behind a bush, grabs you, and pushes your head under the water.
You try to scream, but cannot. You feel your life draining away..."

"...Your vision slowly returns. You are on a wooded cliff overlooking
a waterfall. A rainbow spans the falls. Blather stands above you, bellowing
that the ground is filthy -- scrub harder! You throw your brush at Blather,
but it passes thru him as though he were a ghost, and sails over the cliff.
Blather leaps after the valuable piece of Patrol property, and both plummet
into the void..."

"...At last, the Feinstein has arrived at the historic Nebulon system. It's
been five months since the last shore leave, and you're anxious for
Planetfall. You and some other Ensigns Seventh Class enter the shuttle for
surfaceside. Suddenly, you're alone on the shuttle, and it's tumbling out of
control! It lands in the ocean and begins sinking! You try to clamber out,
but you are stuck in a giant spider web. A giant spider crawls closer and
closer...">> 

<ROUTINE WAKING-UP ("AUX" X N)
	 <SETG DAY <+ ,DAY 1>>
	 <SETG SICKNESS-WARNING-FLAG T>
	 <SETG SLEEPY-LEVEL 0>
	 <RESET-TIME>
	 <SET X <FIRST? ,ADVENTURER>>
	 <REPEAT ()
		 <COND (.X
			<SET N <NEXT? .X>>
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <MOVE .X ,HERE>)>
			<COND (<AND <EQUAL? .X ,CANTEEN>
				    <IN? ,HIGH-PROTEIN ,CANTEEN>
				    <FSET? ,CANTEEN ,OPENBIT>>
			       <REMOVE ,HIGH-PROTEIN>)>
			<COND (<AND <EQUAL? .X ,FLASK>
				    <IN? ,CHEMICAL-FLUID ,FLASK>>
			       <REMOVE ,CHEMICAL-FLUID>)>
			<SET X .N>)
		       (T
			<RETURN>)>>
	 <TELL
"|
***** SEPTEM " N <+ ,DAY 5> ", 11344 *****|
|">
	 <COND (<NOT <IN? ,ADVENTURER ,BED>>
		<TELL
"You wake and slowly stand up, feeling stiff from your
night on the floor.">)
	       (<L? ,SICKNESS-LEVEL 3>
		<TELL
"You wake up feeling refreshed and ready to face the challenges of this
mysterious world.">)
	       (<L? ,SICKNESS-LEVEL 6>
		<TELL
"You wake after sleeping restlessly. You feel weak and listless.">)
	       (T
		<TELL
"You wake feeling weak and worn-out. It will be an effort just to stand up.">)>
	 <COND (<G? ,HUNGER-LEVEL 0>
		<SETG HUNGER-LEVEL 4>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 100>>
		<TELL
" You are also incredibly famished. Better get some breakfast!">)
	       (T
		<ENABLE <QUEUE I-HUNGER-WARNINGS 400>>)>
	 <CRLF>
	 <COND (<AND <FSET? ,FLOYD ,RLANDBIT>
		     ,FLOYD-INTRODUCED>
		<MOVE ,FLOYD ,HERE>
		<SETG FLOYD-SPOKE T>
		<COND (<IN? ,ADVENTURER ,BED>
		       <TELL
"Floyd bounces impatiently at the foot of the bed. \"About time you woke
up, you lazy bones! Let's explore around some more!\"" CR>)
		      (T
		       <TELL
"Floyd gives you a nudge with his foot and giggles. \"You sure look silly
sleeping on the floor,\" he says." CR>)>)>>

<ROUTINE RESET-TIME ()
	 <COND (<EQUAL? ,DAY 2>
		<FCLEAR ,BALCONY ,TOUCHBIT>
		<SETG INTERNAL-MOVES <+ 1600 <RANDOM 80>>>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 5800>>)
	       (<EQUAL? ,DAY 3>
		<FCLEAR ,BALCONY ,TOUCHBIT>
		<SETG INTERNAL-MOVES <+ 1750 <RANDOM 80>>>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 5550>>)
	       (<EQUAL? ,DAY 4>
		<FCLEAR ,WINDING-STAIR ,TOUCHBIT>
		<SETG INTERNAL-MOVES <+ 1950 <RANDOM 80>>>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 5200>>)
	       (<EQUAL? ,DAY 5>
		<FCLEAR ,WINDING-STAIR ,TOUCHBIT>
		<SETG INTERNAL-MOVES <+ 2150 <RANDOM 80>>>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 4800>>)
	       (<EQUAL? ,DAY 6>
		<FCLEAR ,COURTYARD ,TOUCHBIT>
		<SETG INTERNAL-MOVES <+ 2450 <RANDOM 80>>>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 4300>>)
	       (<EQUAL? ,DAY 7>
		<FCLEAR ,COURTYARD ,TOUCHBIT>
		<SETG INTERNAL-MOVES <+ 2800 <RANDOM 80>>>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 3700>>)
	       (<EQUAL? ,DAY 8>
		<SETG INTERNAL-MOVES <+ 3200 <RANDOM 80>>>
		<ENABLE <QUEUE I-SLEEP-WARNINGS 3000>>)
	       (<EQUAL? ,DAY 9>
		<JIGS-UP
"Unfortunately, you don't seem to have survived the night.">)>>

^L

"Feed me!"

<GLOBAL HUNGER-LEVEL 0>

<ROUTINE I-HUNGER-WARNINGS ()
	 <SETG HUNGER-LEVEL <+ ,HUNGER-LEVEL 1>>
	 <COND (<EQUAL? ,HUNGER-LEVEL 1>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 450>>
		<TELL CR
"A growl from your stomach warns that you're getting pretty hungry and
thirsty." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 2>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 150>>
		<TELL CR
"You're now really ravenous and your lips are quite parched." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 3>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 100>>
		<TELL CR
"You're starting to feel faint from lack of food and liquid." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 4>
		<ENABLE <QUEUE I-HUNGER-WARNINGS 50>>
		<TELL CR
"If you don't eat or drink something in a few millichrons, you'll probably
pass out." CR>)
	       (<EQUAL? ,HUNGER-LEVEL 5>
		<JIGS-UP
"|
You collapse from extreme thirst and hunger.">)>>

<GLOBAL NOT-HUNGRY "Thanks, but you're not hungry.">

^L

"Sickness and disease"

<GLOBAL SICKNESS-LEVEL 0>

<GLOBAL SICKNESS-WARNING-FLAG <>>

<ROUTINE I-SICKNESS-WARNINGS ()
	 <ENABLE <QUEUE I-SICKNESS-WARNINGS 700>>
	 <COND (,SICKNESS-WARNING-FLAG
		<SETG SICKNESS-WARNING-FLAG <>>
		<SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>
		<SETG SICKNESS-LEVEL <+ ,SICKNESS-LEVEL 1>>
		<COND (<EQUAL? ,SICKNESS-LEVEL 1>
		       <TELL CR
"You notice that you feel a bit weak and slightly flushed,
but you're not sure why." CR>)
		      (<EQUAL? ,SICKNESS-LEVEL 2>
		       <TELL CR
"You notice that you feel unusually weak, and you suspect
that you have a fever." CR>)
		      (<EQUAL? ,SICKNESS-LEVEL 3>
		       <TELL CR
"You are now feeling quite under the weather, not unlike a bad flu." CR>)
		      (<EQUAL? ,SICKNESS-LEVEL 4>
		       <TELL CR
"Your fever seems to have gotten worse, and you're
developing a bad headache." CR>)
		      (<EQUAL? ,SICKNESS-LEVEL 5>
		       <TELL CR
"Your health has deteriorated further. You feel hot and weak, and your
head is throbbing." CR>)
		      (<EQUAL? ,SICKNESS-LEVEL 6>
		       <TELL CR
"You feel very, very sick, and have almost no strength left." CR>)
		      (<EQUAL? ,SICKNESS-LEVEL 7>
		       <TELL CR
"You feel like you're on fire, burning up from the fever. You're almost too
weak to move, and your brain is reeling from the pounding headache." CR>)
		      (<EQUAL? ,SICKNESS-LEVEL 8>
		       <TELL CR
"You're no longer sure of where you are and what you're doing. You stumble
about, your pain subsiding into a dull numbness." CR>)
		      (<EQUAL? ,SICKNESS-LEVEL 9>
		       <JIGS-UP
"|
You finally succumb to the ravages of your illness and collapse.">)>)>>

"Oh, Boy! Pseudo objects!"

<ROUTINE TRANSLATOR-PSEUDO ()
	 <COND (<IN? ,AMBASSADOR ,HERE>
		<COND (<VERB? TAKE>
		       <TELL
"The ambassador whimpers and slaps your wrist." CR>)
		      (<VERB? MUNG>
		       <TELL
"Are you trying to create an interplanetary incident?" CR>)>)
	       (T
		<TELL "What translator?" CR>)>>

<ROUTINE SLIME-PSEUDO ()
	 <COND (<OR <IN? ,AMBASSADOR ,HERE>
		     <G? ,AMBASSADOR-LEAVE 0>>
		<COND (<VERB? EAT TASTE>
		       <LIKE-SLIME "tastes">)
		      (<VERB? TAKE RUB>
		       <LIKE-SLIME "feels">)
		      (<VERB? EXAMINE>
		       <LIKE-SLIME "looks">)
		      (<VERB? SMELL>
		       <LIKE-SLIME "smells">)
		      (<VERB? SCRUB REMOVE>
		       <TELL
"Whew. You've cleaned up maybe one ten-thousandth of the slime.">
		       <COND (<NOT <IN? ,BLATHER ,HERE>>
			      <TELL
" If you hurry, it might be all cleaned up before Ensign Blather gets here.">)>
		       <CRLF>)>)
	       (T
		<TELL "What slime?" CR>)>>

<ROUTINE LIKE-SLIME (STRING)
	 <TELL "It ">
	 <TELL .STRING>
	 <TELL " like slime. Aren't you glad you didn't step in it?" CR>>

<ROUTINE GRAFFITI-PSEUDO ()
	 <COND (<VERB? READ>
		<SETG C-ELAPSED 28>
		<TELL "All the graffiti seem to be about Blather. One of
the least obscene items reads:|
|
There once was a krip, name of Blather|
Who told a young Ensign named Smather|
\"I'll make you inherit|
A trotting demerit|
And ship you off to those stinking fawg-infested tar-pools of Krather.\"|
|
It's not a very good limerick, is it?" CR>)>>

<ROUTINE DOOR-PSEUDO ()
	 <COND (<VERB? OPEN UNLOCK>
		<TELL "No way, Jose." CR>)>>

<ROUTINE WALKWAY-PSEUDO ()
	 <COND (<VERB? EXAMINE LAMP-ON>
		<TELL "The walkway, which hastened the trip down that
long corridor, is no longer in service." CR>)>>

<ROUTINE BENCH-PSEUDO ()
	 <COND (<VERB? CLIMB-ON BOARD>
		<TELL "The benches look uncomfortable." CR>)>>

<ROUTINE CATWALK-PSEUDO ()
	 <COND (<VERB? CLIMB-ON CLIMB-UP CLIMB-FOO>
		<TELL "The catwalks are too high for you to access." CR>)>>

<ROUTINE EQUIPMENT-PSEUDO ()
	 <COND (<VERB? EXAMINE RUB LAMP-ON LAMP-OFF>
		<TELL
"The equipment here is so complicated that you couldn't even begin to
figure out how to operate it." CR>)>>

<ROUTINE MONITORS-PSEUDO ()
	 <COND (<VERB? EXAMINE READ>
		<DESCRIBE-MONITORS>)>>

<ROUTINE MURAL-PSEUDO ()
	 <COND (,COMPUTER-FIXED
		<ANYMORE>)
	       (T
		<COND (<VERB? EXAMINE>
		       <TELL
"It's a gaudy work of orange and purple abstract shapes, reminiscent of the
early works of Burstini Bonz. It doesn't appear to fit the decor of the room
at all. The mural seems to ripple now and then, as though a breeze were
blowing behind it." CR>)
		      (<VERB? MUNG>
		       <TELL "My sentiments also, but let's be civil." CR>)
		      (<VERB? MOVE LOOK-BEHIND>
		       <TELL "It won't budge." CR>)>)>>

<ROUTINE LOGO-PSEUDO ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The logo shows a flame burning over a sleep chamber of some type. Under
that is the phrase \"Prajekt Kuntrool.\"" CR>)>>

<ROUTINE KEYBOARD-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is a standard numeric keyboard with ten keys labelled from 0
through 9." CR>)>>

<ROUTINE CRACK-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The crack is too small to go through, but large enough to look through." CR>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,RADIATION-LAB>
		       <TELL
"You see a dimly lit Bio Lab. Sinister shapes lurk about within." CR>)
		      (T
		       <TELL
"You see a laboratory suffused with a pale blue glow." CR>)>)>>

<ROUTINE VOID-PSEUDO ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<PERFORM ,V?THROW-OFF ,PRSO ,STRIP>
		<RTRUE>)
	       (<AND <VERB? ZAP>
		     <EQUAL? ,PRSO ,LASER>
		     <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<SETG PRSI <>>
		<PERFORM ,V?ZAP ,LASER>
		<RTRUE>)
	       (<VERB? THROUGH LEAP>
		<JIGS-UP "Plummet.">)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL
"The void extends downward into the gloom far below." CR>)>>

<ROUTINE SPOUT-PSEUDO ()
	 <COND (<AND <VERB? PUT-UNDER>
		     <EQUAL? ,PRSO ,CANTEEN>>
		<PERFORM ,V?PUT ,CANTEEN ,DISPENSER>
		<RTRUE>)
	       (<AND <VERB? LOOK-UNDER>
		     <IN? ,CANTEEN ,DISPENSER>>
		<TELL "The canteen is sitting under the spout." CR>)>>

<ROUTINE TOILET-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "The fixtures are all dry and dusty." CR>)
	       (<VERB? FLUSH>
		<TELL "The water seems to be turned off." CR>)>>

<ROUTINE GAMES-PSEUDO ()
	 <COND (<VERB? PLAY>
		<PERFORM ,V?PLAY ,GLOBAL-GAMES>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "All the usual games -- Chess, Cribbage, Galactic
Overlord, Double Fannucci..." CR>)
	      ;(<AND <VERB? SHOW>
		     <EQUAL? ,PRSI ,FLOYD>>
		<TELL
"\"Floyd doesn't like those tough, thinker games. Any paddleball sets
around?\"" CR>)>>

<ROUTINE TAPES-PSEUDO ()
	 <COND (<VERB? READ PLAY TAKE>
		<TELL
"Hardly the time or place for reading recreational tapes." CR>)
	       (<VERB? EXAMINE>
		<TELL "Let's see...here are some musical selections, here are
some bestselling romantic novels, here is a biography of a famous Double
Fannucci champion..." CR>)>>

<ROUTINE PARTITION-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "The partitions are very plain, and were
obviously intended to separate this huge room into smaller areas." CR>)>>

<ROUTINE CUBBYHOLE-PSEUDO ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The cubbyholes look like the kind that are used to hold maps or
blueprints. They are all empty now." CR>)>>

<ROUTINE MAPS-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "Examining the maps reveals no new information." CR>)>>

<ROUTINE DEVICES-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"They are components of disassembled robots, beyond repair." CR>)>>

<ROUTINE CABLES-PSEUDO ()
	 <COND (<VERB? EXAMINE FOLLOW>
		<TELL
"These heavy cables merely run from the two consoles up into the ceiling." CR>)
	       (<VERB? MUNG>
		<JIGS-UP
"So, that's what it's like to have twenty million volts run through your
body!">)>>

<ROUTINE STRUCTURE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"You'd be able to tell more about it if you climbed up to it." CR>)
	       (<VERB? CLIMB-UP>
		<DO-WALK ,P?UP>)>>

<ROUTINE BUTTON-PSEUDO ()
	 <COND (<VERB? PUSH>
		<COND (<FSET? ,DISPENSER ,MUNGEDBIT>
		       <TELL
"The dispenser sputters a few times." CR>)
		      (<IN? ,CANTEEN ,DISPENSER>
		       <COND (<NOT <FSET? ,CANTEEN ,OPENBIT>>
			      <TELL
"A thick, brown liquid spills over the closed canteen, dribbles down the side
of the machine, and forms a puddle on the floor which quickly dries up." CR>)
			      (<IN? ,HIGH-PROTEIN ,CANTEEN>
			       <TELL
"The brown liquid splashes over the mouth of the already-filled canteen,
creating a mess">
			       <COND (<FSET? ,PATROL-UNIFORM ,WORNBIT>
				      <TELL " and staining your uniform">)>
			       <TELL "." CR>)
			      (T
			       <MOVE ,HIGH-PROTEIN ,CANTEEN>
			       <TELL
"The canteen fills almost to the brim with a brown liquid." CR>)>)
		      (T
		       <TELL "A thick, brownish liquid pours from the spout
and splashes to the floor, where it quickly evaporates." CR>)>)>>

<ROUTINE CARPET-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's pretty dusty." CR>)>>

<ROUTINE CABINETS-PSEUDO ()
	 <COND (<VERB? EXAMINE OPEN>
		<TELL "The cabinets are locked." CR>)
	       (<VERB? UNLOCK>
		<TELL "You don't have the correct key." CR>)>>

<ROUTINE PLATE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "The plates seem to be featureless metal squares." CR>)>>

<ROUTINE ESCALATOR-PSEUDO ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<COND (<EQUAL? ,HERE ,FORK>
		       <TELL
"You're already at the top of the escalator." CR>)
		      (T
		       <DO-WALK ,P?UP>)>)
	       (<VERB? CLIMB-DOWN>
		<COND (<EQUAL? ,HERE ,LAWANDA-PLATFORM>
		       <TELL
"You're already at the bottom of the escalator." CR>)
		      (T
		       <DO-WALK ,P?DOWN>)>)
	       (<VERB? LAMP-ON>
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE REACTOR-BUTTON-PSEUDO ()
	 <COND (<VERB? PUSH>
		<FSET ,REACTOR-ELEVATOR-DOOR ,OPENBIT>
		<ENABLE <QUEUE I-REACTOR-DOOR-CLOSE 30>>
		<TELL
"The metal doors slide open, revealing a small room to the east." CR>)>>

<ROUTINE SUPPLIES-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL "These supplies are of absolutely no use." CR>)>>

<ROUTINE DESK-PSEUDO ()
	 <COND (<VERB? OPEN>
		<TELL "All the drawers are empty." CR>)
	       (<VERB? EXAMINE>
		<TELL "It is bare except for the microfilm reader." CR>)>>

<ROUTINE CRYO-BUTTON-PSEUDO ()
	 <COND (<AND <VERB? PUSH>
		     <NOT ,CRYO-SCORE-FLAG>>
		<ENABLE <QUEUE I-CRYO-ELEVATOR-ARRIVE 100>>
		<DISABLE <INT I-CHASE-SCENE>>
		<FCLEAR ,CRYO-ELEVATOR-DOOR ,OPENBIT>
	        <SETG CRYO-SCORE-FLAG T>
		<SETG SCORE <+ ,SCORE 5>>
		<TELL
"The elevator door closes just as the monsters reach it! You slump
back against the wall, exhausted from the chase. The elevator begins
to move downward." CR>)
	       (<AND <VERB? PUSH>
		     ,CRYO-SCORE-FLAG
		     <FSET? ,CRYO-ELEVATOR-DOOR ,OPENBIT>>
		<JIGS-UP
"Stunning. After days of surviving on a hostile, plague-ridden planet, solving
several of Infocom's toughest puzzles, and coming within one move of completing
Planetfall, you blow it all in one amazingly dumb input.|
|
The doors close and the elevator rises quickly to the top of the shaft. The
doors open, and the mutants, which were waiting impatiently in the ProjCon
Office for just such an occurence, happily saunter in and begin munching.">)>>

<ROUTINE CASTLE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "The castle is ancient and crumbling." CR>)>>

<ROUTINE CHEM-SPOUT-PSEUDO ()
	 <COND (<AND <VERB? PUT-UNDER>
		     <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<PERFORM ,V?PUT-UNDER ,PRSO ,CHEMICAL-DISPENSER>
		<RTRUE>)
	       (<AND <VERB? LOOK-UNDER>
		     ,SPOUT-PLACED>
		<TELL "There is ">
		<A-AN>
		<TELL D ,SPOUT-PLACED " under the spout." CR>)>>

<ROUTINE CLEFT-PSEUDO ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<DO-WALK ,P?UP>)>>

<ROUTINE RUBBLE-PSEUDO ()
	 <COND (<VERB? MOVE>
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE PLAQUE-PSEUDO ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"|
SEENIK VISTA
|
Xis stuneeng vuu uf xee Kalamontee Valee kuvurz oovur fortee skwaar miilz
uf xat faamus tuurist spot. Xee larj bildeeng at xee bend in xee Gulmaan Rivur
iz xee formur pravincul kapitul bildeeng." CR>)>>

<ROUTINE FENCE-PSEUDO ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO LEAP>
		<TELL "You can't." CR>)>>

<ROUTINE LOCK-PSEUDO ()
	 <COND (<VERB? OPEN UNLOCK>
		<COND (,PRSI
		       <TELL "That won't unlock it." CR>)
		      (T
		       <TELL "But you don't have the orange key!" CR>)>)>>

<ROUTINE DIAGRAM-PSEUDO ()
	 <COND (<VERB? READ>
		<TELL "Not unless you've taken a special
twelve-year course in ninth-order molecular physics." CR>)>>

<ROUTINE ENUNCIATOR-PSEUDO ()
	 <COND (<VERB? LOOK-INSIDE PUSH MOVE>
		<TELL <PICK-ONE ,YUKS>>)>>

<ROUTINE NEAR-BOOTH-PSEUDO ()
	 <COND (<VERB? DROP EXIT DISEMBARK>
		<TELL "You're not in the booth!" CR>)
	       (<VERB? THROUGH BOARD WALK-TO>
		<DO-WALK ,P?IN>)>>

<ROUTINE IN-BOOTH-PSEUDO ()
	 <COND (<VERB? THROUGH BOARD WALK-TO>
		<TELL "You're already in the booth!" CR>)
	       (<VERB? DROP EXIT DISEMBARK>
		<DO-WALK ,P?OUT>)>>