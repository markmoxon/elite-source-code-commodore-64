; ******************************************************************************
;
; COMMODORE 64 ELITE GAME DATA SOURCE
;
; Commodore 64 Elite was written by Ian Bell and David Braben and is copyright
; D. Braben and I. Bell 1985
;
; The code in this file is identical to the source disks released on Ian Bell's
; personal website at http://www.elitehomepage.org/ (it's just been reformatted
; to be more readable)
;
; The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
; in the documentation are entirely my fault
;
; The terminology and notations used in this commentary are explained at
; https://elite.bbcelite.com/terminology
;
; The deep dive articles referred to in this commentary can be found at
; https://elite.bbcelite.com/deep_dives
;
; ------------------------------------------------------------------------------
;
; This source file contains the game data for Commodore 64 Elite, including the
; game text and ship blueprints.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary files:
;
;   * IANTOK.bin
;   * LODATA.bin
;   * WORDS.bin
;   * SHIPS.bin
;
; after reading in the following file:
;
;   * FONT.bin
;
; ******************************************************************************

 INCLUDE "1-source-files/main-sources/elite-build-options.asm"

 _GMA85_NTSC            = (_VARIANT = 1)
 _GMA86_PAL             = (_VARIANT = 2)
 _GMA_RELEASE           = (_VARIANT = 1) OR (_VARIANT = 2)
 _SOURCE_DISK_BUILD     = (_VARIANT = 3)
 _SOURCE_DISK_FILES     = (_VARIANT = 4)
 _SOURCE_DISK           = (_VARIANT = 3) OR (_VARIANT = 4)

; ******************************************************************************
;
; Configuration variables
;
; ******************************************************************************

 CODE% = $0700          ; The address where the code will be run

 LOAD% = $4000          ; The address where the code will be loaded

 D% = $D000             ; The address where the ship data will be loaded
                        ; (i.e. XX21)

 RE = $23               ; The obfuscation byte used to hide the recursive tokens
                        ; table from crackers viewing the binary code

 VE = $57               ; The obfuscation byte used to hide the extended tokens
                        ; table from crackers viewing the binary code

; ******************************************************************************
;
; ELITE RECURSIVE TEXT TOKEN FILE
;
; ******************************************************************************

 ORG CODE%              ; Set the assembly address to CODE%

.WORDS

; ******************************************************************************
;
;       Name: CHAR
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for characters in the recursive token table
;  Deep dive: Printing text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the recursive token table:
;
;   CHAR 'x'            Insert ASCII character "x"
;
; To include an apostrophe, use a backtick character, as in CHAR '`'.
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   'x'                 The character to insert into the table
;
; ******************************************************************************

MACRO CHAR x

 IF x = '`'
   EQUB 39 EOR RE
 ELSE
   EQUB x EOR RE
 ENDIF

ENDMACRO

; ******************************************************************************
;
;       Name: TWOK
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for two-letter tokens in the token table
;  Deep dive: Printing text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the recursive token table:
;
;   TWOK 'x', 'y'       Insert two-letter token "xy"
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   'x'                 The first letter of the two-letter token to insert into
;                       the table
;
;   'y'                 The second letter of the two-letter token to insert into
;                       the table
;
; ******************************************************************************

MACRO TWOK t, k

 IF t = 'A' AND k = 'L'
  EQUB 128 EOR RE
 ENDIF

 IF t = 'L' AND k = 'E'
  EQUB 129 EOR RE
 ENDIF

 IF t = 'X' AND k = 'E'
  EQUB 130 EOR RE
 ENDIF

 IF t = 'G' AND k = 'E'
  EQUB 131 EOR RE
 ENDIF

 IF t = 'Z' AND k = 'A'
  EQUB 132 EOR RE
 ENDIF

 IF t = 'C' AND k = 'E'
  EQUB 133 EOR RE
 ENDIF

 IF t = 'B' AND k = 'I'
  EQUB 134 EOR RE
 ENDIF

 IF t = 'S' AND k = 'O'
  EQUB 135 EOR RE
 ENDIF

 IF t = 'U' AND k = 'S'
  EQUB 136 EOR RE
 ENDIF

 IF t = 'E' AND k = 'S'
  EQUB 137 EOR RE
 ENDIF

 IF t = 'A' AND k = 'R'
  EQUB 138 EOR RE
 ENDIF

 IF t = 'M' AND k = 'A'
  EQUB 139 EOR RE
 ENDIF

 IF t = 'I' AND k = 'N'
  EQUB 140 EOR RE
 ENDIF

 IF t = 'D' AND k = 'I'
  EQUB 141 EOR RE
 ENDIF

 IF t = 'R' AND k = 'E'
  EQUB 142 EOR RE
 ENDIF

 IF t = 'A' AND k = '?'
  EQUB 143 EOR RE
 ENDIF

 IF t = 'E' AND k = 'R'
  EQUB 144 EOR RE
 ENDIF

 IF t = 'A' AND k = 'T'
  EQUB 145 EOR RE
 ENDIF

 IF t = 'E' AND k = 'N'
  EQUB 146 EOR RE
 ENDIF

 IF t = 'B' AND k = 'E'
  EQUB 147 EOR RE
 ENDIF

 IF t = 'R' AND k = 'A'
  EQUB 148 EOR RE
 ENDIF

 IF t = 'L' AND k = 'A'
  EQUB 149 EOR RE
 ENDIF

 IF t = 'V' AND k = 'E'
  EQUB 150 EOR RE
 ENDIF

 IF t = 'T' AND k = 'I'
  EQUB 151 EOR RE
 ENDIF

 IF t = 'E' AND k = 'D'
  EQUB 152 EOR RE
 ENDIF

 IF t = 'O' AND k = 'R'
  EQUB 153 EOR RE
 ENDIF

 IF t = 'Q' AND k = 'U'
  EQUB 154 EOR RE
 ENDIF

 IF t = 'A' AND k = 'N'
  EQUB 155 EOR RE
 ENDIF

 IF t = 'T' AND k = 'E'
  EQUB 156 EOR RE
 ENDIF

 IF t = 'I' AND k = 'S'
  EQUB 157 EOR RE
 ENDIF

 IF t = 'R' AND k = 'I'
  EQUB 158 EOR RE
 ENDIF

 IF t = 'O' AND k = 'N'
  EQUB 159 EOR RE
 ENDIF

ENDMACRO

; ******************************************************************************
;
;       Name: CONT
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for control codes in the recursive token table
;  Deep dive: Printing text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the recursive token table:
;
;   CONT n              Insert control code token {n}
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   n                   The control code to insert into the table
;
; ******************************************************************************

MACRO CONT n

 EQUB n EOR RE

ENDMACRO

; ******************************************************************************
;
;       Name: RTOK
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for recursive tokens in the recursive token table
;  Deep dive: Printing text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the recursive token table:
;
;   RTOK n              Insert recursive token [n]
;
;                         * Tokens 0-95 get stored as n + 160
;
;                         * Tokens 128-145 get stored as n - 114
;
;                         * Tokens 96-127 get stored as n
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   n                   The number of the recursive token to insert into the
;                       table, in the range 0 to 145
;
; ******************************************************************************

MACRO RTOK n

 IF n >= 0 AND n <= 95
  t = n + 160
 ELIF n >= 128
  t = n - 114
 ELSE
  t = n
 ENDIF

 EQUB t EOR RE

ENDMACRO

; ******************************************************************************
;
;       Name: QQ18
;       Type: Variable
;   Category: Text
;    Summary: The recursive token table for tokens 0-148
;  Deep dive: Printing text tokens
;
; ------------------------------------------------------------------------------
;
; The encodings shown for each recursive text token use the following notation:
;
;   {n}           Control code              n = 0 to 13
;   <n>           Two-letter token          n = 128 to 159
;   [n]           Recursive token           n = 0 to 148
;
; ******************************************************************************

.QQ18

 RTOK 111               ; Token 0:      "FUEL SCOOPS ON {beep}"
 RTOK 131               ;
 CONT 7                 ; Encoded as:   "[111][131]{7}"
 EQUB 0

 CHAR ' '               ; Token 1:      " CHART"
 CHAR 'C'               ;
 CHAR 'H'               ; Encoded as:   " CH<138>T"
 TWOK 'A', 'R'
 CHAR 'T'
 EQUB 0

 CHAR 'G'               ; Token 2:      "GOVERNMENT"
 CHAR 'O'               ;
 TWOK 'V', 'E'          ; Encoded as:   "GO<150>RNM<146>T"
 CHAR 'R'
 CHAR 'N'
 CHAR 'M'
 TWOK 'E', 'N'
 CHAR 'T'
 EQUB 0

 CHAR 'D'               ; Token 3:      "DATA ON {selected system name}"
 TWOK 'A', 'T'          ;
 CHAR 'A'               ; Encoded as:   "D<145>A[131]{3}"
 RTOK 131
 CONT 3
 EQUB 0

 TWOK 'I', 'N'          ; Token 4:      "INVENTORY{cr}
 TWOK 'V', 'E'          ;               "
 CHAR 'N'               ;
 CHAR 'T'               ; Encoded as:   "<140><150>NT<153>Y{12}"
 TWOK 'O', 'R'
 CHAR 'Y'
 CONT 12
 EQUB 0

 CHAR 'S'               ; Token 5:      "SYSTEM"
 CHAR 'Y'               ;
 CHAR 'S'               ; Encoded as:   "SYS<156>M"
 TWOK 'T', 'E'
 CHAR 'M'
 EQUB 0

 CHAR 'P'               ; Token 6:      "PRICE"
 TWOK 'R', 'I'          ;
 TWOK 'C', 'E'          ; Encoded as:   "P<158><133>"
 EQUB 0

 CONT 2                 ; Token 7:      "{current system name} MARKET PRICES"
 CHAR ' '               ;
 TWOK 'M', 'A'          ; Encoded as:   "{2} <139>RKET [6]S"
 CHAR 'R'
 CHAR 'K'
 CHAR 'E'
 CHAR 'T'
 CHAR ' '
 RTOK 6
 CHAR 'S'
 EQUB 0

 TWOK 'I', 'N'          ; Token 8:      "INDUSTRIAL"
 CHAR 'D'               ;
 TWOK 'U', 'S'          ; Encoded as:   "<140>D<136>T<158><128>"
 CHAR 'T'
 TWOK 'R', 'I'
 TWOK 'A', 'L'
 EQUB 0

 CHAR 'A'               ; Token 9:      "AGRICULTURAL"
 CHAR 'G'               ;
 TWOK 'R', 'I'          ; Encoded as:   "AG<158>CULTU<148>L"
 CHAR 'C'
 CHAR 'U'
 CHAR 'L'
 CHAR 'T'
 CHAR 'U'
 TWOK 'R', 'A'
 CHAR 'L'
 EQUB 0

 TWOK 'R', 'I'          ; Token 10:     "RICH "
 CHAR 'C'               ;
 CHAR 'H'               ; Encoded as:   "<158>CH "
 CHAR ' '
 EQUB 0

 CHAR 'A'               ; Token 11:     "AVERAGE "
 TWOK 'V', 'E'          ;
 TWOK 'R', 'A'          ; Encoded as:   "A<150><148><131> "
 TWOK 'G', 'E'
 CHAR ' '
 EQUB 0

 CHAR 'P'               ; Token 12:     "POOR "
 CHAR 'O'               ;
 TWOK 'O', 'R'          ; Encoded as:   "PO<153> "
 CHAR ' '
 EQUB 0

 TWOK 'M', 'A'          ; Token 13:     "MAINLY "
 TWOK 'I', 'N'          ;
 CHAR 'L'               ; Encoded as:   "<139><140>LY "
 CHAR 'Y'
 CHAR ' '
 EQUB 0

 CHAR 'U'               ; Token 14:     "UNIT"
 CHAR 'N'               ;
 CHAR 'I'               ; Encoded as:   "UNIT"
 CHAR 'T'
 EQUB 0

 CHAR 'V'               ; Token 15:     "VIEW "
 CHAR 'I'               ;
 CHAR 'E'               ; Encoded as:   "VIEW "
 CHAR 'W'
 CHAR ' '
 EQUB 0

 TWOK 'Q', 'U'          ; Token 16:     "QUANTITY"
 TWOK 'A', 'N'          ;
 TWOK 'T', 'I'          ; Encoded as:   "<154><155><151>TY"
 CHAR 'T'
 CHAR 'Y'
 EQUB 0

 TWOK 'A', 'N'          ; Token 17:     "ANARCHY"
 TWOK 'A', 'R'          ;
 CHAR 'C'               ; Encoded as:   "<155><138>CHY"
 CHAR 'H'
 CHAR 'Y'
 EQUB 0

 CHAR 'F'               ; Token 18:     "FEUDAL"
 CHAR 'E'               ;
 CHAR 'U'               ; Encoded as:   "FEUD<128>"
 CHAR 'D'
 TWOK 'A', 'L'
 EQUB 0

 CHAR 'M'               ; Token 19:     "MULTI-GOVERNMENT"
 CHAR 'U'               ;
 CHAR 'L'               ; Encoded as:   "MUL<151>-[2]"
 TWOK 'T', 'I'
 CHAR '-'
 RTOK 2
 EQUB 0

 TWOK 'D', 'I'          ; Token 20:     "DICTATORSHIP"
 CHAR 'C'               ;
 CHAR 'T'               ; Encoded as:   "<141>CT<145><153>[25]"
 TWOK 'A', 'T'
 TWOK 'O', 'R'
 RTOK 25
 EQUB 0

 RTOK 91                ; Token 21:     "COMMUNIST"
 CHAR 'M'               ;
 CHAR 'U'               ; Encoded as:   "[91]MUN<157>T"
 CHAR 'N'
 TWOK 'I', 'S'
 CHAR 'T'
 EQUB 0

 CHAR 'C'               ; Token 22:     "CONFEDERACY"
 TWOK 'O', 'N'          ;
 CHAR 'F'               ; Encoded as:   "C<159>F<152><144>ACY"
 TWOK 'E', 'D'
 TWOK 'E', 'R'
 CHAR 'A'
 CHAR 'C'
 CHAR 'Y'
 EQUB 0

 CHAR 'D'               ; Token 23:     "DEMOCRACY"
 CHAR 'E'               ;
 CHAR 'M'               ; Encoded as:   "DEMOC<148>CY"
 CHAR 'O'
 CHAR 'C'
 TWOK 'R', 'A'
 CHAR 'C'
 CHAR 'Y'
 EQUB 0

 CHAR 'C'               ; Token 24:     "CORPORATE STATE"
 TWOK 'O', 'R'          ;
 CHAR 'P'               ; Encoded as:   "C<153>P<153><145>E [43]<145>E"
 TWOK 'O', 'R'
 TWOK 'A', 'T'
 CHAR 'E'
 CHAR ' '
 RTOK 43
 TWOK 'A', 'T'
 CHAR 'E'
 EQUB 0

 CHAR 'S'               ; Token 25:     "SHIP"
 CHAR 'H'               ;
 CHAR 'I'               ; Encoded as:   "SHIP"
 CHAR 'P'
 EQUB 0

 CHAR 'P'               ; Token 26:     "PRODUCT"
 RTOK 94                ;
 CHAR 'D'               ; Encoded as:   "P[94]]DUCT"
 CHAR 'U'
 CHAR 'C'
 CHAR 'T'
 EQUB 0

 CHAR ' '               ; Token 27:     " LASER"
 TWOK 'L', 'A'          ;
 CHAR 'S'               ; Encoded as:   " <149>S<144>"
 TWOK 'E', 'R'
 EQUB 0

 CHAR 'H'               ; Token 28:     "HUMAN COLONIAL"
 CHAR 'U'               ;
 CHAR 'M'               ; Encoded as:   "HUM<155> COL<159>I<128>"
 TWOK 'A', 'N'
 CHAR ' '
 CHAR 'C'
 CHAR 'O'
 CHAR 'L'
 TWOK 'O', 'N'
 CHAR 'I'
 TWOK 'A', 'L'
 EQUB 0

 CHAR 'H'               ; Token 29:     "HYPERSPACE "
 CHAR 'Y'               ;
 CHAR 'P'               ; Encoded as:   "HYP<144>SPA<133> "
 TWOK 'E', 'R'
 CHAR 'S'
 CHAR 'P'
 CHAR 'A'
 TWOK 'C', 'E'
 CHAR ' '
 EQUB 0

 CHAR 'S'               ; Token 30:     "SHORT RANGE CHART"
 CHAR 'H'               ;
 TWOK 'O', 'R'          ; Encoded as:   "SH<153>T [42][1]"
 CHAR 'T'
 CHAR ' '
 RTOK 42
 RTOK 1
 EQUB 0

 TWOK 'D', 'I'          ; Token 31:     "DISTANCE"
 RTOK 43                ;
 TWOK 'A', 'N'          ; Encoded as:   "<141>[43]<155><133>"
 TWOK 'C', 'E'
 EQUB 0

 CHAR 'P'               ; Token 32:     "POPULATION"
 CHAR 'O'               ;
 CHAR 'P'               ; Encoded as:   "POPUL<145>I<159>"
 CHAR 'U'
 CHAR 'L'
 TWOK 'A', 'T'
 CHAR 'I'
 TWOK 'O', 'N'
 EQUB 0

 CHAR 'G'               ; Token 33:     "GROSS PRODUCTIVITY"
 RTOK 94                ;
 CHAR 'S'               ; Encoded as:   "G[94]SS [26]IVITY"
 CHAR 'S'
 CHAR ' '
 RTOK 26
 CHAR 'I'
 CHAR 'V'
 CHAR 'I'
 CHAR 'T'
 CHAR 'Y'
 EQUB 0

 CHAR 'E'               ; Token 34:     "ECONOMY"
 CHAR 'C'               ;
 TWOK 'O', 'N'          ; Encoded as:   "EC<159>OMY"
 CHAR 'O'
 CHAR 'M'
 CHAR 'Y'
 EQUB 0

 CHAR ' '               ; Token 35:     " LIGHT YEARS"
 CHAR 'L'               ;
 CHAR 'I'               ; Encoded as:   " LIGHT YE<138>S"
 CHAR 'G'
 CHAR 'H'
 CHAR 'T'
 CHAR ' '
 CHAR 'Y'
 CHAR 'E'
 TWOK 'A', 'R'
 CHAR 'S'
 EQUB 0

 TWOK 'T', 'E'          ; Token 36:     "TECH.LEVEL"
 CHAR 'C'               ;
 CHAR 'H'               ; Encoded as:   "<156>CH.<129><150>L"
 CHAR '.'
 TWOK 'L', 'E'
 TWOK 'V', 'E'
 CHAR 'L'
 EQUB 0

 CHAR 'C'               ; Token 37:     "CASH"
 CHAR 'A'               ;
 CHAR 'S'               ; Encoded as:   "CASH"
 CHAR 'H'
 EQUB 0

 CHAR ' '               ; Token 38:     " BILLION"
 TWOK 'B', 'I'          ;
 RTOK 129               ; Encoded as:   " <134>[129]I<159>"
 CHAR 'I'
 TWOK 'O', 'N'
 EQUB 0

 RTOK 122               ; Token 39:     "GALACTIC CHART{galaxy number}"
 RTOK 1                 ;
 CONT 1                 ; Encoded as:   "[122][1]{1}"
 EQUB 0

 CHAR 'T'               ; Token 40:     "TARGET LOST"
 TWOK 'A', 'R'          ;
 TWOK 'G', 'E'          ; Encoded as:   "T<138><131>T LO[43]"
 CHAR 'T'
 CHAR ' '
 CHAR 'L'
 CHAR 'O'
 RTOK 43
 EQUB 0

 RTOK 106               ; Token 41:     "MISSILE JAMMED"
 CHAR ' '               ;
 CHAR 'J'               ; Encoded as:   "[106] JAMM<152>"
 CHAR 'A'
 CHAR 'M'
 CHAR 'M'
 TWOK 'E', 'D'
 EQUB 0

 CHAR 'R'               ; Token 42:     "RANGE"
 TWOK 'A', 'N'          ;
 TWOK 'G', 'E'          ; Encoded as:   "R<155><131>"
 EQUB 0

 CHAR 'S'               ; Token 43:     "ST"
 CHAR 'T'               ;
 EQUB 0                 ; Encoded as:   "ST"

 RTOK 16                ; Token 44:     "QUANTITY OF "
 CHAR ' '               ;
 CHAR 'O'               ; Encoded as:   "[16] OF "
 CHAR 'F'
 CHAR ' '
 EQUB 0

 CHAR 'S'               ; Token 45:     "SELL"
 CHAR 'E'               ;
 RTOK 129               ; Encoded as:   "SE[129]"
 EQUB 0

 CHAR ' '               ; Token 46:     " CARGO{sentence case}"
 CHAR 'C'               ;
 TWOK 'A', 'R'          ; Encoded as:   " C<138>GO{6}"
 CHAR 'G'
 CHAR 'O'
 CONT 6
 EQUB 0

 CHAR 'E'               ; Token 47:     "EQUIP"
 TWOK 'Q', 'U'          ;
 CHAR 'I'               ; Encoded as:   "E<154>IP"
 CHAR 'P'
 EQUB 0

 CHAR 'F'               ; Token 48:     "FOOD"
 CHAR 'O'               ;
 CHAR 'O'               ; Encoded as:   "FOOD"
 CHAR 'D'
 EQUB 0

 TWOK 'T', 'E'          ; Token 49:     "TEXTILES"
 CHAR 'X'               ;
 TWOK 'T', 'I'          ; Encoded as:   "<156>X<151>L<137>"
 CHAR 'L'
 TWOK 'E', 'S'
 EQUB 0

 TWOK 'R', 'A'          ; Token 50:     "RADIOACTIVES"
 TWOK 'D', 'I'          ;
 CHAR 'O'               ; Encoded as:   "<148><141>OAC<151><150>S"
 CHAR 'A'
 CHAR 'C'
 TWOK 'T', 'I'
 TWOK 'V', 'E'
 CHAR 'S'
 EQUB 0

 CHAR 'S'               ; Token 51:     "SLAVES"
 TWOK 'L', 'A'          ;
 TWOK 'V', 'E'          ; Encoded as:   "S<149><150>S"
 CHAR 'S'
 EQUB 0

 CHAR 'L'               ; Token 52:     "LIQUOR/WINES"
 CHAR 'I'               ;
 TWOK 'Q', 'U'          ; Encoded as:   "LI<154><153>/W<140><137>"
 TWOK 'O', 'R'
 CHAR '/'
 CHAR 'W'
 TWOK 'I', 'N'
 TWOK 'E', 'S'
 EQUB 0

 CHAR 'L'               ; Token 53:     "LUXURIES"
 CHAR 'U'               ;
 CHAR 'X'               ; Encoded as:   "LUXU<158><137>"
 CHAR 'U'
 TWOK 'R', 'I'
 TWOK 'E', 'S'
 EQUB 0

 CHAR 'N'               ; Token 54:     "NARCOTICS"
 TWOK 'A', 'R'          ;
 CHAR 'C'               ; Encoded as:   "N<138>CO<151>CS"
 CHAR 'O'
 TWOK 'T', 'I'
 CHAR 'C'
 CHAR 'S'
 EQUB 0

 RTOK 91                ; Token 55:     "COMPUTERS"
 CHAR 'P'               ;
 CHAR 'U'               ; Encoded as:   "[91]PUT<144>S"
 CHAR 'T'
 TWOK 'E', 'R'
 CHAR 'S'
 EQUB 0

 TWOK 'M', 'A'          ; Token 56:     "MACHINERY"
 CHAR 'C'               ;
 CHAR 'H'               ; Encoded as:   "<139>CH<140><144>Y"
 TWOK 'I', 'N'
 TWOK 'E', 'R'
 CHAR 'Y'
 EQUB 0

 CHAR 'A'               ; Token 57:     "ALLOYS"
 CHAR 'L'               ;
 CHAR 'L'               ; Encoded as:   "ALLOYS"
 CHAR 'O'
 CHAR 'Y'
 CHAR 'S'
 EQUB 0

 CHAR 'F'               ; Token 58:     "FIREARMS"
 CHAR 'I'               ;
 TWOK 'R', 'E'          ; Encoded as:   "FI<142><138>MS"
 TWOK 'A', 'R'
 CHAR 'M'
 CHAR 'S'
 EQUB 0

 CHAR 'F'               ; Token 59:     "FURS"
 CHAR 'U'               ;
 CHAR 'R'               ; Encoded as:   "FURS"
 CHAR 'S'
 EQUB 0

 CHAR 'M'               ; Token 60:     "MINERALS"
 TWOK 'I', 'N'          ;
 TWOK 'E', 'R'          ; Encoded as:   "M<140><144><128>S"
 TWOK 'A', 'L'
 CHAR 'S'
 EQUB 0

 CHAR 'G'               ; Token 61:     "GOLD"
 CHAR 'O'               ;
 CHAR 'L'               ; Encoded as:   "GOLD"
 CHAR 'D'
 EQUB 0

 CHAR 'P'               ; Token 62:     "PLATINUM"
 CHAR 'L'               ;
 TWOK 'A', 'T'          ; Encoded as:   "PL<145><140>UM"
 TWOK 'I', 'N'
 CHAR 'U'
 CHAR 'M'
 EQUB 0

 TWOK 'G', 'E'          ; Token 63:     "GEM-STONES"
 CHAR 'M'               ;
 CHAR '-'               ; Encoded as:   "<131>M-[43]<159><137>"
 RTOK 43
 TWOK 'O', 'N'
 TWOK 'E', 'S'
 EQUB 0

 TWOK 'A', 'L'          ; Token 64:     "ALIEN ITEMS"
 CHAR 'I'               ;
 TWOK 'E', 'N'          ; Encoded as:   "<128>I<146> [127]S"
 CHAR ' '
 RTOK 127
 CHAR 'S'
 EQUB 0

 CONT 12                ; Token 65:     "{cr}
 CHAR '1'               ;                10{cash} CR{cr}
 CHAR '0'               ;                5{cash} CR{cr}
 CONT 0                 ;               "
 CHAR '5'               ;
 CONT 0                 ; Encoded as:   "{12}10{0}5{0}"
 EQUB 0

 CHAR ' '               ; Token 66:     " CR"
 CHAR 'C'               ;
 CHAR 'R'               ; Encoded as:   " CR"
 EQUB 0

 CHAR 'L'               ; Token 67:     "LARGE"
 TWOK 'A', 'R'          ;
 TWOK 'G', 'E'          ; Encoded as:   "L<138><131>"
 EQUB 0

 CHAR 'F'               ; Token 68:     "FIERCE"
 CHAR 'I'               ;
 TWOK 'E', 'R'          ; Encoded as:   "FI<144><133>"
 TWOK 'C', 'E'
 EQUB 0

 CHAR 'S'               ; Token 69:     "SMALL"
 TWOK 'M', 'A'          ;
 RTOK 129               ; Encoded as:   "S<139>[129]"
 EQUB 0

 CHAR 'G'               ; Token 70:     "GREEN"
 TWOK 'R', 'E'          ;
 TWOK 'E', 'N'          ; Encoded as:   "G<142><146>"
 EQUB 0

 CHAR 'R'               ; Token 71:     "RED"
 TWOK 'E', 'D'          ;
 EQUB 0                 ; Encoded as:   "R<152>"

 CHAR 'Y'               ; Token 72:     "YELLOW"
 CHAR 'E'               ;
 RTOK 129               ; Encoded as:   "YE[129]OW"
 CHAR 'O'
 CHAR 'W'
 EQUB 0

 CHAR 'B'               ; Token 73:     "BLUE"
 CHAR 'L'               ;
 CHAR 'U'               ; Encoded as:   "BLUE"
 CHAR 'E'
 EQUB 0

 CHAR 'B'               ; Token 74:     "BLACK"
 TWOK 'L', 'A'          ;
 CHAR 'C'               ; Encoded as:   "B<149>CK"
 CHAR 'K'
 EQUB 0

 RTOK 136               ; Token 75:     "HARMLESS"
 EQUB 0                 ;
                        ; Encoded as:   "[136]"

 CHAR 'S'               ; Token 76:     "SLIMY"
 CHAR 'L'               ;
 CHAR 'I'               ; Encoded as:   "SLIMY"
 CHAR 'M'
 CHAR 'Y'
 EQUB 0

 CHAR 'B'               ; Token 77:     "BUG-EYED"
 CHAR 'U'               ;
 CHAR 'G'               ; Encoded as:   "BUG-EY<152>"
 CHAR '-'
 CHAR 'E'
 CHAR 'Y'
 TWOK 'E', 'D'
 EQUB 0

 CHAR 'H'               ; Token 78:     "HORNED"
 TWOK 'O', 'R'          ;
 CHAR 'N'               ; Encoded as:   "H<153>N<152>"
 TWOK 'E', 'D'
 EQUB 0

 CHAR 'B'               ; Token 79:     "BONY"
 TWOK 'O', 'N'          ;
 CHAR 'Y'               ; Encoded as:   "B<159>Y"
 EQUB 0

 CHAR 'F'               ; Token 80:     "FAT"
 TWOK 'A', 'T'          ;
 EQUB 0                 ; Encoded as:   "F<145>"

 CHAR 'F'               ; Token 81:     "FURRY"
 CHAR 'U'               ;
 CHAR 'R'               ; Encoded as:   "FURRY"
 CHAR 'R'
 CHAR 'Y'
 EQUB 0

 RTOK 94                ; Token 82:     "RODENT"
 CHAR 'D'               ;
 TWOK 'E', 'N'          ; Encoded as:   "[94]D<146>T"
 CHAR 'T'
 EQUB 0

 CHAR 'F'               ; Token 83:     "FROG"
 RTOK 94                ;
 CHAR 'G'               ; Encoded as:   "F[94]G"
 EQUB 0

 CHAR 'L'               ; Token 84:     "LIZARD"
 CHAR 'I'               ;
 TWOK 'Z', 'A'          ; Encoded as:   "LI<132>RD"
 CHAR 'R'
 CHAR 'D'
 EQUB 0

 CHAR 'L'               ; Token 85:     "LOBSTER"
 CHAR 'O'               ;
 CHAR 'B'               ; Encoded as:   "LOB[43]<144>"
 RTOK 43
 TWOK 'E', 'R'
 EQUB 0

 TWOK 'B', 'I'          ; Token 86:     "BIRD"
 CHAR 'R'               ;
 CHAR 'D'               ; Encoded as:   "<134>RD"
 EQUB 0

 CHAR 'H'               ; Token 87:     "HUMANOID"
 CHAR 'U'               ;
 CHAR 'M'               ; Encoded as:   "HUM<155>OID"
 TWOK 'A', 'N'
 CHAR 'O'
 CHAR 'I'
 CHAR 'D'
 EQUB 0

 CHAR 'F'               ; Token 88:     "FELINE"
 CHAR 'E'               ;
 CHAR 'L'               ; Encoded as:   "FEL<140>E"
 TWOK 'I', 'N'
 CHAR 'E'
 EQUB 0

 TWOK 'I', 'N'          ; Token 89:     "INSECT"
 CHAR 'S'               ;
 CHAR 'E'               ; Encoded as:   "<140>SECT"
 CHAR 'C'
 CHAR 'T'
 EQUB 0

 RTOK 11                ; Token 90:     "AVERAGE RADIUS"
 TWOK 'R', 'A'          ;
 TWOK 'D', 'I'          ; Encoded as:   "[11]<148><141><136>"
 TWOK 'U', 'S'
 EQUB 0

 CHAR 'C'               ; Token 91:     "COM"
 CHAR 'O'               ;
 CHAR 'M'               ; Encoded as:   "COM"
 EQUB 0

 RTOK 91                ; Token 92:     "COMMANDER"
 CHAR 'M'               ;
 TWOK 'A', 'N'          ; Encoded as:   "[91]M<155>D<144>"
 CHAR 'D'
 TWOK 'E', 'R'
 EQUB 0

 CHAR ' '               ; Token 93:     " DESTROYED"
 CHAR 'D'               ;
 TWOK 'E', 'S'          ; Encoded as:   " D<137>T[94]Y<152>"
 CHAR 'T'
 RTOK 94
 CHAR 'Y'
 TWOK 'E', 'D'
 EQUB 0

 CHAR 'R'               ; Token 94:     "RO"
 CHAR 'O'               ;
 EQUB 0                 ; Encoded as:   "RO"

 RTOK 14                ; Token 95:     "UNIT  QUANTITY{cr}
 CHAR ' '               ;                 PRODUCT   UNIT PRICE FOR SALE{cr}{lf}
 CHAR ' '               ;               "
 RTOK 16                ;
 CONT 12                ; Encoded as:   "[14]  [16]{13} [26]   [14] [6] F<153>
 CHAR ' '               ;                 SA<129>{12}{10}"
 RTOK 26
 CHAR ' '
 CHAR ' '
 CHAR ' '
 RTOK 14
 CHAR ' '
 RTOK 6
 CHAR ' '
 CHAR 'F'
 TWOK 'O', 'R'
 CHAR ' '
 CHAR 'S'
 CHAR 'A'
 TWOK 'L', 'E'
 CONT 12
 CONT 10
 EQUB 0

 CHAR 'F'               ; Token 96:     "FRONT"
 CHAR 'R'               ;
 TWOK 'O', 'N'          ; Encoded as:   "FR<159>T"
 CHAR 'T'
 EQUB 0

 TWOK 'R', 'E'          ; Token 97:     "REAR"
 TWOK 'A', 'R'          ;
 EQUB 0                 ; Encoded as:   "<142><138>"

 TWOK 'L', 'E'          ; Token 98:     "LEFT"
 CHAR 'F'               ;
 CHAR 'T'               ; Encoded as:   "<129>FT"
 EQUB 0

 TWOK 'R', 'I'          ; Token 99:     "RIGHT"
 CHAR 'G'               ;
 CHAR 'H'               ; Encoded as:   "<158>GHT"
 CHAR 'T'
 EQUB 0

 RTOK 121               ; Token 100:    "ENERGY LOW{beep}"
 CHAR 'L'               ;
 CHAR 'O'               ; Encoded as:   "[121]LOW{7}"
 CHAR 'W'
 CONT 7
 EQUB 0

 RTOK 99                ; Token 101:    "RIGHT ON COMMANDER!"
 RTOK 131               ;
 RTOK 92                ; Encoded as:   "[99][131][92]!"
 CHAR '!'
 EQUB 0

 CHAR 'E'               ; Token 102:    "EXTRA "
 CHAR 'X'               ;
 CHAR 'T'               ; Encoded as:   "EXT<148> "
 TWOK 'R', 'A'
 CHAR ' '
 EQUB 0

 CHAR 'P'               ; Token 103:    "PULSE LASER"
 CHAR 'U'               ;
 CHAR 'L'               ; Encoded as:   "PULSE[27]"
 CHAR 'S'
 CHAR 'E'
 RTOK 27
 EQUB 0

 TWOK 'B', 'E'          ; Token 104:    "BEAM LASER"
 CHAR 'A'               ;
 CHAR 'M'               ; Encoded as:   "<147>AM[27]"
 RTOK 27
 EQUB 0

 CHAR 'F'               ; Token 105:    "FUEL"
 CHAR 'U'               ;
 CHAR 'E'               ; Encoded as:   "FUEL"
 CHAR 'L'
 EQUB 0

 CHAR 'M'               ; Token 106:    "MISSILE"
 TWOK 'I', 'S'          ;
 CHAR 'S'               ; Encoded as:   "M<157>SI<129>"
 CHAR 'I'
 TWOK 'L', 'E'
 EQUB 0

 RTOK 67                ; Token 107:    "LARGE CARGO{sentence case} BAY"
 RTOK 46                ;
 CHAR ' '               ; Encoded as:   "[67][46] BAY"
 CHAR 'B'
 CHAR 'A'
 CHAR 'Y'
 EQUB 0

 CHAR 'E'               ; Token 108:    "E.C.M.SYSTEM"
 CHAR '.'               ;
 CHAR 'C'               ; Encoded as:   "E.C.M.[5]"
 CHAR '.'
 CHAR 'M'
 CHAR '.'
 RTOK 5
 EQUB 0

 RTOK 102               ; Token 109:    "EXTRA PULSE LASERS"
 RTOK 103               ;
 CHAR 'S'               ; Encoded as:   "[102][103]S"
 EQUB 0

 RTOK 102               ; Token 110:    "EXTRA BEAM LASERS"
 RTOK 104               ;
 CHAR 'S'               ; Encoded as:   "[102][104]S"
 EQUB 0

 RTOK 105               ; Token 111:    "FUEL SCOOPS"
 CHAR ' '               ;
 CHAR 'S'               ; Encoded as:   "[105] SCOOPS"
 CHAR 'C'
 CHAR 'O'
 CHAR 'O'
 CHAR 'P'
 CHAR 'S'
 EQUB 0

 TWOK 'E', 'S'          ; Token 112:    "ESCAPE POD"
 CHAR 'C'               ;
 CHAR 'A'               ; Encoded as:   "<137>CAPE POD"
 CHAR 'P'
 CHAR 'E'
 CHAR ' '
 CHAR 'P'
 CHAR 'O'
 CHAR 'D'
 EQUB 0

 RTOK 121               ; Token 113:    "ENERGY BOMB"
 CHAR 'B'               ;
 CHAR 'O'               ; Encoded as:   "[121]BOMB"
 CHAR 'M'
 CHAR 'B'
 EQUB 0

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 RTOK 102               ; Token 114:    "EXTRA ENERGY UNIT"
 RTOK 121               ;
 RTOK 14                ; Encoded as:   "[102][121][14]"
 EQUB 0

ELIF _SOURCE_DISK_BUILD

 RTOK 121               ; Token 114:    "ENERGY UNIT"
 RTOK 14                ;
 EQUB 0                 ; Encoded as:   "[121][14]"

ENDIF

 CHAR 'D'               ; Token 115:    "DOCKING COMPUTERS"
 CHAR 'O'               ;
 CHAR 'C'               ; Encoded as:   "DOCK<140>G [55]"
 CHAR 'K'
 TWOK 'I', 'N'
 CHAR 'G'
 CHAR ' '
 RTOK 55
 EQUB 0

 RTOK 122               ; Token 116:    "GALACTIC HYPERSPACE "
 CHAR ' '               ;
 RTOK 29                ; Encoded as:   "[122] [29]"
 EQUB 0

 CHAR 'M'               ; Token 117:    "MILITARY  LASER"
 CHAR 'I'               ;
 CHAR 'L'               ; Encoded as:   "MILIT<138>Y [27]"
 CHAR 'I'
 CHAR 'T'
 TWOK 'A', 'R'
 CHAR 'Y'
 CHAR ' '
 RTOK 27
 EQUB 0

 CHAR 'M'               ; Token 118:    "MINING  LASER"
 TWOK 'I', 'N'          ;
 TWOK 'I', 'N'          ; Encoded as:   "M<140><140>G [27]"
 CHAR 'G'
 CHAR ' '
 RTOK 27
 EQUB 0

 RTOK 37                ; Token 119:    "CASH:{cash} CR{cr}
 CHAR ':'               ;               "
 CONT 0                 ;
 EQUB 0                 ; Encoded as:   "[37]:{0}"

 TWOK 'I', 'N'          ; Token 120:    "INCOMING MISSILE"
 RTOK 91                ;
 TWOK 'I', 'N'          ; Encoded as:   "<140>[91]<140>G [106]"
 CHAR 'G'
 CHAR ' '
 RTOK 106
 EQUB 0

 TWOK 'E', 'N'          ; Token 121:    "ENERGY "
 TWOK 'E', 'R'          ;
 CHAR 'G'               ; Encoded as:   "<146><144>GY "
 CHAR 'Y'
 CHAR ' '
 EQUB 0

 CHAR 'G'               ; Token 122:    "GALACTIC"
 CHAR 'A'               ;
 TWOK 'L', 'A'          ; Encoded as:   "GA<149>C<151>C"
 CHAR 'C'
 TWOK 'T', 'I'
 CHAR 'C'
 EQUB 0

 RTOK 115               ; Token 123:    "DOCKING COMPUTERS ON"
 CHAR ' '               ;
 CHAR 'O'               ; Encoded as:   "[115] ON"
 CHAR 'N'
 EQUB 0

 CHAR 'A'               ; Token 124:    "ALL"
 RTOK 129               ;
 EQUB 0                 ; Encoded as:   "A[129]"

 CONT 5                 ; Token 125:    "FUEL: {fuel level} LIGHT YEARS{cr}
 TWOK 'L', 'E'          ;                CASH:{cash} CR{cr}
 CHAR 'G'               ;                LEGAL STATUS:"
 TWOK 'A', 'L'          ;
 CHAR ' '               ; Encoded as:   "{5}<129>G<128> [43]<145><136>:"
 RTOK 43
 TWOK 'A', 'T'
 TWOK 'U', 'S'
 CHAR ':'
 EQUB 0

 RTOK 92                ; Token 126:    "COMMANDER {commander name}{cr}
 CHAR ' '               ;                {cr}
 CONT 4                 ;                {cr}
 CONT 12                ;                {sentence case}PRESENT SYSTEM{tab to
 CONT 12                ;                column 21}:{current system name}{cr}
 CONT 12                ;                HYPERSPACE SYSTEM{tab to column 21}:
 CONT 6                 ;                {selected system name}{cr}
 RTOK 145               ;                CONDITION{tab to column 21}:"
 CHAR ' '               ;
 RTOK 5                 ; Encoded as:   "[92] {4}{12}{12}{12}{6}[145] [5]{9}{2}
 CONT 9                 ;                {12}[29][5]{9}{3}{13}C<159><141><151>
 CONT 2                 ;                <159>{9}"
 CONT 12
 RTOK 29
 RTOK 5
 CONT 9
 CONT 3
 CONT 12
 CHAR 'C'
 TWOK 'O', 'N'
 TWOK 'D', 'I'
 TWOK 'T', 'I'
 TWOK 'O', 'N'
 CONT 9
 EQUB 0

 CHAR 'I'               ; Token 127:    "ITEM"
 TWOK 'T', 'E'          ;
 CHAR 'M'               ; Encoded as:   "I<156>M"
 EQUB 0

 EQUB 0                 ; Token 128:    ""
                        ;
                        ; Encoded as:   ""

 CHAR 'L'               ; Token 129:    "LL"
 CHAR 'L'               ;
 EQUB 0                 ; Encoded as:   "LL"

 TWOK 'R', 'A'          ; Token 130:    "RATING:"
 TWOK 'T', 'I'          ;
 CHAR 'N'               ; Encoded as:   "<148><151>NG:"
 CHAR 'G'
 CHAR ':'
 EQUB 0

 CHAR ' '               ; Token 131:    " ON "
 TWOK 'O', 'N'          ;
 CHAR ' '               ; Encoded as:   " <159> "
 EQUB 0

 CONT 12                ; Token 132:    "{cr}
 CONT 8                 ;                {all caps}EQUIPMENT: {sentence case}"
 RTOK 47                ;
 CHAR 'M'               ; Encoded as:   "{12}{8}[47]M<146>T:{6}"
 TWOK 'E', 'N'
 CHAR 'T'
 CHAR ':'
 CONT 6
 EQUB 0

 CHAR 'C'               ; Token 133:    "CLEAN"
 TWOK 'L', 'E'          ;
 TWOK 'A', 'N'          ; Encoded as:   "C<129><155>"
 EQUB 0

 CHAR 'O'               ; Token 134:    "OFFENDER"
 CHAR 'F'               ;
 CHAR 'F'               ; Encoded as:   "OFF<146>D<144>"
 TWOK 'E', 'N'
 CHAR 'D'
 TWOK 'E', 'R'
 EQUB 0

 CHAR 'F'               ; Token 135:    "FUGITIVE"
 CHAR 'U'               ;
 CHAR 'G'               ; Encoded as:   "FUGI<151><150>"
 CHAR 'I'
 TWOK 'T', 'I'
 TWOK 'V', 'E'
 EQUB 0

 CHAR 'H'               ; Token 136:    "HARMLESS"
 TWOK 'A', 'R'          ;
 CHAR 'M'               ; Encoded as:   "H<138>M<129>SS"
 TWOK 'L', 'E'
 CHAR 'S'
 CHAR 'S'
 EQUB 0

 CHAR 'M'               ; Token 137:    "MOSTLY HARMLESS"
 CHAR 'O'               ;
 RTOK 43                ; Encoded as:   "MO[43]LY [136]"
 CHAR 'L'
 CHAR 'Y'
 CHAR ' '
 RTOK 136
 EQUB 0

 RTOK 12                ; Token 138:    "POOR "
 EQUB 0                 ;
                        ; Encoded as:   "[12]"

 RTOK 11                ; Token 139:    "AVERAGE "
 EQUB 0                 ;
                        ; Encoded as:   "[11]"

 CHAR 'A'               ; Token 140:    "ABOVE AVERAGE "
 CHAR 'B'               ;
 CHAR 'O'               ; Encoded as:   "ABO<150> [11]"
 TWOK 'V', 'E'
 CHAR ' '
 RTOK 11
 EQUB 0

 RTOK 91                ; Token 141:    "COMPETENT"
 CHAR 'P'               ;
 CHAR 'E'               ; Encoded as:   "[91]PET<146>T"
 CHAR 'T'
 TWOK 'E', 'N'
 CHAR 'T'
 EQUB 0

 CHAR 'D'               ; Token 142:    "DANGEROUS"
 TWOK 'A', 'N'          ;
 TWOK 'G', 'E'          ; Encoded as:   "D<155><131>[94]<136>"
 RTOK 94
 TWOK 'U', 'S'
 EQUB 0

 CHAR 'D'               ; Token 143:    "DEADLY"
 CHAR 'E'               ;
 CHAR 'A'               ; Encoded as:   "DEADLY"
 CHAR 'D'
 CHAR 'L'
 CHAR 'Y'
 EQUB 0

 CHAR '-'               ; Token 144:    "---- E L I T E ----"
 CHAR '-'               ;
 CHAR '-'               ; Encoded as:   "---- E L I T E ----"
 CHAR '-'
 CHAR ' '
 CHAR 'E'
 CHAR ' '
 CHAR 'L'
 CHAR ' '
 CHAR 'I'
 CHAR ' '
 CHAR 'T'
 CHAR ' '
 CHAR 'E'
 CHAR ' '
 CHAR '-'
 CHAR '-'
 CHAR '-'
 CHAR '-'
 EQUB 0

 CHAR 'P'               ; Token 145:    "PRESENT"
 TWOK 'R', 'E'          ;
 CHAR 'S'               ; Encoded as:   "P<142>S<146>T"
 TWOK 'E', 'N'
 CHAR 'T'
 EQUB 0

 CONT 8                 ; Token 146:    "{all caps}GAME OVER"
 CHAR 'G'               ;
 CHAR 'A'               ; Encoded as:   "{8}GAME O<150>R"
 CHAR 'M'
 CHAR 'E'
 CHAR ' '
 CHAR 'O'
 TWOK 'V', 'E'
 CHAR 'R'
 EQUB 0

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 SKIP 4                 ; These bytes appear to be unused

ELIF _SOURCE_DISK_BUILD

 SKIP 5                 ; These bytes appear to be unused

ENDIF

; ******************************************************************************
;
;       Name: SNE
;       Type: Variable
;   Category: Maths (Geometry)
;    Summary: Sine/cosine table
;  Deep dive: The sine, cosine and arctan tables
;             Drawing circles
;             Drawing ellipses
;
; ------------------------------------------------------------------------------
;
; This lookup table contains sine values for the first half of a circle, from 0
; to 180 degrees (0 to PI radians). In terms of circle or ellipse line segments,
; there are 64 segments in a circle, so this contains sine values for segments
; 0 to 31.
;
; In terms of segments, to calculate the sine of the angle at segment x, we look
; up the value in SNE + x, and to calculate the cosine of the angle we look up
; the value in SNE + ((x + 16) mod 32).
;
; In terms of radians, to calculate the following:
;
;   sin(theta) * 256
;
; where theta is in radians, we look up the value in:
;
;   SNE + (theta * 10)
;
; To calculate the following:
;
;   cos(theta) * 256
;
; where theta is in radians, look up the value in:
;
;   SNE + ((theta * 10) + 16) mod 32
;
; Theta must be between 0 and 3.1 radians, so theta * 10 is between 0 and 31.
;
; ******************************************************************************

.SNE

 FOR I%, 0, 31

  N = ABS(SIN((I% / 64) * 2 * PI))

  IF N >= 1
   EQUB 255
  ELSE
   EQUB INT(256 * N + 0.5)
  ENDIF

 NEXT

; ******************************************************************************
;
;       Name: ACT
;       Type: Variable
;   Category: Maths (Geometry)
;    Summary: Arctan table
;  Deep dive: The sine, cosine and arctan tables
;
; ------------------------------------------------------------------------------
;
; This table contains lookup values for arctangent calculations involving angles
; in the range 0 to 45 degrees (or 0 to PI / 4 radians).
;
; To calculate the value of theta in the following:
;
;   theta = arctan(t)
;
; where 0 <= t < 1, we look up the value in:
;
;   ACT + (t * 32)
;
; The result will be an integer representing the angle in radians, where 256
; represents a full circle of 360 degrees (2 * PI radians). The result of the
; lookup will therefore be an integer in the range 0 to 31, as this represents
; 0 to 45 degrees (0 to PI / 4 radians).
;
; The table does not support values of t >= 1 or t < 0 directly, so if we need
; to calculate the arctangent for an angle greater than 45 degrees, we can apply
; the following calculation to the result from the table:
;
;   * For t > 1, arctan(t) = 64 - arctan(1 / t)
;
; For negative values of t where -1 < t < 0, we can apply the following
; calculation to the result from the table:
;
;   * For t < 0, arctan(-t) = 128 - arctan(t)
;
; Finally, if t < -1, we can do the first calculation to get arctan(|t|), and
; the second to get arctan(-|t|).
;
; ******************************************************************************

.ACT

 FOR I%, 0, 31

  EQUB INT((128 / PI) * ATN(I% / 32) + 0.5)

 NEXT

; ******************************************************************************
;
; Save WORDS.bin
;
; ******************************************************************************

 PRINT "WORDS"
 PRINT "Assembled at ", ~WORDS
 PRINT "Ends at ", ~P%
 PRINT "Code size is ", ~(P% - WORDS)
 PRINT "Execute at ", ~LOAD%
 PRINT "Reload at ", ~LOAD%

 PRINT "S.C.WORDS ", ~WORDS, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "3-assembled-output/WORDS.bin", WORDS, P%, LOAD%

; ******************************************************************************
;
; ELITE FONT FILE
;
; ******************************************************************************

.FONT

 INCBIN "1-source-files/fonts/C.FONT.bin"

; ******************************************************************************
;
; ELITE EXTENDED TEXT TOKEN FILE
;
; ******************************************************************************

.IANTOK

; ******************************************************************************
;
;       Name: EJMP
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for jump tokens in the extended token table
;  Deep dive: Extended text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the extended token table:
;
;   EJMP n              Insert a jump to address n in the JMTB table
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   n                   The jump number to insert into the table
;
; ******************************************************************************

MACRO EJMP n

 EQUB n EOR VE

ENDMACRO

; ******************************************************************************
;
;       Name: ECHR
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for characters in the extended token table
;  Deep dive: Extended text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the extended token table:
;
;   ECHR 'x'            Insert ASCII character "x"
;
; To include an apostrophe, use a backtick character, as in ECHR '`'.
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   'x'                 The character to insert into the table
;
; ******************************************************************************

MACRO ECHR x

 IF x = '`'
  EQUB 39 EOR VE
 ELSE
  EQUB x EOR VE
 ENDIF

ENDMACRO

; ******************************************************************************
;
;       Name: ETOK
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for recursive tokens in the extended token table
;  Deep dive: Extended text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the extended token table:
;
;   ETOK n              Insert extended recursive token [n]
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   n                   The number of the recursive token to insert into the
;                       table, in the range 129 to 214
;
; ******************************************************************************

MACRO ETOK n

 EQUB n EOR VE

ENDMACRO

; ******************************************************************************
;
;       Name: ETWO
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for two-letter tokens in the extended token table
;  Deep dive: Extended text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the extended token table:
;
;   ETWO 'x', 'y'       Insert two-letter token "xy"
;
; The newline token can be entered using ETWO '-', '-'.
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   'x'                 The first letter of the two-letter token to insert into
;                       the table
;
;   'y'                 The second letter of the two-letter token to insert into
;                       the table
;
; ******************************************************************************

MACRO ETWO t, k

 IF t = '-' AND k = '-'
  EQUB 215 EOR VE
 ENDIF

 IF t = 'A' AND k = 'B'
  EQUB 216 EOR VE
 ENDIF

 IF t = 'O' AND k = 'U'
  EQUB 217 EOR VE
 ENDIF

 IF t = 'S' AND k = 'E'
  EQUB 218 EOR VE
 ENDIF

 IF t = 'I' AND k = 'T'
  EQUB 219 EOR VE
 ENDIF

 IF t = 'I' AND k = 'L'
  EQUB 220 EOR VE
 ENDIF

 IF t = 'E' AND k = 'T'
  EQUB 221 EOR VE
 ENDIF

 IF t = 'S' AND k = 'T'
  EQUB 222 EOR VE
 ENDIF

 IF t = 'O' AND k = 'N'
  EQUB 223 EOR VE
 ENDIF

 IF t = 'L' AND k = 'O'
  EQUB 224 EOR VE
 ENDIF

 IF t = 'N' AND k = 'U'
  EQUB 225 EOR VE
 ENDIF

 IF t = 'T' AND k = 'H'
  EQUB 226 EOR VE
 ENDIF

 IF t = 'N' AND k = 'O'
  EQUB 227 EOR VE
 ENDIF

 IF t = 'A' AND k = 'L'
  EQUB 228 EOR VE
 ENDIF

 IF t = 'L' AND k = 'E'
  EQUB 229 EOR VE
 ENDIF

 IF t = 'X' AND k = 'E'
  EQUB 230 EOR VE
 ENDIF

 IF t = 'G' AND k = 'E'
  EQUB 231 EOR VE
 ENDIF

 IF t = 'Z' AND k = 'A'
  EQUB 232 EOR VE
 ENDIF

 IF t = 'C' AND k = 'E'
  EQUB 233 EOR VE
 ENDIF

 IF t = 'B' AND k = 'I'
  EQUB 234 EOR VE
 ENDIF

 IF t = 'S' AND k = 'O'
  EQUB 235 EOR VE
 ENDIF

 IF t = 'U' AND k = 'S'
  EQUB 236 EOR VE
 ENDIF

 IF t = 'E' AND k = 'S'
  EQUB 237 EOR VE
 ENDIF

 IF t = 'A' AND k = 'R'
  EQUB 238 EOR VE
 ENDIF

 IF t = 'M' AND k = 'A'
  EQUB 239 EOR VE
 ENDIF

 IF t = 'I' AND k = 'N'
  EQUB 240 EOR VE
 ENDIF

 IF t = 'D' AND k = 'I'
  EQUB 241 EOR VE
 ENDIF

 IF t = 'R' AND k = 'E'
  EQUB 242 EOR VE
 ENDIF

 IF t = 'A' AND k = '?'
  EQUB 243 EOR VE
 ENDIF

 IF t = 'E' AND k = 'R'
  EQUB 244 EOR VE
 ENDIF

 IF t = 'A' AND k = 'T'
  EQUB 245 EOR VE
 ENDIF

 IF t = 'E' AND k = 'N'
  EQUB 246 EOR VE
 ENDIF

 IF t = 'B' AND k = 'E'
  EQUB 247 EOR VE
 ENDIF

 IF t = 'R' AND k = 'A'
  EQUB 248 EOR VE
 ENDIF

 IF t = 'L' AND k = 'A'
  EQUB 249 EOR VE
 ENDIF

 IF t = 'V' AND k = 'E'
  EQUB 250 EOR VE
 ENDIF

 IF t = 'T' AND k = 'I'
  EQUB 251 EOR VE
 ENDIF

 IF t = 'E' AND k = 'D'
  EQUB 252 EOR VE
 ENDIF

 IF t = 'O' AND k = 'R'
  EQUB 253 EOR VE
 ENDIF

 IF t = 'Q' AND k = 'U'
  EQUB 254 EOR VE
 ENDIF

 IF t = 'A' AND k = 'N'
  EQUB 255 EOR VE
 ENDIF

ENDMACRO

; ******************************************************************************
;
;       Name: ERND
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for random tokens in the extended token table
;  Deep dive: Extended text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the extended token table:
;
;   ERND n              Insert recursive token [n]
;
;                         * Tokens 0-123 get stored as n + 91
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   n                   The number of the random token to insert into the
;                       table, in the range 0 to 37
;
; ******************************************************************************

MACRO ERND n

 EQUB (n + 91) EOR VE

ENDMACRO

; ******************************************************************************
;
;       Name: TOKN
;       Type: Macro
;   Category: Text
;    Summary: Macro definition for standard tokens in the extended token table
;  Deep dive: Printing text tokens
;
; ------------------------------------------------------------------------------
;
; The following macro is used when building the recursive token table:
;
;   TOKN n              Insert recursive token [n]
;
;                         * Tokens 0-95 get stored as n + 160
;
;                         * Tokens 128-145 get stored as n - 114
;
;                         * Tokens 96-127 get stored as n
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   n                   The number of the recursive token to insert into the
;                       table, in the range 0 to 145
;
; ******************************************************************************

MACRO TOKN n

 IF n >= 0 AND n <= 95
  t = n + 160
 ELIF n >= 128
  t = n - 114
 ELSE
  t = n
 ENDIF

 EQUB t EOR VE

ENDMACRO

; ******************************************************************************
;
;       Name: TKN1
;       Type: Variable
;   Category: Text
;    Summary: The first extended token table for recursive tokens 0-255 (DETOK)
;  Deep dive: Extended text tokens
;
; ------------------------------------------------------------------------------
;
; The encodings shown for each extended text token use the following notation:
;
;   {n}           Jump token                n = 1 to 31
;   [n?]          Random token              n = 91 to 128
;   [n]           Recursive token           n = 129 to 215
;   <n>           Two-letter token          n = 215 to 255
;
; ******************************************************************************

.TKN1

 EQUB VE                ; Token 0:      ""
                        ;
                        ; Encoded as:   ""

 EJMP 9                 ; Token 1:      "{clear screen}
 EJMP 11                ;                {draw box around title}
 EJMP 1                 ;                {all caps}
 EJMP 8                 ;                {tab 6} {currently selected media}
 ECHR ' '               ;                 ACCESS MENU{crlf}
 EJMP 30                ;                {lf}
 ECHR ' '               ;                {sentence case}
 ECHR 'A'               ;                1. LOAD NEW {single cap}COMMANDER{crlf}
 ECHR 'C'               ;                2. SAVE {single cap}COMMANDER
 ETWO 'C', 'E'          ;                   {commander name}{crlf}
 ECHR 'S'               ;                3. CHANGE TO {other media}{crlf}
 ECHR 'S'               ;                4. DEFAULT {all caps}JAMESON{sentence
 ECHR ' '               ;                   case}{crlf}
 ECHR 'M'               ;                5. EXIT{crlf}
 ECHR 'E'               ;               "
 ETWO 'N', 'U'          ;
 ETWO '-', '-'          ; Encoded as:   "{9}{11}{1}{8} {30} AC<233>SS ME
 EJMP 10                ;                <225><215>{10}{2}1. [149]<215>2. SA
 EJMP 2                 ;                <250> [154] {4}<215>3. CH<255><231>
 ECHR '1'               ;                [201]{31}<215>4. DEFAULT {1}JAMESON{2}
 ECHR '.'               ;                <215>5. EX<219><215>"
 ECHR ' '
 ETOK 149
 ETWO '-', '-'
 ECHR '2'
 ECHR '.'
 ECHR ' '
 ECHR 'S'
 ECHR 'A'
 ETWO 'V', 'E'
 ECHR ' '
 ETOK 154
 ECHR ' '
 EJMP 4
 ETWO '-', '-'
 ECHR '3'
 ECHR '.'
 ECHR ' '
 ECHR 'C'
 ECHR 'H'
 ETWO 'A', 'N'
 ETWO 'G', 'E'
 ETOK 201
 EJMP 31
 ETWO '-', '-'
 ECHR '4'
 ECHR '.'
 ECHR ' '
 ECHR 'D'
 ECHR 'E'
 ECHR 'F'
 ECHR 'A'
 ECHR 'U'
 ECHR 'L'
 ECHR 'T'
 ECHR ' '
 EJMP 1
 ECHR 'J'
 ECHR 'A'
 ECHR 'M'
 ECHR 'E'
 ECHR 'S'
 ECHR 'O'
 ECHR 'N'
 EJMP 2
 ETWO '-', '-'
 ECHR '5'
 ECHR '.'
 ECHR ' '
 ECHR 'E'
 ECHR 'X'
 ETWO 'I', 'T'
 ETWO '-', '-'
 EQUB VE

 ETWO 'D', 'I'          ; Token 2:      "DISK"
 ECHR 'S'               ;
 ECHR 'K'               ; Encoded as:   "<241>SK"
 EQUB VE

 ECHR 'T'               ; Token 3:      "TAPE"
 ECHR 'A'               ;
 ECHR 'P'               ; Encoded as:   "TAPE"
 ECHR 'E'
 EQUB VE

 ECHR 'C'               ; Token 4:      "COMPETITION NUMBER:"
 ECHR 'O'               ;
 ECHR 'M'               ; Encoded as:   "COMPE<251><251><223> <225>MB<244>:"
 ECHR 'P'
 ECHR 'E'
 ETWO 'T', 'I'
 ETWO 'T', 'I'
 ETWO 'O', 'N'
 ECHR ' '
 ETWO 'N', 'U'
 ECHR 'M'
 ECHR 'B'
 ETWO 'E', 'R'
 ECHR ':'
 EQUB VE

 ETOK 176               ; Token 5:      "{lower case}
 ERND 18                ;                {justify}
 ETOK 202               ;                {single cap}[86-90] IS [140-144].{cr}
 ERND 19                ;                {left align}"
 ETOK 177               ;
 EQUB VE                ; Encoded as:   "[176][18?][202][19?][177]"

 ECHR ' '               ; Token 6:      "  LOAD NEW {single cap}COMMANDER {all
 ECHR ' '               ;                caps}(Y/N)?{sentence case}{cr}{cr}"
 ETOK 149               ;
 ECHR ' '               ; Encoded as:   "  [149] {1}(Y/N)?{2}{12}{12}"
 EJMP 1
 ECHR '('
 ECHR 'Y'
 ECHR '/'
 ECHR 'N'
 ECHR ')'
 ECHR '?'
 EJMP 2
 EJMP 12
 EJMP 12
 EQUB VE

 ECHR 'P'               ; Token 7:      "PRESS SPACE OR FIRE,{single cap}
 ETWO 'R', 'E'          ;                COMMANDER.{cr}{cr}"
 ECHR 'S'               ;
 ECHR 'S'               ; Encoded as:   "P<242>SS SPA<233> <253> FI<242>,[154].
 ECHR ' '               ;                {12}{12}"
 ECHR 'S'
 ECHR 'P'
 ECHR 'A'
 ETWO 'C', 'E'
 ECHR ' '
 ETWO 'O', 'R'
 ECHR ' '
 ECHR 'F'
 ECHR 'I'
 ETWO 'R', 'E'
 ECHR ','
 ETOK 154
 ECHR '.'
 EJMP 12
 EJMP 12
 EQUB VE

 ETOK 154               ; Token 8:      "{single cap}COMMANDER'S NAME? "
 ECHR '`'               ;
 ECHR 'S'               ; Encoded as:   "[154]'S[200]"
 ETOK 200
 EQUB VE

 EJMP 12                ; Token 9:      "{cr}
 EJMP 1                 ;                {all caps}
 ETWO 'I', 'L'          ;                ILLEGAL ELITE II FILE
 ETWO 'L', 'E'          ;                {sentence case}"
 ECHR 'G'               ;
 ETWO 'A', 'L'          ; Encoded as:   "{12}{1}<220><229>G<228> ELITE II FI
 ECHR ' '               ;                <229>"
 ECHR 'E'
 ECHR 'L'
 ECHR 'I'
 ECHR 'T'
 ECHR 'E'
 ECHR ' '
 ECHR 'I'
 ECHR 'I'
 ECHR ' '
 ECHR 'F'
 ECHR 'I'
 ETWO 'L', 'E'
 EQUB VE

 EJMP 23                ; Token 10:     "{move to row 10, white, lower case}
 EJMP 14                ;                {justify}
 EJMP 2                 ;                {sentence case}
 ECHR 'G'               ;                GREETINGS {single cap}COMMANDER
 ETWO 'R', 'E'          ;                {commander name}, I {lower case}AM
 ETWO 'E', 'T'          ;                {sentence case} CAPTAIN {mission
 ETWO 'I', 'N'          ;                captain's name} {lower case}OF{sentence
 ECHR 'G'               ;                case} HER MAJESTY'S SPACE NAVY{lower
 ECHR 'S'               ;                case} AND {single cap}I BEG A MOMENT OF
 ETOK 213               ;                YOUR VALUABLE TIME.{cr}
 ETOK 178               ;                 {single cap}WE WOULD LIKE YOU TO DO A
 EJMP 19                ;                LITTLE JOB FOR US.{cr}
 ECHR 'I'               ;                 {single cap}THE SHIP YOU SEE HERE IS A
 ECHR ' '               ;                NEW MODEL, THE {single cap}CONSTRICTOR,
 ETWO 'B', 'E'          ;                EQUIPED WITH A TOP SECRET NEW SHIELD
 ECHR 'G'               ;                GENERATOR.{cr}
 ETOK 208               ;                 {single cap}UNFORTUNATELY IT'S BEEN
 ECHR 'M'               ;                STOLEN.{cr}
 ECHR 'O'               ;                 {single cap}{display ship, wait for
 ECHR 'M'               ;                key press}IT WENT MISSING FROM OUR SHIP
 ETWO 'E', 'N'          ;                YARD ON {single cap}XEER FIVE MONTHS
 ECHR 'T'               ;                AGO AND {mission 1 location hint}.{cr}
 ECHR ' '               ;                 {single cap}YOUR MISSION, SHOULD YOU
 ECHR 'O'               ;                DECIDE TO ACCEPT IT, IS TO SEEK AND
 ECHR 'F'               ;                DESTROY THIS SHIP.{cr}
 ECHR ' '               ;                 {single cap}YOU ARE CAUTIONED THAT
 ETOK 179               ;                ONLY {standard tokens, sentence case}
 ECHR 'R'               ;                MILITARY  LASERS{extended tokens} WILL
 ECHR ' '               ;                PENETRATE THE NEW SHIELDS AND THAT THE
 ECHR 'V'               ;                {single cap}CONSTRICTOR IS FITTED WITH
 ETWO 'A', 'L'          ;                AN {standard tokens, sentence case}
 ECHR 'U'               ;                E.C.M.SYSTEM{extended tokens}.{cr}
 ETWO 'A', 'B'          ;                 {left align}{sentence case}{tab 6}GOOD
 ETWO 'L', 'E'          ;                LUCK, {single cap}COMMANDER.{cr}
 ECHR ' '               ;                 {left align}{tab 6}{all caps}  MESSAGE
 ETWO 'T', 'I'          ;                ENDS{display ship, wait for key press}"
 ECHR 'M'               ;
 ECHR 'E'               ; Encoded as:   "{23}{14}{2}G<242><221><240>GS[213][178]
 ETOK 204               ;                {19}I <247>G[208]MOM<246>T OF [179]R V
 ECHR 'W'               ;                <228>U<216><229> <251>ME[204]WE W<217>
 ECHR 'E'               ;                LD LIKE [179][201]DO[208]L<219>T<229>
 ECHR ' '               ;                 JOB F<253> <236>[204][147][207] [179]
 ECHR 'W'               ;                 <218>E HE<242>[202]A[210]MODEL, [147]
 ETWO 'O', 'U'          ;                {19}C<223><222>RICT<253>, E<254>IP[196]
 ECHR 'L'               ;                WI<226>[208]TOP <218>CR<221>[210]SHIELD
 ECHR 'D'               ;                 G<246><244><245><253>[204]UNF<253>TUN
 ECHR ' '               ;                <245>ELY <219>'S <247><246> <222>OL
 ECHR 'L'               ;                <246>[204]{22}<219> W<246>T MISS[195]
 ECHR 'I'               ;                FROM <217>R [207] Y<238>D <223> {19}
 ECHR 'K'               ;                <230><244> FI<250> M<223><226>S AGO
 ECHR 'E'               ;                [178]{28}[204][179]R MISSI<223>, SH
 ECHR ' '               ;                <217>LD [179] DECIDE[201]AC<233>PT
 ETOK 179               ;                 <219>, IS[201]<218>EK[178]D<237>TROY
 ETOK 201               ;                 [148][207][204][179] A<242> CAU<251>
 ECHR 'D'               ;                <223>[196]<226><245> <223>LY {6}[116]
 ECHR 'O'               ;                {5}S W<220>L P<246><221><248>TE [147]
 ETOK 208               ;                NEW SHIELDS[178]<226><245> [147]{19}
 ECHR 'L'               ;                C<223><222>RICT<253>[202]F<219>T[196]WI
 ETWO 'I', 'T'          ;                <226> <255> {6}[108]{5}[177]{2}{8}GOOD
 ECHR 'T'               ;                 LUCK, [154][212]{22}"
 ETWO 'L', 'E'
 ECHR ' '
 ECHR 'J'
 ECHR 'O'
 ECHR 'B'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ETWO 'U', 'S'
 ETOK 204
 ETOK 147
 ETOK 207
 ECHR ' '
 ETOK 179
 ECHR ' '
 ETWO 'S', 'E'
 ECHR 'E'
 ECHR ' '
 ECHR 'H'
 ECHR 'E'
 ETWO 'R', 'E'
 ETOK 202
 ECHR 'A'
 ETOK 210
 ECHR 'M'
 ECHR 'O'
 ECHR 'D'
 ECHR 'E'
 ECHR 'L'
 ECHR ','
 ECHR ' '
 ETOK 147
 EJMP 19
 ECHR 'C'
 ETWO 'O', 'N'
 ETWO 'S', 'T'
 ECHR 'R'
 ECHR 'I'
 ECHR 'C'
 ECHR 'T'
 ETWO 'O', 'R'
 ECHR ','
 ECHR ' '
 ECHR 'E'
 ETWO 'Q', 'U'
 ECHR 'I'
 ECHR 'P'
 ETOK 196
 ECHR 'W'
 ECHR 'I'
 ETWO 'T', 'H'
 ETOK 208
 ECHR 'T'
 ECHR 'O'
 ECHR 'P'
 ECHR ' '
 ETWO 'S', 'E'
 ECHR 'C'
 ECHR 'R'
 ETWO 'E', 'T'
 ETOK 210
 ECHR 'S'
 ECHR 'H'
 ECHR 'I'
 ECHR 'E'
 ECHR 'L'
 ECHR 'D'
 ECHR ' '
 ECHR 'G'
 ETWO 'E', 'N'
 ETWO 'E', 'R'
 ETWO 'A', 'T'
 ETWO 'O', 'R'
 ETOK 204
 ECHR 'U'
 ECHR 'N'
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR 'T'
 ECHR 'U'
 ECHR 'N'
 ETWO 'A', 'T'
 ECHR 'E'
 ECHR 'L'
 ECHR 'Y'
 ECHR ' '
 ETWO 'I', 'T'
 ECHR '`'
 ECHR 'S'
 ECHR ' '
 ETWO 'B', 'E'
 ETWO 'E', 'N'
 ECHR ' '
 ETWO 'S', 'T'
 ECHR 'O'
 ECHR 'L'
 ETWO 'E', 'N'
 ETOK 204
 EJMP 22
 ETWO 'I', 'T'
 ECHR ' '
 ECHR 'W'
 ETWO 'E', 'N'
 ECHR 'T'
 ECHR ' '
 ECHR 'M'
 ECHR 'I'
 ECHR 'S'
 ECHR 'S'
 ETOK 195
 ECHR 'F'
 ECHR 'R'
 ECHR 'O'
 ECHR 'M'
 ECHR ' '
 ETWO 'O', 'U'
 ECHR 'R'
 ECHR ' '
 ETOK 207
 ECHR ' '
 ECHR 'Y'
 ETWO 'A', 'R'
 ECHR 'D'
 ECHR ' '
 ETWO 'O', 'N'
 ECHR ' '
 EJMP 19
 ETWO 'X', 'E'
 ETWO 'E', 'R'
 ECHR ' '
 ECHR 'F'
 ECHR 'I'
 ETWO 'V', 'E'
 ECHR ' '
 ECHR 'M'
 ETWO 'O', 'N'
 ETWO 'T', 'H'
 ECHR 'S'
 ECHR ' '
 ECHR 'A'
 ECHR 'G'
 ECHR 'O'
 ETOK 178
 EJMP 28
 ETOK 204
 ETOK 179
 ECHR 'R'
 ECHR ' '
 ECHR 'M'
 ECHR 'I'
 ECHR 'S'
 ECHR 'S'
 ECHR 'I'
 ETWO 'O', 'N'
 ECHR ','
 ECHR ' '
 ECHR 'S'
 ECHR 'H'
 ETWO 'O', 'U'
 ECHR 'L'
 ECHR 'D'
 ECHR ' '
 ETOK 179
 ECHR ' '
 ECHR 'D'
 ECHR 'E'
 ECHR 'C'
 ECHR 'I'
 ECHR 'D'
 ECHR 'E'
 ETOK 201
 ECHR 'A'
 ECHR 'C'
 ETWO 'C', 'E'
 ECHR 'P'
 ECHR 'T'
 ECHR ' '
 ETWO 'I', 'T'
 ECHR ','
 ECHR ' '
 ECHR 'I'
 ECHR 'S'
 ETOK 201
 ETWO 'S', 'E'
 ECHR 'E'
 ECHR 'K'
 ETOK 178
 ECHR 'D'
 ETWO 'E', 'S'
 ECHR 'T'
 ECHR 'R'
 ECHR 'O'
 ECHR 'Y'
 ECHR ' '
 ETOK 148
 ETOK 207
 ETOK 204
 ETOK 179
 ECHR ' '
 ECHR 'A'
 ETWO 'R', 'E'
 ECHR ' '
 ECHR 'C'
 ECHR 'A'
 ECHR 'U'
 ETWO 'T', 'I'
 ETWO 'O', 'N'
 ETOK 196
 ETWO 'T', 'H'
 ETWO 'A', 'T'
 ECHR ' '
 ETWO 'O', 'N'
 ECHR 'L'
 ECHR 'Y'
 ECHR ' '
 EJMP 6
 TOKN 117
 EJMP 5
 ECHR 'S'
 ECHR ' '
 ECHR 'W'
 ETWO 'I', 'L'
 ECHR 'L'
 ECHR ' '
 ECHR 'P'
 ETWO 'E', 'N'
 ETWO 'E', 'T'
 ETWO 'R', 'A'
 ECHR 'T'
 ECHR 'E'
 ECHR ' '
 ETOK 147
 ECHR 'N'
 ECHR 'E'
 ECHR 'W'
 ECHR ' '
 ECHR 'S'
 ECHR 'H'
 ECHR 'I'
 ECHR 'E'
 ECHR 'L'
 ECHR 'D'
 ECHR 'S'
 ETOK 178
 ETWO 'T', 'H'
 ETWO 'A', 'T'
 ECHR ' '
 ETOK 147
 EJMP 19
 ECHR 'C'
 ETWO 'O', 'N'
 ETWO 'S', 'T'
 ECHR 'R'
 ECHR 'I'
 ECHR 'C'
 ECHR 'T'
 ETWO 'O', 'R'
 ETOK 202
 ECHR 'F'
 ETWO 'I', 'T'
 ECHR 'T'
 ETOK 196
 ECHR 'W'
 ECHR 'I'
 ETWO 'T', 'H'
 ECHR ' '
 ETWO 'A', 'N'
 ECHR ' '
 EJMP 6
 TOKN 108
 EJMP 5
 ETOK 177
 EJMP 2
 EJMP 8
 ECHR 'G'
 ECHR 'O'
 ECHR 'O'
 ECHR 'D'
 ECHR ' '
 ECHR 'L'
 ECHR 'U'
 ECHR 'C'
 ECHR 'K'
 ECHR ','
 ECHR ' '
 ETOK 154
 ETOK 212
 EJMP 22
 EQUB VE

 EJMP 25                ; Token 11:     "{incoming message screen, wait 2s}
 EJMP 9                 ;                {clear screen}
 EJMP 23                ;                {move to row 10, white, lower case}
 EJMP 14                ;                {justify}
 EJMP 2                 ;                {sentence case}
 ECHR ' '               ;                  ATTENTION {single cap}COMMANDER
 ECHR ' '               ;                {commander name}, I {lower case}AM
 ETWO 'A', 'T'          ;                {sentence case} CAPTAIN {mission
 ECHR 'T'               ;                captain's name} {lower case}OF{sentence
 ETWO 'E', 'N'          ;                case} HER MAJESTY'S SPACE NAVY{lower
 ETWO 'T', 'I'          ;                case}. {single cap}WE HAVE NEED OF YOUR
 ETWO 'O', 'N'          ;                SERVICES AGAIN.{cr}
 ETOK 213               ;                 {single cap}IF YOU WOULD BE SO GOOD AS
 ECHR '.'               ;                TO GO TO {single cap}CEERDI YOU WILL BE
 ECHR ' '               ;                BRIEFED.{cr}
 EJMP 19                ;                 {single cap}IF SUCCESSFUL, YOU WILL BE
 ECHR 'W'               ;                WELL REWARDED.{cr}
 ECHR 'E'               ;                {left align}{tab 6}{all caps}  MESSAGE
 ECHR ' '               ;                ENDS{wait for key press}"
 ECHR 'H'               ;
 ECHR 'A'               ; Encoded as:   "{25}{9}{23}{14}{2}  <245>T<246><251>
 ETWO 'V', 'E'          ;                <223>[213]. {19}WE HA<250> NE[196]OF
 ECHR ' '               ;                 [179]R <218>RVIC<237> AGA<240>[204]IF
 ECHR 'N'               ;                 [179] W<217>LD <247> <235> GOOD AS
 ECHR 'E'               ;                [201]GO[201]{19}<233><244><241> [179] W
 ETOK 196               ;                <220>L <247> BRIEF<252>[204]IF SUC<233>
 ECHR 'O'               ;                SSFUL, [179] W<220>L <247> WELL <242>W
 ECHR 'F'               ;                <238>D<252>[212]{24}"
 ECHR ' '
 ETOK 179
 ECHR 'R'
 ECHR ' '
 ETWO 'S', 'E'
 ECHR 'R'
 ECHR 'V'
 ECHR 'I'
 ECHR 'C'
 ETWO 'E', 'S'
 ECHR ' '
 ECHR 'A'
 ECHR 'G'
 ECHR 'A'
 ETWO 'I', 'N'
 ETOK 204
 ECHR 'I'
 ECHR 'F'
 ECHR ' '
 ETOK 179
 ECHR ' '
 ECHR 'W'
 ETWO 'O', 'U'
 ECHR 'L'
 ECHR 'D'
 ECHR ' '
 ETWO 'B', 'E'
 ECHR ' '
 ETWO 'S', 'O'
 ECHR ' '
 ECHR 'G'
 ECHR 'O'
 ECHR 'O'
 ECHR 'D'
 ECHR ' '
 ECHR 'A'
 ECHR 'S'
 ETOK 201
 ECHR 'G'
 ECHR 'O'
 ETOK 201
 EJMP 19
 ETWO 'C', 'E'
 ETWO 'E', 'R'
 ETWO 'D', 'I'
 ECHR ' '
 ETOK 179
 ECHR ' '
 ECHR 'W'
 ETWO 'I', 'L'
 ECHR 'L'
 ECHR ' '
 ETWO 'B', 'E'
 ECHR ' '
 ECHR 'B'
 ECHR 'R'
 ECHR 'I'
 ECHR 'E'
 ECHR 'F'
 ETWO 'E', 'D'
 ETOK 204
 ECHR 'I'
 ECHR 'F'
 ECHR ' '
 ECHR 'S'
 ECHR 'U'
 ECHR 'C'
 ETWO 'C', 'E'
 ECHR 'S'
 ECHR 'S'
 ECHR 'F'
 ECHR 'U'
 ECHR 'L'
 ECHR ','
 ECHR ' '
 ETOK 179
 ECHR ' '
 ECHR 'W'
 ETWO 'I', 'L'
 ECHR 'L'
 ECHR ' '
 ETWO 'B', 'E'
 ECHR ' '
 ECHR 'W'
 ECHR 'E'
 ECHR 'L'
 ECHR 'L'
 ECHR ' '
 ETWO 'R', 'E'
 ECHR 'W'
 ETWO 'A', 'R'
 ECHR 'D'
 ETWO 'E', 'D'
 ETOK 212
 EJMP 24
 EQUB VE

 ECHR '('               ; Token 12:     "({single cap}C) {single cap}D.{single
 EJMP 19                ;                cap}BRABEN & {single cap}I.{single cap}
 ECHR 'C'               ;                BELL 1985"
 ECHR ')'               ;
 ETOK 197               ; Encoded as:   "({19}C) [191] 1985"
 ECHR ' '
 ECHR '1'
 ECHR '9'
 ECHR '8'
 ECHR '5'
 EQUB VE

 ECHR 'B'               ; Token 13:     "BY D.BRABEN & I.BELL"
 ECHR 'Y'               ;
 ETOK 197               ; Encoded as:   "BY[197]]"
 EQUB VE

 EJMP 21                ; Token 14:     "{clear bottom of screen}
 ETOK 145               ;                PLANET NAME?
 ETOK 200               ;                {fetch line input from keyboard}"
 EJMP 26                ;
 EQUB VE                ; Encoded as:   "{21}[145][200]{26}"

 EJMP 25                ; Token 15:     "{incoming message screen, wait 2s}
 EJMP 9                 ;                {clear screen}
 EJMP 23                ;                {move to row 10, white, lower case}
 EJMP 14                ;                {justify}
 EJMP 2                 ;                {sentence case}
 ECHR ' '               ;                  CONGRATULATIONS {single cap}
 ECHR ' '               ;                COMMANDER!{cr}
 ECHR 'C'               ;                {cr}
 ETWO 'O', 'N'          ;                THERE{lower case} WILL ALWAYS BE A
 ECHR 'G'               ;                PLACE FOR YOU IN{sentence case} HER
 ETWO 'R', 'A'          ;                MAJESTY'S SPACE NAVY{lower case}.{cr}
 ECHR 'T'               ;                 {single cap}AND MAYBE SOONER THAN YOU
 ECHR 'U'               ;                THINK...{cr}
 ETWO 'L', 'A'          ;                {left align}{tab 6}{all caps}  MESSAGE
 ETWO 'T', 'I'          ;                ENDS{wait for key press}"
 ETWO 'O', 'N'          ;
 ECHR 'S'               ; Encoded as:   "{25}{9}{23}{14}{2}  C<223>G<248>TU
 ECHR ' '               ;                <249><251><223>S [154]!{12}{12}<226>
 ETOK 154               ;                <244>E{13} W<220>L <228>WAYS <247>[208]
 ECHR '!'               ;                P<249><233> F<253> [179] <240>[211]
 EJMP 12                ;                [204]<255>D <239>Y<247> <235><223><244>
 EJMP 12                ;                 <226><255> [179] <226><240>K..[212]
 ETWO 'T', 'H'          ;                {24}"
 ETWO 'E', 'R'
 ECHR 'E'
 EJMP 13
 ECHR ' '
 ECHR 'W'
 ETWO 'I', 'L'
 ECHR 'L'
 ECHR ' '
 ETWO 'A', 'L'
 ECHR 'W'
 ECHR 'A'
 ECHR 'Y'
 ECHR 'S'
 ECHR ' '
 ETWO 'B', 'E'
 ETOK 208
 ECHR 'P'
 ETWO 'L', 'A'
 ETWO 'C', 'E'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ETOK 179
 ECHR ' '
 ETWO 'I', 'N'
 ETOK 211
 ETOK 204
 ETWO 'A', 'N'
 ECHR 'D'
 ECHR ' '
 ETWO 'M', 'A'
 ECHR 'Y'
 ETWO 'B', 'E'
 ECHR ' '
 ETWO 'S', 'O'
 ETWO 'O', 'N'
 ETWO 'E', 'R'
 ECHR ' '
 ETWO 'T', 'H'
 ETWO 'A', 'N'
 ECHR ' '
 ETOK 179
 ECHR ' '
 ETWO 'T', 'H'
 ETWO 'I', 'N'
 ECHR 'K'
 ECHR '.'
 ECHR '.'
 ETOK 212
 EJMP 24
 EQUB VE

 ECHR 'F'               ; Token 16:     "FABLED"
 ETWO 'A', 'B'          ;
 ETWO 'L', 'E'          ; Encoded as:   "F<216><229>D"
 ECHR 'D'
 EQUB VE

 ETWO 'N', 'O'          ; Token 17:     "NOTABLE"
 ECHR 'T'               ;
 ETWO 'A', 'B'          ; Encoded as:   "<227>T<216><229>"
 ETWO 'L', 'E'
 EQUB VE

 ECHR 'W'               ; Token 18:     "WELL KNOWN"
 ECHR 'E'               ;
 ECHR 'L'               ; Encoded as:   "WELL K<227>WN"
 ECHR 'L'
 ECHR ' '
 ECHR 'K'
 ETWO 'N', 'O'
 ECHR 'W'
 ECHR 'N'
 EQUB VE

 ECHR 'F'               ; Token 19:     "FAMOUS"
 ECHR 'A'               ;
 ECHR 'M'               ; Encoded as:   "FAMO<236>"
 ECHR 'O'
 ETWO 'U', 'S'
 EQUB VE

 ETWO 'N', 'O'          ; Token 20:     "NOTED"
 ECHR 'T'               ;
 ETWO 'E', 'D'          ; Encoded as:   "<227>T<252>"
 EQUB VE

 ETWO 'V', 'E'          ; Token 21:     "VERY"
 ECHR 'R'               ;
 ECHR 'Y'               ; Encoded as:   "<250>RY"
 EQUB VE

 ECHR 'M'               ; Token 22:     "MILDLY"
 ETWO 'I', 'L'          ;
 ECHR 'D'               ; Encoded as:   "M<220>DLY"
 ECHR 'L'
 ECHR 'Y'
 EQUB VE

 ECHR 'M'               ; Token 23:     "MOST"
 ECHR 'O'               ;
 ETWO 'S', 'T'          ; Encoded as:   "MO<222>"
 EQUB VE

 ETWO 'R', 'E'          ; Token 24:     "REASONABLY"
 ECHR 'A'               ;
 ECHR 'S'               ; Encoded as:   "<242>AS<223><216>LY"
 ETWO 'O', 'N'
 ETWO 'A', 'B'
 ECHR 'L'
 ECHR 'Y'
 EQUB VE

 EQUB VE                ; Token 25:     ""
                        ;
                        ; Encoded as:   ""

 ETOK 165               ; Token 26:     "ANCIENT"
 EQUB VE                ;
                        ; Encoded as:   "[165]"

 ERND 23                ; Token 27:     "[130-134]"
 EQUB VE                ;
                        ; Encoded as:   "[23?]"

 ECHR 'G'               ; Token 28:     "GREAT"
 ETWO 'R', 'E'          ;
 ETWO 'A', 'T'          ; Encoded as:   "G<242><245>"
 EQUB VE

 ECHR 'V'               ; Token 29:     "VAST"
 ECHR 'A'               ;
 ETWO 'S', 'T'          ; Encoded as:   "VA<222>"
 EQUB VE

 ECHR 'P'               ; Token 30:     "PINK"
 ETWO 'I', 'N'          ;
 ECHR 'K'               ; Encoded as:   "P<240>K"
 EQUB VE

 EJMP 2                 ; Token 31:     "{sentence case}[190-194] [185-189]
 ERND 28                ;                {lower case} PLANTATIONS"
 ECHR ' '               ;
 ERND 27                ; Encoded as:   "{2}[28?] [27?]{13} [185]A<251><223>S"
 EJMP 13
 ECHR ' '
 ETOK 185
 ECHR 'A'
 ETWO 'T', 'I'
 ETWO 'O', 'N'
 ECHR 'S'
 EQUB VE

 ETOK 156               ; Token 32:     "MOUNTAINS"
 ECHR 'S'               ;
 EQUB VE                ; Encoded as:   "[156]S"

 ERND 26                ; Token 33:     "[180-184]"
 EQUB VE                ;
                        ; Encoded as:   "[26?]"

 ERND 37                ; Token 34:     "[125-129] FORESTS"
 ECHR ' '               ;
 ECHR 'F'               ; Encoded as:   "[37?] F<253><237>TS"
 ETWO 'O', 'R'
 ETWO 'E', 'S'
 ECHR 'T'
 ECHR 'S'
 EQUB VE

 ECHR 'O'               ; Token 35:     "OCEANS"
 ETWO 'C', 'E'          ;
 ETWO 'A', 'N'          ; Encoded as:   "O<233><255>S"
 ECHR 'S'
 EQUB VE

 ECHR 'S'               ; Token 36:     "SHYNESS"
 ECHR 'H'               ;
 ECHR 'Y'               ; Encoded as:   "SHYN<237>S"
 ECHR 'N'
 ETWO 'E', 'S'
 ECHR 'S'
 EQUB VE

 ECHR 'S'               ; Token 37:     "SILLINESS"
 ETWO 'I', 'L'          ;
 ECHR 'L'               ; Encoded as:   "S<220>L<240><237>S"
 ETWO 'I', 'N'
 ETWO 'E', 'S'
 ECHR 'S'
 EQUB VE

 ETWO 'M', 'A'          ; Token 38:     "MATING TRADITIONS"
 ECHR 'T'               ;
 ETOK 195               ; Encoded as:   "<239>T[195]T<248><241><251><223>S"
 ECHR 'T'
 ETWO 'R', 'A'
 ETWO 'D', 'I'
 ETWO 'T', 'I'
 ETWO 'O', 'N'
 ECHR 'S'
 EQUB VE

 ETWO 'L', 'O'          ; Token 39:     "LOATHING OF [41-45]"
 ETWO 'A', 'T'          ;
 ECHR 'H'               ; Encoded as:   "<224><245>H[195]OF [9?]"
 ETOK 195
 ECHR 'O'
 ECHR 'F'
 ECHR ' '
 ERND 9
 EQUB VE

 ETWO 'L', 'O'          ; Token 40:     "LOVE FOR [41-45]"
 ETWO 'V', 'E'          ;
 ECHR ' '               ; Encoded as:   "<224><250> F<253> [9?]"
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ERND 9
 EQUB VE

 ECHR 'F'               ; Token 41:     "FOOD BLENDERS"
 ECHR 'O'               ;
 ECHR 'O'               ; Encoded as:   "FOOD B<229>ND<244>S"
 ECHR 'D'
 ECHR ' '
 ECHR 'B'
 ETWO 'L', 'E'
 ECHR 'N'
 ECHR 'D'
 ETWO 'E', 'R'
 ECHR 'S'
 EQUB VE

 ECHR 'T'               ; Token 42:     "TOURISTS"
 ETWO 'O', 'U'          ;
 ECHR 'R'               ; Encoded as:   "T<217>RI<222>S"
 ECHR 'I'
 ETWO 'S', 'T'
 ECHR 'S'
 EQUB VE

 ECHR 'P'               ; Token 43:     "POETRY"
 ECHR 'O'               ;
 ETWO 'E', 'T'          ; Encoded as:   "PO<221>RY"
 ECHR 'R'
 ECHR 'Y'
 EQUB VE

 ETWO 'D', 'I'          ; Token 44:     "DISCOS"
 ECHR 'S'               ;
 ECHR 'C'               ; Encoded as:   "<241>SCOS"
 ECHR 'O'
 ECHR 'S'
 EQUB VE

 ERND 17                ; Token 45:     "[81-85]"
 EQUB VE                ;
                        ; Encoded as:   "[17?]"

 ECHR 'W'               ; Token 46:     "WALKING TREE"
 ETWO 'A', 'L'          ;
 ECHR 'K'               ; Encoded as:   "W<228>K[195][158]"
 ETOK 195
 ETOK 158
 EQUB VE

 ECHR 'C'               ; Token 47:     "CRAB"
 ETWO 'R', 'A'          ;
 ECHR 'B'               ; Encoded as:   "C<248>B"
 EQUB VE

 ECHR 'B'               ; Token 48:     "BAT"
 ETWO 'A', 'T'          ;
 EQUB VE                ; Encoded as:   "B<245>"

 ETWO 'L', 'O'          ; Token 49:     "LOBST"
 ECHR 'B'               ;
 ETWO 'S', 'T'          ; Encoded as:   "<224>B<222>"
 EQUB VE

 EJMP 18                ; Token 50:     "{random 1-8 letter word}"
 EQUB VE                ;
                        ; Encoded as:   "{18}"

 ETWO 'B', 'E'          ; Token 51:     "BESET"
 ECHR 'S'               ;
 ETWO 'E', 'T'          ; Encoded as:   "<247>S<221>"
 EQUB VE

 ECHR 'P'               ; Token 52:     "PLAGUED"
 ETWO 'L', 'A'          ;
 ECHR 'G'               ; Encoded as:   "P<249>GU<252>"
 ECHR 'U'
 ETWO 'E', 'D'
 EQUB VE

 ETWO 'R', 'A'          ; Token 53:     "RAVAGED"
 ECHR 'V'               ;
 ECHR 'A'               ; Encoded as:   "<248>VAG<252>"
 ECHR 'G'
 ETWO 'E', 'D'
 EQUB VE

 ECHR 'C'               ; Token 54:     "CURSED"
 ECHR 'U'               ;
 ECHR 'R'               ; Encoded as:   "CURS<252>"
 ECHR 'S'
 ETWO 'E', 'D'
 EQUB VE

 ECHR 'S'               ; Token 55:     "SCOURGED"
 ECHR 'C'               ;
 ETWO 'O', 'U'          ; Encoded as:   "SC<217>RG<252>"
 ECHR 'R'
 ECHR 'G'
 ETWO 'E', 'D'
 EQUB VE

 ERND 22                ; Token 56:     "[135-139] CIVIL WAR"
 ECHR ' '               ;
 ECHR 'C'               ; Encoded as:   "[22?] CIV<220> W<238>"
 ECHR 'I'
 ECHR 'V'
 ETWO 'I', 'L'
 ECHR ' '
 ECHR 'W'
 ETWO 'A', 'R'
 EQUB VE

 ERND 13                ; Token 57:     "[170-174] [155-159] [160-164]S"
 ECHR ' '               ;
 ERND 4                 ; Encoded as:   "[13?] [4?] [5?]S"
 ECHR ' '
 ERND 5
 ECHR 'S'
 EQUB VE

 ECHR 'A'               ; Token 58:     "A [170-174] DISEASE"
 ECHR ' '               ;
 ERND 13                ; Encoded as:   "A [13?] <241><218>A<218>"
 ECHR ' '
 ETWO 'D', 'I'
 ETWO 'S', 'E'
 ECHR 'A'
 ETWO 'S', 'E'
 EQUB VE

 ERND 22                ; Token 59:     "[135-139] EARTHQUAKES"
 ECHR ' '               ;
 ECHR 'E'               ; Encoded as:   "[22?] E<238><226><254>AK<237>"
 ETWO 'A', 'R'
 ETWO 'T', 'H'
 ETWO 'Q', 'U'
 ECHR 'A'
 ECHR 'K'
 ETWO 'E', 'S'
 EQUB VE

 ERND 22                ; Token 60:     "[135-139] SOLAR ACTIVITY"
 ECHR ' '               ;
 ETWO 'S', 'O'          ; Encoded as:   "[22?] <235><249>R AC<251>V<219>Y"
 ETWO 'L', 'A'
 ECHR 'R'
 ECHR ' '
 ECHR 'A'
 ECHR 'C'
 ETWO 'T', 'I'
 ECHR 'V'
 ETWO 'I', 'T'
 ECHR 'Y'
 EQUB VE

 ETOK 175               ; Token 61:     "ITS [26-30] [31-35]"
 ERND 2                 ;
 ECHR ' '               ; Encoded as:   "[175][2?] [3?]"
 ERND 3
 EQUB VE

 ETOK 147               ; Token 62:     "THE {system name adjective} [155-159]
 EJMP 17                ;                 [160-164]"
 ECHR ' '               ;
 ERND 4                 ; Encoded as:   "[147]{17} [4?] [5?]"
 ECHR ' '
 ERND 5
 EQUB VE

 ETOK 175               ; Token 63:     "ITS INHABITANTS' [165-169] [36-40]"
 ETOK 193               ;
 ECHR 'S'               ; Encoded as:   "[175][193]S' [7?] [8?]"
 ECHR '`'
 ECHR ' '
 ERND 7
 ECHR ' '
 ERND 8
 EQUB VE

 EJMP 2                 ; Token 64:     "{sentence case}[235-239]{lower case}"
 ERND 31                ;
 EJMP 13                ; Encoded as:   "{2}[31?]{13}"
 EQUB VE

 ETOK 175               ; Token 65:     "ITS [76-80] [81-85]"
 ERND 16                ;
 ECHR ' '               ; Encoded as:   "[175][16?] [17?]"
 ERND 17
 EQUB VE

 ECHR 'J'               ; Token 66:     "JUICE"
 ECHR 'U'               ;
 ECHR 'I'               ; Encoded as:   "JUI<233>"
 ETWO 'C', 'E'
 EQUB VE

 ECHR 'B'               ; Token 67:     "BRANDY"
 ETWO 'R', 'A'          ;
 ECHR 'N'               ; Encoded as:   "B<248>NDY"
 ECHR 'D'
 ECHR 'Y'
 EQUB VE

 ECHR 'W'               ; Token 68:     "WATER"
 ETWO 'A', 'T'          ;
 ETWO 'E', 'R'          ; Encoded as:   "W<245><244>"
 EQUB VE

 ECHR 'B'               ; Token 69:     "BREW"
 ETWO 'R', 'E'          ;
 ECHR 'W'               ; Encoded as:   "B<242>W"
 EQUB VE

 ECHR 'G'               ; Token 70:     "GARGLE BLASTERS"
 ETWO 'A', 'R'          ;
 ECHR 'G'               ; Encoded as:   "G<238>G<229> B<249><222><244>S"
 ETWO 'L', 'E'
 ECHR ' '
 ECHR 'B'
 ETWO 'L', 'A'
 ETWO 'S', 'T'
 ETWO 'E', 'R'
 ECHR 'S'
 EQUB VE

 EJMP 18                ; Token 71:     "{random 1-8 letter word}"
 EQUB VE                ;
                        ; Encoded as:   "{18}"

 EJMP 17                ; Token 72:     "{system name adjective} [160-164]"
 ECHR ' '               ;
 ERND 5                 ; Encoded as:   "{17} [5?]"
 EQUB VE

 EJMP 17                ; Token 73:     "{system name adjective} {random 1-8
 ECHR ' '               ;                letter word}"
 EJMP 18                ;
 EQUB VE                ; Encoded as:   "{17} {18}"

 EJMP 17                ; Token 74:     "{system name adjective} [170-174]"
 ECHR ' '               ;
 ERND 13                ; Encoded as:   "{17} [13?]"
 EQUB VE

 ERND 13                ; Token 75:     "[170-174] {random 1-8 letter word}"
 ECHR ' '               ;
 EJMP 18                ; Encoded as:   "[13?] {18}"
 EQUB VE

 ECHR 'F'               ; Token 76:     "FABULOUS"
 ETWO 'A', 'B'          ;
 ECHR 'U'               ; Encoded as:   "F<216>U<224><236>"
 ETWO 'L', 'O'
 ETWO 'U', 'S'
 EQUB VE

 ECHR 'E'               ; Token 77:     "EXOTIC"
 ECHR 'X'               ;
 ECHR 'O'               ; Encoded as:   "EXO<251>C"
 ETWO 'T', 'I'
 ECHR 'C'
 EQUB VE

 ECHR 'H'               ; Token 78:     "HOOPY"
 ECHR 'O'               ;
 ECHR 'O'               ; Encoded as:   "HOOPY"
 ECHR 'P'
 ECHR 'Y'
 EQUB VE

 ECHR 'U'               ; Token 79:     "UNUSUAL"
 ETWO 'N', 'U'          ;
 ECHR 'S'               ; Encoded as:   "U<225>SU<228>"
 ECHR 'U'
 ETWO 'A', 'L'
 EQUB VE

 ECHR 'E'               ; Token 80:     "EXCITING"
 ECHR 'X'               ;
 ECHR 'C'               ; Encoded as:   "EXC<219><240>G"
 ETWO 'I', 'T'
 ETWO 'I', 'N'
 ECHR 'G'
 EQUB VE

 ECHR 'C'               ; Token 81:     "CUISINE"
 ECHR 'U'               ;
 ECHR 'I'               ; Encoded as:   "CUIS<240>E"
 ECHR 'S'
 ETWO 'I', 'N'
 ECHR 'E'
 EQUB VE

 ECHR 'N'               ; Token 82:     "NIGHT LIFE"
 ECHR 'I'               ;
 ECHR 'G'               ; Encoded as:   "NIGHT LIFE"
 ECHR 'H'
 ECHR 'T'
 ECHR ' '
 ECHR 'L'
 ECHR 'I'
 ECHR 'F'
 ECHR 'E'
 EQUB VE

 ECHR 'C'               ; Token 83:     "CASINOS"
 ECHR 'A'               ;
 ECHR 'S'               ; Encoded as:   "CASI<227>S"
 ECHR 'I'
 ETWO 'N', 'O'
 ECHR 'S'
 EQUB VE

 ECHR 'S'               ; Token 84:     "SIT COMS"
 ETWO 'I', 'T'          ;
 ECHR ' '               ; Encoded as:   "S<219> COMS"
 ECHR 'C'
 ECHR 'O'
 ECHR 'M'
 ECHR 'S'
 EQUB VE

 EJMP 2                 ; Token 85:     "{sentence case}[235-239]{lower case}"
 ERND 31                ;
 EJMP 13                ; Encoded as:   "{2}[31?]{13}"
 EQUB VE

 EJMP 3                 ; Token 86:     "{selected system name}"
 EQUB VE                ;
                        ; Encoded as:   "{3}"

 ETOK 147               ; Token 87:     "THE PLANET {selected system name}"
 ETOK 145               ;
 ECHR ' '               ; Encoded as:   "[147][145] {3}"
 EJMP 3
 EQUB VE

 ETOK 147               ; Token 88:     "THE WORLD {selected system name}"
 ETOK 146               ;
 ECHR ' '               ; Encoded as:   "[147][146] {3}"
 EJMP 3
 EQUB VE

 ETOK 148               ; Token 89:     "THIS PLANET"
 ETOK 145               ;
 EQUB VE                ; Encoded as:   "[148][145]"

 ETOK 148               ; Token 90:     "THIS WORLD"
 ETOK 146               ;
 EQUB VE                ; Encoded as:   "[148][146]"

 ECHR 'S'               ; Token 91:     "SON OF A BITCH"
 ETWO 'O', 'N'          ;
 ECHR ' '               ; Encoded as:   "S<223> OF[208]B<219>CH"
 ECHR 'O'
 ECHR 'F'
 ETOK 208
 ECHR 'B'
 ETWO 'I', 'T'
 ECHR 'C'
 ECHR 'H'
 EQUB VE

 ECHR 'S'               ; Token 92:     "SCOUNDREL"
 ECHR 'C'               ;
 ETWO 'O', 'U'          ; Encoded as:   "SC<217>ND<242>L"
 ECHR 'N'
 ECHR 'D'
 ETWO 'R', 'E'
 ECHR 'L'
 EQUB VE

 ECHR 'B'               ; Token 93:     "BLACKGUARD"
 ETWO 'L', 'A'          ;
 ECHR 'C'               ; Encoded as:   "B<249>CKGU<238>D"
 ECHR 'K'
 ECHR 'G'
 ECHR 'U'
 ETWO 'A', 'R'
 ECHR 'D'
 EQUB VE

 ECHR 'R'               ; Token 94:     "ROGUE"
 ECHR 'O'               ;
 ECHR 'G'               ; Encoded as:   "ROGUE"
 ECHR 'U'
 ECHR 'E'
 EQUB VE

 ECHR 'W'               ; Token 95:     "WHORESON BEETLE HEADED FLAP EAR'D
 ECHR 'H'               ;                KNAVE"
 ETWO 'O', 'R'          ;
 ETWO 'E', 'S'          ; Encoded as:   "WH<253><237><223> <247><221><229> HEAD
 ETWO 'O', 'N'          ;                [196]F<249>P E<238>'D KNA<250>"
 ECHR ' '
 ETWO 'B', 'E'
 ETWO 'E', 'T'
 ETWO 'L', 'E'
 ECHR ' '
 ECHR 'H'
 ECHR 'E'
 ECHR 'A'
 ECHR 'D'
 ETOK 196
 ECHR 'F'
 ETWO 'L', 'A'
 ECHR 'P'
 ECHR ' '
 ECHR 'E'
 ETWO 'A', 'R'
 ECHR '`'
 ECHR 'D'
 ECHR ' '
 ECHR 'K'
 ECHR 'N'
 ECHR 'A'
 ETWO 'V', 'E'
 EQUB VE

 ECHR 'N'               ; Token 96:     "N UNREMARKABLE"
 ECHR ' '               ;
 ECHR 'U'               ; Encoded as:   "N UN<242><239>RK<216><229>"
 ECHR 'N'
 ETWO 'R', 'E'
 ETWO 'M', 'A'
 ECHR 'R'
 ECHR 'K'
 ETWO 'A', 'B'
 ETWO 'L', 'E'
 EQUB VE

 ECHR ' '               ; Token 97:     " BORING"
 ECHR 'B'               ;
 ETWO 'O', 'R'          ; Encoded as:   " B<253><240>G"
 ETWO 'I', 'N'
 ECHR 'G'
 EQUB VE

 ECHR ' '               ; Token 98:     " DULL"
 ECHR 'D'               ;
 ECHR 'U'               ; Encoded as:   " DULL"
 ECHR 'L'
 ECHR 'L'
 EQUB VE

 ECHR ' '               ; Token 99:     " TEDIOUS"
 ECHR 'T'               ;
 ECHR 'E'               ; Encoded as:   " TE<241>O<236>"
 ETWO 'D', 'I'
 ECHR 'O'
 ETWO 'U', 'S'
 EQUB VE

 ECHR ' '               ; Token 100:    " REVOLTING"
 ETWO 'R', 'E'          ;
 ECHR 'V'               ; Encoded as:   " <242>VOLT<240>G"
 ECHR 'O'
 ECHR 'L'
 ECHR 'T'
 ETWO 'I', 'N'
 ECHR 'G'
 EQUB VE

 ETOK 145               ; Token 101:    "PLANET"
 EQUB VE                ;
                        ; Encoded as:   "[145]"

 ETOK 146               ; Token 102:    "WORLD"
 EQUB VE                ;
                        ; Encoded as:   "[146]"

 ECHR 'P'               ; Token 103:    "PLACE"
 ETWO 'L', 'A'          ;
 ETWO 'C', 'E'          ; Encoded as:   "P<249><233>"
 EQUB VE

 ECHR 'L'               ; Token 104:    "LITTLE PLANET"
 ETWO 'I', 'T'          ;
 ECHR 'T'               ; Encoded as:   "L<219>T<229> [145]"
 ETWO 'L', 'E'
 ECHR ' '
 ETOK 145
 EQUB VE

 ECHR 'D'               ; Token 105:    "DUMP"
 ECHR 'U'               ;
 ECHR 'M'               ; Encoded as:   "DUMP"
 ECHR 'P'
 EQUB VE

 ECHR 'I'               ; Token 106:    "I HEAR A [130-134] LOOKING SHIP
 ECHR ' '               ;                APPEARED AT ERRIUS"
 ECHR 'H'               ;
 ECHR 'E'               ; Encoded as:   "I HE<238>[208][23?] <224>OK[195][207]
 ETWO 'A', 'R'          ;                 APPE<238>[196]<245>[209]"
 ETOK 208
 ERND 23
 ECHR ' '
 ETWO 'L', 'O'
 ECHR 'O'
 ECHR 'K'
 ETOK 195
 ETOK 207
 ECHR ' '
 ECHR 'A'
 ECHR 'P'
 ECHR 'P'
 ECHR 'E'
 ETWO 'A', 'R'
 ETOK 196
 ETWO 'A', 'T'
 ETOK 209
 EQUB VE

 ECHR 'Y'               ; Token 107:    "YEAH, I HEAR A [130-134] SHIP LEFT
 ECHR 'E'               ;                ERRIUS A  WHILE BACK"
 ECHR 'A'               ;
 ECHR 'H'               ; Encoded as:   "YEAH, I HE<238>[208][23?] [207]
 ECHR ','               ;                 <229>FT[209][208] WHI<229> BACK"
 ECHR ' '
 ECHR 'I'
 ECHR ' '
 ECHR 'H'
 ECHR 'E'
 ETWO 'A', 'R'
 ETOK 208
 ERND 23
 ECHR ' '
 ETOK 207
 ECHR ' '
 ETWO 'L', 'E'
 ECHR 'F'
 ECHR 'T'
 ETOK 209
 ETOK 208
 ECHR ' '
 ECHR 'W'
 ECHR 'H'
 ECHR 'I'
 ETWO 'L', 'E'
 ECHR ' '
 ECHR 'B'
 ECHR 'A'
 ECHR 'C'
 ECHR 'K'
 EQUB VE

 ECHR 'G'               ; Token 108:    "GET YOUR IRON ASS OVER TO ERRIUS"
 ETWO 'E', 'T'          ;
 ECHR ' '               ; Encoded as:   "G<221> [179]R IR<223> ASS OV<244> TO
 ETOK 179               ;                [209]"
 ECHR 'R'
 ECHR ' '
 ECHR 'I'
 ECHR 'R'
 ETWO 'O', 'N'
 ECHR ' '
 ECHR 'A'
 ECHR 'S'
 ECHR 'S'
 ECHR ' '
 ECHR 'O'
 ECHR 'V'
 ETWO 'E', 'R'
 ECHR ' '
 ECHR 'T'
 ECHR 'O'
 ETOK 209
 EQUB VE

 ETWO 'S', 'O'          ; Token 109:    "SOME [91-95] NEW SHIP WAS SEEN AT
 ECHR 'M'               ;                ERRIUS"
 ECHR 'E'               ;
 ECHR ' '               ; Encoded as:   "<235>ME [24?][210][207] WAS <218><246>
 ERND 24                ;                 <245>[209]"
 ETOK 210
 ETOK 207
 ECHR ' '
 ECHR 'W'
 ECHR 'A'
 ECHR 'S'
 ECHR ' '
 ETWO 'S', 'E'
 ETWO 'E', 'N'
 ECHR ' '
 ETWO 'A', 'T'
 ETOK 209
 EQUB VE

 ECHR 'T'               ; Token 110:    "TRY ERRIUS"
 ECHR 'R'               ;
 ECHR 'Y'               ; Encoded as:   "TRY[209]"
 ETOK 209
 EQUB VE

 ECHR ' '               ; Token 111:    " CUDDLY"
 ECHR 'C'               ;
 ECHR 'U'               ; Encoded as:   " CUDDLY"
 ECHR 'D'
 ECHR 'D'
 ECHR 'L'
 ECHR 'Y'
 EQUB VE

 ECHR ' '               ; Token 112:    " CUTE"
 ECHR 'C'               ;
 ECHR 'U'               ; Encoded as:   " CUTE"
 ECHR 'T'
 ECHR 'E'
 EQUB VE

 ECHR ' '               ; Token 113:    " FURRY"
 ECHR 'F'               ;
 ECHR 'U'               ; Encoded as:   " FURRY"
 ECHR 'R'
 ECHR 'R'
 ECHR 'Y'
 EQUB VE

 ECHR ' '               ; Token 114:    " FRIENDLY"
 ECHR 'F'               ;
 ECHR 'R'               ; Encoded as:   " FRI<246>DLY"
 ECHR 'I'
 ETWO 'E', 'N'
 ECHR 'D'
 ECHR 'L'
 ECHR 'Y'
 EQUB VE

 ECHR 'W'               ; Token 115:    "WASP"
 ECHR 'A'               ;
 ECHR 'S'               ; Encoded as:   "WASP"
 ECHR 'P'
 EQUB VE

 ECHR 'M'               ; Token 116:    "MOTH"
 ECHR 'O'               ;
 ETWO 'T', 'H'          ; Encoded as:   "MO<226>"
 EQUB VE

 ECHR 'G'               ; Token 117:    "GRUB"
 ECHR 'R'               ;
 ECHR 'U'               ; Encoded as:   "GRUB"
 ECHR 'B'
 EQUB VE

 ETWO 'A', 'N'          ; Token 118:    "ANT"
 ECHR 'T'               ;
 EQUB VE                ; Encoded as:   "<255>T"

 EJMP 18                ; Token 119:    "{random 1-8 letter word}"
 EQUB VE                ;
                        ; Encoded as:   "{18}"

 ECHR 'P'               ; Token 120:    "POET"
 ECHR 'O'               ;
 ETWO 'E', 'T'          ; Encoded as:   "PO<221>"
 EQUB VE

 ETWO 'A', 'R'          ; Token 121:    "ARTS GRADUATE"
 ECHR 'T'               ;
 ECHR 'S'               ; Encoded as:   "<238>TS G<248>DU<245>E"
 ECHR ' '
 ECHR 'G'
 ETWO 'R', 'A'
 ECHR 'D'
 ECHR 'U'
 ETWO 'A', 'T'
 ECHR 'E'
 EQUB VE

 ECHR 'Y'               ; Token 122:    "YAK"
 ECHR 'A'               ;
 ECHR 'K'               ; Encoded as:   "YAK"
 EQUB VE

 ECHR 'S'               ; Token 123:    "SNAIL"
 ECHR 'N'               ;
 ECHR 'A'               ; Encoded as:   "SNA<220>"
 ETWO 'I', 'L'
 EQUB VE

 ECHR 'S'               ; Token 124:    "SLUG"
 ECHR 'L'               ;
 ECHR 'U'               ; Encoded as:   "SLUG"
 ECHR 'G'
 EQUB VE

 ECHR 'T'               ; Token 125:    "TROPICAL"
 ECHR 'R'               ;
 ECHR 'O'               ; Encoded as:   "TROPIC<228>"
 ECHR 'P'
 ECHR 'I'
 ECHR 'C'
 ETWO 'A', 'L'
 EQUB VE

 ECHR 'D'               ; Token 126:    "DENSE"
 ETWO 'E', 'N'          ;
 ETWO 'S', 'E'          ; Encoded as:   "D<246><218>"
 EQUB VE

 ETWO 'R', 'A'          ; Token 127:    "RAIN"
 ETWO 'I', 'N'          ;
 EQUB VE                ; Encoded as:   "<248><240>"

 ECHR 'I'               ; Token 128:    "IMPENETRABLE"
 ECHR 'M'               ;
 ECHR 'P'               ; Encoded as:   "IMP<246><221><248>B<229>"
 ETWO 'E', 'N'
 ETWO 'E', 'T'
 ETWO 'R', 'A'
 ECHR 'B'
 ETWO 'L', 'E'
 EQUB VE

 ECHR 'E'               ; Token 129:    "EXUBERANT"
 ECHR 'X'               ;
 ECHR 'U'               ; Encoded as:   "EXU<247><248>NT"
 ETWO 'B', 'E'
 ETWO 'R', 'A'
 ECHR 'N'
 ECHR 'T'
 EQUB VE

 ECHR 'F'               ; Token 130:    "FUNNY"
 ECHR 'U'               ;
 ECHR 'N'               ; Encoded as:   "FUNNY"
 ECHR 'N'
 ECHR 'Y'
 EQUB VE

 ECHR 'W'               ; Token 131:    "WEIRD"
 ECHR 'E'               ;
 ECHR 'I'               ; Encoded as:   "WEIRD"
 ECHR 'R'               ;
 ECHR 'D'
 EQUB VE

 ECHR 'U'               ; Token 132:    "UNUSUAL"
 ETWO 'N', 'U'          ;
 ECHR 'S'               ; Encoded as:   "U<225>SU<228>"
 ECHR 'U'
 ETWO 'A', 'L'
 EQUB VE

 ETWO 'S', 'T'          ; Token 133:    "STRANGE"
 ETWO 'R', 'A'          ;
 ECHR 'N'               ; Encoded as:   "<222><248>N<231>"
 ETWO 'G', 'E'
 EQUB VE

 ECHR 'P'               ; Token 134:    "PECULIAR"
 ECHR 'E'               ;
 ECHR 'C'               ; Encoded as:   "PECULI<238>"
 ECHR 'U'
 ECHR 'L'
 ECHR 'I'
 ETWO 'A', 'R'
 EQUB VE

 ECHR 'F'               ; Token 135:    "FREQUENT"
 ETWO 'R', 'E'          ;
 ETWO 'Q', 'U'          ; Encoded as:   "F<242><254><246>T"
 ETWO 'E', 'N'
 ECHR 'T'
 EQUB VE

 ECHR 'O'               ; Token 136:    "OCCASIONAL"
 ECHR 'C'               ;
 ECHR 'C'               ; Encoded as:   "OCCASI<223><228>"
 ECHR 'A'
 ECHR 'S'
 ECHR 'I'
 ETWO 'O', 'N'
 ETWO 'A', 'L'
 EQUB VE

 ECHR 'U'               ; Token 137:    "UNPREDICTABLE"
 ECHR 'N'               ;
 ECHR 'P'               ; Encoded as:   "UNP<242><241>CT<216><229>"
 ETWO 'R', 'E'
 ETWO 'D', 'I'
 ECHR 'C'
 ECHR 'T'
 ETWO 'A', 'B'
 ETWO 'L', 'E'
 EQUB VE

 ECHR 'D'               ; Token 138:    "DREADFUL"
 ETWO 'R', 'E'          ;
 ECHR 'A'               ; Encoded as:   "D<242>ADFUL"
 ECHR 'D'
 ECHR 'F'
 ECHR 'U'
 ECHR 'L'
 EQUB VE

 ETOK 171               ; Token 139:    "DEADLY"
 EQUB VE                ;
                        ; Encoded as:   "[171]"

 ERND 1                 ; Token 140:    "[21-25] [16-20] FOR [61-65]"
 ECHR ' '               ;
 ERND 0                 ; Encoded as:   "[1?] [0?] F<253> [10?]"
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ERND 10
 EQUB VE

 ETOK 140               ; Token 141:    "[21-25] [16-20] FOR [61-65] AND
 ETOK 178               ;                [61-65]"
 ERND 10                ;
 EQUB VE                ; Encoded as:   "[140][178][10?]"

 ERND 11                ; Token 142:    "[51-55] BY [56-60]"
 ECHR ' '               ;
 ECHR 'B'               ; Encoded as:   "[11?] BY [12?]"
 ECHR 'Y'
 ECHR ' '
 ERND 12
 EQUB VE

 ETOK 140               ; Token 143:    "[21-25] [16-20] FOR [61-65] BUT [51-55]
 ECHR ' '               ;                BY [56-60]"
 ECHR 'B'               ;
 ECHR 'U'               ; Encoded as:   "[140] BUT [142]"
 ECHR 'T'
 ECHR ' '
 ETOK 142
 EQUB VE

 ECHR ' '               ; Token 144:    " A[96-100] [101-105]"
 ECHR 'A'               ;
 ERND 20                ; Encoded as:   " A[20?] [21?]"
 ECHR ' '
 ERND 21
 EQUB VE

 ECHR 'P'               ; Token 145:    "PLANET"
 ECHR 'L'               ;
 ETWO 'A', 'N'          ; Encoded as:   "PL<255><221>"
 ETWO 'E', 'T'
 EQUB VE

 ECHR 'W'               ; Token 146:    "WORLD"
 ETWO 'O', 'R'          ;
 ECHR 'L'               ; Encoded as:   "W<253>LD"
 ECHR 'D'
 EQUB VE

 ETWO 'T', 'H'          ; Token 147:    "THE "
 ECHR 'E'               ;
 ECHR ' '               ; Encoded as:   "<226>E "
 EQUB VE

 ETWO 'T', 'H'          ; Token 148:    "THIS "
 ECHR 'I'               ;
 ECHR 'S'               ; Encoded as:   "<226>IS "
 ECHR ' '
 EQUB VE

 ETWO 'L', 'O'          ; Token 149:    "LOAD NEW {single cap}COMMANDER"
 ECHR 'A'               ;
 ECHR 'D'               ; Encoded as:   "<224>AD[210][154]"
 ETOK 210
 ETOK 154
 EQUB VE

 EJMP 9                 ; Token 150:    "{clear screen}
 EJMP 11                ;                {draw box around title}
 EJMP 1                 ;                {all caps}
 EJMP 8                 ;                {tab 6}"
 EQUB VE                ;
                        ; Encoded as:   "{9}{11}{1}{8}"

 ECHR 'D'               ; Token 151:    "DRIVE"
 ECHR 'R'               ;
 ECHR 'I'               ; Encoded as:   "DRI<250>"
 ETWO 'V', 'E'
 EQUB VE

 ECHR ' '               ; Token 152:    " CATALOGUE"
 ECHR 'C'               ;
 ETWO 'A', 'T'          ; Encoded as:   " C<245>A<224>GUE"
 ECHR 'A'
 ETWO 'L', 'O'
 ECHR 'G'
 ECHR 'U'
 ECHR 'E'
 EQUB VE

 ECHR 'I'               ; Token 153:    "IAN"
 ETWO 'A', 'N'          ;
 EQUB VE                ; Encoded as:   "I<255>"

 EJMP 19                ; Token 154:    "{single cap}COMMANDER"
 ECHR 'C'               ;
 ECHR 'O'               ; Encoded as:   "{19}COMM<255>D<244>"
 ECHR 'M'
 ECHR 'M'
 ETWO 'A', 'N'
 ECHR 'D'
 ETWO 'E', 'R'
 EQUB VE

 ERND 13                ; Token 155:    "[170-174]"
 EQUB VE                ;
                        ; Encoded as:   "[13?]"

 ECHR 'M'               ; Token 156:    "MOUNTAIN"
 ETWO 'O', 'U'          ;
 ECHR 'N'               ; Encoded as:   "M<217>NTA<240>"
 ECHR 'T'
 ECHR 'A'
 ETWO 'I', 'N'
 EQUB VE

 ETWO 'E', 'D'          ; Token 157:    "EDIBLE"
 ECHR 'I'               ;
 ECHR 'B'               ; Encoded as:   "<252>IB<229>"
 ETWO 'L', 'E'
 EQUB VE

 ECHR 'T'               ; Token 158:    "TREE"
 ETWO 'R', 'E'          ;
 ECHR 'E'               ; Encoded as:   "T<242>E"
 EQUB VE

 ECHR 'S'               ; Token 159:    "SPOTTED"
 ECHR 'P'               ;
 ECHR 'O'               ; Encoded as:   "SPOTT<252>"
 ECHR 'T'
 ECHR 'T'
 ETWO 'E', 'D'
 EQUB VE

 ERND 29                ; Token 160:    "[225-229]"
 EQUB VE                ;
                        ; Encoded as:   "[29?]"

 ERND 30                ; Token 161:    "[230-234]"
 EQUB VE                ;
                        ; Encoded as:   "[30?]"

 ERND 6                 ; Token 162:    "[46-50]OID"
 ECHR 'O'               ;
 ECHR 'I'               ; Encoded as:   "[6?]OID"
 ECHR 'D'
 EQUB VE

 ERND 36                ; Token 163:    "[120-124]"
 EQUB VE                ;
                        ; Encoded as:   "[36?]"

 ERND 35                ; Token 164:    "[115-119]"
 EQUB VE                ;
                        ; Encoded as:   "[35?]"

 ETWO 'A', 'N'          ; Token 165:    "ANCIENT"
 ECHR 'C'               ;
 ECHR 'I'               ; Encoded as:   "<255>CI<246>T"
 ETWO 'E', 'N'
 ECHR 'T'
 EQUB VE

 ECHR 'E'               ; Token 166:    "EXCEPTIONAL"
 ECHR 'X'               ;
 ETWO 'C', 'E'          ; Encoded as:   "EX<233>P<251><223><228>"
 ECHR 'P'
 ETWO 'T', 'I'
 ETWO 'O', 'N'
 ETWO 'A', 'L'
 EQUB VE

 ECHR 'E'               ; Token 167:    "ECCENTRIC"
 ECHR 'C'               ;
 ETWO 'C', 'E'          ; Encoded as:   "EC<233>NTRIC"
 ECHR 'N'
 ECHR 'T'
 ECHR 'R'
 ECHR 'I'
 ECHR 'C'
 EQUB VE

 ETWO 'I', 'N'          ; Token 168:    "INGRAINED"
 ECHR 'G'               ;
 ETWO 'R', 'A'          ; Encoded as:   "<240>G<248><240><252>"
 ETWO 'I', 'N'
 ETWO 'E', 'D'
 EQUB VE

 ERND 23                ; Token 169:    "[130-134]"
 EQUB VE                ;
                        ; Encoded as:   "[23?]"

 ECHR 'K'               ; Token 170:    "KILLER"
 ETWO 'I', 'L'          ;
 ECHR 'L'               ; Encoded as:   "K<220>L<244>"
 ETWO 'E', 'R'
 EQUB VE

 ECHR 'D'               ; Token 171:    "DEADLY"
 ECHR 'E'               ;
 ECHR 'A'               ; Encoded as:   "DEADLY"
 ECHR 'D'
 ECHR 'L'
 ECHR 'Y'
 EQUB VE

 ECHR 'E'               ; Token 172:    "EVIL"
 ECHR 'V'               ;
 ETWO 'I', 'L'          ; Encoded as:   "EV<220>"
 EQUB VE

 ETWO 'L', 'E'          ; Token 173:    "LETHAL"
 ETWO 'T', 'H'          ;
 ETWO 'A', 'L'          ; Encoded as:   "<229><226><228>"
 EQUB VE

 ECHR 'V'               ; Token 174:    "VICIOUS"
 ECHR 'I'               ;
 ECHR 'C'               ; Encoded as:   "VICIO<236>"
 ECHR 'I'
 ECHR 'O'
 ETWO 'U', 'S'
 EQUB VE

 ETWO 'I', 'T'          ; Token 175:    "ITS "
 ECHR 'S'               ;
 ECHR ' '               ; Encoded as:   "<219>S "
 EQUB VE

 EJMP 13                ; Token 176:    "{lower case}
 EJMP 14                ;                {justify}
 EJMP 19                ;                {single cap}"
 EQUB VE                ;
                        ; Encoded as:   "{13}{14}{19}"

 ECHR '.'               ; Token 177:    ".{cr}
 EJMP 12                ;                {left align}"
 EJMP 15                ;
 EQUB VE                ; Encoded as:   ".{12}{15}"

 ECHR ' '               ; Token 178:    " AND "
 ETWO 'A', 'N'          ;
 ECHR 'D'               ; Encoded as:   " <255>D "
 ECHR ' '
 EQUB VE

 ECHR 'Y'               ; Token 179:    "YOU"
 ETWO 'O', 'U'          ;
 EQUB VE                ; Encoded as:   "Y<217>"

 ECHR 'P'               ; Token 180:    "PARKING METERS"
 ETWO 'A', 'R'          ;
 ECHR 'K'               ; Encoded as:   "P<238>K[195]M<221><244>S"
 ETOK 195
 ECHR 'M'
 ETWO 'E', 'T'
 ETWO 'E', 'R'
 ECHR 'S'
 EQUB VE

 ECHR 'D'               ; Token 181:    "DUST CLOUDS"
 ETWO 'U', 'S'          ;
 ECHR 'T'               ; Encoded as:   "D<236>T C<224>UDS"
 ECHR ' '
 ECHR 'C'
 ETWO 'L', 'O'
 ECHR 'U'
 ECHR 'D'
 ECHR 'S'
 EQUB VE

 ECHR 'I'               ; Token 182:    "ICE BERGS"
 ETWO 'C', 'E'          ;
 ECHR ' '               ; Encoded as:   "I<233> <247>RGS"
 ETWO 'B', 'E'
 ECHR 'R'
 ECHR 'G'
 ECHR 'S'
 EQUB VE

 ECHR 'R'               ; Token 183:    "ROCK FORMATIONS"
 ECHR 'O'               ;
 ECHR 'C'               ; Encoded as:   "ROCK F<253><239><251><223>S"
 ECHR 'K'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ETWO 'M', 'A'
 ETWO 'T', 'I'
 ETWO 'O', 'N'
 ECHR 'S'
 EQUB VE

 ECHR 'V'               ; Token 184:    "VOLCANOES"
 ECHR 'O'               ;
 ECHR 'L'               ; Encoded as:   "VOLCA<227><237>"
 ECHR 'C'
 ECHR 'A'
 ETWO 'N', 'O'
 ETWO 'E', 'S'
 EQUB VE

 ECHR 'P'               ; Token 185:    "PLANT"
 ECHR 'L'               ;
 ETWO 'A', 'N'          ; Encoded as:   "PL<255>T"
 ECHR 'T'
 EQUB VE

 ECHR 'T'               ; Token 186:    "TULIP"
 ECHR 'U'               ;
 ECHR 'L'               ; Encoded as:   "TULIP"
 ECHR 'I'
 ECHR 'P'
 EQUB VE

 ECHR 'B'               ; Token 187:    "BANANA"
 ETWO 'A', 'N'          ;
 ETWO 'A', 'N'          ; Encoded as:   "B<255><255>A"
 ECHR 'A'
 EQUB VE

 ECHR 'C'               ; Token 188:    "CORN"
 ETWO 'O', 'R'          ;
 ECHR 'N'               ; Encoded as:   "C<253>N"
 EQUB VE

 EJMP 18                ; Token 189:    "{random 1-8 letter word}WEED"
 ECHR 'W'               ;
 ECHR 'E'               ; Encoded as:   "{18}WE<252>"
 ETWO 'E', 'D'
 EQUB VE

 EJMP 18                ; Token 190:    "{random 1-8 letter word}"
 EQUB VE                ;
                        ; Encoded as:   "{18}"

 EJMP 17                ; Token 191:    "{system name adjective} {random 1-8
 ECHR ' '               ;                letter word}"
 EJMP 18                ;
 EQUB VE                ; Encoded as:   "{17} {18}"

 EJMP 17                ; Token 192:    "{system name adjective} [170-174]"
 ECHR ' '               ;
 ERND 13                ; Encoded as:   "{17} [13?]"
 EQUB VE

 ETWO 'I', 'N'          ; Token 193:    "INHABITANT"
 ECHR 'H'               ;
 ECHR 'A'               ; Encoded as:   "<240>HA<234>T<255>T"
 ETWO 'B', 'I'
 ECHR 'T'
 ETWO 'A', 'N'
 ECHR 'T'
 EQUB VE

 ETOK 191               ; Token 194:    "{system name adjective} {random 1-8
 EQUB VE                ;                letter word}"
                        ;
                        ; Encoded as:   "[191]"

 ETWO 'I', 'N'          ; Token 195:    "ING "
 ECHR 'G'               ;
 ECHR ' '               ; Encoded as:   "<240>G "
 EQUB VE

 ETWO 'E', 'D'          ; Token 196:    "ED "
 ECHR ' '               ;
 EQUB VE                ; Encoded as:   "<252> "

 ECHR ' '               ; Token 197:    " D.BRABEN & I.BELL"
 ECHR 'D'
 ECHR '.'               ; Encoded as:   " D.B<248><247>N & I.<247>LL"
 ECHR 'B'
 ETWO 'R', 'A'
 ETWO 'B', 'E'
 ECHR 'N'
 ECHR ' '
 ECHR '&'
 ECHR ' '
 ECHR 'I'
 ECHR '.'
 ETWO 'B', 'E'
 ECHR 'L'
 ECHR 'L'
 EQUB VE

 ECHR ' '               ; Token 198:    " LITTLE TRUMBLE"
 ECHR 'L'               ;
 ETWO 'I', 'T'          ; Encoded as:   " L<219>T<229> TRUMB"
 ECHR 'T'
 ETWO 'L', 'E'
 ECHR ' '
 ECHR 'T'
 ECHR 'R'
 ECHR 'U'
 ECHR 'M'
 ECHR 'B'
 ETWO 'L', 'E'
 EQUB VE

 EJMP 25                ; Token 199:    "{incoming message screen, wait 2s}
 EJMP 9                 ;                {clear screen}
 EJMP 29                ;                {tab 6, lower case in words}
 EJMP 14                ;                {justify}
 EJMP 19                ;                {single cap}GOOD{lower case} DAY
 ECHR 'G'               ;                {single cap}COMMANDER {commander
 ECHR 'O'               ;                name}, ALLOW ME TO INTRODUCE MYSELF.
 ECHR 'O'               ;                 {single cap}I AM {single cap}THE
 ECHR 'D'               ;                {single cap}MERCHANT {single cap}
 EJMP 13                ;                PRINCE OF THRUN{lower case} AND {single
 ECHR ' '               ;                cap}I FIND MYSELF FORCED TO SELL MY
 ECHR 'D'               ;                MOST TREASURED POSSESSION.{cr}
 ECHR 'A'               ;                {cr}
 ECHR 'Y'               ;                {single cap}I AM OFFERING
 ECHR ' '               ;                YOU, FOR THE PALTRY SUM OF JUST 5000
 ETOK 154               ;                {single cap}C{single cap}R THE RAREST
 ECHR ' '               ;                THING IN THE {single cap}KNOWN {single
 EJMP 4                 ;                cap}UNIVERSE.{cr}
 ECHR ','               ;                {cr}
 ECHR ' '               ;                {single cap}{lower case}WILL YOU TAKE
 ETWO 'A', 'L'          ;                IT{all caps}(Y/N)?{cr}
 ETWO 'L', 'O'          ;                {left align}{all caps}{tab 6}
 ECHR 'W'               ;
 ECHR ' '               ; Encoded as:   "{25}{9}{29}{14}{19}GOOD{13} DAY [154]
 ECHR 'M'               ;                 [4], <228><224>W ME[201]<240>TRODU
 ECHR 'E'               ;                <233> MY<218>LF. {19}I AM{2} [147]M
 ETOK 201               ;                <244>CH<255>T PR<240><233> OF
 ETWO 'I', 'N'          ;                <226>RUN <255>D I F<240>D MY<218>
 ECHR 'T'               ;                LF F<253><233>D[201]<218>LL MY MO<222>
 ECHR 'R'               ;                 T<242>ASUR<252> POSS<237>SI<223>[204]
 ECHR 'O'               ;                I AM OFF<244>[195]Y<217>, F<253>
 ECHR 'D'               ;                 [147]PALTRY SUM OF JU<222> 4000{19}
 ECHR 'U'               ;                C{19}R [147]<248><242><222> <226>[195]
 ETWO 'C', 'E'          ;                 <240> [147]{2}K<227>WN UNI<250>R<218>
 ECHR ' '               ;                [204]{13}W<220>L Y<217> TAKE <219>{1}
 ECHR 'M'               ;                (Y/N)?{12}{15}{1}{8}"
 ECHR 'Y'
 ETWO 'S', 'E'
 ECHR 'L'
 ECHR 'F'
 ECHR '.'
 ECHR ' '
 EJMP 19
 ECHR 'I'
 ECHR ' '
 ECHR 'A'
 ECHR 'M'
 EJMP 2
 ECHR ' '
 ETOK 147
 ECHR 'M'
 ETWO 'E', 'R'
 ECHR 'C'
 ECHR 'H'
 ETWO 'A', 'N'
 ECHR 'T'
 ECHR ' '
 ECHR 'P'
 ECHR 'R'
 ETWO 'I', 'N'
 ETWO 'C', 'E'
 ECHR ' '
 ECHR 'O'
 ECHR 'F'
 ECHR ' '
 ETWO 'T', 'H'
 ECHR 'R'
 ECHR 'U'
 ECHR 'N'
 EJMP 13
 ETOK 178
 EJMP 19
 ECHR 'I'
 ECHR ' '
 ECHR 'F'
 ETWO 'I', 'N'
 ECHR 'D'
 ECHR ' '
 ECHR 'M'
 ECHR 'Y'
 ETWO 'S', 'E'
 ECHR 'L'
 ECHR 'F'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ETWO 'C', 'E'
 ECHR 'D'
 ETOK 201
 ETWO 'S', 'E'
 ECHR 'L'
 ECHR 'L'
 ECHR ' '
 ECHR 'M'
 ECHR 'Y'
 ECHR ' '
 ECHR 'M'
 ECHR 'O'
 ETWO 'S', 'T'
 ECHR ' '
 ECHR 'T'
 ETWO 'R', 'E'
 ECHR 'A'
 ECHR 'S'
 ECHR 'U'
 ECHR 'R'
 ETWO 'E', 'D'
 ECHR ' '
 ECHR 'P'
 ECHR 'O'
 ECHR 'S'
 ECHR 'S'
 ETWO 'E', 'S'
 ECHR 'S'
 ECHR 'I'
 ETWO 'O', 'N'
 ETOK 204
 ECHR 'I'
 ECHR ' '
 ECHR 'A'
 ECHR 'M'
 ECHR ' '
 ECHR 'O'
 ECHR 'F'
 ECHR 'F'
 ETWO 'E', 'R'
 ETOK 195
 ECHR 'Y'
 ETWO 'O', 'U'
 ECHR ','
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ETOK 147
 ECHR 'P'
 ECHR 'A'
 ECHR 'L'
 ECHR 'T'
 ECHR 'R'
 ECHR 'Y'
 ECHR ' '
 ECHR 'S'
 ECHR 'U'
 ECHR 'M'
 ECHR ' '
 ECHR 'O'
 ECHR 'F'
 ECHR ' '
 ECHR 'J'
 ECHR 'U'
 ETWO 'S', 'T'
 ECHR ' '
 ECHR '5'
 ECHR '0'
 ECHR '0'
 ECHR '0'
 EJMP 19
 ECHR 'C'
 EJMP 19
 ECHR 'R'
 ECHR ' '
 ETOK 147
 ETWO 'R', 'A'
 ETWO 'R', 'E'
 ETWO 'S', 'T'
 ECHR ' '
 ETWO 'T', 'H'
 ETOK 195
 ECHR ' '
 ETWO 'I', 'N'
 ECHR ' '
 ETOK 147
 EJMP 2
 ECHR 'K'
 ETWO 'N', 'O'
 ECHR 'W'
 ECHR 'N'
 ECHR ' '
 ECHR 'U'
 ECHR 'N'
 ECHR 'I'
 ETWO 'V', 'E'
 ECHR 'R'
 ETWO 'S', 'E'
 ETOK 204
 EJMP 13
 ECHR 'W'
 ETWO 'I', 'L'
 ECHR 'L'
 ECHR ' '
 ECHR 'Y'
 ETWO 'O', 'U'
 ECHR ' '
 ECHR 'T'
 ECHR 'A'
 ECHR 'K'
 ECHR 'E'
 ECHR ' '
 ETWO 'I', 'T'
 EJMP 1
 ECHR '('
 ECHR 'Y'
 ECHR '/'
 ECHR 'N'
 ECHR ')'
 ECHR '?'
 EJMP 12
 EJMP 15
 EJMP 1
 EJMP 8
 EQUB VE

 ECHR ' '               ; Token 200:    " NAME? "
 ECHR 'N'               ;
 ECHR 'A'               ; Encoded as:   " NAME? "
 ECHR 'M'
 ECHR 'E'
 ECHR '?'
 ECHR ' '
 EQUB VE

 ECHR ' '               ; Token 201:    " TO "
 ECHR 'T'               ;
 ECHR 'O'               ; Encoded as:   " TO "
 ECHR ' '
 EQUB VE

 ECHR ' '               ; Token 202:    " IS "
 ECHR 'I'               ;
 ECHR 'S'               ; Encoded as:   " IS "
 ECHR ' '
 EQUB VE

 ECHR 'W'               ; Token 203:    "WAS LAST SEEN AT {single cap}"
 ECHR 'A'               ;
 ECHR 'S'               ; Encoded as:   "WAS <249><222> <218><246> <245> {19}"
 ECHR ' '
 ETWO 'L', 'A'
 ETWO 'S', 'T'
 ECHR ' '
 ETWO 'S', 'E'
 ETWO 'E', 'N'
 ECHR ' '
 ETWO 'A', 'T'
 ECHR ' '
 EJMP 19
 EQUB VE

 ECHR '.'               ; Token 204:    ".{cr}
 EJMP 12                ;                 {single cap}"
 ECHR ' '               ;
 EJMP 19                ; Encoded as:   ".{12} {19}"
 EQUB VE

 ECHR 'D'               ; Token 205:    "DOCKED"
 ECHR 'O'               ;
 ECHR 'C'               ; Encoded as:   "DOCK<252>"
 ECHR 'K'
 ETWO 'E', 'D'
 EQUB VE

 EJMP 1                 ; Token 206:    "{all caps}(Y/N)?"
 ECHR '('               ;
 ECHR 'Y'               ; Encoded as:   "{1}(Y/N)?"
 ECHR '/'
 ECHR 'N'
 ECHR ')'
 ECHR '?'
 EQUB VE

 ECHR 'S'               ; Token 207:    "SHIP"
 ECHR 'H'               ;
 ECHR 'I'               ; Encoded as:   "SHIP"
 ECHR 'P'
 EQUB VE

 ECHR ' '               ; Token 208:    " A "
 ECHR 'A'               ;
 ECHR ' '               ; Encoded as:   " A "
 EQUB VE

 ECHR ' '               ; Token 209:    " ERRIUS"
 ETWO 'E', 'R'          ;
 ECHR 'R'               ; Encoded as:   " <244>RI<236>"
 ECHR 'I'
 ETWO 'U', 'S'
 EQUB VE

 ECHR ' '               ; Token 210:    " NEW "
 ECHR 'N'               ;
 ECHR 'E'               ; Encoded as:   " NEW "
 ECHR 'W'
 ECHR ' '
 EQUB VE

 EJMP 2                 ; Token 211:    "{sentence case} HER MAJESTY'S SPACE
 ECHR ' '               ;                 NAVY{lower case}"
 ECHR 'H'               ;
 ETWO 'E', 'R'          ; Encoded as:   "{2} H<244> <239>J<237>TY'S SPA<233> NAV
 ECHR ' '               ;                Y{13}"
 ETWO 'M', 'A'
 ECHR 'J'
 ETWO 'E', 'S'
 ECHR 'T'
 ECHR 'Y'
 ECHR '`'
 ECHR 'S'
 ECHR ' '
 ECHR 'S'
 ECHR 'P'
 ECHR 'A'
 ETWO 'C', 'E'
 ECHR ' '
 ECHR 'N'
 ECHR 'A'
 ECHR 'V'
 ECHR 'Y'
 EJMP 13
 EQUB VE

 ETOK 177               ; Token 212:    ".{cr}
 EJMP 8                 ;                {left align}
 EJMP 1                 ;                {tab 6}{all caps}  MESSAGE ENDS"
 ECHR ' '               ;
 ECHR ' '               ; Encoded as:   "[177]{8}{1}  M<237>SA<231> <246>DS"
 ECHR 'M'
 ETWO 'E', 'S'
 ECHR 'S'
 ECHR 'A'
 ETWO 'G', 'E'
 ECHR ' '
 ETWO 'E', 'N'
 ECHR 'D'
 ECHR 'S'
 EQUB VE

 ECHR ' '               ; Token 213:    " {single cap}COMMANDER {commander
 ETOK 154               ;                name}, I {lower case}AM{sentence case}
 ECHR ' '               ;                CAPTAIN {mission captain's name}
 EJMP 4                 ;                {lower case}OF{sentence case} HER
 ECHR ','               ;                MAJESTY'S SPACE NAVY{lower case}"
 ECHR ' '               ;
 ECHR 'I'               ; Encoded as:   " [154] {4}, I {13}AM{2} CAPTA<240> {27}
 ECHR ' '               ;                 {13}OF[211]"
 EJMP 13
 ECHR 'A'
 ECHR 'M'
 EJMP 2
 ECHR ' '
 ECHR 'C'
 ECHR 'A'
 ECHR 'P'
 ECHR 'T'
 ECHR 'A'
 ETWO 'I', 'N'
 ECHR ' '
 EJMP 27
 ECHR ' '
 EJMP 13
 ECHR 'O'
 ECHR 'F'
 ETOK 211
 EQUB VE

 EQUB VE                ; Token 214:    ""
                        ;
                        ; Encoded as:   ""

 EJMP 15                ; Token 215:    "{left align} UNKNOWN PLANET"
 ECHR ' '               ;
 ECHR 'U'               ; Encoded as:   "{15} UNK<227>WN [145]"
 ECHR 'N'
 ECHR 'K'
 ETWO 'N', 'O'
 ECHR 'W'
 ECHR 'N'
 ECHR ' '
 ETOK 145
 EQUB VE

 EJMP 9                 ; Token 216:    "{clear screen}
 EJMP 8                 ;                {tab 6}
 EJMP 23                ;                {move to row 10, white, lower case}
 EJMP 1                 ;                {all caps}
 ECHR ' '               ;                (space)
 ETWO 'I', 'N'          ;                INCOMING MESSAGE"
 ECHR 'C'               ;
 ECHR 'O'               ; Encoded as:   "{9}{8}{23}{1} <240>COM[195]M<237>SA
 ECHR 'M'               ;                <231>"
 ETOK 195
 ECHR 'M'
 ETWO 'E', 'S'
 ECHR 'S'
 ECHR 'A'
 ETWO 'G', 'E'
 EQUB VE

 ECHR 'C'               ; Token 217:    "CURRUTHERS"
 ECHR 'U'               ;
 ECHR 'R'               ; Encoded as:   "CURRU<226><244>S"
 ECHR 'R'
 ECHR 'U'
 ETWO 'T', 'H'
 ETWO 'E', 'R'
 ECHR 'S'
 EQUB VE

 ECHR 'F'               ; Token 218:    "FOSDYKE SMYTHE"
 ECHR 'O'               ;
 ECHR 'S'               ; Encoded as:   "FOSDYKE SMY<226>E"
 ECHR 'D'
 ECHR 'Y'
 ECHR 'K'
 ECHR 'E'
 ECHR ' '
 ECHR 'S'
 ECHR 'M'
 ECHR 'Y'
 ETWO 'T', 'H'
 ECHR 'E'
 EQUB VE

 ECHR 'F'               ; Token 219:    "FORTESQUE"
 ETWO 'O', 'R'          ;
 ECHR 'T'               ; Encoded as:   "F<253>T<237><254>E"
 ETWO 'E', 'S'
 ETWO 'Q', 'U'
 ECHR 'E'
 EQUB VE

 ETOK 203               ; Token 220:    "WAS LAST SEEN AT {single cap}REESDICE"
 ETWO 'R', 'E'          ;
 ETWO 'E', 'S'          ; Encoded as:   "[203]<242><237><241><233>"
 ETWO 'D', 'I'
 ETWO 'C', 'E'
 EQUB VE

 ECHR 'I'               ; Token 221:    "IS BELIEVED TO HAVE JUMPED TO THIS
 ECHR 'S'               ;                GALAXY"
 ECHR ' '               ;
 ETWO 'B', 'E'          ; Encoded as:   "IS <247>LIEV<252>[201]HA<250> JUMP<252>
 ECHR 'L'               ;                [201][148]G<228>AXY"
 ECHR 'I'
 ECHR 'E'
 ECHR 'V'
 ETWO 'E', 'D'
 ETOK 201
 ECHR 'H'
 ECHR 'A'
 ETWO 'V', 'E'
 ECHR ' '
 ECHR 'J'
 ECHR 'U'
 ECHR 'M'
 ECHR 'P'
 ETWO 'E', 'D'
 ETOK 201
 ETOK 148
 ECHR 'G'
 ETWO 'A', 'L'
 ECHR 'A'
 ECHR 'X'
 ECHR 'Y'
 EQUB VE

 EJMP 25                ; Token 222:    "{incoming message screen, wait 2s}
 EJMP 9                 ;                {clear screen}
 EJMP 29                ;                {tab 6, white, lower case in words}
 EJMP 14                ;                {justify}
 EJMP 2                 ;                {sentence case}
 ECHR 'G'               ;                GOOD DAY {single cap}COMMANDER
 ECHR 'O'               ;                {commander name}.{cr}
 ECHR 'O'               ;                 {single cap}I{lower case} AM {single
 ECHR 'D'               ;                cap}AGENT{single cap}BLAKE OF {single
 ECHR ' '               ;                cap}NAVAL {single cap}INTELLEGENCE.{cr}
 ECHR 'D'               ;                 {single cap}AS YOU KNOW, THE {single
 ECHR 'A'               ;                cap}NAVY HAVE BEEN KEEPING THE {single
 ECHR 'Y'               ;                cap}THARGOIDS OFF YOUR ASS OUT IN DEEP
 ECHR ' '               ;                SPACE FOR MANY YEARS NOW. {single cap}
 ETOK 154               ;                WELL THE SITUATION HAS CHANGED.{cr}
 ECHR ' '               ;                 {single cap}OUR BOYS ARE READY FOR A
 EJMP 4                 ;                PUSH RIGHT TO THE HOME SYSTEM OF THOSE
 ETOK 204               ;                MURDERERS.{cr}
 ECHR 'I'               ;                 {single cap}
 EJMP 13                ;                {wait for key press}
 ECHR ' '               ;                {clear screen}
 ECHR 'A'               ;                {white}
 ECHR 'M'               ;                {tab 6, white, lower case in words}
 ECHR ' '               ;                I{lower case} HAVE OBTAINED THE DEFENCE
 EJMP 19                ;                PLANS FOR THEIR {single cap}HIVE
 ECHR 'A'               ;                {single cap}WORLDS.{cr} {single cap}THE
 ECHR 'G'               ;                BEETLES KNOW WE'VE GOT SOMETHING BUT
 ETWO 'E', 'N'          ;                NOT WHAT.{cr} {single cap}IF {single
 ECHR 'T'               ;                cap}I TRANSMIT THE PLANS TO OUR BASE ON
 ECHR ' '               ;                {single cap}BIRERA THEY'LL INTERCEPT
 EJMP 19                ;                THE TRANSMISSION. {single cap}I NEED A
 ECHR 'B'               ;                SHIP TO MAKE THE RUN.{cr}
 ETWO 'L', 'A'          ;                 {single cap}YOU'RE ELECTED.{cr}
 ECHR 'K'               ;                 {single cap}THE PLANS ARE UNIPULSE
 ECHR 'E'               ;                CODED WITHIN THIS TRANSMISSION.{cr}
 ECHR ' '               ;                 {single cap}{tab 6}YOU WILL BE
 ECHR 'O'               ;                PAID.{cr}
 ECHR 'F'               ;                 {single cap}    {single cap}GOOD LUCK
 ECHR ' '               ;                {single cap}COMMANDER.{cr}
 EJMP 19                ;                {left align}
 ECHR 'N'               ;                {tab 6}{all caps}  MESSAGE ENDS
 ECHR 'A'               ;                {wait for key press}"
 ECHR 'V'               ;
 ETWO 'A', 'L'          ; Encoded as:   "{25}{9}{29}{14}{2}GOOD DAY [154]
 ECHR ' '               ;                 {4}[204]I{13} AM {19}AG<246>T {19}B
 EJMP 19                ;                <249>KE OF {19}NAV<228> {19}<240>TELLI
 ETWO 'I', 'N'          ;                G<246><233>[204]AS [179] K<227>W, [147]
 ECHR 'T'               ;                {19}NAVY HA<250> <247><246> KEEP[195]
 ECHR 'E'               ;                [147]{19}<226><238>GOIDS OFF [179]R ASS
 ECHR 'L'               ;                 <217>T <240> DEEP SPA<233> F<253>
 ETWO 'L', 'E'          ;                 <239>NY YE<238>S <227>W. {19}WELL
                        ;                 [147]S<219>UA<251><223> HAS CH<255>G
 ECHR 'G'               ;                <252>[204]<217>R BOYS <238>E <242>ADY F
 ETWO 'E', 'N'          ;                <253>[208]PUSH RIGHT[201][147]HOME
 ETWO 'C', 'E'          ;                 SYSTEM OF <226>O<218> MURD<244><244>S
 ETOK 204               ;                [204]{24}{9}{29}I{13} HA<250> OBTA
 ECHR 'A'               ;                <240>[196][147]DEF<246><233> P<249>NS F
 ECHR 'S'               ;                <253> <226>EIR {19}HI<250> {19}W<253>LD
 ECHR ' '               ;                S[204][147]<247><221><229>S K<227>W WE'
 ETOK 179               ;                <250> GOT <235>ME<226>[195]BUT <227>T W
 ECHR ' '               ;                H<245>[204]IF {19}I T<248>NSM<219>
 ECHR 'K'               ;                 [147]P<249>NS[201]<217>R BA<218> <223>
 ETWO 'N', 'O'          ;                 {19}<234><242><248> <226>EY'LL <240>T
 ECHR 'W'               ;                <244><233>PT [147]TR<255>SMISSI<223>.
 ECHR ','               ;                 {19}I NE<252>[208][207][201]<239>KE
 ECHR ' '               ;                 [147]RUN[204][179]'<242> E<229>CT<252>
 ETOK 147               ;                [204][147]P<249>NS A<242> UNIPUL<218> C
 EJMP 19                ;                OD[196]WI<226><240> [148]TR<255>SMISSI
 ECHR 'N'               ;                <223>[204]{8}[179] W<220>L <247> PAID
 ECHR 'A'               ;                [204]    {19}GOOD LUCK [154][212]{24}"
 ECHR 'V'
 ECHR 'Y'
 ECHR ' '
 ECHR 'H'
 ECHR 'A'
 ETWO 'V', 'E'
 ECHR ' '
 ETWO 'B', 'E'
 ETWO 'E', 'N'
 ECHR ' '
 ECHR 'K'
 ECHR 'E'
 ECHR 'E'
 ECHR 'P'
 ETOK 195
 ETOK 147
 EJMP 19
 ETWO 'T', 'H'
 ETWO 'A', 'R'
 ECHR 'G'
 ECHR 'O'
 ECHR 'I'
 ECHR 'D'
 ECHR 'S'
 ECHR ' '
 ECHR 'O'
 ECHR 'F'
 ECHR 'F'
 ECHR ' '
 ETOK 179
 ECHR 'R'
 ECHR ' '
 ECHR 'A'
 ECHR 'S'
 ECHR 'S'
 ECHR ' '
 ETWO 'O', 'U'
 ECHR 'T'
 ECHR ' '
 ETWO 'I', 'N'
 ECHR ' '
 ECHR 'D'
 ECHR 'E'
 ECHR 'E'
 ECHR 'P'
 ECHR ' '
 ECHR 'S'
 ECHR 'P'
 ECHR 'A'
 ETWO 'C', 'E'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ETWO 'M', 'A'
 ECHR 'N'
 ECHR 'Y'
 ECHR ' '
 ECHR 'Y'
 ECHR 'E'
 ETWO 'A', 'R'
 ECHR 'S'
 ECHR ' '
 ETWO 'N', 'O'
 ECHR 'W'
 ECHR '.'
 ECHR ' '
 EJMP 19
 ECHR 'W'
 ECHR 'E'
 ECHR 'L'
 ECHR 'L'
 ECHR ' '
 ETOK 147
 ECHR 'S'
 ETWO 'I', 'T'
 ECHR 'U'
 ECHR 'A'
 ETWO 'T', 'I'
 ETWO 'O', 'N'
 ECHR ' '
 ECHR 'H'
 ECHR 'A'
 ECHR 'S'
 ECHR ' '
 ECHR 'C'
 ECHR 'H'
 ETWO 'A', 'N'
 ECHR 'G'
 ETWO 'E', 'D'
 ETOK 204
 ETWO 'O', 'U'
 ECHR 'R'
 ECHR ' '
 ECHR 'B'
 ECHR 'O'
 ECHR 'Y'
 ECHR 'S'
 ECHR ' '
 ETWO 'A', 'R'
 ECHR 'E'
 ECHR ' '
 ETWO 'R', 'E'
 ECHR 'A'
 ECHR 'D'
 ECHR 'Y'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ETOK 208
 ECHR 'P'
 ECHR 'U'
 ECHR 'S'
 ECHR 'H'
 ECHR ' '
 ECHR 'R'
 ECHR 'I'
 ECHR 'G'
 ECHR 'H'
 ECHR 'T'
 ETOK 201
 ETOK 147
 ECHR 'H'
 ECHR 'O'
 ECHR 'M'
 ECHR 'E'
 ECHR ' '
 ECHR 'S'
 ECHR 'Y'
 ECHR 'S'
 ECHR 'T'
 ECHR 'E'
 ECHR 'M'
 ECHR ' '
 ECHR 'O'
 ECHR 'F'
 ECHR ' '
 ETWO 'T', 'H'
 ECHR 'O'
 ETWO 'S', 'E'
 ECHR ' '
 ECHR 'M'
 ECHR 'U'
 ECHR 'R'
 ECHR 'D'
 ETWO 'E', 'R'
 ETWO 'E', 'R'
 ECHR 'S'
 ETOK 204
 EJMP 24
 EJMP 9
 EJMP 29
 ECHR 'I'
 EJMP 13
 ECHR ' '
 ECHR 'H'
 ECHR 'A'
 ETWO 'V', 'E'
 ECHR ' '
 ECHR 'O'
 ECHR 'B'
 ECHR 'T'
 ECHR 'A'
 ETWO 'I', 'N'
 ETOK 196
 ETOK 147
 ECHR 'D'
 ECHR 'E'
 ECHR 'F'
 ETWO 'E', 'N'
 ETWO 'C', 'E'
 ECHR ' '
 ECHR 'P'
 ETWO 'L', 'A'
 ECHR 'N'
 ECHR 'S'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ETWO 'T', 'H'
 ECHR 'E'
 ECHR 'I'
 ECHR 'R'
 ECHR ' '
 EJMP 19
 ECHR 'H'
 ECHR 'I'
 ETWO 'V', 'E'
 ECHR ' '
 EJMP 19
 ECHR 'W'
 ETWO 'O', 'R'
 ECHR 'L'
 ECHR 'D'
 ECHR 'S'
 ETOK 204
 ETOK 147
 ETWO 'B', 'E'
 ETWO 'E', 'T'
 ETWO 'L', 'E'
 ECHR 'S'
 ECHR ' '
 ECHR 'K'
 ETWO 'N', 'O'
 ECHR 'W'
 ECHR ' '
 ECHR 'W'
 ECHR 'E'
 ECHR '`'
 ETWO 'V', 'E'
 ECHR ' '
 ECHR 'G'
 ECHR 'O'
 ECHR 'T'
 ECHR ' '
 ETWO 'S', 'O'
 ECHR 'M'
 ECHR 'E'
 ETWO 'T', 'H'
 ETOK 195
 ECHR 'B'
 ECHR 'U'
 ECHR 'T'
 ECHR ' '
 ETWO 'N', 'O'
 ECHR 'T'
 ECHR ' '
 ECHR 'W'
 ECHR 'H'
 ETWO 'A', 'T'
 ETOK 204
 ECHR 'I'
 ECHR 'F'
 ECHR ' '
 EJMP 19
 ECHR 'I'
 ECHR ' '
 ECHR 'T'
 ETWO 'R', 'A'
 ECHR 'N'
 ECHR 'S'
 ECHR 'M'
 ETWO 'I', 'T'
 ECHR ' '
 ETOK 147
 ECHR 'P'
 ETWO 'L', 'A'
 ECHR 'N'
 ECHR 'S'
 ETOK 201
 ETWO 'O', 'U'
 ECHR 'R'
 ECHR ' '
 ECHR 'B'
 ECHR 'A'
 ETWO 'S', 'E'
 ECHR ' '
 ETWO 'O', 'N'
 ECHR ' '
 EJMP 19
 ETWO 'B', 'I'
 ETWO 'R', 'E'
 ETWO 'R', 'A'
 ECHR ' '
 ETWO 'T', 'H'
 ECHR 'E'
 ECHR 'Y'
 ECHR '`'
 ECHR 'L'
 ECHR 'L'
 ECHR ' '
 ETWO 'I', 'N'
 ECHR 'T'
 ETWO 'E', 'R'
 ETWO 'C', 'E'
 ECHR 'P'
 ECHR 'T'
 ECHR ' '
 ETOK 147
 ECHR 'T'
 ECHR 'R'
 ETWO 'A', 'N'
 ECHR 'S'
 ECHR 'M'
 ECHR 'I'
 ECHR 'S'
 ECHR 'S'
 ECHR 'I'
 ETWO 'O', 'N'
 ECHR '.'
 ECHR ' '
 EJMP 19
 ECHR 'I'
 ECHR ' '
 ECHR 'N'
 ECHR 'E'
 ETWO 'E', 'D'
 ETOK 208
 ETOK 207
 ETOK 201
 ETWO 'M', 'A'
 ECHR 'K'
 ECHR 'E'
 ECHR ' '
 ETOK 147
 ECHR 'R'
 ECHR 'U'
 ECHR 'N'
 ETOK 204
 ETOK 179
 ECHR '`'
 ETWO 'R', 'E'
 ECHR ' '
 ECHR 'E'
 ETWO 'L', 'E'
 ECHR 'C'
 ECHR 'T'
 ETWO 'E', 'D'
 ETOK 204
 ETOK 147
 ECHR 'P'
 ETWO 'L', 'A'
 ECHR 'N'
 ECHR 'S'
 ECHR ' '
 ECHR 'A'
 ETWO 'R', 'E'
 ECHR ' '
 ECHR 'U'
 ECHR 'N'
 ECHR 'I'
 ECHR 'P'
 ECHR 'U'
 ECHR 'L'
 ETWO 'S', 'E'
 ECHR ' '
 ECHR 'C'
 ECHR 'O'
 ECHR 'D'
 ETOK 196
 ECHR 'W'
 ECHR 'I'
 ETWO 'T', 'H'
 ETWO 'I', 'N'
 ECHR ' '
 ETOK 148
 ECHR 'T'
 ECHR 'R'
 ETWO 'A', 'N'
 ECHR 'S'
 ECHR 'M'
 ECHR 'I'
 ECHR 'S'
 ECHR 'S'
 ECHR 'I'
 ETWO 'O', 'N'
 ETOK 204
 EJMP 8
 ETOK 179
 ECHR ' '
 ECHR 'W'
 ETWO 'I', 'L'
 ECHR 'L'
 ECHR ' '
 ETWO 'B', 'E'
 ECHR ' '
 ECHR 'P'
 ECHR 'A'
 ECHR 'I'
 ECHR 'D'
 ETOK 204
 ECHR ' '
 ECHR ' '
 ECHR ' '
 ECHR ' '
 EJMP 19
 ECHR 'G'
 ECHR 'O'
 ECHR 'O'
 ECHR 'D'
 ECHR ' '
 ECHR 'L'
 ECHR 'U'
 ECHR 'C'
 ECHR 'K'
 ECHR ' '
 ETOK 154
 ETOK 212
 EJMP 24
 EQUB VE

 EJMP 25                ; Token 223:    "{incoming message screen, wait 2s}
 EJMP 9                 ;                {clear screen}
 EJMP 29                ;                {tab 6, white, lower case in words}
 EJMP 8                 ;                {tab 6}
 EJMP 14                ;                {justify}
 EJMP 13                ;                {lower case}
 EJMP 19                ;                {single cap}WELL DONE {single cap}
 ECHR 'W'               ;                COMMANDER.{cr}
 ECHR 'E'               ;                 {single cap}YOU HAVE SERVED US WELL
 ECHR 'L'               ;                AND WE SHALL REMEMBER.{cr}
 ECHR 'L'               ;                 {single cap}WE DID NOT EXPECT THE
 ECHR ' '               ;                {single cap}THARGOIDS TO FIND OUT
 ECHR 'D'               ;                ABOUT YOU.{cr}
 ETWO 'O', 'N'          ;                 {single cap}FOR THE MOMENT PLEASE
 ECHR 'E'               ;                ACCEPT THIS {single cap}NAVY {standard
 ECHR ' '               ;                tokens, sentence case}EXTRA ENERGY
 ETOK 154               ;                UNIT{extended tokens} AS PAYMENT.{cr}
 ETOK 204               ;                {left align}
 ETOK 179               ;                {tab 6}{all caps}  MESSAGE ENDS
 ECHR ' '               ;                {wait for key press}"
 ECHR 'H'               ;
 ECHR 'A'               ; Encoded as:   "{25}{9}{29}{8}{14}{13}{19}WELL D
 ETWO 'V', 'E'          ;                <223>E [154][204][179] HA<250> <218>RV
 ECHR ' '               ;                [196]US WELL[178]WE SH<228>L <242>MEMB
 ETWO 'S', 'E'          ;                <244>[204]WE DID <227>T EXPECT [147]
 ECHR 'R'               ;                {19}<226><238>GOIDS[201]F<240>D <217>T
 ECHR 'V'               ;                 AB<217>T [179][204]F<253> [147]MOM
 ETOK 196               ;                <246>T P<229>A<218> AC<233>PT [148]{19}
 ECHR 'U'               ;                NAVY {6}[114]{5} AS PAYM<246>T[212]
 ECHR 'S'               ;                {24}"
 ECHR ' '
 ECHR 'W'
 ECHR 'E'
 ECHR 'L'
 ECHR 'L'
 ETOK 178
 ECHR 'W'
 ECHR 'E'
 ECHR ' '
 ECHR 'S'
 ECHR 'H'
 ETWO 'A', 'L'
 ECHR 'L'
 ECHR ' '
 ETWO 'R', 'E'
 ECHR 'M'
 ECHR 'E'
 ECHR 'M'
 ECHR 'B'
 ETWO 'E', 'R'
 ETOK 204
 ECHR 'W'
 ECHR 'E'
 ECHR ' '
 ECHR 'D'
 ECHR 'I'
 ECHR 'D'
 ECHR ' '
 ETWO 'N', 'O'
 ECHR 'T'
 ECHR ' '
 ECHR 'E'
 ECHR 'X'
 ECHR 'P'
 ECHR 'E'
 ECHR 'C'
 ECHR 'T'
 ECHR ' '
 ETOK 147
 EJMP 19
 ETWO 'T', 'H'
 ETWO 'A', 'R'
 ECHR 'G'
 ECHR 'O'
 ECHR 'I'
 ECHR 'D'
 ECHR 'S'
 ETOK 201
 ECHR 'F'
 ETWO 'I', 'N'
 ECHR 'D'
 ECHR ' '
 ETWO 'O', 'U'
 ECHR 'T'
 ECHR ' '
 ECHR 'A'
 ECHR 'B'
 ETWO 'O', 'U'
 ECHR 'T'
 ECHR ' '
 ETOK 179
 ETOK 204
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ETOK 147
 ECHR 'M'
 ECHR 'O'
 ECHR 'M'
 ETWO 'E', 'N'
 ECHR 'T'
 ECHR ' '
 ECHR 'P'
 ETWO 'L', 'E'
 ECHR 'A'
 ETWO 'S', 'E'
 ECHR ' '
 ECHR 'A'
 ECHR 'C'
 ETWO 'C', 'E'
 ECHR 'P'
 ECHR 'T'
 ECHR ' '
 ETOK 148
 EJMP 19
 ECHR 'N'
 ECHR 'A'
 ECHR 'V'
 ECHR 'Y'
 ECHR ' '
 EJMP 6
 TOKN 114
 EJMP 5
 ECHR ' '
 ECHR 'A'
 ECHR 'S'
 ECHR ' '
 ECHR 'P'
 ECHR 'A'
 ECHR 'Y'
 ECHR 'M'
 ETWO 'E', 'N'
 ECHR 'T'
 ETOK 212
 EJMP 24
 EQUB VE

 ECHR 'A'               ; Token 224:    "ARE YOU SURE?"
 ETWO 'R', 'E'          ;
 ECHR ' '               ; Encoded as:   "A<242> [179] SU<242>?"
 ETOK 179
 ECHR ' '
 ECHR 'S'
 ECHR 'U'
 ETWO 'R', 'E'
 ECHR '?'
 EQUB VE

 ECHR 'S'               ; Token 225:    "SHREW"
 ECHR 'H'               ;
 ETWO 'R', 'E'          ; Encoded as:   "SH<242>W"
 ECHR 'W'
 EQUB VE

 ETWO 'B', 'E'          ; Token 226:    "BEAST"
 ECHR 'A'               ;
 ETWO 'S', 'T'          ; Encoded as:   "<247>A<222>"
 EQUB VE

 ECHR 'B'               ; Token 227:    "BISON"
 ECHR 'I'               ;
 ECHR 'S'               ; Encoded as:   "BIS<223>"
 ETWO 'O', 'N'
 EQUB VE

 ECHR 'S'               ; Token 228:    "SNAKE"
 ECHR 'N'               ;
 ECHR 'A'               ; Encoded as:   "SNAKE"
 ECHR 'K'
 ECHR 'E'
 EQUB VE

 ECHR 'W'               ; Token 229:    "WOLF"
 ECHR 'O'               ;
 ECHR 'L'               ; Encoded as:   "WOLF"
 ECHR 'F'
 EQUB VE

 ETWO 'L', 'E'          ; Token 230:    "LEOPARD"
 ECHR 'O'               ;
 ECHR 'P'               ; Encoded as:   "<229>OP<238>D"
 ETWO 'A', 'R'
 ECHR 'D'
 EQUB VE

 ECHR 'C'               ; Token 231:    "CAT"
 ETWO 'A', 'T'          ;
 EQUB VE                ; Encoded as:   "C<245>"

 ECHR 'M'               ; Token 232:    "MONKEY"
 ETWO 'O', 'N'          ;
 ECHR 'K'               ; Encoded as:   "M<223>KEY"
 ECHR 'E'
 ECHR 'Y'
 EQUB VE

 ECHR 'G'               ; Token 233:    "GOAT"
 ECHR 'O'               ;
 ETWO 'A', 'T'          ; Encoded as:   "GO<245>"
 EQUB VE

 ECHR 'F'               ; Token 234:    "FISH"
 ECHR 'I'               ;
 ECHR 'S'               ; Encoded as:   "FISH"
 ECHR 'H'
 EQUB VE

 ERND 15                ; Token 235:    "[71-75] [66-70]"
 ECHR ' '               ;
 ERND 14                ; Encoded as:   "[15?] [14?]"
 EQUB VE

 EJMP 17                ; Token 236:    "{system name adjective} [225-229]
 ECHR ' '               ;                 [240-244]"
 ERND 29                ;
 ECHR ' '               ; Encoded as:   "{17} [29?] [32?]"
 ERND 32
 EQUB VE

 ETOK 175               ; Token 237:    "ITS [76-80] [230-234] [240-244]"
 ERND 16                ;
 ECHR ' '               ; Encoded as:   "[175][16?] [30?] [32?]"
 ERND 30
 ECHR ' '
 ERND 32
 EQUB VE

 ERND 33                ; Token 238:    "[245-249] [250-254]"
 ECHR ' '               ;
 ERND 34                ; Encoded as:   "[33?] [34?]"
 EQUB VE

 ERND 15                ; Token 239:    "[71-75] [66-70]"
 ECHR ' '               ;
 ERND 14                ; Encoded as:   "[15?] [14?]"
 EQUB VE

 ECHR 'M'               ; Token 240:    "MEAT"
 ECHR 'E'               ;
 ETWO 'A', 'T'          ; Encoded as:   "ME<245>"
 EQUB VE

 ECHR 'C'               ; Token 241:    "CUTLET"
 ECHR 'U'               ;
 ECHR 'T'               ; Encoded as:   "CUTL<221>"
 ECHR 'L'
 ETWO 'E', 'T'
 EQUB VE

 ETWO 'S', 'T'          ; Token 242:    "STEAK"
 ECHR 'E'               ;
 ECHR 'A'               ; Encoded as:   "<222>EAK"
 ECHR 'K'
 EQUB VE

 ECHR 'B'               ; Token 243:    "BURGERS"
 ECHR 'U'               ;
 ECHR 'R'               ; Encoded as:   "BURG<244>S"
 ECHR 'G'
 ETWO 'E', 'R'
 ECHR 'S'
 EQUB VE

 ETWO 'S', 'O'          ; Token 244:    "SOUP"
 ECHR 'U'               ;
 ECHR 'P'               ; Encoded as:   "<235>UP"
 EQUB VE

 ECHR 'I'               ; Token 245:    "ICE"
 ETWO 'C', 'E'          ;
 EQUB VE                ; Encoded as:   "I<233>"

 ECHR 'M'               ; Token 246:    "MUD"
 ECHR 'U'               ;
 ECHR 'D'               ; Encoded as:   "MUD"
 EQUB VE

 ECHR 'Z'               ; Token 247:    "ZERO-{single cap}G"
 ETWO 'E', 'R'          ;
 ECHR 'O'               ; Encoded as:   "Z<244>O-{19}G"
 ECHR '-'
 EJMP 19
 ECHR 'G'
 EQUB VE

 ECHR 'V'               ; Token 248:    "VACUUM"
 ECHR 'A'               ;
 ECHR 'C'               ; Encoded as:   "VACUUM"
 ECHR 'U'
 ECHR 'U'
 ECHR 'M'
 EQUB VE

 EJMP 17                ; Token 249:    "{system name adjective} ULTRA"
 ECHR ' '               ;
 ECHR 'U'               ; Encoded as:   "{17} ULT<248>"
 ECHR 'L'
 ECHR 'T'
 ETWO 'R', 'A'
 EQUB VE

 ECHR 'H'               ; Token 250:    "HOCKEY"
 ECHR 'O'               ;
 ECHR 'C'               ; Encoded as:   "HOCKEY"
 ECHR 'K'
 ECHR 'E'
 ECHR 'Y'
 EQUB VE

 ECHR 'C'               ; Token 251:    "CRICKET"
 ECHR 'R'               ;
 ECHR 'I'               ; Encoded as:   "CRICK<221>"
 ECHR 'C'
 ECHR 'K'
 ETWO 'E', 'T'
 EQUB VE

 ECHR 'K'               ; Token 252:    "KARATE"
 ETWO 'A', 'R'          ;
 ETWO 'A', 'T'          ; Encoded as:   "K<238><245>E"
 ECHR 'E'
 EQUB VE

 ECHR 'P'               ; Token 253:    "POLO"
 ECHR 'O'               ;
 ETWO 'L', 'O'          ; Encoded as:   "PO<224>"
 EQUB VE

 ECHR 'T'               ; Token 254:    "TENNIS"
 ETWO 'E', 'N'          ;
 ECHR 'N'               ; Encoded as:   "T<246>NIS"
 ECHR 'I'
 ECHR 'S'
 EQUB VE

 EJMP 12                ; Token 255:    "{cr}
 EJMP 30                ;                {currently selected media}
 ECHR ' '               ;                 ERROR"
 ETWO 'E', 'R'          ;
 ECHR 'R'               ; Encoded as:   "{12}{30} <244>R<253>"
 ETWO 'O', 'R'
 EQUB VE

; ******************************************************************************
;
;       Name: RUPLA
;       Type: Variable
;   Category: Text
;    Summary: System numbers that have extended description overrides
;  Deep dive: Extended system descriptions
;             Extended text tokens
;             The Constrictor mission
;
; ------------------------------------------------------------------------------
;
; This table contains the extended token numbers to show as the specified
; system's extended description, if the criteria in the RUGAL table are met.
;
; The three variables work as follows:
;
;   * The RUPLA table contains the system numbers
;
;   * The RUGAL table contains the galaxy numbers and mission criteria
;
;   * The RUTOK table contains the extended token to display instead of the
;     normal extended description if the criteria in RUPLA and RUGAL are met
;
; See the PDESC routine for details of how extended system descriptions work.
;
; This version of Elite contains an extended system description override for
; Lave that welcomes us to the seventeenth galaxy. This is never shown in-game,
; as the galaxy number in RUGAL has to be 16, and this cannot happen.
;
; ******************************************************************************

.RUPLA

 EQUB 211               ; System 211, Galaxy 0                 Teorge = Token  1
 EQUB 150               ; System 150, Galaxy 0, Mission 1        Xeer = Token  2
 EQUB 36                ; System  36, Galaxy 0, Mission 1    Reesdice = Token  3
 EQUB 28                ; System  28, Galaxy 0, Mission 1       Arexe = Token  4
 EQUB 253               ; System 253, Galaxy 1, Mission 1      Errius = Token  5
 EQUB 79                ; System  79, Galaxy 1, Mission 1      Inbibe = Token  6
 EQUB 53                ; System  53, Galaxy 1, Mission 1       Ausar = Token  7
 EQUB 118               ; System 118, Galaxy 1, Mission 1      Usleri = Token  8
 EQUB 100               ; System 100, Galaxy 2                 Arredi = Token  9
 EQUB 32                ; System  32, Galaxy 1, Mission 1      Bebege = Token 10
 EQUB 68                ; System  68, Galaxy 1, Mission 1      Cearso = Token 11
 EQUB 164               ; System 164, Galaxy 1, Mission 1      Dicela = Token 12
 EQUB 220               ; System 220, Galaxy 1, Mission 1      Eringe = Token 13
 EQUB 106               ; System 106, Galaxy 1, Mission 1      Gexein = Token 14
 EQUB 16                ; System  16, Galaxy 1, Mission 1      Isarin = Token 15
 EQUB 162               ; System 162, Galaxy 1, Mission 1    Letibema = Token 16
 EQUB 3                 ; System   3, Galaxy 1, Mission 1      Maisso = Token 17
 EQUB 107               ; System 107, Galaxy 1, Mission 1        Onen = Token 18
 EQUB 26                ; System  26, Galaxy 1, Mission 1      Ramaza = Token 19
 EQUB 192               ; System 192, Galaxy 1, Mission 1      Sosole = Token 20
 EQUB 184               ; System 184, Galaxy 1, Mission 1      Tivere = Token 21
 EQUB 5                 ; System   5, Galaxy 1, Mission 1      Veriar = Token 22
 EQUB 101               ; System 101, Galaxy 2, Mission 1      Xeveon = Token 23
 EQUB 193               ; System 193, Galaxy 1, Mission 1      Orarra = Token 24
 EQUB 41                ; System  41, Galaxy 2                 Anreer = Token 25
 EQUB 1                 ; System   7, Galaxy 16                  Lave = Token 26

; ******************************************************************************
;
;       Name: RUGAL
;       Type: Variable
;   Category: Text
;    Summary: The criteria for systems with extended description overrides
;  Deep dive: Extended system descriptions
;             Extended text tokens
;             The Constrictor mission
;
; ------------------------------------------------------------------------------
;
; This table contains the criteria for printing an extended description override
; for a system. The galaxy number is in bits 0-6, while bit 7 determines whether
; to show this token during mission 1 only (bit 7 is clear, i.e. a value of $0x
; in the table below), or all of the time (bit 7 is set, i.e. a value of $8x in
; the table below).
;
; In other words, Teorge, Arredi, Anreer and Lave have extended description
; overrides that are always shown, while the rest only appear when mission 1 is
; in progress.
;
; The three variables work as follows:
;
;   * The RUPLA table contains the system numbers
;
;   * The RUGAL table contains the galaxy numbers and mission criteria
;
;   * The RUTOK table contains the extended token to display instead of the
;     normal extended description if the criteria in RUPLA and RUGAL are met
;
; See the PDESC routine for details of how extended system descriptions work.
;
; This version of Elite contains an extended system description override for
; Lave that welcomes us to the seventeenth galaxy. This is never shown in-game,
; as the galaxy number in RUGAL has to be 16, and this cannot happen.
;
; ******************************************************************************

.RUGAL

 EQUB $80               ; System 211, Galaxy 0                 Teorge = Token  1
 EQUB $00               ; System 150, Galaxy 0, Mission 1        Xeer = Token  2
 EQUB $00               ; System  36, Galaxy 0, Mission 1    Reesdice = Token  3
 EQUB $00               ; System  28, Galaxy 0, Mission 1       Arexe = Token  4
 EQUB $01               ; System 253, Galaxy 1, Mission 1      Errius = Token  5
 EQUB $01               ; System  79, Galaxy 1, Mission 1      Inbibe = Token  6
 EQUB $01               ; System  53, Galaxy 1, Mission 1       Ausar = Token  7
 EQUB $01               ; System 118, Galaxy 1, Mission 1      Usleri = Token  8
 EQUB $82               ; System 100, Galaxy 2                 Arredi = Token  9
 EQUB $01               ; System  32, Galaxy 1, Mission 1      Bebege = Token 10
 EQUB $01               ; System  68, Galaxy 1, Mission 1      Cearso = Token 11
 EQUB $01               ; System 164, Galaxy 1, Mission 1      Dicela = Token 12
 EQUB $01               ; System 220, Galaxy 1, Mission 1      Eringe = Token 13
 EQUB $01               ; System 106, Galaxy 1, Mission 1      Gexein = Token 14
 EQUB $01               ; System  16, Galaxy 1, Mission 1      Isarin = Token 15
 EQUB $01               ; System 162, Galaxy 1, Mission 1    Letibema = Token 16
 EQUB $01               ; System   3, Galaxy 1, Mission 1      Maisso = Token 17
 EQUB $01               ; System 107, Galaxy 1, Mission 1        Onen = Token 18
 EQUB $01               ; System  26, Galaxy 1, Mission 1      Ramaza = Token 19
 EQUB $01               ; System 192, Galaxy 1, Mission 1      Sosole = Token 20
 EQUB $01               ; System 184, Galaxy 1, Mission 1      Tivere = Token 21
 EQUB $01               ; System   5, Galaxy 1, Mission 1      Veriar = Token 22
 EQUB $02               ; System 101, Galaxy 2, Mission 1      Xeveon = Token 23
 EQUB $01               ; System 193, Galaxy 1, Mission 1      Orarra = Token 24
 EQUB $82               ; System  41, Galaxy 2                 Anreer = Token 25
 EQUB $90               ; System   7, Galaxy 16                  Lave = Token 26

; ******************************************************************************
;
;       Name: RUTOK
;       Type: Variable
;   Category: Text
;    Summary: The second extended token table for recursive tokens 0-26 (DETOK3)
;  Deep dive: Extended system descriptions
;             Extended text tokens
;             The Constrictor mission
;
; ------------------------------------------------------------------------------
;
; Contains the tokens for extended description overrides of systems that match
; the system number in RUPLA and the conditions in RUGAL.
;
; The three variables work as follows:
;
;   * The RUPLA table contains the system numbers
;
;   * The RUGAL table contains the galaxy numbers and mission criteria
;
;   * The RUTOK table contains the extended token to display instead of the
;     normal extended description if the criteria in RUPLA and RUGAL are met
;
; See the PDESC routine for details of how extended system descriptions work.
;
; The encodings shown for each extended text token use the following notation:
;
;   {n}           Jump token                n = 1 to 31
;   [n?]          Random token              n = 91 to 128
;   [n]           Recursive token           n = 129 to 215
;   <n>           Two-letter token          n = 215 to 255
;
; This version of Elite contains an extended system description override for
; Lave that welcomes us to the seventeenth galaxy. This is never shown in-game,
; as the galaxy number in RUGAL has to be 16, and this cannot happen.
;
; ******************************************************************************

.RUTOK

 EQUB VE                ; Token 0:      ""
                        ;
                        ; Encoded as:   ""

 ETOK 147               ; Token 1:      "THE COLONISTS HERE HAVE VIOLATED
 ECHR 'C'               ;                {sentence case} INTERGALACTIC CLONING
 ECHR 'O'               ;                PROTOCOL{lower case} AND SHOULD BE
 ETWO 'L', 'O'          ;                AVOIDED"
 ECHR 'N'               ;
 ECHR 'I'               ; Encoded as:   "[147]CO<224>NI<222>S HE<242> HA<250>
 ETWO 'S', 'T'          ;                 VIOL<245><252>{2} <240>T<244>G<228>AC
 ECHR 'S'               ;                <251>C C<224>N[195]PROTOCOL{13}[178]SH
 ECHR ' '               ;                <217>LD <247> AVOID<252>"
 ECHR 'H'
 ECHR 'E'
 ETWO 'R', 'E'
 ECHR ' '
 ECHR 'H'
 ECHR 'A'
 ETWO 'V', 'E'
 ECHR ' '
 ECHR 'V'
 ECHR 'I'
 ECHR 'O'
 ECHR 'L'
 ETWO 'A', 'T'
 ETWO 'E', 'D'
 EJMP 2
 ECHR ' '
 ETWO 'I', 'N'
 ECHR 'T'
 ETWO 'E', 'R'
 ECHR 'G'
 ETWO 'A', 'L'
 ECHR 'A'
 ECHR 'C'
 ETWO 'T', 'I'
 ECHR 'C'
 ECHR ' '
 ECHR 'C'
 ETWO 'L', 'O'
 ECHR 'N'
 ETOK 195
 ECHR 'P'
 ECHR 'R'
 ECHR 'O'
 ECHR 'T'
 ECHR 'O'
 ECHR 'C'
 ECHR 'O'
 ECHR 'L'
 EJMP 13
 ETOK 178
 ECHR 'S'
 ECHR 'H'
 ETWO 'O', 'U'
 ECHR 'L'
 ECHR 'D'
 ECHR ' '
 ETWO 'B', 'E'
 ECHR ' '
 ECHR 'A'
 ECHR 'V'
 ECHR 'O'
 ECHR 'I'
 ECHR 'D'
 ETWO 'E', 'D'
 EQUB VE

 ETOK 147               ; Token 2:      "THE CONSTRICTOR WAS LAST SEEN AT
 ECHR 'C'               ;                {single cap}REESDICE, {single cap}
 ETWO 'O', 'N'          ;                COMMANDER"
 ETWO 'S', 'T'          ;
 ECHR 'R'               ; Encoded as:   "[147]C<223><222>RICT<253> [203]<242>
 ECHR 'I'               ;                <237><241><233>, [154]"
 ECHR 'C'
 ECHR 'T'
 ETWO 'O', 'R'
 ECHR ' '
 ETOK 203
 ETWO 'R', 'E'
 ETWO 'E', 'S'
 ETWO 'D', 'I'
 ETWO 'C', 'E'
 ECHR ','
 ECHR ' '
 ETOK 154
 EQUB VE

 ECHR 'A'               ; Token 3:      "A [130-134] LOOKING SHIP LEFT HERE A
 ECHR ' '               ;                WHILE BACK. LOOKED BOUND FOR AREXE"
 ERND 23                ;
 ECHR ' '               ; Encoded as:   "A [23?] <224>OK[195][207] <229>FT HE
 ETWO 'L', 'O'          ;                <242>[208]WHI<229> BACK. LOOK[196]B
 ECHR 'O'               ;                <217>ND F<253> <238>E<230>"
 ECHR 'K'
 ETOK 195
 ETOK 207
 ECHR ' '
 ETWO 'L', 'E'
 ECHR 'F'
 ECHR 'T'
 ECHR ' '
 ECHR 'H'
 ECHR 'E'
 ETWO 'R', 'E'
 ETOK 208
 ECHR 'W'
 ECHR 'H'
 ECHR 'I'
 ETWO 'L', 'E'
 ECHR ' '
 ECHR 'B'
 ECHR 'A'
 ECHR 'C'
 ECHR 'K'
 ECHR '.'
 ECHR ' '
 ECHR 'L'
 ECHR 'O'
 ECHR 'O'
 ECHR 'K'
 ETOK 196
 ECHR 'B'
 ETWO 'O', 'U'
 ECHR 'N'
 ECHR 'D'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ETWO 'A', 'R'
 ECHR 'E'
 ETWO 'X', 'E'
 EQUB VE

 ECHR 'Y'               ; Token 4:      "YEP, A [130-134] NEW SHIP HAD A
 ECHR 'E'               ;                GALACTIC HYPERDRIVE FITTED HERE. USED
 ECHR 'P'               ;                IT TOO"
 ECHR ','               ;
 ETOK 208               ; Encoded as:   "YEP,[208][23?][210][207] HAD[208]G
 ERND 23                ;                <228>AC<251>C HYP<244>DRI<250> F<219>
 ETOK 210               ;                T[196]HE<242>. <236>[196]<219> TOO"
 ETOK 207
 ECHR ' '
 ECHR 'H'
 ECHR 'A'
 ECHR 'D'
 ETOK 208
 ECHR 'G'
 ETWO 'A', 'L'
 ECHR 'A'
 ECHR 'C'
 ETWO 'T', 'I'
 ECHR 'C'
 ECHR ' '
 ECHR 'H'
 ECHR 'Y'
 ECHR 'P'
 ETWO 'E', 'R'
 ECHR 'D'
 ECHR 'R'
 ECHR 'I'
 ETWO 'V', 'E'
 ECHR ' '
 ECHR 'F'
 ETWO 'I', 'T'
 ECHR 'T'
 ETOK 196
 ECHR 'H'
 ECHR 'E'
 ETWO 'R', 'E'
 ECHR '.'
 ECHR ' '
 ETWO 'U', 'S'
 ETOK 196
 ETWO 'I', 'T'
 ECHR ' '
 ECHR 'T'
 ECHR 'O'
 ECHR 'O'
 EQUB VE

 ETOK 148               ; Token 5:      "THIS  [130-134] SHIP DEHYPED HERE FROM
 ECHR ' '               ;                NOWHERE, SUN SKIMMED AND JUMPED. I HEAR
 ERND 23                ;                IT WENT TO INBIBE"
 ECHR ' '               ;
 ETOK 207               ; Encoded as:   "[148] [23?] [207] DEHYP[196]HE<242> FRO
 ECHR ' '               ;                M <227>WHE<242>, SUN SKIMM<252>[178]JUM
 ECHR 'D'               ;                P<252>. I HE<238> <219> W<246>T[201]
 ECHR 'E'               ;                <240><234><247>"
 ECHR 'H'
 ECHR 'Y'
 ECHR 'P'
 ETOK 196
 ECHR 'H'
 ECHR 'E'
 ETWO 'R', 'E'
 ECHR ' '
 ECHR 'F'
 ECHR 'R'
 ECHR 'O'
 ECHR 'M'
 ECHR ' '
 ETWO 'N', 'O'
 ECHR 'W'
 ECHR 'H'
 ECHR 'E'
 ETWO 'R', 'E'
 ECHR ','
 ECHR ' '
 ECHR 'S'
 ECHR 'U'
 ECHR 'N'
 ECHR ' '
 ECHR 'S'
 ECHR 'K'
 ECHR 'I'
 ECHR 'M'
 ECHR 'M'
 ETWO 'E', 'D'
 ETOK 178
 ECHR 'J'
 ECHR 'U'
 ECHR 'M'
 ECHR 'P'
 ETWO 'E', 'D'
 ECHR '.'
 ECHR ' '
 ECHR 'I'
 ECHR ' '
 ECHR 'H'
 ECHR 'E'
 ETWO 'A', 'R'
 ECHR ' '
 ETWO 'I', 'T'
 ECHR ' '
 ECHR 'W'
 ETWO 'E', 'N'
 ECHR 'T'
 ETOK 201
 ETWO 'I', 'N'
 ETWO 'B', 'I'
 ETWO 'B', 'E'
 EQUB VE

 ERND 24                ; Token 6:      "[91-95] SHIP WENT FOR ME AT AUSAR. MY
 ECHR ' '               ;                LASERS DIDN'T EVEN SCRATCH THE [91-95]"
 ETOK 207               ;
 ECHR ' '               ; Encoded as:   "[24?] [207] W<246>T F<253> ME <245>
 ECHR 'W'               ;                 A<236><238>. MY <249>S<244>S DIDN'T EV
 ETWO 'E', 'N'          ;                <246> SC<248>TCH [147][24?]"
 ECHR 'T'
 ECHR ' '
 ECHR 'F'
 ETWO 'O', 'R'
 ECHR ' '
 ECHR 'M'
 ECHR 'E'
 ECHR ' '
 ETWO 'A', 'T'
 ECHR ' '
 ECHR 'A'
 ETWO 'U', 'S'
 ETWO 'A', 'R'
 ECHR '.'
 ECHR ' '
 ECHR 'M'
 ECHR 'Y'
 ECHR ' '
 ETWO 'L', 'A'
 ECHR 'S'
 ETWO 'E', 'R'
 ECHR 'S'
 ECHR ' '
 ECHR 'D'
 ECHR 'I'
 ECHR 'D'
 ECHR 'N'
 ECHR '`'
 ECHR 'T'
 ECHR ' '
 ECHR 'E'
 ECHR 'V'
 ETWO 'E', 'N'
 ECHR ' '
 ECHR 'S'
 ECHR 'C'
 ETWO 'R', 'A'
 ECHR 'T'
 ECHR 'C'
 ECHR 'H'
 ECHR ' '
 ETOK 147
 ERND 24
 EQUB VE

 ECHR 'O'               ; Token 7:      "OH DEAR ME YES. A FRIGHTFUL ROGUE WITH
 ECHR 'H'               ;                WHAT I BELIEVE YOU PEOPLE CALL A LEAD
 ECHR ' '               ;                POSTERIOR SHOT UP LOTS OF THOSE BEASTLY
 ECHR 'D'               ;                PIRATES AND WENT TO USLERI"
 ECHR 'E'               ;
 ETWO 'A', 'R'          ; Encoded as:   "OH DE<238> ME Y<237>.[208]FRIGHTFUL ROG
 ECHR ' '               ;                UE WI<226> WH<245> I <247>LIE<250>
 ECHR 'M'               ;                 [179] PEOP<229> C<228>L[208]<229>AD PO
 ECHR 'E'               ;                <222><244>I<253> SHOT UP <224>TS OF
 ECHR ' '               ;                 <226>O<218> <247>A<222>LY PI<248>T
 ECHR 'Y'               ;                <237>[178]W<246>T[201]<236><229>RI"
 ETWO 'E', 'S'
 ECHR '.'
 ETOK 208
 ECHR 'F'
 ECHR 'R'
 ECHR 'I'
 ECHR 'G'
 ECHR 'H'
 ECHR 'T'
 ECHR 'F'
 ECHR 'U'
 ECHR 'L'
 ECHR ' '
 ECHR 'R'
 ECHR 'O'
 ECHR 'G'
 ECHR 'U'
 ECHR 'E'
 ECHR ' '
 ECHR 'W'
 ECHR 'I'
 ETWO 'T', 'H'
 ECHR ' '
 ECHR 'W'
 ECHR 'H'
 ETWO 'A', 'T'
 ECHR ' '
 ECHR 'I'
 ECHR ' '
 ETWO 'B', 'E'
 ECHR 'L'
 ECHR 'I'
 ECHR 'E'
 ETWO 'V', 'E'
 ECHR ' '
 ETOK 179
 ECHR ' '
 ECHR 'P'
 ECHR 'E'
 ECHR 'O'
 ECHR 'P'
 ETWO 'L', 'E'
 ECHR ' '
 ECHR 'C'
 ETWO 'A', 'L'
 ECHR 'L'
 ETOK 208
 ETWO 'L', 'E'
 ECHR 'A'
 ECHR 'D'
 ECHR ' '
 ECHR 'P'
 ECHR 'O'
 ETWO 'S', 'T'
 ETWO 'E', 'R'
 ECHR 'I'
 ETWO 'O', 'R'
 ECHR ' '
 ECHR 'S'
 ECHR 'H'
 ECHR 'O'
 ECHR 'T'
 ECHR ' '
 ECHR 'U'
 ECHR 'P'
 ECHR ' '
 ETWO 'L', 'O'
 ECHR 'T'
 ECHR 'S'
 ECHR ' '
 ECHR 'O'
 ECHR 'F'
 ECHR ' '
 ETWO 'T', 'H'
 ECHR 'O'
 ETWO 'S', 'E'
 ECHR ' '
 ETWO 'B', 'E'
 ECHR 'A'
 ETWO 'S', 'T'
 ECHR 'L'
 ECHR 'Y'
 ECHR ' '
 ECHR 'P'
 ECHR 'I'
 ETWO 'R', 'A'
 ECHR 'T'
 ETWO 'E', 'S'
 ETOK 178
 ECHR 'W'
 ETWO 'E', 'N'
 ECHR 'T'
 ETOK 201
 ETWO 'U', 'S'
 ETWO 'L', 'E'
 ECHR 'R'
 ECHR 'I'
 EQUB VE

 ETOK 179               ; Token 8:      "YOU CAN TACKLE THE [170-174] [91-95]
 ECHR ' '               ;                IF YOU LIKE. HE'S AT ORARRA"
 ECHR 'C'               ;
 ETWO 'A', 'N'          ; Encoded as:   "[179] C<255> TACK<229> [147][13?] [24?]
 ECHR ' '               ;                 IF [179] LIKE. HE'S <245> <253><238>
 ECHR 'T'               ;                <248>"
 ECHR 'A'
 ECHR 'C'
 ECHR 'K'
 ETWO 'L', 'E'
 ECHR ' '
 ETOK 147
 ERND 13
 ECHR ' '
 ERND 24
 ECHR ' '
 ECHR 'I'
 ECHR 'F'
 ECHR ' '
 ETOK 179
 ECHR ' '
 ECHR 'L'
 ECHR 'I'
 ECHR 'K'
 ECHR 'E'
 ECHR '.'
 ECHR ' '
 ECHR 'H'
 ECHR 'E'
 ECHR '`'
 ECHR 'S'
 ECHR ' '
 ETWO 'A', 'T'
 ECHR ' '
 ETWO 'O', 'R'
 ETWO 'A', 'R'
 ETWO 'R', 'A'
 EQUB VE

 EJMP 1                 ; Token 9:      "{all caps}COMING SOON: ELITE II"
 ECHR 'C'               ;
 ECHR 'O'               ; Encoded as:   "{1}COM[195]<235><223>: EL<219>E II"
 ECHR 'M'
 ETOK 195
 ETWO 'S', 'O'
 ETWO 'O', 'N'
 ECHR ':'
 ECHR ' '
 ECHR 'E'
 ECHR 'L'
 ETWO 'I', 'T'
 ECHR 'E'
 ECHR ' '
 ECHR 'I'
 ECHR 'I'
 EQUB VE

 ERND 25                ; Token 10:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 11:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 12:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 13:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 14:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 15:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 16:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 17:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 18:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 19:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 20:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 21:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ERND 25                ; Token 22:     "[106-110]"
 EQUB VE                ;
                        ; Encoded as:   "[25?]"

 ECHR 'B'               ; Token 23:     "BOY ARE YOU IN THE WRONG GALAXY!"
 ECHR 'O'               ;
 ECHR 'Y'               ; Encoded as:   "BOY A<242> [179] <240> [147]WR<223>G G
 ECHR ' '               ;                <228>AXY!"
 ECHR 'A'
 ETWO 'R', 'E'
 ECHR ' '
 ETOK 179
 ECHR ' '
 ETWO 'I', 'N'
 ECHR ' '
 ETOK 147
 ECHR 'W'
 ECHR 'R'
 ETWO 'O', 'N'
 ECHR 'G'
 ECHR ' '
 ECHR 'G'
 ETWO 'A', 'L'
 ECHR 'A'
 ECHR 'X'
 ECHR 'Y'
 ECHR '!'
 EQUB VE

 ETWO 'T', 'H'          ; Token 24:     "THERE'S A REAL [91-95] PIRATE OUT
 ETWO 'E', 'R'          ;                THERE"
 ECHR 'E'               ;
 ECHR '`'               ; Encoded as:   "<226><244>E'S[208]<242><228> [24?] PI
 ECHR 'S'               ;                <248>TE <217>T <226><244>E"
 ETOK 208
 ETWO 'R', 'E'
 ETWO 'A', 'L'
 ECHR ' '
 ERND 24
 ECHR ' '
 ECHR 'P'
 ECHR 'I'
 ETWO 'R', 'A'
 ECHR 'T'
 ECHR 'E'
 ECHR ' '
 ETWO 'O', 'U'
 ECHR 'T'
 ECHR ' '
 ETWO 'T', 'H'
 ETWO 'E', 'R'
 ECHR 'E'
 EQUB VE

 ETOK 147               ; Token 25:     "THE INHABITANTS OF [86-90] ARE SO
 ETOK 193               ;                AMAZINGLY PRIMITIVE THAT THEY STILL
 ECHR 'S'               ;                THINK {single cap}***** ****** IS  3D"
 ECHR ' '               ;
 ECHR 'O'               ; Encoded as:   "[147][193]S OF [18?] A<242> <235> A
 ECHR 'F'               ;                <239>Z<240>GLY PRIMI<251><250> <226>
 ECHR ' '               ;                <245> <226>EY <222><220>L <226><240>K
 ERND 18                ;                 {19}***** ******[202] 3D"
 ECHR ' '
 ECHR 'A'
 ETWO 'R', 'E'
 ECHR ' '
 ETWO 'S', 'O'
 ECHR ' '
 ECHR 'A'
 ETWO 'M', 'A'
 ECHR 'Z'
 ETWO 'I', 'N'
 ECHR 'G'
 ECHR 'L'
 ECHR 'Y'
 ECHR ' '
 ECHR 'P'
 ECHR 'R'
 ECHR 'I'
 ECHR 'M'
 ECHR 'I'
 ETWO 'T', 'I'
 ETWO 'V', 'E'
 ECHR ' '
 ETWO 'T', 'H'
 ETWO 'A', 'T'
 ECHR ' '
 ETWO 'T', 'H'
 ECHR 'E'
 ECHR 'Y'
 ECHR ' '
 ETWO 'S', 'T'
 ETWO 'I', 'L'
 ECHR 'L'
 ECHR ' '
 ETWO 'T', 'H'
 ETWO 'I', 'N'
 ECHR 'K'
 ECHR ' '
 EJMP 19
 ECHR '*'
 ECHR '*'
 ECHR '*'
 ECHR '*'
 ECHR '*'
 ECHR ' '
 ECHR '*'
 ECHR '*'
 ECHR '*'
 ECHR '*'
 ECHR '*'
 ECHR '*'
 ETOK 202
 ECHR ' '
 ECHR '3'
 ECHR 'D'
 EQUB VE

 EJMP 1                 ; Token 26:     "{all caps}WELCOME TO  THE SEVENTEENTH
 ECHR 'W'               ;                GALAXY!"
 ECHR 'E'               ;
 ECHR 'L'               ; Encoded as:   "{1}WELCOME TO THE SEVENTEENTH GALAXY!"
 ECHR 'C'
 ECHR 'O'
 ECHR 'M'
 ECHR 'E'
 ECHR ' '
 ECHR 'T'
 ECHR 'O'
 ECHR ' '
 ECHR 'T'
 ECHR 'H'
 ECHR 'E'
 ECHR ' '
 ECHR 'S'
 ECHR 'E'
 ECHR 'V'
 ECHR 'E'
 ECHR 'N'
 ECHR 'T'
 ECHR 'E'
 ECHR 'E'
 ECHR 'N'
 ECHR 'T'
 ECHR 'H'
 ECHR ' '
 ECHR 'G'
 ECHR 'A'
 ECHR 'L'
 ECHR 'A'
 ECHR 'X'
 ECHR 'Y'
 ECHR '!'
 EQUB VE

.endian

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 EQUB $3A, $4C, $44, $41, $58, $58, $31, $2B    ; These bytes appear to be
 EQUB $31, $3A, $41, $44, $43, $23, $30, $3A    ; unused and just contain random
 EQUB $53, $54, $41, $58, $58, $31, $35, $2B    ; workspace noise left over from
 EQUB $31, $3A, $4A, $4D, $50, $4C, $4C, $35    ; the BBC Micro assembly process
 EQUB $33, $0D, $21, $7A, $3D, $2E, $4C, $4C
 EQUB $35, $32, $20, $4C, $44, $41, $58, $58
 EQUB $31, $3A, $53

ELIF _SOURCE_DISK_BUILD

 EQUB $3E, $4C, $20, $59, $3C, $32, $31, $37    ; These bytes appear to be
 EQUB $3E, $20, $54, $41, $4B, $45, $20, $3C    ; unused and just contain random
 EQUB $32, $31, $39, $3E, $3C, $30, $30, $31    ; workspace noise left over from
 EQUB $3E, $28, $59, $2F, $4E, $29, $3F, $3C    ; the BBC Micro assembly process
 EQUB $30, $31, $32, $3E, $3C, $30, $31, $35
 EQUB $3E, $3C, $30, $30, $31, $3E, $3C, $30
 EQUB $30, $38, $3E

ENDIF

; ******************************************************************************
;
; Save IANTOK.bin
;
; ******************************************************************************

 LOAD_IT% = IANTOK + LOAD% - CODE%

 PRINT "IANTOK"
 PRINT "Assembled at ", ~IANTOK
 PRINT "Ends at ", ~endian
 PRINT "Code size is ", ~(endian - IANTOK)
 PRINT "Execute at ", ~LOAD_IT%
 PRINT "Reload at ", ~LOAD_IT%

 PRINT "S.C.IANTOK ", ~IANTOK, " ", ~endian, " ", ~LOAD_IT%, " ", ~LOAD_IT%
 SAVE "3-assembled-output/IANTOK.bin", IANTOK, endian, LOAD_IT%

; ******************************************************************************
;
; Save LODATA.bin
;
; ******************************************************************************

 PRINT "P% = ", ~P%
 PRINT "S.C.LODATA ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "3-assembled-output/LODATA.bin", CODE%, P%, LOAD%

; ******************************************************************************
;
; ELITE SHIP BLUEPRINTS FILE
;
; Produces the binary file SHIPS.bin that gets loaded by elite-checksum.py.
;
; ******************************************************************************

 CODE_SHIPS% = D%

 LOAD_SHIPS% = LOAD% + D% - CODE%

 ORG D%                 ; Set the assembly address to D%

; ******************************************************************************
;
;       Name: XX21
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprints lookup table
;  Deep dive: Ship blueprints
;
; ******************************************************************************

.XX21

 EQUW SHIP_MISSILE      ; MSL  =  1 = Missile
 EQUW SHIP_CORIOLIS     ; SST  =  2 = Coriolis space station
 EQUW SHIP_ESCAPE_POD   ; ESC  =  3 = Escape pod
 EQUW SHIP_PLATE        ; PLT  =  4 = Alloy plate
 EQUW SHIP_CANISTER     ; OIL  =  5 = Cargo canister
 EQUW SHIP_BOULDER      ;         6 = Boulder
 EQUW SHIP_ASTEROID     ; AST  =  7 = Asteroid
 EQUW SHIP_SPLINTER     ; SPL  =  8 = Splinter
 EQUW SHIP_SHUTTLE      ; SHU  =  9 = Shuttle
 EQUW SHIP_TRANSPORTER  ;        10 = Transporter
 EQUW SHIP_COBRA_MK_3   ; CYL  = 11 = Cobra Mk III
 EQUW SHIP_PYTHON       ;        12 = Python
 EQUW SHIP_BOA          ;        13 = Boa
 EQUW SHIP_ANACONDA     ; ANA  = 14 = Anaconda
 EQUW SHIP_ROCK_HERMIT  ; HER  = 15 = Rock hermit (asteroid)
 EQUW SHIP_VIPER        ; COPS = 16 = Viper
 EQUW SHIP_SIDEWINDER   ; SH3  = 17 = Sidewinder
 EQUW SHIP_MAMBA        ;        18 = Mamba
 EQUW SHIP_KRAIT        ; KRA  = 19 = Krait
 EQUW SHIP_ADDER        ; ADA  = 20 = Adder
 EQUW SHIP_GECKO        ;        21 = Gecko
 EQUW SHIP_COBRA_MK_1   ;        22 = Cobra Mk I
 EQUW SHIP_WORM         ; WRM  = 23 = Worm
 EQUW SHIP_COBRA_MK_3_P ; CYL2 = 24 = Cobra Mk III (pirate)
 EQUW SHIP_ASP_MK_2     ; ASP  = 25 = Asp Mk II
 EQUW SHIP_PYTHON_P     ;        26 = Python (pirate)
 EQUW SHIP_FER_DE_LANCE ;        27 = Fer-de-lance
 EQUW SHIP_MORAY        ;        28 = Moray
 EQUW SHIP_THARGOID     ; THG  = 29 = Thargoid
 EQUW SHIP_THARGON      ; TGL  = 30 = Thargon
 EQUW SHIP_CONSTRICTOR  ; CON  = 31 = Constrictor
 EQUW SHIP_COUGAR       ; COU  = 32 = Cougar
 EQUW SHIP_DODO         ; DOD  = 33 = Dodecahedron ("Dodo") space station

; ******************************************************************************
;
;       Name: E%
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprints default NEWB flags
;  Deep dive: Ship blueprints
;             Advanced tactics with the NEWB flags
;
; ------------------------------------------------------------------------------
;
; When spawning a new ship, the bits from this table are applied to the new
; ship's NEWB flags in byte #36 (i.e. a set bit in this table will set that bit
; in the NEWB flags). In other words, if a ship blueprint is set to one of the
; following, then all spawned ships of that type will be too: trader, bounty
; hunter, hostile, pirate, innocent, cop.
;
; The NEWB flags are as follows:
;
;   * Bit 0: Trader flag (0 = not a trader, 1 = trader)
;   * Bit 1: Bounty hunter flag (0 = not a bounty hunter, 1 = bounty hunter)
;   * Bit 2: Hostile flag (0 = not hostile, 1 = hostile)
;   * Bit 3: Pirate flag (0 = not a pirate, 1 = pirate)
;   * Bit 4: Docking flag (0 = not docking, 1 = docking)
;   * Bit 5: Innocent bystander (0 = normal, 1 = innocent bystander)
;   * Bit 6: Cop flag (0 = not a cop, 1 = cop)
;   * Bit 7: For spawned ships: ship been scooped or has docked
;            For blueprints: this ship type has an escape pod fitted
;
; ******************************************************************************

.E%

 EQUB %00000000         ; Missile
 EQUB %00000000         ; Coriolis space station
 EQUB %00000001         ; Escape pod                                      Trader
 EQUB %00000000         ; Alloy plate
 EQUB %00000000         ; Cargo canister
 EQUB %00000000         ; Boulder
 EQUB %00000000         ; Asteroid
 EQUB %00000000         ; Splinter
 EQUB %00100001         ; Shuttle                               Trader, innocent
 EQUB %01100001         ; Transporter                      Trader, innocent, cop
 EQUB %10100000         ; Cobra Mk III                      Innocent, escape pod
 EQUB %10100000         ; Python                            Innocent, escape pod
 EQUB %10100000         ; Boa                               Innocent, escape pod
 EQUB %10100001         ; Anaconda                  Trader, innocent, escape pod
 EQUB %10100001         ; Rock hermit (asteroid)    Trader, innocent, escape pod
 EQUB %11000010         ; Viper                   Bounty hunter, cop, escape pod
 EQUB %00001100         ; Sidewinder                             Hostile, pirate
 EQUB %10001100         ; Mamba                      Hostile, pirate, escape pod
 EQUB %10001100         ; Krait                      Hostile, pirate, escape pod
 EQUB %10001100         ; Adder                      Hostile, pirate, escape pod
 EQUB %00001100         ; Gecko                                  Hostile, pirate
 EQUB %10001100         ; Cobra Mk I                 Hostile, pirate, escape pod
 EQUB %00000101         ; Worm                                   Hostile, trader
 EQUB %10001100         ; Cobra Mk III (pirate)      Hostile, pirate, escape pod
 EQUB %10001100         ; Asp Mk II                  Hostile, pirate, escape pod
 EQUB %10001100         ; Python (pirate)            Hostile, pirate, escape pod
 EQUB %10000010         ; Fer-de-lance                 Bounty hunter, escape pod
 EQUB %00001100         ; Moray                                  Hostile, pirate
 EQUB %00001100         ; Thargoid                               Hostile, pirate
 EQUB %00000100         ; Thargon                                        Hostile
 EQUB %00000100         ; Constrictor                                    Hostile
 EQUB %00100000         ; Cougar                                        Innocent

 EQUB 0                 ; This byte appears to be unused

; ******************************************************************************
;
;       Name: KWL%
;       Type: Variable
;   Category: Status
;    Summary: Fractional number of kills awarded for destroying each type of
;             ship
;
; ------------------------------------------------------------------------------
;
; This figure contains the fractional part of the points that are added to the
; combat rank in TALLY when destroying a ship of this type. This is different to
; the original BBC Micro versions, where you always get a single combat point
; for everything you kill; in the Master version, it's more sophisticated.
;
; The integral part is stored in the KWH% table.
;
; Each fraction is stored as the numerator in a fraction with a denominator of
; 256, so 149 represents 149 / 256 = 0.58203125 points.
;
; ******************************************************************************

.KWL%

 EQUB 149               ; Missile                               0.58203125
 EQUB 0                 ; Coriolis space station                0.0
 EQUB 16                ; Escape pod                            0.0625
 EQUB 10                ; Alloy plate                           0.0390625
 EQUB 10                ; Cargo canister                        0.0390625
 EQUB 6                 ; Boulder                               0.0234375
 EQUB 8                 ; Asteroid                              0.03125
 EQUB 10                ; Splinter                              0.0390625
 EQUB 16                ; Shuttle                               0.0625
 EQUB 17                ; Transporter                           0.06640625
 EQUB 234               ; Cobra Mk III                          0.9140625
 EQUB 170               ; Python                                0.6640625
 EQUB 213               ; Boa                                   0.83203125
 EQUB 0                 ; Anaconda                              1.0
 EQUB 85                ; Rock hermit (asteroid)                0.33203125
 EQUB 26                ; Viper                                 0.1015625
 EQUB 85                ; Sidewinder                            0.33203125
 EQUB 128               ; Mamba                                 0.5
 EQUB 85                ; Krait                                 0.33203125
 EQUB 90                ; Adder                                 0.3515625
 EQUB 85                ; Gecko                                 0.33203125
 EQUB 170               ; Cobra Mk I                            0.6640625
 EQUB 50                ; Worm                                  0.1953125
 EQUB 42                ; Cobra Mk III (pirate)                 1.1640625
 EQUB 21                ; Asp Mk II                             1.08203125
 EQUB 42                ; Python (pirate)                       1.1640625
 EQUB 64                ; Fer-de-lance                          1.25
 EQUB 192               ; Moray                                 0.75
 EQUB 170               ; Thargoid                              2.6640625
 EQUB 33                ; Thargon                               0.12890625
 EQUB 85                ; Constrictor                           5.33203125
 EQUB 85                ; Cougar                                5.33203125
 EQUB 0                 ; Dodecahedron ("Dodo") space station   0.0

; ******************************************************************************
;
;       Name: KWH%
;       Type: Variable
;   Category: Status
;    Summary: Integer number of kills awarded for destroying each type of ship
;
; ------------------------------------------------------------------------------
;
; This figure contains the integer part of the points that are added to the
; combat rank in TALLY when destroying a ship of this type. This is different to
; the original BBC Micro versions, where you always get a single combat point
; for everything you kill; in the Master version, it's more sophisticated.
;
; The fractional part is stored in the KWL% table.
;
; ******************************************************************************

.KWH%

 EQUB 0                 ; Missile                               0.58203125
 EQUB 0                 ; Coriolis space station                0.0
 EQUB 0                 ; Escape pod                            0.0625
 EQUB 0                 ; Alloy plate                           0.0390625
 EQUB 0                 ; Cargo canister                        0.0390625
 EQUB 0                 ; Boulder                               0.0234375
 EQUB 0                 ; Asteroid                              0.03125
 EQUB 0                 ; Splinter                              0.0390625
 EQUB 0                 ; Shuttle                               0.0625
 EQUB 0                 ; Transporter                           0.06640625
 EQUB 0                 ; Cobra Mk III                          0.9140625
 EQUB 0                 ; Python                                0.6640625
 EQUB 0                 ; Boa                                   0.83203125
 EQUB 1                 ; Anaconda                              1.0
 EQUB 0                 ; Rock hermit (asteroid)                0.33203125
 EQUB 0                 ; Viper                                 0.1015625
 EQUB 0                 ; Sidewinder                            0.33203125
 EQUB 0                 ; Mamba                                 0.5
 EQUB 0                 ; Krait                                 0.33203125
 EQUB 0                 ; Adder                                 0.3515625
 EQUB 0                 ; Gecko                                 0.33203125
 EQUB 0                 ; Cobra Mk I                            0.6640625
 EQUB 0                 ; Worm                                  0.1953125
 EQUB 1                 ; Cobra Mk III (pirate)                 1.1640625
 EQUB 1                 ; Asp Mk II                             1.08203125
 EQUB 1                 ; Python (pirate)                       1.1640625
 EQUB 1                 ; Fer-de-lance                          1.25
 EQUB 0                 ; Moray                                 0.75
 EQUB 2                 ; Thargoid                              2.6640625
 EQUB 0                 ; Thargon                               0.12890625
 EQUB 5                 ; Constrictor                           5.33203125
 EQUB 5                 ; Cougar                                5.33203125
 EQUB 0                 ; Dodecahedron ("Dodo") space station   0.0

; ******************************************************************************
;
;       Name: VERTEX
;       Type: Macro
;   Category: Drawing ships
;    Summary: Macro definition for adding vertices to ship blueprints
;  Deep dive: Ship blueprints
;             Drawing ships
;
; ------------------------------------------------------------------------------
;
; The following macro is used to build the ship blueprints:
;
;   VERTEX x, y, z, face1, face2, face3, face4, visibility
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   x                   The vertex's x-coordinate
;
;   y                   The vertex's y-coordinate
;
;   z                   The vertex's z-coordinate
;
;   face1               The number of face 1 associated with this vertex
;
;   face2               The number of face 2 associated with this vertex
;
;   face3               The number of face 3 associated with this vertex
;
;   face4               The number of face 4 associated with this vertex
;
;   visibility          The visibility distance, beyond which the vertex is not
;                       shown
;
; ******************************************************************************

MACRO VERTEX x, y, z, face1, face2, face3, face4, visibility

 IF x < 0
  s_x = 1 << 7
 ELSE
  s_x = 0
 ENDIF

 IF y < 0
  s_y = 1 << 6
 ELSE
  s_y = 0
 ENDIF

 IF z < 0
  s_z = 1 << 5
 ELSE
  s_z = 0
 ENDIF

 s = s_x + s_y + s_z + visibility
 f1 = face1 + (face2 << 4)
 f2 = face3 + (face4 << 4)
 ax = ABS(x)
 ay = ABS(y)
 az = ABS(z)

 EQUB ax, ay, az, s, f1, f2

ENDMACRO

; ******************************************************************************
;
;       Name: EDGE
;       Type: Macro
;   Category: Drawing ships
;    Summary: Macro definition for adding edges to ship blueprints
;  Deep dive: Ship blueprints
;             Drawing ships
;
; ------------------------------------------------------------------------------
;
; The following macro is used to build the ship blueprints:
;
;   EDGE vertex1, vertex2, face1, face2, visibility
;
; When stored in memory, bytes #2 and #3 contain the vertex numbers multiplied
; by 4, so we can use them as indices into the heap at XX3 to fetch the screen
; coordinates for each vertex, as they are stored as four bytes containing two
; 16-bit numbers (see part 10 of the LL9 routine for details).
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   vertex1             The number of the vertex at the start of the edge
;
;   vertex1             The number of the vertex at the end of the edge
;
;   face1               The number of face 1 associated with this edge
;
;   face2               The number of face 2 associated with this edge
;
;   visibility          The visibility distance, beyond which the edge is not
;                       shown
;
; ******************************************************************************

MACRO EDGE vertex1, vertex2, face1, face2, visibility

 f = face1 + (face2 << 4)
 EQUB visibility, f, vertex1 << 2, vertex2 << 2

ENDMACRO

; ******************************************************************************
;
;       Name: FACE
;       Type: Macro
;   Category: Drawing ships
;    Summary: Macro definition for adding faces to ship blueprints
;  Deep dive: Ship blueprints
;             Drawing ships
;
; ------------------------------------------------------------------------------
;
; The following macro is used to build the ship blueprints:
;
;   FACE normal_x, normal_y, normal_z, visibility
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   normal_x            The face normal's x-coordinate
;
;   normal_y            The face normal's y-coordinate
;
;   normal_z            The face normal's z-coordinate
;
;   visibility          The visibility distance, beyond which the edge is always
;                       shown
;
; ******************************************************************************

MACRO FACE normal_x, normal_y, normal_z, visibility

 IF normal_x < 0
  s_x = 1 << 7
 ELSE
  s_x = 0
 ENDIF

 IF normal_y < 0
  s_y = 1 << 6
 ELSE
  s_y = 0
 ENDIF

 IF normal_z < 0
  s_z = 1 << 5
 ELSE
  s_z = 0
 ENDIF

 s = s_x + s_y + s_z + visibility
 ax = ABS(normal_x)
 ay = ABS(normal_y)
 az = ABS(normal_z)

 EQUB s, ax, ay, az

ENDMACRO

; ******************************************************************************
;
;       Name: SHIP_MISSILE
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a missile
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_MISSILE

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 40 * 40           ; Targetable area          = 40 * 40

 EQUB LO(SHIP_MISSILE_EDGES - SHIP_MISSILE)        ; Edges data offset (low)
 EQUB LO(SHIP_MISSILE_FACES - SHIP_MISSILE)        ; Faces data offset (low)

 EQUB 85                ; Max. edge count          = (85 - 1) / 4 = 21
 EQUB 0                 ; Gun vertex               = 0
 EQUB 10                ; Explosion count          = 1, as (4 * n) + 6 = 10
 EQUB 102               ; Number of vertices       = 102 / 6 = 17
 EQUB 24                ; Number of edges          = 24
 EQUW 0                 ; Bounty                   = 0
 EQUB 36                ; Number of faces          = 36 / 4 = 9
 EQUB 14                ; Visibility distance      = 14
 EQUB 2                 ; Max. energy              = 2
 EQUB 44                ; Max. speed               = 44

 EQUB HI(SHIP_MISSILE_EDGES - SHIP_MISSILE)        ; Edges data offset (high)
 EQUB HI(SHIP_MISSILE_FACES - SHIP_MISSILE)        ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_MISSILE_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    0,   68,     0,      1,    2,     3,         31    ; Vertex 0
 VERTEX    8,   -8,   36,     1,      2,    4,     5,         31    ; Vertex 1
 VERTEX    8,    8,   36,     2,      3,    4,     7,         31    ; Vertex 2
 VERTEX   -8,    8,   36,     0,      3,    6,     7,         31    ; Vertex 3
 VERTEX   -8,   -8,   36,     0,      1,    5,     6,         31    ; Vertex 4
 VERTEX    8,    8,  -44,     4,      7,    8,     8,         31    ; Vertex 5
 VERTEX    8,   -8,  -44,     4,      5,    8,     8,         31    ; Vertex 6
 VERTEX   -8,   -8,  -44,     5,      6,    8,     8,         31    ; Vertex 7
 VERTEX   -8,    8,  -44,     6,      7,    8,     8,         31    ; Vertex 8
 VERTEX   12,   12,  -44,     4,      7,    8,     8,          8    ; Vertex 9
 VERTEX   12,  -12,  -44,     4,      5,    8,     8,          8    ; Vertex 10
 VERTEX  -12,  -12,  -44,     5,      6,    8,     8,          8    ; Vertex 11
 VERTEX  -12,   12,  -44,     6,      7,    8,     8,          8    ; Vertex 12
 VERTEX   -8,    8,  -12,     6,      7,    7,     7,          8    ; Vertex 13
 VERTEX   -8,   -8,  -12,     5,      6,    6,     6,          8    ; Vertex 14
 VERTEX    8,    8,  -12,     4,      7,    7,     7,          8    ; Vertex 15
 VERTEX    8,   -8,  -12,     4,      5,    5,     5,          8    ; Vertex 16

.SHIP_MISSILE_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     1,     2,         31    ; Edge 0
 EDGE       0,       2,     2,     3,         31    ; Edge 1
 EDGE       0,       3,     0,     3,         31    ; Edge 2
 EDGE       0,       4,     0,     1,         31    ; Edge 3
 EDGE       1,       2,     4,     2,         31    ; Edge 4
 EDGE       1,       4,     1,     5,         31    ; Edge 5
 EDGE       3,       4,     0,     6,         31    ; Edge 6
 EDGE       2,       3,     3,     7,         31    ; Edge 7
 EDGE       2,       5,     4,     7,         31    ; Edge 8
 EDGE       1,       6,     4,     5,         31    ; Edge 9
 EDGE       4,       7,     5,     6,         31    ; Edge 10
 EDGE       3,       8,     6,     7,         31    ; Edge 11
 EDGE       7,       8,     6,     8,         31    ; Edge 12
 EDGE       5,       8,     7,     8,         31    ; Edge 13
 EDGE       5,       6,     4,     8,         31    ; Edge 14
 EDGE       6,       7,     5,     8,         31    ; Edge 15
 EDGE       6,      10,     5,     8,          8    ; Edge 16
 EDGE       5,       9,     7,     8,          8    ; Edge 17
 EDGE       8,      12,     7,     8,          8    ; Edge 18
 EDGE       7,      11,     5,     8,          8    ; Edge 19
 EDGE       9,      15,     4,     7,          8    ; Edge 20
 EDGE      10,      16,     4,     5,          8    ; Edge 21
 EDGE      12,      13,     6,     7,          8    ; Edge 22
 EDGE      11,      14,     5,     6,          8    ; Edge 23

.SHIP_MISSILE_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE      -64,        0,       16,         31      ; Face 0
 FACE        0,      -64,       16,         31      ; Face 1
 FACE       64,        0,       16,         31      ; Face 2
 FACE        0,       64,       16,         31      ; Face 3
 FACE       32,        0,        0,         31      ; Face 4
 FACE        0,      -32,        0,         31      ; Face 5
 FACE      -32,        0,        0,         31      ; Face 6
 FACE        0,       32,        0,         31      ; Face 7
 FACE        0,        0,     -176,         31      ; Face 8

; ******************************************************************************
;
;       Name: SHIP_CORIOLIS
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Coriolis space station
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_CORIOLIS

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 160 * 160         ; Targetable area          = 160 * 160

 EQUB LO(SHIP_CORIOLIS_EDGES - SHIP_CORIOLIS)      ; Edges data offset (low)
 EQUB LO(SHIP_CORIOLIS_FACES - SHIP_CORIOLIS)      ; Faces data offset (low)

 EQUB 89                ; Max. edge count          = (89 - 1) / 4 = 22
 EQUB 0                 ; Gun vertex               = 0
 EQUB 54                ; Explosion count          = 12, as (4 * n) + 6 = 54
 EQUB 96                ; Number of vertices       = 96 / 6 = 16
 EQUB 28                ; Number of edges          = 28
 EQUW 0                 ; Bounty                   = 0
 EQUB 56                ; Number of faces          = 56 / 4 = 14
 EQUB 120               ; Visibility distance      = 120
 EQUB 240               ; Max. energy              = 240
 EQUB 0                 ; Max. speed               = 0

 EQUB HI(SHIP_CORIOLIS_EDGES - SHIP_CORIOLIS)      ; Edges data offset (high)
 EQUB HI(SHIP_CORIOLIS_FACES - SHIP_CORIOLIS)      ; Faces data offset (high)

 EQUB 0                 ; Normals are scaled by    = 2^0 = 1
 EQUB %00000110         ; Laser power              = 0
                        ; Missiles                 = 6

.SHIP_CORIOLIS_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX  160,    0,  160,     0,      1,    2,     6,         31    ; Vertex 0
 VERTEX    0,  160,  160,     0,      2,    3,     8,         31    ; Vertex 1
 VERTEX -160,    0,  160,     0,      3,    4,     7,         31    ; Vertex 2
 VERTEX    0, -160,  160,     0,      1,    4,     5,         31    ; Vertex 3
 VERTEX  160, -160,    0,     1,      5,    6,    10,         31    ; Vertex 4
 VERTEX  160,  160,    0,     2,      6,    8,    11,         31    ; Vertex 5
 VERTEX -160,  160,    0,     3,      7,    8,    12,         31    ; Vertex 6
 VERTEX -160, -160,    0,     4,      5,    7,     9,         31    ; Vertex 7
 VERTEX  160,    0, -160,     6,     10,   11,    13,         31    ; Vertex 8
 VERTEX    0,  160, -160,     8,     11,   12,    13,         31    ; Vertex 9
 VERTEX -160,    0, -160,     7,      9,   12,    13,         31    ; Vertex 10
 VERTEX    0, -160, -160,     5,      9,   10,    13,         31    ; Vertex 11
 VERTEX   10,  -30,  160,     0,      0,    0,     0,         30    ; Vertex 12
 VERTEX   10,   30,  160,     0,      0,    0,     0,         30    ; Vertex 13
 VERTEX  -10,   30,  160,     0,      0,    0,     0,         30    ; Vertex 14
 VERTEX  -10,  -30,  160,     0,      0,    0,     0,         30    ; Vertex 15

.SHIP_CORIOLIS_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       3,     0,     1,         31    ; Edge 0
 EDGE       0,       1,     0,     2,         31    ; Edge 1
 EDGE       1,       2,     0,     3,         31    ; Edge 2
 EDGE       2,       3,     0,     4,         31    ; Edge 3
 EDGE       3,       4,     1,     5,         31    ; Edge 4
 EDGE       0,       4,     1,     6,         31    ; Edge 5
 EDGE       0,       5,     2,     6,         31    ; Edge 6
 EDGE       5,       1,     2,     8,         31    ; Edge 7
 EDGE       1,       6,     3,     8,         31    ; Edge 8
 EDGE       2,       6,     3,     7,         31    ; Edge 9
 EDGE       2,       7,     4,     7,         31    ; Edge 10
 EDGE       3,       7,     4,     5,         31    ; Edge 11
 EDGE       8,      11,    10,    13,         31    ; Edge 12
 EDGE       8,       9,    11,    13,         31    ; Edge 13
 EDGE       9,      10,    12,    13,         31    ; Edge 14
 EDGE      10,      11,     9,    13,         31    ; Edge 15
 EDGE       4,      11,     5,    10,         31    ; Edge 16
 EDGE       4,       8,     6,    10,         31    ; Edge 17
 EDGE       5,       8,     6,    11,         31    ; Edge 18
 EDGE       5,       9,     8,    11,         31    ; Edge 19
 EDGE       6,       9,     8,    12,         31    ; Edge 20
 EDGE       6,      10,     7,    12,         31    ; Edge 21
 EDGE       7,      10,     7,     9,         31    ; Edge 22
 EDGE       7,      11,     5,     9,         31    ; Edge 23
 EDGE      12,      13,     0,     0,         30    ; Edge 24
 EDGE      13,      14,     0,     0,         30    ; Edge 25
 EDGE      14,      15,     0,     0,         30    ; Edge 26
 EDGE      15,      12,     0,     0,         30    ; Edge 27

.SHIP_CORIOLIS_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,        0,      160,         31      ; Face 0
 FACE      107,     -107,      107,         31      ; Face 1
 FACE      107,      107,      107,         31      ; Face 2
 FACE     -107,      107,      107,         31      ; Face 3
 FACE     -107,     -107,      107,         31      ; Face 4
 FACE        0,     -160,        0,         31      ; Face 5
 FACE      160,        0,        0,         31      ; Face 6
 FACE     -160,        0,        0,         31      ; Face 7
 FACE        0,      160,        0,         31      ; Face 8
 FACE     -107,     -107,     -107,         31      ; Face 9
 FACE      107,     -107,     -107,         31      ; Face 10
 FACE      107,      107,     -107,         31      ; Face 11
 FACE     -107,      107,     -107,         31      ; Face 12
 FACE        0,        0,     -160,         31      ; Face 13

; ******************************************************************************
;
;       Name: SHIP_ESCAPE_POD
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for an escape pod
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_ESCAPE_POD

 EQUB 0 + (2 << 4)      ; Max. canisters on demise = 0
                        ; Market item when scooped = 2 + 1 = 3 (slaves)
 EQUW 16 * 16           ; Targetable area          = 16 * 16

 EQUB LO(SHIP_ESCAPE_POD_EDGES - SHIP_ESCAPE_POD)  ; Edges data offset (low)
 EQUB LO(SHIP_ESCAPE_POD_FACES - SHIP_ESCAPE_POD)  ; Faces data offset (low)

 EQUB 29                ; Max. edge count          = (29 - 1) / 4 = 7
 EQUB 0                 ; Gun vertex               = 0
 EQUB 22                ; Explosion count          = 4, as (4 * n) + 6 = 22
 EQUB 24                ; Number of vertices       = 24 / 6 = 4
 EQUB 6                 ; Number of edges          = 6
 EQUW 0                 ; Bounty                   = 0
 EQUB 16                ; Number of faces          = 16 / 4 = 4
 EQUB 8                 ; Visibility distance      = 8
 EQUB 17                ; Max. energy              = 17
 EQUB 8                 ; Max. speed               = 8

 EQUB HI(SHIP_ESCAPE_POD_EDGES - SHIP_ESCAPE_POD)  ; Edges data offset (high)
 EQUB HI(SHIP_ESCAPE_POD_FACES - SHIP_ESCAPE_POD)  ; Faces data offset (high)

 EQUB 4                 ; Normals are scaled by    =  2^4 = 16
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_ESCAPE_POD_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   -7,    0,   36,     2,      1,    3,     3,         31    ; Vertex 0
 VERTEX   -7,  -14,  -12,     2,      0,    3,     3,         31    ; Vertex 1
 VERTEX   -7,   14,  -12,     1,      0,    3,     3,         31    ; Vertex 2
 VERTEX   21,    0,    0,     1,      0,    2,     2,         31    ; Vertex 3

.SHIP_ESCAPE_POD_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     3,     2,         31    ; Edge 0
 EDGE       1,       2,     3,     0,         31    ; Edge 1
 EDGE       2,       3,     1,     0,         31    ; Edge 2
 EDGE       3,       0,     2,     1,         31    ; Edge 3
 EDGE       0,       2,     3,     1,         31    ; Edge 4
 EDGE       3,       1,     2,     0,         31    ; Edge 5

.SHIP_ESCAPE_POD_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE       52,        0,     -122,         31      ; Face 0
 FACE       39,      103,       30,         31      ; Face 1
 FACE       39,     -103,       30,         31      ; Face 2
 FACE     -112,        0,        0,         31      ; Face 3

; ******************************************************************************
;
;       Name: SHIP_PLATE
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for an alloy plate
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_PLATE

 EQUB 0 + (8 << 4)      ; Max. canisters on demise = 0
                        ; Market item when scooped = 8 + 1 = 9 (alloys)
 EQUW 10 * 10           ; Targetable area          = 10 * 10

 EQUB LO(SHIP_PLATE_EDGES - SHIP_PLATE)            ; Edges data offset (low)
 EQUB LO(SHIP_PLATE_FACES - SHIP_PLATE)            ; Faces data offset (low)

 EQUB 21                ; Max. edge count          = (21 - 1) / 4 = 5
 EQUB 0                 ; Gun vertex               = 0
 EQUB 10                ; Explosion count          = 1, as (4 * n) + 6 = 10
 EQUB 24                ; Number of vertices       = 24 / 6 = 4
 EQUB 4                 ; Number of edges          = 4
 EQUW 0                 ; Bounty                   = 0
 EQUB 4                 ; Number of faces          = 4 / 4 = 1
 EQUB 5                 ; Visibility distance      = 5
 EQUB 16                ; Max. energy              = 16
 EQUB 16                ; Max. speed               = 16

 EQUB HI(SHIP_PLATE_EDGES - SHIP_PLATE)            ; Edges data offset (high)
 EQUB HI(SHIP_PLATE_FACES - SHIP_PLATE)            ; Faces data offset (high)

 EQUB 3                 ; Normals are scaled by    = 2^3 = 8
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_PLATE_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX  -15,  -22,   -9,    15,     15,   15,    15,         31    ; Vertex 0
 VERTEX  -15,   38,   -9,    15,     15,   15,    15,         31    ; Vertex 1
 VERTEX   19,   32,   11,    15,     15,   15,    15,         20    ; Vertex 2
 VERTEX   10,  -46,    6,    15,     15,   15,    15,         20    ; Vertex 3

.SHIP_PLATE_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,    15,    15,         31    ; Edge 0
 EDGE       1,       2,    15,    15,         16    ; Edge 1
 EDGE       2,       3,    15,    15,         20    ; Edge 2
 EDGE       3,       0,    15,    15,         16    ; Edge 3

.SHIP_PLATE_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,        0,        0,          0      ; Face 0

; ******************************************************************************
;
;       Name: SHIP_CANISTER
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a cargo canister
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_CANISTER

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 20 * 20           ; Targetable area          = 20 * 20

 EQUB LO(SHIP_CANISTER_EDGES - SHIP_CANISTER)      ; Edges data offset (low)
 EQUB LO(SHIP_CANISTER_FACES - SHIP_CANISTER)      ; Faces data offset (low)

 EQUB 53                ; Max. edge count          = (53 - 1) / 4 = 13
 EQUB 0                 ; Gun vertex               = 0
 EQUB 18                ; Explosion count          = 3, as (4 * n) + 6 = 18
 EQUB 60                ; Number of vertices       = 60 / 6 = 10
 EQUB 15                ; Number of edges          = 15
 EQUW 0                 ; Bounty                   = 0
 EQUB 28                ; Number of faces          = 28 / 4 = 7
 EQUB 12                ; Visibility distance      = 12
 EQUB 17                ; Max. energy              = 17
 EQUB 15                ; Max. speed               = 15

 EQUB HI(SHIP_CANISTER_EDGES - SHIP_CANISTER)      ; Edges data offset (high)
 EQUB HI(SHIP_CANISTER_FACES - SHIP_CANISTER)      ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_CANISTER_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   24,   16,    0,     0,      1,    5,     5,         31    ; Vertex 0
 VERTEX   24,    5,   15,     0,      1,    2,     2,         31    ; Vertex 1
 VERTEX   24,  -13,    9,     0,      2,    3,     3,         31    ; Vertex 2
 VERTEX   24,  -13,   -9,     0,      3,    4,     4,         31    ; Vertex 3
 VERTEX   24,    5,  -15,     0,      4,    5,     5,         31    ; Vertex 4
 VERTEX  -24,   16,    0,     1,      5,    6,     6,         31    ; Vertex 5
 VERTEX  -24,    5,   15,     1,      2,    6,     6,         31    ; Vertex 6
 VERTEX  -24,  -13,    9,     2,      3,    6,     6,         31    ; Vertex 7
 VERTEX  -24,  -13,   -9,     3,      4,    6,     6,         31    ; Vertex 8
 VERTEX  -24,    5,  -15,     4,      5,    6,     6,         31    ; Vertex 9

.SHIP_CANISTER_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     0,     1,         31    ; Edge 0
 EDGE       1,       2,     0,     2,         31    ; Edge 1
 EDGE       2,       3,     0,     3,         31    ; Edge 2
 EDGE       3,       4,     0,     4,         31    ; Edge 3
 EDGE       0,       4,     0,     5,         31    ; Edge 4
 EDGE       0,       5,     1,     5,         31    ; Edge 5
 EDGE       1,       6,     1,     2,         31    ; Edge 6
 EDGE       2,       7,     2,     3,         31    ; Edge 7
 EDGE       3,       8,     3,     4,         31    ; Edge 8
 EDGE       4,       9,     4,     5,         31    ; Edge 9
 EDGE       5,       6,     1,     6,         31    ; Edge 10
 EDGE       6,       7,     2,     6,         31    ; Edge 11
 EDGE       7,       8,     3,     6,         31    ; Edge 12
 EDGE       8,       9,     4,     6,         31    ; Edge 13
 EDGE       9,       5,     5,     6,         31    ; Edge 14

.SHIP_CANISTER_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE       96,        0,        0,         31      ; Face 0
 FACE        0,       41,       30,         31      ; Face 1
 FACE        0,      -18,       48,         31      ; Face 2
 FACE        0,      -51,        0,         31      ; Face 3
 FACE        0,      -18,      -48,         31      ; Face 4
 FACE        0,       41,      -30,         31      ; Face 5
 FACE      -96,        0,        0,         31      ; Face 6

; ******************************************************************************
;
;       Name: SHIP_BOULDER
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a boulder
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_BOULDER

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 30 * 30           ; Targetable area          = 30 * 30

 EQUB LO(SHIP_BOULDER_EDGES - SHIP_BOULDER)        ; Edges data offset (low)
 EQUB LO(SHIP_BOULDER_FACES - SHIP_BOULDER)        ; Faces data offset (low)

 EQUB 49                ; Max. edge count          = (49 - 1) / 4 = 12
 EQUB 0                 ; Gun vertex               = 0
 EQUB 14                ; Explosion count          = 2, as (4 * n) + 6 = 14
 EQUB 42                ; Number of vertices       = 42 / 6 = 7
 EQUB 15                ; Number of edges          = 15
 EQUW 1                 ; Bounty                   = 1
 EQUB 40                ; Number of faces          = 40 / 4 = 10
 EQUB 20                ; Visibility distance      = 20
 EQUB 20                ; Max. energy              = 20
 EQUB 30                ; Max. speed               = 30

 EQUB HI(SHIP_BOULDER_EDGES - SHIP_BOULDER)        ; Edges data offset (high)
 EQUB HI(SHIP_BOULDER_FACES - SHIP_BOULDER)        ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_BOULDER_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX  -18,   37,  -11,     1,      0,    9,     5,         31    ; Vertex 0
 VERTEX   30,    7,   12,     2,      1,    6,     5,         31    ; Vertex 1
 VERTEX   28,   -7,  -12,     3,      2,    7,     6,         31    ; Vertex 2
 VERTEX    2,    0,  -39,     4,      3,    8,     7,         31    ; Vertex 3
 VERTEX  -28,   34,  -30,     4,      0,    9,     8,         31    ; Vertex 4
 VERTEX    5,  -10,   13,    15,     15,   15,    15,         31    ; Vertex 5
 VERTEX   20,   17,  -30,    15,     15,   15,    15,         31    ; Vertex 6

.SHIP_BOULDER_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     5,     1,         31    ; Edge 0
 EDGE       1,       2,     6,     2,         31    ; Edge 1
 EDGE       2,       3,     7,     3,         31    ; Edge 2
 EDGE       3,       4,     8,     4,         31    ; Edge 3
 EDGE       4,       0,     9,     0,         31    ; Edge 4
 EDGE       0,       5,     1,     0,         31    ; Edge 5
 EDGE       1,       5,     2,     1,         31    ; Edge 6
 EDGE       2,       5,     3,     2,         31    ; Edge 7
 EDGE       3,       5,     4,     3,         31    ; Edge 8
 EDGE       4,       5,     4,     0,         31    ; Edge 9
 EDGE       0,       6,     9,     5,         31    ; Edge 10
 EDGE       1,       6,     6,     5,         31    ; Edge 11
 EDGE       2,       6,     7,     6,         31    ; Edge 12
 EDGE       3,       6,     8,     7,         31    ; Edge 13
 EDGE       4,       6,     9,     8,         31    ; Edge 14

.SHIP_BOULDER_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE      -15,       -3,        8,         31      ; Face 0
 FACE       -7,       12,       30,         31      ; Face 1
 FACE       32,      -47,       24,         31      ; Face 2
 FACE       -3,      -39,       -7,         31      ; Face 3
 FACE       -5,       -4,       -1,         31      ; Face 4
 FACE       49,       84,        8,         31      ; Face 5
 FACE      112,       21,      -21,         31      ; Face 6
 FACE       76,      -35,      -82,         31      ; Face 7
 FACE       22,       56,     -137,         31      ; Face 8
 FACE       40,      110,      -38,         31      ; Face 9

; ******************************************************************************
;
;       Name: SHIP_ASTEROID
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for an asteroid
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_ASTEROID

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 80 * 80           ; Targetable area          = 80 * 80

 EQUB LO(SHIP_ASTEROID_EDGES - SHIP_ASTEROID)      ; Edges data offset (low)
 EQUB LO(SHIP_ASTEROID_FACES - SHIP_ASTEROID)      ; Faces data offset (low)

 EQUB 69                ; Max. edge count          = (69 - 1) / 4 = 17
 EQUB 0                 ; Gun vertex               = 0
 EQUB 34                ; Explosion count          = 7, as (4 * n) + 6 = 34
 EQUB 54                ; Number of vertices       = 54 / 6 = 9
 EQUB 21                ; Number of edges          = 21
 EQUW 5                 ; Bounty                   = 5
 EQUB 56                ; Number of faces          = 56 / 4 = 14
 EQUB 50                ; Visibility distance      = 50
 EQUB 60                ; Max. energy              = 60
 EQUB 30                ; Max. speed               = 30

 EQUB HI(SHIP_ASTEROID_EDGES - SHIP_ASTEROID)      ; Edges data offset (high)
 EQUB HI(SHIP_ASTEROID_FACES - SHIP_ASTEROID)      ; Faces data offset (high)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_ASTEROID_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,   80,    0,    15,     15,   15,    15,         31    ; Vertex 0
 VERTEX  -80,  -10,    0,    15,     15,   15,    15,         31    ; Vertex 1
 VERTEX    0,  -80,    0,    15,     15,   15,    15,         31    ; Vertex 2
 VERTEX   70,  -40,    0,    15,     15,   15,    15,         31    ; Vertex 3
 VERTEX   60,   50,    0,     5,      6,   12,    13,         31    ; Vertex 4
 VERTEX   50,    0,   60,    15,     15,   15,    15,         31    ; Vertex 5
 VERTEX  -40,    0,   70,     0,      1,    2,     3,         31    ; Vertex 6
 VERTEX    0,   30,  -75,    15,     15,   15,    15,         31    ; Vertex 7
 VERTEX    0,  -50,  -60,     8,      9,   10,    11,         31    ; Vertex 8

.SHIP_ASTEROID_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     2,     7,         31    ; Edge 0
 EDGE       0,       4,     6,    13,         31    ; Edge 1
 EDGE       3,       4,     5,    12,         31    ; Edge 2
 EDGE       2,       3,     4,    11,         31    ; Edge 3
 EDGE       1,       2,     3,    10,         31    ; Edge 4
 EDGE       1,       6,     2,     3,         31    ; Edge 5
 EDGE       2,       6,     1,     3,         31    ; Edge 6
 EDGE       2,       5,     1,     4,         31    ; Edge 7
 EDGE       5,       6,     0,     1,         31    ; Edge 8
 EDGE       0,       5,     0,     6,         31    ; Edge 9
 EDGE       3,       5,     4,     5,         31    ; Edge 10
 EDGE       0,       6,     0,     2,         31    ; Edge 11
 EDGE       4,       5,     5,     6,         31    ; Edge 12
 EDGE       1,       8,     8,    10,         31    ; Edge 13
 EDGE       1,       7,     7,     8,         31    ; Edge 14
 EDGE       0,       7,     7,    13,         31    ; Edge 15
 EDGE       4,       7,    12,    13,         31    ; Edge 16
 EDGE       3,       7,     9,    12,         31    ; Edge 17
 EDGE       3,       8,     9,    11,         31    ; Edge 18
 EDGE       2,       8,    10,    11,         31    ; Edge 19
 EDGE       7,       8,     8,     9,         31    ; Edge 20

.SHIP_ASTEROID_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        9,       66,       81,         31      ; Face 0
 FACE        9,      -66,       81,         31      ; Face 1
 FACE      -72,       64,       31,         31      ; Face 2
 FACE      -64,      -73,       47,         31      ; Face 3
 FACE       45,      -79,       65,         31      ; Face 4
 FACE      135,       15,       35,         31      ; Face 5
 FACE       38,       76,       70,         31      ; Face 6
 FACE      -66,       59,      -39,         31      ; Face 7
 FACE      -67,      -15,      -80,         31      ; Face 8
 FACE       66,      -14,      -75,         31      ; Face 9
 FACE      -70,      -80,      -40,         31      ; Face 10
 FACE       58,     -102,      -51,         31      ; Face 11
 FACE       81,        9,      -67,         31      ; Face 12
 FACE       47,       94,      -63,         31      ; Face 13

; ******************************************************************************
;
;       Name: SHIP_SPLINTER
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a splinter
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ------------------------------------------------------------------------------
;
; The ship blueprint for the splinter reuses the edges data from the escape pod,
; so the edges data offset is negative.
;
; ******************************************************************************

.SHIP_SPLINTER

 EQUB 0 + (11 << 4)     ; Max. canisters on demise = 0
                        ; Market item when scooped = 11 + 1 = 12 (minerals)
 EQUW 16 * 16           ; Targetable area          = 16 * 16

 EQUB LO(SHIP_ESCAPE_POD_EDGES - SHIP_SPLINTER)    ; Edges from escape pod
 EQUB LO(SHIP_SPLINTER_FACES - SHIP_SPLINTER) + 24 ; Faces data offset (low)

 EQUB 29                ; Max. edge count          = (29 - 1) / 4 = 7
 EQUB 0                 ; Gun vertex               = 0
 EQUB 22                ; Explosion count          = 4, as (4 * n) + 6 = 22
 EQUB 24                ; Number of vertices       = 24 / 6 = 4
 EQUB 6                 ; Number of edges          = 6
 EQUW 0                 ; Bounty                   = 0
 EQUB 16                ; Number of faces          = 16 / 4 = 4
 EQUB 8                 ; Visibility distance      = 8
 EQUB 20                ; Max. energy              = 20
 EQUB 10                ; Max. speed               = 10

 EQUB HI(SHIP_ESCAPE_POD_EDGES - SHIP_SPLINTER)    ; Edges from escape pod
 EQUB HI(SHIP_SPLINTER_FACES - SHIP_SPLINTER)      ; Faces data offset (low)

 EQUB 5                 ; Normals are scaled by    = 2^5 = 32
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_SPLINTER_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX  -24,  -25,   16,     2,      1,    3,     3,         31    ; Vertex 0
 VERTEX    0,   12,  -10,     2,      0,    3,     3,         31    ; Vertex 1
 VERTEX   11,   -6,    2,     1,      0,    3,     3,         31    ; Vertex 2
 VERTEX   12,   42,    7,     1,      0,    2,     2,         31    ; Vertex 3

.SHIP_SPLINTER_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE       35,        0,        4,         31      ; Face 0
 FACE        3,        4,        8,         31      ; Face 1
 FACE        1,        8,       12,         31      ; Face 2
 FACE       18,       12,        0,         31      ; Face 3

; ******************************************************************************
;
;       Name: SHIP_SHUTTLE
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Shuttle
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_SHUTTLE

 EQUB 15                ; Max. canisters on demise = 15
 EQUW 50 * 50           ; Targetable area          = 50 * 50

 EQUB LO(SHIP_SHUTTLE_EDGES - SHIP_SHUTTLE)        ; Edges data offset (low)
 EQUB LO(SHIP_SHUTTLE_FACES - SHIP_SHUTTLE)        ; Faces data offset (low)

 EQUB 113               ; Max. edge count          = (113 - 1) / 4 = 28
 EQUB 0                 ; Gun vertex               = 0
 EQUB 38                ; Explosion count          = 8, as (4 * n) + 6 = 38
 EQUB 114               ; Number of vertices       = 114 / 6 = 19
 EQUB 30                ; Number of edges          = 30
 EQUW 0                 ; Bounty                   = 0
 EQUB 52                ; Number of faces          = 52 / 4 = 13
 EQUB 22                ; Visibility distance      = 22
 EQUB 32                ; Max. energy              = 32
 EQUB 8                 ; Max. speed               = 8

 EQUB HI(SHIP_SHUTTLE_EDGES - SHIP_SHUTTLE)        ; Edges data offset (high)
 EQUB HI(SHIP_SHUTTLE_FACES - SHIP_SHUTTLE)        ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_SHUTTLE_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,  -17,   23,    15,     15,   15,    15,         31    ; Vertex 0
 VERTEX  -17,    0,   23,    15,     15,   15,    15,         31    ; Vertex 1
 VERTEX    0,   18,   23,    15,     15,   15,    15,         31    ; Vertex 2
 VERTEX   18,    0,   23,    15,     15,   15,    15,         31    ; Vertex 3
 VERTEX  -20,  -20,  -27,     2,      1,    9,     3,         31    ; Vertex 4
 VERTEX  -20,   20,  -27,     4,      3,    9,     5,         31    ; Vertex 5
 VERTEX   20,   20,  -27,     6,      5,    9,     7,         31    ; Vertex 6
 VERTEX   20,  -20,  -27,     7,      1,    9,     8,         31    ; Vertex 7
 VERTEX    5,    0,  -27,     9,      9,    9,     9,         16    ; Vertex 8
 VERTEX    0,   -2,  -27,     9,      9,    9,     9,         16    ; Vertex 9
 VERTEX   -5,    0,  -27,     9,      9,    9,     9,          9    ; Vertex 10
 VERTEX    0,    3,  -27,     9,      9,    9,     9,          9    ; Vertex 11
 VERTEX    0,   -9,   35,    10,      0,   12,    11,         16    ; Vertex 12
 VERTEX    3,   -1,   31,    15,     15,    2,     0,          7    ; Vertex 13
 VERTEX    4,   11,   25,     1,      0,    4,    15,          8    ; Vertex 14
 VERTEX   11,    4,   25,     1,     10,   15,     3,          8    ; Vertex 15
 VERTEX   -3,   -1,   31,    11,      6,    3,     2,          7    ; Vertex 16
 VERTEX   -3,   11,   25,     8,     15,    0,    12,          8    ; Vertex 17
 VERTEX  -10,    4,   25,    15,      4,    8,     1,          8    ; Vertex 18

.SHIP_SHUTTLE_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     2,     0,         31    ; Edge 0
 EDGE       1,       2,    10,     4,         31    ; Edge 1
 EDGE       2,       3,    11,     6,         31    ; Edge 2
 EDGE       0,       3,    12,     8,         31    ; Edge 3
 EDGE       0,       7,     8,     1,         31    ; Edge 4
 EDGE       0,       4,     2,     1,         24    ; Edge 5
 EDGE       1,       4,     3,     2,         31    ; Edge 6
 EDGE       1,       5,     4,     3,         24    ; Edge 7
 EDGE       2,       5,     5,     4,         31    ; Edge 8
 EDGE       2,       6,     6,     5,         12    ; Edge 9
 EDGE       3,       6,     7,     6,         31    ; Edge 10
 EDGE       3,       7,     8,     7,         24    ; Edge 11
 EDGE       4,       5,     9,     3,         31    ; Edge 12
 EDGE       5,       6,     9,     5,         31    ; Edge 13
 EDGE       6,       7,     9,     7,         31    ; Edge 14
 EDGE       4,       7,     9,     1,         31    ; Edge 15
 EDGE       0,      12,    12,     0,         16    ; Edge 16
 EDGE       1,      12,    10,     0,         16    ; Edge 17
 EDGE       2,      12,    11,    10,         16    ; Edge 18
 EDGE       3,      12,    12,    11,         16    ; Edge 19
 EDGE       8,       9,     9,     9,         16    ; Edge 20
 EDGE       9,      10,     9,     9,          7    ; Edge 21
 EDGE      10,      11,     9,     9,          9    ; Edge 22
 EDGE       8,      11,     9,     9,          7    ; Edge 23
 EDGE      13,      14,    11,    11,          5    ; Edge 24
 EDGE      14,      15,    11,    11,          8    ; Edge 25
 EDGE      13,      15,    11,    11,          7    ; Edge 26
 EDGE      16,      17,    10,    10,          5    ; Edge 27
 EDGE      17,      18,    10,    10,          8    ; Edge 28
 EDGE      16,      18,    10,    10,          7    ; Edge 29

.SHIP_SHUTTLE_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE      -55,      -55,       40,         31      ; Face 0
 FACE        0,      -74,        4,         31      ; Face 1
 FACE      -51,      -51,       23,         31      ; Face 2
 FACE      -74,        0,        4,         31      ; Face 3
 FACE      -51,       51,       23,         31      ; Face 4
 FACE        0,       74,        4,         31      ; Face 5
 FACE       51,       51,       23,         31      ; Face 6
 FACE       74,        0,        4,         31      ; Face 7
 FACE       51,      -51,       23,         31      ; Face 8
 FACE        0,        0,     -107,         31      ; Face 9
 FACE      -41,       41,       90,         31      ; Face 10
 FACE       41,       41,       90,         31      ; Face 11
 FACE       55,      -55,       40,         31      ; Face 12

; ******************************************************************************
;
;       Name: SHIP_TRANSPORTER
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Transporter
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_TRANSPORTER

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 50 * 50           ; Targetable area          = 50 * 50

 EQUB LO(SHIP_TRANSPORTER_EDGES - SHIP_TRANSPORTER)   ; Edges data offset (low)
 EQUB LO(SHIP_TRANSPORTER_FACES - SHIP_TRANSPORTER)   ; Faces data offset (low)

 EQUB 149               ; Max. edge count          = (149 - 1) / 4 = 37
 EQUB 48                ; Gun vertex               = 48 / 4 = 12
 EQUB 26                ; Explosion count          = 5, as (4 * n) + 6 = 26
 EQUB 222               ; Number of vertices       = 222 / 6 = 37
 EQUB 46                ; Number of edges          = 46
 EQUW 0                 ; Bounty                   = 0
 EQUB 56                ; Number of faces          = 56 / 4 = 14
 EQUB 16                ; Visibility distance      = 16
 EQUB 32                ; Max. energy              = 32
 EQUB 10                ; Max. speed               = 10

 EQUB HI(SHIP_TRANSPORTER_EDGES - SHIP_TRANSPORTER)   ; Edges data offset (high)
 EQUB HI(SHIP_TRANSPORTER_FACES - SHIP_TRANSPORTER)   ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_TRANSPORTER_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,   10,  -26,     6,      0,    7,     7,         31    ; Vertex 0
 VERTEX  -25,    4,  -26,     1,      0,    7,     7,         31    ; Vertex 1
 VERTEX  -28,   -3,  -26,     1,      0,    2,     2,         31    ; Vertex 2
 VERTEX  -25,   -8,  -26,     2,      0,    3,     3,         31    ; Vertex 3
 VERTEX   26,   -8,  -26,     3,      0,    4,     4,         31    ; Vertex 4
 VERTEX   29,   -3,  -26,     4,      0,    5,     5,         31    ; Vertex 5
 VERTEX   26,    4,  -26,     5,      0,    6,     6,         31    ; Vertex 6
 VERTEX    0,    6,   12,    15,     15,   15,    15,         19    ; Vertex 7
 VERTEX  -30,   -1,   12,     7,      1,    9,     8,         31    ; Vertex 8
 VERTEX  -33,   -8,   12,     2,      1,    9,     3,         31    ; Vertex 9
 VERTEX   33,   -8,   12,     4,      3,   10,     5,         31    ; Vertex 10
 VERTEX   30,   -1,   12,     6,      5,   11,    10,         31    ; Vertex 11
 VERTEX  -11,   -2,   30,     9,      8,   13,    12,         31    ; Vertex 12
 VERTEX  -13,   -8,   30,     9,      3,   13,    13,         31    ; Vertex 13
 VERTEX   14,   -8,   30,    10,      3,   13,    13,         31    ; Vertex 14
 VERTEX   11,   -2,   30,    11,     10,   13,    12,         31    ; Vertex 15
 VERTEX   -5,    6,    2,     7,      7,    7,     7,          7    ; Vertex 16
 VERTEX  -18,    3,    2,     7,      7,    7,     7,          7    ; Vertex 17
 VERTEX   -5,    7,   -7,     7,      7,    7,     7,          7    ; Vertex 18
 VERTEX  -18,    4,   -7,     7,      7,    7,     7,          7    ; Vertex 19
 VERTEX  -11,    6,  -14,     7,      7,    7,     7,          7    ; Vertex 20
 VERTEX  -11,    5,   -7,     7,      7,    7,     7,          7    ; Vertex 21
 VERTEX    5,    7,  -14,     6,      6,    6,     6,          7    ; Vertex 22
 VERTEX   18,    4,  -14,     6,      6,    6,     6,          7    ; Vertex 23
 VERTEX   11,    5,   -7,     6,      6,    6,     6,          7    ; Vertex 24
 VERTEX    5,    6,   -3,     6,      6,    6,     6,          7    ; Vertex 25
 VERTEX   18,    3,   -3,     6,      6,    6,     6,          7    ; Vertex 26
 VERTEX   11,    4,    8,     6,      6,    6,     6,          7    ; Vertex 27
 VERTEX   11,    5,   -3,     6,      6,    6,     6,          7    ; Vertex 28
 VERTEX  -16,   -8,  -13,     3,      3,    3,     3,          6    ; Vertex 29
 VERTEX  -16,   -8,   16,     3,      3,    3,     3,          6    ; Vertex 30
 VERTEX   17,   -8,  -13,     3,      3,    3,     3,          6    ; Vertex 31
 VERTEX   17,   -8,   16,     3,      3,    3,     3,          6    ; Vertex 32
 VERTEX  -13,   -3,  -26,     0,      0,    0,     0,          8    ; Vertex 33
 VERTEX   13,   -3,  -26,     0,      0,    0,     0,          8    ; Vertex 34
 VERTEX    9,    3,  -26,     0,      0,    0,     0,          5    ; Vertex 35
 VERTEX   -8,    3,  -26,     0,      0,    0,     0,          5    ; Vertex 36

.SHIP_TRANSPORTER_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     7,     0,         31    ; Edge 0
 EDGE       1,       2,     1,     0,         31    ; Edge 1
 EDGE       2,       3,     2,     0,         31    ; Edge 2
 EDGE       3,       4,     3,     0,         31    ; Edge 3
 EDGE       4,       5,     4,     0,         31    ; Edge 4
 EDGE       5,       6,     5,     0,         31    ; Edge 5
 EDGE       0,       6,     6,     0,         31    ; Edge 6
 EDGE       0,       7,     7,     6,         16    ; Edge 7
 EDGE       1,       8,     7,     1,         31    ; Edge 8
 EDGE       2,       9,     2,     1,         11    ; Edge 9
 EDGE       3,       9,     3,     2,         31    ; Edge 10
 EDGE       4,      10,     4,     3,         31    ; Edge 11
 EDGE       5,      10,     5,     4,         11    ; Edge 12
 EDGE       6,      11,     6,     5,         31    ; Edge 13
 EDGE       7,       8,     8,     7,         17    ; Edge 14
 EDGE       8,       9,     9,     1,         17    ; Edge 15
 EDGE      10,      11,    10,     5,         17    ; Edge 16
 EDGE       7,      11,    11,     6,         17    ; Edge 17
 EDGE       7,      15,    12,    11,         19    ; Edge 18
 EDGE       7,      12,    12,     8,         19    ; Edge 19
 EDGE       8,      12,     9,     8,         16    ; Edge 20
 EDGE       9,      13,     9,     3,         31    ; Edge 21
 EDGE      10,      14,    10,     3,         31    ; Edge 22
 EDGE      11,      15,    11,    10,         16    ; Edge 23
 EDGE      12,      13,    13,     9,         31    ; Edge 24
 EDGE      13,      14,    13,     3,         31    ; Edge 25
 EDGE      14,      15,    13,    10,         31    ; Edge 26
 EDGE      12,      15,    13,    12,         31    ; Edge 27
 EDGE      16,      17,     7,     7,          7    ; Edge 28
 EDGE      18,      19,     7,     7,          7    ; Edge 29
 EDGE      19,      20,     7,     7,          7    ; Edge 30
 EDGE      18,      20,     7,     7,          7    ; Edge 31
 EDGE      20,      21,     7,     7,          7    ; Edge 32
 EDGE      22,      23,     6,     6,          7    ; Edge 33
 EDGE      23,      24,     6,     6,          7    ; Edge 34
 EDGE      24,      22,     6,     6,          7    ; Edge 35
 EDGE      25,      26,     6,     6,          7    ; Edge 36
 EDGE      26,      27,     6,     6,          7    ; Edge 37
 EDGE      25,      27,     6,     6,          7    ; Edge 38
 EDGE      27,      28,     6,     6,          7    ; Edge 39
 EDGE      29,      30,     3,     3,          6    ; Edge 40
 EDGE      31,      32,     3,     3,          6    ; Edge 41
 EDGE      33,      34,     0,     0,          8    ; Edge 42
 EDGE      34,      35,     0,     0,          5    ; Edge 43
 EDGE      35,      36,     0,     0,          5    ; Edge 44
 EDGE      36,      33,     0,     0,          5    ; Edge 45

.SHIP_TRANSPORTER_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,        0,     -103,         31      ; Face 0
 FACE     -111,       48,       -7,         31      ; Face 1
 FACE     -105,      -63,      -21,         31      ; Face 2
 FACE        0,      -34,        0,         31      ; Face 3
 FACE      105,      -63,      -21,         31      ; Face 4
 FACE      111,       48,       -7,         31      ; Face 5
 FACE        8,       32,        3,         31      ; Face 6
 FACE       -8,       32,        3,         31      ; Face 7
 FACE       -8,       34,       11,         19      ; Face 8
 FACE      -75,       32,       79,         31      ; Face 9
 FACE       75,       32,       79,         31      ; Face 10
 FACE        8,       34,       11,         19      ; Face 11
 FACE        0,       38,       17,         31      ; Face 12
 FACE        0,        0,      121,         31      ; Face 13

; ******************************************************************************
;
;       Name: SHIP_COBRA_MK_3
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Cobra Mk III
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_COBRA_MK_3

 EQUB 3                 ; Max. canisters on demise = 3
 EQUW 95 * 95           ; Targetable area          = 95 * 95

 EQUB LO(SHIP_COBRA_MK_3_EDGES - SHIP_COBRA_MK_3)  ; Edges data offset (low)
 EQUB LO(SHIP_COBRA_MK_3_FACES - SHIP_COBRA_MK_3)  ; Faces data offset (low)

 EQUB 157               ; Max. edge count          = (157 - 1) / 4 = 39
 EQUB 84                ; Gun vertex               = 84 / 4 = 21
 EQUB 42                ; Explosion count          = 9, as (4 * n) + 6 = 42
 EQUB 168               ; Number of vertices       = 168 / 6 = 28
 EQUB 38                ; Number of edges          = 38
 EQUW 0                 ; Bounty                   = 0
 EQUB 52                ; Number of faces          = 52 / 4 = 13
 EQUB 50                ; Visibility distance      = 50
 EQUB 150               ; Max. energy              = 150
 EQUB 28                ; Max. speed               = 28

 EQUB HI(SHIP_COBRA_MK_3_EDGES - SHIP_COBRA_MK_3)  ; Edges data offset (low)
 EQUB HI(SHIP_COBRA_MK_3_FACES - SHIP_COBRA_MK_3)  ; Faces data offset (low)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00010011         ; Laser power              = 2
                        ; Missiles                 = 3

.SHIP_COBRA_MK_3_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   32,    0,   76,    15,     15,   15,    15,         31    ; Vertex 0
 VERTEX  -32,    0,   76,    15,     15,   15,    15,         31    ; Vertex 1
 VERTEX    0,   26,   24,    15,     15,   15,    15,         31    ; Vertex 2
 VERTEX -120,   -3,   -8,     3,      7,   10,    10,         31    ; Vertex 3
 VERTEX  120,   -3,   -8,     4,      8,   12,    12,         31    ; Vertex 4
 VERTEX  -88,   16,  -40,    15,     15,   15,    15,         31    ; Vertex 5
 VERTEX   88,   16,  -40,    15,     15,   15,    15,         31    ; Vertex 6
 VERTEX  128,   -8,  -40,     8,      9,   12,    12,         31    ; Vertex 7
 VERTEX -128,   -8,  -40,     7,      9,   10,    10,         31    ; Vertex 8
 VERTEX    0,   26,  -40,     5,      6,    9,     9,         31    ; Vertex 9
 VERTEX  -32,  -24,  -40,     9,     10,   11,    11,         31    ; Vertex 10
 VERTEX   32,  -24,  -40,     9,     11,   12,    12,         31    ; Vertex 11
 VERTEX  -36,    8,  -40,     9,      9,    9,     9,         20    ; Vertex 12
 VERTEX   -8,   12,  -40,     9,      9,    9,     9,         20    ; Vertex 13
 VERTEX    8,   12,  -40,     9,      9,    9,     9,         20    ; Vertex 14
 VERTEX   36,    8,  -40,     9,      9,    9,     9,         20    ; Vertex 15
 VERTEX   36,  -12,  -40,     9,      9,    9,     9,         20    ; Vertex 16
 VERTEX    8,  -16,  -40,     9,      9,    9,     9,         20    ; Vertex 17
 VERTEX   -8,  -16,  -40,     9,      9,    9,     9,         20    ; Vertex 18
 VERTEX  -36,  -12,  -40,     9,      9,    9,     9,         20    ; Vertex 19
 VERTEX    0,    0,   76,     0,     11,   11,    11,          6    ; Vertex 20
 VERTEX    0,    0,   90,     0,     11,   11,    11,         31    ; Vertex 21
 VERTEX  -80,   -6,  -40,     9,      9,    9,     9,          8    ; Vertex 22
 VERTEX  -80,    6,  -40,     9,      9,    9,     9,          8    ; Vertex 23
 VERTEX  -88,    0,  -40,     9,      9,    9,     9,          6    ; Vertex 24
 VERTEX   80,    6,  -40,     9,      9,    9,     9,          8    ; Vertex 25
 VERTEX   88,    0,  -40,     9,      9,    9,     9,          6    ; Vertex 26
 VERTEX   80,   -6,  -40,     9,      9,    9,     9,          8    ; Vertex 27

.SHIP_COBRA_MK_3_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     0,    11,         31    ; Edge 0
 EDGE       0,       4,     4,    12,         31    ; Edge 1
 EDGE       1,       3,     3,    10,         31    ; Edge 2
 EDGE       3,       8,     7,    10,         31    ; Edge 3
 EDGE       4,       7,     8,    12,         31    ; Edge 4
 EDGE       6,       7,     8,     9,         31    ; Edge 5
 EDGE       6,       9,     6,     9,         31    ; Edge 6
 EDGE       5,       9,     5,     9,         31    ; Edge 7
 EDGE       5,       8,     7,     9,         31    ; Edge 8
 EDGE       2,       5,     1,     5,         31    ; Edge 9
 EDGE       2,       6,     2,     6,         31    ; Edge 10
 EDGE       3,       5,     3,     7,         31    ; Edge 11
 EDGE       4,       6,     4,     8,         31    ; Edge 12
 EDGE       1,       2,     0,     1,         31    ; Edge 13
 EDGE       0,       2,     0,     2,         31    ; Edge 14
 EDGE       8,      10,     9,    10,         31    ; Edge 15
 EDGE      10,      11,     9,    11,         31    ; Edge 16
 EDGE       7,      11,     9,    12,         31    ; Edge 17
 EDGE       1,      10,    10,    11,         31    ; Edge 18
 EDGE       0,      11,    11,    12,         31    ; Edge 19
 EDGE       1,       5,     1,     3,         29    ; Edge 20
 EDGE       0,       6,     2,     4,         29    ; Edge 21
 EDGE      20,      21,     0,    11,          6    ; Edge 22
 EDGE      12,      13,     9,     9,         20    ; Edge 23
 EDGE      18,      19,     9,     9,         20    ; Edge 24
 EDGE      14,      15,     9,     9,         20    ; Edge 25
 EDGE      16,      17,     9,     9,         20    ; Edge 26
 EDGE      15,      16,     9,     9,         19    ; Edge 27
 EDGE      14,      17,     9,     9,         17    ; Edge 28
 EDGE      13,      18,     9,     9,         19    ; Edge 29
 EDGE      12,      19,     9,     9,         19    ; Edge 30
 EDGE       2,       9,     5,     6,         30    ; Edge 31
 EDGE      22,      24,     9,     9,          6    ; Edge 32
 EDGE      23,      24,     9,     9,          6    ; Edge 33
 EDGE      22,      23,     9,     9,          8    ; Edge 34
 EDGE      25,      26,     9,     9,          6    ; Edge 35
 EDGE      26,      27,     9,     9,          6    ; Edge 36
 EDGE      25,      27,     9,     9,          8    ; Edge 37

.SHIP_COBRA_MK_3_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       62,       31,         31      ; Face 0
 FACE      -18,       55,       16,         31      ; Face 1
 FACE       18,       55,       16,         31      ; Face 2
 FACE      -16,       52,       14,         31      ; Face 3
 FACE       16,       52,       14,         31      ; Face 4
 FACE      -14,       47,        0,         31      ; Face 5
 FACE       14,       47,        0,         31      ; Face 6
 FACE      -61,      102,        0,         31      ; Face 7
 FACE       61,      102,        0,         31      ; Face 8
 FACE        0,        0,      -80,         31      ; Face 9
 FACE       -7,      -42,        9,         31      ; Face 10
 FACE        0,      -30,        6,         31      ; Face 11
 FACE        7,      -42,        9,         31      ; Face 12

; ******************************************************************************
;
;       Name: SHIP_PYTHON
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Python
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_PYTHON

 EQUB 5                 ; Max. canisters on demise = 5
 EQUW 80 * 80           ; Targetable area          = 80 * 80

 EQUB LO(SHIP_PYTHON_EDGES - SHIP_PYTHON)          ; Edges data offset (low)
 EQUB LO(SHIP_PYTHON_FACES - SHIP_PYTHON)          ; Faces data offset (low)

 EQUB 89                ; Max. edge count          = (89 - 1) / 4 = 22
 EQUB 0                 ; Gun vertex               = 0
 EQUB 42                ; Explosion count          = 9, as (4 * n) + 6 = 42
 EQUB 66                ; Number of vertices       = 66 / 6 = 11
 EQUB 26                ; Number of edges          = 26
 EQUW 0                 ; Bounty                   = 0
 EQUB 52                ; Number of faces          = 52 / 4 = 13
 EQUB 40                ; Visibility distance      = 40
 EQUB 250               ; Max. energy              = 250
 EQUB 20                ; Max. speed               = 20

 EQUB HI(SHIP_PYTHON_EDGES - SHIP_PYTHON)          ; Edges data offset (high)
 EQUB HI(SHIP_PYTHON_FACES - SHIP_PYTHON)          ; Faces data offset (high)

 EQUB 0                 ; Normals are scaled by    = 2^0 = 1
 EQUB %00011011         ; Laser power              = 3
                        ; Missiles                 = 3

.SHIP_PYTHON_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    0,  224,     0,      1,    2,     3,         31    ; Vertex 0
 VERTEX    0,   48,   48,     0,      1,    4,     5,         31    ; Vertex 1
 VERTEX   96,    0,  -16,    15,     15,   15,    15,         31    ; Vertex 2
 VERTEX  -96,    0,  -16,    15,     15,   15,    15,         31    ; Vertex 3
 VERTEX    0,   48,  -32,     4,      5,    8,     9,         31    ; Vertex 4
 VERTEX    0,   24, -112,     9,      8,   12,    12,         31    ; Vertex 5
 VERTEX  -48,    0, -112,     8,     11,   12,    12,         31    ; Vertex 6
 VERTEX   48,    0, -112,     9,     10,   12,    12,         31    ; Vertex 7
 VERTEX    0,  -48,   48,     2,      3,    6,     7,         31    ; Vertex 8
 VERTEX    0,  -48,  -32,     6,      7,   10,    11,         31    ; Vertex 9
 VERTEX    0,  -24, -112,    10,     11,   12,    12,         31    ; Vertex 10

.SHIP_PYTHON_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       8,     2,     3,         31    ; Edge 0
 EDGE       0,       3,     0,     2,         31    ; Edge 1
 EDGE       0,       2,     1,     3,         31    ; Edge 2
 EDGE       0,       1,     0,     1,         31    ; Edge 3
 EDGE       2,       4,     9,     5,         31    ; Edge 4
 EDGE       1,       2,     1,     5,         31    ; Edge 5
 EDGE       2,       8,     7,     3,         31    ; Edge 6
 EDGE       1,       3,     0,     4,         31    ; Edge 7
 EDGE       3,       8,     2,     6,         31    ; Edge 8
 EDGE       2,       9,     7,    10,         31    ; Edge 9
 EDGE       3,       4,     4,     8,         31    ; Edge 10
 EDGE       3,       9,     6,    11,         31    ; Edge 11
 EDGE       3,       5,     8,     8,          7    ; Edge 12
 EDGE       3,      10,    11,    11,          7    ; Edge 13
 EDGE       2,       5,     9,     9,          7    ; Edge 14
 EDGE       2,      10,    10,    10,          7    ; Edge 15
 EDGE       2,       7,     9,    10,         31    ; Edge 16
 EDGE       3,       6,     8,    11,         31    ; Edge 17
 EDGE       5,       6,     8,    12,         31    ; Edge 18
 EDGE       5,       7,     9,    12,         31    ; Edge 19
 EDGE       7,      10,    12,    10,         31    ; Edge 20
 EDGE       6,      10,    11,    12,         31    ; Edge 21
 EDGE       4,       5,     8,     9,         31    ; Edge 22
 EDGE       9,      10,    10,    11,         31    ; Edge 23
 EDGE       1,       4,     4,     5,         31    ; Edge 24
 EDGE       8,       9,     6,     7,         31    ; Edge 25

.SHIP_PYTHON_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE      -27,       40,       11,        31    ; Face 0
 FACE       27,       40,       11,        31    ; Face 1
 FACE      -27,      -40,       11,        31    ; Face 2
 FACE       27,      -40,       11,        31    ; Face 3
 FACE      -19,       38,        0,        31    ; Face 4
 FACE       19,       38,        0,        31    ; Face 5
 FACE      -19,      -38,        0,        31    ; Face 6
 FACE       19,      -38,        0,        31    ; Face 7
 FACE      -25,       37,      -11,        31    ; Face 8
 FACE       25,       37,      -11,        31    ; Face 9
 FACE       25,      -37,      -11,        31    ; Face 10
 FACE      -25,      -37,      -11,        31    ; Face 11
 FACE        0,        0,     -112,        31    ; Face 12

; ******************************************************************************
;
;       Name: SHIP_BOA
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Boa
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_BOA

 EQUB 5                 ; Max. canisters on demise = 5
 EQUW 70 * 70           ; Targetable area          = 70 * 70

 EQUB LO(SHIP_BOA_EDGES - SHIP_BOA)                ; Edges data offset (low)
 EQUB LO(SHIP_BOA_FACES - SHIP_BOA)                ; Faces data offset (low)

 EQUB 93                ; Max. edge count          = (93 - 1) / 4 = 23
 EQUB 0                 ; Gun vertex               = 0
 EQUB 38                ; Explosion count          = 8, as (4 * n) + 6 = 38
 EQUB 78                ; Number of vertices       = 78 / 6 = 13
 EQUB 24                ; Number of edges          = 24
 EQUW 0                 ; Bounty                   = 0
 EQUB 52                ; Number of faces          = 52 / 4 = 13
 EQUB 40                ; Visibility distance      = 40
 EQUB 250               ; Max. energy              = 250
 EQUB 24                ; Max. speed               = 24

 EQUB HI(SHIP_BOA_EDGES - SHIP_BOA)                ; Edges data offset (high)
 EQUB HI(SHIP_BOA_FACES - SHIP_BOA)                ; Faces data offset (high)

 EQUB 0                 ; Normals are scaled by    = 2^0 = 1
 EQUB %00011100         ; Laser power              = 3
                        ; Missiles                 = 4

.SHIP_BOA_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    0,   93,    15,     15,   15,    15,         31    ; Vertex 0
 VERTEX    0,   40,  -87,     2,      0,    3,     3,         24    ; Vertex 1
 VERTEX   38,  -25,  -99,     1,      0,    4,     4,         24    ; Vertex 2
 VERTEX  -38,  -25,  -99,     2,      1,    5,     5,         24    ; Vertex 3
 VERTEX  -38,   40,  -59,     3,      2,    9,     6,         31    ; Vertex 4
 VERTEX   38,   40,  -59,     3,      0,   11,     6,         31    ; Vertex 5
 VERTEX   62,    0,  -67,     4,      0,   11,     8,         31    ; Vertex 6
 VERTEX   24,  -65,  -79,     4,      1,   10,     8,         31    ; Vertex 7
 VERTEX  -24,  -65,  -79,     5,      1,   10,     7,         31    ; Vertex 8
 VERTEX  -62,    0,  -67,     5,      2,    9,     7,         31    ; Vertex 9
 VERTEX    0,    7, -107,     2,      0,   10,    10,         22    ; Vertex 10
 VERTEX   13,   -9, -107,     1,      0,   10,    10,         22    ; Vertex 11
 VERTEX  -13,   -9, -107,     2,      1,   12,    12,         22    ; Vertex 12

.SHIP_BOA_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       5,    11,     6,         31    ; Edge 0
 EDGE       0,       7,    10,     8,         31    ; Edge 1
 EDGE       0,       9,     9,     7,         31    ; Edge 2
 EDGE       0,       4,     9,     6,         29    ; Edge 3
 EDGE       0,       6,    11,     8,         29    ; Edge 4
 EDGE       0,       8,    10,     7,         29    ; Edge 5
 EDGE       4,       5,     6,     3,         31    ; Edge 6
 EDGE       5,       6,    11,     0,         31    ; Edge 7
 EDGE       6,       7,     8,     4,         31    ; Edge 8
 EDGE       7,       8,    10,     1,         31    ; Edge 9
 EDGE       8,       9,     7,     5,         31    ; Edge 10
 EDGE       4,       9,     9,     2,         31    ; Edge 11
 EDGE       1,       4,     3,     2,         24    ; Edge 12
 EDGE       1,       5,     3,     0,         24    ; Edge 13
 EDGE       3,       9,     5,     2,         24    ; Edge 14
 EDGE       3,       8,     5,     1,         24    ; Edge 15
 EDGE       2,       6,     4,     0,         24    ; Edge 16
 EDGE       2,       7,     4,     1,         24    ; Edge 17
 EDGE       1,      10,     2,     0,         22    ; Edge 18
 EDGE       2,      11,     1,     0,         22    ; Edge 19
 EDGE       3,      12,     2,     1,         22    ; Edge 20
 EDGE      10,      11,    12,     0,         14    ; Edge 21
 EDGE      11,      12,    12,     1,         14    ; Edge 22
 EDGE      12,      10,    12,     2,         14    ; Edge 23

.SHIP_BOA_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE       43,       37,      -60,         31      ; Face 0
 FACE        0,      -45,      -89,         31      ; Face 1
 FACE      -43,       37,      -60,         31      ; Face 2
 FACE        0,       40,        0,         31      ; Face 3
 FACE       62,      -32,      -20,         31      ; Face 4
 FACE      -62,      -32,      -20,         31      ; Face 5
 FACE        0,       23,        6,         31      ; Face 6
 FACE      -23,      -15,        9,         31      ; Face 7
 FACE       23,      -15,        9,         31      ; Face 8
 FACE      -26,       13,       10,         31      ; Face 9
 FACE        0,      -31,       12,         31      ; Face 10
 FACE       26,       13,       10,         31      ; Face 11
 FACE        0,        0,     -107,         14      ; Face 12

; ******************************************************************************
;
;       Name: SHIP_ANACONDA
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for an Anaconda
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_ANACONDA

 EQUB 7                 ; Max. canisters on demise = 7
 EQUW 100 * 100         ; Targetable area          = 100 * 100

 EQUB LO(SHIP_ANACONDA_EDGES - SHIP_ANACONDA)      ; Edges data offset (low)
 EQUB LO(SHIP_ANACONDA_FACES - SHIP_ANACONDA)      ; Faces data offset (low)

 EQUB 93                ; Max. edge count          = (93 - 1) / 4 = 23
 EQUB 48                ; Gun vertex               = 48 / 4 = 12
 EQUB 46                ; Explosion count          = 10, as (4 * n) + 6 = 46
 EQUB 90                ; Number of vertices       = 90 / 6 = 15
 EQUB 25                ; Number of edges          = 25
 EQUW 0                 ; Bounty                   = 0
 EQUB 48                ; Number of faces          = 48 / 4 = 12
 EQUB 36                ; Visibility distance      = 36
 EQUB 252               ; Max. energy              = 252
 EQUB 14                ; Max. speed               = 14

 EQUB HI(SHIP_ANACONDA_EDGES - SHIP_ANACONDA)      ; Edges data offset (high)
 EQUB HI(SHIP_ANACONDA_FACES - SHIP_ANACONDA)      ; Faces data offset (high)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00111111         ; Laser power              = 7
                        ; Missiles                 = 7

.SHIP_ANACONDA_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    7,  -58,     1,      0,    5,     5,         30    ; Vertex 0
 VERTEX  -43,  -13,  -37,     1,      0,    2,     2,         30    ; Vertex 1
 VERTEX  -26,  -47,   -3,     2,      0,    3,     3,         30    ; Vertex 2
 VERTEX   26,  -47,   -3,     3,      0,    4,     4,         30    ; Vertex 3
 VERTEX   43,  -13,  -37,     4,      0,    5,     5,         30    ; Vertex 4
 VERTEX    0,   48,  -49,     5,      1,    6,     6,         30    ; Vertex 5
 VERTEX  -69,   15,  -15,     2,      1,    7,     7,         30    ; Vertex 6
 VERTEX  -43,  -39,   40,     3,      2,    8,     8,         31    ; Vertex 7
 VERTEX   43,  -39,   40,     4,      3,    9,     9,         31    ; Vertex 8
 VERTEX   69,   15,  -15,     5,      4,   10,    10,         30    ; Vertex 9
 VERTEX  -43,   53,  -23,    15,     15,   15,    15,         31    ; Vertex 10
 VERTEX  -69,   -1,   32,     7,      2,    8,     8,         31    ; Vertex 11
 VERTEX    0,    0,  254,    15,     15,   15,    15,         31    ; Vertex 12
 VERTEX   69,   -1,   32,     9,      4,   10,    10,         31    ; Vertex 13
 VERTEX   43,   53,  -23,    15,     15,   15,    15,         31    ; Vertex 14

.SHIP_ANACONDA_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     1,     0,         30    ; Edge 0
 EDGE       1,       2,     2,     0,         30    ; Edge 1
 EDGE       2,       3,     3,     0,         30    ; Edge 2
 EDGE       3,       4,     4,     0,         30    ; Edge 3
 EDGE       0,       4,     5,     0,         30    ; Edge 4
 EDGE       0,       5,     5,     1,         29    ; Edge 5
 EDGE       1,       6,     2,     1,         29    ; Edge 6
 EDGE       2,       7,     3,     2,         29    ; Edge 7
 EDGE       3,       8,     4,     3,         29    ; Edge 8
 EDGE       4,       9,     5,     4,         29    ; Edge 9
 EDGE       5,      10,     6,     1,         30    ; Edge 10
 EDGE       6,      10,     7,     1,         30    ; Edge 11
 EDGE       6,      11,     7,     2,         30    ; Edge 12
 EDGE       7,      11,     8,     2,         30    ; Edge 13
 EDGE       7,      12,     8,     3,         31    ; Edge 14
 EDGE       8,      12,     9,     3,         31    ; Edge 15
 EDGE       8,      13,     9,     4,         30    ; Edge 16
 EDGE       9,      13,    10,     4,         30    ; Edge 17
 EDGE       9,      14,    10,     5,         30    ; Edge 18
 EDGE       5,      14,     6,     5,         30    ; Edge 19
 EDGE      10,      14,    11,     6,         30    ; Edge 20
 EDGE      10,      12,    11,     7,         31    ; Edge 21
 EDGE      11,      12,     8,     7,         31    ; Edge 22
 EDGE      12,      13,    10,     9,         31    ; Edge 23
 EDGE      12,      14,    11,    10,         31    ; Edge 24

.SHIP_ANACONDA_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,      -51,      -49,         30      ; Face 0
 FACE      -51,       18,      -87,         30      ; Face 1
 FACE      -77,      -57,      -19,         30      ; Face 2
 FACE        0,      -90,       16,         31      ; Face 3
 FACE       77,      -57,      -19,         30      ; Face 4
 FACE       51,       18,      -87,         30      ; Face 5
 FACE        0,      111,      -20,         30      ; Face 6
 FACE      -97,       72,       24,         31      ; Face 7
 FACE     -108,      -68,       34,         31      ; Face 8
 FACE      108,      -68,       34,         31      ; Face 9
 FACE       97,       72,       24,         31      ; Face 10
 FACE        0,       94,       18,         31      ; Face 11

; ******************************************************************************
;
;       Name: SHIP_ROCK_HERMIT
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a rock hermit (asteroid)
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ------------------------------------------------------------------------------
;
; The ship blueprint for the rock hermit reuses the edges and faces data from
; the asteroid, so the edges and faces data offsets are negative.
;
; ******************************************************************************

.SHIP_ROCK_HERMIT

 EQUB 7                 ; Max. canisters on demise = 7
 EQUW 80 * 80           ; Targetable area          = 80 * 80

 EQUB LO(SHIP_ROCK_HERMIT_EDGES - SHIP_ROCK_HERMIT)   ; Edges data offset (low)
 EQUB LO(SHIP_ROCK_HERMIT_FACES - SHIP_ROCK_HERMIT)   ; Faces data offset (low)

 EQUB 69                ; Max. edge count          = (69 - 1) / 4 = 17
 EQUB 0                 ; Gun vertex               = 0
 EQUB 50                ; Explosion count          = 11, as (4 * n) + 6 = 50
 EQUB 54                ; Number of vertices       = 54 / 6 = 9
 EQUB 21                ; Number of edges          = 21
 EQUW 0                 ; Bounty                   = 0
 EQUB 56                ; Number of faces          = 56 / 4 = 14
 EQUB 50                ; Visibility distance      = 50
 EQUB 180               ; Max. energy              = 180
 EQUB 30                ; Max. speed               = 30

 EQUB HI(SHIP_ROCK_HERMIT_EDGES - SHIP_ROCK_HERMIT)   ; Edges data offset (high)
 EQUB HI(SHIP_ROCK_HERMIT_FACES - SHIP_ROCK_HERMIT)   ; Faces data offset (high)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00000010         ; Laser power              = 0
                        ; Missiles                 = 2

.SHIP_ROCK_HERMIT_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,   80,    0,    15,     15,   15,    15,         31    ; Vertex 0
 VERTEX  -80,  -10,    0,    15,     15,   15,    15,         31    ; Vertex 1
 VERTEX    0,  -80,    0,    15,     15,   15,    15,         31    ; Vertex 2
 VERTEX   70,  -40,    0,    15,     15,   15,    15,         31    ; Vertex 3
 VERTEX   60,   50,    0,     5,      6,   12,    13,         31    ; Vertex 4
 VERTEX   50,    0,   60,    15,     15,   15,    15,         31    ; Vertex 5
 VERTEX  -40,    0,   70,     0,      1,    2,     3,         31    ; Vertex 6
 VERTEX    0,   30,  -75,    15,     15,   15,    15,         31    ; Vertex 7
 VERTEX    0,  -50,  -60,     8,      9,   10,    11,         31    ; Vertex 8

.SHIP_ROCK_HERMIT_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     2,     7,         31    ; Edge 0
 EDGE       0,       4,     6,    13,         31    ; Edge 1
 EDGE       3,       4,     5,    12,         31    ; Edge 2
 EDGE       2,       3,     4,    11,         31    ; Edge 3
 EDGE       1,       2,     3,    10,         31    ; Edge 4
 EDGE       1,       6,     2,     3,         31    ; Edge 5
 EDGE       2,       6,     1,     3,         31    ; Edge 6
 EDGE       2,       5,     1,     4,         31    ; Edge 7
 EDGE       5,       6,     0,     1,         31    ; Edge 8
 EDGE       0,       5,     0,     6,         31    ; Edge 9
 EDGE       3,       5,     4,     5,         31    ; Edge 10
 EDGE       0,       6,     0,     2,         31    ; Edge 11
 EDGE       4,       5,     5,     6,         31    ; Edge 12
 EDGE       1,       8,     8,    10,         31    ; Edge 13
 EDGE       1,       7,     7,     8,         31    ; Edge 14
 EDGE       0,       7,     7,    13,         31    ; Edge 15
 EDGE       4,       7,    12,    13,         31    ; Edge 16
 EDGE       3,       7,     9,    12,         31    ; Edge 17
 EDGE       3,       8,     9,    11,         31    ; Edge 18
 EDGE       2,       8,    10,    11,         31    ; Edge 19
 EDGE       7,       8,     8,     9,         31    ; Edge 20

.SHIP_ROCK_HERMIT_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        9,       66,       81,         31      ; Face 0
 FACE        9,      -66,       81,         31      ; Face 1
 FACE      -72,       64,       31,         31      ; Face 2
 FACE      -64,      -73,       47,         31      ; Face 3
 FACE       45,      -79,       65,         31      ; Face 4
 FACE      135,       15,       35,         31      ; Face 5
 FACE       38,       76,       70,         31      ; Face 6
 FACE      -66,       59,      -39,         31      ; Face 7
 FACE      -67,      -15,      -80,         31      ; Face 8
 FACE       66,      -14,      -75,         31      ; Face 9
 FACE      -70,      -80,      -40,         31      ; Face 10
 FACE       58,     -102,      -51,         31      ; Face 11
 FACE       81,        9,      -67,         31      ; Face 12
 FACE       47,       94,      -63,         31      ; Face 13

; ******************************************************************************
;
;       Name: SHIP_VIPER
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Viper
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_VIPER

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 75 * 75           ; Targetable area          = 75 * 75

 EQUB LO(SHIP_VIPER_EDGES - SHIP_VIPER)            ; Edges data offset (low)
 EQUB LO(SHIP_VIPER_FACES - SHIP_VIPER)            ; Faces data offset (low)

 EQUB 81                ; Max. edge count          = (81 - 1) / 4 = 20
 EQUB 0                 ; Gun vertex               = 0
 EQUB 42                ; Explosion count          = 9, as (4 * n) + 6 = 42
 EQUB 90                ; Number of vertices       = 90 / 6 = 15
 EQUB 20                ; Number of edges          = 20
 EQUW 0                 ; Bounty                   = 0
 EQUB 28                ; Number of faces          = 28 / 4 = 7
 EQUB 23                ; Visibility distance      = 23
 EQUB 140               ; Max. energy              = 140
 EQUB 32                ; Max. speed               = 32

 EQUB HI(SHIP_VIPER_EDGES - SHIP_VIPER)            ; Edges data offset (high)
 EQUB HI(SHIP_VIPER_FACES - SHIP_VIPER)            ; Faces data offset (high)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00010001         ; Laser power              = 2
                        ; Missiles                 = 1

.SHIP_VIPER_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    0,   72,     1,      2,    3,     4,         31    ; Vertex 0
 VERTEX    0,   16,   24,     0,      1,    2,     2,         30    ; Vertex 1
 VERTEX    0,  -16,   24,     3,      4,    5,     5,         30    ; Vertex 2
 VERTEX   48,    0,  -24,     2,      4,    6,     6,         31    ; Vertex 3
 VERTEX  -48,    0,  -24,     1,      3,    6,     6,         31    ; Vertex 4
 VERTEX   24,  -16,  -24,     4,      5,    6,     6,         30    ; Vertex 5
 VERTEX  -24,  -16,  -24,     5,      3,    6,     6,         30    ; Vertex 6
 VERTEX   24,   16,  -24,     0,      2,    6,     6,         31    ; Vertex 7
 VERTEX  -24,   16,  -24,     0,      1,    6,     6,         31    ; Vertex 8
 VERTEX  -32,    0,  -24,     6,      6,    6,     6,         19    ; Vertex 9
 VERTEX   32,    0,  -24,     6,      6,    6,     6,         19    ; Vertex 10
 VERTEX    8,    8,  -24,     6,      6,    6,     6,         19    ; Vertex 11
 VERTEX   -8,    8,  -24,     6,      6,    6,     6,         19    ; Vertex 12
 VERTEX   -8,   -8,  -24,     6,      6,    6,     6,         18    ; Vertex 13
 VERTEX    8,   -8,  -24,     6,      6,    6,     6,         18    ; Vertex 14

.SHIP_VIPER_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       3,     2,     4,         31    ; Edge 0
 EDGE       0,       1,     1,     2,         30    ; Edge 1
 EDGE       0,       2,     3,     4,         30    ; Edge 2
 EDGE       0,       4,     1,     3,         31    ; Edge 3
 EDGE       1,       7,     0,     2,         30    ; Edge 4
 EDGE       1,       8,     0,     1,         30    ; Edge 5
 EDGE       2,       5,     4,     5,         30    ; Edge 6
 EDGE       2,       6,     3,     5,         30    ; Edge 7
 EDGE       7,       8,     0,     6,         31    ; Edge 8
 EDGE       5,       6,     5,     6,         30    ; Edge 9
 EDGE       4,       8,     1,     6,         31    ; Edge 10
 EDGE       4,       6,     3,     6,         30    ; Edge 11
 EDGE       3,       7,     2,     6,         31    ; Edge 12
 EDGE       3,       5,     6,     4,         30    ; Edge 13
 EDGE       9,      12,     6,     6,         19    ; Edge 14
 EDGE       9,      13,     6,     6,         18    ; Edge 15
 EDGE      10,      11,     6,     6,         19    ; Edge 16
 EDGE      10,      14,     6,     6,         18    ; Edge 17
 EDGE      11,      14,     6,     6,         16    ; Edge 18
 EDGE      12,      13,     6,     6,         16    ; Edge 19

.SHIP_VIPER_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       32,        0,         31      ; Face 0
 FACE      -22,       33,       11,         31      ; Face 1
 FACE       22,       33,       11,         31      ; Face 2
 FACE      -22,      -33,       11,         31      ; Face 3
 FACE       22,      -33,       11,         31      ; Face 4
 FACE        0,      -32,        0,         31      ; Face 5
 FACE        0,        0,      -48,         31      ; Face 6

; ******************************************************************************
;
;       Name: SHIP_SIDEWINDER
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Sidewinder
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_SIDEWINDER

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 65 * 65           ; Targetable area          = 65 * 65

 EQUB LO(SHIP_SIDEWINDER_EDGES - SHIP_SIDEWINDER)  ; Edges data offset (low)
 EQUB LO(SHIP_SIDEWINDER_FACES - SHIP_SIDEWINDER)  ; Faces data offset (low)

 EQUB 65                ; Max. edge count          = (65 - 1) / 4 = 16
 EQUB 0                 ; Gun vertex               = 0
 EQUB 30                ; Explosion count          = 6, as (4 * n) + 6 = 30
 EQUB 60                ; Number of vertices       = 60 / 6 = 10
 EQUB 15                ; Number of edges          = 15
 EQUW 50                ; Bounty                   = 50
 EQUB 28                ; Number of faces          = 28 / 4 = 7
 EQUB 20                ; Visibility distance      = 20
 EQUB 70                ; Max. energy              = 70
 EQUB 37                ; Max. speed               = 37

 EQUB HI(SHIP_SIDEWINDER_EDGES - SHIP_SIDEWINDER)  ; Edges data offset (high)
 EQUB HI(SHIP_SIDEWINDER_FACES - SHIP_SIDEWINDER)  ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00010000         ; Laser power              = 2
                        ; Missiles                 = 0

.SHIP_SIDEWINDER_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX  -32,    0,   36,     0,      1,    4,     5,         31    ; Vertex 0
 VERTEX   32,    0,   36,     0,      2,    5,     6,         31    ; Vertex 1
 VERTEX   64,    0,  -28,     2,      3,    6,     6,         31    ; Vertex 2
 VERTEX  -64,    0,  -28,     1,      3,    4,     4,         31    ; Vertex 3
 VERTEX    0,   16,  -28,     0,      1,    2,     3,         31    ; Vertex 4
 VERTEX    0,  -16,  -28,     3,      4,    5,     6,         31    ; Vertex 5
 VERTEX  -12,    6,  -28,     3,      3,    3,     3,         15    ; Vertex 6
 VERTEX   12,    6,  -28,     3,      3,    3,     3,         15    ; Vertex 7
 VERTEX   12,   -6,  -28,     3,      3,    3,     3,         12    ; Vertex 8
 VERTEX  -12,   -6,  -28,     3,      3,    3,     3,         12    ; Vertex 9

.SHIP_SIDEWINDER_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     0,     5,         31    ; Edge 0
 EDGE       1,       2,     2,     6,         31    ; Edge 1
 EDGE       1,       4,     0,     2,         31    ; Edge 2
 EDGE       0,       4,     0,     1,         31    ; Edge 3
 EDGE       0,       3,     1,     4,         31    ; Edge 4
 EDGE       3,       4,     1,     3,         31    ; Edge 5
 EDGE       2,       4,     2,     3,         31    ; Edge 6
 EDGE       3,       5,     3,     4,         31    ; Edge 7
 EDGE       2,       5,     3,     6,         31    ; Edge 8
 EDGE       1,       5,     5,     6,         31    ; Edge 9
 EDGE       0,       5,     4,     5,         31    ; Edge 10
 EDGE       6,       7,     3,     3,         15    ; Edge 11
 EDGE       7,       8,     3,     3,         12    ; Edge 12
 EDGE       6,       9,     3,     3,         12    ; Edge 13
 EDGE       8,       9,     3,     3,         12    ; Edge 14

.SHIP_SIDEWINDER_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       32,        8,         31      ; Face 0
 FACE      -12,       47,        6,         31      ; Face 1
 FACE       12,       47,        6,         31      ; Face 2
 FACE        0,        0,     -112,         31      ; Face 3
 FACE      -12,      -47,        6,         31      ; Face 4
 FACE        0,      -32,        8,         31      ; Face 5
 FACE       12,      -47,        6,         31      ; Face 6

; ******************************************************************************
;
;       Name: SHIP_MAMBA
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Mamba
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_MAMBA

 EQUB 1                 ; Max. canisters on demise = 1
 EQUW 70 * 70           ; Targetable area          = 70 * 70

 EQUB LO(SHIP_MAMBA_EDGES - SHIP_MAMBA)            ; Edges data offset (low)
 EQUB LO(SHIP_MAMBA_FACES - SHIP_MAMBA)            ; Faces data offset (low)

 EQUB 97                ; Max. edge count          = (97 - 1) / 4 = 24
 EQUB 0                 ; Gun vertex               = 0
 EQUB 34                ; Explosion count          = 7, as (4 * n) + 6 = 34
 EQUB 150               ; Number of vertices       = 150 / 6 = 25
 EQUB 28                ; Number of edges          = 28
 EQUW 150               ; Bounty                   = 150
 EQUB 20                ; Number of faces          = 20 / 4 = 5
 EQUB 25                ; Visibility distance      = 25
 EQUB 90                ; Max. energy              = 90
 EQUB 30                ; Max. speed               = 30

 EQUB HI(SHIP_MAMBA_EDGES - SHIP_MAMBA)            ; Edges data offset (high)
 EQUB HI(SHIP_MAMBA_FACES - SHIP_MAMBA)            ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00010010         ; Laser power              = 2
                        ; Missiles                 = 2

.SHIP_MAMBA_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    0,   64,     0,      1,    2,     3,         31    ; Vertex 0
 VERTEX  -64,   -8,  -32,     0,      2,    4,     4,         31    ; Vertex 1
 VERTEX  -32,    8,  -32,     1,      2,    4,     4,         30    ; Vertex 2
 VERTEX   32,    8,  -32,     1,      3,    4,     4,         30    ; Vertex 3
 VERTEX   64,   -8,  -32,     0,      3,    4,     4,         31    ; Vertex 4
 VERTEX   -4,    4,   16,     1,      1,    1,     1,         14    ; Vertex 5
 VERTEX    4,    4,   16,     1,      1,    1,     1,         14    ; Vertex 6
 VERTEX    8,    3,   28,     1,      1,    1,     1,         13    ; Vertex 7
 VERTEX   -8,    3,   28,     1,      1,    1,     1,         13    ; Vertex 8
 VERTEX  -20,   -4,   16,     0,      0,    0,     0,         20    ; Vertex 9
 VERTEX   20,   -4,   16,     0,      0,    0,     0,         20    ; Vertex 10
 VERTEX  -24,   -7,  -20,     0,      0,    0,     0,         20    ; Vertex 11
 VERTEX  -16,   -7,  -20,     0,      0,    0,     0,         16    ; Vertex 12
 VERTEX   16,   -7,  -20,     0,      0,    0,     0,         16    ; Vertex 13
 VERTEX   24,   -7,  -20,     0,      0,    0,     0,         20    ; Vertex 14
 VERTEX   -8,    4,  -32,     4,      4,    4,     4,         13    ; Vertex 15
 VERTEX    8,    4,  -32,     4,      4,    4,     4,         13    ; Vertex 16
 VERTEX    8,   -4,  -32,     4,      4,    4,     4,         14    ; Vertex 17
 VERTEX   -8,   -4,  -32,     4,      4,    4,     4,         14    ; Vertex 18
 VERTEX  -32,    4,  -32,     4,      4,    4,     4,          7    ; Vertex 19
 VERTEX   32,    4,  -32,     4,      4,    4,     4,          7    ; Vertex 20
 VERTEX   36,   -4,  -32,     4,      4,    4,     4,          7    ; Vertex 21
 VERTEX  -36,   -4,  -32,     4,      4,    4,     4,          7    ; Vertex 22
 VERTEX  -38,    0,  -32,     4,      4,    4,     4,          5    ; Vertex 23
 VERTEX   38,    0,  -32,     4,      4,    4,     4,          5    ; Vertex 24

.SHIP_MAMBA_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     0,     2,         31    ; Edge 0
 EDGE       0,       4,     0,     3,         31    ; Edge 1
 EDGE       1,       4,     0,     4,         31    ; Edge 2
 EDGE       1,       2,     2,     4,         30    ; Edge 3
 EDGE       2,       3,     1,     4,         30    ; Edge 4
 EDGE       3,       4,     3,     4,         30    ; Edge 5
 EDGE       5,       6,     1,     1,         14    ; Edge 6
 EDGE       6,       7,     1,     1,         12    ; Edge 7
 EDGE       7,       8,     1,     1,         13    ; Edge 8
 EDGE       5,       8,     1,     1,         12    ; Edge 9
 EDGE       9,      11,     0,     0,         20    ; Edge 10
 EDGE       9,      12,     0,     0,         16    ; Edge 11
 EDGE      10,      13,     0,     0,         16    ; Edge 12
 EDGE      10,      14,     0,     0,         20    ; Edge 13
 EDGE      13,      14,     0,     0,         14    ; Edge 14
 EDGE      11,      12,     0,     0,         14    ; Edge 15
 EDGE      15,      16,     4,     4,         13    ; Edge 16
 EDGE      17,      18,     4,     4,         14    ; Edge 17
 EDGE      15,      18,     4,     4,         12    ; Edge 18
 EDGE      16,      17,     4,     4,         12    ; Edge 19
 EDGE      20,      21,     4,     4,          7    ; Edge 20
 EDGE      20,      24,     4,     4,          5    ; Edge 21
 EDGE      21,      24,     4,     4,          5    ; Edge 22
 EDGE      19,      22,     4,     4,          7    ; Edge 23
 EDGE      19,      23,     4,     4,          5    ; Edge 24
 EDGE      22,      23,     4,     4,          5    ; Edge 25
 EDGE       0,       2,     1,     2,         30    ; Edge 26
 EDGE       0,       3,     1,     3,         30    ; Edge 27

.SHIP_MAMBA_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,      -24,        2,         30      ; Face 0
 FACE        0,       24,        2,         30      ; Face 1
 FACE      -32,       64,       16,         30      ; Face 2
 FACE       32,       64,       16,         30      ; Face 3
 FACE        0,        0,     -127,         30      ; Face 4

; ******************************************************************************
;
;       Name: SHIP_KRAIT
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Krait
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_KRAIT

 EQUB 1                 ; Max. canisters on demise = 1
 EQUW 60 * 60           ; Targetable area          = 60 * 60

 EQUB LO(SHIP_KRAIT_EDGES - SHIP_KRAIT)            ; Edges data offset (low)
 EQUB LO(SHIP_KRAIT_FACES - SHIP_KRAIT)            ; Faces data offset (low)

 EQUB 89                ; Max. edge count          = (89 - 1) / 4 = 22
 EQUB 0                 ; Gun vertex               = 0
 EQUB 18                ; Explosion count          = 3, as (4 * n) + 6 = 18
 EQUB 102               ; Number of vertices       = 102 / 6 = 17
 EQUB 21                ; Number of edges          = 21
 EQUW 100               ; Bounty                   = 100
 EQUB 24                ; Number of faces          = 24 / 4 = 6
 EQUB 20                ; Visibility distance      = 20
 EQUB 80                ; Max. energy              = 80
 EQUB 30                ; Max. speed               = 30

 EQUB HI(SHIP_KRAIT_EDGES - SHIP_KRAIT)            ; Edges data offset (high)
 EQUB HI(SHIP_KRAIT_FACES - SHIP_KRAIT)            ; Faces data offset (high)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00010000         ; Laser power              = 2
                        ; Missiles                 = 0

.SHIP_KRAIT_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    0,   96,     1,      0,    3,     2,         31    ; Vertex 0
 VERTEX    0,   18,  -48,     3,      0,    5,     4,         31    ; Vertex 1
 VERTEX    0,  -18,  -48,     2,      1,    5,     4,         31    ; Vertex 2
 VERTEX   90,    0,   -3,     1,      0,    4,     4,         31    ; Vertex 3
 VERTEX  -90,    0,   -3,     3,      2,    5,     5,         31    ; Vertex 4
 VERTEX   90,    0,   87,     1,      0,    1,     1,         30    ; Vertex 5
 VERTEX  -90,    0,   87,     3,      2,    3,     3,         30    ; Vertex 6
 VERTEX    0,    5,   53,     0,      0,    3,     3,          9    ; Vertex 7
 VERTEX    0,    7,   38,     0,      0,    3,     3,          6    ; Vertex 8
 VERTEX  -18,    7,   19,     3,      3,    3,     3,          9    ; Vertex 9
 VERTEX   18,    7,   19,     0,      0,    0,     0,          9    ; Vertex 10
 VERTEX   18,   11,  -39,     4,      4,    4,     4,          8    ; Vertex 11
 VERTEX   18,  -11,  -39,     4,      4,    4,     4,          8    ; Vertex 12
 VERTEX   36,    0,  -30,     4,      4,    4,     4,          8    ; Vertex 13
 VERTEX  -18,   11,  -39,     5,      5,    5,     5,          8    ; Vertex 14
 VERTEX  -18,  -11,  -39,     5,      5,    5,     5,          8    ; Vertex 15
 VERTEX  -36,    0,  -30,     5,      5,    5,     5,          8    ; Vertex 16

.SHIP_KRAIT_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     3,     0,         31    ; Edge 0
 EDGE       0,       2,     2,     1,         31    ; Edge 1
 EDGE       0,       3,     1,     0,         31    ; Edge 2
 EDGE       0,       4,     3,     2,         31    ; Edge 3
 EDGE       1,       4,     5,     3,         31    ; Edge 4
 EDGE       4,       2,     5,     2,         31    ; Edge 5
 EDGE       2,       3,     4,     1,         31    ; Edge 6
 EDGE       3,       1,     4,     0,         31    ; Edge 7
 EDGE       3,       5,     1,     0,         30    ; Edge 8
 EDGE       4,       6,     3,     2,         30    ; Edge 9
 EDGE       1,       2,     5,     4,          8    ; Edge 10
 EDGE       7,      10,     0,     0,          9    ; Edge 11
 EDGE       8,      10,     0,     0,          6    ; Edge 12
 EDGE       7,       9,     3,     3,          9    ; Edge 13
 EDGE       8,       9,     3,     3,          6    ; Edge 14
 EDGE      11,      13,     4,     4,          8    ; Edge 15
 EDGE      13,      12,     4,     4,          8    ; Edge 16
 EDGE      12,      11,     4,     4,          7    ; Edge 17
 EDGE      14,      15,     5,     5,          7    ; Edge 18
 EDGE      15,      16,     5,     5,          8    ; Edge 19
 EDGE      16,      14,     5,     5,          8    ; Edge 20

.SHIP_KRAIT_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        3,       24,        3,         31      ; Face 0
 FACE        3,      -24,        3,         31      ; Face 1
 FACE       -3,      -24,        3,         31      ; Face 2
 FACE       -3,       24,        3,         31      ; Face 3
 FACE       38,        0,      -77,         31      ; Face 4
 FACE      -38,        0,      -77,         31      ; Face 5

; ******************************************************************************
;
;       Name: SHIP_ADDER
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for an Adder
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_ADDER

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 50 * 50           ; Targetable area          = 50 * 50

 EQUB LO(SHIP_ADDER_EDGES - SHIP_ADDER)            ; Edges data offset (low)
 EQUB LO(SHIP_ADDER_FACES - SHIP_ADDER)            ; Faces data offset (low)

 EQUB 101               ; Max. edge count          = (101 - 1) / 4 = 25
 EQUB 0                 ; Gun vertex               = 0
 EQUB 22                ; Explosion count          = 4, as (4 * n) + 6 = 22
 EQUB 108               ; Number of vertices       = 108 / 6 = 18
 EQUB 29                ; Number of edges          = 29
 EQUW 40                ; Bounty                   = 40
 EQUB 60                ; Number of faces          = 60 / 4 = 15
 EQUB 20                ; Visibility distance      = 20
 EQUB 85                ; Max. energy              = 85
 EQUB 24                ; Max. speed               = 24

 EQUB HI(SHIP_ADDER_EDGES - SHIP_ADDER)            ; Edges data offset (high)
 EQUB HI(SHIP_ADDER_FACES - SHIP_ADDER)            ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00010000         ; Laser power              = 2
                        ; Missiles                 = 0

.SHIP_ADDER_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX  -18,    0,   40,     1,      0,   12,    11,         31    ; Vertex 0
 VERTEX   18,    0,   40,     1,      0,    3,     2,         31    ; Vertex 1
 VERTEX   30,    0,  -24,     3,      2,    5,     4,         31    ; Vertex 2
 VERTEX   30,    0,  -40,     5,      4,    6,     6,         31    ; Vertex 3
 VERTEX   18,   -7,  -40,     6,      5,   14,     7,         31    ; Vertex 4
 VERTEX  -18,   -7,  -40,     8,      7,   14,    10,         31    ; Vertex 5
 VERTEX  -30,    0,  -40,     9,      8,   10,    10,         31    ; Vertex 6
 VERTEX  -30,    0,  -24,    10,      9,   12,    11,         31    ; Vertex 7
 VERTEX  -18,    7,  -40,     8,      7,   13,     9,         31    ; Vertex 8
 VERTEX   18,    7,  -40,     6,      4,   13,     7,         31    ; Vertex 9
 VERTEX  -18,    7,   13,     9,      0,   13,    11,         31    ; Vertex 10
 VERTEX   18,    7,   13,     2,      0,   13,     4,         31    ; Vertex 11
 VERTEX  -18,   -7,   13,    10,      1,   14,    12,         31    ; Vertex 12
 VERTEX   18,   -7,   13,     3,      1,   14,     5,         31    ; Vertex 13
 VERTEX  -11,    3,   29,     0,      0,    0,     0,          5    ; Vertex 14
 VERTEX   11,    3,   29,     0,      0,    0,     0,          5    ; Vertex 15
 VERTEX   11,    4,   24,     0,      0,    0,     0,          4    ; Vertex 16
 VERTEX  -11,    4,   24,     0,      0,    0,     0,          4    ; Vertex 17

.SHIP_ADDER_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     1,     0,         31    ; Edge 0
 EDGE       1,       2,     3,     2,          7    ; Edge 1
 EDGE       2,       3,     5,     4,         31    ; Edge 2
 EDGE       3,       4,     6,     5,         31    ; Edge 3
 EDGE       4,       5,    14,     7,         31    ; Edge 4
 EDGE       5,       6,    10,     8,         31    ; Edge 5
 EDGE       6,       7,    10,     9,         31    ; Edge 6
 EDGE       7,       0,    12,    11,          7    ; Edge 7
 EDGE       3,       9,     6,     4,         31    ; Edge 8
 EDGE       9,       8,    13,     7,         31    ; Edge 9
 EDGE       8,       6,     9,     8,         31    ; Edge 10
 EDGE       0,      10,    11,     0,         31    ; Edge 11
 EDGE       7,      10,    11,     9,         31    ; Edge 12
 EDGE       1,      11,     2,     0,         31    ; Edge 13
 EDGE       2,      11,     4,     2,         31    ; Edge 14
 EDGE       0,      12,    12,     1,         31    ; Edge 15
 EDGE       7,      12,    12,    10,         31    ; Edge 16
 EDGE       1,      13,     3,     1,         31    ; Edge 17
 EDGE       2,      13,     5,     3,         31    ; Edge 18
 EDGE      10,      11,    13,     0,         31    ; Edge 19
 EDGE      12,      13,    14,     1,         31    ; Edge 20
 EDGE       8,      10,    13,     9,         31    ; Edge 21
 EDGE       9,      11,    13,     4,         31    ; Edge 22
 EDGE       5,      12,    14,    10,         31    ; Edge 23
 EDGE       4,      13,    14,     5,         31    ; Edge 24
 EDGE      14,      15,     0,     0,          5    ; Edge 25
 EDGE      15,      16,     0,     0,          3    ; Edge 26
 EDGE      16,      17,     0,     0,          4    ; Edge 27
 EDGE      17,      14,     0,     0,          3    ; Edge 28

.SHIP_ADDER_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       39,       10,         31      ; Face 0
 FACE        0,      -39,       10,         31      ; Face 1
 FACE       69,       50,       13,         31      ; Face 2
 FACE       69,      -50,       13,         31      ; Face 3
 FACE       30,       52,        0,         31      ; Face 4
 FACE       30,      -52,        0,         31      ; Face 5
 FACE        0,        0,     -160,         31      ; Face 6
 FACE        0,        0,     -160,         31      ; Face 7
 FACE        0,        0,     -160,         31      ; Face 8
 FACE      -30,       52,        0,         31      ; Face 9
 FACE      -30,      -52,        0,         31      ; Face 10
 FACE      -69,       50,       13,         31      ; Face 11
 FACE      -69,      -50,       13,         31      ; Face 12
 FACE        0,       28,        0,         31      ; Face 13
 FACE        0,      -28,        0,         31      ; Face 14

; ******************************************************************************
;
;       Name: SHIP_GECKO
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Gecko
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_GECKO

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 99 * 99           ; Targetable area          = 99 * 99

 EQUB LO(SHIP_GECKO_EDGES - SHIP_GECKO)            ; Edges data offset (low)
 EQUB LO(SHIP_GECKO_FACES - SHIP_GECKO)            ; Faces data offset (low)

 EQUB 69                ; Max. edge count          = (69 - 1) / 4 = 17
 EQUB 0                 ; Gun vertex               = 0
 EQUB 26                ; Explosion count          = 5, as (4 * n) + 6 = 26
 EQUB 72                ; Number of vertices       = 72 / 6 = 12
 EQUB 17                ; Number of edges          = 17
 EQUW 55                ; Bounty                   = 55
 EQUB 36                ; Number of faces          = 36 / 4 = 9
 EQUB 18                ; Visibility distance      = 18
 EQUB 70                ; Max. energy              = 70
 EQUB 30                ; Max. speed               = 30

 EQUB HI(SHIP_GECKO_EDGES - SHIP_GECKO)            ; Edges data offset (high)
 EQUB HI(SHIP_GECKO_FACES - SHIP_GECKO)            ; Faces data offset (high)

 EQUB 3                 ; Normals are scaled by    = 2^3 = 8
 EQUB %00010000         ; Laser power              = 2
                        ; Missiles                 = 0

.SHIP_GECKO_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX  -10,   -4,   47,     3,      0,    5,     4,         31    ; Vertex 0
 VERTEX   10,   -4,   47,     1,      0,    3,     2,         31    ; Vertex 1
 VERTEX  -16,    8,  -23,     5,      0,    7,     6,         31    ; Vertex 2
 VERTEX   16,    8,  -23,     1,      0,    8,     7,         31    ; Vertex 3
 VERTEX  -66,    0,   -3,     5,      4,    6,     6,         31    ; Vertex 4
 VERTEX   66,    0,   -3,     2,      1,    8,     8,         31    ; Vertex 5
 VERTEX  -20,  -14,  -23,     4,      3,    7,     6,         31    ; Vertex 6
 VERTEX   20,  -14,  -23,     3,      2,    8,     7,         31    ; Vertex 7
 VERTEX   -8,   -6,   33,     3,      3,    3,     3,         16    ; Vertex 8
 VERTEX    8,   -6,   33,     3,      3,    3,     3,         17    ; Vertex 9
 VERTEX   -8,  -13,  -16,     3,      3,    3,     3,         16    ; Vertex 10
 VERTEX    8,  -13,  -16,     3,      3,    3,     3,         17    ; Vertex 11

.SHIP_GECKO_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     3,     0,         31    ; Edge 0
 EDGE       1,       5,     2,     1,         31    ; Edge 1
 EDGE       5,       3,     8,     1,         31    ; Edge 2
 EDGE       3,       2,     7,     0,         31    ; Edge 3
 EDGE       2,       4,     6,     5,         31    ; Edge 4
 EDGE       4,       0,     5,     4,         31    ; Edge 5
 EDGE       5,       7,     8,     2,         31    ; Edge 6
 EDGE       7,       6,     7,     3,         31    ; Edge 7
 EDGE       6,       4,     6,     4,         31    ; Edge 8
 EDGE       0,       2,     5,     0,         29    ; Edge 9
 EDGE       1,       3,     1,     0,         30    ; Edge 10
 EDGE       0,       6,     4,     3,         29    ; Edge 11
 EDGE       1,       7,     3,     2,         30    ; Edge 12
 EDGE       2,       6,     7,     6,         20    ; Edge 13
 EDGE       3,       7,     8,     7,         20    ; Edge 14
 EDGE       8,      10,     3,     3,         16    ; Edge 15
 EDGE       9,      11,     3,     3,         17    ; Edge 16

.SHIP_GECKO_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       31,        5,         31      ; Face 0
 FACE        4,       45,        8,         31      ; Face 1
 FACE       25,     -108,       19,         31      ; Face 2
 FACE        0,      -84,       12,         31      ; Face 3
 FACE      -25,     -108,       19,         31      ; Face 4
 FACE       -4,       45,        8,         31      ; Face 5
 FACE      -88,       16,     -214,         31      ; Face 6
 FACE        0,        0,     -187,         31      ; Face 7
 FACE       88,       16,     -214,         31      ; Face 8

; ******************************************************************************
;
;       Name: SHIP_COBRA_MK_1
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Cobra Mk I
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_COBRA_MK_1

 EQUB 3                 ; Max. canisters on demise = 3
 EQUW 99 * 99           ; Targetable area          = 99 * 99

 EQUB LO(SHIP_COBRA_MK_1_EDGES - SHIP_COBRA_MK_1)  ; Edges data offset (low)
 EQUB LO(SHIP_COBRA_MK_1_FACES - SHIP_COBRA_MK_1)  ; Faces data offset (low)

 EQUB 73                ; Max. edge count          = (73 - 1) / 4 = 18
 EQUB 40                ; Gun vertex               = 40 / 4 = 10
 EQUB 26                ; Explosion count          = 5, as (4 * n) + 6 = 26
 EQUB 66                ; Number of vertices       = 66 / 6 = 11
 EQUB 18                ; Number of edges          = 18
 EQUW 75                ; Bounty                   = 75
 EQUB 40                ; Number of faces          = 40 / 4 = 10
 EQUB 19                ; Visibility distance      = 19
 EQUB 90                ; Max. energy              = 90
 EQUB 26                ; Max. speed               = 26

 EQUB HI(SHIP_COBRA_MK_1_EDGES - SHIP_COBRA_MK_1)  ; Edges data offset (high)
 EQUB HI(SHIP_COBRA_MK_1_FACES - SHIP_COBRA_MK_1)  ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00010010         ; Laser power              = 2
                        ; Missiles                 = 2

.SHIP_COBRA_MK_1_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX  -18,   -1,   50,     1,      0,    3,     2,         31    ; Vertex 0
 VERTEX   18,   -1,   50,     1,      0,    5,     4,         31    ; Vertex 1
 VERTEX  -66,    0,    7,     3,      2,    8,     8,         31    ; Vertex 2
 VERTEX   66,    0,    7,     5,      4,    9,     9,         31    ; Vertex 3
 VERTEX  -32,   12,  -38,     6,      2,    8,     7,         31    ; Vertex 4
 VERTEX   32,   12,  -38,     6,      4,    9,     7,         31    ; Vertex 5
 VERTEX  -54,  -12,  -38,     3,      1,    8,     7,         31    ; Vertex 6
 VERTEX   54,  -12,  -38,     5,      1,    9,     7,         31    ; Vertex 7
 VERTEX    0,   12,   -6,     2,      0,    6,     4,         20    ; Vertex 8
 VERTEX    0,   -1,   50,     1,      0,    1,     1,          2    ; Vertex 9
 VERTEX    0,   -1,   60,     1,      0,    1,     1,         31    ; Vertex 10

.SHIP_COBRA_MK_1_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       1,       0,     1,     0,         31    ; Edge 0
 EDGE       0,       2,     3,     2,         31    ; Edge 1
 EDGE       2,       6,     8,     3,         31    ; Edge 2
 EDGE       6,       7,     7,     1,         31    ; Edge 3
 EDGE       7,       3,     9,     5,         31    ; Edge 4
 EDGE       3,       1,     5,     4,         31    ; Edge 5
 EDGE       2,       4,     8,     2,         31    ; Edge 6
 EDGE       4,       5,     7,     6,         31    ; Edge 7
 EDGE       5,       3,     9,     4,         31    ; Edge 8
 EDGE       0,       8,     2,     0,         20    ; Edge 9
 EDGE       8,       1,     4,     0,         20    ; Edge 10
 EDGE       4,       8,     6,     2,         16    ; Edge 11
 EDGE       8,       5,     6,     4,         16    ; Edge 12
 EDGE       4,       6,     8,     7,         31    ; Edge 13
 EDGE       5,       7,     9,     7,         31    ; Edge 14
 EDGE       0,       6,     3,     1,         20    ; Edge 15
 EDGE       1,       7,     5,     1,         20    ; Edge 16
 EDGE      10,       9,     1,     0,          2    ; Edge 17

.SHIP_COBRA_MK_1_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       41,       10,         31      ; Face 0
 FACE        0,      -27,        3,         31      ; Face 1
 FACE       -8,       46,        8,         31      ; Face 2
 FACE      -12,      -57,       12,         31      ; Face 3
 FACE        8,       46,        8,         31      ; Face 4
 FACE       12,      -57,       12,         31      ; Face 5
 FACE        0,       49,        0,         31      ; Face 6
 FACE        0,        0,     -154,         31      ; Face 7
 FACE     -121,      111,      -62,         31      ; Face 8
 FACE      121,      111,      -62,         31      ; Face 9

; ******************************************************************************
;
;       Name: SHIP_WORM
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Worm
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_WORM

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 99 * 99           ; Targetable area          = 99 * 99

 EQUB LO(SHIP_WORM_EDGES - SHIP_WORM)              ; Edges data offset (low)
 EQUB LO(SHIP_WORM_FACES - SHIP_WORM)              ; Faces data offset (low)

 EQUB 77                ; Max. edge count          = (77 - 1) / 4 = 19
 EQUB 0                 ; Gun vertex               = 0
 EQUB 18                ; Explosion count          = 3, as (4 * n) + 6 = 18
 EQUB 60                ; Number of vertices       = 60 / 6 = 10
 EQUB 16                ; Number of edges          = 16
 EQUW 0                 ; Bounty                   = 0
 EQUB 32                ; Number of faces          = 32 / 4 = 8
 EQUB 19                ; Visibility distance      = 19
 EQUB 30                ; Max. energy              = 30
 EQUB 23                ; Max. speed               = 23

 EQUB HI(SHIP_WORM_EDGES - SHIP_WORM)              ; Edges data offset (high)
 EQUB HI(SHIP_WORM_FACES - SHIP_WORM)              ; Faces data offset (high)

 EQUB 3                 ; Normals are scaled by    = 2^3 = 8
 EQUB %00001000         ; Laser power              = 1
                        ; Missiles                 = 0

.SHIP_WORM_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   10,  -10,   35,     2,      0,    7,     7,         31    ; Vertex 0
 VERTEX  -10,  -10,   35,     3,      0,    7,     7,         31    ; Vertex 1
 VERTEX    5,    6,   15,     1,      0,    4,     2,         31    ; Vertex 2
 VERTEX   -5,    6,   15,     1,      0,    5,     3,         31    ; Vertex 3
 VERTEX   15,  -10,   25,     4,      2,    7,     7,         31    ; Vertex 4
 VERTEX  -15,  -10,   25,     5,      3,    7,     7,         31    ; Vertex 5
 VERTEX   26,  -10,  -25,     6,      4,    7,     7,         31    ; Vertex 6
 VERTEX  -26,  -10,  -25,     6,      5,    7,     7,         31    ; Vertex 7
 VERTEX    8,   14,  -25,     4,      1,    6,     6,         31    ; Vertex 8
 VERTEX   -8,   14,  -25,     5,      1,    6,     6,         31    ; Vertex 9

.SHIP_WORM_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     7,     0,         31    ; Edge 0
 EDGE       1,       5,     7,     3,         31    ; Edge 1
 EDGE       5,       7,     7,     5,         31    ; Edge 2
 EDGE       7,       6,     7,     6,         31    ; Edge 3
 EDGE       6,       4,     7,     4,         31    ; Edge 4
 EDGE       4,       0,     7,     2,         31    ; Edge 5
 EDGE       0,       2,     2,     0,         31    ; Edge 6
 EDGE       1,       3,     3,     0,         31    ; Edge 7
 EDGE       4,       2,     4,     2,         31    ; Edge 8
 EDGE       5,       3,     5,     3,         31    ; Edge 9
 EDGE       2,       8,     4,     1,         31    ; Edge 10
 EDGE       8,       6,     6,     4,         31    ; Edge 11
 EDGE       3,       9,     5,     1,         31    ; Edge 12
 EDGE       9,       7,     6,     5,         31    ; Edge 13
 EDGE       2,       3,     1,     0,         31    ; Edge 14
 EDGE       8,       9,     6,     1,         31    ; Edge 15

.SHIP_WORM_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       88,       70,         31      ; Face 0
 FACE        0,       69,       14,         31      ; Face 1
 FACE       70,       66,       35,         31      ; Face 2
 FACE      -70,       66,       35,         31      ; Face 3
 FACE       64,       49,       14,         31      ; Face 4
 FACE      -64,       49,       14,         31      ; Face 5
 FACE        0,        0,     -200,         31      ; Face 6
 FACE        0,      -80,        0,         31      ; Face 7

; ******************************************************************************
;
;       Name: SHIP_COBRA_MK_3_P
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Cobra Mk III (pirate)
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_COBRA_MK_3_P

 EQUB 1                 ; Max. canisters on demise = 1
 EQUW 95 * 95           ; Targetable area          = 95 * 95

 EQUB LO(SHIP_COBRA_MK_3_P_EDGES - SHIP_COBRA_MK_3_P) ; Edges data offset (low)
 EQUB LO(SHIP_COBRA_MK_3_P_FACES - SHIP_COBRA_MK_3_P) ; Faces data offset (low)

 EQUB 157               ; Max. edge count          = (157 - 1) / 4 = 39
 EQUB 84                ; Gun vertex               = 84 / 4 = 21
 EQUB 42                ; Explosion count          = 9, as (4 * n) + 6 = 42
 EQUB 168               ; Number of vertices       = 168 / 6 = 28
 EQUB 38                ; Number of edges          = 38
 EQUW 175               ; Bounty                   = 175
 EQUB 52                ; Number of faces          = 52 / 4 = 13
 EQUB 50                ; Visibility distance      = 50
 EQUB 150               ; Max. energy              = 150
 EQUB 28                ; Max. speed               = 28

 EQUB HI(SHIP_COBRA_MK_3_P_EDGES - SHIP_COBRA_MK_3_P) ; Edges data offset (high)
 EQUB HI(SHIP_COBRA_MK_3_P_FACES - SHIP_COBRA_MK_3_P) ; Faces data offset (high)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00010010         ; Laser power              = 2
                        ; Missiles                 = 2

.SHIP_COBRA_MK_3_P_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   32,    0,   76,    15,     15,   15,    15,         31    ; Vertex 0
 VERTEX  -32,    0,   76,    15,     15,   15,    15,         31    ; Vertex 1
 VERTEX    0,   26,   24,    15,     15,   15,    15,         31    ; Vertex 2
 VERTEX -120,   -3,   -8,     3,      7,   10,    10,         31    ; Vertex 3
 VERTEX  120,   -3,   -8,     4,      8,   12,    12,         31    ; Vertex 4
 VERTEX  -88,   16,  -40,    15,     15,   15,    15,         31    ; Vertex 5
 VERTEX   88,   16,  -40,    15,     15,   15,    15,         31    ; Vertex 6
 VERTEX  128,   -8,  -40,     8,      9,   12,    12,         31    ; Vertex 7
 VERTEX -128,   -8,  -40,     7,      9,   10,    10,         31    ; Vertex 8
 VERTEX    0,   26,  -40,     5,      6,    9,     9,         31    ; Vertex 9
 VERTEX  -32,  -24,  -40,     9,     10,   11,    11,         31    ; Vertex 10
 VERTEX   32,  -24,  -40,     9,     11,   12,    12,         31    ; Vertex 11
 VERTEX  -36,    8,  -40,     9,      9,    9,     9,         20    ; Vertex 12
 VERTEX   -8,   12,  -40,     9,      9,    9,     9,         20    ; Vertex 13
 VERTEX    8,   12,  -40,     9,      9,    9,     9,         20    ; Vertex 14
 VERTEX   36,    8,  -40,     9,      9,    9,     9,         20    ; Vertex 15
 VERTEX   36,  -12,  -40,     9,      9,    9,     9,         20    ; Vertex 16
 VERTEX    8,  -16,  -40,     9,      9,    9,     9,         20    ; Vertex 17
 VERTEX   -8,  -16,  -40,     9,      9,    9,     9,         20    ; Vertex 18
 VERTEX  -36,  -12,  -40,     9,      9,    9,     9,         20    ; Vertex 19
 VERTEX    0,    0,   76,     0,     11,   11,    11,          6    ; Vertex 20
 VERTEX    0,    0,   90,     0,     11,   11,    11,         31    ; Vertex 21
 VERTEX  -80,   -6,  -40,     9,      9,    9,     9,          8    ; Vertex 22
 VERTEX  -80,    6,  -40,     9,      9,    9,     9,          8    ; Vertex 23
 VERTEX  -88,    0,  -40,     9,      9,    9,     9,          6    ; Vertex 24
 VERTEX   80,    6,  -40,     9,      9,    9,     9,          8    ; Vertex 25
 VERTEX   88,    0,  -40,     9,      9,    9,     9,          6    ; Vertex 26
 VERTEX   80,   -6,  -40,     9,      9,    9,     9,          8    ; Vertex 27

.SHIP_COBRA_MK_3_P_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     0,    11,         31    ; Edge 0
 EDGE       0,       4,     4,    12,         31    ; Edge 1
 EDGE       1,       3,     3,    10,         31    ; Edge 2
 EDGE       3,       8,     7,    10,         31    ; Edge 3
 EDGE       4,       7,     8,    12,         31    ; Edge 4
 EDGE       6,       7,     8,     9,         31    ; Edge 5
 EDGE       6,       9,     6,     9,         31    ; Edge 6
 EDGE       5,       9,     5,     9,         31    ; Edge 7
 EDGE       5,       8,     7,     9,         31    ; Edge 8
 EDGE       2,       5,     1,     5,         31    ; Edge 9
 EDGE       2,       6,     2,     6,         31    ; Edge 10
 EDGE       3,       5,     3,     7,         31    ; Edge 11
 EDGE       4,       6,     4,     8,         31    ; Edge 12
 EDGE       1,       2,     0,     1,         31    ; Edge 13
 EDGE       0,       2,     0,     2,         31    ; Edge 14
 EDGE       8,      10,     9,    10,         31    ; Edge 15
 EDGE      10,      11,     9,    11,         31    ; Edge 16
 EDGE       7,      11,     9,    12,         31    ; Edge 17
 EDGE       1,      10,    10,    11,         31    ; Edge 18
 EDGE       0,      11,    11,    12,         31    ; Edge 19
 EDGE       1,       5,     1,     3,         29    ; Edge 20
 EDGE       0,       6,     2,     4,         29    ; Edge 21
 EDGE      20,      21,     0,    11,          6    ; Edge 22
 EDGE      12,      13,     9,     9,         20    ; Edge 23
 EDGE      18,      19,     9,     9,         20    ; Edge 24
 EDGE      14,      15,     9,     9,         20    ; Edge 25
 EDGE      16,      17,     9,     9,         20    ; Edge 26
 EDGE      15,      16,     9,     9,         19    ; Edge 27
 EDGE      14,      17,     9,     9,         17    ; Edge 28
 EDGE      13,      18,     9,     9,         19    ; Edge 29
 EDGE      12,      19,     9,     9,         19    ; Edge 30
 EDGE       2,       9,     5,     6,         30    ; Edge 31
 EDGE      22,      24,     9,     9,          6    ; Edge 32
 EDGE      23,      24,     9,     9,          6    ; Edge 33
 EDGE      22,      23,     9,     9,          8    ; Edge 34
 EDGE      25,      26,     9,     9,          6    ; Edge 35
 EDGE      26,      27,     9,     9,          6    ; Edge 36
 EDGE      25,      27,     9,     9,          8    ; Edge 37

.SHIP_COBRA_MK_3_P_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       62,       31,         31      ; Face 0
 FACE      -18,       55,       16,         31      ; Face 1
 FACE       18,       55,       16,         31      ; Face 2
 FACE      -16,       52,       14,         31      ; Face 3
 FACE       16,       52,       14,         31      ; Face 4
 FACE      -14,       47,        0,         31      ; Face 5
 FACE       14,       47,        0,         31      ; Face 6
 FACE      -61,      102,        0,         31      ; Face 7
 FACE       61,      102,        0,         31      ; Face 8
 FACE        0,        0,      -80,         31      ; Face 9
 FACE       -7,      -42,        9,         31      ; Face 10
 FACE        0,      -30,        6,         31      ; Face 11
 FACE        7,      -42,        9,         31      ; Face 12

; ******************************************************************************
;
;       Name: SHIP_ASP_MK_2
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for an Asp Mk II
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_ASP_MK_2

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 60 * 60           ; Targetable area          = 60 * 60

 EQUB LO(SHIP_ASP_MK_2_EDGES - SHIP_ASP_MK_2)      ; Edges data offset (low)
 EQUB LO(SHIP_ASP_MK_2_FACES - SHIP_ASP_MK_2)      ; Faces data offset (low)

 EQUB 105               ; Max. edge count          = (105 - 1) / 4 = 26
 EQUB 32                ; Gun vertex               = 32 / 4 = 8
 EQUB 26                ; Explosion count          = 5, as (4 * n) + 6 = 26
 EQUB 114               ; Number of vertices       = 114 / 6 = 19
 EQUB 28                ; Number of edges          = 28
 EQUW 200               ; Bounty                   = 200
 EQUB 48                ; Number of faces          = 48 / 4 = 12
 EQUB 40                ; Visibility distance      = 40
 EQUB 150               ; Max. energy              = 150
 EQUB 40                ; Max. speed               = 40

 EQUB HI(SHIP_ASP_MK_2_EDGES - SHIP_ASP_MK_2)      ; Edges data offset (high)
 EQUB HI(SHIP_ASP_MK_2_FACES - SHIP_ASP_MK_2)      ; Faces data offset (high)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00101001         ; Laser power              = 5
                        ; Missiles                 = 1

.SHIP_ASP_MK_2_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,  -18,    0,     1,      0,    2,     2,         22    ; Vertex 0
 VERTEX    0,   -9,  -45,     2,      1,   11,    11,         31    ; Vertex 1
 VERTEX   43,    0,  -45,     6,      1,   11,    11,         31    ; Vertex 2
 VERTEX   69,   -3,    0,     6,      1,    9,     7,         31    ; Vertex 3
 VERTEX   43,  -14,   28,     1,      0,    7,     7,         31    ; Vertex 4
 VERTEX  -43,    0,  -45,     5,      2,   11,    11,         31    ; Vertex 5
 VERTEX  -69,   -3,    0,     5,      2,   10,     8,         31    ; Vertex 6
 VERTEX  -43,  -14,   28,     2,      0,    8,     8,         31    ; Vertex 7
 VERTEX   26,   -7,   73,     4,      0,    9,     7,         31    ; Vertex 8
 VERTEX  -26,   -7,   73,     4,      0,   10,     8,         31    ; Vertex 9
 VERTEX   43,   14,   28,     4,      3,    9,     6,         31    ; Vertex 10
 VERTEX  -43,   14,   28,     4,      3,   10,     5,         31    ; Vertex 11
 VERTEX    0,    9,  -45,     5,      3,   11,     6,         31    ; Vertex 12
 VERTEX  -17,    0,  -45,    11,     11,   11,    11,         10    ; Vertex 13
 VERTEX   17,    0,  -45,    11,     11,   11,    11,          9    ; Vertex 14
 VERTEX    0,   -4,  -45,    11,     11,   11,    11,         10    ; Vertex 15
 VERTEX    0,    4,  -45,    11,     11,   11,    11,          8    ; Vertex 16
 VERTEX    0,   -7,   73,     4,      0,    4,     0,         10    ; Vertex 17
 VERTEX    0,   -7,   83,     4,      0,    4,     0,         10    ; Vertex 18

.SHIP_ASP_MK_2_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     2,     1,         22    ; Edge 0
 EDGE       0,       4,     1,     0,         22    ; Edge 1
 EDGE       0,       7,     2,     0,         22    ; Edge 2
 EDGE       1,       2,    11,     1,         31    ; Edge 3
 EDGE       2,       3,     6,     1,         31    ; Edge 4
 EDGE       3,       8,     9,     7,         16    ; Edge 5
 EDGE       8,       9,     4,     0,         31    ; Edge 6
 EDGE       6,       9,    10,     8,         16    ; Edge 7
 EDGE       5,       6,     5,     2,         31    ; Edge 8
 EDGE       1,       5,    11,     2,         31    ; Edge 9
 EDGE       3,       4,     7,     1,         31    ; Edge 10
 EDGE       4,       8,     7,     0,         31    ; Edge 11
 EDGE       6,       7,     8,     2,         31    ; Edge 12
 EDGE       7,       9,     8,     0,         31    ; Edge 13
 EDGE       2,      12,    11,     6,         31    ; Edge 14
 EDGE       5,      12,    11,     5,         31    ; Edge 15
 EDGE      10,      12,     6,     3,         22    ; Edge 16
 EDGE      11,      12,     5,     3,         22    ; Edge 17
 EDGE      10,      11,     4,     3,         22    ; Edge 18
 EDGE       6,      11,    10,     5,         31    ; Edge 19
 EDGE       9,      11,    10,     4,         31    ; Edge 20
 EDGE       3,      10,     9,     6,         31    ; Edge 21
 EDGE       8,      10,     9,     4,         31    ; Edge 22
 EDGE      13,      15,    11,    11,         10    ; Edge 23
 EDGE      15,      14,    11,    11,          9    ; Edge 24
 EDGE      14,      16,    11,    11,          8    ; Edge 25
 EDGE      16,      13,    11,    11,          8    ; Edge 26
 EDGE      18,      17,     4,     0,         10    ; Edge 27

.SHIP_ASP_MK_2_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,      -35,        5,         31      ; Face 0
 FACE        8,      -38,       -7,         31      ; Face 1
 FACE       -8,      -38,       -7,         31      ; Face 2
 FACE        0,       24,       -1,         22      ; Face 3
 FACE        0,       43,       19,         31      ; Face 4
 FACE       -6,       28,       -2,         31      ; Face 5
 FACE        6,       28,       -2,         31      ; Face 6
 FACE       59,      -64,       31,         31      ; Face 7
 FACE      -59,      -64,       31,         31      ; Face 8
 FACE       80,       46,       50,         31      ; Face 9
 FACE      -80,       46,       50,         31      ; Face 10
 FACE        0,        0,      -90,         31      ; Face 11

 EQUB $59, $3A          ; These bytes appear to be unused
 EQUB $43, $4D

; ******************************************************************************
;
;       Name: SHIP_PYTHON_P
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Python (pirate)
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_PYTHON_P

 EQUB 2                 ; Max. canisters on demise = 2
 EQUW 80 * 80           ; Targetable area          = 80 * 80

 EQUB LO(SHIP_PYTHON_P_EDGES - SHIP_PYTHON_P)      ; Edges data offset (low)
 EQUB LO(SHIP_PYTHON_P_FACES - SHIP_PYTHON_P)      ; Faces data offset (low)

 EQUB 89                ; Max. edge count          = (89 - 1) / 4 = 22
 EQUB 0                 ; Gun vertex               = 0
 EQUB 42                ; Explosion count          = 9, as (4 * n) + 6 = 42
 EQUB 66                ; Number of vertices       = 66 / 6 = 11
 EQUB 26                ; Number of edges          = 26
 EQUW 200               ; Bounty                   = 200
 EQUB 52                ; Number of faces          = 52 / 4 = 13
 EQUB 40                ; Visibility distance      = 40
 EQUB 250               ; Max. energy              = 250
 EQUB 20                ; Max. speed               = 20

 EQUB HI(SHIP_PYTHON_P_EDGES - SHIP_PYTHON_P)      ; Edges data offset (high)
 EQUB HI(SHIP_PYTHON_P_FACES - SHIP_PYTHON_P)      ; Faces data offset (high)

 EQUB 0                 ; Normals are scaled by    = 2^0 = 1
 EQUB %00011011         ; Laser power              = 3
                        ; Missiles                 = 3

.SHIP_PYTHON_P_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    0,  224,     0,      1,    2,     3,         31    ; Vertex 0
 VERTEX    0,   48,   48,     0,      1,    4,     5,         31    ; Vertex 1
 VERTEX   96,    0,  -16,    15,     15,   15,    15,         31    ; Vertex 2
 VERTEX  -96,    0,  -16,    15,     15,   15,    15,         31    ; Vertex 3
 VERTEX    0,   48,  -32,     4,      5,    8,     9,         31    ; Vertex 4
 VERTEX    0,   24, -112,     9,      8,   12,    12,         31    ; Vertex 5
 VERTEX  -48,    0, -112,     8,     11,   12,    12,         31    ; Vertex 6
 VERTEX   48,    0, -112,     9,     10,   12,    12,         31    ; Vertex 7
 VERTEX    0,  -48,   48,     2,      3,    6,     7,         31    ; Vertex 8
 VERTEX    0,  -48,  -32,     6,      7,   10,    11,         31    ; Vertex 9
 VERTEX    0,  -24, -112,    10,     11,   12,    12,         31    ; Vertex 10

.SHIP_PYTHON_P_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       8,     2,     3,         31    ; Edge 0
 EDGE       0,       3,     0,     2,         31    ; Edge 1
 EDGE       0,       2,     1,     3,         31    ; Edge 2
 EDGE       0,       1,     0,     1,         31    ; Edge 3
 EDGE       2,       4,     9,     5,         31    ; Edge 4
 EDGE       1,       2,     1,     5,         31    ; Edge 5
 EDGE       2,       8,     7,     3,         31    ; Edge 6
 EDGE       1,       3,     0,     4,         31    ; Edge 7
 EDGE       3,       8,     2,     6,         31    ; Edge 8
 EDGE       2,       9,     7,    10,         31    ; Edge 9
 EDGE       3,       4,     4,     8,         31    ; Edge 10
 EDGE       3,       9,     6,    11,         31    ; Edge 11
 EDGE       3,       5,     8,     8,          7    ; Edge 12
 EDGE       3,      10,    11,    11,          7    ; Edge 13
 EDGE       2,       5,     9,     9,          7    ; Edge 14
 EDGE       2,      10,    10,    10,          7    ; Edge 15
 EDGE       2,       7,     9,    10,         31    ; Edge 16
 EDGE       3,       6,     8,    11,         31    ; Edge 17
 EDGE       5,       6,     8,    12,         31    ; Edge 18
 EDGE       5,       7,     9,    12,         31    ; Edge 19
 EDGE       7,      10,    12,    10,         31    ; Edge 20
 EDGE       6,      10,    11,    12,         31    ; Edge 21
 EDGE       4,       5,     8,     9,         31    ; Edge 22
 EDGE       9,      10,    10,    11,         31    ; Edge 23
 EDGE       1,       4,     4,     5,         31    ; Edge 24
 EDGE       8,       9,     6,     7,         31    ; Edge 25

.SHIP_PYTHON_P_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE      -27,       40,       11,         31      ; Face 0
 FACE       27,       40,       11,         31      ; Face 1
 FACE      -27,      -40,       11,         31      ; Face 2
 FACE       27,      -40,       11,         31      ; Face 3
 FACE      -19,       38,        0,         31      ; Face 4
 FACE       19,       38,        0,         31      ; Face 5
 FACE      -19,      -38,        0,         31      ; Face 6
 FACE       19,      -38,        0,         31      ; Face 7
 FACE      -25,       37,      -11,         31      ; Face 8
 FACE       25,       37,      -11,         31      ; Face 9
 FACE       25,      -37,      -11,         31      ; Face 10
 FACE      -25,      -37,      -11,         31      ; Face 11
 FACE        0,        0,     -112,         31      ; Face 12

; ******************************************************************************
;
;       Name: SHIP_FER_DE_LANCE
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Fer-de-Lance
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_FER_DE_LANCE

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 40 * 40           ; Targetable area          = 40 * 40

 EQUB LO(SHIP_FER_DE_LANCE_EDGES - SHIP_FER_DE_LANCE) ; Edges data offset (low)
 EQUB LO(SHIP_FER_DE_LANCE_FACES - SHIP_FER_DE_LANCE) ; Faces data offset (low)

 EQUB 109               ; Max. edge count          = (109 - 1) / 4 = 27
 EQUB 0                 ; Gun vertex               = 0
 EQUB 26                ; Explosion count          = 5, as (4 * n) + 6 = 26
 EQUB 114               ; Number of vertices       = 114 / 6 = 19
 EQUB 27                ; Number of edges          = 27
 EQUW 0                 ; Bounty                   = 0
 EQUB 40                ; Number of faces          = 40 / 4 = 10
 EQUB 40                ; Visibility distance      = 40
 EQUB 160               ; Max. energy              = 160
 EQUB 30                ; Max. speed               = 30

 EQUB HI(SHIP_FER_DE_LANCE_EDGES - SHIP_FER_DE_LANCE) ; Edges data offset (high)
 EQUB HI(SHIP_FER_DE_LANCE_FACES - SHIP_FER_DE_LANCE) ; Faces data offset (high)

 EQUB 1                 ; Normals are scaled by    = 2^1 = 2
 EQUB %00010010         ; Laser power              = 2
                        ; Missiles                 = 2

.SHIP_FER_DE_LANCE_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,  -14,  108,     1,      0,    9,     5,         31    ; Vertex 0
 VERTEX  -40,  -14,   -4,     2,      1,    9,     9,         31    ; Vertex 1
 VERTEX  -12,  -14,  -52,     3,      2,    9,     9,         31    ; Vertex 2
 VERTEX   12,  -14,  -52,     4,      3,    9,     9,         31    ; Vertex 3
 VERTEX   40,  -14,   -4,     5,      4,    9,     9,         31    ; Vertex 4
 VERTEX  -40,   14,   -4,     1,      0,    6,     2,         28    ; Vertex 5
 VERTEX  -12,    2,  -52,     3,      2,    7,     6,         28    ; Vertex 6
 VERTEX   12,    2,  -52,     4,      3,    8,     7,         28    ; Vertex 7
 VERTEX   40,   14,   -4,     4,      0,    8,     5,         28    ; Vertex 8
 VERTEX    0,   18,  -20,     6,      0,    8,     7,         15    ; Vertex 9
 VERTEX   -3,  -11,   97,     0,      0,    0,     0,         11    ; Vertex 10
 VERTEX  -26,    8,   18,     0,      0,    0,     0,          9    ; Vertex 11
 VERTEX  -16,   14,   -4,     0,      0,    0,     0,         11    ; Vertex 12
 VERTEX    3,  -11,   97,     0,      0,    0,     0,         11    ; Vertex 13
 VERTEX   26,    8,   18,     0,      0,    0,     0,          9    ; Vertex 14
 VERTEX   16,   14,   -4,     0,      0,    0,     0,         11    ; Vertex 15
 VERTEX    0,  -14,  -20,     9,      9,    9,     9,         12    ; Vertex 16
 VERTEX  -14,  -14,   44,     9,      9,    9,     9,         12    ; Vertex 17
 VERTEX   14,  -14,   44,     9,      9,    9,     9,         12    ; Vertex 18

.SHIP_FER_DE_LANCE_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     9,     1,         31    ; Edge 0
 EDGE       1,       2,     9,     2,         31    ; Edge 1
 EDGE       2,       3,     9,     3,         31    ; Edge 2
 EDGE       3,       4,     9,     4,         31    ; Edge 3
 EDGE       0,       4,     9,     5,         31    ; Edge 4
 EDGE       0,       5,     1,     0,         28    ; Edge 5
 EDGE       5,       6,     6,     2,         28    ; Edge 6
 EDGE       6,       7,     7,     3,         28    ; Edge 7
 EDGE       7,       8,     8,     4,         28    ; Edge 8
 EDGE       0,       8,     5,     0,         28    ; Edge 9
 EDGE       5,       9,     6,     0,         15    ; Edge 10
 EDGE       6,       9,     7,     6,         11    ; Edge 11
 EDGE       7,       9,     8,     7,         11    ; Edge 12
 EDGE       8,       9,     8,     0,         15    ; Edge 13
 EDGE       1,       5,     2,     1,         14    ; Edge 14
 EDGE       2,       6,     3,     2,         14    ; Edge 15
 EDGE       3,       7,     4,     3,         14    ; Edge 16
 EDGE       4,       8,     5,     4,         14    ; Edge 17
 EDGE      10,      11,     0,     0,          8    ; Edge 18
 EDGE      11,      12,     0,     0,          9    ; Edge 19
 EDGE      10,      12,     0,     0,         11    ; Edge 20
 EDGE      13,      14,     0,     0,          8    ; Edge 21
 EDGE      14,      15,     0,     0,          9    ; Edge 22
 EDGE      13,      15,     0,     0,         11    ; Edge 23
 EDGE      16,      17,     9,     9,         12    ; Edge 24
 EDGE      16,      18,     9,     9,         12    ; Edge 25
 EDGE      17,      18,     9,     9,          8    ; Edge 26

.SHIP_FER_DE_LANCE_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       24,        6,         28      ; Face 0
 FACE      -68,        0,       24,         31      ; Face 1
 FACE      -63,        0,      -37,         31      ; Face 2
 FACE        0,        0,     -104,         31      ; Face 3
 FACE       63,        0,      -37,         31      ; Face 4
 FACE       68,        0,       24,         31      ; Face 5
 FACE      -12,       46,      -19,         28      ; Face 6
 FACE        0,       45,      -22,         28      ; Face 7
 FACE       12,       46,      -19,         28      ; Face 8
 FACE        0,      -28,        0,         31      ; Face 9

; ******************************************************************************
;
;       Name: SHIP_MORAY
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Moray
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_MORAY

 EQUB 1                 ; Max. canisters on demise = 1
 EQUW 30 * 30           ; Targetable area          = 30 * 30

 EQUB LO(SHIP_MORAY_EDGES - SHIP_MORAY)            ; Edges data offset (low)
 EQUB LO(SHIP_MORAY_FACES - SHIP_MORAY)            ; Faces data offset (low)

 EQUB 73                ; Max. edge count          = (73 - 1) / 4 = 18
 EQUB 0                 ; Gun vertex               = 0
 EQUB 26                ; Explosion count          = 5, as (4 * n) + 6 = 26
 EQUB 84                ; Number of vertices       = 84 / 6 = 14
 EQUB 19                ; Number of edges          = 19
 EQUW 50                ; Bounty                   = 50
 EQUB 36                ; Number of faces          = 36 / 4 = 9
 EQUB 40                ; Visibility distance      = 40
 EQUB 100               ; Max. energy              = 100
 EQUB 25                ; Max. speed               = 25

 EQUB HI(SHIP_MORAY_EDGES - SHIP_MORAY)            ; Edges data offset (high)
 EQUB HI(SHIP_MORAY_FACES - SHIP_MORAY)            ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00010000         ; Laser power              = 2
                        ; Missiles                 = 0

.SHIP_MORAY_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   15,    0,   65,     2,      0,    8,     7,         31    ; Vertex 0
 VERTEX  -15,    0,   65,     1,      0,    7,     6,         31    ; Vertex 1
 VERTEX    0,   18,  -40,    15,     15,   15,    15,         17    ; Vertex 2
 VERTEX  -60,    0,    0,     3,      1,    6,     6,         31    ; Vertex 3
 VERTEX   60,    0,    0,     5,      2,    8,     8,         31    ; Vertex 4
 VERTEX   30,  -27,  -10,     5,      4,    8,     7,         24    ; Vertex 5
 VERTEX  -30,  -27,  -10,     4,      3,    7,     6,         24    ; Vertex 6
 VERTEX   -9,   -4,  -25,     4,      4,    4,     4,          7    ; Vertex 7
 VERTEX    9,   -4,  -25,     4,      4,    4,     4,          7    ; Vertex 8
 VERTEX    0,  -18,  -16,     4,      4,    4,     4,          7    ; Vertex 9
 VERTEX   13,    3,   49,     0,      0,    0,     0,          5    ; Vertex 10
 VERTEX    6,    0,   65,     0,      0,    0,     0,          5    ; Vertex 11
 VERTEX  -13,    3,   49,     0,      0,    0,     0,          5    ; Vertex 12
 VERTEX   -6,    0,   65,     0,      0,    0,     0,          5    ; Vertex 13

.SHIP_MORAY_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     7,     0,         31    ; Edge 0
 EDGE       1,       3,     6,     1,         31    ; Edge 1
 EDGE       3,       6,     6,     3,         24    ; Edge 2
 EDGE       5,       6,     7,     4,         24    ; Edge 3
 EDGE       4,       5,     8,     5,         24    ; Edge 4
 EDGE       0,       4,     8,     2,         31    ; Edge 5
 EDGE       1,       6,     7,     6,         15    ; Edge 6
 EDGE       0,       5,     8,     7,         15    ; Edge 7
 EDGE       0,       2,     2,     0,         15    ; Edge 8
 EDGE       1,       2,     1,     0,         15    ; Edge 9
 EDGE       2,       3,     3,     1,         17    ; Edge 10
 EDGE       2,       4,     5,     2,         17    ; Edge 11
 EDGE       2,       5,     5,     4,         13    ; Edge 12
 EDGE       2,       6,     4,     3,         13    ; Edge 13
 EDGE       7,       8,     4,     4,          5    ; Edge 14
 EDGE       7,       9,     4,     4,          7    ; Edge 15
 EDGE       8,       9,     4,     4,          7    ; Edge 16
 EDGE      10,      11,     0,     0,          5    ; Edge 17
 EDGE      12,      13,     0,     0,          5    ; Edge 18

.SHIP_MORAY_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       43,        7,         31      ; Face 0
 FACE      -10,       49,        7,         31      ; Face 1
 FACE       10,       49,        7,         31      ; Face 2
 FACE      -59,      -28,     -101,         24      ; Face 3
 FACE        0,      -52,      -78,         24      ; Face 4
 FACE       59,      -28,     -101,         24      ; Face 5
 FACE      -72,      -99,       50,         31      ; Face 6
 FACE        0,      -83,       30,         31      ; Face 7
 FACE       72,      -99,       50,         31      ; Face 8

; ******************************************************************************
;
;       Name: SHIP_THARGOID
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Thargoid mothership
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_THARGOID

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 99 * 99           ; Targetable area          = 99 * 99

 EQUB LO(SHIP_THARGOID_EDGES - SHIP_THARGOID)      ; Edges data offset (low)
 EQUB LO(SHIP_THARGOID_FACES - SHIP_THARGOID)      ; Faces data offset (low)

 EQUB 105               ; Max. edge count          = (105 - 1) / 4 = 26
 EQUB 60                ; Gun vertex               = 60 / 4 = 15
 EQUB 38                ; Explosion count          = 8, as (4 * n) + 6 = 38
 EQUB 120               ; Number of vertices       = 120 / 6 = 20
 EQUB 26                ; Number of edges          = 26
 EQUW 500               ; Bounty                   = 500
 EQUB 40                ; Number of faces          = 40 / 4 = 10
 EQUB 55                ; Visibility distance      = 55
 EQUB 240               ; Max. energy              = 240
 EQUB 39                ; Max. speed               = 39

 EQUB HI(SHIP_THARGOID_EDGES - SHIP_THARGOID)      ; Edges data offset (high)
 EQUB HI(SHIP_THARGOID_FACES - SHIP_THARGOID)      ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00010110         ; Laser power              = 2
                        ; Missiles                 = 6

.SHIP_THARGOID_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   32,  -48,   48,     0,      4,    8,     8,         31    ; Vertex 0
 VERTEX   32,  -68,    0,     0,      1,    4,     4,         31    ; Vertex 1
 VERTEX   32,  -48,  -48,     1,      2,    4,     4,         31    ; Vertex 2
 VERTEX   32,    0,  -68,     2,      3,    4,     4,         31    ; Vertex 3
 VERTEX   32,   48,  -48,     3,      4,    5,     5,         31    ; Vertex 4
 VERTEX   32,   68,    0,     4,      5,    6,     6,         31    ; Vertex 5
 VERTEX   32,   48,   48,     4,      6,    7,     7,         31    ; Vertex 6
 VERTEX   32,    0,   68,     4,      7,    8,     8,         31    ; Vertex 7
 VERTEX  -24, -116,  116,     0,      8,    9,     9,         31    ; Vertex 8
 VERTEX  -24, -164,    0,     0,      1,    9,     9,         31    ; Vertex 9
 VERTEX  -24, -116, -116,     1,      2,    9,     9,         31    ; Vertex 10
 VERTEX  -24,    0, -164,     2,      3,    9,     9,         31    ; Vertex 11
 VERTEX  -24,  116, -116,     3,      5,    9,     9,         31    ; Vertex 12
 VERTEX  -24,  164,    0,     5,      6,    9,     9,         31    ; Vertex 13
 VERTEX  -24,  116,  116,     6,      7,    9,     9,         31    ; Vertex 14
 VERTEX  -24,    0,  164,     7,      8,    9,     9,         31    ; Vertex 15
 VERTEX  -24,   64,   80,     9,      9,    9,     9,         30    ; Vertex 16
 VERTEX  -24,   64,  -80,     9,      9,    9,     9,         30    ; Vertex 17
 VERTEX  -24,  -64,  -80,     9,      9,    9,     9,         30    ; Vertex 18
 VERTEX  -24,  -64,   80,     9,      9,    9,     9,         30    ; Vertex 19

.SHIP_THARGOID_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       7,     4,     8,         31    ; Edge 0
 EDGE       0,       1,     0,     4,         31    ; Edge 1
 EDGE       1,       2,     1,     4,         31    ; Edge 2
 EDGE       2,       3,     2,     4,         31    ; Edge 3
 EDGE       3,       4,     3,     4,         31    ; Edge 4
 EDGE       4,       5,     4,     5,         31    ; Edge 5
 EDGE       5,       6,     4,     6,         31    ; Edge 6
 EDGE       6,       7,     4,     7,         31    ; Edge 7
 EDGE       0,       8,     0,     8,         31    ; Edge 8
 EDGE       1,       9,     0,     1,         31    ; Edge 9
 EDGE       2,      10,     1,     2,         31    ; Edge 10
 EDGE       3,      11,     2,     3,         31    ; Edge 11
 EDGE       4,      12,     3,     5,         31    ; Edge 12
 EDGE       5,      13,     5,     6,         31    ; Edge 13
 EDGE       6,      14,     6,     7,         31    ; Edge 14
 EDGE       7,      15,     7,     8,         31    ; Edge 15
 EDGE       8,      15,     8,     9,         31    ; Edge 16
 EDGE       8,       9,     0,     9,         31    ; Edge 17
 EDGE       9,      10,     1,     9,         31    ; Edge 18
 EDGE      10,      11,     2,     9,         31    ; Edge 19
 EDGE      11,      12,     3,     9,         31    ; Edge 20
 EDGE      12,      13,     5,     9,         31    ; Edge 21
 EDGE      13,      14,     6,     9,         31    ; Edge 22
 EDGE      14,      15,     7,     9,         31    ; Edge 23
 EDGE      16,      17,     9,     9,         30    ; Edge 24
 EDGE      18,      19,     9,     9,         30    ; Edge 25

.SHIP_THARGOID_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE      103,      -60,       25,         31      ; Face 0
 FACE      103,      -60,      -25,         31      ; Face 1
 FACE      103,      -25,      -60,         31      ; Face 2
 FACE      103,       25,      -60,         31      ; Face 3
 FACE       64,        0,        0,         31      ; Face 4
 FACE      103,       60,      -25,         31      ; Face 5
 FACE      103,       60,       25,         31      ; Face 6
 FACE      103,       25,       60,         31      ; Face 7
 FACE      103,      -25,       60,         31      ; Face 8
 FACE      -48,        0,        0,         31      ; Face 9

; ******************************************************************************
;
;       Name: SHIP_THARGON
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Thargon
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ------------------------------------------------------------------------------
;
; The ship blueprint for the Thargon reuses the edges data from the cargo
; canister, so the edges data offset is negative.
;
; ******************************************************************************

.SHIP_THARGON

 EQUB 0 + (15 << 4)     ; Max. canisters on demise = 0
                        ; Market item when scooped = 15 + 1 = 16 (alien items)
 EQUW 40 * 40           ; Targetable area          = 40 * 40

 EQUB LO(SHIP_CANISTER_EDGES - SHIP_THARGON)       ; Edges from canister
 EQUB LO(SHIP_THARGON_FACES - SHIP_THARGON)        ; Faces data offset (low)

 EQUB 69                ; Max. edge count          = (69 - 1) / 4 = 17
 EQUB 0                 ; Gun vertex               = 0
 EQUB 18                ; Explosion count          = 3, as (4 * n) + 6 = 18
 EQUB 60                ; Number of vertices       = 60 / 6 = 10
 EQUB 15                ; Number of edges          = 15
 EQUW 50                ; Bounty                   = 50
 EQUB 28                ; Number of faces          = 28 / 4 = 7
 EQUB 20                ; Visibility distance      = 20
 EQUB 20                ; Max. energy              = 20
 EQUB 30                ; Max. speed               = 30

 EQUB HI(SHIP_CANISTER_EDGES - SHIP_THARGON)       ; Edges from canister
 EQUB HI(SHIP_THARGON_FACES - SHIP_THARGON)        ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00010000         ; Laser power              = 2
                        ; Missiles                 = 0

.SHIP_THARGON_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   -9,    0,   40,     1,      0,    5,     5,         31    ; Vertex 0
 VERTEX   -9,  -38,   12,     1,      0,    2,     2,         31    ; Vertex 1
 VERTEX   -9,  -24,  -32,     2,      0,    3,     3,         31    ; Vertex 2
 VERTEX   -9,   24,  -32,     3,      0,    4,     4,         31    ; Vertex 3
 VERTEX   -9,   38,   12,     4,      0,    5,     5,         31    ; Vertex 4
 VERTEX    9,    0,   -8,     5,      1,    6,     6,         31    ; Vertex 5
 VERTEX    9,  -10,  -15,     2,      1,    6,     6,         31    ; Vertex 6
 VERTEX    9,   -6,  -26,     3,      2,    6,     6,         31    ; Vertex 7
 VERTEX    9,    6,  -26,     4,      3,    6,     6,         31    ; Vertex 8
 VERTEX    9,   10,  -15,     5,      4,    6,     6,         31    ; Vertex 9

.SHIP_THARGON_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE      -36,        0,        0,         31      ; Face 0
 FACE       20,       -5,        7,         31      ; Face 1
 FACE       46,      -42,      -14,         31      ; Face 2
 FACE       36,        0,     -104,         31      ; Face 3
 FACE       46,       42,      -14,         31      ; Face 4
 FACE       20,        5,        7,         31      ; Face 5
 FACE       36,        0,        0,         31      ; Face 6

; ******************************************************************************
;
;       Name: SHIP_CONSTRICTOR
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Constrictor
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_CONSTRICTOR

 EQUB 3                 ; Max. canisters on demise = 3
 EQUW 65 * 65           ; Targetable area          = 65 * 65

 EQUB LO(SHIP_CONSTRICTOR_EDGES - SHIP_CONSTRICTOR)   ; Edges data offset (low)
 EQUB LO(SHIP_CONSTRICTOR_FACES - SHIP_CONSTRICTOR)   ; Faces data offset (low)

 EQUB 81                ; Max. edge count          = (81 - 1) / 4 = 20
 EQUB 0                 ; Gun vertex               = 0
 EQUB 46                ; Explosion count          = 10, as (4 * n) + 6 = 46
 EQUB 102               ; Number of vertices       = 102 / 6 = 17
 EQUB 24                ; Number of edges          = 24
 EQUW 0                 ; Bounty                   = 0
 EQUB 40                ; Number of faces          = 40 / 4 = 10
 EQUB 45                ; Visibility distance      = 45
 EQUB 252               ; Max. energy              = 252
 EQUB 36                ; Max. speed               = 36

 EQUB HI(SHIP_CONSTRICTOR_EDGES - SHIP_CONSTRICTOR)   ; Edges data offset (high)
 EQUB HI(SHIP_CONSTRICTOR_FACES - SHIP_CONSTRICTOR)   ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00110100         ; Laser power              = 6
                        ; Missiles                 = 4

.SHIP_CONSTRICTOR_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX   20,   -7,   80,     2,      0,    9,     9,         31    ; Vertex 0
 VERTEX  -20,   -7,   80,     1,      0,    9,     9,         31    ; Vertex 1
 VERTEX  -54,   -7,   40,     4,      1,    9,     9,         31    ; Vertex 2
 VERTEX  -54,   -7,  -40,     5,      4,    9,     8,         31    ; Vertex 3
 VERTEX  -20,   13,  -40,     6,      5,    8,     8,         31    ; Vertex 4
 VERTEX   20,   13,  -40,     7,      6,    8,     8,         31    ; Vertex 5
 VERTEX   54,   -7,  -40,     7,      3,    9,     8,         31    ; Vertex 6
 VERTEX   54,   -7,   40,     3,      2,    9,     9,         31    ; Vertex 7
 VERTEX   20,   13,    5,    15,     15,   15,    15,         31    ; Vertex 8
 VERTEX  -20,   13,    5,    15,     15,   15,    15,         31    ; Vertex 9
 VERTEX   20,   -7,   62,     9,      9,    9,     9,         18    ; Vertex 10
 VERTEX  -20,   -7,   62,     9,      9,    9,     9,         18    ; Vertex 11
 VERTEX   25,   -7,  -25,     9,      9,    9,     9,         18    ; Vertex 12
 VERTEX  -25,   -7,  -25,     9,      9,    9,     9,         18    ; Vertex 13
 VERTEX   15,   -7,  -15,     9,      9,    9,     9,         10    ; Vertex 14
 VERTEX  -15,   -7,  -15,     9,      9,    9,     9,         10    ; Vertex 15
 VERTEX    0,   -7,    0,    15,      9,    1,     0,          0    ; Vertex 16

.SHIP_CONSTRICTOR_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     9,     0,         31    ; Edge 0
 EDGE       1,       2,     9,     1,         31    ; Edge 1
 EDGE       1,       9,     1,     0,         31    ; Edge 2
 EDGE       0,       8,     2,     0,         31    ; Edge 3
 EDGE       0,       7,     9,     2,         31    ; Edge 4
 EDGE       7,       8,     3,     2,         31    ; Edge 5
 EDGE       2,       9,     4,     1,         31    ; Edge 6
 EDGE       2,       3,     9,     4,         31    ; Edge 7
 EDGE       6,       7,     9,     3,         31    ; Edge 8
 EDGE       6,       8,     7,     3,         31    ; Edge 9
 EDGE       5,       8,     7,     6,         31    ; Edge 10
 EDGE       4,       9,     6,     5,         31    ; Edge 11
 EDGE       3,       9,     5,     4,         31    ; Edge 12
 EDGE       3,       4,     8,     5,         31    ; Edge 13
 EDGE       4,       5,     8,     6,         31    ; Edge 14
 EDGE       5,       6,     8,     7,         31    ; Edge 15
 EDGE       3,       6,     9,     8,         31    ; Edge 16
 EDGE       8,       9,     6,     0,         31    ; Edge 17
 EDGE      10,      12,     9,     9,         18    ; Edge 18
 EDGE      12,      14,     9,     9,          5    ; Edge 19
 EDGE      14,      10,     9,     9,         10    ; Edge 20
 EDGE      11,      15,     9,     9,         10    ; Edge 21
 EDGE      13,      15,     9,     9,          5    ; Edge 22
 EDGE      11,      13,     9,     9,         18    ; Edge 23

.SHIP_CONSTRICTOR_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,       55,       15,         31      ; Face 0
 FACE      -24,       75,       20,         31      ; Face 1
 FACE       24,       75,       20,         31      ; Face 2
 FACE       44,       75,        0,         31      ; Face 3
 FACE      -44,       75,        0,         31      ; Face 4
 FACE      -44,       75,        0,         31      ; Face 5
 FACE        0,       53,        0,         31      ; Face 6
 FACE       44,       75,        0,         31      ; Face 7
 FACE        0,        0,     -160,         31      ; Face 8
 FACE        0,      -27,        0,         31      ; Face 9

; ******************************************************************************
;
;       Name: SHIP_COUGAR
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Cougar
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;             The elusive Cougar
;
; ******************************************************************************

.SHIP_COUGAR

 EQUB 3                 ; Max. canisters on demise = 3
 EQUW 70 * 70           ; Targetable area          = 70 * 70

 EQUB LO(SHIP_COUGAR_EDGES - SHIP_COUGAR)          ; Edges data offset (low)
 EQUB LO(SHIP_COUGAR_FACES - SHIP_COUGAR)          ; Faces data offset (low)

 EQUB 105               ; Max. edge count          = (105 - 1) / 4 = 26
 EQUB 0                 ; Gun vertex               = 0
 EQUB 42                ; Explosion count          = 9, as (4 * n) + 6 = 42
 EQUB 114               ; Number of vertices       = 114 / 6 = 19
 EQUB 25                ; Number of edges          = 25
 EQUW 0                 ; Bounty                   = 0
 EQUB 24                ; Number of faces          = 24 / 4 = 6
 EQUB 34                ; Visibility distance      = 34
 EQUB 252               ; Max. energy              = 252
 EQUB 40                ; Max. speed               = 40

 EQUB HI(SHIP_COUGAR_EDGES - SHIP_COUGAR)          ; Edges data offset (high)
 EQUB HI(SHIP_COUGAR_FACES - SHIP_COUGAR)          ; Faces data offset (high)

 EQUB 2                 ; Normals are scaled by    = 2^2 = 4
 EQUB %00110100         ; Laser power              = 6
                        ; Missiles                 = 4

.SHIP_COUGAR_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,    5,   67,     2,      0,    4,     4,         31    ; Vertex 0
 VERTEX  -20,    0,   40,     1,      0,    2,     2,         31    ; Vertex 1
 VERTEX  -40,    0,  -40,     1,      0,    5,     5,         31    ; Vertex 2
 VERTEX    0,   14,  -40,     4,      0,    5,     5,         30    ; Vertex 3
 VERTEX    0,  -14,  -40,     2,      1,    5,     3,         30    ; Vertex 4
 VERTEX   20,    0,   40,     3,      2,    4,     4,         31    ; Vertex 5
 VERTEX   40,    0,  -40,     4,      3,    5,     5,         31    ; Vertex 6
 VERTEX  -36,    0,   56,     1,      0,    1,     1,         31    ; Vertex 7
 VERTEX  -60,    0,  -20,     1,      0,    1,     1,         31    ; Vertex 8
 VERTEX   36,    0,   56,     4,      3,    4,     4,         31    ; Vertex 9
 VERTEX   60,    0,  -20,     4,      3,    4,     4,         31    ; Vertex 10
 VERTEX    0,    7,   35,     0,      0,    4,     4,         18    ; Vertex 11
 VERTEX    0,    8,   25,     0,      0,    4,     4,         20    ; Vertex 12
 VERTEX  -12,    2,   45,     0,      0,    0,     0,         20    ; Vertex 13
 VERTEX   12,    2,   45,     4,      4,    4,     4,         20    ; Vertex 14
 VERTEX  -10,    6,  -40,     5,      5,    5,     5,         20    ; Vertex 15
 VERTEX  -10,   -6,  -40,     5,      5,    5,     5,         20    ; Vertex 16
 VERTEX   10,   -6,  -40,     5,      5,    5,     5,         20    ; Vertex 17
 VERTEX   10,    6,  -40,     5,      5,    5,     5,         20    ; Vertex 18

.SHIP_COUGAR_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     2,     0,         31    ; Edge 0
 EDGE       1,       7,     1,     0,         31    ; Edge 1
 EDGE       7,       8,     1,     0,         31    ; Edge 2
 EDGE       8,       2,     1,     0,         31    ; Edge 3
 EDGE       2,       3,     5,     0,         30    ; Edge 4
 EDGE       3,       6,     5,     4,         30    ; Edge 5
 EDGE       2,       4,     5,     1,         30    ; Edge 6
 EDGE       4,       6,     5,     3,         30    ; Edge 7
 EDGE       6,      10,     4,     3,         31    ; Edge 8
 EDGE      10,       9,     4,     3,         31    ; Edge 9
 EDGE       9,       5,     4,     3,         31    ; Edge 10
 EDGE       5,       0,     4,     2,         31    ; Edge 11
 EDGE       0,       3,     4,     0,         27    ; Edge 12
 EDGE       1,       4,     2,     1,         27    ; Edge 13
 EDGE       5,       4,     3,     2,         27    ; Edge 14
 EDGE       1,       2,     1,     0,         26    ; Edge 15
 EDGE       5,       6,     4,     3,         26    ; Edge 16
 EDGE      12,      13,     0,     0,         20    ; Edge 17
 EDGE      13,      11,     0,     0,         18    ; Edge 18
 EDGE      11,      14,     4,     4,         18    ; Edge 19
 EDGE      14,      12,     4,     4,         20    ; Edge 20
 EDGE      15,      16,     5,     5,         18    ; Edge 21
 EDGE      16,      18,     5,     5,         20    ; Edge 22
 EDGE      18,      17,     5,     5,         18    ; Edge 23
 EDGE      17,      15,     5,     5,         20    ; Edge 24

.SHIP_COUGAR_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE      -16,       46,        4,         31      ; Face 0
 FACE      -16,      -46,        4,         31      ; Face 1
 FACE        0,      -27,        5,         31      ; Face 2
 FACE       16,      -46,        4,         31      ; Face 3
 FACE       16,       46,        4,         31      ; Face 4
 FACE        0,        0,     -160,         30      ; Face 5

; ******************************************************************************
;
;       Name: SHIP_DODO
;       Type: Variable
;   Category: Drawing ships
;    Summary: Ship blueprint for a Dodecahedron ("Dodo") space station
;  Deep dive: Ship blueprints
;             Comparing ship specifications
;
; ******************************************************************************

.SHIP_DODO

 EQUB 0                 ; Max. canisters on demise = 0
 EQUW 180 * 180         ; Targetable area          = 180 * 180

 EQUB LO(SHIP_DODO_EDGES - SHIP_DODO)              ; Edges data offset (low)
 EQUB LO(SHIP_DODO_FACES - SHIP_DODO)              ; Faces data offset (low)

 EQUB 101               ; Max. edge count          = (101 - 1) / 4 = 25
 EQUB 0                 ; Gun vertex               = 0
 EQUB 54                ; Explosion count          = 12, as (4 * n) + 6 = 54
 EQUB 144               ; Number of vertices       = 144 / 6 = 24
 EQUB 34                ; Number of edges          = 34
 EQUW 0                 ; Bounty                   = 0
 EQUB 48                ; Number of faces          = 48 / 4 = 12
 EQUB 125               ; Visibility distance      = 125
 EQUB 240               ; Max. energy              = 240
 EQUB 0                 ; Max. speed               = 0

 EQUB HI(SHIP_DODO_EDGES - SHIP_DODO)              ; Edges data offset (high)
 EQUB HI(SHIP_DODO_FACES - SHIP_DODO)              ; Faces data offset (high)

 EQUB 0                 ; Normals are scaled by    = 2^0 = 1
 EQUB %00000000         ; Laser power              = 0
                        ; Missiles                 = 0

.SHIP_DODO_VERTICES

      ;    x,    y,    z, face1, face2, face3, face4, visibility
 VERTEX    0,  150,  196,     1,      0,    5,     5,         31    ; Vertex 0
 VERTEX  143,   46,  196,     1,      0,    2,     2,         31    ; Vertex 1
 VERTEX   88, -121,  196,     2,      0,    3,     3,         31    ; Vertex 2
 VERTEX  -88, -121,  196,     3,      0,    4,     4,         31    ; Vertex 3
 VERTEX -143,   46,  196,     4,      0,    5,     5,         31    ; Vertex 4
 VERTEX    0,  243,   46,     5,      1,    6,     6,         31    ; Vertex 5
 VERTEX  231,   75,   46,     2,      1,    7,     7,         31    ; Vertex 6
 VERTEX  143, -196,   46,     3,      2,    8,     8,         31    ; Vertex 7
 VERTEX -143, -196,   46,     4,      3,    9,     9,         31    ; Vertex 8
 VERTEX -231,   75,   46,     5,      4,   10,    10,         31    ; Vertex 9
 VERTEX  143,  196,  -46,     6,      1,    7,     7,         31    ; Vertex 10
 VERTEX  231,  -75,  -46,     7,      2,    8,     8,         31    ; Vertex 11
 VERTEX    0, -243,  -46,     8,      3,    9,     9,         31    ; Vertex 12
 VERTEX -231,  -75,  -46,     9,      4,   10,    10,         31    ; Vertex 13
 VERTEX -143,  196,  -46,     6,      5,   10,    10,         31    ; Vertex 14
 VERTEX   88,  121, -196,     7,      6,   11,    11,         31    ; Vertex 15
 VERTEX  143,  -46, -196,     8,      7,   11,    11,         31    ; Vertex 16
 VERTEX    0, -150, -196,     9,      8,   11,    11,         31    ; Vertex 17
 VERTEX -143,  -46, -196,    10,      9,   11,    11,         31    ; Vertex 18
 VERTEX  -88,  121, -196,    10,      6,   11,    11,         31    ; Vertex 19
 VERTEX  -16,   32,  196,     0,      0,    0,     0,         30    ; Vertex 20
 VERTEX  -16,  -32,  196,     0,      0,    0,     0,         30    ; Vertex 21
 VERTEX   16,   32,  196,     0,      0,    0,     0,         23    ; Vertex 22
 VERTEX   16,  -32,  196,     0,      0,    0,     0,         23    ; Vertex 23

.SHIP_DODO_EDGES

    ; vertex1, vertex2, face1, face2, visibility
 EDGE       0,       1,     1,     0,         31    ; Edge 0
 EDGE       1,       2,     2,     0,         31    ; Edge 1
 EDGE       2,       3,     3,     0,         31    ; Edge 2
 EDGE       3,       4,     4,     0,         31    ; Edge 3
 EDGE       4,       0,     5,     0,         31    ; Edge 4
 EDGE       5,      10,     6,     1,         31    ; Edge 5
 EDGE      10,       6,     7,     1,         31    ; Edge 6
 EDGE       6,      11,     7,     2,         31    ; Edge 7
 EDGE      11,       7,     8,     2,         31    ; Edge 8
 EDGE       7,      12,     8,     3,         31    ; Edge 9
 EDGE      12,       8,     9,     3,         31    ; Edge 10
 EDGE       8,      13,     9,     4,         31    ; Edge 11
 EDGE      13,       9,    10,     4,         31    ; Edge 12
 EDGE       9,      14,    10,     5,         31    ; Edge 13
 EDGE      14,       5,     6,     5,         31    ; Edge 14
 EDGE      15,      16,    11,     7,         31    ; Edge 15
 EDGE      16,      17,    11,     8,         31    ; Edge 16
 EDGE      17,      18,    11,     9,         31    ; Edge 17
 EDGE      18,      19,    11,    10,         31    ; Edge 18
 EDGE      19,      15,    11,     6,         31    ; Edge 19
 EDGE       0,       5,     5,     1,         31    ; Edge 20
 EDGE       1,       6,     2,     1,         31    ; Edge 21
 EDGE       2,       7,     3,     2,         31    ; Edge 22
 EDGE       3,       8,     4,     3,         31    ; Edge 23
 EDGE       4,       9,     5,     4,         31    ; Edge 24
 EDGE      10,      15,     7,     6,         31    ; Edge 25
 EDGE      11,      16,     8,     7,         31    ; Edge 26
 EDGE      12,      17,     9,     8,         31    ; Edge 27
 EDGE      13,      18,    10,     9,         31    ; Edge 28
 EDGE      14,      19,    10,     6,         31    ; Edge 29
 EDGE      20,      21,     0,     0,         30    ; Edge 30
 EDGE      21,      23,     0,     0,         20    ; Edge 31
 EDGE      23,      22,     0,     0,         23    ; Edge 32
 EDGE      22,      20,     0,     0,         20    ; Edge 33

.SHIP_DODO_FACES

    ; normal_x, normal_y, normal_z, visibility
 FACE        0,        0,      196,         31      ; Face 0
 FACE      103,      142,       88,         31      ; Face 1
 FACE      169,      -55,       89,         31      ; Face 2
 FACE        0,     -176,       88,         31      ; Face 3
 FACE     -169,      -55,       89,         31      ; Face 4
 FACE     -103,      142,       88,         31      ; Face 5
 FACE        0,      176,      -88,         31      ; Face 6
 FACE      169,       55,      -89,         31      ; Face 7
 FACE      103,     -142,      -88,         31      ; Face 8
 FACE     -103,     -142,      -88,         31      ; Face 9
 FACE     -169,       55,      -89,         31      ; Face 10
 FACE        0,        0,     -196,         31      ; Face 11

 EQUB $4C, $44          ; These bytes appear to be unused
 EQUB $41, $52

; ******************************************************************************
;
; Save SHIPS.bin
;
; ******************************************************************************

 PRINT "SHIPS"
 PRINT "Assembled at ", ~CODE_SHIPS%
 PRINT "Ends at ", ~P%
 PRINT "Code size is ", ~(P% - CODE_SHIPS%)
 PRINT "Execute at ", ~LOAD%
 PRINT "Reload at ", ~LOAD_SHIPS%

 PRINT "S.SHIPS ", ~CODE_SHIPS%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD_SHIPS%
 SAVE "3-assembled-output/SHIPS.bin", CODE_SHIPS%, P%, LOAD%
