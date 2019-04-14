

	.FUNCT	UNDERWATER-F,RARG
	EQUAL?	RARG,M-END \FALSE
	IGRTR?	'DROWN,2 \FALSE
	CALL	JIGS-UP,STR?101
	RSTACK	


	.FUNCT	CRAG-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	SET	'DROWN,3
	RETURN	DROWN


	.FUNCT	BALCONY-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is an octagonal room, half carved into and half built out from the cliff wall. Through the shattered windows which ring the outer wall you can see ocean to the horizon. A weathered metal plaque with barely readable lettering rests below the windows. The language seems to be a corrupt form of Galalingua. A steep stairway, roughly cut into the face of the cliff, leads upward. "
	EQUAL?	DAY,1 \?CCL6
	PRINTR	"A rocky crag can be seen about eight meters below."
?CCL6:	EQUAL?	DAY,2 \?CCL8
	PRINTR	"The ocean waters swirl below. The crag where you landed yesterday is now underwater!"
?CCL8:	EQUAL?	DAY,3 \FALSE
	PRINTR	"Ocean waters are lapping at the base of the balcony."


	.FUNCT	WINDING-STAIR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The middle of a long, steep stairway carved into the face of a cliff."
	EQUAL?	DAY,4 \?CCL6
	PRINTR	" You hear the lapping of water from below."
?CCL6:	EQUAL?	DAY,5 \?CND4
	PRINTR	" You can see ocean water splashing against the steps below you."
?CND4:	CRLF	
	RTRUE	


	.FUNCT	COURTYARD-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in the courtyard of an ancient stone edifice, vaguely reminiscent of the castles you saw during your leave on Ramos Two. It has decayed to the point where it can probably be termed a ruin. Openings lead north and west, and a stairway downward is visible to the south. "
	EQUAL?	DAY,6,7 \?CCL6
	PRINTR	"From the direction of the stairway comes the sound of ocean surf."
?CCL6:	EQUAL?	DAY,8 \?CND4
	PRINTR	"Ocean water washes against the top few steps."
?CND4:	CRLF	
	RTRUE	


	.FUNCT	WATER-LEVEL-F
	EQUAL?	HERE,BALCONY \?CCL3
	EQUAL?	DAY,1 \?CCL6
	RETURN	CRAG
?CCL6:	RETURN	UNDERWATER
?CCL3:	EQUAL?	HERE,WINDING-STAIR \?CCL8
	LESS?	DAY,4 \?CCL11
	RETURN	BALCONY
?CCL11:	RETURN	UNDERWATER
?CCL8:	EQUAL?	HERE,COURTYARD \FALSE
	LESS?	DAY,6 \?CCL16
	RETURN	WINDING-STAIR
?CCL16:	RETURN	UNDERWATER


	.FUNCT	REC-AREA-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a recreational facility of some sort. Games and tapes are scattered about the room. Hallways head off to the east and south, and to the north is a door which is "
	FSET?	CONFERENCE-DOOR,OPENBIT \?CCL6
	PRINTI	"open"
	JUMP	?CND4
?CCL6:	PRINTI	"closed and locked. A dial on the door is currently set to "
	PRINTN	DIAL-NUMBER
?CND4:	PRINTR	"."


	.FUNCT	CONFERENCE-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a fairly square room, almost filled by a round conference table. To the south is a door which is "
	CALL	DDESC,CONFERENCE-DOOR
	PRINTR	". To the north is a small room about the size of a phone booth."


	.FUNCT	COMBINATION-DIAL-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The dial can be turned to any number between 0 and 1000."
?CCL3:	EQUAL?	PRSA,V?SET \FALSE
	EQUAL?	PRSI,INTNUM \FALSE
	FSET?	COMBINATION-DIAL,MUNGEDBIT \?CCL10
	PRINTR	"The dial has somehow become fused and won't move."
?CCL10:	EQUAL?	P-NUMBER,DIAL-NUMBER \?CCL12
	PRINTR	"That's what the dial is set to now!"
?CCL12:	EQUAL?	P-NUMBER,NUMBER-NEEDED \?CCL14
	SET	'DIAL-NUMBER,0
	FSET	CONFERENCE-DOOR,OPENBIT
	PRINTR	"The door swings open, and the dial resets to 0."
?CCL14:	GRTR?	P-NUMBER,1000 \?CCL16
	PRINTR	"The dial cannot be turned to a number that high."
?CCL16:	SET	'DIAL-NUMBER,P-NUMBER
	PRINTI	"The dial is now set to "
	PRINTN	P-NUMBER
	PRINTR	"."


	.FUNCT	CONFERENCE-DOOR-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	CONFERENCE-DOOR,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	EQUAL?	HERE,REC-AREA \?CCL9
	PRINTR	"The door is locked. You probably have to turn the dial to some number to open it."
?CCL9:	PRINTR	"The door seems to be locked from the other side."
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	CONFERENCE-DOOR,OPENBIT \?CCL14
	FCLEAR	CONFERENCE-DOOR,OPENBIT
	PRINTR	"The door closes and you hear a click as it locks."
?CCL14:	CALL	IS-CLOSED
	RSTACK	


	.FUNCT	MESS-CORRIDOR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a wide, east-west hallway with a large portal to the south. A small door to the north is "
	CALL	DDESC,STORAGE-WEST-DOOR
	ZERO?	PADLOCK-REMOVED \?CND4
	PRINTI	" and hooked with a simple steel padlock"
	FSET?	PADLOCK,OPENBIT \?CCL8
	PRINTI	" which hangs unlocked"
	JUMP	?CND4
?CCL8:	PRINTI	" which is also closed"
?CND4:	PRINTR	"."


	.FUNCT	STORAGE-WEST-DOOR-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	STORAGE-WEST-DOOR,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	ZERO?	PADLOCK-REMOVED /?CCL8
	FSET	STORAGE-WEST-DOOR,OPENBIT
	PRINTR	"Opened."
?CCL8:	PRINTR	"The door cannot be opened until the padlock is removed."
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL10
	FSET?	STORAGE-WEST-DOOR,OPENBIT \?CCL13
	FCLEAR	STORAGE-WEST-DOOR,OPENBIT
	PRINTR	"The door is now closed."
?CCL13:	CALL	IS-CLOSED
	RSTACK	
?CCL10:	EQUAL?	PRSA,V?UNLOCK \FALSE
	PRINTI	"The door itself isn't locked."
	FSET?	PADLOCK,OPENBIT /?CND16
	PRINTR	" It is the padlock on the door which is locked."
?CND16:	CRLF	
	RTRUE	


	.FUNCT	PADLOCK-F
	EQUAL?	HERE,BRIG \?CCL3
	PRINTR	"You can't see or reach the lock from inside the cell."
?CCL3:	EQUAL?	PRSA,V?OPEN-WITH \?CCL5
	EQUAL?	PADLOCK,PRSO \?CCL5
	CALL	PERFORM,V?UNLOCK,PADLOCK,PRSI
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?OPEN,V?UNLOCK \?CCL9
	FSET?	PADLOCK,OPENBIT /?CCL12
	ZERO?	PRSI \?CCL15
	PRINTR	"You can't open it with your hands."
?CCL15:	EQUAL?	PRSI,KEY \?CCL17
	FSET?	PADLOCK,MUNGEDBIT \?CCL20
	PRINTR	"Tsk, tsk ... the padlock seems to be fused shut."
?CCL20:	FSET	PADLOCK,OPENBIT
	PRINTR	"The padlock springs open."
?CCL17:	PRINTR	"That doesn't work."
?CCL12:	PRINTR	"The padlock is already unlocked."
?CCL9:	EQUAL?	PRSA,V?LOCK,V?CLOSE \?CCL22
	FSET?	PADLOCK,OPENBIT \?CCL25
	FCLEAR	PADLOCK,OPENBIT
	PRINTR	"The padlock closes with a sharp click."
?CCL25:	PRINTR	"The padlock is already locked."
?CCL22:	EQUAL?	PRSA,V?TAKE \?CCL27
	ZERO?	PADLOCK-REMOVED \?CCL27
	FSET?	PADLOCK,OPENBIT \?CCL32
	SET	'PADLOCK-REMOVED,TRUE-VALUE
	FCLEAR	PADLOCK,TRYTAKEBIT
	FCLEAR	PADLOCK,NDESCBIT
	RFALSE	
?CCL32:	FSET?	PADLOCK,OPENBIT /FALSE
	PRINTR	"The padlock is locked to the door."
?CCL27:	EQUAL?	PRSA,V?MUNG \FALSE
	PRINTR	"And, as we go into the next round, it's Padlock 1, Adventurer 0..."


	.FUNCT	CAN-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"This is a rather normal tin can. It is large and is labelled ""Spam and Egz."""
?CCL3:	EQUAL?	PRSA,V?OPEN \FALSE
	PRINTR	"You certainly can't open it with your hands, and you don't seem to have found a can opener yet."


	.FUNCT	LADDER-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	ZERO?	LADDER-EXTENDED /FALSE
	PRINTR	"You can't possibly carry the ladder while it's extended."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL8
	PRINTI	"It is a heavy-duty ladder built of sturdy aluminum tubing. It is currently "
	ZERO?	LADDER-EXTENDED /?CCL11
	PRINTR	"extended to its full length of about 8 meters, but could be collapsed to a shorter length for easier carrying."
?CCL11:	PRINTR	"collapsed and is around two-and-a-half meters long, but if extended would obviously be much longer."
?CCL8:	EQUAL?	PRSA,V?OPEN \?CCL13
	ZERO?	LADDER-EXTENDED /?CCL16
	PRINTR	"The ladder is already extended."
?CCL16:	EQUAL?	HERE,STORAGE-EAST,STORAGE-WEST,BOOTH-2 /?CTR17
	EQUAL?	HERE,UPPER-ELEVATOR,LOWER-ELEVATOR \?CCL18
?CTR17:	PRINTR	"You can't extend the ladder in this tiny space!"
?CCL18:	IN?	LADDER,ADVENTURER \?CCL22
	PRINTR	"You couldn't possibly extend the ladder while you're holding it."
?CCL22:	FSET	LADDER,TRYTAKEBIT
	SET	'LADDER-EXTENDED,TRUE-VALUE
	SET	'C-ELAPSED,36
	PRINTR	"The ladder extends to a length of around eight meters."
?CCL13:	EQUAL?	PRSA,V?CLOSE \?CCL24
	ZERO?	LADDER-EXTENDED /?CCL27
	SET	'C-ELAPSED,21
	ZERO?	LADDER-FLAG /?CCL30
	SET	'LADDER-FLAG,FALSE-VALUE
	REMOVE	LADDER
	PRINTR	"As the ladder shortens it plunges into the rift."
?CCL30:	SET	'LADDER-EXTENDED,FALSE-VALUE
	FCLEAR	LADDER,TRYTAKEBIT
	PRINTR	"The ladder collapses to a length of around two-and-a-half meters."
?CCL27:	PRINTR	"The ladder is already in its collapsed state."
?CCL24:	EQUAL?	PRSA,V?ATTRACT,V?SPAN \?CCL32
	EQUAL?	PRSI,RIFT \?CCL32
	ZERO?	LADDER-FLAG /?CCL37
	PRINTR	"The ladder already spans the rift."
?CCL37:	ZERO?	LADDER-EXTENDED /?CCL40
	SET	'LADDER-FLAG,TRUE-VALUE
	FSET	LADDER,NDESCBIT
	PRINTR	"The ladder swings out across the rift and comes to rest on the far edge, spanning the precipice."
?CCL40:	REMOVE	LADDER
	PRINTR	"The ladder, far too short to reach the other edge of the rift, plunges into the rift and is lost forever."
?CCL32:	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	ZERO?	LADDER-FLAG /?CCL45
	PRINTR	"You can't climb a horizontal ladder!"
?CCL45:	IN?	LADDER,ADVENTURER \FALSE
	PRINTR	"That would be a neat trick, considering that you're holding it."


	.FUNCT	MESS-HALL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a large hall lined with tables and benches. An opening to the north leads back to the corridor. A door to the south is "
	CALL	DDESC,KITCHEN-DOOR
	PRINTR	". Next to the door is a small slot."


	.FUNCT	KITCHEN-DOOR-F
	EQUAL?	PRSA,V?OPEN \FALSE
	PRINTR	"A light flashes ""Pleez yuuz kitcin akses kard."""


	.FUNCT	DISPENSER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"This wall-mounted unit contains an octagonal niche beneath a spout. "
	IN?	CANTEEN,DISPENSER \?CND4
	PRINTI	"A canteen is resting in the niche, its mouth lying just below the spout. "
?CND4:	PRINTR	"Above the spout is a button. The machine is labelled ""Hii Prooteen Likwid Dispensur."""
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL7
	CALL	NO-CLOSE
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,CANTEEN \?CCL12
	MOVE	CANTEEN,DISPENSER
	PRINTR	"The canteen fits snugly into the octagonal niche, its mouth resting just below the spout of the machine."
?CCL12:	PRINTR	"It doesn't fit in the niche."


	.FUNCT	HIGH-PROTEIN-F,X=0
	EQUAL?	PRSA,V?EAT \?CCL3
	IN?	CANTEEN,ADVENTURER /?CCL6
	SET	'PRSO,CANTEEN
	CALL	NOT-HOLDING
	RSTACK	
?CCL6:	ZERO?	HUNGER-LEVEL \?CCL9
	PRINT	NOT-HUNGRY
	CRLF	
	RTRUE	
?CCL9:	REMOVE	HIGH-PROTEIN
	SET	'C-ELAPSED,15
	SET	'HUNGER-LEVEL,0
	CALL	QUEUE,I-HUNGER-WARNINGS,3600
	PUT	STACK,0,1
	PRINTR	"Mmmm....that was good. It certainly quenched your thirst and satisfied your hunger."
?CCL3:	EQUAL?	PRSA,V?POUR \FALSE
	EQUAL?	PRSO,HIGH-PROTEIN \FALSE
	IN?	CANTEEN,ADVENTURER /?CCL16
	PRINTR	"Maybe if you were holding the canteen..."
?CCL16:	ZERO?	PRSI \?CND14
	SET	'PRSI,GROUND
?CND14:	EQUAL?	PRSI,FLASK \?CCL20
	CALL	WORTHLESS-ACTION
	RSTACK	
?CCL20:	EQUAL?	PRSI,FUNNEL-HOLE \?CCL22
	IN?	CHEMICAL-FLUID,FLASK \?CND23
	SET	'X,TRUE-VALUE
?CND23:	SET	'CHEMICAL-REQUIRED,10
	REMOVE	HIGH-PROTEIN
	CALL	PERFORM,V?POUR,CHEMICAL-FLUID,FUNNEL-HOLE
	ZERO?	X /TRUE
	MOVE	CHEMICAL-FLUID,FLASK
	RTRUE	
?CCL22:	REMOVE	HIGH-PROTEIN
	PRINTI	"The protein-rich fluid pours over the "
	PRINTD	PRSI
	PRINTR	" and then dries up."


	.FUNCT	WORTHLESS-ACTION
	PRINTR	"A worthless action -- and much too difficult for a poorly-written program like this one to handle."


	.FUNCT	LONG-HALL-F
	PRINTI	"You walk down the long, featureless hallway for a long time. Finally, you see "
	SET	'C-ELAPSED,160
	EQUAL?	HERE,CORRIDOR-JUNCTION \?CCL3
	PRINTI	"some doorways ahead..."
	CRLF	
	CRLF	
	RETURN	DORM-CORRIDOR
?CCL3:	PRINTI	"an intersection ahead..."
	CRLF	
	CRLF	
	RETURN	CORRIDOR-JUNCTION


	.FUNCT	ADMIN-CORRIDOR-S-F,RARG
	EQUAL?	RARG,M-END \FALSE
	FSET?	KEY,INVISIBLE \FALSE
	RANDOM	100
	LESS?	20,STACK /FALSE
	PRINTR	"You catch, out of the corner of your eye, a glint of light from the direction of the floor."


	.FUNCT	CREVICE-F
	EQUAL?	PRSA,V?REACH \?CCL3
	PRINTR	"The crevice is too narrow to reach into."
?CCL3:	EQUAL?	PRSA,V?SEARCH,V?EXAMINE,V?LOOK-INSIDE \FALSE
	FSET?	KEY,TOUCHBIT \?CCL8
	PRINTR	"Nothing there but bunches of dust."
?CCL8:	FCLEAR	KEY,INVISIBLE
	PRINTR	"Lying at the bottom of the narrow crack, partly covered by layers of dust, is a shiny steel key!"


	.FUNCT	KEY-F
	EQUAL?	PRSA,V?MOVE,V?ZATTRACT,V?TAKE \?CCL3
	FSET?	KEY,TOUCHBIT /?CCL3
	EQUAL?	PRSI,PLIERS \?CCL8
	PRINTR	"These are heavy-duty pliers, too large to reach into this narrow crack."
?CCL8:	EQUAL?	PRSI,MAGNET \?CCL10
	CALL	PERFORM,V?ATTRACT,MAGNET,KEY
	RTRUE	
?CCL10:	ZERO?	PRSI /?CCL12
	PRINTR	"Nice try."
?CCL12:	PRINTR	"Either the crevice is too narrow, or your fingers are too large."
?CCL3:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,CREVICE \FALSE
	PRINTR	"And you wonder why you're still only an Ensign Seventh Class?"


	.FUNCT	ADMIN-CORRIDOR-F,RARG
	ZERO?	LADDER-FLAG /?CCL3
	EQUAL?	RARG,M-ENTER \?CCL3
	MOVE	LADDER,HERE
	RTRUE	
?CCL3:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The hallway, in fact the entire building, has been rent apart here, presumably by seismic upheaval. You can see the sky through the severed roof above, and the ground is thick with rubble. To the north is a gaping rift, at least eight meters across and thirty meters deep. "
	ZERO?	LADDER-FLAG /?CND8
	PRINTI	"A metal ladder spans the rift. "
?CND8:	PRINTR	"A wide doorway, labelled ""Sistumz Moniturz,"" leads west."


	.FUNCT	ADMIN-CORRIDOR-N-F,RARG
	ZERO?	LADDER-FLAG /?CCL3
	EQUAL?	RARG,M-ENTER \?CCL3
	MOVE	LADDER,HERE
	RTRUE	
?CCL3:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The corridor ends here. Portals lead west, north, and east. Signs above these portals read, respectively, ""Administraativ Awfisiz,"" ""Tranzportaashun Suplii,"" and ""Plan Ruum."" To the south is a wide rift"
	ZERO?	LADDER-FLAG /?CND8
	PRINTI	", spanned by a metal ladder,"
?CND8:	PRINTR	" separating this area from the rest of the building."


	.FUNCT	LADDER-EXIT-F
	ZERO?	LADDER-FLAG /?CCL3
	SET	'C-ELAPSED,33
	PRINTI	"You slowly make your way across the swaying ladder. You can see sharp, pointy rocks at the bottom of the rift, far below..."
	CRLF	
	CRLF	
	EQUAL?	HERE,ADMIN-CORRIDOR-N \?CCL6
	RETURN	ADMIN-CORRIDOR
?CCL6:	RETURN	ADMIN-CORRIDOR-N
?CCL3:	PRINTI	"The rift is too wide to jump across."
	CRLF	
	RFALSE	


	.FUNCT	RIFT-F
	EQUAL?	PRSA,V?LEAP \?CCL3
	CALL	JIGS-UP,STR?122
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL5
	EQUAL?	RIFT,PRSI \?CCL5
	EQUAL?	PRSO,LASER \?CND8
	CALL	INT,I-WARMTH
	PUT	STACK,0,0
?CND8:	REMOVE	PRSO
	EQUAL?	PRSO,SCRUB-BRUSH \?CCL12
	PRINTR	"You watch with tremendous satisfaction as the brush is lost forever."
?CCL12:	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" sails gracefully into the rift."
?CCL5:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTR	"The rift is at least eight meters wide and more than thirty meters deep. The bottom is covered with sharp and nasty rocks."


	.FUNCT	SYSTEMS-MONITORS-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a large room filled with tables full of strange equipment. "
	CALL	DESCRIBE-MONITORS
	RSTACK	


	.FUNCT	DESCRIBE-MONITORS
	PRINTI	"The far wall is filled with a number of monitors. Of these, the ones labelled "
	ZERO?	DEFENSE-FIXED /?CND1
	PRINTI	"PLANATEREE DEFENS, "
?CND1:	ZERO?	COURSE-CONTROL-FIXED /?CND3
	PRINTI	"PLANATEREE KORS KUNTROOL, "
?CND3:	ZERO?	COMM-FIXED /?CND5
	PRINTI	"KUMUUNIKAASHUNZ, "
?CND5:	PRINTI	"LIIBREREE, REEAKTURZ, and LIIF SUPORT are green, but the one"
	ZERO?	DEFENSE-FIXED /?CCL8
	ZERO?	COURSE-CONTROL-FIXED /?CCL8
	ZERO?	COMM-FIXED \?CND7
?CCL8:	PRINTC	115
?CND7:	PRINTI	" labelled "
	ZERO?	DEFENSE-FIXED \?CND12
	PRINTI	"PLANATEREE DEFENS, "
?CND12:	ZERO?	COURSE-CONTROL-FIXED \?CND14
	PRINTI	"PLANATEREE KORS KUNTROOL, "
?CND14:	ZERO?	COMM-FIXED \?CND16
	PRINTI	"KUMUUNIKAASHUNZ, "
?CND16:	ZERO?	DEFENSE-FIXED /?CCL19
	ZERO?	COURSE-CONTROL-FIXED /?CCL19
	ZERO?	COMM-FIXED \?CND18
?CCL19:	PRINTI	"and "
?CND18:	PRINTI	"PRAJEKT KUNTROOL indicate"
	ZERO?	DEFENSE-FIXED /?CND23
	ZERO?	COURSE-CONTROL-FIXED /?CND23
	ZERO?	COMM-FIXED /?CND23
	PRINTC	115
?CND23:	PRINTR	" a malfunctioning condition."


	.FUNCT	DESK-F
	EQUAL?	PRSA,V?EXAMINE,V?SEARCH \FALSE
	PRINTI	"The desk has a drawer which is currently "
	CALL	DDESC,PRSO
	PRINTR	"."


	.FUNCT	OIL-CAN-F
	EQUAL?	PRSA,V?POUR \?CCL3
	ZERO?	PRSI \?CND4
	SET	'PRSI,GROUND
?CND4:	CALL	PERFORM,V?OIL,PRSI
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EMPTY \FALSE
	PRINTR	"Pretty much impossible -- you could only do that one drop at a time."


	.FUNCT	CARTON-F
	EQUAL?	PRSA,V?CLOSE \FALSE
	CALL	NO-CLOSE
	RTRUE	


	.FUNCT	CRACKED-BOARD-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	EXAMINE-BOARD
	PRINTR	" This one looks as though it's been dropped."


	.FUNCT	GOOD-BEDISTOR-F
	EQUAL?	PRSA,V?TAKE \FALSE
	ZERO?	COURSE-CONTROL-FIXED /FALSE
	CALL	JIGS-UP,STR?137
	RSTACK	


	.FUNCT	REACTOR-ELEVATOR-DOOR-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTR	"It won't budge."


	.FUNCT	I-REACTOR-DOOR-CLOSE
	CALL	QUEUE,I-REACTOR-DOOR-CLOSE,-1
	PUT	STACK,0,1
	EQUAL?	HERE,REACTOR-ELEVATOR /FALSE
	FCLEAR	REACTOR-ELEVATOR-DOOR,OPENBIT
	EQUAL?	HERE,REACTOR-CONTROL \?CND4
	CRLF	
	PRINTI	"The elevator door slides shut."
	CRLF	
?CND4:	CALL	INT,I-REACTOR-DOOR-CLOSE
	PUT	STACK,0,0
	RTRUE	


	.FUNCT	FLASK-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The flask has a wide mouth and looks large enough to hold one or two liters. It is made of glass, or perhaps some tough plastic"
	IN?	CHEMICAL-FLUID,FLASK \?CND4
	PRINTI	", and is filled with a milky white fluid"
?CND4:	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL7
	CALL	NO-CLOSE
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?EMPTY \FALSE
	IN?	CHEMICAL-FLUID,FLASK \FALSE
	EQUAL?	PRSI,FUNNEL-HOLE \FALSE
	CALL	PERFORM,V?POUR,CHEMICAL-FLUID,FUNNEL-HOLE
	RTRUE	


	.FUNCT	MAGNET-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	CALL	QUEUE,I-MAGNET,-1
	PUT	STACK,0,1
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?PUT-ON,V?ATTRACT \FALSE
	EQUAL?	PRSO,MAGNET \?CCL8
	IN?	MAGNET,ADVENTURER /?CCL8
	CALL	NOT-HOLDING
	RSTACK	
?CCL8:	FSET?	KEY,TOUCHBIT \?CCL12
	EQUAL?	PRSI,KEY \?CCL12
	MOVE	KEY,ADVENTURER
	PRINTR	"The key jumps against the ends of the magnet and sticks there. Proud of your feat, you remove the key from the magnet."
?CCL12:	FSET?	KEY,TOUCHBIT /FALSE
	EQUAL?	PRSI,KEY,CREVICE \FALSE
	MOVE	KEY,ADVENTURER
	FCLEAR	KEY,INVISIBLE
	FCLEAR	KEY,TRYTAKEBIT
	FSET	KEY,TOUCHBIT
	PRINTR	"With a spray of dust and a loud clank, a piece of metal leaps from the crevice and affixes itself to the magnet. It is a steel key! With a tug, you remove the key from the magnet."


	.FUNCT	I-MAGNET
	IN?	MAGNET,ADVENTURER \?CCL3
	CALL	HELD?,KITCHEN-CARD
	ZERO?	STACK /?CCL6
	FSET	KITCHEN-CARD,SCRAMBLEDBIT
	RFALSE	
?CCL6:	CALL	HELD?,SHUTTLE-CARD
	ZERO?	STACK /?CCL8
	FSET	SHUTTLE-CARD,SCRAMBLEDBIT
	RFALSE	
?CCL8:	CALL	HELD?,TELEPORTATION-CARD
	ZERO?	STACK /?CCL10
	FSET	TELEPORTATION-CARD,SCRAMBLEDBIT
	RFALSE	
?CCL10:	CALL	HELD?,UPPER-ELEVATOR-CARD
	ZERO?	STACK /?CCL12
	FSET	UPPER-ELEVATOR-CARD,SCRAMBLEDBIT
	RFALSE	
?CCL12:	CALL	HELD?,LOWER-ELEVATOR-CARD
	ZERO?	STACK /?CCL14
	FSET	LOWER-ELEVATOR-CARD,SCRAMBLEDBIT
	RFALSE	
?CCL14:	CALL	HELD?,MINI-CARD
	ZERO?	STACK /?CCL16
	FSET	MINI-CARD,SCRAMBLEDBIT
	RFALSE	
?CCL16:	CALL	HELD?,ID-CARD
	ZERO?	STACK /FALSE
	FSET	ID-CARD,SCRAMBLEDBIT
	RFALSE	
?CCL3:	CALL	INT,I-MAGNET
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	MACHINE-SHOP-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This room is probably some sort of machine shop filled with a variety of unusual machines. Doorways lead north, east, and west.

Standing against the rear wall is a large dispensing machine with a spout. "
	EQUAL?	SPOUT-PLACED,GROUND /?CND4
	PRINTI	"Sitting under the spout is "
	FSET?	SPOUT-PLACED,VOWELBIT \?CCL8
	PRINTI	"an "
	JUMP	?CND6
?CCL8:	PRINTI	"a "
?CND6:	PRINTD	SPOUT-PLACED
	PRINTI	". "
?CND4:	PRINTR	"The dispenser is lined with brightly-colored buttons. The first four buttons, labelled ""KUULINTS 1 - 4"", are colored red, blue, green, and yellow. The next three buttons, labelled ""KATALISTS 1 - 3"", are colored gray, brown, and black. The last two buttons are both white. One of these is square and says ""BAAS."" The other white button is round and says ""ASID."""
?CCL3:	EQUAL?	RARG,M-END \FALSE
	EQUAL?	SPOUT-PLACED,GROUND \FALSE
	IN?	FLOYD,HERE \FALSE
	FSET?	FLOYD,RLANDBIT \FALSE
	RANDOM	100
	LESS?	15,STACK /FALSE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTR	"Floyd pushes one of the dispenser buttons. Fluid pours from the spout and splashes across the floor. Floyd jumps up and down, giggling."


	.FUNCT	CHEMICAL-DISPENSER-F
	EQUAL?	PRSA,V?PUT-UNDER \FALSE
	EQUAL?	PRSI,CHEMICAL-DISPENSER \FALSE
	EQUAL?	SPOUT-PLACED,GROUND \?CCL8
	MOVE	PRSO,HERE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" is now sitting under the spout."
	CRLF	
	SET	'SPOUT-PLACED,PRSO
	RETURN	SPOUT-PLACED
?CCL8:	PRINTI	"The "
	PRINTD	SPOUT-PLACED
	PRINTR	" is already resting under the spout."


	.FUNCT	CHEM-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	FSET?	CHEMICAL-DISPENSER,MUNGEDBIT \?CCL6
	PRINTR	"The machine coughs a few times, but nothing else happens."
?CCL6:	EQUAL?	SPOUT-PLACED,FLASK \?CCL8
	IN?	CHEMICAL-FLUID,FLASK \?CCL11
	PRINTR	"Another dose of the chemical fluid pours out of the spout, splashes over the already-full flask, spills onto the floor, and dries up."
?CCL11:	MOVE	CHEMICAL-FLUID,FLASK
	PRINTI	"The flask fills with some "
	GETP	PRSO,P?C-MOVE >CHEMICAL-FLAG
	GETP	PRSO,P?C-MOVE
	GET	COLOR-LTBL,STACK
	PRINT	STACK
	PRINTR	" chemical fluid. The fluid gradually turns milky white."
?CCL8:	EQUAL?	SPOUT-PLACED,CANTEEN \?CCL13
	FSET?	CANTEEN,OPENBIT \?CCL13
	PRINTR	"Chemical fluid gushes from the spout. Unfortunately, the mouth of the canteen is very narrow, and the fluid just splashes over it."
?CCL13:	PRINTI	"Some sort of chemical fluid pours out of the spout, spills all over the "
	PRINTD	SPOUT-PLACED
	PRINTI	", and dries up."
	CRLF	
	EQUAL?	PRSO,ROUND-WHITE-BUTTON,SQUARE-WHITE-BUTTON \TRUE
	FSET?	SPOUT-PLACED,ACIDBIT /?CCL17
	FSET?	SPOUT-PLACED,MUNGBIT \TRUE
?CCL17:	SET	'CHEMICAL-FLAG,9
	CALL	PERFORM,V?POUR,CHEMICAL-FLUID,SPOUT-PLACED
	RTRUE	


	.FUNCT	FLOYD-F,X,N
	EQUAL?	FLOYD,WINNER \?CCL3
	SET	'FLOYD-SPOKE,TRUE-VALUE
	EQUAL?	PRSA,V?GIVE \?CCL6
	EQUAL?	PRSI,ME \?CCL6
	SET	'WINNER,ADVENTURER
	CALL	PERFORM,V?ASK-FOR,FLOYD,PRSO
	RTRUE	
?CCL6:	EQUAL?	PRSA,V?SGIVE \?CCL10
	EQUAL?	PRSO,ME \?CCL10
	SET	'WINNER,ADVENTURER
	CALL	PERFORM,V?ASK-FOR,FLOYD,PRSI
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?WALK \?CCL14
	EQUAL?	HERE,REPAIR-ROOM \?CCL17
	EQUAL?	PRSO,P?NORTH,P?IN \?CCL17
	CALL	FLOYD-THROUGH-HOLE
	JUMP	?CND15
?CCL17:	EQUAL?	HERE,BIO-LOCK-EAST \?CCL21
	EQUAL?	PRSO,P?EAST \?CCL21
	CALL	FLOYD-INTO-LAB
	JUMP	?CND15
?CCL21:	EQUAL?	HERE,RADIATION-LOCK-EAST \?CCL25
	EQUAL?	PRSO,P?EAST \?CCL25
	PRINTI	"""After you."""
	CRLF	
	JUMP	?CND15
?CCL25:	PRINTI	"Floyd looks slightly embarrassed. ""You know me and my sense of direction."" Then he looks up at you with wide, trusting eyes. ""Tell Floyd a story?"""
	CRLF	
?CND15:	CALL	FLUSH
	ZERO?	STACK /TRUE
	RETURN	2
?CCL14:	EQUAL?	PRSA,V?THROUGH \?CCL33
	CALL	FLOYDS-FAMOUS-DOOR-ROUTINE
	CALL	FLUSH
	ZERO?	STACK /TRUE
	RETURN	2
?CCL33:	EQUAL?	PRSA,V?TAKE \?CCL39
	EQUAL?	PRSO,GOOD-BOARD \?CCL39
	IN?	GOOD-BOARD,ROBOT-HOLE /?CCL44
	PRINTI	"Floyd looks half-bored and half-annoyed. "
	PRINTR	"Floyd already did that. How about some leap-frogger?"""
?CCL44:	ZERO?	BOARD-REPORTED /?CCL46
	MOVE	GOOD-BOARD,ADVENTURER
	FCLEAR	GOOD-BOARD,NDESCBIT
	FSET	GOOD-BOARD,TAKEBIT
	SET	'C-ELAPSED,22
	PRINTR	"Floyd shrugs. ""If you say so."" He vanishes for a few minutes, and returns holding the fromitz board. It seems to be in good shape. He tosses it toward you, and you just manage to catch it before it smashes."
?CCL46:	PRINTR	"""Huh?"" asks Floyd. ""What fromitz board?"""
?CCL39:	EQUAL?	PRSA,V?FOLLOW \?CCL48
	EQUAL?	PRSO,ME \?CCL48
	PRINTR	"""Okay!"""
?CCL48:	EQUAL?	PRSA,V?HELLO \?CCL52
	SET	'WINNER,ADVENTURER
	CALL	PERFORM,V?HELLO,FLOYD
	RTRUE	
?CCL52:	EQUAL?	PRSA,V?DROP \?CCL54
	IN?	PRSO,FLOYD \?CCL57
	RANDOM	100
	LESS?	50,STACK /?CCL60
	MOVE	PRSO,HERE
	PRINTI	"Floyd shrugs and drops the "
	PRINTD	PRSO
	PRINTR	"."
?CCL60:	PRINTI	"Floyd clutches the "
	PRINTD	PRSO
	PRINTR	" even more tightly. ""Floyd won't,"" he says defiantly."
?CCL57:	CALL	FLOYD-NOT-HAVE
	RSTACK	
?CCL54:	PRINTI	"Floyd whines, ""Enough talking! Let's play Hider-and-Seeker."""
	CRLF	
	RETURN	2
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL64
	PRINTR	"Huh?"
?CCL64:	EQUAL?	PRSA,V?REACH,V?LOOK-INSIDE \?CCL66
	CALL	PERFORM,V?OPEN,FLOYD
	RTRUE	
?CCL66:	FSET?	FLOYD,RLANDBIT \?CCL68
	SET	'FLOYD-SPOKE,TRUE-VALUE
	EQUAL?	PRSA,V?LAMP-ON \?CCL71
	PRINTR	"He's already been activated."
?CCL71:	EQUAL?	PRSA,V?LAMP-OFF \?CCL73
	FCLEAR	FLOYD,RLANDBIT
	FCLEAR	FLOYD,ACTORBIT
	CALL	INT,I-FLOYD
	PUT	STACK,0,0
	PRINTI	"Floyd, shocked by this betrayal from his new-found friend, whimpers and keels over"
	FIRST?	FLOYD \?CCL76
	PRINTI	", dropping what he was carrying."
	CRLF	
	JUMP	?CND74
?CCL76:	PRINTC	46
	CRLF	
?CND74:	FIRST?	FLOYD >X /?PRG78
?PRG78:	ZERO?	X /TRUE
	NEXT?	X >N /?BOGUS83
?BOGUS83:	MOVE	X,HERE
	SET	'X,N
	JUMP	?PRG78
?CCL73:	EQUAL?	PRSA,V?EXAMINE \?CCL85
	PRINTR	"From its design, the robot seems to be of the multi-purpose sort. It is slightly cross-eyed, and its mechanical mouth forms a lopsided grin."
?CCL85:	EQUAL?	PRSA,V?KISS \?CCL87
	PRINTR	"You receive a painful electric shock."
?CCL87:	EQUAL?	PRSA,V?SCOLD \?CCL89
	PRINTR	"Floyd looks defensive. ""What did Floyd do wrong?"""
?CCL89:	EQUAL?	PRSA,V?PLAY-WITH \?CCL91
	SET	'C-ELAPSED,30
	CALL	QUEUE,I-FLOYD,1
	PUT	STACK,0,1
	PRINTR	"You play with Floyd for several centichrons until you drop to the floor, exhausted. Floyd pokes at you gleefully. ""C'mon! Let's play some more!"""
?CCL91:	EQUAL?	PRSA,V?LISTEN \?CCL93
	PRINTR	"Floyd is babbling about this and that."
?CCL93:	EQUAL?	PRSA,V?TAKE \?CCL95
	EQUAL?	PRSO,FLOYD \?CCL95
	PRINTR	"You manage to lift Floyd a few inches off the ground, but he is too heavy and you drop him suddenly. Floyd gives a surprised squeal and moves a respectable distance away."
?CCL95:	EQUAL?	PRSA,V?MUNG,V?ATTACK \?CCL99
	PRINTR	"Floyd starts dashing around the room. ""Oh boy oh boy oh boy! I haven't played Chase and Tag for years! You be It! Nah, nah!"""
?CCL99:	EQUAL?	PRSA,V?SHAKE,V?KICK \?CCL101
	PRINTR	"""Why you do that?"" Floyd whines. ""I think a wire now shaken loose."" He goes off into a corner and sulks."
?CCL101:	EQUAL?	PRSA,V?TALK,V?HELLO \?CCL103
	PRINTR	"""Hi!"" Floyd grins and bounces up and down."
?CCL103:	EQUAL?	PRSA,V?OPEN,V?SCRUB,V?SEARCH \?CCL105
	PRINTR	"Floyd giggles and pushes you away. ""You're tickling Floyd!"" He clutches at his side panels, laughing hysterically. Oil drops stream from his eyes."
?CCL105:	EQUAL?	PRSA,V?PUT,V?GIVE \?CCL107
	EQUAL?	FLOYD,PRSI \?CCL107
	EQUAL?	PRSO,LAZARUS-PART \?CCL112
	REMOVE	FLOYD
	SET	'FLOYD-FOLLOW,FALSE-VALUE
	MOVE	LAZARUS-PART,HERE
	CALL	QUEUE,I-FLOYD,40
	PUT	STACK,0,1
	PRINTR	"At first, Floyd is all grins because of your gift. Then, he realizes what it is, begins weeping, drops the breastplate, and rushes out of the room."
?CCL112:	EQUAL?	PRSO,RED-GOO,GREEN-GOO,BROWN-GOO \?CCL114
	PRINTR	"Floyd looks at the goo. ""Yech! Got any Number Seven Heavy Grease?"""
?CCL114:	FIRST?	FLOYD /?CTR115
	RANDOM	100
	LESS?	25,STACK /?CCL116
?CTR115:	MOVE	PRSO,HERE
	PRINTI	"Floyd examines the "
	PRINTD	PRSO
	PRINTI	", shrugs, and drops "
	EQUAL?	PRSO,PLIERS \?CCL121
	PRINTR	"them."
?CCL121:	PRINTR	"it."
?CCL116:	MOVE	PRSO,FLOYD
	PRINTR	"""Neat!"" exclaims Floyd. He thanks you profusely."
?CCL107:	EQUAL?	PRSA,V?SHOW \?CCL123
	EQUAL?	FLOYD,PRSI \?CCL123
	EQUAL?	PRSO,PRINT-OUT \?CCL128
	ZERO?	COMPUTER-FLAG \?CCL128
	CALL	COMPUTER-ACTION
	RSTACK	
?CCL128:	EQUAL?	PRSO,ROBOT-HOLE \?CCL132
	CALL	FLOYD-THROUGH-HOLE
	RSTACK	
?CCL132:	EQUAL?	HERE,REC-AREA \?CCL134
	EQUAL?	PRSO,PSEUDO-OBJECT \?CCL134
	PRINTR	"""Too intellectual for Floyd. Any paddleball sets around?"""
?CCL134:	EQUAL?	PRSO,ID-CARD,SHUTTLE-CARD /?CTR137
	EQUAL?	PRSO,KITCHEN-CARD,UPPER-ELEVATOR-CARD \?CCL138
?CTR137:	PRINTR	"Floyd scratches his head. ""Aren't those things usually blue?"""
?CCL138:	EQUAL?	PRSO,LOWER-ELEVATOR-CARD \?CCL142
	ZERO?	CARD-REVEALED \?CCL142
	SET	'CARD-REVEALED,TRUE-VALUE
	PRINTR	"""I've got one just like that!"" says Floyd. He looks through several of his compartments, then glances at you suspiciously."
?CCL142:	PRINTI	"Floyd looks over the "
	PRINTD	PRSO
	PRINTR	". ""Can you play any games with it?"" he asks."
?CCL123:	EQUAL?	PRSA,V?RUB \?CCL146
	PRINTR	"Floyd gives a contented sigh."
?CCL146:	EQUAL?	PRSA,V?SMELL \?CCL148
	PRINTR	"Floyd smells faintly of ozone and light machine oil."
?CCL148:	EQUAL?	PRSA,V?ASK-FOR \FALSE
	IN?	PRSI,FLOYD \?CCL153
	MOVE	PRSI,ADVENTURER
	PRINTI	"""Okay,"" says Floyd, handing you the "
	PRINTD	PRSI
	PRINTR	", ""but only because you're Floyd's best friend."""
?CCL153:	CALL	FLOYD-NOT-HAVE
	RSTACK	
?CCL68:	EQUAL?	PRSA,V?LAMP-ON \?CCL156
	ZERO?	FLOYD-INTRODUCED /?CCL159
	CALL	QUEUE,I-FLOYD,-1
	PUT	STACK,0,1
	RTRUE	
?CCL159:	CALL	QUEUE,I-FLOYD,25
	PUT	STACK,0,1
	PRINTI	"Nothing happens."
	CRLF	
	ZERO?	FLOYD-SCORE-FLAG \TRUE
	SET	'FLOYD-SCORE-FLAG,TRUE-VALUE
	ADD	SCORE,2 >SCORE
	RTRUE	
?CCL156:	EQUAL?	PRSA,V?LAMP-OFF \?CCL163
	PRINTR	"The robot doesn't seem to be on."
?CCL163:	EQUAL?	PRSA,V?EXAMINE \?CCL165
	PRINTR	"The de-activated robot is leaning against the wall, its head lolling to the side. It is short, and seems to be equipped for general-purpose work. It has apparently been turned off."
?CCL165:	EQUAL?	PRSA,V?OPEN,V?SEARCH \FALSE
	ZERO?	CARD-REVEALED \?CCL170
	ZERO?	CARD-STOLEN \?CCL170
	FCLEAR	LOWER-ELEVATOR-CARD,INVISIBLE
	MOVE	LOWER-ELEVATOR-CARD,ADVENTURER
	CALL	SCORE-OBJ,LOWER-ELEVATOR-CARD
	SET	'CARD-STOLEN,TRUE-VALUE
	PRINTR	"In one of the robot's compartments you find and take a magnetic-striped card embossed ""Loowur Elavaatur Akses Kard."""
?CCL170:	PRINTR	"Your search discovers nothing in the robot's compartments except a single crayon which you leave where you found it."


	.FUNCT	FLOYDS-FAMOUS-DOOR-ROUTINE
	EQUAL?	PRSO,ROBOT-HOLE \?CCL3
	CALL	FLOYD-THROUGH-HOLE
	RSTACK	
?CCL3:	EQUAL?	PRSO,BIO-DOOR-EAST \?CCL5
	CALL	FLOYD-INTO-LAB
	RSTACK	
?CCL5:	FSET?	PRSO,DOORBIT \?CCL7
	PRINTR	"""You go first,"" says Floyd."
?CCL7:	PRINTR	"Floyd scratches his head and looks at you."


	.FUNCT	FLUSH
	ZERO?	P-CONT /FALSE
	SET	'P-CONT,FALSE-VALUE
	CRLF	
	PRINTR	"Floyd scratches his head and looks at you. ""What else were you saying to Floyd? I can't remember."""


	.FUNCT	FLOYD-INTO-LAB
	ZERO?	FLOYD-WAITING /?CCL3
	PRINTR	"""As soon as you open the door, dummy."""
?CCL3:	PRINTR	"""Are you kidding? Floyd not going in THERE without a good reason."""


	.FUNCT	FLOYD-NOT-HAVE
	PRINTR	"""Floyd does not one of those have!"""


	.FUNCT	FLOYD-COMES-ALIVE,FOO
	IN?	FLOYD,HERE \?CND1
	ZERO?	FLOYD-REACTIVATED /?CCL5
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTI	"Floyd jumps to his feet, hopping mad. ""Why you turn Floyd off?"" he asks accusingly."
	CRLF	
	JUMP	?CND1
?CCL5:	SET	'FLOYD-INTRODUCED,TRUE-VALUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTI	"Suddenly, the robot comes to life and its head starts swivelling about. It notices you and bounds over. ""Hi! I'm B-19-7, but to everyperson I'm called Floyd. Are you a doctor-person or a planner-person? "
	FIRST?	ADVENTURER >FOO \?CND6
	PRINTI	"That's a nice "
	PRINTD	FOO
	PRINTI	" you are having there. "
?CND6:	PRINTI	"Let's play Hider-and-Seeker you with me."""
	CRLF	
?CND1:	FSET	FLOYD,RLANDBIT
	FSET	FLOYD,ACTORBIT
	FSET	FLOYD,TOUCHBIT
	SET	'FLOYD-REACTIVATED,TRUE-VALUE
	RETURN	FLOYD-REACTIVATED


	.FUNCT	I-FLOYD
	CALL	QUEUE,I-FLOYD,-1
	PUT	STACK,0,1
	FSET?	FLOYD,RLANDBIT /?CCL3
	FSET	FLOYD,ACTORBIT
	CRLF	
	CALL	FLOYD-COMES-ALIVE
	JUMP	?CND1
?CCL3:	IN?	FLOYD,HERE \?CCL5
	ZERO?	FLOYD-INTRODUCED \?CCL8
	SET	'FLOYD-INTRODUCED,TRUE-VALUE
	CRLF	
	PRINTI	"The robot, now apparently active, notices you enter. ""Hi,"" he says. ""I'm Floyd!"""
	CRLF	
	JUMP	?CND1
?CCL8:	ZERO?	FLOYD-FOLLOW /?CCL10
	FSET?	HERE,FLOYDBIT \?CCL10
	RANDOM	100
	LESS?	6,STACK /?CCL10
	REMOVE	FLOYD
	SET	'FLOYD-FOLLOW,FALSE-VALUE
	CRLF	
	PRINTI	"Floyd says ""Floyd going exploring. See you later."" He glides out of the room."
	CRLF	
	JUMP	?CND1
?CCL10:	SET	'FLOYD-FOLLOW,TRUE-VALUE
	RANDOM	100
	LESS?	40,STACK /?CND1
	ZERO?	FLOYD-SPOKE \?CND1
	PRINTI	"Floyd "
	CALL	PICK-ONE,FLOYDISMS
	PRINT	STACK
	PRINTR	"."
?CCL5:	ZERO?	FLOYD-FOLLOW /?CCL20
	RANDOM	100
	LESS?	80,STACK /?CCL20
	IN?	LAZARUS-PART,HERE \?CND23
	SET	'FLOYD-FOLLOW,FALSE-VALUE
	CRLF	
	PRINTR	"Floyd starts to follow you but notices the Lazarus breast plate. He sniffs and leaves the room."
?CND23:	MOVE	FLOYD,HERE
	PRINTI	"Floyd follows you."
	CRLF	
	CALL	KLUDGE
	JUMP	?CND1
?CCL20:	SET	'FLOYD-FOLLOW,FALSE-VALUE
	EQUAL?	HERE,BOOTH-1,BOOTH-2,BOOTH-3 \?CCL27
	MOVE	FLOYD,HERE
	ZERO?	FLOYD-INTRODUCED \?CND28
	CRLF	
	CALL	CALL-ME-FLOYD
	RTRUE	
?CND28:	CRLF	
	PRINTI	"Floyd scampers into the booth. ""Oooo, this is a tiny room,"" he remarks."
	CRLF	
	JUMP	?CND1
?CCL27:	EQUAL?	HERE,BIO-LOCK-EAST,BIO-LOCK-WEST \?PRD33
	ZERO?	FLOYD-GAVE-UP /?CTR30
?PRD33:	EQUAL?	HERE,RADIATION-LOCK-EAST,RADIATION-LOCK-WEST \?CCL31
?CTR30:	MOVE	FLOYD,HERE
	ZERO?	FLOYD-INTRODUCED \?CND36
	CRLF	
	CALL	CALL-ME-FLOYD
	RTRUE	
?CND36:	CRLF	
	PRINTI	"Floyd glides after you. ""Is this...is this a squash court?"" he asks."
	CRLF	
	JUMP	?CND1
?CCL31:	EQUAL?	HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST /?CTR38
	EQUAL?	HERE,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST /?CTR38
	EQUAL?	HERE,UPPER-ELEVATOR,LOWER-ELEVATOR,REACTOR-ELEVATOR /?CTR38
	EQUAL?	HERE,MESS-HALL \?CCL39
	IN?	FLOYD,KITCHEN \?CCL39
?CTR38:	MOVE	FLOYD,HERE
	ZERO?	FLOYD-INTRODUCED \?CND46
	CRLF	
	CALL	CALL-ME-FLOYD
	RTRUE	
?CND46:	CRLF	
	PRINTI	"Floyd bounces into the "
	EQUAL?	HERE,UPPER-ELEVATOR,LOWER-ELEVATOR,REACTOR-ELEVATOR \?CCL50
	PRINTI	"elevator"
	JUMP	?CND48
?CCL50:	EQUAL?	HERE,MESS-HALL \?CCL52
	PRINTI	"room"
	JUMP	?CND48
?CCL52:	PRINTI	"cabin"
?CND48:	PRINTI	". ""Hey, wait for Floyd!"" he yells, smiling broadly."
	CRLF	
	JUMP	?CND1
?CCL39:	EQUAL?	HERE,MINI-BOOTH \?CCL54
	MOVE	FLOYD,HERE
	ZERO?	FLOYD-INTRODUCED \?CND55
	CRLF	
	CALL	CALL-ME-FLOYD
	RTRUE	
?CND55:	CRLF	
	PRINTI	"""Hi,"" whispers Floyd, tiptoeing in. ""Are we going to teleport into the computer like Achilles always used to do?"""
	CRLF	
	JUMP	?CND1
?CCL54:	RANDOM	100
	LESS?	30,STACK /?CND1
	EQUAL?	HERE,INFIRMARY \?CND58
	ZERO?	LAZARUS-FLAG \FALSE
?CND58:	MOVE	FLOYD,HERE
	ZERO?	FLOYD-INTRODUCED /?CCL64
	RANDOM	100
	LESS?	15,STACK /?CCL67
	IN?	ADVENTURER,BED /?CCL67
	CRLF	
	PRINTI	"Floyd rushes into the room and barrels into you. ""Oops, sorry,"" he says. ""Floyd not looking at where he was going to."""
	CRLF	
	JUMP	?CND65
?CCL67:	CRLF	
	PRINTI	"Floyd bounds into the room. ""Floyd here now!"" he cries."
	CRLF	
?CND65:	CALL	KLUDGE
	JUMP	?CND1
?CCL64:	CRLF	
	CALL	CALL-ME-FLOYD
?CND1:	SET	'FLOYD-SPOKE,FALSE-VALUE
	RETURN	FLOYD-SPOKE


	.FUNCT	CALL-ME-FLOYD
	SET	'FLOYD-INTRODUCED,TRUE-VALUE
	PRINTR	"The robot you were fiddling with in the Robot Shop bounds into the room. ""Hi!"" he says, with a wide and friendly smile. ""You turn Floyd on? Be Floyd's friend, yes?"""


	.FUNCT	KLUDGE
	EQUAL?	HERE,REPAIR-ROOM \?CCL3
	ZERO?	ACHILLES-FLAG \?CCL3
	SET	'ACHILLES-FLAG,TRUE-VALUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTR	"Floyd points at the fallen robot. ""That's Achilles. He was in charge of repairing machinery. He repaired Floyd once. I never liked him much; he wasn't friendly like other robots. Looks like he fell down the stairs. He always had trouble with one of his feet working right. A Planner-person once told me that's why they named him Achilles."""
?CCL3:	EQUAL?	HERE,COMPUTER-ROOM \FALSE
	ZERO?	COMPUTER-FLAG \FALSE
	CALL	COMPUTER-ACTION
	RSTACK	


	.FUNCT	DEAD-FLOYD-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"You turn to look at Floyd, but a tremendous sense of loss overcomes you, and you turn away."
?CCL3:	EQUAL?	PRSA,V?LAMP-ON \?CCL5
	PRINTR	"As you touch Floyd's on-off switch, it falls off in your hands."
?CCL5:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	PRINTR	"I'm afraid that Floyd has already been turned off, permanently, and gone to that great robot shop in the sky."


	.FUNCT	ELEVATOR-LOBBY-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a wide, brightly lit lobby. A blue metal door to the north is "
	FSET?	UPPER-ELEVATOR-DOOR,OPENBIT \?CCL6
	EQUAL?	UPPER-ELEVATOR-UP,FALSE-VALUE \?CCL6
	PRINTI	"open"
	JUMP	?CND4
?CCL6:	PRINTI	"closed"
?CND4:	PRINTI	" and a larger red metal door to the south is "
	FSET?	LOWER-ELEVATOR-DOOR,OPENBIT \?CCL11
	EQUAL?	LOWER-ELEVATOR-UP,TRUE-VALUE \?CCL11
	FSET?	UPPER-ELEVATOR-DOOR,OPENBIT \?CND14
	EQUAL?	UPPER-ELEVATOR-UP,FALSE-VALUE \?CND14
	PRINTI	"also "
?CND14:	PRINTI	"open"
	JUMP	?CND9
?CCL11:	FSET?	UPPER-ELEVATOR-DOOR,OPENBIT \?CCL19
	EQUAL?	UPPER-ELEVATOR-UP,TRUE-VALUE \?CND18
?CCL19:	PRINTI	"also "
?CND18:	PRINTI	"closed"
?CND9:	PRINTR	". Beside the blue door is a blue button, and beside the red door is a red button. A corridor leads west. To the east is a small room about the size of a telephone booth."


	.FUNCT	UPPER-ELEVATOR-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"You have entered a tiny room with a sliding door to the south which is "
	CALL	DDESC,UPPER-ELEVATOR-DOOR
	PRINTR	". A control panel contains an Up button, a Down button, and a narrow slot."
?CCL3:	EQUAL?	RARG,M-END \FALSE
	FSET?	UPPER-ELEVATOR-DOOR,OPENBIT /FALSE
	RANDOM	100
	LESS?	10,STACK /FALSE
	PRINTR	"Some innocuous Hawaiian music oozes from the elevator's intercom."


	.FUNCT	LOWER-ELEVATOR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a medium-sized room with a door to the north which is "
	CALL	DDESC,LOWER-ELEVATOR-DOOR
	PRINTR	". A control panel contains an Up button, a Down button, and a narrow slot."


	.FUNCT	ELEVATOR-ENTER-F
	EQUAL?	PRSO,P?NORTH \?CCL3
	FSET?	UPPER-ELEVATOR-DOOR,OPENBIT \?CCL6
	EQUAL?	UPPER-ELEVATOR-UP,FALSE-VALUE \?CCL6
	RETURN	UPPER-ELEVATOR
?CCL6:	CALL	DOOR-CLOSED
	RFALSE	
?CCL3:	EQUAL?	PRSO,P?SOUTH \FALSE
	FSET?	LOWER-ELEVATOR-DOOR,OPENBIT \?CCL13
	EQUAL?	LOWER-ELEVATOR-UP,TRUE-VALUE \?CCL13
	RETURN	LOWER-ELEVATOR
?CCL13:	CALL	DOOR-CLOSED
	RFALSE	


	.FUNCT	ELEVATOR-EXIT-F
	EQUAL?	HERE,UPPER-ELEVATOR \?CCL3
	FSET?	UPPER-ELEVATOR-DOOR,OPENBIT \?CCL6
	EQUAL?	UPPER-ELEVATOR-UP,TRUE-VALUE \?CCL9
	RETURN	TOWER-CORE
?CCL9:	RETURN	ELEVATOR-LOBBY
?CCL6:	CALL	DOOR-CLOSED
	RFALSE	
?CCL3:	EQUAL?	HERE,LOWER-ELEVATOR \FALSE
	FSET?	LOWER-ELEVATOR-DOOR,OPENBIT \?CCL14
	EQUAL?	LOWER-ELEVATOR-UP,TRUE-VALUE \?CCL17
	RETURN	ELEVATOR-LOBBY
?CCL17:	RETURN	WAITING-AREA
?CCL14:	CALL	DOOR-CLOSED
	RFALSE	


	.FUNCT	UPPER-ELEVATOR-DOOR-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	UPPER-ELEVATOR-DOOR,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	PRINTR	"It won't budge."
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	UPPER-ELEVATOR-DOOR,OPENBIT \?CCL11
	PRINTR	"You can't close it yourself."
?CCL11:	CALL	IS-CLOSED
	RSTACK	


	.FUNCT	LOWER-ELEVATOR-DOOR-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	LOWER-ELEVATOR-DOOR,OPENBIT \?CCL6
	EQUAL?	HERE,ELEVATOR-LOBBY \?CCL6
	EQUAL?	LOWER-ELEVATOR-UP,TRUE-VALUE \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	FSET?	LOWER-ELEVATOR-DOOR,OPENBIT \?CCL11
	EQUAL?	HERE,WAITING-AREA \?CCL11
	EQUAL?	LOWER-ELEVATOR-UP,FALSE-VALUE \?CCL11
	CALL	ALREADY-OPEN
	RSTACK	
?CCL11:	PRINTR	"It won't budge."
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	LOWER-ELEVATOR-DOOR,OPENBIT \?CCL19
	EQUAL?	HERE,ELEVATOR-LOBBY \?CCL19
	EQUAL?	LOWER-ELEVATOR-UP,TRUE-VALUE \?CCL19
	PRINTR	"You can't close it yourself."
?CCL19:	FSET?	LOWER-ELEVATOR-DOOR,OPENBIT \?CCL24
	EQUAL?	HERE,WAITING-AREA \?CCL24
	EQUAL?	LOWER-ELEVATOR-UP,FALSE-VALUE \?CCL24
	PRINTR	"You can't close it yourself."
?CCL24:	CALL	IS-CLOSED
	RSTACK	


	.FUNCT	DOOR-CLOSED
	PRINTR	"The door is closed."


	.FUNCT	BLUE-ELEVATOR-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	UPPER-ELEVATOR-UP,TRUE-VALUE \FALSE
	CALL	INT,I-UPPER-ELEVATOR-ARRIVE
	GET	STACK,C-ENABLED?
	EQUAL?	STACK,1 \?CCL8
	PRINTR	"Patience, patience..."
?CCL8:	RANDOM	20
	ADD	STACK,40
	CALL	QUEUE,I-UPPER-ELEVATOR-ARRIVE,STACK
	PUT	STACK,0,1
	PRINTR	"You hear a faint whirring noise from behind the blue door."


	.FUNCT	RED-ELEVATOR-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	LOWER-ELEVATOR-UP,FALSE-VALUE \FALSE
	CALL	INT,I-LOWER-ELEVATOR-ARRIVE
	GET	STACK,C-ENABLED?
	EQUAL?	STACK,1 \?CCL8
	PRINTR	"Patience, patience..."
?CCL8:	RANDOM	40
	ADD	STACK,80
	CALL	QUEUE,I-LOWER-ELEVATOR-ARRIVE,STACK
	PUT	STACK,0,1
	PRINTR	"The red door begins vibrating a bit."


	.FUNCT	I-UPPER-ELEVATOR-ARRIVE
	FSET	UPPER-ELEVATOR-DOOR,OPENBIT
	SET	'UPPER-ELEVATOR-UP,FALSE-VALUE
	CALL	INT,I-UPPER-ELEVATOR-ARRIVE
	PUT	STACK,0,0
	EQUAL?	HERE,ELEVATOR-LOBBY \FALSE
	CRLF	
	PRINTR	"The door at the north end of the room slides open."


	.FUNCT	I-LOWER-ELEVATOR-ARRIVE
	FSET	LOWER-ELEVATOR-DOOR,OPENBIT
	SET	'LOWER-ELEVATOR-UP,TRUE-VALUE
	CALL	INT,I-LOWER-ELEVATOR-ARRIVE
	PUT	STACK,0,0
	EQUAL?	HERE,ELEVATOR-LOBBY \FALSE
	CRLF	
	PRINTR	"The door at the south end of the room slides open."


	.FUNCT	ELEVATOR-BUTTON-F
	EQUAL?	PRSA,V?PUSH-UP \?CCL3
	EQUAL?	HERE,LOWER-ELEVATOR \?CCL6
	EQUAL?	LOWER-ELEVATOR-UP,FALSE-VALUE \?CCL6
	EQUAL?	LOWER-ELEVATOR-ON,TRUE-VALUE \?CCL6
	EQUAL?	ELEVATOR-IN-TRANSIT,FALSE-VALUE \?CCL6
	PRINT	ELEVATOR-STARTS
	CRLF	
	FCLEAR	LOWER-ELEVATOR-DOOR,OPENBIT
	SET	'ELEVATOR-IN-TRANSIT,TRUE-VALUE
	CALL	QUEUE,I-LOWER-ELEVATOR-TRIP,100
	PUT	STACK,0,1
	RTRUE	
?CCL6:	EQUAL?	HERE,UPPER-ELEVATOR \?CCL12
	EQUAL?	UPPER-ELEVATOR-UP,FALSE-VALUE \?CCL12
	EQUAL?	UPPER-ELEVATOR-ON,TRUE-VALUE \?CCL12
	EQUAL?	ELEVATOR-IN-TRANSIT,FALSE-VALUE \?CCL12
	PRINT	ELEVATOR-STARTS
	CRLF	
	FCLEAR	UPPER-ELEVATOR-DOOR,OPENBIT
	SET	'ELEVATOR-IN-TRANSIT,TRUE-VALUE
	CALL	QUEUE,I-UPPER-ELEVATOR-TRIP,50
	PUT	STACK,0,1
	RTRUE	
?CCL12:	PRINTR	"Nothing happens."
?CCL3:	EQUAL?	PRSA,V?PUSH-DOWN \?CCL18
	EQUAL?	HERE,LOWER-ELEVATOR \?CCL21
	EQUAL?	LOWER-ELEVATOR-UP,TRUE-VALUE \?CCL21
	EQUAL?	LOWER-ELEVATOR-ON,TRUE-VALUE \?CCL21
	EQUAL?	ELEVATOR-IN-TRANSIT,FALSE-VALUE \?CCL21
	PRINT	ELEVATOR-STARTS
	CRLF	
	FCLEAR	LOWER-ELEVATOR-DOOR,OPENBIT
	SET	'ELEVATOR-IN-TRANSIT,TRUE-VALUE
	CALL	QUEUE,I-LOWER-ELEVATOR-TRIP,100
	PUT	STACK,0,1
	RTRUE	
?CCL21:	EQUAL?	HERE,UPPER-ELEVATOR \?CCL27
	EQUAL?	UPPER-ELEVATOR-UP,TRUE-VALUE \?CCL27
	EQUAL?	UPPER-ELEVATOR-ON,TRUE-VALUE \?CCL27
	EQUAL?	ELEVATOR-IN-TRANSIT,FALSE-VALUE \?CCL27
	PRINT	ELEVATOR-STARTS
	CRLF	
	FCLEAR	UPPER-ELEVATOR-DOOR,OPENBIT
	SET	'ELEVATOR-IN-TRANSIT,TRUE-VALUE
	CALL	QUEUE,I-UPPER-ELEVATOR-TRIP,50
	PUT	STACK,0,1
	RTRUE	
?CCL27:	PRINTR	"Nothing happens."
?CCL18:	EQUAL?	PRSA,V?PUSH \FALSE
	PRINTR	"You must specify whether you want to push the Up button or the Down button."


	.FUNCT	I-TURNOFF-UPPER-ELEVATOR
	ZERO?	ELEVATOR-IN-TRANSIT /?CCL3
	CALL	QUEUE,I-TURNOFF-UPPER-ELEVATOR,120
	PUT	STACK,0,1
	RFALSE	
?CCL3:	SET	'UPPER-ELEVATOR-ON,FALSE-VALUE
	EQUAL?	HERE,UPPER-ELEVATOR \FALSE
	CRLF	
	PRINT	ELEVATOR-LIGHT-OFF
	CRLF	
	RFALSE	


	.FUNCT	I-TURNOFF-LOWER-ELEVATOR
	ZERO?	ELEVATOR-IN-TRANSIT /?CCL3
	CALL	QUEUE,I-TURNOFF-LOWER-ELEVATOR,120
	PUT	STACK,0,1
	RFALSE	
?CCL3:	SET	'LOWER-ELEVATOR-ON,FALSE-VALUE
	EQUAL?	HERE,LOWER-ELEVATOR \FALSE
	CRLF	
	PRINT	ELEVATOR-LIGHT-OFF
	CRLF	
	RFALSE	


	.FUNCT	I-UPPER-ELEVATOR-TRIP
	EQUAL?	UPPER-ELEVATOR-UP,TRUE-VALUE \?CCL3
	SET	'UPPER-ELEVATOR-UP,FALSE-VALUE
	SET	'ELEVATOR-IN-TRANSIT,FALSE-VALUE
	FSET	UPPER-ELEVATOR-DOOR,OPENBIT
	CRLF	
	CALL	ELEVATOR-DOOR-OPENS
	RSTACK	
?CCL3:	SET	'UPPER-ELEVATOR-UP,TRUE-VALUE
	SET	'ELEVATOR-IN-TRANSIT,FALSE-VALUE
	FSET	UPPER-ELEVATOR-DOOR,OPENBIT
	CRLF	
	CALL	ELEVATOR-DOOR-OPENS
	RSTACK	


	.FUNCT	I-LOWER-ELEVATOR-TRIP
	EQUAL?	LOWER-ELEVATOR-UP,TRUE-VALUE \?CCL3
	SET	'LOWER-ELEVATOR-UP,FALSE-VALUE
	SET	'ELEVATOR-IN-TRANSIT,FALSE-VALUE
	FSET	LOWER-ELEVATOR-DOOR,OPENBIT
	CRLF	
	CALL	ELEVATOR-DOOR-OPENS
	RSTACK	
?CCL3:	SET	'LOWER-ELEVATOR-UP,TRUE-VALUE
	SET	'ELEVATOR-IN-TRANSIT,FALSE-VALUE
	FSET	LOWER-ELEVATOR-DOOR,OPENBIT
	CRLF	
	CALL	ELEVATOR-DOOR-OPENS
	RSTACK	


	.FUNCT	ELEVATOR-DOOR-OPENS
	PRINTR	"The elevator door slides open."


	.FUNCT	HELICOPTER-OBJECT-F
	EQUAL?	PRSA,V?WALK-TO,V?BOARD,V?THROUGH \?CCL3
	EQUAL?	HERE,HELIPAD \?CCL6
	CALL	GOTO,HELICOPTER
	RSTACK	
?CCL6:	PRINTR	"You're in it!"
?CCL3:	EQUAL?	PRSA,V?DISEMBARK,V?DROP,V?EXIT \?CCL8
	EQUAL?	HERE,HELICOPTER \?CCL11
	CALL	GOTO,HELIPAD
	RSTACK	
?CCL11:	PRINTR	"You're not in it!"
?CCL8:	EQUAL?	PRSA,V?FLY \FALSE
	EQUAL?	HERE,HELICOPTER \?CCL16
	PRINTR	"The controls seem to be locked."
?CCL16:	PRINTR	"You're not even in it!"


	.FUNCT	COMM-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This is a small room with no windows. The sole exit is southwest. Two wide consoles fill either end of the room; thick cables lead up into the ceiling.

The console on the left side of the room is labelled ""Reeseev Staashun."" A bright red light, labelled ""Tranzmishun Reeseevd"", is blinking rapidly. Next to the light is a glowing button marked ""Mesij Plaabak.""

The console on the right side of the room is labelled ""Send Staashun."" A screen on the console displays a message. Next to the screen is a flashing sign which says "
	ZERO?	COMM-SHUTDOWN /?CCL6
	CALL	SHUTDOWN
	JUMP	?CND4
?CCL6:	ZERO?	COMM-FIXED /?CCL8
	PRINTI	"""Tranzmishun in pragres."""
	JUMP	?CND4
?CCL8:	PRINTI	"""Malfunkshun in Sendeeng Kuulint Sistum."""
?CND4:	PRINTI	" Next to this console is an enunciator"
	ZERO?	COMM-FIXED \?CCL10
	ZERO?	COMM-SHUTDOWN /?CND9
?CCL10:	PRINTI	" whose lights are all dark"
?CND9:	PRINTR	". On the console next to the enunciator panel is a funnel-shaped hole labelled ""Kuulint Sistum Manyuuwul Oovuriid."""
?CCL3:	EQUAL?	RARG,M-END \FALSE
	ZERO?	COMM-FIXED \FALSE
	ZERO?	COMM-SHUTDOWN \FALSE
	ZERO?	JUST-ENTERED /FALSE
	CALL	QUEUE,I-UNENTER,-1
	PUT	STACK,0,1
	SET	'JUST-ENTERED,FALSE-VALUE
	PRINTI	"A "
	EQUAL?	CHEMICAL-REQUIRED,1 \?CCL21
	PRINTI	"red"
	JUMP	?CND19
?CCL21:	EQUAL?	CHEMICAL-REQUIRED,2 \?CCL23
	PRINTI	"blue"
	JUMP	?CND19
?CCL23:	EQUAL?	CHEMICAL-REQUIRED,3 \?CCL25
	PRINTI	"green"
	JUMP	?CND19
?CCL25:	EQUAL?	CHEMICAL-REQUIRED,4 \?CCL27
	PRINTI	"yellow"
	JUMP	?CND19
?CCL27:	EQUAL?	CHEMICAL-REQUIRED,5 \?CCL29
	PRINTI	"gray"
	JUMP	?CND19
?CCL29:	EQUAL?	CHEMICAL-REQUIRED,6 \?CCL31
	PRINTI	"brown"
	JUMP	?CND19
?CCL31:	EQUAL?	CHEMICAL-REQUIRED,7 \?CND19
	PRINTI	"black"
?CND19:	PRINTR	" colored light is flashing on the enunciator panel."


	.FUNCT	I-UNENTER
	EQUAL?	HERE,COMM-ROOM /FALSE
	SET	'JUST-ENTERED,TRUE-VALUE
	CALL	INT,I-UNENTER
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	PLAYBACK-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	PRINTR	"A voice fills the room ... the voice of the Feinstein's communications officer! ""Stellar Patrol Ship Feinstein to planetside ... Please respond on frequency 48.5 ... SPS Feinstein to planetside ... Please come in ..."" After a pause you hear the officer, in a quieter voice, say ""Admiral, no response on any of the standard frequen..."" The sentence is cut short by the sound of an explosion and a loud burst of static, followed by silence."


	.FUNCT	RANDOMIZE-ORDER,COUNT=0,TEMP,?TMP1,?TMP2
?PRG1:	IGRTR?	'COUNT,7 /?REP2
	PUT	ORDER-LTBL,COUNT,FALSE-VALUE
	JUMP	?PRG1
?REP2:	SET	'COUNT,0
?PRG6:	IGRTR?	'COUNT,7 /TRUE
	RANDOM	7 >TEMP
	GET	ORDER-LTBL,1 >?TMP2
	GET	ORDER-LTBL,2 >?TMP1
	GET	ORDER-LTBL,3
	EQUAL?	TEMP,?TMP2,?TMP1,STACK /?CTR12
	GET	ORDER-LTBL,4 >?TMP2
	GET	ORDER-LTBL,5 >?TMP1
	GET	ORDER-LTBL,6
	EQUAL?	TEMP,?TMP2,?TMP1,STACK /?CTR12
	GET	ORDER-LTBL,7
	EQUAL?	TEMP,STACK \?CCL13
?CTR12:	DEC	'COUNT
	JUMP	?PRG6
?CCL13:	PUT	ORDER-LTBL,COUNT,TEMP
	JUMP	?PRG6


	.FUNCT	CHEMICAL-FLUID-F
	EQUAL?	PRSA,V?EAT \?CCL3
	CALL	JIGS-UP,STR?184
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL5
	EQUAL?	PRSI,CHEMICAL-FLUID \?CCL5
	CALL	PERFORM,V?PUT,PRSO,FLASK
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?POUR,V?THROW \?CCL9
	EQUAL?	PRSI,RAT-ANT,TROLL /?CTR8
	EQUAL?	PRSI,GRUE,TRIFFID \?CCL9
?CTR8:	CALL	HELD?,FLASK
	ZERO?	STACK \?CND14
	PRINTR	"You're not holding the flask."
?CND14:	REMOVE	CHEMICAL-FLUID
	PRINTR	"The mutants lap up the chemical, howling with delight. One immediately grows three new mouths."
?CCL9:	EQUAL?	PRSA,V?POUR,V?PUT \FALSE
	CALL	HELD?,FLASK
	ZERO?	STACK \?CCL20
	PRINTR	"You're not holding the flask."
?CCL20:	EQUAL?	PRSI,CANTEEN \?CND18
	CALL	WORTHLESS-ACTION
	RTRUE	
?CND18:	REMOVE	CHEMICAL-FLUID
	ZERO?	PRSI \?CND22
	SET	'PRSI,GROUND
?CND22:	EQUAL?	PRSI,FUNNEL-HOLE \?CCL26
	EQUAL?	CHEMICAL-FLAG,CHEMICAL-REQUIRED \?CCL29
	GET	ORDER-LTBL,STEPS-TO-GO >CHEMICAL-REQUIRED
	DEC	'STEPS-TO-GO
	PRINTI	"The liquid disappears into the hole. The lights on the enunciator panel blink rapidly "
	ZERO?	STEPS-TO-GO \?CCL32
	SET	'COMM-FIXED,TRUE-VALUE
	ADD	SCORE,6 >SCORE
	SET	'CHEMICAL-REQUIRED,10
	PRINTR	"and then go dark. The coolant system warning light goes off, and another flashes, indicating that the help message is now being sent."
?CCL32:	PRINTI	"and all go off except one, a "
	EQUAL?	CHEMICAL-REQUIRED,1 \?CCL35
	PRINTI	"red"
	JUMP	?CND33
?CCL35:	EQUAL?	CHEMICAL-REQUIRED,2 \?CCL37
	PRINTI	"blue"
	JUMP	?CND33
?CCL37:	EQUAL?	CHEMICAL-REQUIRED,3 \?CCL39
	PRINTI	"green"
	JUMP	?CND33
?CCL39:	EQUAL?	CHEMICAL-REQUIRED,4 \?CCL41
	PRINTI	"yellow"
	JUMP	?CND33
?CCL41:	EQUAL?	CHEMICAL-REQUIRED,5 \?CCL43
	PRINTI	"gray"
	JUMP	?CND33
?CCL43:	EQUAL?	CHEMICAL-REQUIRED,6 \?CCL45
	PRINTI	"brown"
	JUMP	?CND33
?CCL45:	EQUAL?	CHEMICAL-REQUIRED,7 \?CND33
	PRINTI	"black"
?CND33:	PRINTR	" light."
?CCL29:	SET	'COMM-SHUTDOWN,TRUE-VALUE
	ZERO?	COMM-FIXED /?CND47
	SUB	SCORE,6 >SCORE
	SET	'COMM-FIXED,FALSE-VALUE
?CND47:	PRINTI	"An alarm sounds briefly, and a sign flashes "
	CALL	SHUTDOWN
	PRINTR	" A moment later, the lights in the room dim and the send console shuts down."
?CCL26:	EQUAL?	CHEMICAL-FLAG,8,9 \?CCL50
	FSET?	PRSI,ACIDBIT \?CCL53
	EQUAL?	PRSI,SPOUT-PLACED \?CND54
	SET	'SPOUT-PLACED,GROUND
?CND54:	REMOVE	PRSI
	PRINTI	"The "
	PRINTD	PRSI
	PRINTI	" dissolves right before your eyes!"
	EQUAL?	PRSI,BAD-BEDISTOR \?CCL58
	FSET?	BAD-BEDISTOR,TOUCHBIT /?CCL58
	FSET	CUBE,MUNGEDBIT
	CALL	CUBE-SEEMS
	JUMP	?CND56
?CCL58:	EQUAL?	PRSI,GOOD-BEDISTOR \?CND56
	ZERO?	COURSE-CONTROL-FIXED /?CND56
	FSET	CUBE,MUNGEDBIT
	SUB	SCORE,6 >SCORE
	SET	'COURSE-CONTROL-FIXED,FALSE-VALUE
	CALL	CUBE-SEEMS
?CND56:	CRLF	
	RTRUE	
?CCL53:	EQUAL?	CREVICE,PRSI \?CCL65
	FSET?	KEY,TOUCHBIT /?CCL65
	FSET?	KEY,INVISIBLE \?CCL70
	PRINTI	"A puff of smoke rises from the crevice."
	CRLF	
	JUMP	?CND68
?CCL70:	PRINTI	"Although the chemical has no effect on the crevice, it does seem to have dissolved the key that was lying in it."
	CRLF	
?CND68:	REMOVE	KEY
	FSET	KEY,TOUCHBIT
	FCLEAR	KEY,INVISIBLE
	RTRUE	
?CCL65:	EQUAL?	PRSI,HIGH-PROTEIN,MEDICINE \?CCL72
	CALL	JIGS-UP,STR?185
	RSTACK	
?CCL72:	EQUAL?	PRSI,ME,ADVENTURER,HANDS \?CCL74
	CALL	JIGS-UP,STR?186
	RSTACK	
?CCL74:	EQUAL?	PRSI,FLOYD \?CCL76
	FSET?	FLOYD,RLANDBIT \?CCL76
	PRINTR	"Floyd yelps. ""Hey, cut it out! That stuff burns!"""
?CCL76:	EQUAL?	PRSI,MICROBE \?CCL80
	PRINTI	"The microbe writhes in pain. "
	CALL	STRIP-DISSOLVES
	RSTACK	
?CCL80:	EQUAL?	PRSI,STRIP,RELAY \?CCL82
	CALL	STRIP-DISSOLVES
	RSTACK	
?CCL82:	FSET?	PRSI,MUNGBIT \?CCL84
	FSET	PRSI,MUNGEDBIT
	EQUAL?	PRSI,CHRONOMETER \?CND85
	SET	'MUNGED-TIME,INTERNAL-MOVES
?CND85:	PRINTI	"The "
	PRINTD	PRSI
	PRINTI	" seems to undergo some damage as a result of your action."
	CRLF	
	EQUAL?	PRSI,CUBE \TRUE
	ZERO?	COURSE-CONTROL-FIXED /TRUE
	SET	'COURSE-CONTROL-FIXED,FALSE-VALUE
	REMOVE	GOOD-BEDISTOR
	SUB	SCORE,6 >SCORE
	PRINTR	"The bedistor also happens to dissolve."
?CCL84:	CALL	CHEMICAL-POURS
	RSTACK	
?CCL50:	CALL	CHEMICAL-POURS
	RSTACK	


	.FUNCT	CUBE-SEEMS
	PRINTI	" Unfortunately, the cube seems to undergo some damage as well."
	RTRUE	


	.FUNCT	CHEMICAL-POURS
	PRINTI	"The chemical pours all over the "
	PRINTD	PRSI
	PRINTR	", making quite a mess."


	.FUNCT	STRIP-DISSOLVES
	CALL	JIGS-UP,STR?187
	RSTACK	


	.FUNCT	SHUTDOWN
	PRINTI	"""Kuulint Sistum Imbalins Kritikul -- Shuteeng Down Awl Sistumz."""
	RTRUE	


	.FUNCT	COMM-SETUP
	RANDOM	3
	ADD	2,STACK >OLD-SHOTS
	RANDOM	10
	ADD	20,STACK >NEW-SHOTS
	CALL	RANDOMIZE-ORDER
	RANDOM	2
	ADD	1,STACK >STEPS-TO-GO
	ADD	STEPS-TO-GO,1
	GET	ORDER-LTBL,STACK >CHEMICAL-REQUIRED
	RETURN	CHEMICAL-REQUIRED


	.FUNCT	OTHER-ELEVATOR-ENTER-F
	FSET?	LOWER-ELEVATOR-DOOR,OPENBIT \?CCL3
	ZERO?	LOWER-ELEVATOR-UP \?CCL3
	RETURN	LOWER-ELEVATOR
?CCL3:	CALL	DOOR-CLOSED
	CALL	THIS-IS-IT,LOWER-ELEVATOR-DOOR
	RFALSE	


	.FUNCT	KALAMONTEE-PLATFORM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a wide, flat strip of concrete which continues westward. "
	ZERO?	BETTY-AT-KALAMONTEE /?CCL6
	ZERO?	ALFIE-AT-KALAMONTEE /?CCL6
	PRINTI	"Open shuttle cars lie on the north and south sides of the platform. "
	JUMP	?CND4
?CCL6:	ZERO?	BETTY-AT-KALAMONTEE /?CCL10
	PRINTI	"An open shuttle car lies to the north. "
	JUMP	?CND4
?CCL10:	ZERO?	ALFIE-AT-KALAMONTEE /?CND4
	PRINTI	"A large transport of some sort lies to the south, its open door beckoning you to enter. "
?CND4:	PRINTR	"A faded sign on the wall reads ""Shutul Platform -- Kalamontee Staashun."""

	.ENDI
