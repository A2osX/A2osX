# A2osX Forth Words (0.94)

## Description

This document lists all of the **Forth Words** supported in the A2osX implementation of **FigForth**.  Note that not all **Words** are implemented at this time, please check the *Status* and *Comment* Columns.  Currently only an interpreter is available (*../bin/forth*) | | | though a compiler is planned |

## Word Notation

The following will help you understand the Forth Words defined in the tables below.

### Stack Notation

The  first  line of each entry describes the execution of  the definition:<br>i.e., before -- after<br>In  this  notation,   the top of the stack is  to  the  right. Words may also be shown in context when appropriate.

### Attributes

The I/C Column symbols indicate attributes of the defined words:

     C    The  word may only be used during compilation of a  colon definition.
     I    Indicates  that  the word is IMMEDIATE and  will  execute during compilation, unless special action is taken.
     U    A user variable.

### Stack Parameters
Unless otherwise stated, all reference to numbers apply to 16-bit signed integers.   The implied range of values is shown as {from..to}.   The  content  of an address is shown  by  double curly  brackets,  particularly for the contents of  variables, i.e.,  BASE {{2..70}}.

### addr                                                   {0..65,535}
A value representing the address of a byte,  within the  FORTH standard memory space.   This addressed byte may represent the first byte of a larger data field in memory.

### byte                                                   {0..255}
A  value representing an 8 bit byte.   When in a larger field, the higher bits are zero.

### char                                                   {0..127}
A value representing a 7 bit ASCII character code.   When in a larger field, the higher bits are zero.

### d                                  {-2,147,483,648..2,147,483,647}
32 bit signed 'double' number.   The most significant 16-bits, with sign, is most accessible on the stack.

### flag
A numerical value with two logical states;   0 = false,  non-zero = true.

### n                                                 {-32,768..32,767}
16 bit signed integer number.  Any other symbol refers to an arbitrary signed 16-bit  integer in the range {-32,768..32,767}, unless otherwise noted.

### Input Text

**name**  An arbitrary FORTH word accepted from the input stream.   This notation refers to text from the input stream,  not to  values on  the data stack.   If the input stream is exhausted  before encountering <name>, an error condition exists.

### Order

The  definitions are listed  in  ASCII  alphabetical order in several groups consisting of:

#### Nucleus Words

!   *   */   */MOD   +   +!   +loop   -   / /MOD   0<   0=   0>   1+   1-   2+   2-   < =   >   >R   ?DUP   @   ABS   AND   begin   C! C@   colon   CMOVE   constant   create   D+ D<   DEPTH   DNEGATE   do   does> DROP   DUP   else   EXECUTE   EXIT   FILL   I if   J   LEAVE   literal   loop   MAX   MIN MOD   MOVE   NEGATE   NOT   OR   OVER   PICK R>   R@   repeat   ROLL   ROT   semicolon SWAP   then   U*   U/   until   variable while   XOR

(note  that  lower  case entries refer to just  the  run-time  code corresponding to a compiling word.)

#### Interpreter Words

#   #>   #S   '   (   -TRAILING   . 79-STANDARD   <#   >IN   ?   ABORT   BASE   BLK CONTEXT   CONVERT   COUNT   CR   CURRENT DECIMAL   EMIT   EXPECT   FIND   FORTH   HERE HOLD   KEY   PAD   QUERY   QUIT   SIGN   SPACE SPACES   TYPE   U.   WORD

#### Compiler Words

+LOOP   ,   ."   :   ;   ALLOT   BEGIN COMPILE   CONSTANT   CREATE   DEFINITIONS   DO DOES>   ELSE   FORGET   IF   IMMEDIATE LITERAL   LOOP   REPEAT   STATE   THEN   UNTIL VARIABLE   VOCABULARY   WHILE   [   [COMPILE]   ]

#### Device Words

BLOCK   BUFFER   EMPTY-BUFFERS   LIST LOAD   SAVE-BUFFERS   SCR   UPDATE

## Words

| Word | Syntax | I/C | Status | Description | Comment |
|-|-|-|-|-|-|
| ! | n addr -- | I,C | Working | Store second word at address on top | |
| # | ud1 -- ud2 | | | Convert one digit of double number and add character to output string | |
| #> | d -- addr n | | | Terminate output string for TYPE | |
| #S | ud -- 0 0 | | | Convert all significant digits of double number to output string | |
| ' | -- addr | I | | Find address of next string in dictionary | |
| | -- | I | | Begin comment, terminated by | |
| * | n1 n2 -- n3 | I,C | Working | Arithmetic product of n1 times n2 | |
| */ | n1 n2 n3 -- n4 | || Multiply n1 by n2, divide result by n3 and leave quotient in n4 | |
| */MOD | n1 n2 n3 -- n4 n5  | | | Multiply n1 by n2, divide result by n3 and leave remainder in n4 and quotient in n5 | |
| + | n1 n2 -- n3 | I,C | Working | Arithmetic result of n1 plus n2 | |
| +! | n addr -- | | Working | Add second 16-bit number to contents of address | |
| +LOOP | n -- | C | Working | Increment index by n. Terminate loop if outside limit | |
| , | n -- | | | Allot two bytes in dictionary, storing n there | |
| - | n1 n2 -- n3 | I,C | Working | Subtract n2 from n1 leaveing result in n3 | |
| -TRAILING | addr n1 -- addr n2 | | | Adjust char count n1 of a text string at addr to exclude trailing blank, resulting in string at addr new length on n2| |
| . | n -- | I,C | Working | Print number | |
| ." | -- | I,C | Working  | Print message terminated by " |  |
| / | n1 n2 -- n3 | I,C | Working | Divide n1 divide by n2, leave quotient in n3| |
| /MOD | n1 n2 -- n3 n4 | I,C | Working | Divide n1 divide by n2, leave remainder in n3 and quotient in n4 | |
| 0< | n -- flag | I,C | Working | True if n less than zero | |
| 0= | n -- flag | I,C | Working | True if n zero | |
| 0> | n -- flag | I,C | Working | True if n greater than zero | |
| 1+| n -- n+1 | | | Increment n by one | |
| 1- | n -- n-1 | | | Decrement n by one | |
| 2+ | n -- n+2 | | | Increment n by two | |
| 2- | n -- n-2 | | | Decrement n by two| |
| 79-STANDARD | | | | Returns Error if FORTH-79 Standard is not available| |
| : | -- | I | Working | Begin a colon definition | |
| ; | -- | C | Working | End of a colon definition | |
| < | n1 n2 -- flag | I,C | Working | True if n1 less than n2 | |
| <# | -- | | | Initialize pictured number output  | |
| = | n1 n2 -- flag | I,C | Working | True if n1 equal to n2 | |
| > | n1 n2 -- flag | I,C | Working | True if n1 greater than n2 | |
| >IN | -- addr | U | | Leave addr of variable of char offset input stream {0,,1023}| |
| >R | n -- | C | | Move n to return stack | |
| ? | addr -- | I,C | Working  | Print contents of address | |
| ?DUP | n -- n ( n) | | duplicate n if non-zero | |
| @ | addr -- n | I,C | Working  | Put on stack number at addr | |
| ABORT | | | Clear data and return stacks | |
| ABS | n1 -- n1 | I,C | Working | Absolute value of n1 | |
| ALLOT | n -- | I,C | Working | Add n bytes to parameter field of most recently defined word | |
| AND | n1 n2 -- n3 | I,C | Working | Leave Logical bitwise AND of n1 and n2 | |
| BASE | -- addr | U | | Leave address of variable containing current input-output number conversion base. {{2..70} | |
| BEGIN | -- | C | Working | Used in a colon-definition in the form: <br>BEGIN ... flag UNTIL or<br>BEGIN ... flag WHILE ... REPEAT  <br> BEGIN  marks  the  start of a  word  sequence  for  repetitive execution.   A BEGIN-UNTIL loop will be repeated until flag is true.   A  BEGIN-WHILE-REPEAT loop will be repeated until flag is  false.   The words after UNTIL or REPEAT will be  executed when  either loop is finished.  flag is always dropped  after being tested. | |
| BLK | -- addr | U | | Leave  the address of a variable containing the number of  the mass storage block being interpreted as the input stream.  If the  content  is  zero,  the input stream is  taken  from  the terminal.| |
| BLOCK | n -- addr | | | Return address of first byte of memory for block n.  If block n is not in memory, retrieve it first | |
| BUFFER | n -- addr | | | Obtain next block buffer, assign to n | |
| C! | n addr -- | | Working | Store least significant of n in addr | |
| C@ | addr -- byte | | Working | Leave on stack addr, with high bits set to 0 for 16-bit field | |
| CMOVE | addr1 addr2 n -- | | | Move n bytes at addr1 to addr2 | |
| COMPILE | | C | | When  a  word containing COMPILE executes,  the  16-bit  value following   the  compilation  address  of  COMPILE  is  copied (compiled) into the dictionary.   i.e.,  COMPILE DUP will copy the compilation address of DUP.    <br>COMPILE  [ 0 , ]   will copy zero. | |
| CONSTANT | n -- | I,C | Working | A defining word used in the form: <br>n CONSTANT **name** <br>to  create  a dictionary entry for **name**,  leaving n  in  its parameter  field.   When **name** is later executed,  n will  be left on the stack. | |
| CONTEXT | -- addr | U | | Leave  the address of a variable specifying the vocabulary  in which   dictionary   searches   are   to   be   made,   during interpretation of the input stream. | | 
| CONVERT | d1 addr1 -- d2 addr2 | | | Convert to the equivalent stack number  the text beginning  at addr1+1  with regard to BASE.   The new value  is  accumulated into double number d1, being left as d2.  addr2 is the address of the first non-convertible character. | |
| COUNT | addr -- addr+1 n | | | Leave  the  address  addr+1 and the character  count  of  text beginning  at addr.   The first byte at addr must contain  the character count n.  Range of n is {0..255}. | |
| CR | -- | I,C | Working | Do a carriage-return | |
| CREATE | | | |   A defining word used in the form:  <br>CREATE  **name**<br> to  create a dictionary entry for <name>,  without  allocating any  parameter  field memory.   When **name**  is  subsequently executed,  the address of the first byte of **name**'s parameter field is left on the stack. | |
| CURRENT | -- addr | U | | Leave the address of a variable specifying the vocabulary into which new word definitions are to be entered. | |
| D+ | d1 d2 -- d3 | I,C | Working | Leave arithmetic sum of d1 plus d2 | |
| D< | d1 d2 -- flag | | | True is d1 less than d2 | | 
| DECIMAL | -- | | | Set input-output numeric conversation base to ten  | |
| DEFINITIONS | -- | | | Set current vocabulary to context vocabulary | |
| DEPTH | -- n | | | Leave number of the quantity of 16-bit values contained in the data stack, before n added | |
| DNEGATE | d -- -d | | | Leave the two's complement of a double number. | |
| DO | n1 n2 -- | C | Working | Used in a colon-definition: <br>DO ... LOOP   or  <br>DO ... +LOOP  <br>Begin a loop which will terminate based on control parameters. The loop index begins at n2, and terminates based on the limit n1.   At LOOP or +LOOP, the index is modified by a positive or negative  value.   The range of a DO-LOOP is determined by the terminating word.   DO-LOOP may be nested.  Capacity for three levels  of  nesting  is specified as a  minimum  for  standard systems. | |
| DOES | | I,C | | Define  the run-time action of a word created by a  high-level defining word.  Used in the form:   <br>: **name** ... CREATE ... DOES> ... ; <br>and then   **namex  name**<br>Marks  the  termination of the defining part of  the  defining word **name** and begins the defining of the run-time action for words  that will later be defined by **name**.   On execution of **namex**  the  sequence  of  words  between  DOES>  and  ;  are executed, with the address of **namex**'s parameter field on the stack. | |
| DROP | n -- | I,C | Working | Drop top number from the stack | |
| DUP | n -- n n | I,C | Working | Duplicate top of stack | |
| ELSE | -- | C | Working | Used in a colon-definition in the form: <br>IF ... ELSE ... THEN  <br> ELSE executes after the true part following IF.   ELSE  forces execution  to skip till just after THEN.   It has no effect on  the stack.  (see IF) | |
| EMIT | char -- | I,C | Working | Transmit character to current output device | |
| EMPTY-BUFFERS | | | | Mark all block buffers as empty, without necessarily affecting their actual contents.  UPDATEd blocks are not written to mass  storage. | |
| EXECUTE | addr -- | | | Execute the dictionary entry whose compilation address is on the stack. | |
| EXIT | | C | | When compiled within a colon-definition,  terminate  execution of that definition,  at that point.   May not be used within a DO...LOOP. | |
| EXPECT | addr n -- | | | Transfer  characters  from  the terminal  beginning  at  addr, upward,  until a "return" or the count of n has been received.   Take  no action for n less than or equal to zero.   One or two nulls are added at the end of text. | |
| FILL | addr n byte -- | I,C | Working | Fill memory starting at addr with n copies of byte | |
| FIND | -- addr ||| Leave the compilation address of the next word name,  which is accepted from the input stream.   If that word cannot be found in  the  dictionary after a search of CONTEXT and FORTH  leave zero. | |
| FORGET | -- | | | Execute in the form:  <br>FORGET  **name**  <br>Delete  from  the dictionary **name** (which is in  the  CURRENT vocabulary)  and  all  words added  to  the  dictionary  after **name**,  regardless  of  their vocabulary.   Failure  to  find **name** in CURRENT or FORTH is an error condition. | |
| FORTH | -- | I | | The name of the primary vocabulary.  Execution makes FORTH the CONTEXT  vocabulary.   New  definitions become a part  of  the FORTH  until  a differing CURRENT vocabulary  is  established.    User  vocabularies  conclude by 'chaining'  to  FORTH,  so  it should  be  considered that FORTH is 'contained'  within  each user's vocabulary.y | |
| HERE | -- addr | | Working | Return address of next available dictionary location.| |
| HOLD | char -- | | | Insert ASCII character into pictured output string. May only be used between <# and #>. | |
| I | -- n | C | Working | Copy loop index on stack.  May only be used in the form: <br>DO ... I ... LOOP or <br>DO ... I ... +LOOP | |
| IF | flag -- | C | Working | Used in a colon-definition in the form:<br>flag  IF ... ELSE ... THEN   or<br>flag  IF ... THEN<br>If  flag is true,  the words following IF are executed and the words following ELSE are skipped.   The ELSE part is optional. If flag is false, words between IF and ELSE, or between IF and THEN  (when  no  ELSE is  used),  are  skipped.   IF-ELSE-THEN conditionals may be nested. | |
| IMMEDIATE | | | | Marks the most recently made dictionary entry as a word  which will  be  executed when encountered during compilation  rather than compiled. | |
| J | -- n | C | | Return  the index of the next outer loop.   May only  be  used within a nested DO-LOOP in the form: <br>DO ... DO ... J ... LOOP ... LOOP | |
| KEY | -- char | | Working | Read key, put ASCII value on stack | |
| LEAVE | -- | C | Working | Force  termination  of a DO-LOOP at the next LOOP or +LOOP  by setting  the  loop  limit equal to the current  value  of  the index.   The  index itself remains  unchanged,  and  execution proceeds   normally   until  the  loop  terminating  word   is encountered. | |
| LIST | n -- | | | List  the ASCII symbolic contents of screen n on  the  current output device, setting SCR to contain n.  n is unsigned. | |
| LITERAL | n -- | I | | f  compiling,  then  compile  the stack value n as  a  16-bit literal, which when later executed, will leave n on the stack. | |
| LOAD | n -- | | | Begin  interpretation  of  screen n by  making  it  the  input stream;  preserve  the  locators of the present  input  stream (from  >IN  and  BLK).   If interpretation is  not  terminated explicitly  it  will be terminated when the  input  stream  is exhausted.    Control   then  returns  to  the  input   stream containing  LOAD,  determined by the input stream locators >IN and BLK. | |
| LOOP | -- | C | Working |Increment  the DO-LOOP index by one,  terminating the loop  if the  new  index is equal to or greater than  the  limit.   The limit  and  index  are signed numbers in  the  range  {-32,768..32,767}. | |
| MAX | n1 n2 -- n3 | I,C | Working | Leave the greater of two numbers. | |
| MIN | n1 n2 -- n3 | I,C | Working | Leave the lesser of two numbers. | |
| MOD | n1 n2 -- n3 | I,C | Working | Divide n1 by n2,  leaving the remainder n3, with the same sign as n1. | |
| MOVE | addr1 addr2 n -- | | | Move the specified quantity n of 16-bit memory cells beginning at addr1 into memory at addr2.  The contents of addr1 is moved first.  If n is negative or zero, nothing is moved. | |
| NEGATE | n -- -n | | | Leave the two's complement of a number,  i.e.,  the difference of zero less n. | |
| NOT | flag1 -- flag2 | | | Reverse the boolean value of flag1.  This is identical to 0=. | |
| OR | n1 n2 -- n3 | I,C | Working | Leave the bitwise inclusive-or of two numbers. | |
| OVER | n1 n2 -- n1 n2 n1 | I,C | Working | Leave a copy of the second number on the stack. | |
| PAD | -- addr | I,C | Working | The address of a scratch area used to hold character strings for intermediate processing.   The minimum capacity of PAD is 64 characters (addr through addr+63). | |
| PICK | n1 -- n2 | | | Return the contents of the n1-th stack value,  not counting n1 itself.  An error condition results for n less than one.  <br>2 PICK  is equivalent to OVER.  {1..n} | |
| QUERY | | | | ccept input of up to 80 characters (or until a 'return') from the operator's terminal, into the terminal input buffer.  WORD may be used to accept text from this buffer  as  the  input stream, by setting >IN and BLK to zero. | |
| QUIT | | | | Clear the return stack, setting execution mode, and return control to the terminal.  No message is given. | |
| R> | -- n | C | | Transfer n from the return stack to the data stack. | |
| R@ | -- n | C | | Copy the number on top of the return stack to the data stack. | |
| REPEAT | -- | C | Working | Used in a colon-definition in the form: <br>BEGIN ... WHILE ... REPEAT  <br>At  run-time,  REPEAT returns to just after the  corresponding BEGIN. | |
| ROLL | n -- | | | Extract  the  n-th stack value to the top of  the  stack,  not counting  n  itself,  moving  the remaining  values  into  the vacated position.   An error condition results for n less than one.  {1..n}  <br> 3  ROLL  =  ROT<br>   1  ROLL  =  null operation | |
| ROT | n1 n2 n3 -- n2 n3 n1 | I,C | Working | Rotate the top three values, bringing the deepest to the top. | |
| SAVE-BUFFERS | | | | Write  all  blocks to mass-storage that have been  flagged  as UPDATEd.   An  error condition results if mass-storage writing is not completed. | |
| SCR | -- addr | U | | Leave  the address of a variable containing the number of  the screen most recently listed. | |
| SIGN | n -- | C | | Insert  the ASCII "-" (minus sign) into the  pictured  numeric output string, if n is negative. | |
| SPACE | -- | I,C | Working | Transmit an ASCII blank to the current output device. | |
| SPACES | n -- | I,C | Working | Transmit  n  spaces  to the current output  device.   Take  no action for n of zero or less. | |
| STATE | -- addr | U | | Leave  the address of the variable containing the  compilation state.  A non-zero content indicates compilation is occurring, but the value itself may be installation dependent. | |
| SWAP | n1 n2 -- n2 n1 | I,C | Working | Reverse top two stack items | |
| THEN | | C | Working | Used in a colon-definition in the form:<br>IF ... ELSE ... THEN   or<br>IF ... THEN<br>THEN  is  the point where execution resumes after ELSE  or  IF (when no ELSE is present). | |
| TYPE | addr n -- | | | Transmit  n  characters beginning at address  to  the  current output device.  No action takes place for n less than or equal to zero. | |
| U* | un1 un2 -- ud3 | | | Perform an unsigned multiplication of un1 by un2,  leaving the double number product ud3.  All values are unsigned. | |
| U. | un -- | I,C | Working | Display  un converted according to BASE as an unsigned number, in a free-field format, with one trailing blank. | |
| U/MOD | ud1 un2 -- un3 un 4 | | | Perform  the  unsigned division of double number ud1  by  un2, leaving the remainder un3,  and the quotient un4.   All values are unsigned. | |
| U< | un1 un2 -- flag | | | Leave the flag representing the magnitude comparison of un1  < un2 where un1 and un2 are treated as 16-bit unsigned integers. | |
| UNTIL | flag -- | C | Working | LWithin a colon-definition, mark the end of a BEGIN-UNTIL loop, which will terminate based on flag.  If flag is true, the loop is terminated.   If flag is false,  execution returns to  the first word after BEGIN.  BEGIN-UNTIL structures may be nested. | |
| UPDATE | | | | Mark  the  most recently referenced block  as  modified.   The block  will subsequently be automatically transferred to  mass storage  should  its memory buffer be needed for storage of  a different block, or upon execution of SAVE-BUFFERS. | |
| VARIABLE | n -- | I,C | Working | A defining word executed in the form:<br>VARIABLE  **name** to  create a dictionary entry for **name** and allot  two  bytes for  storage  in the parameter field.   The  application  must initialize  the stored value.   When **name** is later executed, it will place the storage address on the stack. | |
| VOCABULARY | -- | | | A defining word executed in the form:<br>VOCABULARY  **name**<br>to  create (in the CURRENT vocabulary) a dictionary entry  for **name**,   which   specifies  a  new  ordered  list   of   word definitions.   Subsequent execution of **name** will make it the CONTEXT   vocabulary.    When   **name**  becomes  the   CURRENT vocabulary (see DEFINITIONS), new definitions will be  created in that list.<br>In lieu of any further specification, new vocabularies 'chain' to  FORTH.   That  is,  when  a dictionary  search  through  a vocabulary is exhausted, FORTH will be searched. | |
| WHILE | flag -- | C | Working | Used in the form:<br>BEGIN ... flag WHILE ... REPEAT<br>Select conditional execution based on flag.   On a true  flag, continue execution through to REPEAT,  which then returns back to just after BEGIN.   On a false flag, skip execution to just after REPEAT, exiting the structure. | |
| WORD | char -- addr | | | Receive  characters  from the input stream until the  non-zero delimiting  character  is encountered or the input  stream  is exhausted,  ignoring leading delimiters.   The characters  are stored  as  a  packed string with the character count  in  the first  character position.   The actual delimiter  encountered (char  or  null)  is stored at the end of  the  text  but  not included  in the count.   If the input stream was exhausted as WORD is called,  then a zero length will result.   The address of the beginning of this packed string is left on the stack. | |
| XOR | n1 n2 -- n3 | I,C | Working | Leave the bitwise exclusive-or of two numbers. | |
| [ | | I | | End the compilation mode.   The text from the input stream  is subsequently executed.  See ] | |
| [COMPILE] | | I,C | | Used in a colon-definition in the form:<br>[COMPILE] **name**<br>Forces  compilation  of  the  following  word.    This  allows compilation  of  an IMMEDIATE word when it would otherwise  be executed. | |
| ] | | | | Sets the compilation mode.   The text from the input stream is subsequently compiled.  See [ | |

##Extension Word Sets

DOUBLE NUMBER WORD SET

| Word | Syntax | I/C | Status | Description | Comment |
|-|-|-|-|-|-|
| 2! | d addr -- | | | Store  d  in 4 consecutive bytes beginning at addr,  as for  a double number. | |
| 2@ | addr -- d | | | Leave on the stack the contents of the four consecutive  bytes beginning at addr, as for a double number. | |
| 2CONSTANT | d -- | | | A defining word used in the form:<br>d  2CONSTANT  **name**<br>to  create  a dictionary entry for **name**,  leaving d  in  its parameter  field.   When **name** is later executed,  d will  be left on the stack. | |
| 2DROP | d -- | | | Drop the top double number on the stack. | |
| 2DUP | d -- d d | | | Duplicate the top double number on the stack. | |
| 2OVER | d1 d2 -- d1 d2 d1 | | | Leave a copy of the second double number on the stack. | |
| 2ROT | d1 d2 d3 -- d2 d3 d1 | | | Rotate the third double number to the top of the stack. | |
| 2SWAP | d1 d2 -- d2 d1 | | | Exchange the top two double numbers on the stack. | |
| 2VARIABLE | | | | A defining word used in the form:<br>2VARIABLE  **name**<br>to  create a dictionary entry of **name** and assign four  bytes for  storage  in the parameter field.   When **name** is  later executed,  it  will leave the address of the first byte of its parameter field is placed on the stack. | |
| D+ | d1 d2 -- d3 | | | Leave the arithmetic sum of d1 and d2. | |
| D- | d1 d2 -- d3 | | | Subtract d2 from d1 and leave the difference d3. | |
| | D. | d -- | | | Display d converted according to BASE in a free field  format, with one trailing blank.  Display the sign only if negative. | |
| D.R | d n -- | | | Display  d converted according to BASE,  right aligned in an n character field. Display the sign only if negative. | |
| D0= | d -- flag | | | Leave true if d is zero. | |
| D< | d1 d2 -- flag | | | True if d1 is less than d2. | |
| D= | d1 d2 -- flag | | | True if d1 equals d2. | |
| DABS | d1 -- d2 | | | Leave as a positive double number d2,  the absolute value of a double number, d1.  {0..2,147,483,647} | |
| DMAX | d1 d2 -- d3 | | | Leave the larger of two double numbers. | |
| DMIN | d1 d2 -- d3 | | | Leave the smaller of two double numbers. | |
| DNEGATE | d -- -d | | | Leave  the double number two's complement of a double  number, i.e., the difference 0 less d. | |
| DU< | ud1 ud2 -- flag | | | rue if ud1 is less than ud2.  Both numbers are unsigned. | |

##Assembler Word Set

| Word | Syntax | I/C | Status | Description | Comment |
|-|-|-|-|-|-|
| ;CODE | -- | C,I | | Used in the form:<br>: **name** ...  ;CODE<br>Stop  compilation  and  terminate  a  defining  word  **name**. ASSEMBLER  becomes  the CONTEXT vocabulary.   When  **name** is executed in the form:<br>**name  namex**<br> to  define the new **namex**,  the execution address of  **namex**  will  contain  the address of the code sequence following  the ;CODE  in **name**.   Execution of any **namex** will  cause  this machine code sequence to be executed. | |
| ASSEMBLER | -- | I | | Select assembler as the CONTEXT vocabulary. | |
| CODE | -- | | | A defining word used in the form:<br>CODE  **name** ... END-CODE<br>to  create  a dictionary entry for **name** to be defined  by  a following  sequence  of assembly  language  words.   ASSEMBLER becomes the context vocabulary. | |
| END-CODE | | | | Terminate a code definition,  resetting the CONTEXT vocabulary to the CURRENT vocabulary.   If no errors have  occurred,  the   code definition is made available for use. | |

##Reference Word Set

The Reference Word Set contain both Standard Word Definitions  and uncontrolled word definitions.

| Word | Syntax | I/C | Status | Description | Comment |
|-|-|-|-|-|-|
| !BITS | n1 addr n2 -- | | | Store the value of n1  masked by n2 into the equivalent masked part  of the contents of addr,  without affecting bits outside the mask. | |
| ** | n1 n2 -- n3 | | | Leave the value of n1 to the power n2. | |
| +BLOCK | n1 -- n2 | | | Leave the sum  of  n1  plus  the number  of  the  block  being interpreted, n1 and n2 are unsigned. | |
| -' | -- ( addr ) flag | | | Used in the form:<br> -' **name**<br>Leave the parameter field of  **name**  beneath zero  (false) if the name can be found in the  CONTEXT  vocabulary;  leave only true if not found. | |
| --> | | I | | ontinue interpretation on the next sequential block.   May be used within a colon definition that crosses a block boundary. | |
| -MATCH | addr1 n1 addr2 n2 -- addr3 flag | | | Attempt  to  find the n2-character string beginning  at  addr2 somewhere  in  the  n1-character string  beginning  at  addr1.  Return  the last+1 character address addr3 of the match  point and a flag which is zero if a match exists. | |
| -TEXT | addr1 n1 addr2 -- n2 | | | Compare two strings over the length n1 beginning at addr1  and addr2.   Return  zero if the strings are equal.   If  unequal, return n2, the  difference  between  the  last  characters compared:  addr1(i) - addr2(i) | |
| .R | n1 n2 -- | | | Print n1 right aligned in a field of n2 characters,  according to  BASE. If  n2  is less than  1,  no  leading  blanks  are supplied. | |
| /LOOP | n -- | | | A DO-LOOP terminating word.   The loop index is incremented by the  unsigned  magnitude  of n.   Until  the  resultant  index exceeds  the  limit,  execution  returns  to  just  after  the corresponding   DO:   otherwise,   the  index  and  limit  are discarded.  Magnitude logic is used. | |
| 1+! | addr -- | | | Add one to the 16-bit contents at addr. | |
| 1-! | addr -- | | | Subtract 1 from the 16-bit contents at addr. | |
| 2* | n1 -- n2 | | | Leave 2*(n1). | |
| 2/ | n1 -- n2| | | Leave (n1)/2. | |
| ;: | | C | | Used to specify a new defining word:<br>: **name**  ...<br>;:   ...  ;<br>**name   namex**<br>When **name** is executed, it creates an entry for the new  word **namex**.  Later execution of **namex** will execute the sequence of  words between  ;:  and  ; , with the address of the  first (if any) parameters associated with **namex** on the stack. | |
| ;S | | | | Stop interpretation of a block.  For execution only. | |
| <> | n1 n2 -- flag | | | Leave true if n1 is not equal to n2. | |
| <BUILDS | | C | | Used in conjunction with DOES> in defining words, in the form:<br>: **name**  . . .  <BUILDS  . . .<br>DOES>  ...    ;<br>and then  **name  namex**<br>When  <name> executes, <BUILDS creates a dictionary entry  for the  new **namex**.  The sequence of words between  <BUILDS  and DOES> established a parameter field for **namex**.  When **namex** is later executed, the sequence of words following DOES>  will be  executed, with the parameter field address of  **namex** on the data stack. | |
| <CMOVE | addr1 addr2 n -- | | | Copy  n bytes beginning at addr1 to addr2.   The move proceeds within the bytes from high memory toward low memory. | |
| >< | n1 -- n2 | | | Swap the high and low bytes within n1. | |
| >MOVE< | addr1 addr2 n -- | | | Move  n  bytes beginning at addr1 to the memory  beginning  at addr2.   During  this  move, the order of each  byte  pair  is reversed. | |
| @BITS | addr n1 -- n2 | | | Return the 16-bits at addr masked by n1. | |
| ABORT" | flag -- | I,C | | Used in a colon-definition in the form:<br>ABORT" stack empty"<br>If the flag is true,  print the following text,  till ".  Then execute ABORT. | |
| AGAIN | | I,C | | Effect  an  unconditional jump back to the start of  a  BEGIN-AGAIN loop. | |
| ASCII | -- char (executing)<br>-   (compiling) | I,C | | Leave  the  ASCII  character  value  of  the  next   non-blank character in the input stream.   If compiling, compile it as a literal, which will be later left when executed. | |
| ASHIFT | n1 n2 -- n3 | | | Shift  the  value  n1 arithemetically n2 bits left  if  n2  is positive,  shifting  zeros  into  the  least-significant bit positions.   If  n2 is negative, n1 is  shifted  right.   Sign extension is to be consistent with the processor's  arithmetic shift. | |
| B/BUF | -- 1024 | | | A constant leaving 1024, the number of bytes per block buffer. | |
| BELL | | | | Activate  a terminal bell or noise-maker as appropriate to the device in use. | |
| BL | -- n | | | Leave the ASCII character value for space (decimal 32). | |
|  BLANKS | addr n -- | | Working | Fill  an area of memory over n bytes with the value for  ASCII blank,  starting at addr.  If n is less than or equal to zero, take no action. | |
| C, | n -- | | | Store  the  low-order  8 bits of n at the  next  byte  in  the dictionary, advancing the dictionary pointer. | |
| CHAIN | | | | Used in the form:<br>CHAIN  **name**<br> Connect  the CURRENT vocabulary to all definitions that  might be  entered  into the vocabulary **name** in  the  future.   The CURRENT  vocabulary may not be FORTH or ASSEMBLER.  Any  given vocabulary may only be chained  once, but may be the object of any  number  of chainings.  For  example,  every  user-defined vocabulary may include the sequence:<br>CHAIN  FORTH | |
| COM | n1 -- n2 | | | Leave the one's complement of n1. | |
| CONTINUED | n -- | | | Continue  interpretation at block n. | |
| CUR | -- addr | | | A variable pointing to the physical record number before which the tape is currently positioned.  REWIND sets CUR=1. | |
| DBLOCK | d -- addr | | | Identical to  BLOCK  but with a 32-bit block unsigned number. | |
| DPL | -- addr | | | A   variable  containing  the  number  of  places  after   the fractional point for output conversion.  If DPL contains zero, the  last character output will be a decimal point.   No point is  output if DPL contains a negative value.   DPL may be  set explicitly,  or by certain output words,  but is unaffected by number input. | |
| DUMP | addr n -- | | | List the contents of n addresses at addr.  Each line of values may be preceded by the address of the first value. | |
| EDITOR | | I | | The  name  of  the  editor  vocabulary.   When  this  name  is executed, EDITOR is established as the CONTEXT vocabulary. | |
| END | | I,C | |  A synonym for UNTIL. | |
| ERASE | addr n -- | | Working | Fill  an area of memory over n bytes with zeros,  starting  at addr.  If n is zero or less, take no action. | |
| FLD | -- addr | | | A variable pointing to the field length reserved for a  number during output conversion. | |
| H. | n --| | | Output  n  as a hexadecimal integer with one  trailing  blank.  The current base is unchanged. | |
| HEX | -- | | | Set the numeric input-output conversion base to sixteen. | |
| I' | -- n | C | | Used within a colon-definition executed only from within a DO-LOOP to return the corresponding loop index. | |
| IFEND | | | | Terminate  a  conditional  interpretation  sequence  begun  by IFTRUE. | |
| IFTRUE | flag -- | | | Begin an <br>IFTRUE  ...  OTHERWISE  ...  IFEND<br>conditional sequence.  These conditional words operate like<br>IF  ...  ELSE  ...  THEN<br>except  that  they cannot be nested, and are to be  used  only during interpretation.  In conjunction with the words [ and  ] they  may  be  used  within  a  colon-definition  to   control compilation, although they are not to be compiled. | |
| INDEX | n1 n2 --  | | | Print  the first line of each screen over the range  {n1..n2}. This  displays  the first line of each screen of source  text, which conventionally contains a title. | |
| INTERPRET | | | | Begin interpretation at the character indexed by the  contents of  >IN  relative  to  the  block  number  contained  in  BLK, continuing  until  the  input stream  is  exhausted.   If  BLK  contains  zero,  interpret characters from the terminal  input buffer. | |
| K | -- n | C | | Within a nested DO-LOOP,  return the index of the second outer loop. | |
| LAST | -- addr | | | A variable containing the address of the beginning of the last dictionary  entry  made,  which may not yet be a  complete  or valid entry. | |
| LINE | n -- addr | | | Leave  the  address of the beginning of line n for the  screen whose number is contained in SCR.  The range of n is {0..15}. | |
| LINELOAD | n1 n2 -- | | | Begin interpretation at line n1 of screen n2. | |
| LOADS | n -- | | | A defining word used in the form:<br>n  LOADS   **name**<br>When **name** is subsequently executed, block n will be loaded. | |
| MAP0 | -- addr | | | A variable pointing to the first location in the tape map. | |
| MASK | n1 -- n2 | | | Leave a mask of n1 most significant bits if n1 is positive, or n least significant bits if n1 is negative. | |
| MS | n -- | | | Delay for approximately n milliseconds. | |
| NAND | n1 n2 -- n3 | | | The one's complement of the logical and of n1 and n2. | |
| NOR | n1 n2 -- n3 | | | The one's complement of the logical or of n1 and n2. | |
| NUMBER | addr -- n | | | Convert  the count and character string at addr,  to a  signed 32-bit integer, using the current base.  If numeric conversion is not possible,  an error condition exists.   The string  may contain a preceding negative sign. | |
| O. | n -- | | | Print n in octal format with one trailing blank.  The value in base is unaffected. | |
| OCTAL | | | | Set the number base to 8. | |
| OFFSET | -- addr | | | A  variable that contains the offset added to the block number on  the stack by BLOCK to determine the actual physical  block number.   The user must add any desired offset when  utilizing BUFFER. | |
| OTHERWISE | | | | An interpreter-level conditional word.  See IFTRUE. | |
| PAGE | | | | Clear the terminal screen or perform an action suitable to the output device currently active. | |
| READ-MAP | | | | Read   to   the  next  file  mark  on  tape   constructing   a correspondence  table  in memory (the map)  relating  physical block  position  to  logical block number.   The  tape  should normally  be rewound to its load point before executing  READ-MAP. | |
| REMEMBER | | | | A defining word used in the form:<br>REMEMBER **name**<br>Defines a word which, when executed, will cause **name** and all subsequently defined words to be deleted from the  dictionary.  **name**  may  be  compiled  into  and  executed  from  a  colon definition.  The sequence <br>DISCARD  REMEMBER  DISCARD<br>provides a standardized preface to any group of transient word definitions. | |
| REWIND | | | | Rewind the tape to its load point, setting CUR=1. | |
| ROTATE | n1 n2 -- n3 | | | Rotate  the value n1 left n2 bits if n2 is positive, right  n2 bits  if n2 is negative.  Bits shifted out of one end  of  the cell are shifted back in at the opposite end. | |
| S0 | -- addr | | | Returns the address of the bottom of the stack, when empty. | |
| SET | n addr -- | | | A defining word used  in the form:<br>n  addr  SET **name**<br>Defines  a  word **name** which, when executed, will  cause  the value  n  to be stored at address. | |
| SHIFT | n1 n2 -- n3 | | | Logical  shift  n1  left  n2  bits if  n2  in positive,  right if  n2  is  negative.  Zeros are  shifted  into  vacated  bit positions. | |
| SP@ | -- addr | | Working  | Return the address of the top of the stack, just before SP@ was executed | |
| TEXT | c -- | | | Accept  characters from the input stream,  as for  WORD,  into PAD, blank-filling the remainder of PAD to 64 characters. | |
| THRU | n1 n2 -- | | | Load consecutively the blocks from n1 through n2. | |
| U,R | un1 n2 -- | | | Output un1 as an unsigned number right justified in a field n2 characters  wide.   If  n2  is  smaller  than  the  characters required for n1, no leading spaces are given. | |
| USER | n -- | | | A defining word used in the form:<br>n  USER  **name**<br>which  creates a user variable **name**.   n is the cell  offset within  the  user area where the value for **name**  is  stored.  Execution  of  **name** leaves its absolute  user  area  storage address. | |
| VLIST | | | | List  the  word names of the CONTEXT vocabulary starting  with the most recent definition. | |
| WHERE | | | | Output information about the status of FORTH,  (e.g., after an error  abort).   Indicate at least the last word compiled  and the last block accessed. | |
| \LOOP | n -- | I, C | | A DO-LOOP terminating word.   The loop index is decremented by n  and  the loop terminated when the resultant  index  becomes equal to or less than the limit.  Magnitude logic is used, and n must be positive. | |

###Words from original implementation that should be removed (or perhaps are really renamed)

| Word | Syntax | I/C | Status | Description | Comment |
|-|-|-|-|-|-|
| -DUP | n -- n ? | RENAMED to ?DUP | Working | Duplicate only if non-zero |  **should be ?DUP** |
| R | -- n | | Working | Copy top of return stack onto stack |** really >R  maybe** |
| MINUS | n -- -n | RENAMED to NEGATE | Working | Change sign | **rename NEGATE** |
| DMINUS | d -- -d |RENAMED to DNEGATE | Working | Change sign of double-precision number | **rename DNEGATE**|
| ?TERMINAL | -- f | | | True if terminal break request present | |
| SIGN | 	( n d -- d | | | Insert sign of n to output string | |
| ENDIF | -- | | RENAMED to THEN | End of the IF-ELSE structure | **there is no ENDIF like statement in forth, i think maybe IFs are only in loops or DOs or create word type structure so there is other "terminating" words that tell you IF is done**|

## License
A2osX is licensed under the GNU General Pulic License |

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) | | | any later version |

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details |

The full A2osX license can be found **[Here](../LICENSE)** |

## Copyright

Copyright 2015 -- 2019, Remy Gibert and the A2osX contributors |
