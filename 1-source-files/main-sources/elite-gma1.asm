; ******************************************************************************
;
; COMMODORE 64 ELITE GMA1 DISK LOADER SOURCE (PART 2 of 2)
;
; Commodore 64 Elite was written by Ian Bell and David Braben and is copyright
; D. Braben and I. Bell 1985
;
; The GMA85 and GMA86 loaders were written by Graeme Ashton
;
; The code in this file has been reconstructed from a disassembly of the version
; released on Ian Bell's personal website at http://www.elitehomepage.org/
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
; This source file contains the second of two disk loaders for Commodore 64
; Elite. It loads the disk protection code in GMA3 (which gets disabled in this
; version). Then it runs the game loader to load the game data, before loading
; the two game binaries and starting the game.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
;   * gma1.bin
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

 CODE% = $0334          ; The address where the code will be run

 LOAD% = $0334          ; The address where the code will be loaded

IF _GMA_RELEASE

 ENTRY = $7596          ; The entry point in the COMLOD file (GMA4)

 S% = $1D22             ; The entry point in the LOCODE file (GMA5)

ELIF _SOURCE_DISK

 ENTRY = $7607          ; The entry point in the COMLOD file (GMA4)

 S% = $1D1F             ; The entry point in the LOCODE file (GMA5)

ENDIF

 L1 = $0001             ; The 6510 input/output port register, which we can use
                        ; to configure the Commodore 64 memory layout (see page
                        ; 260 of the Programmer's Reference Guide)

 VIC = $D000            ; Registers for the VIC-II video controller chip, which
                        ; are memory-mapped to the 46 bytes from $D000 to $D02E
                        ; (see page 454 of the Programmer's Reference Guide)

 KERNALSCINIT = $FF81   ; The Kernal function to initialise the VIC-II

 KERNALRESTOR = $FF8A   ; The Kernal function to restore the vector table at
                        ; $0314 to $0333 with the default values

 KERNALSETLFS = $FFBA   ; The Kernal function to set the logical, first, and
                        ; second addresses for file access

 KERNALSETNAM = $FFBD   ; The Kernal function to set a filename

 KERNALSETMSG = $FF90   ; The Kernal function to control Kernal messages

 KERNALCHROUT = $FFD2   ; The Kernal function to print characters

 KERNALGETIN = $FFE4    ; The Kernal function to read a byte from the default
                        ; input

 KERNALCLALL = $FFE7    ; The Kernal function to clear the file table

 KERNALLOAD = $FFD5     ; The Kernal function to load a file from a device

; ******************************************************************************
;
; ELITE GMA1 LOADER
;
; ******************************************************************************

 ORG CODE% - 2          ; Add a two-byte PRG header to the start of the file
 EQUW LOAD%             ; that contains the load address

; ******************************************************************************
;
;       Name: Elite GMA loader (Part 1 of 4)
;       Type: Subroutine
;   Category: Loader
;    Summary: Skip past the table of track and sector numbers if present
;
; ******************************************************************************

IF _GMA86_PAL

 JMP load1              ; Jump to part 2 of the loader, skipping the table of
                        ; track and sector numbers

ENDIF

; ******************************************************************************
;
;       Name: trackSector
;       Type: Variable
;   Category: Loader
;    Summary: Track and sector numbers for all the files on the disk, for use in
;             the fast loader
;
; ******************************************************************************

IF _GMA86_PAL

.trackSector

 EQUB $00, $00          ; Track and sector for the "FIREBIRD" file

 EQUB $00, $00          ; Track and sector for the "GMA1" file

 EQUB $11, $04          ; Track and sector for the "GMA2" file

 EQUB $11, $05          ; Track and sector for the "GMA3" file

 EQUB $11, $06          ; Track and sector for the "GMA4" file

 EQUB $13, $00          ; Track and sector for the "GMA5" file

                        ; --- Mod: Code removed for improved disk menu: ------->

\EQUB $14, $08          ; Track and sector for the "GMA6" file

                        ; --- And replaced by: -------------------------------->

 EQUB $14, $09          ; Track and sector for the "GMA6" file

                        ; --- End of replacement ------------------------------>


ENDIF

; ******************************************************************************
;
;       Name: Elite GMA loader (Part 2 of 4)
;       Type: Subroutine
;   Category: Loader
;    Summary: Offer the option of a fast loader and run the disk protection code
;             in the GMA3 file
;
; ******************************************************************************

.load1

 LDA #%00000000         ; Call the Kernal's SETMSG function to set the system
 JSR KERNALSETMSG       ; error display switch as follows:
                        ;
                        ;   * Bit 6 clear = do not display I/O error messages
                        ;
                        ;   * Bit 7 clear = do not display system messages
                        ;
                        ; This ensures that any file system errors are hidden

 LDA #$FF               ; Set the high byte of the execution address of STOP to
 STA $0329              ; $FF, from the default $F6ED to $FFED
                        ;
                        ; The address $FFED in the Kernal ROM simply returns
                        ; without doing anything, so this effectively disables
                        ; the RUN/STOP key

 JSR OfferFastLoader    ; Ask whether we want to use the fast loader, and if we
                        ; do, configure it to intercept the Kernal functions for
                        ; loading files

IF _GMA86_PAL

 LDA #3                 ; Call LoadGMAFile to load the GMA3 file, which contains
 JSR LoadGMAFile        ; the disk copy protection

ELIF _GMA85_NTSC

 LDA #'3'               ; Call LoadGMAFile to load the GMA3 file, which contains
 JSR LoadGMAFile        ; the disk copy protection

ENDIF

 JSR $C800              ; Call the disk copy protection code in GMA3 (this call
                        ; gets disabled by elite-checksum.py)

IF _GMA86_PAL

 LDA $02                ; If the result of the disk copy protection in address
 EOR #$97               ; $0002 is $97, then jump to load2 to skip the following
 BEQ load2              ; (this check gets disabled by elite-checksum.py)

 JMP ($FFFC)            ; Otherwise we have failed the disk protection checks,
                        ; so jump to the address in $FFFC to reset the machine

.load2

ENDIF

; ******************************************************************************
;
;       Name: Elite GMA loader (Part 3 of 4)
;       Type: Subroutine
;   Category: Loader
;    Summary: Run the Elite loader in the GMA4 file
;
; ------------------------------------------------------------------------------
;
; Other entry points:
;
;   load3               Jump to the entry point in elite-loader
;
; ******************************************************************************

IF _GMA86_PAL

 LDA #4                 ; Call LoadGMAFile to load the GMA4 file, which contains
 JSR LoadGMAFile        ; the Elite loader and game data

ELIF _GMA85_NTSC

 LDA #'4'               ; Call LoadGMAFile to load the GMA4 file, which contains
 JSR LoadGMAFile        ; the Elite loader and game data

ENDIF

 JSR KERNALSCINIT       ; Call the Kernal's SCINIT function to initialise the
                        ; VIC-II

 LDA #2                 ; Set VIC register $20 to set the border colour to the
 STA VIC+$20            ; colour number in bits 0-3 (i.e. colour 2, red)

 STA VIC+$21            ; Set VIC register $21 to set the background colour to
                        ; the colour number in bits 0-3 (i.e. colour 2, red)

 LDA #$04               ; Set the high byte of the pointer to screen memory to
 STA $0288              ; $04, so screen memory gets set to $0400

 LDA #$4C               ; Insert the following instruction into address $CE0E:
 STA $CE0E              ;
 LDA #LO(load4)         ;   JMP load4
 STA $CE0F              ;
                        ; starting with the opcode ($4C) and the low byte of the
                        ; address

.load3

 LDA #HI(load4)         ; And finishing up with the high byte of the address
 STA $CE10              ;
                        ; This enables the Elite loader to jump back to load4
                        ; when it has finished by doing a JMP $CE0E instruction
                        ; (see elite-loader.asm)

 JMP ENTRY              ; Jump to the entry point in elite-loader, which returns
                        ; to load4 via the JMP command we put in $CE0E above

; ******************************************************************************
;
;       Name: Elite GMA loader (Part 4 of 4)
;       Type: Subroutine
;   Category: Loader
;    Summary: Load the GMA5 and GMA6 binaries and start the game
;
; ******************************************************************************

.load4

                        ; When the Elite loader has finished, it jumps back here
                        ; via the instruction we inserted into address $CE0E

 CLC                    ; Call CopyZeroPage with the C flag clear to copy the
 JSR CopyZeroPage       ; contents of zero page to $CE00, so we can restore it
                        ; once we have finished loading the game binaries

 LDA L1                 ; Set bits 0 to 2 of the 6510 port register at location
 AND #%11111000         ; L1 to %110 to set the input/output port to the
 ORA #%00101110         ; following:
 STA L1                 ;
                        ;   * LORAM = 0
                        ;   * HIRAM = 1
                        ;   * CHAREN = 1
                        ;
                        ; This sets the entire 64K memory map to RAM except for
                        ; the I/O memory map at $D000-$DFFF, which gets mapped
                        ; to registers in the VIC-II video controller chip, the
                        ; SID sound chip, the two CIA I/O chips, and so on, and
                        ; $E000-$FFFF, which gets mapped to the Kernal ROM
                        ;
                        ; See the memory map at the bottom of page 264 in the
                        ; "Commodore 64 Programmer's Reference Guide", published
                        ; by Commodore
                        ;
                        ; This also sets bits 3 and 5 to configure the Datasette
                        ; as follows:
                        ;
                        ;   * Bit 3 = Datasette output signal level 1
                        ;
                        ;   * Bit 5 = Datasette motor control off

IF _GMA86_PAL

 LDA #5                 ; Call LoadGMAFile to load the GMA5 file, which contains
 JSR LoadGMAFile        ; the first block of game code (ELITE A to C)

 LDA #6                 ; Call LoadGMAFile to load the GMA6 file, which contains
 JSR LoadGMAFile        ; the second block of game code (ELITE D onwards)

ELIF _GMA85_NTSC

 LDA #'5'               ; Call LoadGMAFile to load the GMA5 file, which contains
 JSR LoadGMAFile        ; the first block of game code (ELITE A to C)

 LDA #'6'               ; Call LoadGMAFile to load the GMA6 file, which contains
 JSR LoadGMAFile        ; the second block of game code (ELITE D onwards)

ENDIF

 LDA L1                 ; Set bits 0 to 2 of the 6510 port register at location
 AND #%11111000         ; L1 to %110 to set the input/output port to the
 ORA #%00000110         ; following:
 STA L1                 ;
                        ;   * LORAM = 0
                        ;   * HIRAM = 1
                        ;   * CHAREN = 1
                        ;
                        ; This sets the entire 64K memory map to RAM except for
                        ; the I/O memory map at $D000-$DFFF, which gets mapped
                        ; to registers in the VIC-II video controller chip, the
                        ; SID sound chip, the two CIA I/O chips, and so on, and
                        ; $E000-$FFFF, which gets mapped to the Kernal ROM
                        ;
                        ; See the memory map at the bottom of page 264 in the
                        ; "Commodore 64 Programmer's Reference Guide", published
                        ; by Commodore

 SEC                    ; Call CopyZeroPage with the C flag set to restore the
 JSR CopyZeroPage       ; contents of zero page from $CE00, which we backed up
                        ; above

 JSR KERNALRESTOR       ; Call the Kernal's RESTOR function to restore the
                        ; vector table at $0314 to $0333 with the default
                        ; values, so the fast loader code is no longer called
                        ; when we use the Kernal's file functions

 JSR KERNALCLALL        ; Call the Kernal's CLALL function to clear the file
                        ; table and close any open files

 JMP S%                 ; Jump to S% in the GMA5 game binary we just loaded, to
                        ; finally start the game

; ******************************************************************************
;
;       Name: LoadGMAFile
;       Type: Subroutine
;   Category: Loader
;    Summary: Load a specific GMA file
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   A                   The number of the GMA file to load
;
;                         * For the GMA85 NTSC variant: as an ASCII character
;
;                         * For the GMA86 PAL variant: as an integer
;
; ******************************************************************************

.LoadGMAFile

 JSR SetUpGMAFile       ; Configure the filename parameters to load the GMA file
                        ; whose number is in A

 LDA #1                 ; Call the Kernal's SETLFS function to set the file
 LDX #8                 ; parameters as follows:
 LDY #1                 ;
 JSR KERNALSETLFS       ;   * A = logical number 1
                        ;
                        ;   * X = device number 8 (disk)
                        ;
                        ;   * Y = secondary address 1

 LDA #0                 ; Call the Kernal's LOAD function to load the GMA file
 JSR KERNALLOAD         ; as follows:
                        ;
                        ;   * A = 0 to initiate a load operation
                        ;
                        ; So this loads the specified GMA file from disk

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: SetUpGMAFile
;       Type: Subroutine
;   Category: Loader
;    Summary: Configure the filename parameters to load a specific GMA file
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   A                   The number of the GMA file to load
;
;                         * For the GMA85 NTSC variant: as an ASCII character
;
;                         * For the GMA86 PAL variant: as an integer
;
; ******************************************************************************

.SetUpGMAFile

IF _GMA86_PAL

 TAX                    ; Copy the number of the GMA file into X

 CLC                    ; Add X to the ASCII for '0' to turn 3, 4 or 5 into
 ADC #'0'               ; ASCII characters "3", "4" or "5"

ENDIF

 STA fileNumber         ; Store the ASCII file number in fileNumber so the
                        ; filename gets set to GMA3, GMA4 or GMA5

IF _GMA86_PAL

 TXA                    ; Set X = X * 2
 ASL A                  ;
 TAX                    ; so we can use X as an index into the trackSector
                        ; table, which has two bytes per entry

 LDA trackSector,X      ; Modify the code at mod1 and mod2 with the track
 STA mod1+1             ; and sector numbers for file X, so the fast loader
 LDA trackSector+1,X    ; knows where to find the file on disk
 STA mod2+1

ENDIF

 LDX #LO(filename)      ; Call SETNAM to set the filename parameters as follows:
 LDY #HI(filename)      ;
 LDA #4                 ;   * A = filename length of 4
 JSR KERNALSETNAM       ;
                        ;   * (Y X) = address of filename
                        ;
                        ; So this sets the filename to "GMA*" where "*" is the
                        ; number passed to the subroutine in A

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: filename
;       Type: Variable
;   Category: Loader
;    Summary: The GMA filename used to load the game files, buried in a message
;             from GMA, the author of the loader
;
; ******************************************************************************

.filename

 EQUS "GMA"

.fileNumber

 EQUS " "

 EQUS " WAS HERE 1985 OK"

; ******************************************************************************
;
;       Name: SetUpFastLoader
;       Type: Subroutine
;   Category: Loader
;    Summary: Set up the fast loader so that calls to the Kernal's file
;             functions use the fast loader routines instead
;
; ------------------------------------------------------------------------------
;
; This routine implements a fast loader that intercepts the Kernal's file
; functions to provide a faster load experience than the default system does.
;
; As this code isn't really Elite-specific and is only run if you choose the
; optional fast loader, I haven't added any commentary.
;
; For an excellent commented version of this routine, I highly recommend Kroc
; Camen's epic Elite Harmless project:
;
; https://github.com/Kroc/elite-harmless/blob/kroc/src/boot/gma/stage1.asm
;
; ******************************************************************************

.SetUpFastLoader

 JSR fast47
 JSR fast46
 RTS

 LDA #$06
 STA $31
 JSR $F50A

.fast1

 BVC fast1
 CLV
 LDA $1C01

IF _GMA86_PAL

 STA $0600,Y

ELIF _GMA85_NTSC

 STA ($30),Y

ENDIF

 INY
 BNE fast1
 LDY #$BA

.fast2

 BVC fast2
 CLV
 LDA $1C01
 STA $0100,Y
 INY
 BNE fast2
 JSR $F8E0
 LDA $38
 CMP $47
 BEQ fast3
 LDA #$04
 BNE fast12

.fast3

 JSR $F5E9
 CMP $3A
 BEQ fast4
 LDA #$05
 BNE fast12

.fast4

IF _GMA86_PAL

 LDA $0601
 STA $07
 LDY #$02
 LDX #$FF
 LDA $0600
 BEQ fast5
 STX $0601

.fast5

 INC $0601

.fast6

 LDX $0600,Y
 CPX #$01
 BNE fast7
 JSR load3

.fast7

 JSR load3
 INY
 CPY $0601
 BNE fast6
 LDA $0600
 BEQ fast14
 CMP $06
 STA $06
 BEQ fast13
 LDA #$01

.fast8

ELIF _GMA85_NTSC

 LDA ($30),Y
 BNE fast9
 INC $0601

.fast9

 LDA ($30),Y
 TAX

.fast10

 BIT $1800
 BPL fast10
 LDA #$10
 STA $1800

.fast11

 BIT $1800
 BMI fast11
 TXA
 LSR A
 LSR A
 LSR A
 LSR A
 STA $1800
 ASL A
 AND #$0F
 NOP
 STA $1800
 TXA
 AND #$0F
 NOP
 STA $1800
 ASL A
 AND #$0F
 NOP
 STA $1800
 LDX #$0F
 NOP
 NOP
 STX $1800
 LDA $0600
 BEQ fast17
 INY
 BNE fast9
 LDA $0601
 STA $0F
 LDA ($30),Y
 CMP $0E
 STA $0E
 BEQ fast13
 LDA #$01

ENDIF

.fast12

 JMP $F969

.fast13

IF _GMA86_PAL

 JMP $0304

.fast14

 LDX #$01
 JSR load3
 LDX #$02
 JSR load3
 LDA #$7F
 JMP $F969

.fast15

 BIT $1800
 BPL fast15
 LDA #$10
 STA $1800

.fast16

 BIT $1800
 BMI fast16
 TXA
 LSR A
 LSR A
 LSR A
 LSR A
 STA $1800
 ASL A
 AND #$0F
 STA $1800
 TXA
 AND #$0F
 STA $1800
 ASL A
 AND #$0F
 STA $1800
 LDA #$0F
 NOP
 STA $1800
 RTS
 JSR $D042

.mod1

 LDA #$FF
 STA $06

.mod2

 LDA #$FF
 STA $07

ELIF _GMA85_NTSC

 JMP $0704

.fast17

 INY
 CPY $0601
 BNE fast9
 LDA #$7F
 BNE fast12
 LDA $18
 STA $0E
 LDA $19
 STA $0F

ENDIF

.fast18

IF _GMA86_PAL

 LDA #$E0
 STA $00

.fast19

 LDA $00

ELIF _GMA85_NTSC

 LDA #$E0
 STA $04

.fast19

 LDA $04

ENDIF

 BMI fast19
 CMP #$7F
 BEQ fast20
 BCC fast18

.fast20

 JMP $D048

.fast21

 LDA $A4
 STA $DD00

.fast22

 LDA $DD00
 BPL fast22

.fast23

 LDA VIC+$12
 CMP #$31
 BCC fast24
 AND #$06
 CMP #$02
 BEQ fast23

.fast24

 LDA $A5
 STA $DD00
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP

IF _GMA86_PAL

 LDX $DD00
 LDA $CF00,X
 LDX $DD00
 ORA $CF08,X
 LDX $DD00
 ORA $CF10,X
 LDX $DD00
 ORA $CF18,X

ELIF _GMA85_NTSC

 NOP
 LDY $DD00
 LDA $CF00,Y
 NOP
 LDY $DD00
 ORA $CF08,Y
 NOP
 LDY $DD00
 ORA $CF10,Y
 NOP
 LDY $DD00
 ORA $CF18,Y

ENDIF

 RTS

IF _GMA85_NTSC

 LDA #$00
 STA $93
 LDA $BA
 CMP #$08
 BCS fast25
 LDA #$08

.fast25

 STA $BA
 STA $B8
 JSR $F5AF
 JSR $F333
 LDX $B9
 STX $02
 LDA #$60
 STA $B9
 JSR $F3D5
 LDA $BA
 JSR $ED09
 LDA $B9
 JSR $EDC7
 JSR $EE13
 LDA $90
 LSR A
 LSR A
 BCC fast26
 JMP $F704

.fast26

 JSR $F5D2

ENDIF

 LDA #$00
 STA $A4

.fast27

 JSR fast43
 LDA #$57
 JSR $EDDD
 LDA $A4
 JSR $EDDD

IF _GMA86_PAL

 LDA #$03

ELIF _GMA85_NTSC

 LDA #$07

ENDIF

 JSR $EDDD
 LDA #$20
 JSR $EDDD
 LDY $A4
 CLC
 LDA $A4
 ADC #$20
 STA $A4

.fast28

IF _GMA86_PAL

 LDA $0403,Y

ELIF _GMA85_NTSC

 LDA $03D6,Y

ENDIF

 JSR $EDDD
 INY
 CPY $A4
 BNE fast28

IF _GMA86_PAL

 JSR $FFCC
 LDA $A4
 CMP #$CE

ELIF _GMA85_NTSC

 JSR $EDFE
 LDA $A4
 CMP #$B5

ENDIF

 BCC fast27
 JSR fast43
 LDA #$45
 JSR $EDDD

IF _GMA86_PAL

 LDA #$B2
 JSR $EDDD
 LDA #$03
 JSR $EDDD
 JSR $FFCC

ELIF _GMA85_NTSC

 LDA #$9C
 JSR $EDDD
 LDA #$07
 JSR $EDDD
 JSR $EDFE

ENDIF

 LDA $DD00
 AND #$07
 STA $A5
 ORA #$08
 STA $A4
 SEI

IF _GMA85_NTSC

 LDX #$04

.fast29

 JSR fast21
 BEQ fast34
 CMP #$FF
 BNE fast30
 LDA #$02
 STA $90
 BNE fast41

.fast30

 JSR fast21
 CPX #$02
 BEQ fast31
 JSR fast44

.fast31

 JSR fast21
 JSR fast50
 LDY #$00
 STA ($AE),Y
 INC $AE
 BEQ fast33

.fast32

 INX
 BNE fast31
 LDX #$02
 JMP fast29

.fast33

 INC $AF
 JMP fast32

.fast34

 JSR fast21
 CPX #$02
 PHP
 TAX
 PLP
 BEQ fast35

 JSR fast44
 DEX
 DEX

.fast35

 DEX
 DEX

.fast36

 JSR fast21

ENDIF

IF _GMA86_PAL

 JSR fast44

 LDY #$00

.fast37

 JSR fast50
 JSR fast21
 CMP #$01
 BNE fast38
 JSR fast21
 CMP #$01
 BNE fast39

.fast38

 STA ($AE),Y
 INY
 BNE fast37
 INC $AF
 BNE fast37

.fast39

 LDA $A5
 STA $0618
 JSR $F646

ELIF _GMA85_NTSC

 JSR fast50

 LDY #$00

 STA ($AE),Y
 INC $AE
 BNE fast40
 INC $AF

.fast40

 DEX
 BNE fast36

.fast41

 LDA $A5
 STA $064E
 JSR $F646

ENDIF

.fast42

 LDA VIC+$11
 BPL fast42
 JSR $FDA3
 LDA $DD00
 AND #$F8

IF _GMA86_PAL

 ORA $0618
 STA $DD00

ELIF _GMA85_NTSC

 ORA $064E
 STA $DD00
 LDX $AE
 LDY $AF

ENDIF

 RTS

.fast43

IF _GMA86_PAL

 LDA #$00
 JSR KERNALSETNAM
 LDA #$0F
 TAY
 LDX #$08
 JSR KERNALSETLFS
 JSR $FFC0
 LDX #$0F
 JSR $FFC9

 LDA #$4D
 JSR KERNALCHROUT
 LDA #$2D
 JSR KERNALCHROUT

ELIF _GMA85_NTSC

 LDA $BA
 JSR $ED0C
 LDA #$6F
 JSR $EDB9

 LDA #$4D
 JSR $EDDD
 LDA #$2D
 JSR $EDDD

ENDIF

 RTS

.fast44

 JSR fast21
 STA $AE
 JSR fast21

IF _GMA85_NTSC

 LDY $02
 BNE fast45
 LDA $C3
 STA $AE
 LDA $C4

.fast45

ENDIF

 STA $AF
 RTS

.fast46

IF _GMA86_PAL

 LDA #$10
 STA $0330
 LDA #$05
 STA $0331

ELIF _GMA85_NTSC

 LDA #$CE
 STA $0330
 LDA #$04
 STA $0331

ENDIF

 RTS

.fast47

 LDX #$00
 LDY #$00

.fast48

 LDA #$08

IF _GMA86_PAL

 STA $0618
 LDA $05FC,X

ELIF _GMA85_NTSC

 STA $064E
 LDA $0632,X

ENDIF

.fast49

 STA $CF00,Y
 INY

IF _GMA86_PAL

 DEC $0618

ELIF _GMA85_NTSC

 DEC $064E

ENDIF

 BNE fast49
 INX
 CPX #$1C
 BCC fast48
 RTS

.fast50

 INC VIC+$20
 DEC VIC+$20
 RTS

; ******************************************************************************
;
;       Name: fastTrackSector
;       Type: Variable
;   Category: Loader
;    Summary: A track and sector table for use by the fast loader
;
; ******************************************************************************

.fastTrackSector

 EQUB $A0, $50
 EQUB $0A
 EQUB $05, $00
 EQUB $00
 EQUB $00
 EQUB $00
 EQUB $20, $10, $02
 EQUB $01, $FF
 EQUB $FF
 EQUB $FF
 EQUB $FF
 EQUB $80
 EQUB $40
 EQUB $08
 EQUB $04
 EQUB $FF
 EQUB $FF
 EQUB $FF
 EQUB $FF
 EQUB $00
 EQUB $00
 EQUB $00
 EQUB $00
 EQUB $FF

; ******************************************************************************
;
;       Name: CopyZeroPage
;       Type: Subroutine
;   Category: Loader
;    Summary: Copy a page of data in a specified direction between zero page and
;             the page at $CE00, omitting the first two bytes
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   C flag              Configures the source page:
;
;                         * Clear = copy data from zero page to $CE00
;
;                         * Set = copy data from the page at $CE00 to zero page
;
; ******************************************************************************

.CopyZeroPage

 LDX #2                 ; We copy the contents of either $0002 to $00FF (if the
                        ; C flag is clear) or $CE02 to $CEFF (if the C flag is
                        ; set), so set an index in X to start from offset 2

.swap1

 LDA $0000,X            ; Set A to the X-th byte of zero page

 BCC swap2              ; If the C flag is clear then skip the following
                        ; instruction

 LDA $CE00,X            ; Set A to the X-th byte of the page at $CE00

.swap2

 STA $0000,X            ; Store the copied byte in the X-th byte of both zero
 STA $CE00,X            ; page and the page at $CE00

 INX                    ; Increment the byte counter

 BNE swap1              ; Loop back until we have copied all of zero page

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: OfferFastLoader
;       Type: Subroutine
;   Category: Loader
;    Summary: Offer the option of using the fast loader, if we haven't already,
;             and set up the fast loader if it is chosen
;
; ******************************************************************************

.OfferFastLoader

 LDA VIC+$11            ; Loop back to OfferFastLoader until bit 7 of VIC-II
 BPL OfferFastLoader    ; register $11 (control register 1) is set
                        ;
                        ; Bit 7 of register $11 contains the top bit of the
                        ; current raster line (which is a 9-bit value), so this
                        ; waits until the raster has reached at least line 256

 LDA #$08               ; Set the high byte of the pointer to screen memory to
 STA $0288              ; $08, so screen memory gets set to $0800

 JSR KERNALSCINIT       ; Call the Kernal's SCINIT function to initialise the
                        ; VIC-II and start using the new screen memory address

 LDA VIC+$18            ; Set bits 4-7 of VIC register $18 to %0010 to set the
 AND #%00001111         ; address of screen RAM to $0800
 ORA #%00100000
 STA VIC+$18

 LDA #2                 ; Set VIC register $20 to set the border colour to the
 STA VIC+$20            ; colour number in bits 0-3 (i.e. colour 2, red)

 STA VIC+$21            ; Set VIC register $21 to set the background colour to
                        ; the colour number in bits 0-3 (i.e. colour 2, red)

 LDX #0                 ; Print the first string from loaderScreens, which
 JSR PrintString        ; clears the screen and prints the "FAST LOADER? (Y/N)"
                        ; prompt

 TXA                    ; Store X on the stack, as it contains the offset of the
 PHA                    ; second string in loaderScreens

 LDA fastLoaderOffered  ; If fastLoaderOffered is non-zero then we have already
 BNE setf2              ; asked about the fast loader, so jump to setf2 to skip
                        ; the following and go straight to the loading screen
                        ; (so we don't ask twice)

 INC fastLoaderOffered  ; Set fastLoaderOffered to 1 to record that we have
                        ; asked about the fast loader

 LDA #$1C               ; Change the colour of the "FAST LOADER? (Y/N)" prompt
 STA promptText         ; from yellow to red to hide it, as it is on a red
                        ; background

.setf1

 JSR KERNALGETIN        ; Call the Kernal's GETIN function to fetch a key press
                        ; from the keyboard

 BEQ setf1              ; Loop back to setf1 until a key is pressed

 CMP #'N'               ; If "N" was pressed then jump to setf2 to skip the fast
 BEQ setf2              ; loader setup and stick to the standard load routines

 CMP #'Y'               ; If "Y" was not pressed then loop back to setf1 to wait
 BNE setf1              ; for another key press

                        ; If we get here then "Y" was pressed, so we need to set
                        ; up the fast loader

 JSR SetUpFastLoader    ; Call SetUpFastLoader to set up the fast loader, so
                        ; that calls to the Kernal's file functions use the fast
                        ; loader routines instead of the built-in functions

.setf2

 PLA                    ; Retrieve the value of X from the stack so it points to
 TAX                    ; the second string in loaderScreens, i.e. the "LOADING
                        ; ELITE" screen

                        ; Fall through into PrintString to display the "LOADING
                        ; ELITE" screen

; ******************************************************************************
;
;       Name: PrintString
;       Type: Subroutine
;   Category: Loader
;    Summary: Print the null-terminated string at offset X in loaderScreens
;
; ******************************************************************************

.PrintString

 LDA loaderScreens,X    ; Set A to the X-th from loaderScreens

 BEQ prin1              ; If it is zero then we have reached the end of the
                        ; string, so jump to prin1

 JSR KERNALCHROUT       ; Call the Kernal's CHROUT function to print the
                        ; character in A

 INX                    ; Increment X to point to the next character

 BNE PrintString        ; Loop back to print the next character (this BNE is
                        ; effectively a JMP as X is never zero

.prin1

 INX                    ; Increment X to point to the next character, so the
                        ; next call to PrintString will print the next string

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: fastLoaderOffered
;       Type: Variable
;   Category: Loader
;    Summary: A flag to record whether we have already asked whether to use the
;             fast loader, so we don't ask twice
;
; ******************************************************************************

.fastLoaderOffered

 EQUB 0                 ; A flag to record the status of the fast loader:
                        ;
                        ;   * 0 = we have not asked about the fast loader
                        ;
                        ;   * 1 = we have already asked about the fast loader

; ******************************************************************************
;
;       Name: loaderScreens
;       Type: Variable
;   Category: Loader
;    Summary: PETSCII codes for clearing the screen and displaying the fast
;             loader prompt and loading screens
;
; ******************************************************************************

.loaderScreens

 EQUB $93               ; Clear screen

 EQUB $96               ; Set pink text

 EQUB $8E               ; Upper case character set

 EQUB $08               ; Disable SHIFT-C=

 EQUS "       "
 EQUS "       "
 EQUS "       "
 EQUS "       "
 EQUS "       "

IF _GMA86_PAL

 EQUS "GMA86"

ELIF _GMA85_NTSC

 EQUS "GMA85"

ENDIF

 EQUB $11, $11, $11     ; 9 x cursor down
 EQUB $11, $11, $11
 EQUB $11, $11, $11

.promptText

 EQUB $9E               ; Set yellow text

 EQUS " DO YOU WANT TO USE"
 EQUB 13
 EQUB 13
 EQUS " THE FAST LOADER? (Y/N)"

 EQUB 0                 ; Terminate string 1 for PrintString

 EQUB $93               ; Clear screen

 EQUB $96               ; Set pink text

 EQUB $8E               ; Upper case character set

 EQUB $08               ; Disable SHIFT-C=

 EQUS "       "
 EQUS "       "
 EQUS "       "
 EQUS "       "
 EQUS "       "

IF _GMA86_PAL

 EQUS "GMA86"

ELIF _GMA85_NTSC

 EQUS "GMA85"

ENDIF

 EQUB $11, $11, $11     ; 9 x cursor down
 EQUB $11, $11, $11
 EQUB $11, $11, $11

 EQUB $9E               ; Set yellow text

 EQUS "       "
 EQUS "       "
 EQUS "LOADING"
 EQUB 13
 EQUB 13
 EQUS "       "
 EQUS "       "
 EQUS " ELITE."

 EQUB 0                 ; Terminate string 2 for PrintString

; ******************************************************************************
;
; Save gma1.bin
;
; ******************************************************************************

 SAVE "3-assembled-output/gma1.bin", CODE%-2, P%, LOAD%
