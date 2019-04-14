"COMPTWO for PLANETFALL 
(C) COPYRIGHT 1983 INFOCOM, INC. ALL RIGHTS RESERVED

This file contains all the rooms, objects, and actions associated
with Complex Two / the Eastern Complex / the Lawanda Compleks."

<ROOM LAWANDA-PLATFORM
      (IN ROOMS)
      (DESC "Lawanda Platform")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"    30
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH PER SHUTTLE-ENTER-F)
      (SOUTH PER SHUTTLE-ENTER-F)
      (EAST TO ESCALATOR)
      (UP TO ESCALATOR)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (VALUE 4)
      (GLOBAL GLOBAL-SHUTTLE STAIRS)
      (PSEUDO "ESCALATOR" ESCALATOR-PSEUDO)
      (ACTION LAWANDA-PLATFORM-F)>

<GLOBAL LAWANDA-PLATFORM-FLAG <>>

<ROUTINE LAWANDA-PLATFORM-F (RARG)
	 <COND (<NOT ,LAWANDA-PLATFORM-FLAG>
		<SETG LAWANDA-PLATFORM-FLAG T>
		<SETG SICKNESS-WARNING-FLAG T>)>
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "This is a wide, flat strip of concrete. ">
		<COND (<AND <NOT ,ALFIE-AT-KALAMONTEE>
			    <NOT ,BETTY-AT-KALAMONTEE>>
		       <TELL
"Open shuttle cars lie to the north and south.">)
		      (<OR <NOT ,ALFIE-AT-KALAMONTEE>
			   <NOT ,BETTY-AT-KALAMONTEE>>
		       <TELL "An open shuttle car lies to the ">
		       <COND (,ALFIE-AT-KALAMONTEE
			      <TELL "north.">)
			     (T
			      <TELL "south.">)>)>
		<TELL
" A wide escalator, not currently operating, beckons upward at the east end of
the platform. A faded sign reads \"Shutul Platform -- Lawanda Staashun.\"" CR>)>>

<ROOM ESCALATOR
      (IN ROOMS)
      (DESC "Escalator")
      (LDESC
"You are in the middle of a long mechanical stairway. It is not running,
and seems to be in disrepair.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN"15  ;"UP"    30
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (UP TO FORK)
      (EAST TO FORK)
      (DOWN TO LAWANDA-PLATFORM)
      (WEST TO LAWANDA-PLATFORM)
      (GLOBAL STAIRS)
      (PSEUDO "ESCALATOR" ESCALATOR-PSEUDO)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)>

<ROOM FORK
      (IN ROOMS)
      (DESC "Fork")
      (LDESC
"This is a hallway which forks to the northeast and southeast. To the west
is the top of a long escalator.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN"15  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE" 25 ;"EAST" 0 ;"NE"  25  ;"NORTH"  0>)
      (WEST TO ESCALATOR)
      (DOWN TO ESCALATOR)
      (NE TO SYSTEMS-CORRIDOR-WEST)
      (SE TO PROJECT-CORRIDOR-WEST)
      (GLOBAL STAIRS)
      (PSEUDO "ESCALATOR" ESCALATOR-PSEUDO)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)>

^L

"He's dead, Jim"

<ROOM INFIRMARY
      (IN ROOMS)
      (DESC "Infirmary")
      (LDESC 
"You have entered a clean, well-lighted place. There are a number of beds,
some complicated looking equipment, and many shelves that are mostly bare.")
      (C-MOVE  <TABLE
         ;"OUT"25 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE" 25 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SE TO SYSTEMS-CORRIDOR-WEST)
      (OUT TO SYSTEMS-CORRIDOR-WEST)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BED SHELVES)
      (PSEUDO "EQUIPM" EQUIPMENT-PSEUDO "MACHIN" EQUIPMENT-PSEUDO)
      (ACTION INFIRMARY-F)>

<OBJECT LAZARUS-PART
	(DESC "medical robot breastplate")
	(SYNONYM LAZARUS PART BREAST PLATE)
	(ADJECTIVE MEDICAL BREAST)
	(SIZE 35)
	(FLAGS TAKEBIT)>

<GLOBAL LAZARUS-FLAG <>>

<ROUTINE INFIRMARY-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT ,LAZARUS-FLAG>
		     <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,RLANDBIT>
		     <PROB 30>>
		<SETG LAZARUS-FLAG T>
		<MOVE ,LAZARUS-PART ,HERE>
		<MOVE ,FLOYD ,FORK>
		<SETG FLOYD-FOLLOW <>>
		<SETG FLOYD-SPOKE T>
		<TELL
"Floyd, rummaging in a corner, finds something and carries it to the center of
the room to examine it in the brighter light. It seems to be the breast plate
of a robot, along with some connected inner circuitry. The entire piece is
bent and rusting. Floyd stares at it in complete silence. A moment later, he
begins sobbing quietly, awkwardly excuses himself, and runs out of the room.
You look at the breast plate, and notice the name \"Lazarus\" engraved on
it." CR>)>>  

<OBJECT RED-SPOOL
	(IN INFIRMARY)
	(DESC "red spool")
	(FDESC
"Lying on one of the beds is a small red spool.")
	(SYNONYM SPOOL SPOOLS OBJECT)
	(ADJECTIVE RED SMALL)
	(SIZE 3)
	(TEXT
"The spool is labelled \"Simptumz uv Xe Dizeez.\"")
	(FLAGS TAKEBIT ACIDBIT READBIT)
	(ACTION RED-SPOOL-F)>

<ROUTINE RED-SPOOL-F ()
	 <COND (<AND <VERB? TAKE>
		     <IN? ,RED-SPOOL ,SPOOL-READER>
		     <FSET? ,SPOOL-READER ,ONBIT>>
		<MOVE ,RED-SPOOL ,ADVENTURER>
		<FCLEAR ,RED-SPOOL ,TRYTAKEBIT>
		<TELL "The screen goes blank as you take the spool." CR>)>>

<OBJECT MEDICINE-BOTTLE
	(IN INFIRMARY)
	(DESC "medicine bottle")
	(FDESC
"On a low shelf is a translucent bottle with a small white label.")
	(SYNONYM BOTTLE LABEL)
	(ADJECTIVE MEDICINE SMALL WHITE TRANSL)
	(SIZE 7)
	(CAPACITY 7)
	(TEXT
"\"Dizeez supreshun medisin -- eksperimentul\"")
	(FLAGS CONTBIT SEARCHBIT TAKEBIT TRANSBIT READBIT)>

<OBJECT MEDICINE
	(IN MEDICINE-BOTTLE)
	(DESC "quantity of medicine")
	(FDESC "At the bottom of the bottle is a small quantity of medicine.")
	(SYNONYM MEDICINE)
	(ADJECTIVE SMALL QUANTITY EXPERIMENTAL)
	(SIZE 7)
	(FLAGS FOODBIT)
	(ACTION MEDICINE-F)>

<ROUTINE MEDICINE-F ("AUX" (X <>))
	 <COND (<AND <VERB? TASTE EAT POUR>
		     <NOT <IN? ,MEDICINE-BOTTLE ,ADVENTURER>>>
		<SETG PRSO ,MEDICINE-BOTTLE>
		<NOT-HOLDING>
		<THIS-IS-IT ,MEDICINE-BOTTLE>)
	       (<AND <VERB? TASTE EAT POUR>
		     <NOT <FSET? ,MEDICINE-BOTTLE ,OPENBIT>>>
		<TELL "The bottle is closed." CR>)
	       (<VERB? TASTE>
		<TELL "It tastes fairly bitter." CR>)
	       (<VERB? EAT>
		<REMOVE ,MEDICINE>
		<SETG C-ELAPSED 15>
		<SETG SICKNESS-LEVEL <- ,SICKNESS-LEVEL 2>>
		<SETG LOAD-ALLOWED <+ ,LOAD-ALLOWED 20>>
		<TELL "The medicine tasted extremely bitter." CR>)
	       (<VERB? POUR>		
		<REMOVE ,MEDICINE>
		<COND (<NOT ,PRSI>
		       <SETG PRSI ,GROUND>)>
		<COND (<EQUAL? ,PRSI ,FUNNEL-HOLE>
		       <COND (<IN? ,CHEMICAL-FLUID ,FLASK>
			      <SET X T>)>
		       <SETG CHEMICAL-REQUIRED 10>
		       <PERFORM ,V?POUR ,CHEMICAL-FLUID ,FUNNEL-HOLE>
		       <COND (.X
			      <MOVE ,CHEMICAL-FLUID ,FLASK>)>
		       <RTRUE>)
		      (T
		       <TELL
"It pours over the " D ,PRSI " and evaporates." CR>)>)
	       (<AND <VERB? TAKE>
		     <EQUAL? <GET ,P-VTBL 0> ,W?TAKE>>
		<PERFORM ,V?EAT ,MEDICINE>
		<RTRUE>)>>

<ROOM REPAIR-ROOM
      (IN ROOMS)
      (DESC "Repair Room")
      (LDESC
"You are in a dimly lit room, filled with strange machines and wide storage
cabinets, all locked. To the south, a narrow stairway leads upward. On the
north wall of the room is a very small doorway.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"    30
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (UP TO SYSTEMS-CORRIDOR-WEST)
      (SOUTH TO SYSTEMS-CORRIDOR-WEST)
      (NORTH "It is a robot-sized doorway -- a bit too small for you.")
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (GLOBAL STAIRS)
      (PSEUDO "CABINETS" CABINETS-PSEUDO "MACHIN" EQUIPMENT-PSEUDO)>

<GLOBAL ACHILLES-FLAG <>> ;"Set to T when Floyd babbles about Achilles"

<OBJECT ACHILLES
	(IN REPAIR-ROOM)
	(DESC "broken robot")
	(LDESC
"Lying face down at the bottom of the stairs is a motionless robot. It
appears to be damaged beyond repair.")
	(SYNONYM ROBOT ACHILLES)
	(ADJECTIVE BROKEN DEAD)>

<OBJECT ROBOT-HOLE
	(IN REPAIR-ROOM)
	(DESC "small doorway")
	(SYNONYM DOOR DOORWA HOLE)
	(ADJECTIVE SMALL VERY)
	(FLAGS NDESCBIT TRANSBIT CONTBIT)
	(CAPACITY 0)
	(ACTION ROBOT-HOLE-F)>

<ROUTINE ROBOT-HOLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's too small for you to get through. It was presumably intended for
robots, such as the broken repair robot lying over there." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"You can make out a small supply room of some sort." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"There's no door, just an opening in the wall." CR>)>>

<GLOBAL HOLE-TRIP-FLAG <>>

<ROUTINE FLOYD-THROUGH-HOLE ()
	 <COND (,HOLE-TRIP-FLAG
		<TELL "\"Not again,\" whines Floyd." CR>
		<RTRUE>)
	       (T
		<SETG C-ELAPSED 50>
		<SETG HOLE-TRIP-FLAG T>
		<SETG BOARD-REPORTED T>
		<FCLEAR ,GOOD-BOARD ,INVISIBLE>
	        <TELL
"Floyd squeezes through the opening and is gone for quite a while. You hear
thudding noises and squeals of enjoyment. After a while the noise stops, and
Floyd emerges, looking downcast. \"Floyd found a rubber ball inside. Lots of
fun for a while, but must have been old, because it fell apart. Nothing else
interesting inside. Just a shiny fromitz board.\"" CR>)>>

<OBJECT GOOD-BOARD
	(IN ROBOT-HOLE)
	(DESC "shiny seventeen-centimeter fromitz board")
	(SYNONYM BOARD BOARDS)
	(ADJECTIVE SHINY GOOD SEVENTEEN CENTIMETER FROMITZ)
	(SIZE 10)
	(FLAGS ACIDBIT INVISIBLE NDESCBIT)
	(ACTION GOOD-BOARD-F)>

<ROUTINE GOOD-BOARD-F ()
	 <COND (<AND <FSET? ,GOOD-BOARD ,NDESCBIT>
		     <VERB? TAKE EXAMINE RUB PUSH PULL MOVE LOOK-UNDER>
		     <EQUAL? ,GOOD-BOARD ,PRSO>>
		<TELL "You can't see any " D ,PRSO " here." CR>)
	       (<VERB? EXAMINE>
		<EXAMINE-BOARD>
		<CRLF>)>>

<GLOBAL BOARD-REPORTED <>>

<ROOM SYSTEMS-CORRIDOR-WEST
      (IN ROOMS)
      (DESC "Systems Corridor West")
      (LDESC
"The corridor bends here, leading east and southwest. A doorway opens
to the northwest, and a narrow stairway leads down to the north.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN"15  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"  25  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NW TO INFIRMARY)
      (NORTH TO REPAIR-ROOM)
      (DOWN TO REPAIR-ROOM)
      (EAST TO SYSTEMS-CORRIDOR)
      (SW TO FORK)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM SYSTEMS-CORRIDOR
      (IN ROOMS)
      (DESC "Systems Corridor")
      (LDESC
"This section of hallway has a doorway to the north labelled \"Planateree
Deefens.\" The corridor continues east and west.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO PLANETARY-DEFENSE)
      (WEST TO SYSTEMS-CORRIDOR-WEST)
      (EAST TO SYSTEMS-CORRIDOR-EAST)
      (FLAGS RLANDBIT ONBIT)>

<ROOM SYSTEMS-CORRIDOR-EAST
      (IN ROOMS)
      (DESC "Systems Corridor East")
      (LDESC
"The hallway ends here with a large doorway leading east, and smaller doorways
to the north and south. The northern doorway is labelled \"Planateree Kors
Kontrool.\" The hallway itself leads west.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO SYSTEMS-CORRIDOR)
      (SOUTH TO LIBRARY-LOBBY)
      (NORTH TO PLANETARY-COURSE-CONTROL)
      (EAST TO PHYSICAL-PLANT-TWO)
      (FLAGS RLANDBIT ONBIT)>

<ROOM PHYSICAL-PLANT-TWO
      (IN ROOMS)
      (DESC "Physical Plant")
      (LDESC
"This is an enormous room full of environmental control equipment presumably
intended to heat and ventilate the Lawanda Complex. Oddly, although the
Lawanda Complex is slightly smaller than its counterpart, this plant is much
larger than the one in the Kalamontee Complex. The only exit is westward.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO SYSTEMS-CORRIDOR-EAST)
      (OUT TO SYSTEMS-CORRIDOR-EAST)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (PSEUDO "EQUIPM" EQUIPMENT-PSEUDO)>

^L

"Planetary systems and repairs"

<GLOBAL DEFENSE-FIXED <>>

<GLOBAL COURSE-CONTROL-FIXED <>>

<GLOBAL ACCESS-PANEL-FULL T>

<ROOM PLANETARY-DEFENSE
      (IN ROOMS)
      (DESC "Planetary Defense")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH TO SYSTEMS-CORRIDOR)
      (OUT TO SYSTEMS-CORRIDOR)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (GLOBAL CONTROLS LIGHTS)
      (ACTION PLANETARY-DEFENSE-F)>

<ROUTINE PLANETARY-DEFENSE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room is filled with a dazzling array of lights and controls. ">
		<COND (<NOT ,DEFENSE-FIXED>
		       <TELL
"One light, blinking quickly, catches your eye. It reads \"Surkit Boord
Faalyur. WORNEENG: xis boord kuntroolz xe diskriminaashun surkits.\"" >)>
		<TELL" There is a small access panel on one wall which is ">
		<DDESC ,ACCESS-PANEL>
		<TELL "." CR>)>>

<OBJECT ACCESS-PANEL
	(IN PLANETARY-DEFENSE)
	(DESC "access panel")
	(SYNONYM PANEL DOOR SOCKET)
	(ADJECTIVE SMALL ACCESS REPAIR)
	(FLAGS VOWELBIT NDESCBIT CONTBIT SEARCHBIT)
	(CAPACITY 40)
	(ACTION ACCESS-PANEL-F)>

<ROUTINE ACCESS-PANEL-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,ACCESS-PANEL ,OPENBIT>
		       <ALREADY-OPEN>)
		      (T
		       <FSET ,ACCESS-PANEL ,OPENBIT>
		       <TELL "The panel swings open." CR>
		       <PERFORM ,V?LOOK-INSIDE ,ACCESS-PANEL>
		       <RTRUE>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,ACCESS-PANEL ,OPENBIT>
		       <FCLEAR ,ACCESS-PANEL ,OPENBIT>
		       <TELL "The panel swings closed." CR>)
		      (T
		       <IS-CLOSED>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,ACCESS-PANEL>>
		<COND (<NOT <FSET? ,ACCESS-PANEL ,OPENBIT>>
		       <TELL "The panel is closed." CR>)
		      (,ACCESS-PANEL-FULL
		       <TELL "There's no room." CR>)
		      (<EQUAL? ,PRSO ,GOOD-BOARD>
		       <REMOVE ,GOOD-BOARD>
		       <MOVE ,SECOND-BOARD ,ACCESS-PANEL>
		       <THIS-IS-IT ,SECOND-BOARD>
		       <SETG DEFENSE-FIXED T>
		       <SETG SCORE <+ ,SCORE 6>>
		       <SETG ACCESS-PANEL-FULL T>
		       <PUT-BOARD>
		       <TELL " The warning lights stop flashing." CR>)
		      (<EQUAL? ,PRSO ,CRACKED-BOARD ,FRIED-BOARD>
		       <REMOVE ,PRSO>
		       <THIS-IS-IT ,SECOND-BOARD>
		       <MOVE ,SECOND-BOARD ,ACCESS-PANEL>
		       <SETG ACCESS-PANEL-FULL T>
		       <COND (<EQUAL? ,PRSO ,CRACKED-BOARD>
			      <SETG ITS-CRACKED T>)>			      
		       <PUT-BOARD>
		       <CRLF>)
		      (T
		       <TELL "The " D, PRSO " doesn't fit.">)>)>>

<OBJECT FIRST-BOARD
	(IN ACCESS-PANEL)
	(DESC "first seventeen-centimeter fromitz board")
	(SYNONYM BOARD BOARDS)
	(ADJECTIVE FIRST SEVENTEEN CENTIMETER FROMITZ)
	(ACTION BOARD-F)>

<OBJECT FOURTH-BOARD
	(IN ACCESS-PANEL)
	(DESC "fourth seventeen-centimeter fromitz board")
	(SYNONYM BOARD BOARDS)
	(ADJECTIVE FOURTH SEVENTEEN CENTIMETER FROMITZ)
	(ACTION BOARD-F)>

<OBJECT THIRD-BOARD
	(IN ACCESS-PANEL)
	(DESC "third seventeen-centimeter fromitz board")
	(SYNONYM BOARD BOARDS)
	(ADJECTIVE THIRD SEVENTEEN CENTIMETER FROMITZ)
	(ACTION BOARD-F)>
			 
<OBJECT SECOND-BOARD
	(IN ACCESS-PANEL)
	(DESC "second seventeen-centimeter fromitz board")
	(SYNONYM BOARD BOARDS)
	(ADJECTIVE SECOND SEVENTEEN CENTIMETER FROMITZ)
	(FLAGS TRYTAKEBIT TAKEBIT)
	(ACTION BOARD-F)>

<OBJECT FRIED-BOARD
	(DESC "fried seventeen-centimeter fromitz board")
	(SYNONYM BOARD BOARDS)
	(ADJECTIVE FRIED SEVENTEEN CENTIMETER FROMITZ)
	(SIZE 10)
	(FLAGS ACIDBIT TAKEBIT)
	(ACTION FRIED-BOARD-F)>

<ROUTINE FRIED-BOARD-F ()
	 <COND (<VERB? EXAMINE>
		<EXAMINE-BOARD>
		<TELL
" This one is a bit blackened around the edges, though." CR>)>>

<GLOBAL ITS-CRACKED <>>

<ROUTINE BOARD-F ()
	 <COND (<VERB? TAKE>
		<COND (<EQUAL? ,PRSO ,SECOND-BOARD>
		       <COND (,DEFENSE-FIXED
			      <BOARD-SHOCK>)
			     (T
			      <TELL
"The fromitz board slides out of the panel, producing an empty socket
for another board." CR>
			      <REMOVE ,SECOND-BOARD>
			      <SETG ACCESS-PANEL-FULL <>>
			      <COND (<EQUAL? ,ITS-CRACKED T>
				     <MOVE ,CRACKED-BOARD ,ADVENTURER>)
				    (T
				     <MOVE ,FRIED-BOARD ,ADVENTURER>)>
			      <THIS-IS-IT ,FRIED-BOARD>)>)
		      (T
		       <BOARD-SHOCK>)>)
	       (<VERB? EXAMINE>
		<EXAMINE-BOARD>
		<CRLF>)>>

<ROUTINE EXAMINE-BOARD ()
	 <TELL
"Like most fromitz boards, it is a twisted maze of silicon circuits. It is
square, approximately seventeen centimeters on each side.">>

<ROUTINE PUT-BOARD ()
	 <TELL "The card clicks neatly into the socket.">>

<ROUTINE BOARD-SHOCK ()
	 <TELL "You jerk your hand back as you receive a powerful
shock from the fromitz board." CR>>

<ROOM PLANETARY-COURSE-CONTROL
      (IN ROOMS)
      (DESC "Course Control")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH TO SYSTEMS-CORRIDOR-EAST)
      (OUT TO SYSTEMS-CORRIDOR-EAST)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (GLOBAL CONTROLS LIGHTS)
      (ACTION PLANETARY-COURSE-CONTROL-F)>

<ROUTINE PLANETARY-COURSE-CONTROL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a long room whose walls are covered with complicated controls
and colored lights. ">
		<COND (,COURSE-CONTROL-FIXED
		       <TELL
"One blinking light says \"Kors diivurjins minimiizeeng.\"">)
		      (T
		       <TELL
"Two of these lights are blinking. The first one reads \"Bedistur Faalyur!\"
The other light reads \"Kritikul diivurjins frum pland kors.\"">)>
		<TELL " In one corner is a large metal cube whose lid is ">
		<COND (<FSET? ,CUBE ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL "." CR>)>>

<OBJECT CUBE
	(IN PLANETARY-COURSE-CONTROL)
	(DESC "large metal cube")
	(SYNONYM CUBE LID SOCKET)
	(ADJECTIVE LARGE METAL)
	(FLAGS MUNGBIT NDESCBIT CONTBIT SEARCHBIT)
	(ACTION CUBE-F)>

<ROUTINE CUBE-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,CUBE ,OPENBIT>
		       <ALREADY-OPEN>)
		      (T
		       <FSET ,CUBE ,OPENBIT>
		       <TELL "The lid swings open." CR>
		       <PERFORM ,V?LOOK-INSIDE ,CUBE>
		       <RTRUE>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,CUBE ,OPENBIT>
		       <FCLEAR ,CUBE ,OPENBIT>
		       <TELL "The lid swings closed." CR>)
		      (T
		       <IS-CLOSED>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,CUBE>>
		<COND (<NOT <FSET? ,CUBE ,OPENBIT>>
		       <TELL "The cube is closed." CR>) 
		      (<IN? ,BAD-BEDISTOR ,CUBE>
		       <TELL "There's a fused bedistor in the way." CR>)
		      (<EQUAL? ,PRSO ,GOOD-BEDISTOR>
		       <MOVE ,GOOD-BEDISTOR ,CUBE>
		       <COND (<NOT <FSET? ,CUBE ,MUNGEDBIT>>
			      <SETG COURSE-CONTROL-FIXED T>
			      <FSET ,GOOD-BEDISTOR ,TRYTAKEBIT>
			      <SETG SCORE <+ ,SCORE 6>>
			      <TELL
"Done. The warning lights go out and another light goes on." CR>)
			     (T
			      <TELL "Done." CR>)>)
		      (<EQUAL? ,PRSO ,BAD-BEDISTOR>
		       <MOVE ,BAD-BEDISTOR ,CUBE>
		       <TELL "Done." CR>)
		      (T
		       <TELL "The " D, PRSO " doesn't fit.">)>)>>

<OBJECT BAD-BEDISTOR
	(IN CUBE)
	(DESC "fused ninety-ohm bedistor")
	(SYNONYM BEDISTOR)
	(ADJECTIVE FUSED NINETY OHM)
	(SIZE 8)
	(FLAGS ACIDBIT TRYTAKEBIT TAKEBIT)
	(ACTION BAD-BEDISTOR-F)>

<ROUTINE BAD-BEDISTOR-F ()
	 <COND (<AND <VERB? TAKE>
		     <IN? ,BAD-BEDISTOR ,CUBE>>
		<TELL "It seems to be fused to its socket." CR>)
	       (<VERB? ZATTRACT>
		<COND (<EQUAL? ,PRSI ,PLIERS>
		       <MOVE ,BAD-BEDISTOR ,ADVENTURER>
		       <FCLEAR ,BAD-BEDISTOR ,TRYTAKEBIT>
		       <TELL
"With a tug, you manage to remove the fused bedistor." CR>)
		      (T
		       <TELL
"You can't get a grip on the bedistor with that." CR>)>)>>

^L

"The Library"

<ROOM LIBRARY-LOBBY
      (IN ROOMS)
      (DESC "Library Lobby")
      (LDESC 
"This is a carpeted room, thick with dust, with exits to the north and south.
To the west, up a few steps, is a wide doorway. A small booth lies to the
east.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (UP TO LIBRARY)
      (WEST TO LIBRARY)
      (NORTH TO SYSTEMS-CORRIDOR-EAST)
      (SOUTH TO PROJECT-CORRIDOR-EAST)
      (EAST TO BOOTH-3)
      (IN TO BOOTH-3)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (GLOBAL TABLES STAIRS)
      (PSEUDO "CARPET" CARPET-PSEUDO "BOOTH" NEAR-BOOTH-PSEUDO)>

<OBJECT GREEN-SPOOL
	(IN LIBRARY-LOBBY)
	(DESC "green spool")
	(FDESC
"You catch a glimpse of a small object nestled among the dust.")
	(SYNONYM SPOOL SPOOLS OBJECT)
	(ADJECTIVE GREEN SMALL)
	(SIZE 3)
	(TEXT
"The spool is labelled \"Helikoptur Opuraateeng Manyuuwul.\"")
	(FLAGS ACIDBIT TAKEBIT READBIT)
	(ACTION GREEN-SPOOL-F)>

<ROUTINE GREEN-SPOOL-F ()
	 <COND (<AND <VERB? TAKE>
		     <IN? ,GREEN-SPOOL ,SPOOL-READER>
		     <FSET? ,SPOOL-READER ,ONBIT>>
		<MOVE ,GREEN-SPOOL ,ADVENTURER>
		<FCLEAR ,GREEN-SPOOL ,TRYTAKEBIT>
		<TELL "The screen goes blank as you take the spool." CR>)>>

<ROOM BOOTH-3
      (IN ROOMS)
      (DESC "Booth 3")
      (LDESC
"This is a tiny room with a large \"3\" painted on the wall. A panel contains
a slot about ten centimeters wide, a brown button labelled \"1\" and a beige
button labelled \"2.\"")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO LIBRARY-LOBBY)
      (OUT TO LIBRARY-LOBBY)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CONTROLS SLOT TELEPORTATION-BUTTON-1 TELEPORTATION-BUTTON-2)
      (PSEUDO "BOOTH" IN-BOOTH-PSEUDO)>

<ROOM LIBRARY
      (IN ROOMS)
      (DESC "Library")
      (LDESC
"This is a large carpeted room with a desk and many small tables. The sole
exit is down a few steps to the east.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO LIBRARY-LOBBY)
      (OUT TO LIBRARY-LOBBY)
      (FLAGS RLANDBIT ONBIT FLOYDBIT)
      (GLOBAL TABLES STAIRS)
      (PSEUDO "CARPET" CARPET-PSEUDO "DESK" DESK-PSEUDO)>

<OBJECT TERMINAL
	(IN LIBRARY-LOBBY)
	(DESC "terminal")
	(FDESC
"Sitting on a wide table is a machine of sorts, consisting of a video
screen and a keyboard. It is currently turned off.")
	(LDESC
"On the table is a computer terminal.")
	(SYNONYM TERMINAL KEYBOARD SCREEN MACHIN)
	(ADJECTIVE COMPUTER VIDEO)
	(FLAGS LIGHTBIT)
	(ACTION TERMINAL-F)>

<GLOBAL MENU-LEVEL 0>

<ROUTINE TERMINAL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The computer terminal consists of a video display screen, a keyboard with
ten keys numbered from zero through nine, and an on-off switch. ">
		<COND (<FSET? ,TERMINAL ,ONBIT>
		       <TELL
"The screen displays some writing:" CR ,SCREEN-TEXT CR>
		       <COND (<G? ,MENU-LEVEL 9>
			      <TELL ,MORE-INFO CR>)>
		       <RTRUE>)
		      (T
		       <TELL "The screen is dark." CR>)>)
	       (<VERB? READ>
		<COND (<FSET? ,TERMINAL ,ONBIT>
		       <TELL ,SCREEN-TEXT CR>
		       <COND (<G? ,MENU-LEVEL 9>
			      <TELL ,MORE-INFO CR>)>
		       <RTRUE>)
		      (T
		       <TELL "The screen is blank." CR>)>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,TERMINAL ,ONBIT>
		       <TELL "It's already on." CR>)
		      (T
		       <FSET ,TERMINAL ,ONBIT>
		       <FSET ,TERMINAL ,TOUCHBIT>
		       <SETG SCREEN-TEXT ,MAIN-MENU>
		       <TELL
"The screen gives off a green flash, and then some writing appears on
the screen:" CR>
		       <TELL ,SCREEN-TEXT CR>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,TERMINAL ,ONBIT>
		       <FCLEAR ,TERMINAL ,ONBIT>
		       <SETG MENU-LEVEL 0>
		       <TELL "The screen goes dark." CR>)
		      (T
		       <TELL "It isn't on!" CR>)>)>>

<ROUTINE LIBRARY-TYPE ()
	 <COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		<NUMBERS-ONLY>)
	       (<EQUAL? ,MENU-LEVEL 0>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <TELL ,NO-MEANING CR>)
		      (<EQUAL? ,P-NUMBER 1>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,HISTORY-MENU>
		       <TELL ,SCREEN-TEXT CR>
		       <SETG MENU-LEVEL 1>)
		      (<EQUAL? ,P-NUMBER 2>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,CULTURE-MENU>
		       <TELL ,SCREEN-TEXT CR>
		       <SETG MENU-LEVEL 2>)
		      (<EQUAL? ,P-NUMBER 3>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,TECHNOLOGY-MENU>
		       <TELL ,SCREEN-TEXT CR>
		       <SETG MENU-LEVEL 3>)
		      (<EQUAL? ,P-NUMBER 4>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,GEOGRAPHY-MENU>
		       <TELL ,SCREEN-TEXT CR>
		       <SETG MENU-LEVEL 4>)
		      (<EQUAL? ,P-NUMBER 5>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,PROJECT-MENU>
		       <TELL ,SCREEN-TEXT CR>
		       <SETG MENU-LEVEL 5>)
		      (<EQUAL? ,P-NUMBER 6>
		       <SETG MENU-LEVEL 6>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,INTERLOGIC-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (<G? ,P-NUMBER 6>
		       <TELL ,NO-MEANING CR>)>)
	       (<EQUAL? ,MENU-LEVEL 1>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 0>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,MAIN-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (<EQUAL? ,P-NUMBER 1>
		       <SETG MENU-LEVEL 11>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,11-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 2>
		       <SETG MENU-LEVEL 12>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,12-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 3>
		       <SETG MENU-LEVEL 13>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,13-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<G? ,P-NUMBER 3>
		       <TELL ,NO-MEANING CR>)>)
	       (<EQUAL? ,MENU-LEVEL 2>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 0>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,MAIN-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (<EQUAL? ,P-NUMBER 1>
		       <SETG MENU-LEVEL 21>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,21-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 2>
		       <SETG MENU-LEVEL 22>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,22-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 3>
		       <SETG MENU-LEVEL 23>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,23-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<G? ,P-NUMBER 4>
		       <TELL ,NO-MEANING CR>)>)
	       (<EQUAL? ,MENU-LEVEL 3>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 0>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,MAIN-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (<EQUAL? ,P-NUMBER 1>
		       <SETG MENU-LEVEL 31>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,31-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 2>
		       <SETG MENU-LEVEL 32>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,32-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 3>
		       <SETG MENU-LEVEL 33>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,33-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 4>
		       <SETG MENU-LEVEL 34>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,34-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 5>
		       <SETG MENU-LEVEL 35>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,35-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<G? ,P-NUMBER 5>
		       <TELL ,NO-MEANING CR>)>)
	       (<EQUAL? ,MENU-LEVEL 4>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 0>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,MAIN-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (<EQUAL? ,P-NUMBER 1>
		       <SETG MENU-LEVEL 41>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,41-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 2>
		       <SETG MENU-LEVEL 42>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,42-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 3>
		       <SETG MENU-LEVEL 43>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,43-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<G? ,P-NUMBER 3>
		       <TELL ,NO-MEANING CR>)>)
	       (<EQUAL? ,MENU-LEVEL 5>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 0>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,MAIN-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (<EQUAL? ,P-NUMBER 1>
		       <SETG MENU-LEVEL 51>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,51-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 2>
		       <SETG MENU-LEVEL 52>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,52-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 3>
		       <SETG MENU-LEVEL 53>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,53-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<G? ,P-NUMBER 3>
		       <TELL ,NO-MEANING CR>)>)
	       (<EQUAL? ,MENU-LEVEL 6>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 0>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,MAIN-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (<EQUAL? ,P-NUMBER 1>
		       <SETG MENU-LEVEL 61>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,61-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>
		       <COND (<IN? ,FLOYD ,HERE>
			      <SETG FLOYD-SPOKE T>
			      <TELL
"Floyd, peering over your shoulder, says \"Oh, I love that game! Solved every
problem, except couldn't figure out how to get into white house.\"" CR>)>)
		      (<EQUAL? ,P-NUMBER 2>
		       <SETG MENU-LEVEL 62>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,62-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<EQUAL? ,P-NUMBER 3>
		       <SETG MENU-LEVEL 63>
		       <TELL ,TEXT-APPEARS CR>
		       <SETG SCREEN-TEXT ,63-TEXT>
		       <TELL ,SCREEN-TEXT CR>
		       <TELL ,MORE-INFO CR>)
		      (<G? ,P-NUMBER 3>
		       <TELL ,NO-MEANING CR>)>)
	       (<AND <G? ,MENU-LEVEL 10>
		     <L? ,MENU-LEVEL 20>>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 1>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,HISTORY-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (T
		       <TELL ,LOW-END CR>)>)
	       (<AND <G? ,MENU-LEVEL 20>
		     <L? ,MENU-LEVEL 30>>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 2>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,CULTURE-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (T
		       <TELL ,LOW-END CR>)>)
	       (<AND <G? ,MENU-LEVEL 30>
		     <L? ,MENU-LEVEL 40>>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 3>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,TECHNOLOGY-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (T
		       <TELL ,LOW-END CR>)>)
	       (<AND <G? ,MENU-LEVEL 40>
		     <L? ,MENU-LEVEL 50>>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 4>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,GEOGRAPHY-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (T
		       <TELL ,LOW-END CR>)>)
	       (<AND <G? ,MENU-LEVEL 50>
		     <L? ,MENU-LEVEL 60>>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 5>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,PROJECT-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (T
		       <TELL ,LOW-END CR>)>)
	       (<AND <G? ,MENU-LEVEL 60>
		     <L? ,MENU-LEVEL 70>>
		<COND (<EQUAL? ,P-NUMBER 0>
		       <SETG MENU-LEVEL 6>
		       <TELL ,SCREEN-CLEARS CR>
		       <SETG SCREEN-TEXT ,INTERLOGIC-MENU>
		       <TELL ,SCREEN-TEXT CR>)
		      (T
		       <TELL ,LOW-END CR>)>)>>

<GLOBAL SCREEN-TEXT <>>

<GLOBAL NO-MEANING "The terminal feeps, and a message briefly appears on the
screen explaining that typing that character has no meaning at the moment.">

<GLOBAL SCREEN-CLEARS "The screen clears and a different menu appears:|">

<GLOBAL TEXT-APPEARS "The screen clears and some text appears:|">

<GLOBAL MORE-INFO
"|
\"Foor moor deetaald infoormaashun on xis tapik, konsult xe
liibrereein foor xe aproopreeit spuulz. Tiip zeeroo tuu goo tuu
aa hiiyur levul.\"">

<GLOBAL LOW-END "\"Yuu hav reect xe loowist levul uv xe liibreree indeks.
Pleez tiip zeeroo tuu goo tuu aa hiiyur levul. If yuu reekwiir
asistins, kawl xe liibrereein.\"">

<GLOBAL MAIN-MENU
"    1. Histooree|
    2. Kulcur|
    3. Teknolojee|
    4. Jeeografee|
    5. Xe Prajekt|
    6. Inturlajik Gaamz">

<GLOBAL HISTORY-MENU
"    0. Maan Menyuu|
    1. Raashul Orijinz|
    2. Graat Hiiaatus|
    3. Riiz uv xe Nuu Teknakrasee">

<GLOBAL CULTURE-MENU
"    0. Maan Menyuu|
    1. Lituracur|
    2. Art|
    3. Muusik">

<GLOBAL TECHNOLOGY-MENU
"    0. Maan Menyuu|
    1. Medisin|
    2. Agrikultcur|
    3. Tranzportaashun|
    4. Roobotiks|
    5. Planateree Sistumz">

<GLOBAL GEOGRAPHY-MENU
"    0. Maan Menyuu|
    1. Planit Landmasiz|
    2. Undursee Reejunz|
    3. Spaas Kolooneez">

<GLOBAL PROJECT-MENU
"    0. Maan Menyuu|
    1. Orijinz uv xe Dizeez|
    2. Xe Instalaashunz|
    3. Prajekt Kuntrool|">

<GLOBAL INTERLOGIC-MENU
"    0. Maan Menyuu|
    1. Zoork|
    2. Dedliin and Witnis|
    3. Starkros and Suspendid">

<GLOBAL 11-TEXT
"\"Xe aancint lejindz saa xat ships frum xe Sekund Yuunyun wuns fild ar skiis
and wil wun daa kum agen. Madern siientists, huu wuns dismist suc lejindz
and felt xat liif eevolvd heer on Resida, now feel xat ar planit wuz reelee
setuld bii men uv xe Sekund Yuunyun.\"">

<GLOBAL 12-TEXT
"\"Wexur oor not xe lejindz uv xe Sekund Yuunyun ar truu, arkeeoloojists ar
surtin xat aa peereeid uv hii teknoolojikul and sooshul deevelupmint egzistid
xowzindz uv yeerz agoo, but foor sum reezin sivilizaashun slid intuu aa dark
aaj lasteeng senshureez.\"">

<GLOBAL 13-TEXT
"\"Wixin xe last fiiv senshureez, xe riiz uv xe Nuu Teknakrasee haz reeturnd
sivilizaashun tuu xe levul ataand beefoor xe Hiiaatus. Sooshul histooreeunz
xink xat wen xe Dizeez struk, ar raas had aceevd aa levul uv sufistikaashun
eekwal tuu xe pree-Hiiaatus.\"">

<GLOBAL 21-TEXT
"\"Menee volyuumz on xe deevelupmint uv Residan lituracur ar on fiil in xe
liibreree. Alsoo, kopeez uv awl graat wurks uv riiteeng, sum daateeng bak tuu
xe mixikul daaz uv xe Sekund Yuunyun, ar lookaatid heer.\"">

<GLOBAL 22-TEXT
"\"Histoorikul studeez and reeproodukshunz uv Residan art ar avaalibul heer
foor awl xree maajur peereeids uv art deevelupmint: xe Primitiv peereeid, xe
Renasans peereeid uv xe urlee poost-Hiiaatus, and xe moost reesint peereeid
uv videeoo and laazur art.\"">

<GLOBAL 23-TEXT
"\"Reekoordeengz uv awl impoortint kompoozishunz uv xe last fiiv hundrid yeerz
ar lookaatid in xe liibrereez data banks.\"">

<GLOBAL 31-TEXT
"\"Awl maajur dizeezuz hav bin kyuuribul foor oovur aa senshuree. Xe
deevelupmint uv kriioojeniks now alowz dokturz tuu put paashints in staasis
until aa kyuur iz fownd. Avurij Residan liif ekspektinsee iz now 147
revooluushunz.\"">

<GLOBAL 32-TEXT
"\"Durt farmeeng iz awl but obsooleet, wix moost fuud kumeeng frum xe
hiidrooponiks kompleksiz oor xe undurwatur aljee farmz.\"">

<GLOBAL 33-TEXT
"\"Planateree travul iz noormulee priivit skuutur foor shoort hops, and aarbus
foor longur trips.  Spaas travul haz reesintlee bin revooluushuniizd bii xe
invenshun uv nuukleeur-fyuuld enjinz.\"">

<GLOBAL 34-TEXT
"\"Untoold senshureez agoo, entiir teemz uv roobots wur reekwiird tuu purfoorm
eevin xe simplist tasks...wun roobot wud handul viszuuwul funkshunz, wun roobot
wud handul awditooree funkshunz, and soo foorx. Now, xanks tuu advansis in
mineeatshurizaashun, xeez tasks kan bee purfoormd bii singul roobots, suc az
xe multiipurpis B-19 seereez.\"">

<GLOBAL 35-TEXT
"\"Xe priimeree Planateree Sistumz ar Kors Kuntrool (foor maantaaneeng an
iideel kliimit), Deefens (foor destroieeng pootenshulee daanjuris meeteeoorz),
and xe reesintlee adid Prajekt Kuntrool (foor monitureeng proogres uv
Xe Prajekt).\"">

<GLOBAL 41-TEXT
"\"Sins xe staabulizaashun uv xe oorbit uv Resida, preesiislee 47.79 pursent
uv xe planits surfis iz land. Xe land iz diviidid intuu tuu priimeree
landmasiz, Andoor and Fruulik, plus siks lesur landmasiz. Xe gloobul kapitul,
Pilandoor, iz on xe eesturn koost uv Andoor.\"">

<GLOBAL 42-TEXT
"\"Xe furst undursee habutats wur oopind in 2992, and tuudaa, neerlee tuu
senshureez laatur, abowt 9 pursent uv Residaz popyuulaashun livz in wun
uv xe twentee sprawleeng undursee siteez.\"">

<GLOBAL 43-TEXT
"\"Alxoo setulmints hav bin establisht on Fristin, and on sevrul uv xe muunz
uv xe gas jiiunt Blustin, xe vast majooritee uv of-woorldurz liv in xe
spaas kolooneez establisht at Residaz troojin points.\""> 

<GLOBAL 51-TEXT
"\"Xe oorijin uv Xe Dizeez haz bin linkt tuu xe Sentur foor Advanst Kriioojenik
Reesurc, wic wuz kondukteeng reesurc intuu waaz uv ekstendeeng xe Kriioojenik
peereeid indefinitlee. Alxoo xis reesurc wuz aa sukses, sumhow Xe Dizeez
wuz reeleest and beegan spredeeng.\"">

<GLOBAL 52-TEXT
"\"Xe tuu kompleksiz wur establisht on xe twin peek platooz uv Kalamontee and
Lawanda. Xeez lookaashunz wur coozin beekawz xaar hiit wud maak
transpoortaashun and komyuunikaashunz eezeeur, and soo xat xe vast reeakturz
and kriioojeniks caamburz kud bee kunstruktid in xe mowntinz beeloo.\"">

<GLOBAL 53-TEXT
"\"Faaz Wun: xe kunstrukshun uv xe Kalamontee and Lawanda Kompleksiz. Faaz
Tuu: mass kriioojenik freezeeng uv Residan popyuulaashun. Faaz Xree:
siimultaaneeus monitureeng uv kriioojeniks wiil awtoomaatid reesurc iz
konduktid bii inkrediblee soofistikaatid kumpyuuturiizd fasiliteez. Faaz
Foor: reeviivul and inokyuulaashun uv xe popyuulaashun.\"">

<GLOBAL 61-TEXT
"\"Xe Zoork triloojee, an adventshur klasik, taaks plaas in aa deeliitful
but daanjuris undurgrownd seteeng.\"">

<GLOBAL 62-TEXT
"\"Dedliin iz xe furst graat misturee uv xe kumpyuutur aaj, and Witnis iz
its wurxee suksesur.\"">

<GLOBAL 63-TEXT
"\"Starkros iz Infookamz miind-bendeeng siiens-fikshun adventshur. Suspendid
iz aa kriioojenik siiens-fikshun niitmaar.\"">

<OBJECT SPOOL-READER
	(IN LIBRARY)
	(DESC "microfilm reader")
	(FDESC
"On the desk is a machine with a screen and a small circular opening. It
seems to be turned off.")
	(LDESC
"There is a microfilm reader on one of the tables.")
	(SYNONYM READER SCREEN OPENIN MACHIN) 
	(ADJECTIVE MICROF SMALL CIRCUL)
	(CAPACITY 3)
	(FLAGS LIGHTBIT CONTBIT SEARCHBIT OPENBIT)
	(ACTION SPOOL-READER-F)>

<GLOBAL SPOOL-TEXT <>>

<ROUTINE SPOOL-READER-F ()
	 <COND (<VERB? LAMP-ON>
		<COND (<FSET? ,SPOOL-READER ,ONBIT>
		       <TELL "The spool reader is already on." CR>)
		      (T
		       <FSET ,SPOOL-READER ,ONBIT>
		       <FSET ,SPOOL-READER ,TOUCHBIT> 
		       <COND (<FIRST? ,SPOOL-READER>
			      <TELL ,SPOOL-TEXT CR>)
			     (T
			      <TELL
"The machine hums quietly, and the screen lights up with the phrase
\"Pleez insurt spuul.\"" CR>)>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,SPOOL-READER ,ONBIT>
		       <FCLEAR ,SPOOL-READER ,ONBIT>
		       <TELL "The spool reader is now off." CR>)
		      (T
		       <TELL "It's not on!" CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"The machine has a small screen, and below that, a small circular opening.
The screen is currently ">
		<COND (<AND <FSET? ,SPOOL-READER ,ONBIT>
			    <FIRST? ,SPOOL-READER>>
		       <TELL "displaying some information:" CR>
		       <TELL ,SPOOL-TEXT CR>)
		      (T
		       <TELL "blank." CR>)>)
	       (<VERB? READ>
		<COND (<AND <FSET? ,SPOOL-READER ,ONBIT>
			    <FIRST? ,SPOOL-READER>>
		       <TELL ,SPOOL-TEXT CR>)
		      (T
		       <TELL "The screen is blank." CR>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,SPOOL-READER>>
		<COND (<FIRST? ,SPOOL-READER>
		       <TELL "There's already a spool in the reader." CR>)
		      (<EQUAL? ,PRSO ,GREEN-SPOOL>
		       <SETG SPOOL-TEXT ,GREEN-TEXT>
		       <MOVE ,GREEN-SPOOL ,SPOOL-READER>
		       <FSET ,GREEN-SPOOL ,TRYTAKEBIT>
		       <TELL ,SPOOL-FITS>
		       <COND (<FSET? ,SPOOL-READER ,ONBIT>
			      <TELL ,SOME-INFO>)>
		       <TELL CR>)
		      (<EQUAL? ,PRSO ,RED-SPOOL>
		       <SETG SPOOL-TEXT ,RED-TEXT>
		       <MOVE ,RED-SPOOL ,SPOOL-READER>
		       <FSET ,RED-SPOOL ,TRYTAKEBIT>
		       <TELL ,SPOOL-FITS>
		       <COND (<FSET? ,SPOOL-READER ,ONBIT>
			      <TELL ,SOME-INFO>)>
		       <TELL CR>)
		      (T
		       <TELL "It doesn't fit in the circular opening." CR>)>)
	       (<VERB? CLOSE>
		<NO-CLOSE>
		<RTRUE>)>>

<GLOBAL SPOOL-FITS "The spool fits neatly into the opening.">

<GLOBAL SOME-INFO " Some information appears on the screen.">

<GLOBAL GREEN-TEXT
"\"Oonlee peepul wix propur traaneeng shud piilot xe helikopturz. Reekwiird
ekwipmint inkluudz aa Helikoptur Akses Kard and aa Kuntrool Panul Kee. Xeez
kan bee obtaand frum Tranzportaashun Stoorij.\"|
The rest is all very technical.">

<GLOBAL RED-TEXT
"\"Xe jestaashun peereeid uv Xe Dizeez, folooweeng ekspoozur, vaareez
treemenduslee frum pursin tuu pursin, raanjeeng frum wun daa tuu sevrul
rootaashunz. Wuns xe furst simptumz ar shoon, dex alwaaz okurz in aat tuu
ten daaz.|
Xe priimeree simptum iz aa hii feevur. Xe sekunderee simptum iz aa sharp
inkrees in xe amownt uv sleep needid eec niit.\"|
The rest of the information is about symptoms which can be detected only by
using complicated medical procedures.">

<ROOM PROJECT-CORRIDOR-WEST
      (IN ROOMS)
      (DESC "Project Corridor West")
      (LDESC
"This is a curving hallway leading east and northwest. There is an opening
to the west.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW" 25 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO SANFAC-F)
      (EAST TO PROJECT-CORRIDOR)
      (NW TO FORK)
      (FLAGS RLANDBIT ONBIT)>

<ROOM SANFAC-F
      (IN ROOMS)
      (DESC "SanFac F")
      (LDESC
"This is another dusty sanitary facility. Unlike the ones near the dorms,
this one is smaller and has no bathing fixtures.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO PROJECT-CORRIDOR-WEST)
      (OUT TO PROJECT-CORRIDOR-WEST)
      (FLAGS FLOYDBIT RLANDBIT ONBIT)
      (PSEUDO "FIXTURES" TOILET-PSEUDO "TOILET" TOILET-PSEUDO)>

<ROOM PROJECT-CORRIDOR
      (IN ROOMS)
      (DESC "Project Corridor")
      (LDESC
"You are at the center of a long east-west hallway. A doorway, labelled
\"PrajKon Awfis\", opens to the south.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO PROJECT-CORRIDOR-EAST)
      (WEST TO PROJECT-CORRIDOR-WEST)
      (SOUTH TO PROJCON-OFFICE)
      (FLAGS RLANDBIT ONBIT)>

<ROOM PROJCON-OFFICE
      (IN ROOMS)
      (DESC "ProjCon Office")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO PROJECT-CORRIDOR)
      (SOUTH TO CRYO-ELEVATOR IF CRYO-ELEVATOR-DOOR IS OPEN
       ELSE "You can't go that way.")
      (EAST TO COMPUTER-ROOM)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (GLOBAL CRYO-ELEVATOR-DOOR)
      (PSEUDO "MURAL" MURAL-PSEUDO "LOGO" LOGO-PSEUDO)
      (ACTION PROJCON-OFFICE-F)>

<ROUTINE PROJCON-OFFICE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This office looks like a headquarters of some kind. Exits lead north and
east. The west wall displays a logo. ">
		<COND (,COMPUTER-FIXED
		       <TELL
"The mural that previously adorned the south wall has slid away, revealing
an open doorway to a large elevator!" CR>)
		      (T
		       <TELL
"The south wall is completely covered by a garish mural which clashes
with the other decor of the room." CR>)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,FLOYD ,HERE>
		     <NOT ,MURAL-FLAG>>
		<SETG MURAL-FLAG T>
		<SETG FLOYD-SPOKE T>
		<TELL
"Floyd surveys the mural and scratches his head. \"I don't remember seeing
this before,\" he comments." CR>)>>

<GLOBAL MURAL-FLAG <>>

<OBJECT CRYO-ELEVATOR-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "cryo-elevator door")
	(SYNONYM DOOR)
	(ADJECTIVE CRYO-ELEVATOR ELEVATOR)
	(FLAGS NDESCBIT INVISIBLE)>

<ROOM CRYO-ELEVATOR
      (IN ROOMS)
      (DESC "Cryo-Elevator")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH PER CRYO-EXIT-F)
      (GLOBAL CRYO-ELEVATOR-DOOR)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "BUTTON" CRYO-BUTTON-PSEUDO)
      (ACTION CRYO-ELEVATOR-F)>

<ROUTINE CRYO-ELEVATOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large, plain elevator with one solitary button and a door
to the north which is ">
		<DDESC ,CRYO-ELEVATOR-DOOR>
		<TELL "." CR>)>>

<ROUTINE CRYO-EXIT-F ()
	 <COND (<FSET? ,CRYO-ELEVATOR-DOOR ,OPENBIT>
		<COND (,CRYO-SCORE-FLAG
		       ,CRYO-ANTEROOM)
		      (T
		       ,PROJCON-OFFICE)>)
	       (T
		<DOOR-CLOSED>
		<RFALSE>)>>

<GLOBAL CRYO-SCORE-FLAG <>>

<ROUTINE I-CRYO-ELEVATOR-ARRIVE ()
	 <FSET ,CRYO-ELEVATOR-DOOR ,OPENBIT>
	 <TELL CR "The elevator door opens onto a room to the north." CR>>

<ROOM CRYO-ANTEROOM
      (IN ROOMS)
      (DESC "Cryo-Anteroom")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (FLAGS RLANDBIT ONBIT)
      (ACTION CRYO-ANTEROOM-F)>

<ROUTINE CRYO-ANTEROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The elevator closes as you leave it, and you find yourself in a small,
chilly room. To the north, through a wide arch, is an enormous chamber lined
from floor to ceiling with thousands of cryo-units. You can see similar
chambers beyond, and your mind staggers at the thought of the millions of
individuals asleep for countless centuries.|
|
In the anteroom where you stand is a solitary cryo-unit, its cover frosted.
Next to the cryo-unit is a complicated control panel." CR CR>)
	       (<EQUAL? .RARG ,M-END>
		<TELL
"A door slides open and a medical robot glides in. It opens the cryo-unit
and administers an injection to its inhabitant. As the robot glides away, a
figure rises from the cryo-unit -- a handsome, middle-aged woman with flowing
red hair. She spends some time studying readouts from the control panel">
		<COND (<AND ,COMM-FIXED ,DEFENSE-FIXED>
		       <TELL ", pressing several keys." CR>)
		      (T
		       <TELL "." CR>)>
		<COND (,COURSE-CONTROL-FIXED
		       <TELL
"|
As other cryo-units in the chambers beyond begin opening, the woman turns
to you, bows gracefully, and speaks in a beautiful, lilting
voice. \"I am Veldina, leader of Resida. Thanks to you, the cure has been
discovered, and the planetary systems repaired. We are eternally
grateful.\"" CR>
		       <COND (<AND ,COMM-FIXED ,DEFENSE-FIXED>
			      <TELL
"|
\"You will also be glad to hear that a ship of your Stellar Patrol now orbits
the planet. I have sent them the coordinates for this room.\" As if on cue,
a landing party from the S.P.S. Flathead materializes nearby. Blather is with
them, having been picked up from deep space in another escape pod, babbling
cravenly. Captain Sterling of the Flathead acknowledges your heroic actions,
and informs you of your promotion to Lieutenant First Class.|
|
As a team of mutant hunters head for the cryo-elevator, Veldina mentions that
the grateful people of Resida offer you leadership of their world. Captain
Sterling points out that, even if you choose to remain on Resida, Blather
(demoted to Ensign Twelfth Class) has been assigned as your personal toilet
attendant.|
|
You feel a sting from your arm and turn to see a medical robot moving
away after administering the antidote for The Disease.|
|
A team of robot technicians step into the anteroom. They part their ranks, and
a familiar figure comes bounding toward you! \"Hi!\" shouts Floyd, with
uncontrolled enthusiasm. \"Floyd feeling better now!\" Smiling from ear to
ear, he says, \"Look what Floyd found!\" He hands you a helicopter key,
a reactor elevator card, and a paddleball set. \"Maybe we can use them in
the sequel...\"" CR CR>
			      <FINISH <>>)
			     (T
			      <TELL
"|
\"Unfortunately, a second ship from your Stellar Patrol has ">
			      <COND (<NOT ,DEFENSE-FIXED>
				     <TELL
"been destroyed by our malfunctioning meteor defenses.">)
				    (T
				     <TELL
"come looking for survivors, and because of our malfunctioning communications
system, has given up and departed.">)>
			      <TELL
" I fear that you are stranded on Resida, possibly forever. However, we
show our gratitude by offering you an unlimited bank account and a house
in the country.\"" CR CR>
			      <FINISH <>>)>)
		      (T
		       <TELL
"|
She turns to you and, with a strained voice says, \"You have fixed our
computer and a Cure has been discovered, and we are grateful. But alas,
it was all in vain. Our planetary course control system has malfunctioned,
and the orbit has now decayed beyond correction. Soon Resida will plunge
into the sun.\"" CR CR>
		       <COND (<AND ,COMM-FIXED ,DEFENSE-FIXED>
			      <TELL
"Veldina examines the control panel again. \"Fortunately, another ship from
your Stellar Patrol has arrived, so at least you will survive.\" At that
moment, a landing party from the S.P.S. Flathead materializes, and takes you
away from the doomed world." CR CR>)>
		       <FINISH <>>)>)>>

;(OLD HACK ENDING:
"A parchment containing Mike Dornbrook's phone number appears in the trophy
case. A holographic image of the Dungeon Master appears in the air before
you. He is carrying a letter from Chief Inspector Klutz. \"I hope to meet you
in person some day,\" he says.")

<ROOM PROJECT-CORRIDOR-EAST
      (IN ROOMS)
      (DESC "Project Corridor East")
      (LDESC
"The hallway ends here but continues back toward the west. Doorways lead
north, south and east.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO LIBRARY-LOBBY)
      (SOUTH TO COMPUTER-ROOM)
      (WEST TO PROJECT-CORRIDOR)
      (EAST TO MAIN-LAB)
      (FLAGS RLANDBIT ONBIT)>

<ROOM COMPUTER-ROOM
      (IN ROOMS)
      (DESC "Computer Room")
      (LDESC
"This is the main computer room for the Project. The only sign of activity is
a glowing red light. The exits are north, west, and northeast. To the south
is a small booth.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"  25  ;"NORTH"  0>)
      (NORTH TO PROJECT-CORRIDOR-EAST)
      (WEST TO PROJCON-OFFICE)
      (SOUTH TO MINI-BOOTH)
      (IN TO MINI-BOOTH)
      (NE TO MAIN-LAB)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (GLOBAL LIGHTS)
      (PSEUDO "BOOTH" NEAR-BOOTH-PSEUDO)>

<GLOBAL COMPUTER-FLAG <>>

<ROUTINE COMPUTER-ACTION ()
	 <SETG COMPUTER-FLAG T>
	 <SETG FLOYD-SPOKE T>
	 <TELL "Floyd examines the ">
	 <COND (<EQUAL? ,HERE ,COMPUTER-ROOM>
		<TELL "glowing light">)
	       (T
		<TELL "computer printout">)>
	 <TELL ". With a concerned frown, he says, \"Uh oh. Computer is
broken. A Doctor-person once told Floyd that Computer is the most important
part of the Project.\"" CR>>

<OBJECT PRINT-OUT
	(IN COMPUTER-ROOM)
	(DESC "pile of computer output")
	(SYNONYM PILE PAPER OUTPUT PRINTOUT)
	(ADJECTIVE COMPUTER)
	(SIZE 20)
	(FLAGS ACIDBIT TAKEBIT READBIT)
	(ACTION PRINT-OUT-F)>

<ROUTINE PRINT-OUT-F ()
	 <COND (<VERB? READ EXAMINE>
		<FIXED-FONT-ON>
		<TELL
"The printout is hundreds of pages long. It would take many chrons to
read it all. The last page looks pretty interesting, though:|
|
\"Daalee Statis Reeport:|
PREELIMINEREE REESURC:  100.000%|
INTURMEEDEEIT REESURC:  100.000%|
FIINUL REESURC:         100.000%|
DRUG PROODUKSHUN:       100.000%|
DRUG TESTEENG:           99.985%|
Proojektid tiim tuu reeviivul prooseedzur:  0 daaz, 0.8 kronz|
|
|
*** ALURT! ALURT! ***|
Malfunkshun in Sekshun 384! Sumuneeng reepaar roobot.\"|
|
The printout ends at this point." CR>
		<FIXED-FONT-OFF>)>>

<ROOM MINI-BOOTH
      (IN ROOMS)
      (DESC "Miniaturization Booth")
      (LDESC
"This is a small room barely large enough for one person. Mounted on the wall
is a small slot, and next to it a keyboard with numeric keys. The exit is to
the north.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO COMPUTER-ROOM)
      (OUT TO COMPUTER-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SLOT)
      (PSEUDO "KEYBOARD" KEYBOARD-PSEUDO "BOOTH" IN-BOOTH-PSEUDO)>

<OBJECT MINI-CARD
	(IN BIO-LOCK-EAST)
	(DESC "miniaturization access card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE MINIAT MINI ACCESS)
	(SIZE 3)
	(FLAGS TAKEBIT NDESCBIT INVISIBLE READBIT)
	(VALUE 1)
	(TEXT "The card is embossed \"minitcurizaashun akses kard.\"")
	(ACTION MINI-CARD-F)>

<ROUTINE MINI-CARD-F ()
	 <COND (<AND <FSET? ,MINI-CARD ,NDESCBIT>
		     <VERB? RUB MOVE TURN SET TAKE PUSH PULL SMELL>>
		<TELL "It's in the next room." CR>)>>

<ROOM MAIN-LAB
      (IN ROOMS)
      (DESC "Main Lab")
      (LDESC
"This is the heart of the Project's vast laboratory complex. There are exits
to the west and southwest, and heavy metal doors to the northeast and
southeast. A small doorway leads south.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"  25  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO PROJECT-CORRIDOR-EAST)
      (SOUTH TO LAB-STORAGE)
      (SW TO COMPUTER-ROOM)
      (SE TO BIO-LOCK-WEST IF BIO-DOOR-WEST IS OPEN)
      (NE TO RADIATION-LOCK-WEST IF RAD-DOOR-WEST IS OPEN)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (GLOBAL BIO-DOOR-WEST RAD-DOOR-WEST)>

<ROOM LAB-STORAGE
      (IN ROOMS)
      (DESC "Lab Storage")
      (LDESC
"This is a tiny room for the storage of laboratory supplies. The sole exit is
to the north.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO MAIN-LAB)
      (OUT TO MAIN-LAB)
      (FLAGS RLANDBIT FLOYDBIT ONBIT)
      (GLOBAL SHELVES)
      (PSEUDO "RACK" CARPET-PSEUDO "SUPPLIES" SUPPLIES-PSEUDO)> 

<OBJECT LAB-UNIFORM
	(IN LAB-STORAGE)
	(DESC "lab uniform")
	(FDESC
"Hanging on a rack is a pale blue lab uniform. Sewn onto its pocket is a
non-descript logo.")
	(SYNONYM UNIFORM SUIT POCKET LOGO)
	(ADJECTIVE PALE BLUE LAB)
	(SIZE 10)
	(CAPACITY 5)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT WEARBIT)
	(ACTION LAB-UNIFORM-F)>

<GLOBAL UNIFORM-OPENED <>>

<ROUTINE LAB-UNIFORM-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is a plain lab uniform. The logo above the pocket depicts a flame burning
above some kind of sleep chamber. The pocket is ">
		<DDESC ,LAB-UNIFORM>
		<TELL "." CR>)
	       (<VERB? SEARCH OPEN>
	        <COND (<FSET? ,LAB-UNIFORM ,OPENBIT>
		       <TELL "The pocket is already open." CR>)
		      (T
		       <FSET ,LAB-UNIFORM ,OPENBIT>
		       <COND (,UNIFORM-OPENED
			      <COND (<FIRST? ,LAB-UNIFORM>
				     <TELL
"Opening the uniform's pocket reveals ">
				     <PRINT-CONTENTS ,LAB-UNIFORM>
				     <TELL "." CR>)
				    (T
				     <TELL "The pocket is empty." CR>)>)
			     (T
		              <FSET ,LAB-UNIFORM ,OPENBIT>
			      <SETG UNIFORM-OPENED T>
			      <TELL
"You discover a small piece of paper and a teleportation access card in the
pocket of the uniform." CR>)>)>)
	       (<AND <VERB? WEAR>
		     <FSET? ,PATROL-UNIFORM ,WORNBIT>>
		<TELL "It won't fit on top of the Patrol uniform." CR>)>>

<OBJECT TELEPORTATION-CARD
	(IN LAB-UNIFORM)
	(DESC "teleportation access card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE TELEPO ACCESS)
	(SIZE 3)
	(FLAGS TAKEBIT READBIT)
	(TEXT "The card is embossed \"teliportaashun akses kard.\"")>

;<OBJECT MODULATOR-PIN
	(IN LAB-UNIFORM)
	(DESC "modulator pin")
	(SYNONYM PIN)
	(ADJECTIVE DIGGER MODULATOR)
	(SIZE 2)
	(FLAGS TAKEBIT)>

<OBJECT COMBINATION-PAPER
	(IN LAB-UNIFORM)
	(DESC "piece of paper")
	(SYNONYM PIECE PAPER)
	(FLAGS ACIDBIT TAKEBIT READBIT)
	(SIZE 2)
	(ACTION COMBINATION-PAPER-F)>

<ROUTINE COMBINATION-PAPER-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"Week uv 14-Juun--2882. Kombinaashun tuu Konfurins Ruum: " N ,NUMBER-NEEDED
"." CR>)>>

<ROOM BIO-LOCK-WEST
      (IN ROOMS)
      (DESC "Bio Lock West")
      (LDESC
"This is the first half of a sterilization chamber to prevent contamination
of the delicate biological experiments in the Bio Lab which lies beyond. The
door to the west leads to the main lab, and the bio lock continues eastward.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST"10 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO BIO-LOCK-EAST)
      (WEST TO MAIN-LAB IF BIO-DOOR-WEST IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BIO-DOOR-WEST)>

<ROOM BIO-LOCK-EAST
      (IN ROOMS)
      (DESC "Bio Lock East")
      (LDESC
"The is the second half of the sterilization chamber leading from the main
lab to the Bio Lab. The door to the east, leading to the Bio Lab, has a
window. The bio lock continues to the west.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST"10 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO BIO-LAB IF BIO-DOOR-EAST IS OPEN)
      (WEST TO BIO-LOCK-WEST)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BIO-DOOR-EAST WINDOW)
      (ACTION BIO-LOCK-EAST-F)>

<ROUTINE BIO-LOCK-EAST-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,FLOYD ,HERE>
		     <FSET? ,FLOYD ,RLANDBIT>
		     <NOT <EQUAL? ,FLOYD ,WINNER>>>
		<COND (,FLOYD-WAITING
		       <COND (<G? ,WAITING-COUNTER 3>
			      <SETG FLOYD-WAITING <>>
			      <SETG FLOYD-GAVE-UP T>
			      <SETG FLOYD-SPOKE T>
			      <SETG FLOYD-FOLLOW <>>
			      <MOVE ,FLOYD ,BIO-LOCK-WEST>
			      <ENABLE <QUEUE I-FLOYD 1>>
			      <TELL
"\"Okay,\" says Floyd with uncharacteristic annoyance. \"Forget about the
stupid card.\" He goes to the other end of the bio-lock and sulks." CR>)
			     (<NOT ,FLOYD-FORAYED>
			      <SETG FLOYD-SPOKE T>
			      <SETG WAITING-COUNTER <+ ,WAITING-COUNTER 1>>
			      <TELL
"Floyd looks at you with a dash of impatience and a healthy helping of
nervousness. \"Well?\" he asks. \"Are you going to open the door?\"" CR>)>)
		      (<AND <NOT ,FLOYD-GAVE-UP>
			    <NOT ,FLOYD-PEERED>>
		       <SETG FLOYD-SPOKE T>
		       <SETG FLOYD-PEERED T>
		       <ENABLE <QUEUE I-CLEAR-FLOYD-PEER 40>>
		       <FCLEAR ,MINI-CARD ,INVISIBLE>
		       <TELL
"Floyd stands on his tiptoes and peers in the window. ">
		       <COND (,COMPUTER-FLAG
			      <SETG FLOYD-WAITING T>
			      <TELL
"\"Looks dangerous in there,\" says Floyd. \"I don't think you should go
inside.\" He peers in again. \"We'll need card there to fix computer. Hmmm...
I know! Floyd will get card. Robots are tough. Nothing can hurt robots. You
open the door, then Floyd will rush in. Then you close door. When Floyd knocks,
open door again. Okay? Go!\" Floyd's voice trembles slightly as he waits for
you to open the door.">)
			     (T
			      <TELL
"\"Ooo, look,\" he says. \"There's a miniaturization booth access card!\"">)>
		       <TELL CR>)>)>> 

<GLOBAL FLOYD-PEERED <>>

<ROUTINE I-CLEAR-FLOYD-PEER ()
	 <SETG FLOYD-PEERED <>>
	 <RFALSE>>

<ROOM RADIATION-LOCK-WEST
      (IN ROOMS)
      (DESC "Radiation Lock West")
      (LDESC
"This is the western half of a decontamination chamber to prevent dangerous
radioactive materials from leaving the Radiation Lab which lies to the east.
The door leads west to the main lab.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO RADIATION-LOCK-EAST)
      (WEST TO MAIN-LAB IF RAD-DOOR-WEST IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL RAD-DOOR-WEST)>

<ROOM RADIATION-LOCK-EAST
      (IN ROOMS)
      (DESC "Radiation Lock East")
      (LDESC
"This is the eastern half of the decontamination chamber. The door to the
east leads to the Radiation Lab, and the chamber continues westward. A sign
on the wall reads \"WORNEENG! Raadeeaashun suuts must bee worn beeyond xis
point.\"")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO RADIATION-LAB IF RAD-DOOR-EAST IS OPEN)
      (WEST TO RADIATION-LOCK-WEST)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL RAD-DOOR-EAST)>

<OBJECT BIO-DOOR-EAST
	(IN LOCAL-GLOBALS)
	(DESC "lab door")
	(SYNONYM DOOR)
	(ADJECTIVE LAB)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION BIO-DOOR-EAST-F)>

<OBJECT BIO-DOOR-WEST
	(IN LOCAL-GLOBALS)
	(DESC "bio-lock door")
	(SYNONYM DOOR)
	(ADJECTIVE BIO-LOCK)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION BIO-DOOR-WEST-F)>

<OBJECT RAD-DOOR-EAST
	(IN LOCAL-GLOBALS)
	(DESC "lab door")
	(SYNONYM DOOR)
	(ADJECTIVE LAB)
	(FLAGS DOORBIT NDESCBIT)
        (ACTION RAD-DOOR-EAST-F)>

<OBJECT RAD-DOOR-WEST
	(IN LOCAL-GLOBALS)
	(DESC "radiation-lock door")
	(SYNONYM DOOR)
	(ADJECTIVE RADIATION)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION RAD-DOOR-WEST-F)>

<ROUTINE BIO-DOOR-EAST-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,BIO-DOOR-EAST ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<FSET? ,BIO-DOOR-WEST ,OPENBIT>
		       <TELL ,BOTH-DOORS CR>)
		      (<AND ,FLOYD-WAITING
			    <FSET? ,FLOYD ,RLANDBIT>
			    <EQUAL? ,FORAY-COUNTER 0>>
		       <ENABLE <QUEUE I-FLOYD-FORAY -1>>
		       <SETG FLOYD-FORAYED T>
		       <FSET ,BIO-DOOR-EAST ,OPENBIT>
		       <REMOVE ,FLOYD>
		       <DISABLE <INT I-FLOYD>>
		       <TELL
"The door opens and Floyd, pausing only for the briefest moment, plunges into
the Bio Lab. Immediately, he is set upon by hideous, mutated monsters! More
are heading straight toward the open door! Floyd shrieks and yells to you to
close the door." CR>)
		      (<AND <NOT ,FLOYD-FORAYED>
			    <EQUAL? <GET <INT I-CHASE-SCENE> ,C-ENABLED?> 0>>
		       <JIGS-UP
"Opening the door reveals a Bio-Lab full of horrible mutations. You stare at
them, frozen with horror. Growling with hunger and delight, the mutations
march into the bio-lock and devour you.">)
		      (T
		       <FSET ,BIO-DOOR-EAST ,OPENBIT>
		       <ENABLE <QUEUE I-BIO-EAST-CLOSES 30>>
		       <TELL ,DOOR-OPENS CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,BIO-DOOR-EAST ,OPENBIT>
		       <COND (<EQUAL? ,FORAY-COUNTER 4>
			      <SETG C-ELAPSED 95>)>
		       <FCLEAR ,BIO-DOOR-EAST ,OPENBIT>
		       <TELL "The door closes">
		       <COND (<EQUAL? <GET <INT I-CHASE-SCENE> ,C-ENABLED?> 1>
			      <TELL ", but not soon enough!" CR>)
			     (T
			      <TELL "." CR>)>)
		      (T
		       <IS-CLOSED>)>)>>

<ROUTINE I-BIO-EAST-CLOSES ()
	 <COND (<FSET? ,BIO-DOOR-EAST ,OPENBIT>
		<FCLEAR ,BIO-DOOR-EAST ,OPENBIT>
		<COND (<EQUAL? ,HERE ,BIO-LOCK-EAST ,BIO-LOCK-WEST ,BIO-LAB>
		       <TELL CR 
"The door at the eastern end of the bio-lock closes silently." CR>)>)>>

<ROUTINE BIO-DOOR-WEST-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,BIO-DOOR-WEST ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<FSET? ,BIO-DOOR-EAST ,OPENBIT>
		       <TELL ,BOTH-DOORS CR>)
		      (T
		       <TELL ,DOOR-OPENS CR>
		       <ENABLE <QUEUE I-BIO-WEST-CLOSES 30>>
		       <FSET ,BIO-DOOR-WEST ,OPENBIT>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,BIO-DOOR-WEST ,OPENBIT>
		       <FCLEAR ,BIO-DOOR-WEST ,OPENBIT>
		       <TELL ,DOOR-CLOSES CR>)
		      (T
		       <IS-CLOSED>)>)>>

<ROUTINE I-BIO-WEST-CLOSES ()
	 <COND (<FSET? ,BIO-DOOR-WEST ,OPENBIT>
		<FCLEAR ,BIO-DOOR-WEST ,OPENBIT>
		<COND (<EQUAL? ,HERE ,BIO-LOCK-WEST ,BIO-LOCK-EAST ,MAIN-LAB>
		       <TELL CR
"The door at the western end of the bio-lock closes silently." CR>)>)>>

<ROUTINE RAD-DOOR-EAST-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,RAD-DOOR-EAST ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<FSET? ,RAD-DOOR-WEST ,OPENBIT>
		       <TELL ,BOTH-DOORS CR>)
		      (T
		       <FSET ,RAD-DOOR-EAST ,OPENBIT>
		       <TELL ,DOOR-OPENS CR>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,RAD-DOOR-EAST ,OPENBIT>
		       <FCLEAR ,RAD-DOOR-EAST ,OPENBIT>
		       <TELL ,DOOR-CLOSES CR>)
		      (T
		       <IS-CLOSED>)>)>>

<ROUTINE RAD-DOOR-WEST-F ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,RAD-DOOR-WEST ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<FSET? ,RAD-DOOR-EAST ,OPENBIT>
		       <TELL ,BOTH-DOORS CR>)
		      (T
		       <TELL ,DOOR-OPENS CR>
		       <FSET ,RAD-DOOR-WEST ,OPENBIT>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,RAD-DOOR-WEST ,OPENBIT>
		       <FCLEAR ,RAD-DOOR-WEST ,OPENBIT>
		       <TELL ,DOOR-CLOSES CR>)
		      (T
		       <IS-CLOSED>)>)>>

<GLOBAL BOTH-DOORS
"A very bored-sounding recorded voice explains that, in order to prevent
contamination, both lock doors cannot be open simultaneously.">

<GLOBAL DOOR-OPENS "The door opens.">

<GLOBAL DOOR-CLOSES "The door closes.">

<GLOBAL FLOYD-WAITING <>>

<GLOBAL WAITING-COUNTER 0>

<GLOBAL FLOYD-GAVE-UP <>>

<GLOBAL FLOYD-FORAYED <>>

<GLOBAL FORAY-COUNTER 0>

<ROUTINE I-FLOYD-FORAY ()
	 <SETG FORAY-COUNTER <+ ,FORAY-COUNTER 1>>
	 <COND (<EQUAL? ,FORAY-COUNTER 2>
		<COND (<FSET? ,BIO-DOOR-EAST ,OPENBIT>
		       <CRLF>
		       <MONSTER-DEATH>)
		      (T
		       <TELL CR
"From within the lab you hear ferocious growlings, the sounds of a skirmish,
and then a high-pitched metallic scream!" CR>)>)
	       (<EQUAL? ,FORAY-COUNTER 3>
		<COND (<FSET? ,BIO-DOOR-EAST ,OPENBIT>
		       <CRLF>
		       <MONSTER-DEATH>)
		      (T
		       <TELL CR
"You hear, slightly muffled by the door, three fast knocks, followed
by the distinctive sound of tearing metal." CR>)>)
	       (<EQUAL? ,FORAY-COUNTER 4>
		<COND (<FSET? ,BIO-DOOR-EAST ,OPENBIT>
		       <MOVE ,FLOYD ,HERE>
		       <TELL CR
"Floyd stumbles out of the Bio Lab, clutching the mini-booth card. The
mutations rush toward the open doorway!" CR>)
		      (T
		       <TELL CR
"The three knocks come again, followed by a wild scream. Then, all is silence
from within the Bio Lab, except for an occasional metallic crunch." CR>
		       <FCLEAR ,FLOYD ,RLANDBIT>
		       <DISABLE <INT I-FLOYD-FORAY>>)>)
	       (<EQUAL? ,FORAY-COUNTER 5>
		<COND (<FSET? ,BIO-DOOR-EAST ,OPENBIT>
		       <CRLF>
		       <MONSTER-DEATH>)
		      (T
		       <REMOVE ,FLOYD>
		       <FCLEAR ,FLOYD ,RLANDBIT>
		       <DISABLE <INT I-FLOYD>>
		       <FSET ,FLOYD ,INVISIBLE>
		       <MOVE ,DEAD-FLOYD ,HERE>
		       <MOVE ,MINI-CARD ,BIO-LOCK-EAST>
		       <FSET ,MINI-CARD ,TOUCHBIT>
		       <SETG SCORE <+ ,SCORE 2>>
		       <TELL CR
"And not a moment too soon! You hear a pounding from the door as the monsters
within vent their frustration at losing their prey.|
|
Floyd staggers to the ground, dropping the mini card. He is badly torn apart,
with loose wires and broken circuits everywhere. Oil flows from his
lubrication system. He obviously has only moments to live.|
|
You drop to your knees and cradle Floyd's head in your lap. Floyd looks up
at his friend with half-open eyes. \"Floyd did it ... got card. Floyd a
good friend, huh?\" Quietly, you sing Floyd's favorite song, the Ballad
of the Starcrossed Miner:|
|
O, they ruled the solar system|
Near ten thousand years before|
In their single starcrossed scout ships|
Mining ast'roids, spinning lore.|
|
Then one true courageous miner|
Spied a spaceship from the stars|
Boarded he that alien liner|
Out beyond the orb of Mars.|
|
Yes, that ship was filled with danger|
Mighty monsters barred his way|
Yet he solved the alien myst'ries|
Mining quite a lode that day.|
|
O, they ruled the solar system|
Near ten thousand years before|
'Til one brave advent'rous spirit|
Brought that mighty ship to shore.|
|
As you finish the last verse, Floyd smiles with contentment, and then his
eyes close as his head rolls to one side. You sit in silence for a moment,
in memory of a brave friend who gave his life so that you might live." CR>
		       <FCLEAR ,FLOYD ,RLANDBIT>
		       <FCLEAR ,MINI-CARD ,NDESCBIT>
		       <DISABLE <INT I-FLOYD-FORAY>>)>)>>

<ROUTINE MONSTER-DEATH ()
	 <JIGS-UP
"The biological nightmares reach you. Gripping coils wrap around your limbs
as powerful teeth begin tearing at your flesh. Something bites your leg,
and you feel a powerful poison begin to work its numbing effects...">>

<ROOM BIO-LAB
      (IN ROOMS)
      (DESC "Bio Lab")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO LAB-OFFICE IF OFFICE-DOOR IS OPEN)
      (WEST TO BIO-LOCK-EAST IF BIO-DOOR-EAST IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BIO-DOOR-EAST WINDOW OFFICE-DOOR)
      (PSEUDO "CRACK" CRACK-PSEUDO)
      (ACTION BIO-LAB-F)>

<ROUTINE BIO-LAB-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a huge laboratory filled with many biological experiments.
The lighting is ">
		<COND (,LAB-LIGHTS-ON
		       <TELL "bright.">)
		      (T
		       <TELL
"dim, and a faint blue glow comes from a gaping crack in the northern wall.">)>
	       <TELL
" Some of the experiments seem to be out of control..." CR>)
	 (<EQUAL? .RARG ,M-END>
	  <ENABLE <QUEUE I-CHASE-SCENE -1>>
	  <COND (,LAB-FLOODED
		       <TELL
"The air is filled with mist, which is affecting the mutants. They appear
to be stunned and confused, but are slowly recovering." CR>
		       <COND (<NOT <FSET? ,GAS-MASK ,WORNBIT>>
			      <JIGS-UP
" Unfortunately, you don't seem to be that hardy.">)>)
		      (T
		       <JIGS-UP
"The mutants attack you and rip you to shreds within seconds.">)>)>> 

<GLOBAL EXTRA-MOVE-FLAG <>>

<GLOBAL CRYO-MOVE-FLAG <>>

<GLOBAL LAST-CHASE-ROOM <>>

<GLOBAL SECOND-TO-LAST-ROOM <>>

<ROUTINE I-CHASE-SCENE ()
	 <COND (<AND <IN? ,RAT-ANT ,HERE>
		     <NOT ,LAB-FLOODED>>
		<JIGS-UP
"|
Dozens of hungry eyes fix on you as the mutations surround you
and begin feasting.">)
	       (<NOT ,LAB-FLOODED>
		<COND (<AND <EQUAL? ,HERE ,BIO-LOCK-WEST>
			    <NOT ,EXTRA-MOVE-FLAG>>
		       <SETG EXTRA-MOVE-FLAG T>
		       <TELL CR
"The monsters gallop toward you, smacking their lips." CR>)
		      (<AND <EQUAL? ,HERE ,CRYO-ELEVATOR>
			    <NOT ,CRYO-MOVE-FLAG>>
		       <SETG CRYO-MOVE-FLAG T>
		       <TELL CR
"The monsters are storming straight toward the elevator door!" CR>)
		      (<AND <EQUAL? ,HERE ,SECOND-TO-LAST-ROOM>
			    <VERB? WALK>>
		       <JIGS-UP
"|
You stupidly run right into the jaws of the pursuing mutants.">)
		      (T
		       <COND (<EQUAL? ,HERE ,CRYO-ELEVATOR>
			      <CRLF>
			      <MONSTER-DEATH>)>
		       <MOVE ,RAT-ANT ,HERE>
		       <MOVE ,TRIFFID ,HERE>
		       <MOVE ,TROLL ,HERE>
		       <MOVE ,GRUE ,HERE>
		       <TELL CR "The mutants ">
		       <COND (<EQUAL? ,HERE ,BIO-LOCK-WEST>
			      <TELL "are almost upon you now!" CR>)
			     (T
			      <TELL "burst into the room right on your heels! "
				    <PICK-ONE ,MONSTER-ENTRANCES> CR>)>)>)>
	 <SETG SECOND-TO-LAST-ROOM ,LAST-CHASE-ROOM>
	 <SETG LAST-CHASE-ROOM ,HERE>>

<GLOBAL MONSTER-ENTRANCES
	<PLTABLE
	 "The growling humanoid is charging straight at you, waving his
axe-like implement!"
	 "A pair of slavering fangs removes part of your clothing!"
	 "Needle-sharp mandibles nip at your arms!"
	 "The mobile plant whips its poisonous tentacles against
your ankles!">>

<ROOM RADIATION-LAB
      (IN ROOMS)
      (DESC "Radiation Lab")
      (LDESC 
"This room is filled with unfathomable equipment and large canisters bearing
radioactive warnings. Many of the canisters are split open. You can see the
Bio Lab through a large crack in the south wall. Sinister-looking forms move
about within the Bio Lab. Although the lights here are off, the room is
suffused with a pale blue glow.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO RADIATION-LOCK-EAST IF RAD-DOOR-EAST IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TABLES RAD-DOOR-EAST)
      (PSEUDO "CRACK" CRACK-PSEUDO "EQUIPM" EQUIPMENT-PSEUDO)
      (ACTION RADIATION-LAB-F)>

<ROUTINE RADIATION-LAB-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,RADIATION-LAB ,TOUCHBIT>>>
		<ENABLE <QUEUE I-NUKED-BLUE 50>>)>>

<GLOBAL NUKED-COUNTER 0>

<ROUTINE I-NUKED-BLUE ()
	 <ENABLE <QUEUE I-NUKED-BLUE -1>>
	 <SETG NUKED-COUNTER <+ ,NUKED-COUNTER 1>>
	 <COND (<EQUAL? ,NUKED-COUNTER 1>
		<TELL CR "You suddenly feel sick and dizzy." CR>)
	       (<EQUAL? ,NUKED-COUNTER 2>
		<TELL CR
"You feel incredibly nauseous and begin vomiting. Also, all your
hair has fallen out.">
		<COND (<IN? ,FLOYD ,HERE>
		       <TELL
" Floyd points at you and laughs hysterically. \"You look funny with no
hair,\" he gasps.">)>
		<CRLF>)
	       (<EQUAL? ,NUKED-COUNTER 3>
		<JIGS-UP
"|
It seems you have picked up a bad case of radiation poisoning.">)>>

<OBJECT BROWN-SPOOL
	(IN RADIATION-LAB)
	(DESC "brown spool")
	(FDESC
"Sitting on a long table is a small brown spool.")
	(SYNONYM SPOOL SPOOLS OBJECT)
	(ADJECTIVE BROWN SMALL)
	(SIZE 3)
	(TEXT
"The spool is labelled \"Instrukshunz foor Reepaareeng Reepaar Roobots.\"")
	(FLAGS ACIDBIT TAKEBIT READBIT)>

<OBJECT LAMP
	(IN RADIATION-LAB)
	(DESC "portable lamp")
	(FDESC
"There is a powerful portable lamp here, currently off.")
	(SYNONYM LAMP LANTERN LIGHT)
	(ADJECTIVE POWERFUL PORTABLE)
	(SIZE 20)
	(FLAGS TAKEBIT)
	(ACTION LAMP-F)>

<ROUTINE LAMP-F ()
	 <COND (<VERB? LAMP-ON>
		<COND (<FSET? ,LAMP ,ONBIT>
		       <TELL "It is on." CR>)
		      (T
		       <FSET ,LAMP ,ONBIT>
		       <FSET ,LAMP ,TOUCHBIT>
		       <TELL "The lamp is now producing a bright light." CR>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,LAMP ,ONBIT>
		       <FCLEAR ,LAMP ,ONBIT>
		       <TELL "The lamp goes dark." CR>)
		      (T
		       <TELL "It isn't on." CR>)>)>>

<ROOM LAB-OFFICE
      (IN ROOMS)
      (DESC "Lab Office")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (WEST TO BIO-LAB IF OFFICE-DOOR IS OPEN)
      (SOUTH TO AUXILIARY-BOOTH)
      (IN TO AUXILIARY-BOOTH)
      (GLOBAL OFFICE-DOOR)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "FILES" CABINETS-PSEUDO "BOOTH" NEAR-BOOTH-PSEUDO)
      (ACTION LAB-OFFICE-F)>

<ROUTINE LAB-OFFICE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"This is the office for storing files on Bio Lab experiments. A large and
messy desk is surrounded by locked files. A small booth lies to the south. ">
		<COND (<FSET? ,OFFICE-DOOR ,OPENBIT>
		       <TELL "An open">)
		      (T
		       <TELL "A closed">)>
		<TELL " door to the west is labelled \"Biioo Lab.\" You
realize with shock and horror that the only way out is through the
mutant-infested Bio Lab.|
|
On the wall are three buttons: a white button labelled \"Lab Liits On\",
a black button labelled \"Lab Liits Of\", and a red button labelled
\"Eemurjensee Sistum.\"" CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		      <FSET? ,OFFICE-DOOR ,OPENBIT>>
		<COND (,LAB-FLOODED
		       <TELL
"Through the open doorway you can see the Bio Lab. It seems to be filled
with a light mist. Horrifying biological nightmares stagger about making
choking noises." CR>)
		      (T
		       <JIGS-UP
"Mutated monsters from the Bio Lab pour into the office. You are
devoured.">)>)>>

<OBJECT OFFICE-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "office door")
	(SYNONYM DOOR)
	(ADJECTIVE OFFICE)
	(FLAGS VOWELBIT DOORBIT NDESCBIT)>

<OBJECT LAB-DESK
	(IN LAB-OFFICE)
	(DESC "desk")
	(SYNONYM DESK)
	(ADJECTIVE LARGE MESSY)
	(FLAGS CONTBIT SEARCHBIT NDESCBIT)
	(CAPACITY 10)
	(ACTION LAB-DESK-F)>

<ROUTINE LAB-DESK-F ()
	 <COND (<AND <VERB? EXAMINE SEARCH>
		     <NOT <FSET? ,LAB-DESK ,TOUCHBIT>>>
		<MOVE ,MEMO ,ADVENTURER>
		<FSET ,LAB-DESK ,TOUCHBIT>
		<TELL
"After inspecting the various papers on the desk, you find only
one item of interest, a memo of some sort. The desk itself is ">
		<COND (<FSET? ,LAB-DESK ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL
"closed, but it doesn't look locked">)>
		<TELL "." CR>)
	       (<AND <VERB? OPEN>
		     <IN? ,GAS-MASK ,LAB-DESK>>
		<THIS-IS-IT ,GAS-MASK>
		<RFALSE>)>>

<OBJECT GAS-MASK
	(IN LAB-DESK)
	(DESC "gas mask")
	(SYNONYM MASK)
	(ADJECTIVE GAS)
	(FLAGS ACIDBIT TAKEBIT WEARBIT)
	(SIZE 10)>

<OBJECT MEMO
	(DESC "memo")
	(SYNONYM MEMO)
	(FLAGS READBIT ACIDBIT TAKEBIT)
	(TEXT
"\"Memoo tuu awl lab pursunel: Duu tuu xe daanjuris naatshur uv xe biioo
eksperiments, an eemurjensee sistum haz bin instawld. Xis sistum wud flud
xe entiir Biioo Lab wic aa dedlee fungasiid. Propur preecawshunz shud bee
taakin if xis sistum iz evur yuuzd.\"")>

<OBJECT LIGHT-BUTTON
	(IN LAB-OFFICE)
	(DESC "white button")
	(SYNONYM BUTTON)
	(ADJECTIVE WHITE LIGHT)
	(FLAGS NDESCBIT)
	(ACTION LIGHT-BUTTON-F)>

<OBJECT DARK-BUTTON
	(IN LAB-OFFICE)
	(DESC "black button")
	(SYNONYM BUTTON)
	(ADJECTIVE BLACK DARK DARKNESS)
	(FLAGS NDESCBIT)
	(ACTION DARK-BUTTON-F)>

<OBJECT FUNGICIDE-BUTTON
	(IN LAB-OFFICE)
	(DESC "red button")
	(SYNONYM BUTTON)
	(ADJECTIVE RED FUNGICIDE EMERGENCY)
	(FLAGS NDESCBIT)
	(ACTION FUNGICIDE-BUTTON-F)>

<GLOBAL LAB-LIGHTS-ON <>>

<GLOBAL LAB-FLOODED <>>

<ROUTINE LIGHT-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (,LAB-LIGHTS-ON
		       <TELL "Nothing happens." CR>)
		      (T
		       <SETG LAB-LIGHTS-ON T>
		       <TELL ,FAINT-SOUND CR>)>)>>

<ROUTINE DARK-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (,LAB-LIGHTS-ON
		       <SETG LAB-LIGHTS-ON <>>
		       <TELL ,FAINT-SOUND CR>)
		      (T
		       <TELL "Nothing happens." CR>)>)>>

<GLOBAL FAINT-SOUND "You hear the faint sound of a relay clicking.">

<ROUTINE FUNGICIDE-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<SETG LAB-FLOODED T>
		<ENABLE <QUEUE I-UNFLOOD 50>>
		<TELL
"You hear a hissing from beyond the door to the west." CR>)>>

<ROUTINE I-UNFLOOD ()
	 <SETG LAB-FLOODED <>>
	 <COND (<EQUAL? ,HERE ,BIO-LAB>
		<TELL CR
"The last traces of mist in the air vanish. The mutants, recovering
quickly, notice you and begin salivating." CR>)
	       (<AND <EQUAL? ,HERE ,LAB-OFFICE>
		     <FSET? ,OFFICE-DOOR ,OPENBIT>>
		<TELL CR
"The mist in the Bio Lab clears. The mutants recover and rush
toward the door!" CR>)>>

<ROOM AUXILIARY-BOOTH
      (IN ROOMS)
      (DESC "Auxiliary Booth")
      (LDESC
"This is another small booth. Unlike the Miniaturization Booth, this room
has no slot or keyboard, so presumably it is intended only as a receiving
station. The exit is on the northern side.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO LAB-OFFICE)
      (OUT TO LAB-OFFICE)
      (FLAGS RLANDBIT ONBIT)
      (VALUE 4)
      (PSEUDO "BOOTH" IN-BOOTH-PSEUDO)>

^L

;"INSIDE THE COMPUTER"

<GLOBAL MINI-ACTIVATED <>>

<ROUTINE I-TURNOFF-MINI ()
	 <SETG MINI-ACTIVATED <>>
	 <COND (<EQUAL? ,HERE ,MINI-BOOTH>
		<TELL CR
"A recorded voice says \"Miniaturization booth de-activated.\"" CR>)>>

<ROOM STATION-384
      (IN ROOMS)
      (DESC "Station 384")
      (LDESC
"You are standing on a square plate of heavy metal. Above your head, parallel
to the plate beneath you, is an identical metal plate. To the east is a wide,
metallic strip.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (EAST TO STRIP-NEAR-STATION)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STRIP)
      (PSEUDO "PLATE" PLATE-PSEUDO "PLATES" PLATE-PSEUDO)
      (ACTION STATION-384-F)>

<ROUTINE STATION-384-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (,BEEN-HERE
		       <SETG BEEN-HERE <>>
		       <COND (,COMPUTER-FIXED
			      <TELL
"A voice seems to whisper in your ear \"Main Miniaturization and Teleportation
Booth has malfunctioned...switching to Auxiliary Booth...\" ">
	                      <ENABLE <QUEUE I-ANNOUNCEMENT 130>>
			      <TELL ,FAMILIAR-WRENCHING CR>
			      <GOTO ,AUXILIARY-BOOTH>
			      <RFATAL>)
			     (T
			      <TELL ,FAMILIAR-WRENCHING CR>
			      <GOTO ,MINI-BOOTH <>>)>)>)>>

<ROUTINE I-ANNOUNCEMENT ()
	 <TELL CR "A recorded announcement blares from the public address
system. \"Revival procedure beginning. Cryo-chamber access from Project
Control Office now open.\"" CR>>

<GLOBAL BEEN-HERE <>>

<GLOBAL COMPUTER-FIXED <>>

<GLOBAL FAMILIAR-WRENCHING
"You feel the familiar wrenching of your innards, and find yourself in a vast
room whose distant walls are rushing straight toward you...|">

<ROOM STRIP-NEAR-STATION
      (IN ROOMS)
      (DESC "Strip Near Station")
      (LDESC
"You are standing on a silicon filament, which looks to you like a wide
metal highway. South of here, the filament makes a right angle and heads
straight down, like a cliff overlooking a black void. The filament can be
followed north, however. Station 384 lies westward.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (SOUTH "The plunge would probably be fatal.")
      (EAST "The plunge would probably be fatal.")
      (NORTH TO MIDDLE-OF-STRIP)
      (WEST TO STATION-384)
      (FLAGS RLANDBIT ONBIT)
      (VALUE 4)
      (PSEUDO "VOID" VOID-PSEUDO)
      (GLOBAL STRIP)>

<ROOM MIDDLE-OF-STRIP
      (IN ROOMS)
      (DESC "Middle of Strip")
      (LDESC
"You are standing on a section of the strip with a bottomless void stretching
out on both sides. The strip continues to the north and south.")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH TO STRIP-NEAR-RELAY)
      (SOUTH TO STRIP-NEAR-STATION IF NO-MICROBE ELSE "Not a chance -- unless,
of course, you don't mind walking into the gullet of a hungry microbe.")
      (EAST "Do you have a penchant for bottomless voids?")
      (WEST "Do you have a penchant for bottomless voids?")
      (FLAGS RLANDBIT ONBIT)
      (ACTION MIDDLE-OF-STRIP-F)
      (PSEUDO "VOID" VOID-PSEUDO)
      (GLOBAL STRIP)>

<GLOBAL NO-MICROBE T>

<GLOBAL MICROBE-DISPATCHED <>>

<ROUTINE MIDDLE-OF-STRIP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<AND ,COMPUTER-FIXED
			    ,NO-MICROBE
			    <NOT ,MICROBE-DISPATCHED>>
		       <MOVE ,MICROBE ,HERE>
		       <ENABLE <QUEUE I-MICROBE -1>>
		       <SETG NO-MICROBE <>>
		       <TELL
"Suddenly, with a loud plop, a giant elephant-sized monster lands on the strip
just in front of you. It is amorphously shaped, its skin a slimy translucent
red membrane. While most of your brain screams with panic about the disgusting
monster that now blocks your exit, some small section in the back of your mind
calmly realizes that this is merely some tiny microbe which has somehow
violated the sterile environment of the computer interior.|
|
As you stand frozen with fear, the microbe slithers toward you,
extending slimy pseudopods thick with waving cilia. It looks pretty
hungry, and seems intent on having you for lunch." CR CR>)>)>>

<ROOM STRIP-NEAR-RELAY
      (IN ROOMS)
      (DESC "Strip Near Relay")
      (C-MOVE  <TABLE
         ;"OUT" 0 ;"IN"   0 ;"DOWN" 0  ;"UP"     0
         ;"NW"  0 ;"WEST" 0 ;"SW"   0  ;"SOUTH"  0 
	 ;"SE"  0 ;"EAST" 0 ;"NE"   0  ;"NORTH"  0>)
      (NORTH "There is a huge featureless wall there, remember?")
      (SOUTH TO MIDDLE-OF-STRIP IF NO-MICROBE ELSE "Not a chance -- unless,
of course, you don't mind walking into the gullet of a hungry microbe.")
      (EAST PER RELAY-EXIT-F)
      (WEST "Do you have a penchant for bottomless voids?")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STRIP)
      (PSEUDO "VOID" VOID-PSEUDO)
      (ACTION STRIP-NEAR-RELAY-F)>

<ROUTINE STRIP-NEAR-RELAY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"North of here, the filament ends at a huge featureless wall, presumably the
side of some micro-component. ">
		<COND (<IN? ,RELAY ,HERE>
		       <TELL
"To the east is a vacuu-sealed micro-relay, sealed in transparent red
plastic. You could probably see into the micro-relay." CR>)
		      (T
		       <TELL
"To the east are the shattered remains of some large object." CR>)>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT ,NO-MICROBE>>
		<MOVE ,MICROBE ,HERE>
		<SETG MICROBE-COUNTER 0>
		<TELL
"The microbe, writhing angrily, follows you northward." CR>)>>

<ROUTINE RELAY-EXIT-F ()
	 <COND (<IN? ,RELAY ,HERE>
		<TELL
"The relay is sealed. Although you cannot enter it, you could look into
it." CR>
		<RFALSE>)
	       (T
		<TELL
"You would slice yourself to ribbons on the shattered relay." CR>
		<RFALSE>)>>

<OBJECT RELAY
	(IN STRIP-NEAR-RELAY)
	(DESC "micro-relay")
	(SYNONYM MICRO RELAY)
	(ADJECTIVE MICRO)
	(FLAGS NDESCBIT TRANSBIT)
	(ACTION RELAY-F)>

<ROUTINE RELAY-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"This is a vacuum-sealed micro-relay, encased in red translucent plastic.">
		<COND (<NOT ,COMPUTER-FIXED>
		      <TELL
" Within, you can see that some sort of speck or impurity has wedged itself
into the contact point of the relay, preventing it from closing. The speck,
presumably of microscopic size, resembles a blue boulder to you in your
current size.">)>
		<TELL CR>)>>

<OBJECT SPECK
	(IN RELAY)
	(DESC "speck")
	(SYNONYM SPECK BOULDER IMPURITY)
	(ADJECTIVE BLUE)
	(FLAGS NDESCBIT)>

^L

;"Laserium"

<OBJECT LASER
	(IN TOOL-ROOM)
	(DESC "laser")
	(FDESC
"A small device, labelled \"Akmee Portabul Laazur\", is resting on one of
the lower shelves.")
	(SYNONYM DEVICE LASER UNIT DEPRES)
	(ADJECTIVE PORTABLE ACME)
	(SIZE 25)
	(CAPACITY 5)
	(FLAGS MUNGBIT TAKEBIT OPENBIT TRANSBIT CONTBIT)
	(ACTION LASER-F)>

<OBJECT LASER-DIAL
	(IN LASER)
	(DESC "laser setting dial")
	(SYNONYM DIAL)
	(ADJECTIVE LASER SETTING)
	(FLAGS MUNGBIT NDESCBIT)
	(ACTION LASER-DIAL-F)>

<ROUTINE LASER-DIAL-F ()
	 <COND (<AND <VERB? SET>
		     <EQUAL? ,PRSI ,INTNUM>>
		<COND (<FSET? ,LASER-DIAL ,MUNGEDBIT>
		       <TELL
"The laser dial seems to have become damaged and will not turn." CR>)
		      (<EQUAL? ,P-NUMBER ,LASER-SETTING>
		       <TELL "That's where it's set now!" CR>)
		      (<OR <G? ,P-NUMBER 6>
			   <EQUAL? ,P-NUMBER 0>>
		       <TELL "The dial can only be set from 1 to 6." CR>)
		      (T
		       <SETG LASER-SETTING ,P-NUMBER>
		       <TELL "The dial is now set to " N ,P-NUMBER "." CR>)>)
	       (<VERB? EXAMINE>
		<TELL "The dial is currently set to " N ,LASER-SETTING "." CR>)>>

<OBJECT OLD-BATTERY
	(IN LASER)
	(DESC "old battery")
	(LDESC "There is a worn-out laser battery here.")
	(SYNONYM BATTERY)
	(ADJECTIVE LASER WORN-OUT OLD)
	(SIZE 5)
	(FLAGS VOWELBIT ACIDBIT TAKEBIT)>

<OBJECT NEW-BATTERY
	(IN LAB-STORAGE)
	(DESC "new battery")
	(FDESC
"The odds and ends on the shelves include a small round object, which closer
inspection reveals to be a fresh laser battery.")
	(SYNONYM OBJECT BATTERY)
	(ADJECTIVE LASER SMALL ROUND FRESH NEW)
	(SIZE 5)
	(FLAGS ACIDBIT TAKEBIT)>

<GLOBAL LASER-SETTING 5> ;"dial on laser -- 1 is red, 2 is orange, etc."

<GLOBAL SPECK-HIT <>> ;"set to T first time you hit speck, takes two hits"

<GLOBAL OLD-SHOTS 0> ;"number of shots left in the old-battery"

<GLOBAL NEW-SHOTS 0> ;"number of shots left in the new-battery"

<ROUTINE ZAP-COUNT () ;"checks to see if if have any shots left"
	 <COND (<IN? ,OLD-BATTERY ,LASER>
		<COND (<G? ,OLD-SHOTS 0>
		       <SETG OLD-SHOTS <- ,OLD-SHOTS 1>>
		       <RFALSE>)>
		<RTRUE>)
	       (<IN? ,NEW-BATTERY ,LASER>
		<COND (<G? ,NEW-SHOTS 0>
		       <SETG NEW-SHOTS <- ,NEW-SHOTS 1>>
		       <RFALSE>)>
		<RTRUE>)
	       (T <RTRUE>)>>

<ROUTINE LASER-F ("OPTIONAL" (RARG <>))
	 <COND (<AND <VERB? SET>
		     <EQUAL? ,PRSI ,INTNUM>>
		<PERFORM ,V?SET ,LASER-DIAL ,PRSI>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The laser, though portable, is still fairly heavy. It has a long, slender
barrel and a dial with six settings, labelled \"1\" through \"6.\" This dial
is currently on setting " N ,LASER-SETTING ". There is a depression on the
top of the laser which ">
		<COND (<IN? ,OLD-BATTERY ,LASER>
		       <TELL "contains an " D ,OLD-BATTERY>)
		      (<IN? ,NEW-BATTERY ,LASER>
		       <TELL "contains a " D ,NEW-BATTERY>)
		      (T
		       <TELL "is empty">)>
		<TELL "." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"There doesn't seem to be any way to do that to this laser." CR>)
	       (<VERB? PUT>
		<COND (<EQUAL? ,PRSO ,OLD-BATTERY>
		       <COND (<IN? ,NEW-BATTERY ,LASER>
			      <ALREADY-BATTERY>)
			     (T
			      <MOVE ,OLD-BATTERY ,LASER>
			      <BATTERY-NOW>)>)
		      (<EQUAL? ,PRSO ,NEW-BATTERY>
		       <COND (<IN? ,OLD-BATTERY ,LASER>
			      <ALREADY-BATTERY>)
			     (T
			      <MOVE ,NEW-BATTERY ,LASER>
			      <BATTERY-NOW>)>)
		      (<NOT <EQUAL? ,LASER ,PRSO>>
		       <TELL
"The " D ,PRSO " doesn't fit the depression." CR>)>)
	       (<VERB? ZAP>
		<COND (<NOT <IN? ,LASER ,ADVENTURER>>
		       <NOT-HOLDING>
		       <RTRUE>)>
		<COND (<NOT ,LASER-SCORE-FLAG>
		       <SETG LASER-SCORE-FLAG T>
		       <SETG SCORE <+ ,SCORE 2>>)>
		<COND (<OR <EQUAL? ,PRSI ,LASER>
				  <EQUAL? ,PRSI ,LASER-DIAL>
				  <AND <EQUAL? ,PRSI ,OLD-BATTERY>
				       <IN? ,OLD-BATTERY ,LASER>>
				  <AND <EQUAL? ,PRSI ,NEW-BATTERY>
				       <IN? ,NEW-BATTERY ,LASER>>>
			      <TELL
"Sorry, the laser doesn't have a rubber barrel." CR>)
		      (<ZAP-COUNT>
		       <TELL "Click." CR>)
		      (<FSET? ,LASER ,MUNGEDBIT>
		       <TELL
"The laser sparks a few times, whines, and then stops." CR>)
		      (T
		       <ENABLE <QUEUE I-WARMTH -1>>
		       <SETG LASER-JUST-SHOT T>
		       <COND (<EQUAL? ,PRSI ,SPECK>
			      <SHOOT-SPECK>
			      <RTRUE>)
			     (<EQUAL? ,PRSI ,MICROBE>
			      <SHOOT-MICROBE>
			      <RTRUE>)
			     (<EQUAL? ,PRSI ,ME ,HANDS ,ADVENTURER>
			      <TELL
"Ouch! You managed to burn yourself nicely." CR>)
			     (T
			      <TELL "The laser emits a narrow ">
			      <BEAM-COLOR>
			      <TELL " beam of light">
			      <COND (,PRSI
				     <COND (<OR <EQUAL? ,PRSI
                                                        ,TOWEL
						        ,BROCHURE
						        ,COMBINATION-PAPER>
						<EQUAL? ,PRSI
							,PRINT-OUT
							,LAB-UNIFORM
							,PATROL-UNIFORM>
						<EQUAL? ,PRSI
							,ID-CARD
							,KITCHEN-CARD
							,MINI-CARD>
						<EQUAL? ,PRSI
							,TELEPORTATION-CARD
							,SHUTTLE-CARD
							,UPPER-ELEVATOR-CARD>
						<EQUAL? ,PRSI
							,LOWER-ELEVATOR-CARD>>
					    <REMOVE ,PRSI>
					    <COND (<EQUAL? ,PRSI
							   ,SPOUT-PLACED>
						   <SETG SPOUT-PLACED
							 ,GROUND>)>
					    <TELL
" which strikes the " D ,PRSI ". The " D ,PRSI " bursts into flame,
blinding you momentarily, and is quickly consumed." CR>)
					   (<AND <EQUAL? ,PRSI ,FLOYD>
						 <FSET? ,FLOYD ,RLANDBIT>>
					    <TELL
" which strikes Floyd. \"Yow!\" yells Floyd. He jumps to the other end
of the room and eyes you warily." CR>)
					   (<AND <EQUAL? ,PRSI ,PSEUDO-OBJECT>
						<EQUAL? ,HERE ,PROJCON-OFFICE>>
					    <TELL
" which strikes the " D ,PRSI ". However, this doesn't seem to affect it." CR>)
					   (T
					    <TELL
" which strikes the " D ,PRSI ". The " D ,PRSI " grows a bit warm, but
nothing else happens." CR>)>)
				    (T
				     <TELL "." CR>)>)>)>)
	       (<VERB? DROP>
		<DISABLE <INT I-WARMTH>>
		<COND (<AND <IN? ,MICROBE ,HERE>
			    <G? ,WARMTH-FLAG 7>>
		       <REMOVE ,LASER>
		       <TELL
"The microbe rushes to envelop the laser. You hear a faint burp as the
monster begins to look around for other morsels..." CR>)
		      (T
		       <RFALSE>)>)>>

<ROUTINE ALREADY-BATTERY ()
	 <TELL "There's already a battery there." CR>>

<ROUTINE BATTERY-NOW ()
	 <TELL "The battery is now resting in the depression, attached
to the laser." CR>>

;<ROUTINE LASER-CONTENTS ()
	  <TELL "The laser ">
	  <COND (<IN? ,OLD-BATTERY ,LASER>
		 <TELL "contains an " D ,OLD-BATTERY>)
		(<IN? ,NEW-BATTERY ,LASER>
		 <TELL "contains a " D ,NEW-BATTERY>)
		(T
		 <TELL "is empty">)>
	  <TELL "." CR>>

<GLOBAL WARMTH-FLAG 0>

<GLOBAL LASER-JUST-SHOT <>>

<ROUTINE I-WARMTH ()
	 <COND (,LASER-JUST-SHOT
		<SETG LASER-JUST-SHOT <>>
		<SETG WARMTH-FLAG <+ ,WARMTH-FLAG 1>>
		<COND (<EQUAL? ,WARMTH-FLAG 3>
		       <LASER-FEELS "slightly warm now">)
		      (<EQUAL? ,WARMTH-FLAG 6>
		       <LASER-FEELS "somewhat warm now">)
		      (<EQUAL? ,WARMTH-FLAG 9>
		       <LASER-FEELS "very warm now">)
		      (<EQUAL? ,WARMTH-FLAG 12>
		       <LASER-FEELS "quite hot">)>)
	       (T
		<COND (<EQUAL? ,WARMTH-FLAG 0>
		       <DISABLE <INT I-WARMTH>>)
		      (T
		       <SETG WARMTH-FLAG <- ,WARMTH-FLAG 1>>
		       <COND (<EQUAL? ,WARMTH-FLAG 12>
			      <LASER-COOLS "quite hot">)
			     (<EQUAL? ,WARMTH-FLAG 9>
			      <LASER-COOLS "very warm">)
			     (<EQUAL? ,WARMTH-FLAG 6>
			      <LASER-COOLS "somewhat warm">)
			     (<EQUAL? ,WARMTH-FLAG 3>
			      <LASER-COOLS "slightly warm">)>)>)>>

<ROUTINE LASER-FEELS (STRING)
	 <TELL CR
"The laser feels " .STRING
", but that doesn't seem to affect its performance at all." CR>>

<ROUTINE LASER-COOLS (STRING)
	 <TELL CR
"The laser has cooled, but it still feels " .STRING "." CR>>

<GLOBAL LASER-SCORE-FLAG <>>

<GLOBAL MARKSMANSHIP-COUNTER 0>

<ROUTINE BEAM-COLOR ()
	 <COND (<EQUAL? ,LASER-SETTING 1>
	        <TELL "red">)
               (<EQUAL? ,LASER-SETTING 2>
	        <TELL "orange">)
	       (<EQUAL? ,LASER-SETTING 3>
		<TELL "yellow">)
	       (<EQUAL? ,LASER-SETTING 4>
	        <TELL "green">)
	       (<EQUAL? ,LASER-SETTING 5>
		<TELL "blue">)
	       (<EQUAL? ,LASER-SETTING 6>
		<TELL "violet">)>>

<ROUTINE SHOOT-SPECK ()
	<COND (<EQUAL? ,LASER-SETTING 1>
	       <COND (<PROB ,MARKSMANSHIP-COUNTER>
		      <COND (,SPECK-HIT
			     <SETG COMPUTER-FIXED T>
			     <FSET ,CRYO-ELEVATOR-DOOR ,OPENBIT>
			     <FCLEAR ,PROJCON-OFFICE ,TOUCHBIT>
			     <FCLEAR ,CRYO-ELEVATOR-DOOR ,INVISIBLE>
			     <ENABLE <QUEUE I-FRY 200>>
			     <SETG SCORE <+ ,SCORE 8>>
			     <REMOVE ,SPECK>
			     <TELL
"The beam hits the speck again! This time, it vaporizes into a fine cloud
of ash. The relay slowly begins to close, and a voice whispers in your ear
\"Sector 384 will activate in 200 millichrons. Proceed to exit station.\"" CR>)
			    (T
			     <SETG SPECK-HIT T>
			     <TELL
"The speck is hit by the beam! It sizzles a little,
but isn't destroyed yet." CR>)>)
		     (T
		      <SETG MARKSMANSHIP-COUNTER <+ ,MARKSMANSHIP-COUNTER 12>>
		      <TELL <PICK-ONE ,BEAM-MISSES> CR>)>)
	      (T
	       <REMOVE ,RELAY>
	       <TELL "A thin ">
	       <BEAM-COLOR>
	       <TELL
" beam shoots from the laser and slices through the red plastic covering of
the relay like a hot knife through butter. Air rushes into the relay, which
collapses into a heap of plastic shards." CR>)>>

<GLOBAL BEAM-MISSES
	<PLTABLE
	 "The beam just misses the speck!"
	 "A near miss!"
	 "A good shot, but just a little wide of the target.">>

<ROUTINE I-FRY ()
	 <COND (<EQUAL? ,HERE ,MIDDLE-OF-STRIP
			      ,STRIP-NEAR-STATION
			      ,STRIP-NEAR-RELAY>
		<CRLF>
		<JIGS-UP
"|
With a furious storm of electrical mayhem, Sector 384 comes to life. A
few micro-volts course through the silicon strip on which you stand.
Unfortunately, at your current size, this is enough to barbecue you.">)>>

^L

;"The microbe battle"

<OBJECT MICROBE
	(DESC "microbe")
	(LDESC 
"A hungry microbe blocks your way, its cilia waving and its pseudopods
towering over you.")
	(SYNONYM MICROBE BUG MONSTER)
	(ADJECTIVE HUNGRY)
	(FLAGS ACTORBIT)
	(ACTION MICROBE-F)>

<ROUTINE MICROBE-F ()
	 <COND (<VERB? TELL HELLO TALK>
		<TELL
"You don't seem to have bridged the vast communication gulf
between yourself and the microbe." CR>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<RFATAL>)
	       (<AND <VERB? THROW GIVE>
		     <EQUAL? ,PRSI ,MICROBE>>
		<COND (<AND <EQUAL? ,PRSO ,LASER>
			    <G? ,WARMTH-FLAG 7>>
		       <REMOVE ,LASER>
		       <DISABLE <INT I-WARMTH>>
		       <COND (<G? ,WARMTH-FLAG 10>
			      <DISABLE <INT I-MICROBE>>
			      <TELL
"The microbe gobbles up the laser and turns toward you. A moment later,
it begins writhing in pain. Apparently, eating the hot laser was a bit
too much for it. With a bellow of agony, it rolls off the edge of
the strip. (Whew!)" CR>
		             <REMOVE ,LASER>
		             <REMOVE ,MICROBE>
		             <SETG NO-MICROBE T>
			     <SETG MICROBE-DISPATCHED T>)
			     (T
			      <TELL
"The microbe greedily devours the laser, and turns toward you." CR>)
		      (T
		       <TELL
"The microbe ignores the " D ,PRSO ", but does attempt to digest
your arm." CR>)>)>)>>

<ROUTINE I-MICROBE ()
	 <COND (<EQUAL? ,MICROBE-HIT T>
	        <TELL CR <PICK-ONE ,WINNER-ATTACKED>>
	        <COND (<AND <G? ,WARMTH-FLAG 13>
			    <IN? ,LASER ,ADVENTURER>>
		       <JIGS-UP
" The microbe, whipped into a rabid frenzy by the waves of heat from the
pulsing laser, literally lunges at it. You jump back and, losing your
balance, fall over the edge of the strip. The microbe, writhing madly, hurls
itself after its prey. You and the microbe both plunge into the void below.">)
		      (<AND <G? ,WARMTH-FLAG 7>
			    <IN? ,LASER ,ADVENTURER>>
		       <TELL 
" Another pseudopod, perhaps attracted by the warmth of the laser, tries to
envelop the weapon. You snatch it away from the monster's grasp.">)>
		<CRLF>)
	       (T
		<COND (<EQUAL? ,MICROBE-COUNTER 2>
		       <JIGS-UP
"|
The microbe wraps several pseudopods around you and shoves you into its
mucus-covered gullet. Digestive juices begin their work. The experience
is not pleasant.">)
		      (T
		       <SETG MICROBE-COUNTER <+ ,MICROBE-COUNTER 1>>
		       <TELL CR <PICK-ONE ,MONSTER-CLOSES> CR>)>)>
	 <SETG MICROBE-HIT <>>>

<GLOBAL WINNER-ATTACKED
	<PLTABLE
	 "A pseudopod extends toward you. You jump back just in time
to avoid being engulfed."
	 "A slimy pseudopod brushes against your shoulder. You twist
away in the nick of time."
	 "A pseudopod shoots out toward your head! Ducking quickly,
you save your life."
         "Two protoplasm-filled blobs sneak toward you from the left.
You jump to the side and almost fall off the strip into the void below!">>

<GLOBAL MONSTER-CLOSES
	<PLTABLE
	 "The microbe slithers closer. The cilia around its gullet glisten
with mucus, giving the impression that the microbe is salivating."
         "The microbe flows toward you. It towers above you, its cilia
waving madly in your face."
	 "The monster wriggles nearer. It is now so close that you can make
out details in the protoplasm beneath its translucent skin.">>

<GLOBAL MICROBE-HIT <>>

<GLOBAL MICROBE-COUNTER 0>

<ROUTINE SHOOT-MICROBE ()
	 <TELL "The laser beam strikes the microbe">
	 <COND (<EQUAL? ,LASER-SETTING 1>
		<TELL ", but passes harmlessly through its red skin." CR>)
	       (T
		<SETG MICROBE-HIT T>
		<TELL ". ">
		<TELL <PICK-ONE ,MICROBE-STRIKES> CR>)>>

<GLOBAL MICROBE-STRIKES
	<PLTABLE
	 "The microbe's outer membrane sizzles a bit, and some protoplasm
oozes out. The microbe recoils momentarily, but quickly recovers."
	 "The beam slices through the microbe's skin! A tremendous shudder
passes through the microbe, but the wound quickly seals itself."
         "The monster rears back for a moment, but almost as soon as the
beam goes off, it advances again.">> 

<OBJECT STRIP
	(IN LOCAL-GLOBALS)
	(DESC "silicon strip")
	(SYNONYM STRIP SIDE EDGE)
	(ADJECTIVE SILICON)
	(FLAGS NDESCBIT)
	(ACTION STRIP-F)>

<ROUTINE STRIP-F ()
	 <COND (<VERB? THROW-OFF>
		<COND (<AND <EQUAL? ,PRSO ,LASER>
			    <G? ,WARMTH-FLAG 7>>
		       <DISABLE <INT I-WARMTH>>
		       <DISABLE <INT I-MICROBE>>
		       <TELL
"As the laser flies over the edge of the strip, the hungry microbe lunges after
it. Both the laser and the microbe plummet into the void. (Whew!)" CR>
		       <REMOVE ,LASER>
		       <REMOVE ,MICROBE>
		       <SETG NO-MICROBE T>
		       <SETG MICROBE-DISPATCHED T>)
		      (T
		       <COND (<EQUAL? ,PRSO ,LASER>
			      <DISABLE <INT I-WARMTH>>)>
		       <REMOVE ,PRSO>
		       <TELL
"The " D ,PRSO " flies over the edge of the strip and disappears into the
void." CR>)>)>>

^L

;"Endgame -- The mutant chase scene"

<OBJECT RAT-ANT
	(IN BIO-LAB)
	(DESC "rat-like, ant-like man-sized monster")
	(LDESC "A ferocious feral creature, with a hairy shelled body and
a whip-like tail snaps its enormous mandibles at you.")
	(SYNONYM MONSTER MUTANT RAT-ANT)
	(ADJECTIVE RAT-LIKE ANT-LIKE MAN-SIZED)
	(FLAGS ACTORBIT)>

<OBJECT TROLL
	(IN BIO-LAB)
	(DESC "hairy growling biped")
	(LDESC "Rushing toward you is an ugly, deformed humanoid, bellowing
in a guttural tongue. It brandishes a piece of lab equipment shaped
somewhat like a battle axe.")
	(SYNONYM TROLL BIPED MUTANT MONSTER)
	(ADJECTIVE HAIRY GROWLING UGLY DEFORMED)
	(FLAGS ACTORBIT)>

<OBJECT GRUE
	(IN BIO-LAB)
	(DESC "lurking fanged creature")
	(LDESC "Lurking nearby is a vicious-looking creature with slavering
fangs. Squinting in the light, it eyes you hungrily.")
	(SYNONYM GRUE CREATURE MUTANT MONSTER)
	(ADJECTIVE LURKING SINISTER FANGED VICIOUS HUNGRY SILENT)
	(FLAGS ACTORBIT)
	(ACTION GRUE-F)>

<ROUTINE GRUE-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <NOT <IN? ,GRUE ,HERE>>>
		<TELL
"Grues are vicious, carnivorous beasts first introduced to Earth by a
visiting alien spaceship during the late 22nd century. Grues spread throughout
the galaxy alongside man. Although now extinct on all civilized planets,
they still exist in some backwater corners of the galaxy. Their favorite diet
is Ensigns Seventh Class, but their insatiable appetite is tempered by their
fear of light." CR>)>>

<OBJECT TRIFFID
	(IN BIO-LAB)
	(DESC "mobile man-eating plant")
	(LDESC "A giant plant, teeming with poisonous tentacles, is shuffling
toward you on three leg-like stalks.")
	(SYNONYM TRIFFID PLANT MUTANT MONSTER)
	(ADJECTIVE MOBILE MAN-EATING GIANT)
	(FLAGS ACTORBIT)>