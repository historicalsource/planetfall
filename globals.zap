

	.FUNCT	GROUND-F
	EQUAL?	PRSA,V?PUT \?CCL3
	EQUAL?	PRSI,GROUND \?CCL3
	CALL	PERFORM,V?DROP,PRSO
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?BOARD,V?CLIMB-ON \?CCL7
	SET	'C-ELAPSED,28
	PRINTR	"You sit down on the floor. After a brief rest, you stand again."
?CCL7:	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,ADMIN-CORRIDOR-S \FALSE
	PRINTR	"A narrow, jagged crevice runs across the floor."


	.FUNCT	WINDOW-F
	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL3
	EQUAL?	HERE,BIO-LOCK-EAST \?CCL6
	PRINTI	"You can see a large laboratory, dimly illuminated. A blue glow comes from a crack in the northern wall of the lab. Shadowy, ominous shapes move about within the room."
	FSET?	MINI-CARD,TOUCHBIT /?CND7
	PRINTR	" On the floor, just inside the door, you can see a magnetic-striped card."
?CND7:	CRLF	
	RTRUE	
?CCL6:	EQUAL?	HERE,BIO-LAB \?CCL10
	PRINTR	"You see the Bio Lock."
?CCL10:	EQUAL?	HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST /?CTR11
	EQUAL?	HERE,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST \?CCL12
?CTR11:	PRINTI	"You see "
	CALL	DESCRIBE-VIEW
	CRLF	
	RTRUE	
?CCL12:	EQUAL?	HERE,BALCONY \?CCL16
	PRINTR	"Water. Lots and lots of water."
?CCL16:	EQUAL?	HERE,HELICOPTER \?CCL18
	PRINTR	"You see the helipad and the ocean beyond."
?CCL18:	EQUAL?	HERE,ESCAPE-POD \?CCL20
	LESS?	TRIP-COUNTER,2 \?CCL23
	PRINTR	"You can see debris from the exploding Feinstein."
?CCL23:	GRTR?	TRIP-COUNTER,8 \?CCL25
	PRINTR	"You can see a planet, hopefully a hospitable one."
?CCL25:	PRINTR	"The window has polarized to blackness."
?CCL20:	EQUAL?	HERE,LARGE-OFFICE \FALSE
	PRINTR	"You can see the dormitories and other parts of the complex in the distance. Water is visible in every direction."
?CCL3:	EQUAL?	PRSA,V?THROUGH \?CCL29
	EQUAL?	HERE,BALCONY \?CCL29
	CALL	JIGS-UP,STR?1
	RSTACK	
?CCL29:	EQUAL?	PRSA,V?OPEN \?CCL33
	PRINTR	"This window doesn't open."
?CCL33:	EQUAL?	PRSA,V?EXAMINE \?CCL35
	EQUAL?	HERE,BALCONY \?CCL35
	PRINTR	"They're shattered."
?CCL35:	EQUAL?	PRSA,V?MUNG \FALSE
	EQUAL?	HERE,BALCONY \?CCL42
	PRINTR	"They're already broken."
?CCL42:	PRINTR	"It's made of tough Zynoid plastic."


	.FUNCT	CLIFF-F
	EQUAL?	HERE,WEST-WING \?CCL3
	EQUAL?	PRSA,V?LEAP \?CCL6
	CALL	JIGS-UP,STR?2
	RSTACK	
?CCL6:	EQUAL?	PRSA,V?THROW-OFF \FALSE
	EQUAL?	PRSO,LASER \?CND9
	CALL	INT,I-WARMTH
	PUT	STACK,0,0
?CND9:	REMOVE	PRSO
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" falls into the ocean below."
?CCL3:	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \?CCL13
	CALL	DO-WALK,P?UP
	RSTACK	
?CCL13:	EQUAL?	PRSA,V?CLIMB-DOWN \FALSE
	CALL	DO-WALK,P?DOWN
	RSTACK	


	.FUNCT	OCEAN-F
	EQUAL?	PRSA,V?RUB,V?THROUGH,V?TAKE \?CCL3
	PRINTR	"You can't reach the ocean from here."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It stretches as far as you can see."


	.FUNCT	TABLES-F
	EQUAL?	PRSA,V?LOOK-UNDER \?CCL3
	EQUAL?	HERE,MESS-HALL \?CCL3
	PRINTR	"Wow!!! Under the table are three keys, a sack of food, a reactor elevator access pass, one hundred gold pieces ... Just kidding. Actually, there's nothing there."
?CCL3:	EQUAL?	PRSA,V?PUT-ON \FALSE
	EQUAL?	PRSI,TABLES \FALSE
	PRINTR	"That would accomplish nothing useful."


	.FUNCT	SHELVES-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The shelves are pretty dusty."
?CCL3:	EQUAL?	PRSA,V?PUT-ON \FALSE
	EQUAL?	PRSI,SHELVES \FALSE
	PRINTR	"That would be a waste of time."


	.FUNCT	LIGHTS-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,COMPUTER-ROOM \FALSE
	PRINTR	"The red light would seem to indicate a malfunction in the computer."


	.FUNCT	GLOBAL-DOORWAY-F
	EQUAL?	PRSA,V?THROUGH \?CCL3
	CALL	USE-DIRECTIONS
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL5
	PRINTR	"It's just an opening; you can't open or close it."
?CCL5:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"Can't see much from here. Try going there."


	.FUNCT	USE-DIRECTIONS
	PRINTR	"Use compass directions for movement."


	.FUNCT	NO-CLOSE
	PRINTR	"There's no way to close it."


	.FUNCT	CONTROLS-F
	EQUAL?	HERE,UPPER-ELEVATOR,LOWER-ELEVATOR,BOOTH-1 /?CTR2
	EQUAL?	HERE,REACTOR-ELEVATOR,BOOTH-2,BOOTH-3 \?CCL3
?CTR2:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The control panel is a simple one, as described. Just a small slot and two buttons."
?CCL3:	EQUAL?	PRSA,V?PULL,V?PUSH /?CTR9
	EQUAL?	PRSA,V?EXAMINE,V?TAKE,V?SET /?CTR9
	EQUAL?	PRSA,V?TURN,V?MOVE,V?RUB \?CCL10
?CTR9:	EQUAL?	HERE,HELICOPTER \?CCL16
	PRINTR	"The controls are covered and locked."
?CCL16:	EQUAL?	HERE,ESCAPE-POD \?CCL18
	PRINTR	"The controls are entirely automated."
?CCL18:	PRINTR	"The controls are incredibly complicated and you shouldn't even be thinking about touching them."
?CCL10:	EQUAL?	HERE,HELICOPTER \FALSE
	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	PRINTR	"You don't even have the orange key!"


	.FUNCT	GLOBAL-GAMES-F
	EQUAL?	PRSA,V?PLAY \FALSE
	IN?	FLOYD,HERE \?CCL6
	CALL	PERFORM,V?PLAY-WITH,FLOYD
	RTRUE	
?CCL6:	PRINTR	"Okay. Gee, that was fun."


	.FUNCT	HANDS-F
	EQUAL?	PRSA,V?SHAKE \FALSE
	IN?	AMBASSADOR,HERE \?CCL6
	PRINTR	"A repulsive idea."
?CCL6:	IN?	BLATHER,HERE \?CCL8
	PRINTR	"Saluting might be a better idea."
?CCL8:	IN?	FLOYD,HERE \?CCL10
	FSET?	FLOYD,RLANDBIT \?CCL10
	PRINTR	"You shake one of Floyd's grasping extensions."
?CCL10:	PRINTR	"There's no one to shake hands with."


	.FUNCT	SLEEP-F
	EQUAL?	PRSA,V?WALK-TO \FALSE
	CALL	V-SLEEP
	RSTACK	


	.FUNCT	CRETIN-F
	EQUAL?	PRSA,V?GIVE \?CCL3
	CALL	PERFORM,V?TAKE,PRSO
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?SCRUB \?CCL5
	PRINTR	"If only you'd done that before the last inspection, you wouldn't have gotten 300 demerits."
?CCL5:	EQUAL?	PRSA,V?DROP \?CCL7
	PRINTR	"Huh?"
?CCL7:	EQUAL?	PRSA,V?SMELL \?CCL9
	PRINTR	"Phew!"
?CCL9:	EQUAL?	PRSA,V?FOLLOW \?CCL11
	PRINTR	"It would be hard not to."
?CCL11:	EQUAL?	PRSA,V?EAT \?CCL13
	PRINTR	"Auto-cannibalism is not the answer."
?CCL13:	EQUAL?	PRSA,V?MUNG,V?ATTACK \?CCL15
	EQUAL?	PRSO,ME \?CCL18
	CALL	JIGS-UP,STR?3
	RSTACK	
?CCL18:	PRINTR	"What a silly idea!"
?CCL15:	EQUAL?	PRSA,V?TAKE \?CCL20
	PRINTR	"How romantic!"
?CCL20:	EQUAL?	PRSA,V?DISEMBARK \?CCL22
	PRINTR	"You'll have to do that on your own."
?CCL22:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"That's difficult unless your eyes are prehensile."


	.FUNCT	DDESC,DOOR
	FSET?	DOOR,OPENBIT \?CCL3
	PRINTI	"open"
	RTRUE	
?CCL3:	PRINTI	"closed"
	RTRUE	


	.FUNCT	ALREADY-OPEN
	PRINTR	"It's already open!"


	.FUNCT	IS-CLOSED
	PRINTR	"It is closed!"


	.FUNCT	V-THROUGH,OBJ=0,M
	ZERO?	OBJ \?CCL3
	FSET?	PRSO,VEHBIT \?CCL3
	CALL	PERFORM,V?BOARD,PRSO
	RTRUE	
?CCL3:	ZERO?	OBJ \?CCL7
	FSET?	PRSO,TAKEBIT /?CCL7
	PRINTI	"You hit your head against the "
	PRINTD	PRSO
	PRINTR	" as you attempt this feat."
?CCL7:	ZERO?	OBJ /?CCL11
	PRINTR	"You can't do that!"
?CCL11:	IN?	PRSO,ADVENTURER \?CCL13
	PRINTR	"That would involve quite a contortion!"
?CCL13:	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	FIND-IN,WHERE,WHAT,W
	FIRST?	WHERE >W /?BOGUS1
?BOGUS1:	ZERO?	W /FALSE
?PRG4:	FSET?	W,WHAT \?CCL8
	RETURN	W
?CCL8:	NEXT?	W >W /?PRG4
	RFALSE	


	.FUNCT	NOT-HERE-OBJECT-F,TBL,PRSO?=1,OBJ
	EQUAL?	PRSO,NOT-HERE-OBJECT \?CCL3
	EQUAL?	PRSI,NOT-HERE-OBJECT \?CCL3
	PRINTR	"Those things aren't here!"
?CCL3:	EQUAL?	PRSO,NOT-HERE-OBJECT \?CCL7
	SET	'TBL,P-PRSO
	JUMP	?CND1
?CCL7:	SET	'TBL,P-PRSI
	SET	'PRSO?,FALSE-VALUE
?CND1:	ZERO?	PRSO? /?CND8
	EQUAL?	PRSA,V?TYPE \?CCL12
	CALL	PERFORM,V?TYPE,FLOYD
	RTRUE	
?CCL12:	EQUAL?	PRSA,V?EXAMINE /?CCL13
	EQUAL?	WINNER,FLOYD \?CND8
	EQUAL?	PRSA,V?FIND,V?TAKE \?CND8
?CCL13:	CALL	FIND-NOT-HERE,TBL,PRSO? >OBJ
	ZERO?	OBJ /FALSE
	EQUAL?	OBJ,NOT-HERE-OBJECT \TRUE
?CND8:	EQUAL?	WINNER,ADVENTURER \?CCL25
	PRINTI	"You can't see any"
	CALL	NOT-HERE-PRINT,PRSO?
	PRINTI	" here!"
	CRLF	
	EQUAL?	PRSA,V?TELL \TRUE
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RETURN	2
?CCL25:	PRINTI	"The "
	PRINTD	WINNER
	PRINTI	" seems confused. ""I don't see any"
	CALL	NOT-HERE-PRINT,PRSO?
	PRINTR	" here!"""


	.FUNCT	FIND-NOT-HERE,TBL,PRSO?,M-F,OBJ
	CALL	MOBY-FIND,TBL >M-F
	EQUAL?	1,M-F \?CCL3
	ZERO?	PRSO? /?CCL6
	SET	'PRSO,P-MOBY-FOUND
	RFALSE	
?CCL6:	SET	'PRSI,P-MOBY-FOUND
	RFALSE	
?CCL3:	ZERO?	PRSO? \?CCL8
	PRINTI	"You wouldn't find any"
	CALL	NOT-HERE-PRINT,PRSO?
	PRINTR	" there."
?CCL8:	RETURN	NOT-HERE-OBJECT


	.FUNCT	NOT-HERE-PRINT,PRSO?,?TMP1
	ZERO?	P-OFLAG \?CTR2
	ZERO?	P-MERGED /?CCL3
?CTR2:	ZERO?	P-XADJ /?CND6
	PRINTC	32
	PRINTB	P-XADJN
?CND6:	ZERO?	P-XNAM /FALSE
	PRINTC	32
	PRINTB	P-XNAM
	RTRUE	
?CCL3:	ZERO?	PRSO? /?CCL12
	GET	P-ITBL,P-NC1 >?TMP1
	GET	P-ITBL,P-NC1L
	CALL	BUFFER-PRINT,?TMP1,STACK,FALSE-VALUE
	RSTACK	
?CCL12:	GET	P-ITBL,P-NC2 >?TMP1
	GET	P-ITBL,P-NC2L
	CALL	BUFFER-PRINT,?TMP1,STACK,FALSE-VALUE
	RSTACK	


	.FUNCT	DECK-NINE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a featureless corridor similar to every other corridor on the ship. It curves away to starboard, and a gangway leads up"
	FSET?	GANGWAY-DOOR,OPENBIT \?CCL6
	PRINTC	46
	JUMP	?CND4
?CCL6:	PRINTI	", but both of these are blocked by closed bulkheads."
?CND4:	PRINTI	" To port is the entrance to one of the ship's primary escape pods. The pod bulkhead is "
	CALL	DDESC,POD-DOOR
	PRINTR	"."


	.FUNCT	CHRONOMETER-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTI	"It is a standard wrist chronometer with a digital display. "
	CALL	TELL-TIME
	PRINTR	" The back is engraved with the message ""Good luck in the Patrol! Love, Mom and Dad."""


	.FUNCT	TELL-TIME
	PRINTI	"According to the chronometer, the current time is "
	FSET?	CHRONOMETER,MUNGEDBIT \?CCL3
	PRINTN	MUNGED-TIME
	JUMP	?CND1
?CCL3:	PRINTN	INTERNAL-MOVES
?CND1:	PRINTC	46
	RTRUE	


	.FUNCT	PATROL-UNIFORM-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It is a standard-issue one-pocket Stellar Patrol uniform, a miracle of modern technology. It will keep its owner warm in cold climates and cool in warm locales. It provides protection against mild radiation, repels all insects, absorbs sweat, promotes healthy skin tone, and on top of everything else, it is super-comfy."
	EQUAL?	TRIP-COUNTER,15 \?CND4
	PRINTR	" There are definitely worse things to find yourself wearing when stranded on a strange planet."
?CND4:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?WEAR \?CCL7
	FSET?	LAB-UNIFORM,WORNBIT \?CCL7
	PRINTR	"It won't fit over the lab uniform."
?CCL7:	EQUAL?	PRSA,V?TAKE-OFF \?CCL11
	FSET?	PATROL-UNIFORM,WORNBIT \?CCL11
	FCLEAR	PATROL-UNIFORM,WORNBIT
	PRINTI	"You have removed your Patrol uniform."
	EQUAL?	TRIP-COUNTER,15 \?CND14
	PRINTI	" You suddenly realize how warm it is. You also feel naked and vulnerable."
?CND14:	IN?	BLATHER,HERE \?CCL18
	PRINTR	" ""Removing your uniform while on duty? Five hundred demerits!"""
?CCL18:	IN?	FLOYD,HERE \?CND16
	PRINTR	" Floyd giggles. ""You look funny without any clothes on."""
?CND16:	CRLF	
	RTRUE	
?CCL11:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTI	"There's no way to open or close the pocket of the "
	PRINTD	PRSO
	PRINTR	"."


	.FUNCT	GANGWAY-F,RARG
	EQUAL?	RARG,M-END \FALSE
	RANDOM	100
	LESS?	15,STACK /FALSE
	ZERO?	BLOWUP-COUNTER \FALSE
	PRINTR	"You hear a distant bellowing ... something about an Ensign Seventh Class whose life is in danger."


	.FUNCT	I-BLATHER
	EQUAL?	HERE,DECK-EIGHT,REACTOR-LOBBY \?CCL3
	IN?	BLATHER,HERE \?CCL6
	IGRTR?	'BRIGS-UP,3 \?CCL9
	CRLF	
	PRINTI	"Blather loses his last vestige of patience and drags you to the Feinstein's brig. He throws you in, and the door clangs shut behind you."
	CRLF	
	CRLF	
	CALL	GOTO,BRIG
	CALL	ROB,ADVENTURER,CRAG
	MOVE	PADLOCK,HERE
	FCLEAR	PADLOCK,TAKEBIT
	RTRUE	
?CCL9:	CRLF	
	PRINTR	"""I said to return to your post, Ensign Seventh Class!"" bellows Blather, turning a deepening shade of crimson."
?CCL6:	ZERO?	BLOWUP-COUNTER \FALSE
	MOVE	BLATHER,HERE
	CALL	THIS-IS-IT,BLATHER
	CRLF	
	PRINTR	"Ensign Blather, his uniform immaculate, enters and notices you are away from your post. ""Twenty demerits, Ensign Seventh Class!"" bellows Blather. ""Forty if you're not back on Deck Nine in five seconds!"" He curls his face into a hideous mask of disgust at your unbelievable negligence."
?CCL3:	EQUAL?	HERE,DECK-NINE \FALSE
	EQUAL?	BLATHER-LEAVE,3 \?CCL16
	IN?	BLATHER,HERE \?CCL16
	SET	'BLATHER-LEAVE,0
	REMOVE	BLATHER
	CRLF	
	PRINTR	"Blather, adding fifty more demerits for good measure, moves off in search of more young ensigns to terrorize."
?CCL16:	IN?	BLATHER,DECK-NINE \?CCL20
	INC	'BLATHER-LEAVE
	RFALSE	
?CCL20:	IN?	AMBASSADOR,HERE /FALSE
	ZERO?	BLOWUP-COUNTER \FALSE
	RANDOM	100
	LESS?	5,STACK /FALSE
	MOVE	BLATHER,HERE
	CALL	THIS-IS-IT,BLATHER
	CRLF	
	PRINTI	"Ensign First Class Blather swaggers in. He studies your work with half-closed eyes. ""You call this polishing, Ensign Seventh Class?"" he sneers. ""We have a position for an Ensign Ninth Class in the toilet-scrubbing division, you know. Thirty demerits."
	FSET?	PATROL-UNIFORM,WORNBIT /?CND26
	PRINTI	" And another sixty for improper dress!"
?CND26:	PRINTR	""" He glares at you, his arms crossed."


	.FUNCT	BLATHER-F
	EQUAL?	PRSA,V?HELLO,V?TALK /?CTR2
	EQUAL?	BLATHER,WINNER \?CCL3
?CTR2:	PRINTI	"Blather shouts ""Speak when you're spoken to, Ensign Seventh Class!"" He breaks three pencil points in a frenzied rush to give you more demerits."
	CRLF	
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RETURN	2
?CCL3:	EQUAL?	PRSA,V?KICK,V?ATTACK \?CCL9
	CALL	JIGS-UP,STR?16
	RSTACK	
?CCL9:	EQUAL?	PRSA,V?SALUTE \?CCL11
	PRINTR	"Blather's sneer softens a bit. ""First right thing you've done today. Only five demerits."""
?CCL11:	EQUAL?	PRSA,V?THROW \?CCL13
	EQUAL?	BLATHER,PRSI \?CCL13
	MOVE	PRSO,HERE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" bounces off Blather's bulbous nose. He becomes livid, orders you to do five hundred push-ups, gives you ten thousand demerits, and assigns you five years of extra galley duty."
?CCL13:	EQUAL?	PRSA,V?EXAMINE \?CCL17
	PRINTR	"Ensign Blather is a tall, beefy officer with a tremendous, misshapen nose. His uniform is perfect in every respect, and the crease in his trousers could probably slice diamonds in half."
?CCL17:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"Blather brushes you away, muttering about suspended shore leave."


	.FUNCT	CELERY-F
	EQUAL?	PRSA,V?EAT \?CCL3
	CALL	JIGS-UP,STR?18
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"The ambassador seems perturbed by your lack of normal protocol."


	.FUNCT	I-AMBASSADOR
	GRTR?	AMBASSADOR-LEAVE,2 \?CCL3
	IN?	AMBASSADOR,HERE \?CCL3
	REMOVE	AMBASSADOR
	REMOVE	CELERY
	EQUAL?	HERE,DECK-NINE \?CND6
	CRLF	
	PRINTI	"The ambassador grunts a polite farewell, and disappears up the gangway, leaving a trail of dripping slime."
	CRLF	
?CND6:	CALL	INT,I-AMBASSADOR
	PUT	STACK,0,0
	RTRUE	
?CCL3:	IN?	AMBASSADOR,DECK-NINE \?CCL9
	INC	'AMBASSADOR-LEAVE
	EQUAL?	HERE,DECK-NINE \FALSE
	CRLF	
	PRINTI	"The ambassador "
	CALL	PICK-ONE,AMBASSADOR-QUOTES
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL9:	EQUAL?	HERE,DECK-NINE \FALSE
	IN?	AMBASSADOR,HERE /FALSE
	IN?	BLATHER,HERE /FALSE
	ZERO?	BLOWUP-COUNTER \FALSE
	RANDOM	100
	LESS?	15,STACK /FALSE
	MOVE	AMBASSADOR,HERE
	MOVE	CELERY,HERE
	CALL	THIS-IS-IT,AMBASSADOR
	MOVE	BROCHURE,ADVENTURER
	CRLF	
	PRINTR	"The alien ambassador from the planet Blow'k-bibben-Gordo ambles toward you from down the corridor. He is munching on something resembling an enormous stalk of celery, and he leaves a trail of green slime on the deck. He stops nearby, and you wince as a pool of slime begins forming beneath him on your newly-polished deck. The ambassador wheezes loudly and hands you a brochure outlining his planet's major exports."


	.FUNCT	AMBASSADOR-F
	EQUAL?	PRSA,V?HELLO,V?TALK /?CTR2
	EQUAL?	AMBASSADOR,WINNER \?CCL3
?CTR2:	PRINTI	"The ambassador taps his translator, and then touches his center knee to his left ear (the Blow'k-bibben-Gordoan equivalent of shrugging)."
	CRLF	
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RETURN	2
?CCL3:	EQUAL?	PRSA,V?ASK-FOR \?CCL9
	EQUAL?	PRSI,CELERY \?CCL9
	PRINTR	"The ambassador seems willing to let you eat some of it, but I doubt he wants to part with the entire stalk."
?CCL9:	EQUAL?	PRSA,V?KICK,V?ATTACK \?CCL13
	PRINTR	"The ambassador is startled, and emits an amazing quantity of slime which spreads across the section of the deck you just polished."
?CCL13:	EQUAL?	PRSA,V?EXAMINE \?CCL15
	PRINTR	"The ambassador has around twenty eyes, seven of which are currently open. Half of his six legs are retracted. Green slime oozes from multiple orifices in his scaly skin. He speaks through a mechanical translator slung around his neck."
?CCL15:	EQUAL?	PRSA,V?LISTEN \FALSE
	PRINTR	"The alien makes a wheezing noise as he breathes."


	.FUNCT	GLOBAL-POD-F
	EQUAL?	PRSA,V?WALK-TO,V?BOARD,V?THROUGH \?CCL3
	EQUAL?	HERE,ESCAPE-POD \?CCL6
	PRINTR	"You're already in it!"
?CCL6:	CALL	DO-WALK,P?WEST
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?DROP,V?DISEMBARK,V?EXIT \?CCL8
	EQUAL?	HERE,DECK-NINE \?CCL11
	PRINTR	"You're not in it!"
?CCL11:	CALL	DO-WALK,P?OUT
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?OPEN \FALSE
	CALL	PERFORM,V?OPEN,POD-DOOR
	RTRUE	


	.FUNCT	POD-EXIT-F
	GRTR?	BLOWUP-COUNTER,4 \?CCL3
	EQUAL?	PRSO,P?EAST \?CCL6
	PRINT	CANT-GO
	CRLF	
	RFALSE	
?CCL6:	FSET?	POD-DOOR,OPENBIT /?CCL8
	PRINTI	"The pod door is closed."
	CRLF	
	RFALSE	
?CCL8:	SET	'C-ELAPSED,30
	RETURN	UNDERWATER
?CCL3:	EQUAL?	PRSO,P?UP \?CCL11
	PRINT	CANT-GO
	CRLF	
	RFALSE	
?CCL11:	FSET?	POD-DOOR,OPENBIT /?CCL13
	PRINTI	"The pod door is closed."
	CRLF	
	RFALSE	
?CCL13:	RETURN	DECK-NINE


	.FUNCT	SAFETY-WEB-F,RARG=M-OBJECT
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	ZERO?	RARG \?CCL3
	PRINTR	"The safety webbing fills most of the pod. It could accomodate from one to, perhaps, twenty people."
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL7
	ZERO?	RARG \?CCL7
	PRINTR	"The safety web seems to be more intended for getting into than grabbing onto."
?CCL7:	EQUAL?	PRSA,V?CLIMB-ON,V?BOARD \?CCL11
	ZERO?	RARG \?CCL11
	MOVE	ADVENTURER,SAFETY-WEB
	PRINTR	"You are now safely cushioned within the web."
?CCL11:	EQUAL?	PRSA,V?TAKE,V?OPEN \?CCL15
	EQUAL?	RARG,M-BEG \?CCL15
	EQUAL?	PRSO,SAFETY-WEB \?CCL20
	PRINTR	"You're in it!"
?CCL20:	PRINTR	"You can't reach it from here."
?CCL15:	EQUAL?	PRSA,V?WALK \?CCL22
	EQUAL?	RARG,M-BEG \?CCL22
	PRINTR	"You'll have to stand up, first."
?CCL22:	EQUAL?	PRSA,V?STAND /?PRD28
	EQUAL?	PRSA,V?DROP,V?DISEMBARK,V?EXIT \FALSE
?PRD28:	ZERO?	RARG \FALSE
	IN?	ADVENTURER,SAFETY-WEB \FALSE
	MOVE	ADVENTURER,HERE
	GRTR?	TRIP-COUNTER,14 \?CCL34
	CALL	INT,I-SINK-POD
	GET	STACK,C-ENABLED?
	ZERO?	STACK \?CCL34
	CALL	QUEUE,I-SINK-POD,-1
	PUT	STACK,0,1
	PRINTR	"As you stand, the pod shifts slightly and you feel it falling. A moment later, the fall stops with a shock, and you see water rising past the viewport."
?CCL34:	PRINTR	"You are standing again."


	.FUNCT	TOWEL-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"A pretty ordinary towel. Something is written in its corner."


	.FUNCT	FOOD-KIT-F
	EQUAL?	PRSA,V?EMPTY \FALSE
	FSET?	FOOD-KIT,OPENBIT /?CCL6
	PRINTR	"The kit is closed!"
?CCL6:	FIRST?	PRSO \FALSE
	PRINTR	"The goo, being gooey, sticks to the inside of the kit. You would probably have to shake the kit to get the goo out."


	.FUNCT	GOO-F
	EQUAL?	PRSA,V?EAT \?CCL3
	ZERO?	HUNGER-LEVEL \?CCL6
	PRINT	NOT-HUNGRY
	CRLF	
	RTRUE	
?CCL6:	IN?	FOOD-KIT,ADVENTURER /?CCL8
	SET	'PRSO,FOOD-KIT
	CALL	NOT-HOLDING
	CALL	THIS-IS-IT,FOOD-KIT
	RSTACK	
?CCL8:	REMOVE	PRSO
	SET	'C-ELAPSED,15
	SET	'HUNGER-LEVEL,0
	CALL	QUEUE,I-HUNGER-WARNINGS,1450
	PUT	STACK,0,1
	PRINTI	"Mmmm...that tasted just like "
	EQUAL?	PRSO,BROWN-GOO \?CCL11
	PRINTI	"delicious Nebulan fungus pudding"
	JUMP	?CND9
?CCL11:	EQUAL?	PRSO,RED-GOO \?CCL13
	PRINTI	"scrumptious cherry pie"
	JUMP	?CND9
?CCL13:	PRINTI	"yummy lima beans"
?CND9:	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?DROP,V?TAKE \FALSE
	EQUAL?	PRSA,V?DROP \?CCL18
	PRINTI	"The goo, being gooey, sticks where it is"
	JUMP	?CND16
?CCL18:	EQUAL?	PRSA,V?TAKE \?CND16
	PRINTI	"It would ooze through your fingers"
?CND16:	PRINTR	". You'll have to eat it right from the survival kit."


	.FUNCT	ESCAPE-POD-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is one of the Feinstein's primary escape pods, for use in extreme emergencies. A mass of safety webbing, large enough to hold several dozen people, fills half the pod. The controls are entirely automated. The bulkhead leading out is "
	CALL	DDESC,POD-DOOR
	PRINTR	"."


	.FUNCT	POD-DOOR-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	POD-DOOR,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	GRTR?	TRIP-COUNTER,14 \?CCL8
	FSET	POD-DOOR,OPENBIT
	PRINTR	"The bulkhead opens and cold ocean water rushes in!"
?CCL8:	GRTR?	BLOWUP-COUNTER,0 \?CCL10
	EQUAL?	HERE,DECK-NINE \?CCL13
	PRINTR	"Too late. The pod's launching procedure has already begun."
?CCL13:	PRINTR	"Opening the door now would be a phenomenally stupid idea."
?CCL10:	PRINTR	"Why open the door to the emergency escape pod if there's no emergency?"
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL15
	FSET?	POD-DOOR,OPENBIT /?CCL18
	CALL	IS-CLOSED
	RSTACK	
?CCL18:	PRINTR	"You can't close it yourself."
?CCL15:	EQUAL?	PRSA,V?THROUGH \FALSE
	EQUAL?	HERE,DECK-NINE \?CCL23
	CALL	DO-WALK,P?WEST
	RSTACK	
?CCL23:	CALL	DO-WALK,P?OUT
	RSTACK	


	.FUNCT	GANGWAY-DOOR-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	FSET?	PRSO,OPENBIT \?CCL6
	CALL	ALREADY-OPEN
	RSTACK	
?CCL6:	PRINTR	"There doesn't seem to be any way to open it."
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	PRSO,OPENBIT \?CCL11
	PRINTR	"You can't close it yourself."
?CCL11:	CALL	IS-CLOSED
	RSTACK	


	.FUNCT	I-BLOWUP-FEINSTEIN
	CALL	QUEUE,I-BLOWUP-FEINSTEIN,-1
	PUT	STACK,0,1
	INC	'BLOWUP-COUNTER
	EQUAL?	BLOWUP-COUNTER,5 \?CCL3
	EQUAL?	HERE,DECK-NINE \?CCL6
	CALL	JIGS-UP,STR?29
	RSTACK	
?CCL6:	CRLF	
	PRINTI	"Through the viewport of the pod you see the Feinstein dwindle as you head away. Bursts of light dot its hull. Suddenly, a huge explosion blows the Feinstein into tiny pieces, sending the escape pod tumbling away! "
	CRLF	
	CALL	QUEUE,I-POD-TRIP,-1
	PUT	STACK,0,1
	CALL	INT,I-BLOWUP-FEINSTEIN
	PUT	STACK,0,0
	IN?	ADVENTURER,SAFETY-WEB /?CCL9
	RANDOM	100
	LESS?	20,STACK /?CCL9
	CALL	JIGS-UP,STR?30
	RSTACK	
?CCL9:	IN?	ADVENTURER,SAFETY-WEB /FALSE
	CRLF	
	PRINTR	"You are thrown against the bulkhead, bruising a few limbs. The safety webbing might have offered a bit more protection."
?CCL3:	EQUAL?	BLOWUP-COUNTER,4 \?CCL15
	CALL	INT,I-BLATHER
	PUT	STACK,0,0
	CALL	INT,I-AMBASSADOR
	PUT	STACK,0,0
	EQUAL?	HERE,DECK-NINE \?CCL18
	CRLF	
	PRINTR	"Explosions continue to rock the ship."
?CCL18:	CRLF	
	PRINTR	"You feel the pod begin to slide down its ejection tube as explosions shake the mother ship."
?CCL15:	EQUAL?	BLOWUP-COUNTER,3 \?CCL20
	FCLEAR	POD-DOOR,OPENBIT
	EQUAL?	HERE,DECK-NINE \?CCL23
	CRLF	
	PRINTR	"More powerful explosions buffet the ship. The lights flicker madly, and the escape-pod bulkhead clangs shut."
?CCL23:	EQUAL?	HERE,ESCAPE-POD \?CCL25
	CRLF	
	PRINTR	"The pod door clangs shut as heavy explosions continue to buffet the Feinstein."
?CCL25:	CALL	JIGS-UP,STR?31
	RSTACK	
?CCL20:	EQUAL?	BLOWUP-COUNTER,2 \?CCL27
	FCLEAR	CORRIDOR-DOOR,OPENBIT
	FCLEAR	CORRIDOR-DOOR,INVISIBLE
	FCLEAR	GANGWAY-DOOR,OPENBIT
	FCLEAR	GANGWAY-DOOR,INVISIBLE
	EQUAL?	HERE,DECK-NINE \?CCL30
	CRLF	
	PRINTR	"More distant explosions! A narrow emergency bulkhead at the base of the gangway and a wider one along the corridor to starboard both crash shut!"
?CCL30:	EQUAL?	HERE,ESCAPE-POD,BRIG \?CCL32
	CRLF	
	PRINTR	"The ship shakes again. You hear, from close by, the sounds of emergency bulkheads closing."
?CCL32:	EQUAL?	HERE,GANGWAY \?CCL34
	CRLF	
	PRINTR	"Another explosion. A narrow bulkhead at the base of the gangway slams shut!"
?CCL34:	CRLF	
	PRINTI	"You are deafened by more explosions and by the sound of emergency bulkheads slamming closed. "
	IN?	BLATHER,HERE \?CCL37
	PRINTI	"Blather, foaming slightly at the mouth, screams at you to swab the decks"
	JUMP	?CND35
?CCL37:	MOVE	BLATHER,HERE
	PRINTI	"Blather enters, looking confused, and begins ranting madly at you"
?CND35:	PRINTR	"."
?CCL27:	EQUAL?	BLOWUP-COUNTER,1 \FALSE
	SET	'BRIGS-UP,0
	FSET	POD-DOOR,OPENBIT
	CRLF	
	PRINTI	"A massive explosion rocks the ship. Echoes from the explosion resound deafeningly down the halls. "
	EQUAL?	HERE,DECK-NINE \?CCL42
	PRINTI	"The door to port slides open. "
	IN?	AMBASSADOR,HERE \?CCL45
	REMOVE	AMBASSADOR
	REMOVE	CELERY
	PRINTR	"The ambassador squawks frantically, evacuates a massive load of gooey slime, and rushes away."
?CCL45:	IN?	BLATHER,HERE \?CCL47
	REMOVE	BLATHER
	PRINTR	"Blather, confused by this non-routine occurrence, orders you to continue scrubbing the floor, and then dashes off."
?CCL47:	CRLF	
	RTRUE	
?CCL42:	EQUAL?	HERE,ESCAPE-POD,GANGWAY,BRIG \?CCL49
	CRLF	
	RTRUE	
?CCL49:	PRINTR	"Blather, looking slightly disoriented, barks at you to resume your assigned duties."


	.FUNCT	I-POD-TRIP
	INC	'TRIP-COUNTER
	EQUAL?	TRIP-COUNTER,1 \?CCL3
	CRLF	
	PRINTR	"As the escape pod tumbles away from the former location of the Feinstein, its gyroscopes whine. The pod slowly stops tumbling. Lights on the control panel blink furiously as the autopilot searches for a reasonable destination."
?CCL3:	EQUAL?	TRIP-COUNTER,2 \?CCL5
	CRLF	
	PRINTR	"The auxiliary rockets fire briefly, and a nearby planet swings into view through the port. It appears to be almost entirely ocean, with just a few visible islands and an unusually small polar ice cap. A moment later, the system's sun swings into view, and the viewport polarizes into a featureless black rectangle."
?CCL5:	EQUAL?	TRIP-COUNTER,3 \?CCL7
	CRLF	
	PRINTR	"The main thrusters fire a long, gentle burst. A monotonic voice issues from the control panel. ""Approaching planet...human-habitable."""
?CCL7:	EQUAL?	TRIP-COUNTER,7 \?CCL9
	CRLF	
	PRINTR	"The pod is buffeted as it enters the planet's atmosphere."
?CCL9:	EQUAL?	TRIP-COUNTER,8 \?CCL11
	CRLF	
	PRINTR	"You feel the temperature begin to rise, and the pod's climate control system roars as it labors to compensate."
?CCL11:	EQUAL?	TRIP-COUNTER,9 \?CCL13
	CRLF	
	PRINTR	"The viewport suddenly becomes transparent again, giving you a view of endless ocean below. The lights on the control panel flash madly as the pod's computer searches for a suitable landing site. The thrusters fire long and hard, slowing the pod's descent."
?CCL13:	EQUAL?	TRIP-COUNTER,10 \?CCL15
	CRLF	
	PRINTR	"The pod is now approaching the closer of a pair of islands. It appears to be surrounded by sheer cliffs rising from the water, and is topped by a wide plateau. The plateau seems to be covered by a sprawling complex of buildings."
?CCL15:	EQUAL?	TRIP-COUNTER,11 \FALSE
	IN?	ADVENTURER,SAFETY-WEB \?CCL20
	MOVE	FOOD-KIT,HERE
	MOVE	TOWEL,HERE
	CRLF	
	PRINTI	"The pod lands with a thud. Through the viewport you can see a rocky cleft and some water below. The pod rocks gently back and forth as if it was precariously balanced. A previously unseen panel slides open, revealing some emergency provisions, including a survival kit and a towel."
	CRLF	
	SET	'TRIP-COUNTER,15
	CALL	INT,I-POD-TRIP
	PUT	STACK,0,0
	RTRUE	
?CCL20:	CALL	JIGS-UP,STR?32
	RSTACK	


	.FUNCT	I-SINK-POD
	INC	'SINK-COUNTER
	EQUAL?	SINK-COUNTER,3 \?CCL3
	EQUAL?	HERE,ESCAPE-POD \?CCL3
	CRLF	
	PRINTR	"The pod is now completely submerged, and you feel it smash against underwater rocks. Bubbles streaming upward past the window indicate that the pod is continuing to sink."
?CCL3:	EQUAL?	SINK-COUNTER,4 \?CCL7
	EQUAL?	HERE,ESCAPE-POD \?CCL7
	FSET?	POD-DOOR,OPENBIT /?CCL7
	CRLF	
	PRINTR	"The pod creaks ominously from the increasing pressure."
?CCL7:	EQUAL?	SINK-COUNTER,5 \FALSE
	EQUAL?	HERE,ESCAPE-POD \FALSE
	FSET?	POD-DOOR,OPENBIT \?CCL17
	CALL	JIGS-UP,STR?33
	RSTACK	
?CCL17:	CALL	JIGS-UP,STR?34
	RSTACK	


	.FUNCT	SLOT-F
	EQUAL?	PRSA,V?PUT \?CCL3
	EQUAL?	SLOT,PRSI \?CCL3
	PRINTR	"The slot is shallow, so you can't put anything in it. It may be possible to slide something through the slot, though."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINTR	"The slot is about ten centimeters wide, but only about two centimeters deep. It is surrounded on its long sides by parallel ridges of metal."
?CCL7:	EQUAL?	PRSA,V?SLIDE \FALSE
	EQUAL?	SLOT,PRSI \FALSE
	MOVE	PRSO,ADVENTURER
	FSET?	PRSO,SCRAMBLEDBIT \?CCL14
	PRINTR	"A sign flashes ""Magnetik striip randumiizd...konsult Prajekt Handbuk abowt propur kaar uv awtharazaashun kardz."""
?CCL14:	EQUAL?	PRSO,KITCHEN-CARD \?CCL16
	EQUAL?	HERE,MESS-HALL \?CCL19
	FSET?	KITCHEN-DOOR,OPENBIT \?CCL22
	PRINTR	"Nothing happens."
?CCL22:	FSET	KITCHEN-DOOR,OPENBIT
	CALL	QUEUE,I-KITCHEN-DOOR-CLOSES,50
	PUT	STACK,0,1
	PRINTI	"The kitchen door quietly slides open."
	CRLF	
	CALL	FLOYD-REVEAL-CARD-F
	RTRUE	
?CCL19:	PRINT	WRONG-CARD
	CRLF	
	RTRUE	
?CCL16:	EQUAL?	PRSO,UPPER-ELEVATOR-CARD \?CCL24
	EQUAL?	HERE,UPPER-ELEVATOR \?CCL27
	SET	'UPPER-ELEVATOR-ON,TRUE-VALUE
	CALL	QUEUE,I-TURNOFF-UPPER-ELEVATOR,180
	PUT	STACK,0,1
	PRINT	ELEVATOR-ENABLED
	CRLF	
	CALL	FLOYD-REVEAL-CARD-F
	RTRUE	
?CCL27:	PRINT	WRONG-CARD
	CRLF	
	RTRUE	
?CCL24:	EQUAL?	PRSO,LOWER-ELEVATOR-CARD \?CCL29
	EQUAL?	HERE,LOWER-ELEVATOR \?CCL32
	SET	'LOWER-ELEVATOR-ON,TRUE-VALUE
	CALL	QUEUE,I-TURNOFF-LOWER-ELEVATOR,200
	PUT	STACK,0,1
	PRINT	ELEVATOR-ENABLED
	CRLF	
	RTRUE	
?CCL32:	PRINT	WRONG-CARD
	CRLF	
	RTRUE	
?CCL29:	EQUAL?	PRSO,TELEPORTATION-CARD \?CCL34
	EQUAL?	HERE,BOOTH-1,BOOTH-2,BOOTH-3 \?CCL37
	SET	'TELEPORTATION-ON,TRUE-VALUE
	CALL	QUEUE,I-TURNOFF-TELEPORTATION,30
	PUT	STACK,0,1
	PRINTR	"Nothing happens for a moment. Then a light flashes ""Redee."""
?CCL37:	PRINT	WRONG-CARD
	CRLF	
	RTRUE	
?CCL34:	EQUAL?	PRSO,SHUTTLE-CARD \?CCL39
	CALL	SHUTTLE-ACTIVATE
	RSTACK	
?CCL39:	EQUAL?	PRSO,MINI-CARD \?CCL41
	EQUAL?	HERE,MINI-BOOTH \?CCL44
	SET	'MINI-ACTIVATED,TRUE-VALUE
	CALL	QUEUE,I-TURNOFF-MINI,30
	PUT	STACK,0,1
	PRINTR	"A melodic high-pitched voice says ""Miniaturization and teleportation booth activated. Please type in damaged sector number."""
?CCL44:	PRINT	WRONG-CARD
	CRLF	
	RTRUE	
?CCL41:	EQUAL?	PRSO,ID-CARD \FALSE
	PRINT	WRONG-CARD
	CRLF	
	RTRUE	


	.FUNCT	FLOYD-REVEAL-CARD-F
	IN?	FLOYD,HERE \FALSE
	ZERO?	CARD-REVEALED \FALSE
	EQUAL?	DAY,2 \?PRD8
	LESS?	INTERNAL-MOVES,5000 \?PRD8
	RANDOM	100
	LESS?	5,STACK \?CCL3
?PRD8:	EQUAL?	DAY,2 \?PRD12
	GRTR?	INTERNAL-MOVES,4999 \?PRD12
	RANDOM	100
	LESS?	10,STACK \?CCL3
?PRD12:	EQUAL?	DAY,3 \?PRD16
	LESS?	INTERNAL-MOVES,5000 \?PRD16
	RANDOM	100
	LESS?	20,STACK \?CCL3
?PRD16:	EQUAL?	DAY,3 \?PRD20
	GRTR?	INTERNAL-MOVES,4999 \?PRD20
	RANDOM	100
	LESS?	40,STACK \?CCL3
?PRD20:	GRTR?	DAY,3 \FALSE
?CCL3:	SET	'CARD-REVEALED,TRUE-VALUE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	ZERO?	CARD-STOLEN \?CCL26
	MOVE	LOWER-ELEVATOR-CARD,FLOYD
	PRINTR	"Floyd claps his hands with excitement. ""Those cards are really neat, huh? Floyd has one for himself--see?"" He reaches behind one of his panels and retrieves a magnetic-striped card. He waves it exuberantly in the air."
?CCL26:	PRINTR	"Floyd bobs up and down with excitement. ""Those cards are really neat! Floyd has one, too."" He begins searching through his compartments, but finds nothing. He scratches his head and looks confused."


	.FUNCT	I-KITCHEN-DOOR-CLOSES
	EQUAL?	HERE,KITCHEN \?CCL3
	CALL	QUEUE,I-KITCHEN-DOOR-CLOSES,-1
	PUT	STACK,0,1
	RFALSE	
?CCL3:	FCLEAR	KITCHEN-DOOR,OPENBIT
	CALL	INT,I-KITCHEN-DOOR-CLOSES
	PUT	STACK,0,0
	EQUAL?	HERE,MESS-HALL \FALSE
	CRLF	
	PRINTR	"The kitchen door slides quietly closed."


	.FUNCT	TELEPORT,BOOTH
	EQUAL?	PRSA,V?PUSH \FALSE
	EQUAL?	TELEPORTATION-ON,TRUE-VALUE \?CCL6
	PRINTI	"You experience a strange feeling in the pit of your stomach."
	CRLF	
	IN?	FLOYD,HERE \?CND7
	PRINTI	"Floyd gives a terrified squeal, and clutches at his guidance mechanism."
	CRLF	
	SET	'FLOYD-SPOKE,TRUE-VALUE
	CALL	QUEUE,I-FLOYD,1
	PUT	STACK,0,1
?CND7:	CALL	ROB,HERE,BOOTH
	CALL	GOTO,BOOTH,FALSE-VALUE
	CALL	INT,I-TURNOFF-TELEPORTATION
	PUT	STACK,0,0
	SET	'TELEPORTATION-ON,FALSE-VALUE
	RTRUE	
?CCL6:	PRINTR	"A sign flashes ""Teleportaashun buux not aktivaatid."""


	.FUNCT	TELEPORTATION-BUTTON-1-F
	CALL	TELEPORT,BOOTH-1
	RSTACK	


	.FUNCT	TELEPORTATION-BUTTON-2-F
	CALL	TELEPORT,BOOTH-2
	RSTACK	


	.FUNCT	TELEPORTATION-BUTTON-3-F
	CALL	TELEPORT,BOOTH-3
	RSTACK	


	.FUNCT	I-TURNOFF-TELEPORTATION
	SET	'TELEPORTATION-ON,FALSE-VALUE
	EQUAL?	HERE,BOOTH-1,BOOTH-2,BOOTH-3 \FALSE
	CRLF	
	PRINTR	"The ready light goes dark."


	.FUNCT	GLOBAL-SHUTTLE-F
	EQUAL?	PRSA,V?BOARD /?CTR2
	EQUAL?	PRSA,V?WALK-TO,V?THROUGH,V?ENTER \?CCL3
?CTR2:	EQUAL?	HERE,SHUTTLE-CAR-ALFIE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST /?CTR7
	EQUAL?	HERE,SHUTTLE-CAR-BETTY,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST \?CCL8
?CTR7:	PRINTR	"You ARE in the shuttle car."
?CCL8:	PRINTR	"Use 'north' or 'south'."
?CCL3:	EQUAL?	PRSA,V?DROP,V?DISEMBARK,V?EXIT \FALSE
	EQUAL?	HERE,SHUTTLE-CAR-ALFIE \?CCL15
	CALL	DO-WALK,P?NORTH
	RSTACK	
?CCL15:	EQUAL?	HERE,SHUTTLE-CAR-BETTY \?CCL17
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?CCL17:	EQUAL?	HERE,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST /?CTR18
	EQUAL?	HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST \?CCL19
?CTR18:	PRINTR	"You can't exit the shuttle car from here."
?CCL19:	PRINTR	"You're not in the shuttle car!"


	.FUNCT	SHUTTLE-CAR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the cabin of a large transport, with seating for around 20 people plus space for freight. There are open doors at the eastern and western ends of the cabin, and a doorway leads out to a wide platform to the "
	EQUAL?	HERE,SHUTTLE-CAR-ALFIE \?CCL6
	PRINTI	"north"
	JUMP	?CND4
?CCL6:	PRINTI	"south"
?CND4:	PRINTR	"."


	.FUNCT	CONTROL-CABIN-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a small control cabin. A control panel contains a slot, a lever, and a display. The lever can be set at a central position, or it could be pushed up to a position labelled ""+"", or pulled down to a position labelled ""-"". It is currently at the "
	ZERO?	LEVER-SETTING \?CCL6
	PRINTI	"center"
	JUMP	?CND4
?CCL6:	EQUAL?	LEVER-SETTING,1 \?CCL8
	PRINTI	"upper"
	JUMP	?CND4
?CCL8:	PRINTI	"lower"
?CND4:	PRINTI	" setting. The display, a digital readout, currently reads "
	PRINTN	SHUTTLE-VELOCITY
	PRINTI	". Through the cabin window you can see "
	CALL	DESCRIBE-VIEW
	CRLF	
	RTRUE	


	.FUNCT	DESCRIBE-VIEW
	EQUAL?	HERE,ALFIE-CONTROL-WEST \?PRD5
	ZERO?	ALFIE-AT-KALAMONTEE \?CTR2
?PRD5:	EQUAL?	HERE,BETTY-CONTROL-WEST \?PRD8
	ZERO?	BETTY-AT-KALAMONTEE \?CTR2
?PRD8:	EQUAL?	HERE,ALFIE-CONTROL-EAST \?PRD11
	ZERO?	ALFIE-AT-KALAMONTEE /?CTR2
?PRD11:	EQUAL?	HERE,BETTY-CONTROL-EAST \?CCL3
	ZERO?	BETTY-AT-KALAMONTEE \?CCL3
?CTR2:	PRINTI	"a featureless concrete wall."
	RTRUE	
?CCL3:	ZERO?	SHUTTLE-MOVING /?CCL17
	EQUAL?	SHUTTLE-COUNTER,23 \?CCL17
	PRINTI	"parallel rails ending at a brightly-lit station ahead."
	RTRUE	
?CCL17:	PRINTI	"parallel rails running along the floor of a long tunnel, vanishing in the distance."
	RTRUE	


	.FUNCT	SHUTTLE-DOOR-F
	EQUAL?	PRSA,V?OPEN \FALSE
	ZERO?	SHUTTLE-MOVING /?CCL6
	PRINTR	"A recorded voice says ""Operator should remain in control cabin while shuttle car is between stations."""
?CCL6:	PRINTR	"Are you sure it isn't?"


	.FUNCT	SHUTTLE-ENTER-F
	EQUAL?	HERE,KALAMONTEE-PLATFORM \?CCL3
	EQUAL?	PRSO,P?NORTH \?CCL6
	ZERO?	BETTY-AT-KALAMONTEE /?CCL9
	RETURN	SHUTTLE-CAR-BETTY
?CCL9:	PRINT	CANT-GO
	CRLF	
	RFALSE	
?CCL6:	EQUAL?	PRSO,P?SOUTH \FALSE
	ZERO?	ALFIE-AT-KALAMONTEE /?CCL14
	RETURN	SHUTTLE-CAR-ALFIE
?CCL14:	PRINT	CANT-GO
	CRLF	
	RFALSE	
?CCL3:	EQUAL?	HERE,LAWANDA-PLATFORM \FALSE
	EQUAL?	PRSO,P?NORTH \?CCL19
	ZERO?	BETTY-AT-KALAMONTEE /?CCL22
	PRINT	CANT-GO
	CRLF	
	RFALSE	
?CCL22:	RETURN	SHUTTLE-CAR-BETTY
?CCL19:	EQUAL?	PRSO,P?SOUTH \FALSE
	ZERO?	ALFIE-AT-KALAMONTEE /?CCL27
	PRINT	CANT-GO
	CRLF	
	RFALSE	
?CCL27:	RETURN	SHUTTLE-CAR-ALFIE


	.FUNCT	SHUTTLE-EXIT-F
	EQUAL?	HERE,SHUTTLE-CAR-ALFIE \?CCL3
	ZERO?	ALFIE-AT-KALAMONTEE /?CCL6
	RETURN	KALAMONTEE-PLATFORM
?CCL6:	RETURN	LAWANDA-PLATFORM
?CCL3:	EQUAL?	HERE,SHUTTLE-CAR-BETTY \FALSE
	ZERO?	BETTY-AT-KALAMONTEE /?CCL11
	RETURN	KALAMONTEE-PLATFORM
?CCL11:	RETURN	LAWANDA-PLATFORM


	.FUNCT	SHUTTLE-ACTIVATE
	EQUAL?	HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST /?CCL3
	EQUAL?	HERE,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST /?CCL3
	PRINT	WRONG-CARD
	CRLF	
	RTRUE	
?CCL3:	ZERO?	ALFIE-BROKEN /?PRD9
	EQUAL?	HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST /?CTR6
?PRD9:	ZERO?	BETTY-BROKEN /?CCL7
	EQUAL?	HERE,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST \?CCL7
?CTR6:	PRINTR	"A garbled recording mentions that the shuttle car has undergone some damage and that the repair robot has been summoned."
?CCL7:	GRTR?	INTERNAL-MOVES,6000 \?CND1
	PRINTR	"A recorded voice explains that using the shuttle car during the evening hours requires special authorization."
?CND1:	EQUAL?	HERE,ALFIE-CONTROL-EAST \?CCL17
	ZERO?	SHUTTLE-ON /?CCL20
	PRINT	SHUTTLE-RECORDING-1
	CRLF	
	RTRUE	
?CCL20:	ZERO?	ALFIE-AT-KALAMONTEE \?CCL22
	PRINT	SHUTTLE-RECORDING-2
	CRLF	
	RTRUE	
?CCL22:	SET	'SHUTTLE-ON,TRUE-VALUE
	CALL	QUEUE,I-TURNOFF-SHUTTLE,80
	PUT	STACK,0,1
	PRINT	SHUTTLE-RECORDING-3
	CRLF	
	RTRUE	
?CCL17:	EQUAL?	HERE,ALFIE-CONTROL-WEST \?CCL24
	ZERO?	SHUTTLE-ON /?CCL27
	PRINT	SHUTTLE-RECORDING-1
	CRLF	
	RTRUE	
?CCL27:	ZERO?	ALFIE-AT-KALAMONTEE /?CCL29
	PRINT	SHUTTLE-RECORDING-2
	CRLF	
	RTRUE	
?CCL29:	SET	'SHUTTLE-ON,TRUE-VALUE
	CALL	QUEUE,I-TURNOFF-SHUTTLE,80
	PUT	STACK,0,1
	PRINT	SHUTTLE-RECORDING-3
	CRLF	
	RTRUE	
?CCL24:	EQUAL?	HERE,BETTY-CONTROL-EAST \?CCL31
	ZERO?	SHUTTLE-ON /?CCL34
	PRINT	SHUTTLE-RECORDING-1
	CRLF	
	RTRUE	
?CCL34:	ZERO?	BETTY-AT-KALAMONTEE \?CCL36
	PRINT	SHUTTLE-RECORDING-2
	CRLF	
	RTRUE	
?CCL36:	SET	'SHUTTLE-ON,TRUE-VALUE
	CALL	QUEUE,I-TURNOFF-SHUTTLE,80
	PUT	STACK,0,1
	PRINT	SHUTTLE-RECORDING-3
	CRLF	
	RTRUE	
?CCL31:	EQUAL?	HERE,BETTY-CONTROL-WEST \?CCL38
	ZERO?	SHUTTLE-ON /?CCL41
	PRINT	SHUTTLE-RECORDING-1
	CRLF	
	RTRUE	
?CCL41:	ZERO?	BETTY-AT-KALAMONTEE /?CCL43
	PRINT	SHUTTLE-RECORDING-2
	CRLF	
	RTRUE	
?CCL43:	SET	'SHUTTLE-ON,TRUE-VALUE
	CALL	QUEUE,I-TURNOFF-SHUTTLE,80
	PUT	STACK,0,1
	PRINT	SHUTTLE-RECORDING-3
	CRLF	
	RTRUE	
?CCL38:	PRINT	WRONG-CARD
	CRLF	
	RTRUE	


	.FUNCT	I-TURNOFF-SHUTTLE
	ZERO?	SHUTTLE-MOVING /?CCL3
	CALL	QUEUE,I-TURNOFF-SHUTTLE,80
	PUT	STACK,0,1
	RFALSE	
?CCL3:	SET	'SHUTTLE-ON,FALSE-VALUE
	RFALSE	


	.FUNCT	LEVER-F
	EQUAL?	PRSA,V?PUSH-UP,V?PUSH \?CCL3
	ZERO?	SHUTTLE-ON /?CCL6
	EQUAL?	LEVER-SETTING,1 \?CCL9
	PRINTR	"The lever is already in the upper position."
?CCL9:	ZERO?	LEVER-SETTING \?CCL11
	SET	'LEVER-SETTING,1
	CALL	QUEUE,I-SHUTTLE,1
	PUT	STACK,0,1
	PRINTR	"The lever is now in the upper position."
?CCL11:	SET	'LEVER-SETTING,0
	PRINTR	"The lever is now in the central position."
?CCL6:	PRINT	SHUTTLE-RECORDING-4
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?PUSH-DOWN,V?PULL \FALSE
	ZERO?	SHUTTLE-ON /?CCL16
	EQUAL?	LEVER-SETTING,1 \?CCL19
	SET	'LEVER-SETTING,0
	PRINTR	"The lever is now in the central position."
?CCL19:	ZERO?	LEVER-SETTING \?CCL21
	ZERO?	SHUTTLE-VELOCITY \?CCL24
	PRINTR	"The lever immediately pops back to the central position."
?CCL24:	SET	'LEVER-SETTING,-1
	CALL	QUEUE,I-SHUTTLE,1
	PUT	STACK,0,1
	PRINTR	"The lever is now in the lower position."
?CCL21:	PRINTR	"The lever is already in the lower position."
?CCL16:	PRINT	SHUTTLE-RECORDING-4
	CRLF	
	RTRUE	


	.FUNCT	I-SHUTTLE
	CALL	QUEUE,I-SHUTTLE,-1
	PUT	STACK,0,1
	ZERO?	SHUTTLE-MOVING \?CCL3
	SET	'SHUTTLE-MOVING,TRUE-VALUE
	FCLEAR	SHUTTLE-DOOR,OPENBIT
	FCLEAR	SHUTTLE-DOOR,INVISIBLE
	PRINTI	"The control cabin door slides shut and the shuttle car begins to move "
	EQUAL?	LEVER-SETTING,1 \FALSE
	ADD	SHUTTLE-VELOCITY,5 >SHUTTLE-VELOCITY
	PRINTR	"forward! The display changes to 5."
?CCL3:	GRTR?	SHUTTLE-VELOCITY,0 \?CND7
	INC	'SHUTTLE-COUNTER
?CND7:	EQUAL?	LEVER-SETTING,1 \?CCL11
	ADD	SHUTTLE-VELOCITY,5 >SHUTTLE-VELOCITY
	JUMP	?CND9
?CCL11:	EQUAL?	LEVER-SETTING,-1 \?CND9
	GRTR?	SHUTTLE-VELOCITY,0 \?CCL15
	SUB	SHUTTLE-VELOCITY,5 >SHUTTLE-VELOCITY
	JUMP	?CND9
?CCL15:	SET	'LEVER-SETTING,0
	PRINTI	"The shuttle car comes to a stop and the lever pops back to the central position."
	CRLF	
?CND9:	EQUAL?	SHUTTLE-COUNTER,24 \?CCL18
	CALL	DESCRIBE-SHUTTLE-ARRIVE
	RSTACK	
?CCL18:	GRTR?	SHUTTLE-VELOCITY,0 \FALSE
	CALL	DESCRIBE-SHUTTLE-TRIP
	RTRUE	


	.FUNCT	DESCRIBE-SHUTTLE-TRIP
	PRINTI	"The shuttle car continues to move. The display "
	ZERO?	LEVER-SETTING \?CCL3
	PRINTI	"still reads "
	JUMP	?CND1
?CCL3:	PRINTI	"blinks, and now reads "
?CND1:	PRINTN	SHUTTLE-VELOCITY
	PRINTC	46
	CRLF	
	EQUAL?	SHUTTLE-COUNTER,2 \?CND4
	PRINTI	"You pass a sign which says ""Limit 45."""
	CRLF	
?CND4:	EQUAL?	SHUTTLE-COUNTER,12 \?CND6
	PRINTI	"The tunnel levels out and begins to slope upward. A sign flashes by which reads ""Hafwaa Mark -- Beegin Deeseluraashun."""
	CRLF	
?CND6:	EQUAL?	SHUTTLE-COUNTER,20 \?CND8
	PRINT	SIGN-PASS
	PRINTI	"""15."""
	CRLF	
?CND8:	EQUAL?	SHUTTLE-COUNTER,21 \?CND10
	PRINT	SIGN-PASS
	PRINTI	"""10."""
	CRLF	
?CND10:	EQUAL?	SHUTTLE-COUNTER,22 \?CND12
	PRINT	SIGN-PASS
	PRINTI	"""5."""
	CRLF	
?CND12:	EQUAL?	SHUTTLE-COUNTER,23 \FALSE
	PRINTR	"The shuttle car is approaching a brightly-lit area. As you near it, you make out the concrete platforms of a shuttle station."


	.FUNCT	DESCRIBE-SHUTTLE-ARRIVE
	EQUAL?	SHUTTLE-COUNTER,24 \FALSE
	ZERO?	SHUTTLE-VELOCITY \?CCL6
	PRINTI	"The shuttle car glides into the station and comes to rest at the concrete platform. You hear the cabin doors slide open."
	CRLF	
	JUMP	?CND4
?CCL6:	LESS?	SHUTTLE-VELOCITY,20 \?CCL8
	EQUAL?	HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST \?CCL11
	SET	'ALFIE-BROKEN,TRUE-VALUE
	JUMP	?CND9
?CCL11:	SET	'BETTY-BROKEN,TRUE-VALUE
?CND9:	PRINTI	"The shuttle car rumbles through the station and smashes into the wall at the far end. You are thrown forward into the control panel. Both you and the shuttle car produce unhealthy crunching sounds as the cabin doors creak slowly open."
	CRLF	
	JUMP	?CND4
?CCL8:	CALL	JIGS-UP,STR?42
?CND4:	SET	'SHUTTLE-VELOCITY,0
	SET	'SHUTTLE-MOVING,FALSE-VALUE
	SET	'SHUTTLE-COUNTER,0
	SET	'LEVER-SETTING,0
	SET	'SHUTTLE-ON,FALSE-VALUE
	FSET	SHUTTLE-DOOR,INVISIBLE
	FSET	SHUTTLE-DOOR,OPENBIT
	CALL	INT,I-SHUTTLE
	PUT	STACK,0,0
	EQUAL?	HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST \?CCL14
	ZERO?	ALFIE-AT-KALAMONTEE /?CCL17
	SET	'ALFIE-AT-KALAMONTEE,FALSE-VALUE
	RETURN	ALFIE-AT-KALAMONTEE
?CCL17:	SET	'ALFIE-AT-KALAMONTEE,TRUE-VALUE
	RETURN	ALFIE-AT-KALAMONTEE
?CCL14:	ZERO?	BETTY-AT-KALAMONTEE /?CCL20
	SET	'BETTY-AT-KALAMONTEE,FALSE-VALUE
	RETURN	BETTY-AT-KALAMONTEE
?CCL20:	SET	'BETTY-AT-KALAMONTEE,TRUE-VALUE
	RETURN	BETTY-AT-KALAMONTEE


	.FUNCT	I-SLEEP-WARNINGS
	INC	'SLEEPY-LEVEL
	IN?	ADVENTURER,BED \?CND1
	CRLF	
	PRINTI	"You suddenly realize how tired you were and how comfortable the bed is. You should be asleep in no time."
	CRLF	
	CALL	INT,I-SLEEP-WARNINGS
	PUT	STACK,0,0
	CALL	QUEUE,I-FALL-ASLEEP,16
	PUT	STACK,0,1
	RTRUE	
?CND1:	EQUAL?	SLEEPY-LEVEL,1 \?CCL5
	CRLF	
	PRINTI	"You begin to feel weary. It might be time to think about finding a nice safe place to sleep."
	CRLF	
	CALL	QUEUE,I-SLEEP-WARNINGS,400
	PUT	STACK,0,1
	RTRUE	
?CCL5:	EQUAL?	SLEEPY-LEVEL,2 \?CCL7
	CRLF	
	PRINTI	"You're really tired now. You'd better find a place to sleep real soon."
	CRLF	
	CALL	QUEUE,I-SLEEP-WARNINGS,135
	PUT	STACK,0,1
	RTRUE	
?CCL7:	EQUAL?	SLEEPY-LEVEL,3 \?CCL9
	CRLF	
	PRINTI	"If you don't get some sleep soon you'll probably drop."
	CRLF	
	CALL	QUEUE,I-SLEEP-WARNINGS,60
	PUT	STACK,0,1
	RTRUE	
?CCL9:	EQUAL?	SLEEPY-LEVEL,4 \?CCL11
	CRLF	
	PRINTI	"You can barely keep your eyes open."
	CRLF	
	CALL	QUEUE,I-SLEEP-WARNINGS,50
	PUT	STACK,0,1
	RTRUE	
?CCL11:	EQUAL?	SLEEPY-LEVEL,5 \FALSE
	EQUAL?	HERE,BED \?CCL16
	CRLF	
	PRINTI	"You slowly sink into a deep and blissful sleep."
	CRLF	
	CALL	DREAMING
	RSTACK	
?CCL16:	EQUAL?	HERE,DORM-A,DORM-B /?CTR17
	EQUAL?	HERE,DORM-C,DORM-D \?CCL18
?CTR17:	CRLF	
	PRINTI	"You climb into one of the bunk beds and immediately fall asleep."
	CRLF	
	MOVE	ADVENTURER,BED
	CALL	DREAMING
	RSTACK	
?CCL18:	CRLF	
	PRINTI	"You can't stay awake a moment longer. You drop to the ground and fall into a deep but fitful sleep."
	CRLF	
	EQUAL?	DAY,1 \?PRD25
	EQUAL?	HERE,CRAG /?CTR22
?PRD25:	EQUAL?	DAY,3 \?PRD28
	EQUAL?	HERE,BALCONY /?CTR22
?PRD28:	EQUAL?	DAY,5 \?CCL23
	EQUAL?	HERE,WINDING-STAIR \?CCL23
?CTR22:	CALL	JIGS-UP,STR?44
	RSTACK	
?CCL23:	RANDOM	100
	LESS?	30,STACK /?CCL34
	CALL	JIGS-UP,STR?45
	RSTACK	
?CCL34:	CALL	DREAMING
	RSTACK	


	.FUNCT	BED-F,RARG=M-OBJECT
	EQUAL?	PRSA,V?WALK \?CCL3
	EQUAL?	RARG,M-BEG \?CCL3
	PRINTR	"You'll have to stand up, first."
?CCL3:	EQUAL?	PRSA,V?RUB /?PRD9
	EQUAL?	PRSA,V?CLOSE,V?OPEN,V?TAKE \?CCL7
?PRD9:	EQUAL?	RARG,M-BEG \?CCL7
	EQUAL?	PRSO,BED /?CCL7
	PRINTR	"You can't reach it from here."
?CCL7:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?WALK-TO,V?BOARD,V?THROUGH \?CCL16
	EQUAL?	HERE,INFIRMARY \?CCL19
	CALL	JIGS-UP,STR?46
	RSTACK	
?CCL19:	GRTR?	SLEEPY-LEVEL,0 \?CCL21
	MOVE	ADVENTURER,BED
	CALL	QUEUE,I-FALL-ASLEEP,16
	PUT	STACK,0,1
	CALL	INT,I-SLEEP-WARNINGS
	PUT	STACK,0,0
	PRINTR	"Ahhh...the bed is soft and comfortable. You should be asleep in short order."
?CCL21:	MOVE	ADVENTURER,BED
	PRINTR	"You are now in bed."
?CCL16:	EQUAL?	PRSA,V?DROP /?PRD25
	EQUAL?	PRSA,V?EXIT,V?STAND,V?DISEMBARK \?CCL23
?PRD25:	CALL	INT,I-FALL-ASLEEP
	GET	STACK,C-TICK
	ZERO?	STACK /?CCL23
	PRINTR	"How could you suggest such a thing when you're so tired and this bed is so comfy?"
?CCL23:	EQUAL?	PRSA,V?DROP,V?EXIT,V?LEAVE \?CCL29
	CALL	PERFORM,V?DISEMBARK,BED
	RTRUE	
?CCL29:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	BED,PRSI \FALSE
	MOVE	PRSO,HERE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTR	" bounces off the bed and lands on the floor."


	.FUNCT	I-FALL-ASLEEP
	CRLF	
	PRINTI	"You slowly sink into a deep and restful sleep."
	CRLF	
	CALL	INT,I-FALL-ASLEEP
	PUT	STACK,0,0
	CALL	DREAMING
	RSTACK	


	.FUNCT	DREAMING
	FSET?	FORK,TOUCHBIT \?CCL3
	RANDOM	100
	LESS?	13,STACK /?CCL3
	PRINTI	"You are in a busy office crowded with people. The only one you recognize is Floyd. He rushes back and forth between the desks, carrying papers and delivering coffee. He notices you, and asks how your project is coming, and whether you have time to tell him a story. You look into his deep, trusting eyes..."
	CRLF	
	JUMP	?CND1
?CCL3:	RANDOM	100
	LESS?	60,STACK /?CND1
	CRLF	
	CALL	PICK-ONE,DREAMS
	PRINT	STACK
	CRLF	
?CND1:	CALL	WAKING-UP
	RSTACK	


	.FUNCT	WAKING-UP,X,N
	INC	'DAY
	SET	'SICKNESS-WARNING-FLAG,TRUE-VALUE
	SET	'SLEEPY-LEVEL,0
	CALL	RESET-TIME
	FIRST?	ADVENTURER >X /?PRG2
?PRG2:	ZERO?	X /?REP3
	NEXT?	X >N /?BOGUS7
?BOGUS7:	FSET?	X,WORNBIT /?CND8
	MOVE	X,HERE
?CND8:	EQUAL?	X,CANTEEN \?CND10
	IN?	HIGH-PROTEIN,CANTEEN \?CND10
	FSET?	CANTEEN,OPENBIT \?CND10
	REMOVE	HIGH-PROTEIN
?CND10:	EQUAL?	X,FLASK \?CND15
	IN?	CHEMICAL-FLUID,FLASK \?CND15
	REMOVE	CHEMICAL-FLUID
?CND15:	SET	'X,N
	JUMP	?PRG2
?REP3:	PRINTI	"
***** SEPTEM "
	ADD	DAY,5
	PRINTN	STACK
	PRINTI	", 11344 *****

"
	IN?	ADVENTURER,BED /?CCL21
	PRINTI	"You wake and slowly stand up, feeling stiff from your night on the floor."
	JUMP	?CND19
?CCL21:	LESS?	SICKNESS-LEVEL,3 \?CCL23
	PRINTI	"You wake up feeling refreshed and ready to face the challenges of this mysterious world."
	JUMP	?CND19
?CCL23:	LESS?	SICKNESS-LEVEL,6 \?CCL25
	PRINTI	"You wake after sleeping restlessly. You feel weak and listless."
	JUMP	?CND19
?CCL25:	PRINTI	"You wake feeling weak and worn-out. It will be an effort just to stand up."
?CND19:	GRTR?	HUNGER-LEVEL,0 \?CCL28
	SET	'HUNGER-LEVEL,4
	CALL	QUEUE,I-HUNGER-WARNINGS,100
	PUT	STACK,0,1
	PRINTI	" You are also incredibly famished. Better get some breakfast!"
	JUMP	?CND26
?CCL28:	CALL	QUEUE,I-HUNGER-WARNINGS,400
	PUT	STACK,0,1
?CND26:	CRLF	
	FSET?	FLOYD,RLANDBIT \FALSE
	ZERO?	FLOYD-INTRODUCED /FALSE
	MOVE	FLOYD,HERE
	SET	'FLOYD-SPOKE,TRUE-VALUE
	IN?	ADVENTURER,BED \?CCL36
	PRINTR	"Floyd bounces impatiently at the foot of the bed. ""About time you woke up, you lazy bones! Let's explore around some more!"""
?CCL36:	PRINTR	"Floyd gives you a nudge with his foot and giggles. ""You sure look silly sleeping on the floor,"" he says."


	.FUNCT	RESET-TIME
	EQUAL?	DAY,2 \?CCL3
	FCLEAR	BALCONY,TOUCHBIT
	RANDOM	80
	ADD	1600,STACK >INTERNAL-MOVES
	CALL	QUEUE,I-SLEEP-WARNINGS,5800
	PUT	STACK,0,1
	RTRUE	
?CCL3:	EQUAL?	DAY,3 \?CCL5
	FCLEAR	BALCONY,TOUCHBIT
	RANDOM	80
	ADD	1750,STACK >INTERNAL-MOVES
	CALL	QUEUE,I-SLEEP-WARNINGS,5550
	PUT	STACK,0,1
	RTRUE	
?CCL5:	EQUAL?	DAY,4 \?CCL7
	FCLEAR	WINDING-STAIR,TOUCHBIT
	RANDOM	80
	ADD	1950,STACK >INTERNAL-MOVES
	CALL	QUEUE,I-SLEEP-WARNINGS,5200
	PUT	STACK,0,1
	RTRUE	
?CCL7:	EQUAL?	DAY,5 \?CCL9
	FCLEAR	WINDING-STAIR,TOUCHBIT
	RANDOM	80
	ADD	2150,STACK >INTERNAL-MOVES
	CALL	QUEUE,I-SLEEP-WARNINGS,4800
	PUT	STACK,0,1
	RTRUE	
?CCL9:	EQUAL?	DAY,6 \?CCL11
	FCLEAR	COURTYARD,TOUCHBIT
	RANDOM	80
	ADD	2450,STACK >INTERNAL-MOVES
	CALL	QUEUE,I-SLEEP-WARNINGS,4300
	PUT	STACK,0,1
	RTRUE	
?CCL11:	EQUAL?	DAY,7 \?CCL13
	FCLEAR	COURTYARD,TOUCHBIT
	RANDOM	80
	ADD	2800,STACK >INTERNAL-MOVES
	CALL	QUEUE,I-SLEEP-WARNINGS,3700
	PUT	STACK,0,1
	RTRUE	
?CCL13:	EQUAL?	DAY,8 \?CCL15
	RANDOM	80
	ADD	3200,STACK >INTERNAL-MOVES
	CALL	QUEUE,I-SLEEP-WARNINGS,3000
	PUT	STACK,0,1
	RTRUE	
?CCL15:	EQUAL?	DAY,9 \FALSE
	CALL	JIGS-UP,STR?52
	RSTACK	


	.FUNCT	I-HUNGER-WARNINGS
	INC	'HUNGER-LEVEL
	EQUAL?	HUNGER-LEVEL,1 \?CCL3
	CALL	QUEUE,I-HUNGER-WARNINGS,450
	PUT	STACK,0,1
	CRLF	
	PRINTR	"A growl from your stomach warns that you're getting pretty hungry and thirsty."
?CCL3:	EQUAL?	HUNGER-LEVEL,2 \?CCL5
	CALL	QUEUE,I-HUNGER-WARNINGS,150
	PUT	STACK,0,1
	CRLF	
	PRINTR	"You're now really ravenous and your lips are quite parched."
?CCL5:	EQUAL?	HUNGER-LEVEL,3 \?CCL7
	CALL	QUEUE,I-HUNGER-WARNINGS,100
	PUT	STACK,0,1
	CRLF	
	PRINTR	"You're starting to feel faint from lack of food and liquid."
?CCL7:	EQUAL?	HUNGER-LEVEL,4 \?CCL9
	CALL	QUEUE,I-HUNGER-WARNINGS,50
	PUT	STACK,0,1
	CRLF	
	PRINTR	"If you don't eat or drink something in a few millichrons, you'll probably pass out."
?CCL9:	EQUAL?	HUNGER-LEVEL,5 \FALSE
	CALL	JIGS-UP,STR?53
	RSTACK	


	.FUNCT	I-SICKNESS-WARNINGS
	CALL	QUEUE,I-SICKNESS-WARNINGS,700
	PUT	STACK,0,1
	ZERO?	SICKNESS-WARNING-FLAG /FALSE
	SET	'SICKNESS-WARNING-FLAG,FALSE-VALUE
	SUB	LOAD-ALLOWED,10 >LOAD-ALLOWED
	INC	'SICKNESS-LEVEL
	EQUAL?	SICKNESS-LEVEL,1 \?CCL6
	CRLF	
	PRINTR	"You notice that you feel a bit weak and slightly flushed, but you're not sure why."
?CCL6:	EQUAL?	SICKNESS-LEVEL,2 \?CCL8
	CRLF	
	PRINTR	"You notice that you feel unusually weak, and you suspect that you have a fever."
?CCL8:	EQUAL?	SICKNESS-LEVEL,3 \?CCL10
	CRLF	
	PRINTR	"You are now feeling quite under the weather, not unlike a bad flu."
?CCL10:	EQUAL?	SICKNESS-LEVEL,4 \?CCL12
	CRLF	
	PRINTR	"Your fever seems to have gotten worse, and you're developing a bad headache."
?CCL12:	EQUAL?	SICKNESS-LEVEL,5 \?CCL14
	CRLF	
	PRINTR	"Your health has deteriorated further. You feel hot and weak, and your head is throbbing."
?CCL14:	EQUAL?	SICKNESS-LEVEL,6 \?CCL16
	CRLF	
	PRINTR	"You feel very, very sick, and have almost no strength left."
?CCL16:	EQUAL?	SICKNESS-LEVEL,7 \?CCL18
	CRLF	
	PRINTR	"You feel like you're on fire, burning up from the fever. You're almost too weak to move, and your brain is reeling from the pounding headache."
?CCL18:	EQUAL?	SICKNESS-LEVEL,8 \?CCL20
	CRLF	
	PRINTR	"You're no longer sure of where you are and what you're doing. You stumble about, your pain subsiding into a dull numbness."
?CCL20:	EQUAL?	SICKNESS-LEVEL,9 \FALSE
	CALL	JIGS-UP,STR?55
	RSTACK	


	.FUNCT	TRANSLATOR-PSEUDO
	IN?	AMBASSADOR,HERE \?CCL3
	EQUAL?	PRSA,V?TAKE \?CCL6
	PRINTR	"The ambassador whimpers and slaps your wrist."
?CCL6:	EQUAL?	PRSA,V?MUNG \FALSE
	PRINTR	"Are you trying to create an interplanetary incident?"
?CCL3:	PRINTR	"What translator?"


	.FUNCT	SLIME-PSEUDO
	IN?	AMBASSADOR,HERE /?CTR2
	GRTR?	AMBASSADOR-LEAVE,0 \?CCL3
?CTR2:	EQUAL?	PRSA,V?TASTE,V?EAT \?CCL8
	CALL	LIKE-SLIME,STR?56
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?RUB,V?TAKE \?CCL10
	CALL	LIKE-SLIME,STR?57
	RSTACK	
?CCL10:	EQUAL?	PRSA,V?EXAMINE \?CCL12
	CALL	LIKE-SLIME,STR?58
	RSTACK	
?CCL12:	EQUAL?	PRSA,V?SMELL \?CCL14
	CALL	LIKE-SLIME,STR?59
	RSTACK	
?CCL14:	EQUAL?	PRSA,V?REMOVE,V?SCRUB \FALSE
	PRINTI	"Whew. You've cleaned up maybe one ten-thousandth of the slime."
	IN?	BLATHER,HERE /?CND17
	PRINTR	" If you hurry, it might be all cleaned up before Ensign Blather gets here."
?CND17:	CRLF	
	RTRUE	
?CCL3:	PRINTR	"What slime?"


	.FUNCT	LIKE-SLIME,STRING
	PRINTI	"It "
	PRINT	STRING
	PRINTR	" like slime. Aren't you glad you didn't step in it?"


	.FUNCT	GRAFFITI-PSEUDO
	EQUAL?	PRSA,V?READ \FALSE
	SET	'C-ELAPSED,28
	PRINTR	"All the graffiti seem to be about Blather. One of the least obscene items reads:

There once was a krip, name of Blather
Who told a young Ensign named Smather
""I'll make you inherit
A trotting demerit
And ship you off to those stinking fawg-infested tar-pools of Krather.""

It's not a very good limerick, is it?"


	.FUNCT	DOOR-PSEUDO
	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	PRINTR	"No way, Jose."


	.FUNCT	WALKWAY-PSEUDO
	EQUAL?	PRSA,V?LAMP-ON,V?EXAMINE \FALSE
	PRINTR	"The walkway, which hastened the trip down that long corridor, is no longer in service."


	.FUNCT	BENCH-PSEUDO
	EQUAL?	PRSA,V?BOARD,V?CLIMB-ON \FALSE
	PRINTR	"The benches look uncomfortable."


	.FUNCT	CATWALK-PSEUDO
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP,V?CLIMB-ON \FALSE
	PRINTR	"The catwalks are too high for you to access."


	.FUNCT	EQUIPMENT-PSEUDO
	EQUAL?	PRSA,V?LAMP-OFF /?CCL3
	EQUAL?	PRSA,V?LAMP-ON,V?RUB,V?EXAMINE \FALSE
?CCL3:	PRINTR	"The equipment here is so complicated that you couldn't even begin to figure out how to operate it."


	.FUNCT	MONITORS-PSEUDO
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	CALL	DESCRIBE-MONITORS
	RSTACK	


	.FUNCT	MURAL-PSEUDO
	ZERO?	COMPUTER-FIXED /?CCL3
	CALL	ANYMORE
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL6
	PRINTR	"It's a gaudy work of orange and purple abstract shapes, reminiscent of the early works of Burstini Bonz. It doesn't appear to fit the decor of the room at all. The mural seems to ripple now and then, as though a breeze were blowing behind it."
?CCL6:	EQUAL?	PRSA,V?MUNG \?CCL8
	PRINTR	"My sentiments also, but let's be civil."
?CCL8:	EQUAL?	PRSA,V?LOOK-BEHIND,V?MOVE \FALSE
	PRINTR	"It won't budge."


	.FUNCT	LOGO-PSEUDO
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"The logo shows a flame burning over a sleep chamber of some type. Under that is the phrase ""Prajekt Kuntrool."""


	.FUNCT	KEYBOARD-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It is a standard numeric keyboard with ten keys labelled from 0 through 9."


	.FUNCT	CRACK-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The crack is too small to go through, but large enough to look through."
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	EQUAL?	HERE,RADIATION-LAB \?CCL8
	PRINTR	"You see a dimly lit Bio Lab. Sinister shapes lurk about within."
?CCL8:	PRINTR	"You see a laboratory suffused with a pale blue glow."


	.FUNCT	VOID-PSEUDO
	EQUAL?	PRSA,V?PUT \?CCL3
	EQUAL?	PRSI,PSEUDO-OBJECT \?CCL3
	CALL	PERFORM,V?THROW-OFF,PRSO,STRIP
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?ZAP \?CCL7
	EQUAL?	PRSO,LASER \?CCL7
	EQUAL?	PRSI,PSEUDO-OBJECT \?CCL7
	SET	'PRSI,FALSE-VALUE
	CALL	PERFORM,V?ZAP,LASER
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?LEAP,V?THROUGH \?CCL12
	CALL	JIGS-UP,STR?60
	RSTACK	
?CCL12:	EQUAL?	PRSA,V?EXAMINE,V?LOOK-INSIDE \FALSE
	PRINTR	"The void extends downward into the gloom far below."


	.FUNCT	SPOUT-PSEUDO
	EQUAL?	PRSA,V?PUT-UNDER \?CCL3
	EQUAL?	PRSO,CANTEEN \?CCL3
	CALL	PERFORM,V?PUT,CANTEEN,DISPENSER
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	IN?	CANTEEN,DISPENSER \FALSE
	PRINTR	"The canteen is sitting under the spout."


	.FUNCT	TOILET-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"The fixtures are all dry and dusty."
?CCL3:	EQUAL?	PRSA,V?FLUSH \FALSE
	PRINTR	"The water seems to be turned off."


	.FUNCT	GAMES-PSEUDO
	EQUAL?	PRSA,V?PLAY \?CCL3
	CALL	PERFORM,V?PLAY,GLOBAL-GAMES
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"All the usual games -- Chess, Cribbage, Galactic Overlord, Double Fannucci..."


	.FUNCT	TAPES-PSEUDO
	EQUAL?	PRSA,V?TAKE,V?PLAY,V?READ \?CCL3
	PRINTR	"Hardly the time or place for reading recreational tapes."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"Let's see...here are some musical selections, here are some bestselling romantic novels, here is a biography of a famous Double Fannucci champion..."


	.FUNCT	PARTITION-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The partitions are very plain, and were obviously intended to separate this huge room into smaller areas."


	.FUNCT	CUBBYHOLE-PSEUDO
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTR	"The cubbyholes look like the kind that are used to hold maps or blueprints. They are all empty now."


	.FUNCT	MAPS-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"Examining the maps reveals no new information."


	.FUNCT	DEVICES-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"They are components of disassembled robots, beyond repair."


	.FUNCT	CABLES-PSEUDO
	EQUAL?	PRSA,V?FOLLOW,V?EXAMINE \?CCL3
	PRINTR	"These heavy cables merely run from the two consoles up into the ceiling."
?CCL3:	EQUAL?	PRSA,V?MUNG \FALSE
	CALL	JIGS-UP,STR?61
	RSTACK	


	.FUNCT	STRUCTURE-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"You'd be able to tell more about it if you climbed up to it."
?CCL3:	EQUAL?	PRSA,V?CLIMB-UP \FALSE
	CALL	DO-WALK,P?UP
	RSTACK	


	.FUNCT	BUTTON-PSEUDO
	EQUAL?	PRSA,V?PUSH \FALSE
	FSET?	DISPENSER,MUNGEDBIT \?CCL6
	PRINTR	"The dispenser sputters a few times."
?CCL6:	IN?	CANTEEN,DISPENSER \?CCL8
	FSET?	CANTEEN,OPENBIT /?CCL11
	PRINTR	"A thick, brown liquid spills over the closed canteen, dribbles down the side of the machine, and forms a puddle on the floor which quickly dries up."
?CCL11:	IN?	HIGH-PROTEIN,CANTEEN \?CCL13
	PRINTI	"The brown liquid splashes over the mouth of the already-filled canteen, creating a mess"
	FSET?	PATROL-UNIFORM,WORNBIT \?CND14
	PRINTI	" and staining your uniform"
?CND14:	PRINTR	"."
?CCL13:	MOVE	HIGH-PROTEIN,CANTEEN
	PRINTR	"The canteen fills almost to the brim with a brown liquid."
?CCL8:	PRINTR	"A thick, brownish liquid pours from the spout and splashes to the floor, where it quickly evaporates."


	.FUNCT	CARPET-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It's pretty dusty."


	.FUNCT	CABINETS-PSEUDO
	EQUAL?	PRSA,V?OPEN,V?EXAMINE \?CCL3
	PRINTR	"The cabinets are locked."
?CCL3:	EQUAL?	PRSA,V?UNLOCK \FALSE
	PRINTR	"You don't have the correct key."


	.FUNCT	PLATE-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The plates seem to be featureless metal squares."


	.FUNCT	ESCALATOR-PSEUDO
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \?CCL3
	EQUAL?	HERE,FORK \?CCL6
	PRINTR	"You're already at the top of the escalator."
?CCL6:	CALL	DO-WALK,P?UP
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?CLIMB-DOWN \?CCL8
	EQUAL?	HERE,LAWANDA-PLATFORM \?CCL11
	PRINTR	"You're already at the bottom of the escalator."
?CCL11:	CALL	DO-WALK,P?DOWN
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?LAMP-ON \FALSE
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	REACTOR-BUTTON-PSEUDO
	EQUAL?	PRSA,V?PUSH \FALSE
	FSET	REACTOR-ELEVATOR-DOOR,OPENBIT
	CALL	QUEUE,I-REACTOR-DOOR-CLOSE,30
	PUT	STACK,0,1
	PRINTR	"The metal doors slide open, revealing a small room to the east."


	.FUNCT	SUPPLIES-PSEUDO
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"These supplies are of absolutely no use."


	.FUNCT	DESK-PSEUDO
	EQUAL?	PRSA,V?OPEN \?CCL3
	PRINTR	"All the drawers are empty."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It is bare except for the microfilm reader."


	.FUNCT	CRYO-BUTTON-PSEUDO
	EQUAL?	PRSA,V?PUSH \?CCL3
	ZERO?	CRYO-SCORE-FLAG \?CCL3
	CALL	QUEUE,I-CRYO-ELEVATOR-ARRIVE,100
	PUT	STACK,0,1
	CALL	INT,I-CHASE-SCENE
	PUT	STACK,0,0
	FCLEAR	CRYO-ELEVATOR-DOOR,OPENBIT
	SET	'CRYO-SCORE-FLAG,TRUE-VALUE
	ADD	SCORE,5 >SCORE
	PRINTR	"The elevator door closes just as the monsters reach it! You slump back against the wall, exhausted from the chase. The elevator begins to move downward."
?CCL3:	EQUAL?	PRSA,V?PUSH \FALSE
	ZERO?	CRYO-SCORE-FLAG /FALSE
	FSET?	CRYO-ELEVATOR-DOOR,OPENBIT \FALSE
	CALL	JIGS-UP,STR?62
	RSTACK	


	.FUNCT	CASTLE-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The castle is ancient and crumbling."


	.FUNCT	CHEM-SPOUT-PSEUDO
	EQUAL?	PRSA,V?PUT-UNDER \?CCL3
	EQUAL?	PRSI,PSEUDO-OBJECT \?CCL3
	CALL	PERFORM,V?PUT-UNDER,PRSO,CHEMICAL-DISPENSER
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	ZERO?	SPOUT-PLACED /FALSE
	PRINTI	"There is "
	CALL	A-AN
	PRINTD	SPOUT-PLACED
	PRINTR	" under the spout."


	.FUNCT	CLEFT-PSEUDO
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	CALL	DO-WALK,P?UP
	RSTACK	


	.FUNCT	RUBBLE-PSEUDO
	EQUAL?	PRSA,V?MOVE \FALSE
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	PLAQUE-PSEUDO
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"
SEENIK VISTA 
Xis stuneeng vuu uf xee Kalamontee Valee kuvurz oovur fortee skwaar miilz uf xat faamus tuurist spot. Xee larj bildeeng at xee bend in xee Gulmaan Rivur iz xee formur pravincul kapitul bildeeng."


	.FUNCT	FENCE-PSEUDO
	EQUAL?	PRSA,V?LEAP,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	PRINTR	"You can't."


	.FUNCT	LOCK-PSEUDO
	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	ZERO?	PRSI /?CCL6
	PRINTR	"That won't unlock it."
?CCL6:	PRINTR	"But you don't have the orange key!"


	.FUNCT	DIAGRAM-PSEUDO
	EQUAL?	PRSA,V?READ \FALSE
	PRINTR	"Not unless you've taken a special twelve-year course in ninth-order molecular physics."


	.FUNCT	ENUNCIATOR-PSEUDO
	EQUAL?	PRSA,V?MOVE,V?PUSH,V?LOOK-INSIDE \FALSE
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	RTRUE	


	.FUNCT	NEAR-BOOTH-PSEUDO
	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?DROP \?CCL3
	PRINTR	"You're not in the booth!"
?CCL3:	EQUAL?	PRSA,V?WALK-TO,V?BOARD,V?THROUGH \FALSE
	CALL	DO-WALK,P?IN
	RSTACK	


	.FUNCT	IN-BOOTH-PSEUDO
	EQUAL?	PRSA,V?WALK-TO,V?BOARD,V?THROUGH \?CCL3
	PRINTR	"You're already in the booth!"
?CCL3:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?DROP \FALSE
	CALL	DO-WALK,P?OUT
	RSTACK	

	.ENDI
