"MISC for PLANETFALL
(c) Copyright 1983 Infocom, Inc.  All Rights Reserved."

^L

"old MACROS file"

<SETG C-ENABLED? 0>
<SETG C-ENABLED 1>
<SETG C-DISABLED 0>

;<COND (<NOT <GASSIGNED? XTELLEN>> <SETG XTELLEN 15>)>

;<DEFINE XSTR (STR "AUX" (L ,XTELLEN))
 <COND (<AND <NOT <GASSIGNED? PREDGEN>>
	     <TYPE? .STR STRING>
	     <NOT <LENGTH? .STR .L>>>
	<STRING <SUBSTRUC .STR 0 <- .L 3>> "...">)
       (T .STR)>>

;<DEFINE XTELL ("CALL" F "AUX" (L ,XTELLEN)) ;"use %<XTELL ...> for <TELL ...>"
 <COND (<NOT <GASSIGNED? PREDGEN>>
	<MAPR <>
	      <FUNCTION (FF "AUX" (A <1 .FF>))
	       <COND (<AND <TYPE? .A STRING>
			   <NOT <LENGTH? .A .L>>>
		      <1 .FF <STRING <SUBSTRUC .A 0 <- .L 3>>
				     "...">>)>>
	      .F>)>
 <1 .F TELL>>

<DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM PRINTD .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<TYPE? .E FORM>
				 <MAPRET <FORM PRINT .E>>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>

<DEFMAC VERB? ("TUPLE" ATMS "AUX" (O ()) (L ())) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				     (ELSE <FORM OR !.O>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<FORM GVAL <PARSE <STRING "V?" <SPNAME .ATM>>>>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O (<FORM EQUAL? ',PRSA !.L> !.O)>
		<SET L ()>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	 <FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

;<ROUTINE ZPROB (BASE)
	 <G? .BASE <RANDOM 300>>>

<ROUTINE PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>

^L

"old MAIN or VERMONT file"

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>
 
<CONSTANT M-HANDLED 1>   
 
<CONSTANT M-NOT-HANDLED <>>   
 
<CONSTANT M-BEG 1>  
 
<CONSTANT M-END 6> 
 
<CONSTANT M-OBJECT <>>

<CONSTANT M-ENTER 2>
 
<CONSTANT M-LOOK 3> 
 
<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<ROUTINE GO () 
	 <PUTB ,P-LEXV 0 59>
;"put interrupts on clock chain"
	 <ENABLE <QUEUE I-BLATHER -1>>
	 <ENABLE <QUEUE I-AMBASSADOR -1>>
	 <ENABLE <QUEUE I-RANDOM-INTERRUPTS 1>>
	 <ENABLE <QUEUE I-SLEEP-WARNINGS 3600>>
	 <ENABLE <QUEUE I-HUNGER-WARNINGS 2000>>
	 <ENABLE <QUEUE I-SICKNESS-WARNINGS 1000>>
;"set up and go"
	 <SETG SPOUT-PLACED ,GROUND>
	 <SETG INTERNAL-MOVES <+ 4450 <RANDOM 180>>>
         <SETG MOVES ,INTERNAL-MOVES>
	 <SETG LIT T>
	 <SETG WINNER ,ADVENTURER>
	 <SETG HERE ,DECK-NINE>
	 <SETG P-IT-LOC ,DECK-NINE>
	 <SETG P-IT-OBJECT ,POD-DOOR>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<V-VERSION>
		<CRLF>
		<TELL
"Another routine day of drudgery aboard the Stellar Patrol Ship Feinstein.
This morning's assignment for a certain lowly Ensign Seventh Class: scrubbing
the filthy metal deck at the port end of Level Nine. With your Patrol-issue
self-contained multi-purpose all-weather scrub brush you shine the floor with
a diligence born of the knowledge that at any moment dreaded Ensign First
Class Blather, the bane of your shipboard existence, could appear." CR CR>)>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>

<ROUTINE I-RANDOM-INTERRUPTS ()
	 <ENABLE <QUEUE I-BLOWUP-FEINSTEIN <+ <RANDOM 90> 240>>>
	 <COMM-SETUP> ;"sets up comm system and laser values"
	 <SETG NUMBER-NEEDED <RANDOM 1000>>>

<ROUTINE MAIN-LOOP ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP)
   <REPEAT ()
     <SETG C-ELAPSED ,C-ELAPSED-DEFAULT>
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND ,P-IT-OBJECT <ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
					 <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
					 <SET TMP T>
					 <RETURN>)>)>>
		   <COND (<NOT .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM
		 <COND (<0? .OCNT> .OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<0? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <NOT .OBJ> <1? .ICNT>> <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<==? ,PRSA ,V?WALK> <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<0? .NUM>
		   <COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (T
			  <TELL "There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<OR ,P-OFLAG ,P-MERGED>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <WORD-PRINT <GETB .TMP 2>
					     <GETB .TMP 3>>)>
			  <TELL "!" CR>
			  <SET V <>>)>)
		  (T
		   <SET TMP 0>
		   <SET ICNT <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
				  <COND (<G? .TMP 0>
					 <TELL "The ">
					 <COND (<NOT <EQUAL? .TMP .NUM>>
						<TELL "other ">)>
					 <TELL "object">
					 <COND (<NOT <EQUAL? .TMP 1>>
						<TELL "s">)>
					 <TELL " that you mentioned ">
					 <COND (<NOT <EQUAL? .TMP 1>>
						<TELL "are">)
					       (T <TELL "is">)>
					 <TELL "n't here." CR>)
					(<NOT .ICNT>
					 <TELL "There's nothing there." CR>)>
				  <RETURN>)
				 (T
				  <COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
					(T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
				  <SETG PRSO <COND (.PTBL .OBJ1) (T .OBJ)>>
				  <SETG PRSI <COND (.PTBL .OBJ) (T .OBJ1)>>
				  <COND (<OR <G? .NUM 1>
					     <EQUAL? <GET <GET ,P-ITBL ,P-NC1>
							  0>
						     ,W?ALL>>
					 <COND (<EQUAL? .OBJ1
							,NOT-HERE-OBJECT>
						<SET TMP
						      <+ .TMP 1>>
						<AGAIN>)
					       (<AND <VERB? TAKE>
						     ,PRSI
						     <EQUAL? <GET <GET ,P-ITBL
								       ,P-NC1>
								  0>
							     ,W?ALL>
						     <NOT <IN? ,PRSO ,PRSI>>>
						<AGAIN>)
					       (<AND <EQUAL? ,P-GETFLAGS
							     ,P-ALL>
						     <VERB? TAKE>
						     <NOT <EQUAL?
							   <LOC .OBJ1>
							   ,WINNER
							   ,HERE>>>
						<AGAIN>)
					       (T
						<COND (<EQUAL? .OBJ1 ,IT>
						       <PRINTD ,P-IT-OBJECT>)
						      (T <PRINTD .OBJ1>)>
						<TELL ": ">)>)>
				  <SET ICNT T>
				  <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
				  <COND (<==? .V ,M-FATAL> <RETURN>)>)>>)>
	    <COND (<NOT <==? .V ,M-FATAL>>
		   ;<COND (<==? <LOC ,WINNER> ,PRSO>
			  <SETG PRSO <>>)>
		   <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	    <COND (<NOT <==? ,PRSA ,V?AGAIN>>
		   <SETG L-PRSA ,PRSA>
		   <SETG L-PRSO ,PRSO>
		   <SETG L-PRSI ,PRSI>)>
	    <COND (<NOT <EQUAL? <GET <INT I-POD-TRIP> ,C-ENABLED?> 0>>
		   <SETG C-ELAPSED 54>)
		  (<G? ,SHUTTLE-VELOCITY 0>
		   <SETG C-ELAPSED </ 600 ,SHUTTLE-VELOCITY>>)
		  (<OR <VERB? TELL>
		       <TIMELESS-VERB? ,PRSA>>
		   <SETG C-ELAPSED 0>)
		  (<AND <VERB? AGAIN>
			<TIMELESS-VERB? ,L-PRSA>>
		   <SETG C-ELAPSED 0>)>
	    <SETG INTERNAL-MOVES <+ ,INTERNAL-MOVES ,C-ELAPSED>>
	    <COND (<==? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (<NOT <IN? ,CHRONOMETER ,ADVENTURER>>
	    <SETG MOVES 0>)
	   (<FSET? ,CHRONOMETER ,MUNGEDBIT>
	    <SETG MOVES ,MUNGED-TIME>)
	   (T
	    <SETG MOVES ,INTERNAL-MOVES>)>
     <COND (,P-WON
	    <COND (<NOT <EQUAL? ,C-ELAPSED 0>>
		   <SET V <CLOCKER>>)>)>>>

<ROUTINE TIMELESS-VERB? (VRB)
	 <COND (<OR <EQUAL? .VRB ,V?BRIEF ,V?SUPER-BRIEF ,V?VERBOSE>
		    <EQUAL? .VRB ,V?SAVE ,V?RESTORE ,V?SCORE>
		    <EQUAL? .VRB ,V?SCRIPT ,V?UNSCRIPT ,V?TIME>
		    <EQUAL? .VRB ,V?QUIT ,V?RESTART ,V?VERSION>
		    <EQUAL? .VRB ,V?$RANDOM ,V?$RECORD ,V?$UNRECORD>
		    <EQUAL? .VRB ,V?$COMMAND>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL L-PRSA <>>  
 
<GLOBAL L-PRSO <>>  
 
<GLOBAL L-PRSI <>>  

%<COND (<GASSIGNED? PREDGEN>

'<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI)
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<EQUAL? ,IT .I .O>
	       ;<AND <EQUAL? ,IT .I .O>
		    <OR <NOT <EQUAL? ,P-IT-LOC ,HERE>>
			<EQUAL? <LOC ,P-IT-OBJECT> <>>>>
	       <TELL "I don't see what you are referring to." CR>
	       <SETG P-IT-OBJECT <>>
	       <RFATAL>)>
	;<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	;<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>
	       <SETG P-IT-LOC ,HERE>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <APPLY ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>	;"to keep clock from running"
	       .V)
	      (<AND <SET O ,PRSO> <SET I ,PRSI> <NULL-F>>
	       <TELL "[in case last clause changed PRSx]">)
	      (<SET V <APPLY <GETP ,WINNER ,P?ACTION>>> .V)
	      (<SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>> .V)
	      (<SET V <APPLY <GET ,PREACTIONS .A>>> .V)
	      (<AND .I <SET V <APPLY <GETP .I ,P?ACTION>>>> .V)
	      (<AND .O
		    <NOT <==? .A ,V?WALK>>
		    <SET V <APPLY <GETP .O ,P?ACTION>>>>
	       .V)
	      (<SET V <APPLY <GET ,ACTIONS .A>>> .V)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>)
       (T

'<PROG ()

<SETG PDEBUG <>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI)
	<COND (,PDEBUG
	       <TELL "** PERFORM: PRSA = ">
	       <PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>
	       <COND (<AND .O <NOT <==? .A ,V?WALK>>>
		      <TELL " | PRSO = " D .O>)>
	       <COND (.I <TELL " | PRSI = " D .I>)>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<EQUAL? ,IT .I .O>
	       ;<AND <EQUAL? ,IT .I .O>
		    <OR <NOT <EQUAL? ,P-IT-LOC ,HERE>>
			<EQUAL? <LOC ,P-IT-OBJECT> <>>>>
	       <TELL "I don't see what you are referring to." CR>
	       <SETG P-IT-OBJECT <>>
	       <RFATAL>)>
	;<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	;<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>
	       <SETG P-IT-LOC ,HERE>)>
	<SETG PRSI .I>
	<COND (<SET V <D-APPLY "Actor"
			       <GETP ,WINNER ,P?ACTION>>> .V)
	      (<SET V <D-APPLY "Room (M-BEG)"
			       <GETP <LOC ,WINNER> ,P?ACTION>
			       ,M-BEG>> .V)
	      (<SET V <D-APPLY "Preaction"
			       <GET ,PREACTIONS .A>>> .V)
	      (<AND .I <SET V <D-APPLY "PRSI"
				       <GETP .I ,P?ACTION>>>> .V)
	      (<AND .O
		    <NOT <==? .A ,V?WALK>>
		    <LOC .O>
		    <SET V <D-APPLY "Container"
				    <GETP <LOC .O> ,P?CONTFCN>>>>
	       .V)
	      (<AND .O
		    <NOT <==? .A ,V?WALK>>
		    <SET V <D-APPLY "PRSO"
				    <GETP .O ,P?ACTION>>>>
	       .V)
	      (<SET V <D-APPLY <>
			       <GET ,ACTIONS .A>>> .V)>
	<COND (<NOT <==? .V ,M-FATAL>>
	       ;<COND (<==? <LOC ,WINNER> ,PRSO>
		      <SETG PRSO <>>)>
	       <SET V <D-APPLY "Room (M-END)"
			       <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<DEFINE D-APPLY (STR FCN "OPTIONAL" FOO "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,PDEBUG
		      <COND (<NOT .STR>
			     <TELL CR "  Default ->" CR>)
			    (T <TELL CR "  " .STR " -> ">)>)>
	       <SET RES
		    <COND (<ASSIGNED? FOO>
			   <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       <COND (<AND ,PDEBUG .STR>
		      <COND (<==? .RES 2>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>
>)>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ> <RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (ELSE
			<SET OBJ <LOC .OBJ>>)>>>

^L

"old CLOCK file"

<CONSTANT C-TABLELEN 240>

<GLOBAL C-TABLE %<COND (<GASSIGNED? PREDGEN>
			'<ITABLE NONE 120>)
		       (T
			'<ITABLE NONE 240>)>>

<GLOBAL C-DEMONS 300>

<GLOBAL C-INTS 240>

<GLOBAL C-ELAPSED 7>

<CONSTANT C-ELAPSED-DEFAULT 7>

<CONSTANT C-INTLEN 6>

<CONSTANT C-ENABLED? 0>

<CONSTANT C-TICK 1>

<CONSTANT C-RTN 2>

;<ROUTINE DEMON (RTN TICK "AUX" CINT)
	 <PUT <SET CINT <INT .RTN T>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;<GLOBAL CLOCK-WAIT <>>

;<GLOBAL ELAPSED-MOVES 0>

<ROUTINE CLOCKER ("AUX" C E TICK (FLG <>))
	 ;<SETG ELAPSED-MOVES <+ ,ELAPSED-MOVES 1>>
	 ;<COND (,DEBUG-ON
		<TELL "[Elapsed time: " N ,C-ELAPSED "]" CR>)>
	 ;<COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SET C <REST ,C-TABLE <COND (,P-WON ,C-INTS) (T ,C-DEMONS)>>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<==? .C .E> <RETURN .FLG>)
		       (<NOT <0? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<0? .TICK>)
			      (<==? .TICK -1>
			       <COND (<APPLY <GET .C ,C-RTN>>
				      <SET FLG T>)>)
			      (T
			       <PUT .C ,C-TICK <SET TICK <- .TICK ,C-ELAPSED>>>
			       <COND (<NOT <G? .TICK 1>>
				      <PUT .C ,C-TICK 0>
				      <COND (<APPLY <GET .C ,C-RTN>>
					     <SET FLG T>)>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE NULL-F ("OPTIONAL" A1 A2)
	<RFALSE>>