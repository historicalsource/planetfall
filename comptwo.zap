

	.FUNCT	LAWANDA-PLATFORM-F,RARG
	ZERO?	LAWANDA-PLATFORM-FLAG \?CND1
	SET	'LAWANDA-PLATFORM-FLAG,TRUE-VALUE
	SET	'SICKNESS-WARNING-FLAG,TRUE-VALUE
?CND1:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a wide, flat strip of concrete. "
	ZERO?	ALFIE-AT-KALAMONTEE \?CCL8
	ZERO?	BETTY-AT-KALAMONTEE \?CCL8
	PRINTI	"Open shuttle cars lie to the north and south."
	JUMP	?CND6
?CCL8:	ZERO?	ALFIE-AT-KALAMONTEE /?CCL11
	ZERO?	BETTY-AT-KALAMONTEE \?CND6
?CCL11:	PRINTI	"An open shuttle car lies to the "
	ZERO?	ALFIE-AT-KALAMONTEE /?CCL16
	PRINTI	"north."
	JUMP	?CND6
?CCL16:	PRINTI	"south."
?CND6:	PRINTR	" A wide escalator, not currently operating, beckons upward at the east end of the platform. A faded sign reads ""Shutul Platform -- Lawanda Staashun."""


	.FUNCT	INFIRMARY-F,RARG
	EQUAL?	RARG,M-END \FALSE
	ZERO?	LAZARUS-FLAG \FALSE
	IN?	FLOYD,HERE \FALSE
	FSET?	FLOYD,RLANDBIT \FALSE
	RANDOM	100
	LESS?	30,STACK /FALSE
	SET	'LAZARUS-FLAG,TRUE-VALUE
	MOVE	LAZARUS-PART,HERE
	MOVE	FLOYD,FORK
	SET	'FLOYD-FOLLOW,FALSE-VALUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTR	"Floyd, rummaging in a corner, finds something and carries it to the center of the room to examine it in the brighter light. It seems to be the breast plate of a robot, along with some connected inner circuitry. The entire piece is bent and rusting. Floyd stares at it in complete silence. A moment later, he begins sobbing quietly, awkwardly excuses himself, and runs out of the room. You look at the breast plate, and notice the name ""Lazarus"" engraved on it."


	.FUNCT	RED-SPOOL-F
	EQUAL?	PRSA,V?TAKE \FALSE
	IN?	RED-SPOOL,SPOOL-READER \FALSE
	FSET?	SPOOL-READER,ONBIT \FALSE
	MOVE	RED-SPOOL,ADVENTURER
	FCLEAR	RED-SPOOL,TRYTAKEBIT
	PRINTR	"The screen goes blank as you take the spool."


	.FUNCT	MEDICINE-F,X=0
	EQUAL?	PRSA,V?POUR,V?EAT,V?TASTE \?CCL3
	IN?	MEDICINE-BOTTLE,ADVENTURER /?CCL3
	SET	'PRSO,MEDICINE-BOTTLE
	CALL	NOT-HOLDING
	CALL	THIS-IS-IT,MEDICINE-BOTTLE
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?POUR,V?EAT,V?TASTE \?CCL7
	FSET?	MEDICINE-BOTTLE,OPENBIT /?CCL7
	PRINTR	"The bottle is closed."
?CCL7:	EQUAL?	PRSA,V?TASTE \?CCL11
	PRINTR	"It tastes fairly bitter."
?CCL11:	EQUAL?	PRSA,V?EAT \?CCL13
	REMOVE	MEDICINE
	SET	'C-ELAPSED,15
	SUB	SICKNESS-LEVEL,2 >SICKNESS-LEVEL
	ADD	LOAD-ALLOWED,20 >LOAD-ALLOWED
	PRINTR	"The medicine tasted extremely bitter."
?CCL13:	EQUAL?	PRSA,V?POUR \?CCL15
	REMOVE	MEDICINE
	ZERO?	PRSI \?CND16
	SET	'PRSI,GROUND
?CND16:	EQUAL?	PRSI,FUNNEL-HOLE \?CCL20
	IN?	CHEMICAL-FLUID,FLASK \?CND21
	SET	'X,TRUE-VALUE
?CND21:	SET	'CHEMICAL-REQUIRED,10
	CALL	PERFORM,V?POUR,CHEMICAL-FLUID,FUNNEL-HOLE
	ZERO?	X /TRUE
	MOVE	CHEMICAL-FLUID,FLASK
	RTRUE	
?CCL20:	PRINTI	"It pours over the "
	PRINTD	PRSI
	PRINTR	" and evaporates."
?CCL15:	EQUAL?	PRSA,V?TAKE \FALSE
	GET	P-VTBL,0
	EQUAL?	STACK,W?TAKE \FALSE
	CALL	PERFORM,V?EAT,MEDICINE
	RTRUE	


	.FUNCT	ROBOT-HOLE-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"It's too small for you to get through. It was presumably intended for robots, such as the broken repair robot lying over there."
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL5
	PRINTR	"You can make out a small supply room of some sort."
?CCL5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTR	"There's no door, just an opening in the wall."


	.FUNCT	FLOYD-THROUGH-HOLE
	ZERO?	HOLE-TRIP-FLAG /?CCL3
	PRINTR	"""Not again,"" whines Floyd."
?CCL3:	SET	'C-ELAPSED,50
	SET	'HOLE-TRIP-FLAG,TRUE-VALUE
	SET	'BOARD-REPORTED,TRUE-VALUE
	FCLEAR	GOOD-BOARD,INVISIBLE
	PRINTR	"Floyd squeezes through the opening and is gone for quite a while. You hear thudding noises and squeals of enjoyment. After a while the noise stops, and Floyd emerges, looking downcast. ""Floyd found a rubber ball inside. Lots of fun for a while, but must have been old, because it fell apart. Nothing else interesting inside. Just a shiny fromitz board."""


	.FUNCT	GOOD-BOARD-F
	FSET?	GOOD-BOARD,NDESCBIT \?CCL3
	EQUAL?	PRSA,V?LOOK-UNDER /?PRD6
	EQUAL?	PRSA,V?MOVE,V?PULL,V?PUSH /?PRD6
	EQUAL?	PRSA,V?RUB,V?EXAMINE,V?TAKE \?CCL3
?PRD6:	EQUAL?	GOOD-BOARD,PRSO \?CCL3
	PRINTI	"You can't see any "
	PRINTD	PRSO
	PRINTR	" here."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	EXAMINE-BOARD
	CRLF	
	RTRUE	


	.FUNCT	PLANETARY-DEFENSE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This room is filled with a dazzling array of lights and controls. "
	ZERO?	DEFENSE-FIXED \?CND4
	PRINTI	"One light, blinking quickly, catches your eye. It reads ""Surkit Boord Faalyur. WORNEENG: xis boord kuntroolz xe diskriminaashun surkits."""
?CND4:	PRINTI	" There is a small access panel on one wall which is "
	CALL	DDESC,ACCESS-PANEL
	PRINTR	"."


	.FUNCT	ACCESS-PANEL-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	ACCESS-PANEL,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	FSET	ACCESS-PANEL,OPENBIT
	PRINTI	"The panel swings open."
	CRLF	
	CALL	PERFORM,V?LOOK-INSIDE,ACCESS-PANEL
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL8
	FSET?	ACCESS-PANEL,OPENBIT \?CCL11
	FCLEAR	ACCESS-PANEL,OPENBIT
	PRINTR	"The panel swings closed."
?CCL11:	CALL	IS-CLOSED
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,ACCESS-PANEL \FALSE
	FSET?	ACCESS-PANEL,OPENBIT /?CCL18
	PRINTR	"The panel is closed."
?CCL18:	ZERO?	ACCESS-PANEL-FULL /?CCL20
	PRINTR	"There's no room."
?CCL20:	EQUAL?	PRSO,GOOD-BOARD \?CCL22
	REMOVE	GOOD-BOARD
	MOVE	SECOND-BOARD,ACCESS-PANEL
	CALL	THIS-IS-IT,SECOND-BOARD
	SET	'DEFENSE-FIXED,TRUE-VALUE
	ADD	SCORE,6 >SCORE
	SET	'ACCESS-PANEL-FULL,TRUE-VALUE
	CALL	PUT-BOARD
	PRINTR	" The warning lights stop flashing."
?CCL22:	EQUAL?	PRSO,CRACKED-BOARD,FRIED-BOARD \?CCL24
	REMOVE	PRSO
	CALL	THIS-IS-IT,SECOND-BOARD
	MOVE	SECOND-BOARD,ACCESS-PANEL
	SET	'ACCESS-PANEL-FULL,TRUE-VALUE
	EQUAL?	PRSO,CRACKED-BOARD \?CND25
	SET	'ITS-CRACKED,TRUE-VALUE
?CND25:	CALL	PUT-BOARD
	CRLF	
	RTRUE	
?CCL24:	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" doesn't fit."
	RTRUE	


	.FUNCT	FRIED-BOARD-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	EXAMINE-BOARD
	PRINTR	" This one is a bit blackened around the edges, though."


	.FUNCT	BOARD-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	EQUAL?	PRSO,SECOND-BOARD \?CCL6
	ZERO?	DEFENSE-FIXED /?CCL9
	CALL	BOARD-SHOCK
	RSTACK	
?CCL9:	PRINTI	"The fromitz board slides out of the panel, producing an empty socket for another board."
	CRLF	
	REMOVE	SECOND-BOARD
	SET	'ACCESS-PANEL-FULL,FALSE-VALUE
	EQUAL?	ITS-CRACKED,TRUE-VALUE \?CCL12
	MOVE	CRACKED-BOARD,ADVENTURER
	JUMP	?CND10
?CCL12:	MOVE	FRIED-BOARD,ADVENTURER
?CND10:	CALL	THIS-IS-IT,FRIED-BOARD
	RSTACK	
?CCL6:	CALL	BOARD-SHOCK
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	EXAMINE-BOARD
	CRLF	
	RTRUE	


	.FUNCT	EXAMINE-BOARD
	PRINTI	"Like most fromitz boards, it is a twisted maze of silicon circuits. It is square, approximately seventeen centimeters on each side."
	RTRUE	


	.FUNCT	PUT-BOARD
	PRINTI	"The card clicks neatly into the socket."
	RTRUE	


	.FUNCT	BOARD-SHOCK
	PRINTR	"You jerk your hand back as you receive a powerful shock from the fromitz board."


	.FUNCT	PLANETARY-COURSE-CONTROL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a long room whose walls are covered with complicated controls and colored lights. "
	ZERO?	COURSE-CONTROL-FIXED /?CCL6
	PRINTI	"One blinking light says ""Kors diivurjins minimiizeeng."""
	JUMP	?CND4
?CCL6:	PRINTI	"Two of these lights are blinking. The first one reads ""Bedistur Faalyur!"" The other light reads ""Kritikul diivurjins frum pland kors."""
?CND4:	PRINTI	" In one corner is a large metal cube whose lid is "
	FSET?	CUBE,OPENBIT \?CCL9
	PRINTI	"open"
	JUMP	?CND7
?CCL9:	PRINTI	"closed"
?CND7:	PRINTR	"."


	.FUNCT	CUBE-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	CUBE,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	FSET	CUBE,OPENBIT
	PRINTI	"The lid swings open."
	CRLF	
	CALL	PERFORM,V?LOOK-INSIDE,CUBE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL8
	FSET?	CUBE,OPENBIT \?CCL11
	FCLEAR	CUBE,OPENBIT
	PRINTR	"The lid swings closed."
?CCL11:	CALL	IS-CLOSED
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,CUBE \FALSE
	FSET?	CUBE,OPENBIT /?CCL18
	PRINTR	"The cube is closed."
?CCL18:	IN?	BAD-BEDISTOR,CUBE \?CCL20
	PRINTR	"There's a fused bedistor in the way."
?CCL20:	EQUAL?	PRSO,GOOD-BEDISTOR \?CCL22
	MOVE	GOOD-BEDISTOR,CUBE
	FSET?	CUBE,MUNGEDBIT /?CCL25
	SET	'COURSE-CONTROL-FIXED,TRUE-VALUE
	FSET	GOOD-BEDISTOR,TRYTAKEBIT
	ADD	SCORE,6 >SCORE
	PRINTR	"Done. The warning lights go out and another light goes on."
?CCL25:	PRINTR	"Done."
?CCL22:	EQUAL?	PRSO,BAD-BEDISTOR \?CCL27
	MOVE	BAD-BEDISTOR,CUBE
	PRINTR	"Done."
?CCL27:	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" doesn't fit."
	RTRUE	


	.FUNCT	BAD-BEDISTOR-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	IN?	BAD-BEDISTOR,CUBE \?CCL3
	PRINTR	"It seems to be fused to its socket."
?CCL3:	EQUAL?	PRSA,V?ZATTRACT \FALSE
	EQUAL?	PRSI,PLIERS \?CCL10
	MOVE	BAD-BEDISTOR,ADVENTURER
	FCLEAR	BAD-BEDISTOR,TRYTAKEBIT
	PRINTR	"With a tug, you manage to remove the fused bedistor."
?CCL10:	PRINTR	"You can't get a grip on the bedistor with that."


	.FUNCT	GREEN-SPOOL-F
	EQUAL?	PRSA,V?TAKE \FALSE
	IN?	GREEN-SPOOL,SPOOL-READER \FALSE
	FSET?	SPOOL-READER,ONBIT \FALSE
	MOVE	GREEN-SPOOL,ADVENTURER
	FCLEAR	GREEN-SPOOL,TRYTAKEBIT
	PRINTR	"The screen goes blank as you take the spool."


	.FUNCT	TERMINAL-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The computer terminal consists of a video display screen, a keyboard with ten keys numbered from zero through nine, and an on-off switch. "
	FSET?	TERMINAL,ONBIT \?CCL6
	PRINTI	"The screen displays some writing:"
	CRLF	
	PRINT	SCREEN-TEXT
	CRLF	
	GRTR?	MENU-LEVEL,9 \TRUE
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL6:	PRINTR	"The screen is dark."
?CCL3:	EQUAL?	PRSA,V?READ \?CCL10
	FSET?	TERMINAL,ONBIT \?CCL13
	PRINT	SCREEN-TEXT
	CRLF	
	GRTR?	MENU-LEVEL,9 \TRUE
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL13:	PRINTR	"The screen is blank."
?CCL10:	EQUAL?	PRSA,V?LAMP-ON \?CCL17
	FSET?	TERMINAL,ONBIT \?CCL20
	PRINTR	"It's already on."
?CCL20:	FSET	TERMINAL,ONBIT
	FSET	TERMINAL,TOUCHBIT
	SET	'SCREEN-TEXT,MAIN-MENU
	PRINTI	"The screen gives off a green flash, and then some writing appears on the screen:"
	CRLF	
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL17:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	FSET?	TERMINAL,ONBIT \?CCL25
	FCLEAR	TERMINAL,ONBIT
	SET	'MENU-LEVEL,0
	PRINTR	"The screen goes dark."
?CCL25:	PRINTR	"It isn't on!"


	.FUNCT	LIBRARY-TYPE
	EQUAL?	PRSO,INTNUM /?CCL3
	CALL	NUMBERS-ONLY
	RSTACK	
?CCL3:	ZERO?	MENU-LEVEL \?CCL5
	ZERO?	P-NUMBER \?CCL8
	PRINT	NO-MEANING
	CRLF	
	RTRUE	
?CCL8:	EQUAL?	P-NUMBER,1 \?CCL10
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,HISTORY-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	SET	'MENU-LEVEL,1
	RETURN	MENU-LEVEL
?CCL10:	EQUAL?	P-NUMBER,2 \?CCL12
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,CULTURE-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	SET	'MENU-LEVEL,2
	RETURN	MENU-LEVEL
?CCL12:	EQUAL?	P-NUMBER,3 \?CCL14
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,TECHNOLOGY-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	SET	'MENU-LEVEL,3
	RETURN	MENU-LEVEL
?CCL14:	EQUAL?	P-NUMBER,4 \?CCL16
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,GEOGRAPHY-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	SET	'MENU-LEVEL,4
	RETURN	MENU-LEVEL
?CCL16:	EQUAL?	P-NUMBER,5 \?CCL18
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,PROJECT-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	SET	'MENU-LEVEL,5
	RETURN	MENU-LEVEL
?CCL18:	EQUAL?	P-NUMBER,6 \?CCL20
	SET	'MENU-LEVEL,6
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,INTERLOGIC-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL20:	GRTR?	P-NUMBER,6 \FALSE
	PRINT	NO-MEANING
	CRLF	
	RTRUE	
?CCL5:	EQUAL?	MENU-LEVEL,1 \?CCL24
	ZERO?	P-NUMBER \?CCL27
	SET	'MENU-LEVEL,0
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,MAIN-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL27:	EQUAL?	P-NUMBER,1 \?CCL29
	SET	'MENU-LEVEL,11
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,11-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL29:	EQUAL?	P-NUMBER,2 \?CCL31
	SET	'MENU-LEVEL,12
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,12-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL31:	EQUAL?	P-NUMBER,3 \?CCL33
	SET	'MENU-LEVEL,13
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,13-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL33:	GRTR?	P-NUMBER,3 \FALSE
	PRINT	NO-MEANING
	CRLF	
	RTRUE	
?CCL24:	EQUAL?	MENU-LEVEL,2 \?CCL37
	ZERO?	P-NUMBER \?CCL40
	SET	'MENU-LEVEL,0
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,MAIN-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL40:	EQUAL?	P-NUMBER,1 \?CCL42
	SET	'MENU-LEVEL,21
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,21-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL42:	EQUAL?	P-NUMBER,2 \?CCL44
	SET	'MENU-LEVEL,22
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,22-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL44:	EQUAL?	P-NUMBER,3 \?CCL46
	SET	'MENU-LEVEL,23
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,23-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL46:	GRTR?	P-NUMBER,4 \FALSE
	PRINT	NO-MEANING
	CRLF	
	RTRUE	
?CCL37:	EQUAL?	MENU-LEVEL,3 \?CCL50
	ZERO?	P-NUMBER \?CCL53
	SET	'MENU-LEVEL,0
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,MAIN-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL53:	EQUAL?	P-NUMBER,1 \?CCL55
	SET	'MENU-LEVEL,31
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,31-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL55:	EQUAL?	P-NUMBER,2 \?CCL57
	SET	'MENU-LEVEL,32
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,32-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL57:	EQUAL?	P-NUMBER,3 \?CCL59
	SET	'MENU-LEVEL,33
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,33-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL59:	EQUAL?	P-NUMBER,4 \?CCL61
	SET	'MENU-LEVEL,34
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,34-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL61:	EQUAL?	P-NUMBER,5 \?CCL63
	SET	'MENU-LEVEL,35
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,35-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL63:	GRTR?	P-NUMBER,5 \FALSE
	PRINT	NO-MEANING
	CRLF	
	RTRUE	
?CCL50:	EQUAL?	MENU-LEVEL,4 \?CCL67
	ZERO?	P-NUMBER \?CCL70
	SET	'MENU-LEVEL,0
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,MAIN-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL70:	EQUAL?	P-NUMBER,1 \?CCL72
	SET	'MENU-LEVEL,41
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,41-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL72:	EQUAL?	P-NUMBER,2 \?CCL74
	SET	'MENU-LEVEL,42
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,42-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL74:	EQUAL?	P-NUMBER,3 \?CCL76
	SET	'MENU-LEVEL,43
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,43-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL76:	GRTR?	P-NUMBER,3 \FALSE
	PRINT	NO-MEANING
	CRLF	
	RTRUE	
?CCL67:	EQUAL?	MENU-LEVEL,5 \?CCL80
	ZERO?	P-NUMBER \?CCL83
	SET	'MENU-LEVEL,0
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,MAIN-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL83:	EQUAL?	P-NUMBER,1 \?CCL85
	SET	'MENU-LEVEL,51
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,51-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL85:	EQUAL?	P-NUMBER,2 \?CCL87
	SET	'MENU-LEVEL,52
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,52-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL87:	EQUAL?	P-NUMBER,3 \?CCL89
	SET	'MENU-LEVEL,53
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,53-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL89:	GRTR?	P-NUMBER,3 \FALSE
	PRINT	NO-MEANING
	CRLF	
	RTRUE	
?CCL80:	EQUAL?	MENU-LEVEL,6 \?CCL93
	ZERO?	P-NUMBER \?CCL96
	SET	'MENU-LEVEL,0
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,MAIN-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL96:	EQUAL?	P-NUMBER,1 \?CCL98
	SET	'MENU-LEVEL,61
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,61-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	IN?	FLOYD,HERE \FALSE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTR	"Floyd, peering over your shoulder, says ""Oh, I love that game! Solved every problem, except couldn't figure out how to get into white house."""
?CCL98:	EQUAL?	P-NUMBER,2 \?CCL103
	SET	'MENU-LEVEL,62
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,62-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL103:	EQUAL?	P-NUMBER,3 \?CCL105
	SET	'MENU-LEVEL,63
	PRINT	TEXT-APPEARS
	CRLF	
	SET	'SCREEN-TEXT,63-TEXT
	PRINT	SCREEN-TEXT
	CRLF	
	PRINT	MORE-INFO
	CRLF	
	RTRUE	
?CCL105:	GRTR?	P-NUMBER,3 \FALSE
	PRINT	NO-MEANING
	CRLF	
	RTRUE	
?CCL93:	GRTR?	MENU-LEVEL,10 \?CCL109
	LESS?	MENU-LEVEL,20 \?CCL109
	ZERO?	P-NUMBER \?CCL114
	SET	'MENU-LEVEL,1
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,HISTORY-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL114:	PRINT	LOW-END
	CRLF	
	RTRUE	
?CCL109:	GRTR?	MENU-LEVEL,20 \?CCL116
	LESS?	MENU-LEVEL,30 \?CCL116
	ZERO?	P-NUMBER \?CCL121
	SET	'MENU-LEVEL,2
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,CULTURE-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL121:	PRINT	LOW-END
	CRLF	
	RTRUE	
?CCL116:	GRTR?	MENU-LEVEL,30 \?CCL123
	LESS?	MENU-LEVEL,40 \?CCL123
	ZERO?	P-NUMBER \?CCL128
	SET	'MENU-LEVEL,3
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,TECHNOLOGY-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL128:	PRINT	LOW-END
	CRLF	
	RTRUE	
?CCL123:	GRTR?	MENU-LEVEL,40 \?CCL130
	LESS?	MENU-LEVEL,50 \?CCL130
	ZERO?	P-NUMBER \?CCL135
	SET	'MENU-LEVEL,4
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,GEOGRAPHY-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL135:	PRINT	LOW-END
	CRLF	
	RTRUE	
?CCL130:	GRTR?	MENU-LEVEL,50 \?CCL137
	LESS?	MENU-LEVEL,60 \?CCL137
	ZERO?	P-NUMBER \?CCL142
	SET	'MENU-LEVEL,5
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,PROJECT-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL142:	PRINT	LOW-END
	CRLF	
	RTRUE	
?CCL137:	GRTR?	MENU-LEVEL,60 \FALSE
	LESS?	MENU-LEVEL,70 \FALSE
	ZERO?	P-NUMBER \?CCL149
	SET	'MENU-LEVEL,6
	PRINT	SCREEN-CLEARS
	CRLF	
	SET	'SCREEN-TEXT,INTERLOGIC-MENU
	PRINT	SCREEN-TEXT
	CRLF	
	RTRUE	
?CCL149:	PRINT	LOW-END
	CRLF	
	RTRUE	


	.FUNCT	SPOOL-READER-F
	EQUAL?	PRSA,V?LAMP-ON \?CCL3
	FSET?	SPOOL-READER,ONBIT \?CCL6
	PRINTR	"The spool reader is already on."
?CCL6:	FSET	SPOOL-READER,ONBIT
	FSET	SPOOL-READER,TOUCHBIT
	FIRST?	SPOOL-READER \?CCL9
	PRINT	SPOOL-TEXT
	CRLF	
	RTRUE	
?CCL9:	PRINTR	"The machine hums quietly, and the screen lights up with the phrase ""Pleez insurt spuul."""
?CCL3:	EQUAL?	PRSA,V?LAMP-OFF \?CCL11
	FSET?	SPOOL-READER,ONBIT \?CCL14
	FCLEAR	SPOOL-READER,ONBIT
	PRINTR	"The spool reader is now off."
?CCL14:	PRINTR	"It's not on!"
?CCL11:	EQUAL?	PRSA,V?EXAMINE \?CCL16
	PRINTI	"The machine has a small screen, and below that, a small circular opening. The screen is currently "
	FSET?	SPOOL-READER,ONBIT \?CCL19
	FIRST?	SPOOL-READER \?CCL19
	PRINTI	"displaying some information:"
	CRLF	
	PRINT	SPOOL-TEXT
	CRLF	
	RTRUE	
?CCL19:	PRINTR	"blank."
?CCL16:	EQUAL?	PRSA,V?READ \?CCL23
	FSET?	SPOOL-READER,ONBIT \?CCL26
	FIRST?	SPOOL-READER \?CCL26
	PRINT	SPOOL-TEXT
	CRLF	
	RTRUE	
?CCL26:	PRINTR	"The screen is blank."
?CCL23:	EQUAL?	PRSA,V?PUT \?CCL30
	EQUAL?	PRSI,SPOOL-READER \?CCL30
	FIRST?	SPOOL-READER \?CCL35
	PRINTR	"There's already a spool in the reader."
?CCL35:	EQUAL?	PRSO,GREEN-SPOOL \?CCL37
	SET	'SPOOL-TEXT,GREEN-TEXT
	MOVE	GREEN-SPOOL,SPOOL-READER
	FSET	GREEN-SPOOL,TRYTAKEBIT
	PRINT	SPOOL-FITS
	FSET?	SPOOL-READER,ONBIT \?CND38
	PRINT	SOME-INFO
?CND38:	CRLF	
	RTRUE	
?CCL37:	EQUAL?	PRSO,RED-SPOOL \?CCL41
	SET	'SPOOL-TEXT,RED-TEXT
	MOVE	RED-SPOOL,SPOOL-READER
	FSET	RED-SPOOL,TRYTAKEBIT
	PRINT	SPOOL-FITS
	FSET?	SPOOL-READER,ONBIT \?CND42
	PRINT	SOME-INFO
?CND42:	CRLF	
	RTRUE	
?CCL41:	PRINTR	"It doesn't fit in the circular opening."
?CCL30:	EQUAL?	PRSA,V?CLOSE \FALSE
	CALL	NO-CLOSE
	RTRUE	


	.FUNCT	PROJCON-OFFICE-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This office looks like a headquarters of some kind. Exits lead north and east. The west wall displays a logo. "
	ZERO?	COMPUTER-FIXED /?CCL6
	PRINTR	"The mural that previously adorned the south wall has slid away, revealing an open doorway to a large elevator!"
?CCL6:	PRINTR	"The south wall is completely covered by a garish mural which clashes with the other decor of the room."
?CCL3:	EQUAL?	RARG,M-END \FALSE
	IN?	FLOYD,HERE \FALSE
	ZERO?	MURAL-FLAG \FALSE
	SET	'MURAL-FLAG,TRUE-VALUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTR	"Floyd surveys the mural and scratches his head. ""I don't remember seeing this before,"" he comments."


	.FUNCT	CRYO-ELEVATOR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a large, plain elevator with one solitary button and a door to the north which is "
	CALL	DDESC,CRYO-ELEVATOR-DOOR
	PRINTR	"."


	.FUNCT	CRYO-EXIT-F
	FSET?	CRYO-ELEVATOR-DOOR,OPENBIT \?CCL3
	ZERO?	CRYO-SCORE-FLAG /?CCL6
	RETURN	CRYO-ANTEROOM
?CCL6:	RETURN	PROJCON-OFFICE
?CCL3:	CALL	DOOR-CLOSED
	RFALSE	


	.FUNCT	I-CRYO-ELEVATOR-ARRIVE
	FSET	CRYO-ELEVATOR-DOOR,OPENBIT
	CRLF	
	PRINTR	"The elevator door opens onto a room to the north."


	.FUNCT	CRYO-ANTEROOM-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"The elevator closes as you leave it, and you find yourself in a small, chilly room. To the north, through a wide arch, is an enormous chamber lined from floor to ceiling with thousands of cryo-units. You can see similar chambers beyond, and your mind staggers at the thought of the millions of individuals asleep for countless centuries.

In the anteroom where you stand is a solitary cryo-unit, its cover frosted. Next to the cryo-unit is a complicated control panel."
	CRLF	
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	RARG,M-END \FALSE
	PRINTI	"A door slides open and a medical robot glides in. It opens the cryo-unit and administers an injection to its inhabitant. As the robot glides away, a figure rises from the cryo-unit -- a handsome, middle-aged woman with flowing red hair. She spends some time studying readouts from the control panel"
	ZERO?	COMM-FIXED /?CCL8
	ZERO?	DEFENSE-FIXED /?CCL8
	PRINTI	", pressing several keys."
	CRLF	
	JUMP	?CND6
?CCL8:	PRINTC	46
	CRLF	
?CND6:	ZERO?	COURSE-CONTROL-FIXED /?CCL13
	PRINTI	"
As other cryo-units in the chambers beyond begin opening, the woman turns to you, bows gracefully, and speaks in a beautiful, lilting voice. ""I am Veldina, leader of Resida. Thanks to you, the cure has been discovered, and the planetary systems repaired. We are eternally grateful."""
	CRLF	
	ZERO?	COMM-FIXED /?CCL16
	ZERO?	DEFENSE-FIXED /?CCL16
	PRINTI	"
""You will also be glad to hear that a ship of your Stellar Patrol now orbits the planet. I have sent them the coordinates for this room."" As if on cue, a landing party from the S.P.S. Flathead materializes nearby. Blather is with them, having been picked up from deep space in another escape pod, babbling cravenly. Captain Sterling of the Flathead acknowledges your heroic actions, and informs you of your promotion to Lieutenant First Class.

As a team of mutant hunters head for the cryo-elevator, Veldina mentions that the grateful people of Resida offer you leadership of their world. Captain Sterling points out that, even if you choose to remain on Resida, Blather (demoted to Ensign Twelfth Class) has been assigned as your personal toilet attendant.

You feel a sting from your arm and turn to see a medical robot moving away after administering the antidote for The Disease.

A team of robot technicians step into the anteroom. They part their ranks, and a familiar figure comes bounding toward you! ""Hi!"" shouts Floyd, with uncontrolled enthusiasm. ""Floyd feeling better now!"" Smiling from ear to ear, he says, ""Look what Floyd found!"" He hands you a helicopter key, a reactor elevator card, and a paddleball set. ""Maybe we can use them in the sequel..."""
	CRLF	
	CRLF	
	CALL	FINISH,FALSE-VALUE
	RSTACK	
?CCL16:	PRINTI	"
""Unfortunately, a second ship from your Stellar Patrol has "
	ZERO?	DEFENSE-FIXED \?CCL21
	PRINTI	"been destroyed by our malfunctioning meteor defenses."
	JUMP	?CND19
?CCL21:	PRINTI	"come looking for survivors, and because of our malfunctioning communications system, has given up and departed."
?CND19:	PRINTI	" I fear that you are stranded on Resida, possibly forever. However, we show our gratitude by offering you an unlimited bank account and a house in the country."""
	CRLF	
	CRLF	
	CALL	FINISH,FALSE-VALUE
	RSTACK	
?CCL13:	PRINTI	"
She turns to you and, with a strained voice says, ""You have fixed our computer and a Cure has been discovered, and we are grateful. But alas, it was all in vain. Our planetary course control system has malfunctioned, and the orbit has now decayed beyond correction. Soon Resida will plunge into the sun."""
	CRLF	
	CRLF	
	ZERO?	COMM-FIXED /?CND22
	ZERO?	DEFENSE-FIXED /?CND22
	PRINTI	"Veldina examines the control panel again. ""Fortunately, another ship from your Stellar Patrol has arrived, so at least you will survive."" At that moment, a landing party from the S.P.S. Flathead materializes, and takes you away from the doomed world."
	CRLF	
	CRLF	
?CND22:	CALL	FINISH,FALSE-VALUE
	RSTACK	


	.FUNCT	COMPUTER-ACTION
	SET	'COMPUTER-FLAG,TRUE-VALUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	PRINTI	"Floyd examines the "
	EQUAL?	HERE,COMPUTER-ROOM \?CCL3
	PRINTI	"glowing light"
	JUMP	?CND1
?CCL3:	PRINTI	"computer printout"
?CND1:	PRINTR	". With a concerned frown, he says, ""Uh oh. Computer is broken. A Doctor-person once told Floyd that Computer is the most important part of the Project."""


	.FUNCT	PRINT-OUT-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"The printout is hundreds of pages long. It would take many chrons to read it all. The last page looks pretty interesting, though:

""Daalee Statis Reeport:
PREELIMINEREE REESURC:  100.000%
INTURMEEDEEIT REESURC:  100.000%
FIINUL REESURC:         100.000%
DRUG PROODUKSHUN:       100.000%
DRUG TESTEENG:           99.985%
Proojektid tiim tuu reeviivul prooseedzur:  0 daaz, 0.8 kronz


*** ALURT! ALURT! ***
Malfunkshun in Sekshun 384! Sumuneeng reepaar roobot.""

The printout ends at this point."
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	MINI-CARD-F
	FSET?	MINI-CARD,NDESCBIT \FALSE
	EQUAL?	PRSA,V?SMELL,V?PULL /?CCL3
	EQUAL?	PRSA,V?PUSH,V?TAKE,V?SET /?CCL3
	EQUAL?	PRSA,V?TURN,V?MOVE,V?RUB \FALSE
?CCL3:	PRINTR	"It's in the next room."


	.FUNCT	LAB-UNIFORM-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It is a plain lab uniform. The logo above the pocket depicts a flame burning above some kind of sleep chamber. The pocket is "
	CALL	DDESC,LAB-UNIFORM
	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?OPEN,V?SEARCH \?CCL5
	FSET?	LAB-UNIFORM,OPENBIT \?CCL8
	PRINTR	"The pocket is already open."
?CCL8:	FSET	LAB-UNIFORM,OPENBIT
	ZERO?	UNIFORM-OPENED /?CCL11
	FIRST?	LAB-UNIFORM \?CCL14
	PRINTI	"Opening the uniform's pocket reveals "
	CALL	PRINT-CONTENTS,LAB-UNIFORM
	PRINTR	"."
?CCL14:	PRINTR	"The pocket is empty."
?CCL11:	FSET	LAB-UNIFORM,OPENBIT
	SET	'UNIFORM-OPENED,TRUE-VALUE
	PRINTR	"You discover a small piece of paper and a teleportation access card in the pocket of the uniform."
?CCL5:	EQUAL?	PRSA,V?WEAR \FALSE
	FSET?	PATROL-UNIFORM,WORNBIT \FALSE
	PRINTR	"It won't fit on top of the Patrol uniform."


	.FUNCT	COMBINATION-PAPER-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTI	"Week uv 14-Juun--2882. Kombinaashun tuu Konfurins Ruum: "
	PRINTN	NUMBER-NEEDED
	PRINTR	"."


	.FUNCT	BIO-LOCK-EAST-F,RARG
	EQUAL?	RARG,M-END \FALSE
	IN?	FLOYD,HERE \FALSE
	FSET?	FLOYD,RLANDBIT \FALSE
	EQUAL?	FLOYD,WINNER /FALSE
	ZERO?	FLOYD-WAITING /?CCL10
	GRTR?	WAITING-COUNTER,3 \?CCL13
	SET	'FLOYD-WAITING,FALSE-VALUE
	SET	'FLOYD-GAVE-UP,TRUE-VALUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	SET	'FLOYD-FOLLOW,FALSE-VALUE
	MOVE	FLOYD,BIO-LOCK-WEST
	CALL	QUEUE,I-FLOYD,1
	PUT	STACK,0,1
	PRINTR	"""Okay,"" says Floyd with uncharacteristic annoyance. ""Forget about the stupid card."" He goes to the other end of the bio-lock and sulks."
?CCL13:	ZERO?	FLOYD-FORAYED \FALSE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	INC	'WAITING-COUNTER
	PRINTR	"Floyd looks at you with a dash of impatience and a healthy helping of nervousness. ""Well?"" he asks. ""Are you going to open the door?"""
?CCL10:	ZERO?	FLOYD-GAVE-UP \FALSE
	ZERO?	FLOYD-PEERED \FALSE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	SET	'FLOYD-PEERED,TRUE-VALUE
	CALL	QUEUE,I-CLEAR-FLOYD-PEER,40
	PUT	STACK,0,1
	FCLEAR	MINI-CARD,INVISIBLE
	PRINTI	"Floyd stands on his tiptoes and peers in the window. "
	ZERO?	COMPUTER-FLAG /?CCL22
	SET	'FLOYD-WAITING,TRUE-VALUE
	PRINTR	"""Looks dangerous in there,"" says Floyd. ""I don't think you should go inside."" He peers in again. ""We'll need card there to fix computer. Hmmm... I know! Floyd will get card. Robots are tough. Nothing can hurt robots. You open the door, then Floyd will rush in. Then you close door. When Floyd knocks, open door again. Okay? Go!"" Floyd's voice trembles slightly as he waits for you to open the door."
?CCL22:	PRINTR	"""Ooo, look,"" he says. ""There's a miniaturization booth access card!"""


	.FUNCT	I-CLEAR-FLOYD-PEER
	SET	'FLOYD-PEERED,FALSE-VALUE
	RFALSE	


	.FUNCT	BIO-DOOR-EAST-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	BIO-DOOR-EAST,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	FSET?	BIO-DOOR-WEST,OPENBIT \?CCL8
	PRINT	BOTH-DOORS
	CRLF	
	RTRUE	
?CCL8:	ZERO?	FLOYD-WAITING /?CCL10
	FSET?	FLOYD,RLANDBIT \?CCL10
	ZERO?	FORAY-COUNTER \?CCL10
	CALL	QUEUE,I-FLOYD-FORAY,-1
	PUT	STACK,0,1
	SET	'FLOYD-FORAYED,TRUE-VALUE
	FSET	BIO-DOOR-EAST,OPENBIT
	REMOVE	FLOYD
	CALL	INT,I-FLOYD
	PUT	STACK,0,0
	PRINTR	"The door opens and Floyd, pausing only for the briefest moment, plunges into the Bio Lab. Immediately, he is set upon by hideous, mutated monsters! More are heading straight toward the open door! Floyd shrieks and yells to you to close the door."
?CCL10:	ZERO?	FLOYD-FORAYED \?CCL15
	CALL	INT,I-CHASE-SCENE
	GET	STACK,C-ENABLED?
	ZERO?	STACK \?CCL15
	CALL	JIGS-UP,STR?265
	RSTACK	
?CCL15:	FSET	BIO-DOOR-EAST,OPENBIT
	CALL	QUEUE,I-BIO-EAST-CLOSES,30
	PUT	STACK,0,1
	PRINT	DOOR-OPENS
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	BIO-DOOR-EAST,OPENBIT \?CCL22
	EQUAL?	FORAY-COUNTER,4 \?CND23
	SET	'C-ELAPSED,95
?CND23:	FCLEAR	BIO-DOOR-EAST,OPENBIT
	PRINTI	"The door closes"
	CALL	INT,I-CHASE-SCENE
	GET	STACK,C-ENABLED?
	EQUAL?	STACK,1 \?CCL27
	PRINTR	", but not soon enough!"
?CCL27:	PRINTR	"."
?CCL22:	CALL	IS-CLOSED
	RSTACK	


	.FUNCT	I-BIO-EAST-CLOSES
	FSET?	BIO-DOOR-EAST,OPENBIT \FALSE
	FCLEAR	BIO-DOOR-EAST,OPENBIT
	EQUAL?	HERE,BIO-LOCK-EAST,BIO-LOCK-WEST,BIO-LAB \FALSE
	CRLF	
	PRINTR	"The door at the eastern end of the bio-lock closes silently."


	.FUNCT	BIO-DOOR-WEST-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	BIO-DOOR-WEST,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	FSET?	BIO-DOOR-EAST,OPENBIT \?CCL8
	PRINT	BOTH-DOORS
	CRLF	
	RTRUE	
?CCL8:	PRINT	DOOR-OPENS
	CRLF	
	CALL	QUEUE,I-BIO-WEST-CLOSES,30
	PUT	STACK,0,1
	FSET	BIO-DOOR-WEST,OPENBIT
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	BIO-DOOR-WEST,OPENBIT \?CCL13
	FCLEAR	BIO-DOOR-WEST,OPENBIT
	PRINT	DOOR-CLOSES
	CRLF	
	RTRUE	
?CCL13:	CALL	IS-CLOSED
	RSTACK	


	.FUNCT	I-BIO-WEST-CLOSES
	FSET?	BIO-DOOR-WEST,OPENBIT \FALSE
	FCLEAR	BIO-DOOR-WEST,OPENBIT
	EQUAL?	HERE,BIO-LOCK-WEST,BIO-LOCK-EAST,MAIN-LAB \FALSE
	CRLF	
	PRINTR	"The door at the western end of the bio-lock closes silently."


	.FUNCT	RAD-DOOR-EAST-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	RAD-DOOR-EAST,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	FSET?	RAD-DOOR-WEST,OPENBIT \?CCL8
	PRINT	BOTH-DOORS
	CRLF	
	RTRUE	
?CCL8:	FSET	RAD-DOOR-EAST,OPENBIT
	PRINT	DOOR-OPENS
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	RAD-DOOR-EAST,OPENBIT \?CCL13
	FCLEAR	RAD-DOOR-EAST,OPENBIT
	PRINT	DOOR-CLOSES
	CRLF	
	RTRUE	
?CCL13:	CALL	IS-CLOSED
	RSTACK	


	.FUNCT	RAD-DOOR-WEST-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	RAD-DOOR-WEST,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	FSET?	RAD-DOOR-EAST,OPENBIT \?CCL8
	PRINT	BOTH-DOORS
	CRLF	
	RTRUE	
?CCL8:	PRINT	DOOR-OPENS
	CRLF	
	FSET	RAD-DOOR-WEST,OPENBIT
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	RAD-DOOR-WEST,OPENBIT \?CCL13
	FCLEAR	RAD-DOOR-WEST,OPENBIT
	PRINT	DOOR-CLOSES
	CRLF	
	RTRUE	
?CCL13:	CALL	IS-CLOSED
	RSTACK	


	.FUNCT	I-FLOYD-FORAY
	INC	'FORAY-COUNTER
	EQUAL?	FORAY-COUNTER,2 \?CCL3
	FSET?	BIO-DOOR-EAST,OPENBIT \?CCL6
	CRLF	
	CALL	MONSTER-DEATH
	RSTACK	
?CCL6:	CRLF	
	PRINTR	"From within the lab you hear ferocious growlings, the sounds of a skirmish, and then a high-pitched metallic scream!"
?CCL3:	EQUAL?	FORAY-COUNTER,3 \?CCL8
	FSET?	BIO-DOOR-EAST,OPENBIT \?CCL11
	CRLF	
	CALL	MONSTER-DEATH
	RSTACK	
?CCL11:	CRLF	
	PRINTR	"You hear, slightly muffled by the door, three fast knocks, followed by the distinctive sound of tearing metal."
?CCL8:	EQUAL?	FORAY-COUNTER,4 \?CCL13
	FSET?	BIO-DOOR-EAST,OPENBIT \?CCL16
	MOVE	FLOYD,HERE
	CRLF	
	PRINTR	"Floyd stumbles out of the Bio Lab, clutching the mini-booth card. The mutations rush toward the open doorway!"
?CCL16:	CRLF	
	PRINTI	"The three knocks come again, followed by a wild scream. Then, all is silence from within the Bio Lab, except for an occasional metallic crunch."
	CRLF	
	FCLEAR	FLOYD,RLANDBIT
	CALL	INT,I-FLOYD-FORAY
	PUT	STACK,0,0
	RTRUE	
?CCL13:	EQUAL?	FORAY-COUNTER,5 \FALSE
	FSET?	BIO-DOOR-EAST,OPENBIT \?CCL21
	CRLF	
	CALL	MONSTER-DEATH
	RSTACK	
?CCL21:	REMOVE	FLOYD
	FCLEAR	FLOYD,RLANDBIT
	CALL	INT,I-FLOYD
	PUT	STACK,0,0
	FSET	FLOYD,INVISIBLE
	MOVE	DEAD-FLOYD,HERE
	MOVE	MINI-CARD,BIO-LOCK-EAST
	FSET	MINI-CARD,TOUCHBIT
	ADD	SCORE,2 >SCORE
	CRLF	
	PRINTI	"And not a moment too soon! You hear a pounding from the door as the monsters within vent their frustration at losing their prey.

Floyd staggers to the ground, dropping the mini card. He is badly torn apart, with loose wires and broken circuits everywhere. Oil flows from his lubrication system. He obviously has only moments to live.

You drop to your knees and cradle Floyd's head in your lap. Floyd looks up at his friend with half-open eyes. ""Floyd did it ... got card. Floyd a good friend, huh?"" Quietly, you sing Floyd's favorite song, the Ballad of the Starcrossed Miner:

O, they ruled the solar system
Near ten thousand years before
In their single starcrossed scout ships
Mining ast'roids, spinning lore.

Then one true courageous miner
Spied a spaceship from the stars
Boarded he that alien liner
Out beyond the orb of Mars.

Yes, that ship was filled with danger
Mighty monsters barred his way
Yet he solved the alien myst'ries
Mining quite a lode that day.

O, they ruled the solar system
Near ten thousand years before
'Til one brave advent'rous spirit
Brought that mighty ship to shore.

As you finish the last verse, Floyd smiles with contentment, and then his eyes close as his head rolls to one side. You sit in silence for a moment, in memory of a brave friend who gave his life so that you might live."
	CRLF	
	FCLEAR	FLOYD,RLANDBIT
	FCLEAR	MINI-CARD,NDESCBIT
	CALL	INT,I-FLOYD-FORAY
	PUT	STACK,0,0
	RTRUE	


	.FUNCT	MONSTER-DEATH
	CALL	JIGS-UP,STR?269
	RSTACK	


	.FUNCT	BIO-LAB-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This is a huge laboratory filled with many biological experiments. The lighting is "
	ZERO?	LAB-LIGHTS-ON /?CCL6
	PRINTI	"bright."
	JUMP	?CND4
?CCL6:	PRINTI	"dim, and a faint blue glow comes from a gaping crack in the northern wall."
?CND4:	PRINTR	" Some of the experiments seem to be out of control..."
?CCL3:	EQUAL?	RARG,M-END \FALSE
	CALL	QUEUE,I-CHASE-SCENE,-1
	PUT	STACK,0,1
	ZERO?	LAB-FLOODED /?CCL11
	PRINTI	"The air is filled with mist, which is affecting the mutants. They appear to be stunned and confused, but are slowly recovering."
	CRLF	
	FSET?	GAS-MASK,WORNBIT /FALSE
	CALL	JIGS-UP,STR?270
	RSTACK	
?CCL11:	CALL	JIGS-UP,STR?271
	RSTACK	


	.FUNCT	I-CHASE-SCENE
	IN?	RAT-ANT,HERE \?CCL3
	ZERO?	LAB-FLOODED \?CCL3
	CALL	JIGS-UP,STR?272
	JUMP	?CND1
?CCL3:	ZERO?	LAB-FLOODED \?CND1
	EQUAL?	HERE,BIO-LOCK-WEST \?CCL9
	ZERO?	EXTRA-MOVE-FLAG \?CCL9
	SET	'EXTRA-MOVE-FLAG,TRUE-VALUE
	CRLF	
	PRINTI	"The monsters gallop toward you, smacking their lips."
	CRLF	
	JUMP	?CND1
?CCL9:	EQUAL?	HERE,CRYO-ELEVATOR \?CCL13
	ZERO?	CRYO-MOVE-FLAG \?CCL13
	SET	'CRYO-MOVE-FLAG,TRUE-VALUE
	CRLF	
	PRINTI	"The monsters are storming straight toward the elevator door!"
	CRLF	
	JUMP	?CND1
?CCL13:	EQUAL?	HERE,SECOND-TO-LAST-ROOM \?CCL17
	EQUAL?	PRSA,V?WALK \?CCL17
	CALL	JIGS-UP,STR?273
	JUMP	?CND1
?CCL17:	EQUAL?	HERE,CRYO-ELEVATOR \?CND20
	CRLF	
	CALL	MONSTER-DEATH
?CND20:	MOVE	RAT-ANT,HERE
	MOVE	TRIFFID,HERE
	MOVE	TROLL,HERE
	MOVE	GRUE,HERE
	CRLF	
	PRINTI	"The mutants "
	EQUAL?	HERE,BIO-LOCK-WEST \?CCL24
	PRINTI	"are almost upon you now!"
	CRLF	
	JUMP	?CND1
?CCL24:	PRINTI	"burst into the room right on your heels! "
	CALL	PICK-ONE,MONSTER-ENTRANCES
	PRINT	STACK
	CRLF	
?CND1:	SET	'SECOND-TO-LAST-ROOM,LAST-CHASE-ROOM
	SET	'LAST-CHASE-ROOM,HERE
	RETURN	LAST-CHASE-ROOM


	.FUNCT	RADIATION-LAB-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	FSET?	RADIATION-LAB,TOUCHBIT /FALSE
	CALL	QUEUE,I-NUKED-BLUE,50
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	I-NUKED-BLUE
	CALL	QUEUE,I-NUKED-BLUE,-1
	PUT	STACK,0,1
	INC	'NUKED-COUNTER
	EQUAL?	NUKED-COUNTER,1 \?CCL3
	CRLF	
	PRINTR	"You suddenly feel sick and dizzy."
?CCL3:	EQUAL?	NUKED-COUNTER,2 \?CCL5
	CRLF	
	PRINTI	"You feel incredibly nauseous and begin vomiting. Also, all your hair has fallen out."
	IN?	FLOYD,HERE \?CND6
	PRINTR	" Floyd points at you and laughs hysterically. ""You look funny with no hair,"" he gasps."
?CND6:	CRLF	
	RTRUE	
?CCL5:	EQUAL?	NUKED-COUNTER,3 \FALSE
	CALL	JIGS-UP,STR?279
	RSTACK	


	.FUNCT	LAMP-F
	EQUAL?	PRSA,V?LAMP-ON \?CCL3
	FSET?	LAMP,ONBIT \?CCL6
	PRINTR	"It is on."
?CCL6:	FSET	LAMP,ONBIT
	FSET	LAMP,TOUCHBIT
	PRINTR	"The lamp is now producing a bright light."
?CCL3:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	FSET?	LAMP,ONBIT \?CCL11
	FCLEAR	LAMP,ONBIT
	PRINTR	"The lamp goes dark."
?CCL11:	PRINTR	"It isn't on."


	.FUNCT	LAB-OFFICE-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This is the office for storing files on Bio Lab experiments. A large and messy desk is surrounded by locked files. A small booth lies to the south. "
	FSET?	OFFICE-DOOR,OPENBIT \?CCL6
	PRINTI	"An open"
	JUMP	?CND4
?CCL6:	PRINTI	"A closed"
?CND4:	PRINTR	" door to the west is labelled ""Biioo Lab."" You realize with shock and horror that the only way out is through the mutant-infested Bio Lab.

On the wall are three buttons: a white button labelled ""Lab Liits On"", a black button labelled ""Lab Liits Of"", and a red button labelled ""Eemurjensee Sistum."""
?CCL3:	EQUAL?	RARG,M-END \FALSE
	FSET?	OFFICE-DOOR,OPENBIT \FALSE
	ZERO?	LAB-FLOODED /?CCL13
	PRINTR	"Through the open doorway you can see the Bio Lab. It seems to be filled with a light mist. Horrifying biological nightmares stagger about making choking noises."
?CCL13:	CALL	JIGS-UP,STR?283
	RSTACK	


	.FUNCT	LAB-DESK-F
	EQUAL?	PRSA,V?SEARCH,V?EXAMINE \?CCL3
	FSET?	LAB-DESK,TOUCHBIT /?CCL3
	MOVE	MEMO,ADVENTURER
	FSET	LAB-DESK,TOUCHBIT
	PRINTI	"After inspecting the various papers on the desk, you find only one item of interest, a memo of some sort. The desk itself is "
	FSET?	LAB-DESK,OPENBIT \?CCL8
	PRINTI	"open"
	JUMP	?CND6
?CCL8:	PRINTI	"closed, but it doesn't look locked"
?CND6:	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?OPEN \FALSE
	IN?	GAS-MASK,LAB-DESK \FALSE
	CALL	THIS-IS-IT,GAS-MASK
	RFALSE	


	.FUNCT	LIGHT-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	ZERO?	LAB-LIGHTS-ON /?CCL6
	PRINTR	"Nothing happens."
?CCL6:	SET	'LAB-LIGHTS-ON,TRUE-VALUE
	PRINT	FAINT-SOUND
	CRLF	
	RTRUE	


	.FUNCT	DARK-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	ZERO?	LAB-LIGHTS-ON /?CCL6
	SET	'LAB-LIGHTS-ON,FALSE-VALUE
	PRINT	FAINT-SOUND
	CRLF	
	RTRUE	
?CCL6:	PRINTR	"Nothing happens."


	.FUNCT	FUNGICIDE-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	SET	'LAB-FLOODED,TRUE-VALUE
	CALL	QUEUE,I-UNFLOOD,50
	PUT	STACK,0,1
	PRINTR	"You hear a hissing from beyond the door to the west."


	.FUNCT	I-UNFLOOD
	SET	'LAB-FLOODED,FALSE-VALUE
	EQUAL?	HERE,BIO-LAB \?CCL3
	CRLF	
	PRINTR	"The last traces of mist in the air vanish. The mutants, recovering quickly, notice you and begin salivating."
?CCL3:	EQUAL?	HERE,LAB-OFFICE \FALSE
	FSET?	OFFICE-DOOR,OPENBIT \FALSE
	CRLF	
	PRINTR	"The mist in the Bio Lab clears. The mutants recover and rush toward the door!"


	.FUNCT	I-TURNOFF-MINI
	SET	'MINI-ACTIVATED,FALSE-VALUE
	EQUAL?	HERE,MINI-BOOTH \FALSE
	CRLF	
	PRINTR	"A recorded voice says ""Miniaturization booth de-activated."""


	.FUNCT	STATION-384-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	ZERO?	BEEN-HERE /FALSE
	SET	'BEEN-HERE,FALSE-VALUE
	ZERO?	COMPUTER-FIXED /?CCL9
	PRINTI	"A voice seems to whisper in your ear ""Main Miniaturization and Teleportation Booth has malfunctioned...switching to Auxiliary Booth..."" "
	CALL	QUEUE,I-ANNOUNCEMENT,130
	PUT	STACK,0,1
	PRINT	FAMILIAR-WRENCHING
	CRLF	
	CALL	GOTO,AUXILIARY-BOOTH
	RETURN	2
?CCL9:	PRINT	FAMILIAR-WRENCHING
	CRLF	
	CALL	GOTO,MINI-BOOTH,FALSE-VALUE
	RSTACK	


	.FUNCT	I-ANNOUNCEMENT
	CRLF	
	PRINTR	"A recorded announcement blares from the public address system. ""Revival procedure beginning. Cryo-chamber access from Project Control Office now open."""


	.FUNCT	MIDDLE-OF-STRIP-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	ZERO?	COMPUTER-FIXED /FALSE
	ZERO?	NO-MICROBE /FALSE
	ZERO?	MICROBE-DISPATCHED \FALSE
	MOVE	MICROBE,HERE
	CALL	QUEUE,I-MICROBE,-1
	PUT	STACK,0,1
	SET	'NO-MICROBE,FALSE-VALUE
	PRINTI	"Suddenly, with a loud plop, a giant elephant-sized monster lands on the strip just in front of you. It is amorphously shaped, its skin a slimy translucent red membrane. While most of your brain screams with panic about the disgusting monster that now blocks your exit, some small section in the back of your mind calmly realizes that this is merely some tiny microbe which has somehow violated the sterile environment of the computer interior.

As you stand frozen with fear, the microbe slithers toward you, extending slimy pseudopods thick with waving cilia. It looks pretty hungry, and seems intent on having you for lunch."
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	STRIP-NEAR-RELAY-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"North of here, the filament ends at a huge featureless wall, presumably the side of some micro-component. "
	IN?	RELAY,HERE \?CCL6
	PRINTR	"To the east is a vacuu-sealed micro-relay, sealed in transparent red plastic. You could probably see into the micro-relay."
?CCL6:	PRINTR	"To the east are the shattered remains of some large object."
?CCL3:	EQUAL?	RARG,M-ENTER \FALSE
	ZERO?	NO-MICROBE \FALSE
	MOVE	MICROBE,HERE
	SET	'MICROBE-COUNTER,0
	PRINTR	"The microbe, writhing angrily, follows you northward."


	.FUNCT	RELAY-EXIT-F
	IN?	RELAY,HERE \?CCL3
	PRINTI	"The relay is sealed. Although you cannot enter it, you could look into it."
	CRLF	
	RFALSE	
?CCL3:	PRINTI	"You would slice yourself to ribbons on the shattered relay."
	CRLF	
	RFALSE	


	.FUNCT	RELAY-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTI	"This is a vacuum-sealed micro-relay, encased in red translucent plastic."
	ZERO?	COMPUTER-FIXED \?CND4
	PRINTR	" Within, you can see that some sort of speck or impurity has wedged itself into the contact point of the relay, preventing it from closing. The speck, presumably of microscopic size, resembles a blue boulder to you in your current size."
?CND4:	CRLF	
	RTRUE	


	.FUNCT	LASER-DIAL-F
	EQUAL?	PRSA,V?SET \?CCL3
	EQUAL?	PRSI,INTNUM \?CCL3
	FSET?	LASER-DIAL,MUNGEDBIT \?CCL8
	PRINTR	"The laser dial seems to have become damaged and will not turn."
?CCL8:	EQUAL?	P-NUMBER,LASER-SETTING \?CCL10
	PRINTR	"That's where it's set now!"
?CCL10:	GRTR?	P-NUMBER,6 /?CTR11
	ZERO?	P-NUMBER \?CCL12
?CTR11:	PRINTR	"The dial can only be set from 1 to 6."
?CCL12:	SET	'LASER-SETTING,P-NUMBER
	PRINTI	"The dial is now set to "
	PRINTN	P-NUMBER
	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The dial is currently set to "
	PRINTN	LASER-SETTING
	PRINTR	"."


	.FUNCT	ZAP-COUNT
	IN?	OLD-BATTERY,LASER \?CCL3
	GRTR?	OLD-SHOTS,0 \TRUE
	DEC	'OLD-SHOTS
	RFALSE	
?CCL3:	IN?	NEW-BATTERY,LASER \TRUE
	GRTR?	NEW-SHOTS,0 \TRUE
	DEC	'NEW-SHOTS
	RFALSE	


	.FUNCT	LASER-F,RARG=0
	EQUAL?	PRSA,V?SET \?CCL3
	EQUAL?	PRSI,INTNUM \?CCL3
	CALL	PERFORM,V?SET,LASER-DIAL,PRSI
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINTI	"The laser, though portable, is still fairly heavy. It has a long, slender barrel and a dial with six settings, labelled ""1"" through ""6."" This dial is currently on setting "
	PRINTN	LASER-SETTING
	PRINTI	". There is a depression on the top of the laser which "
	IN?	OLD-BATTERY,LASER \?CCL10
	PRINTI	"contains an "
	PRINTD	OLD-BATTERY
	JUMP	?CND8
?CCL10:	IN?	NEW-BATTERY,LASER \?CCL12
	PRINTI	"contains a "
	PRINTD	NEW-BATTERY
	JUMP	?CND8
?CCL12:	PRINTI	"is empty"
?CND8:	PRINTR	"."
?CCL7:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL14
	PRINTR	"There doesn't seem to be any way to do that to this laser."
?CCL14:	EQUAL?	PRSA,V?PUT \?CCL16
	EQUAL?	PRSO,OLD-BATTERY \?CCL19
	IN?	NEW-BATTERY,LASER \?CCL22
	CALL	ALREADY-BATTERY
	RSTACK	
?CCL22:	MOVE	OLD-BATTERY,LASER
	CALL	BATTERY-NOW
	RSTACK	
?CCL19:	EQUAL?	PRSO,NEW-BATTERY \?CCL24
	IN?	OLD-BATTERY,LASER \?CCL27
	CALL	ALREADY-BATTERY
	RSTACK	
?CCL27:	MOVE	NEW-BATTERY,LASER
	CALL	BATTERY-NOW
	RSTACK	
?CCL24:	EQUAL?	LASER,PRSO /FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" doesn't fit the depression."
?CCL16:	EQUAL?	PRSA,V?ZAP \?CCL31
	IN?	LASER,ADVENTURER /?CND32
	CALL	NOT-HOLDING
	RTRUE	
?CND32:	ZERO?	LASER-SCORE-FLAG \?CND34
	SET	'LASER-SCORE-FLAG,TRUE-VALUE
	ADD	SCORE,2 >SCORE
?CND34:	EQUAL?	PRSI,LASER /?CTR37
	EQUAL?	PRSI,LASER-DIAL /?CTR37
	EQUAL?	PRSI,OLD-BATTERY \?PRD42
	IN?	OLD-BATTERY,LASER /?CTR37
?PRD42:	EQUAL?	PRSI,NEW-BATTERY \?CCL38
	IN?	NEW-BATTERY,LASER \?CCL38
?CTR37:	PRINTR	"Sorry, the laser doesn't have a rubber barrel."
?CCL38:	CALL	ZAP-COUNT
	ZERO?	STACK /?CCL48
	PRINTR	"Click."
?CCL48:	FSET?	LASER,MUNGEDBIT \?CCL50
	PRINTR	"The laser sparks a few times, whines, and then stops."
?CCL50:	CALL	QUEUE,I-WARMTH,-1
	PUT	STACK,0,1
	SET	'LASER-JUST-SHOT,TRUE-VALUE
	EQUAL?	PRSI,SPECK \?CCL53
	CALL	SHOOT-SPECK
	RTRUE	
?CCL53:	EQUAL?	PRSI,MICROBE \?CCL55
	CALL	SHOOT-MICROBE
	RTRUE	
?CCL55:	EQUAL?	PRSI,ME,HANDS,ADVENTURER \?CCL57
	PRINTR	"Ouch! You managed to burn yourself nicely."
?CCL57:	PRINTI	"The laser emits a narrow "
	CALL	BEAM-COLOR
	PRINTI	" beam of light"
	ZERO?	PRSI /?CCL60
	EQUAL?	PRSI,TOWEL,BROCHURE,COMBINATION-PAPER /?CTR62
	EQUAL?	PRSI,PRINT-OUT,LAB-UNIFORM,PATROL-UNIFORM /?CTR62
	EQUAL?	PRSI,ID-CARD,KITCHEN-CARD,MINI-CARD /?CTR62
	EQUAL?	PRSI,TELEPORTATION-CARD,SHUTTLE-CARD,UPPER-ELEVATOR-CARD /?CTR62
	EQUAL?	PRSI,LOWER-ELEVATOR-CARD \?CCL63
?CTR62:	REMOVE	PRSI
	EQUAL?	PRSI,SPOUT-PLACED \?CND69
	SET	'SPOUT-PLACED,GROUND
?CND69:	PRINTI	" which strikes the "
	PRINTD	PRSI
	PRINTI	". The "
	PRINTD	PRSI
	PRINTR	" bursts into flame, blinding you momentarily, and is quickly consumed."
?CCL63:	EQUAL?	PRSI,FLOYD \?CCL72
	FSET?	FLOYD,RLANDBIT \?CCL72
	PRINTR	" which strikes Floyd. ""Yow!"" yells Floyd. He jumps to the other end of the room and eyes you warily."
?CCL72:	EQUAL?	PRSI,PSEUDO-OBJECT \?CCL76
	EQUAL?	HERE,PROJCON-OFFICE \?CCL76
	PRINTI	" which strikes the "
	PRINTD	PRSI
	PRINTR	". However, this doesn't seem to affect it."
?CCL76:	PRINTI	" which strikes the "
	PRINTD	PRSI
	PRINTI	". The "
	PRINTD	PRSI
	PRINTR	" grows a bit warm, but nothing else happens."
?CCL60:	PRINTR	"."
?CCL31:	EQUAL?	PRSA,V?DROP \FALSE
	CALL	INT,I-WARMTH
	PUT	STACK,0,0
	IN?	MICROBE,HERE \FALSE
	GRTR?	WARMTH-FLAG,7 \FALSE
	REMOVE	LASER
	PRINTR	"The microbe rushes to envelop the laser. You hear a faint burp as the monster begins to look around for other morsels..."


	.FUNCT	ALREADY-BATTERY
	PRINTR	"There's already a battery there."


	.FUNCT	BATTERY-NOW
	PRINTR	"The battery is now resting in the depression, attached to the laser."


	.FUNCT	I-WARMTH
	ZERO?	LASER-JUST-SHOT /?CCL3
	SET	'LASER-JUST-SHOT,FALSE-VALUE
	INC	'WARMTH-FLAG
	EQUAL?	WARMTH-FLAG,3 \?CCL6
	CALL	LASER-FEELS,STR?298
	RSTACK	
?CCL6:	EQUAL?	WARMTH-FLAG,6 \?CCL8
	CALL	LASER-FEELS,STR?299
	RSTACK	
?CCL8:	EQUAL?	WARMTH-FLAG,9 \?CCL10
	CALL	LASER-FEELS,STR?300
	RSTACK	
?CCL10:	EQUAL?	WARMTH-FLAG,12 \FALSE
	CALL	LASER-FEELS,STR?301
	RSTACK	
?CCL3:	ZERO?	WARMTH-FLAG \?CCL15
	CALL	INT,I-WARMTH
	PUT	STACK,0,0
	RTRUE	
?CCL15:	DEC	'WARMTH-FLAG
	EQUAL?	WARMTH-FLAG,12 \?CCL18
	CALL	LASER-COOLS,STR?301
	RSTACK	
?CCL18:	EQUAL?	WARMTH-FLAG,9 \?CCL20
	CALL	LASER-COOLS,STR?302
	RSTACK	
?CCL20:	EQUAL?	WARMTH-FLAG,6 \?CCL22
	CALL	LASER-COOLS,STR?303
	RSTACK	
?CCL22:	EQUAL?	WARMTH-FLAG,3 \FALSE
	CALL	LASER-COOLS,STR?304
	RSTACK	


	.FUNCT	LASER-FEELS,STRING
	CRLF	
	PRINTI	"The laser feels "
	PRINT	STRING
	PRINTR	", but that doesn't seem to affect its performance at all."


	.FUNCT	LASER-COOLS,STRING
	CRLF	
	PRINTI	"The laser has cooled, but it still feels "
	PRINT	STRING
	PRINTR	"."


	.FUNCT	BEAM-COLOR
	EQUAL?	LASER-SETTING,1 \?CCL3
	PRINTI	"red"
	RTRUE	
?CCL3:	EQUAL?	LASER-SETTING,2 \?CCL5
	PRINTI	"orange"
	RTRUE	
?CCL5:	EQUAL?	LASER-SETTING,3 \?CCL7
	PRINTI	"yellow"
	RTRUE	
?CCL7:	EQUAL?	LASER-SETTING,4 \?CCL9
	PRINTI	"green"
	RTRUE	
?CCL9:	EQUAL?	LASER-SETTING,5 \?CCL11
	PRINTI	"blue"
	RTRUE	
?CCL11:	EQUAL?	LASER-SETTING,6 \FALSE
	PRINTI	"violet"
	RTRUE	


	.FUNCT	SHOOT-SPECK
	EQUAL?	LASER-SETTING,1 \?CCL3
	RANDOM	100
	LESS?	MARKSMANSHIP-COUNTER,STACK /?CCL6
	ZERO?	SPECK-HIT /?CCL9
	SET	'COMPUTER-FIXED,TRUE-VALUE
	FSET	CRYO-ELEVATOR-DOOR,OPENBIT
	FCLEAR	PROJCON-OFFICE,TOUCHBIT
	FCLEAR	CRYO-ELEVATOR-DOOR,INVISIBLE
	CALL	QUEUE,I-FRY,200
	PUT	STACK,0,1
	ADD	SCORE,8 >SCORE
	REMOVE	SPECK
	PRINTR	"The beam hits the speck again! This time, it vaporizes into a fine cloud of ash. The relay slowly begins to close, and a voice whispers in your ear ""Sector 384 will activate in 200 millichrons. Proceed to exit station."""
?CCL9:	SET	'SPECK-HIT,TRUE-VALUE
	PRINTR	"The speck is hit by the beam! It sizzles a little, but isn't destroyed yet."
?CCL6:	ADD	MARKSMANSHIP-COUNTER,12 >MARKSMANSHIP-COUNTER
	CALL	PICK-ONE,BEAM-MISSES
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL3:	REMOVE	RELAY
	PRINTI	"A thin "
	CALL	BEAM-COLOR
	PRINTR	" beam shoots from the laser and slices through the red plastic covering of the relay like a hot knife through butter. Air rushes into the relay, which collapses into a heap of plastic shards."


	.FUNCT	I-FRY
	EQUAL?	HERE,MIDDLE-OF-STRIP,STRIP-NEAR-STATION,STRIP-NEAR-RELAY \FALSE
	CRLF	
	CALL	JIGS-UP,STR?308
	RSTACK	


	.FUNCT	MICROBE-F
	EQUAL?	PRSA,V?TALK,V?HELLO /?CTR2
	EQUAL?	MICROBE,WINNER \?CCL3
?CTR2:	PRINTI	"You don't seem to have bridged the vast communication gulf between yourself and the microbe."
	CRLF	
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RETURN	2
?CCL3:	EQUAL?	PRSA,V?GIVE,V?THROW \FALSE
	EQUAL?	PRSI,MICROBE \FALSE
	EQUAL?	PRSO,LASER \?CCL14
	GRTR?	WARMTH-FLAG,7 \?CCL14
	REMOVE	LASER
	CALL	INT,I-WARMTH
	PUT	STACK,0,0
	GRTR?	WARMTH-FLAG,10 \?CCL19
	CALL	INT,I-MICROBE
	PUT	STACK,0,0
	PRINTI	"The microbe gobbles up the laser and turns toward you. A moment later, it begins writhing in pain. Apparently, eating the hot laser was a bit too much for it. With a bellow of agony, it rolls off the edge of the strip. (Whew!)"
	CRLF	
	REMOVE	LASER
	REMOVE	MICROBE
	SET	'NO-MICROBE,TRUE-VALUE
	SET	'MICROBE-DISPATCHED,TRUE-VALUE
	RETURN	MICROBE-DISPATCHED
?CCL19:	PRINTR	"The microbe greedily devours the laser, and turns toward you."
?CCL14:	PRINTI	"The microbe ignores the "
	PRINTD	PRSO
	PRINTR	", but does attempt to digest your arm."


	.FUNCT	I-MICROBE
	EQUAL?	MICROBE-HIT,TRUE-VALUE \?CCL3
	CRLF	
	CALL	PICK-ONE,WINNER-ATTACKED
	PRINT	STACK
	GRTR?	WARMTH-FLAG,13 \?CCL6
	IN?	LASER,ADVENTURER \?CCL6
	CALL	JIGS-UP,STR?310
	JUMP	?CND4
?CCL6:	GRTR?	WARMTH-FLAG,7 \?CND4
	IN?	LASER,ADVENTURER \?CND4
	PRINTI	" Another pseudopod, perhaps attracted by the warmth of the laser, tries to envelop the weapon. You snatch it away from the monster's grasp."
?CND4:	CRLF	
	JUMP	?CND1
?CCL3:	EQUAL?	MICROBE-COUNTER,2 \?CCL14
	CALL	JIGS-UP,STR?311
	JUMP	?CND1
?CCL14:	INC	'MICROBE-COUNTER
	CRLF	
	CALL	PICK-ONE,MONSTER-CLOSES
	PRINT	STACK
	CRLF	
?CND1:	SET	'MICROBE-HIT,FALSE-VALUE
	RETURN	MICROBE-HIT


	.FUNCT	SHOOT-MICROBE
	PRINTI	"The laser beam strikes the microbe"
	EQUAL?	LASER-SETTING,1 \?CCL3
	PRINTR	", but passes harmlessly through its red skin."
?CCL3:	SET	'MICROBE-HIT,TRUE-VALUE
	PRINTI	". "
	CALL	PICK-ONE,MICROBE-STRIKES
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	STRIP-F
	EQUAL?	PRSA,V?THROW-OFF \FALSE
	EQUAL?	PRSO,LASER \?CCL6
	GRTR?	WARMTH-FLAG,7 \?CCL6
	CALL	INT,I-WARMTH
	PUT	STACK,0,0
	CALL	INT,I-MICROBE
	PUT	STACK,0,0
	PRINTI	"As the laser flies over the edge of the strip, the hungry microbe lunges after it. Both the laser and the microbe plummet into the void. (Whew!)"
	CRLF	
	REMOVE	LASER
	REMOVE	MICROBE
	SET	'NO-MICROBE,TRUE-VALUE
	SET	'MICROBE-DISPATCHED,TRUE-VALUE
	RETURN	MICROBE-DISPATCHED
?CCL6:	EQUAL?	PRSO,LASER \?CND9
	CALL	INT,I-WARMTH
	PUT	STACK,0,0
?CND9:	REMOVE	PRSO
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" flies over the edge of the strip and disappears into the void."


	.FUNCT	GRUE-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	IN?	GRUE,HERE /FALSE
	PRINTR	"Grues are vicious, carnivorous beasts first introduced to Earth by a visiting alien spaceship during the late 22nd century. Grues spread throughout the galaxy alongside man. Although now extinct on all civilized planets, they still exist in some backwater corners of the galaxy. Their favorite diet is Ensigns Seventh Class, but their insatiable appetite is tempered by their fear of light."

	.ENDI
