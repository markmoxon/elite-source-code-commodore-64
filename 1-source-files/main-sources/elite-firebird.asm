; ******************************************************************************
;
; COMMODORE 64 ELITE FIREBIRD DISK LOADER SOURCE (PART 1 of 2)
;
; Commodore 64 Elite was written by Ian Bell and David Braben and is copyright
; D. Braben and I. Bell 1985
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
; This source file contains the first of two disk loaders for Commodore 64
; Elite. It contains a BASIC bootstrap that auto-runs the second disk loader.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
;   * firebird.bin
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

 CODE% = $02A7          ; The address where the code will be run

 LOAD% = $02A7          ; The address where the code will be loaded

 KERNALSETLFS = $FFBA   ; The Kernal function to set the logical, first, and
                        ; second addresses for file access

 KERNALSETNAM = $FFBD   ; The Kernal function to set a filename

 KERNALSETMSG = $FF90   ; The Kernal function to control Kernal messages

 KERNALLOAD = $FFD5     ; The Kernal function to load a file from a device

; ******************************************************************************
;
; ELITE FIREBIRD LOADER
;
; ******************************************************************************

 ORG CODE% - 2          ; Add a two-byte PRG header to the start of the file
 EQUW LOAD%             ; that contains the load address

; ******************************************************************************
;
;       Name: basicBootstrap
;       Type: Variable
;   Category: Loader
;    Summary: Call the RelocateLoader routine even if the firebird file is
;             loaded as a BASIC program
;
; ******************************************************************************

.basicBootstrap

 EQUW $080B             ; Although we have set a PRG address of $02A7, it is
 EQUW $0001             ; possible to ignore a file's PRG when loading (you just
 EQUB $9E               ; need to omit the ",1" part of the LOAD"*",8,1 command)
 EQUS "2061"            ;
 EQUB 0                 ; In this case the file will be loaded as a BASIC file
                        ; at the standard address of $0801, so to make sure we
                        ; still run the game, the firebird loader starts with a
                        ; tokenised one-line BASIC program that contains the
                        ; following:
                        ;
                        ;   1 SYS 2061
                        ;
                        ; 2061 is $080D in hexadecimal, which is the address of
                        ; the RelocateLoader routine if this file is loaded at
                        ; $0801; the RelocateLoader routine is supposed to be at
                        ; $02B3, but if the file is loaded at $0801 instead of
                        ; $02A7, RelocateLoader ends up at this address:
                        ;
                        ;   $02B3 + $0801 - $02A7 = $080D
                        ;
                        ; So this BASIC program ensures that we call the
                        ; RelocateLoader routine, even if we omit the ",1" from
                        ; the load command

 EQUW 0                 ; These bytes appear to be unused

; ******************************************************************************
;
;       Name: RelocateLoader
;       Type: Subroutine
;   Category: Loader
;    Summary: Load and run the GMA1 loader file
;
; ******************************************************************************

.RelocateLoader

 LDX #101               ; We now copy this program from the BASIC program area
                        ; to $02A7, which is where it is supposed to run, so
                        ; set byte a counter in X to copy 101 bytes

.relo1

 LDA $0801,X            ; Copy the X-th byte from $0801 to $02A7
 STA $02A7,X

 DEX                    ; Decrement the byte counter

 BPL relo1              ; Loop back until we have copied the whole program

 JMP RunGMA             ; Jump to the newly relocated RunDMA routine to load and
                        ; run the first GMA file on disk

; ******************************************************************************
;
;       Name: filename
;       Type: Subroutine
;   Category: Loader
;    Summary: A wildcarded filename that matches the first GMA file on disk
;
; ******************************************************************************

.filename

                        ; --- Mod: Code removed for Compendium: --------------->

;EQUS "GM*"

                        ; --- And replaced by: -------------------------------->

 EQUS "CM*"

                        ; --- End of replacement ------------------------------>

; ******************************************************************************
;
;       Name: RunGMA
;       Type: Subroutine
;   Category: Loader
;    Summary: Load and run the GMA1 loader file
;
; ******************************************************************************

.RunGMA

 LDA #%00000000         ; Call the Kernal's SETMSG function to set the system
 JSR KERNALSETMSG       ; error display switch as follows:
                        ;
                        ;   * Bit 6 clear = do not display I/O error messages
                        ;
                        ;   * Bit 7 clear = do not display system messages
                        ;
                        ; This ensures that any file system errors are hidden

 LDA #2                 ; Call the Kernal's SETLFS function to set the file
 LDX #8                 ; parameters as follows:
 LDY #$FF               ;
 JSR KERNALSETLFS       ;   * A = logical number 2
                        ;
                        ;   * X = device number 8 (disk)
                        ;
                        ;   * Y = secondary address $FF
                        ;
                        ; The last setting ensures that the Kernal's LOAD
                        ; function loads files using the addresses in their PRG
                        ; headers

 LDA #3                 ; Call SETNAM to set the filename parameters as follows:
 LDX #LO(filename)      ;
 LDY #HI(filename)      ;   * A = filename length of 3
 JSR KERNALSETNAM       ;
                        ;   * (Y X) = address of filename
                        ;
                        ; So this sets the filename to "GM*"

 LDA #0                 ; Call the Kernal's LOAD function to load the GMA* file
 JSR KERNALLOAD         ; as follows:
                        ;
                        ;   * A = 0 to initiate a load operation
                        ;
                        ; So this loads the first GM* file we find on disk at
                        ; the address in its PRG header, which will be GMA1 at
                        ; $0334

 LDA #$FF               ; Set the high byte of the execution address of STOP to
 STA $0329              ; $FF, from the default $F6ED to $FFED
                        ;
                        ; The address $FFED in the Kernal ROM simply returns
                        ; without doing anything, so this effectively disables
                        ; the RUN/STOP key

 NOP                    ; These NOPs pad out the rest of this routine to ensure
 NOP                    ; that the BASIC vectors in basicVectors end up in the
 NOP                    ; correct addresses for overriding BASIC, for when this
 NOP                    ; file is loaded at its PRG address of $02A7
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

 JMP $0334              ; Jump to the start of the GMA1 loader file that we just
                        ; loaded, which loads the game

; ******************************************************************************
;
;       Name: basicVectors
;       Type: Variable
;   Category: Loader
;    Summary: Addresses that override the BASIC vectors for when the loader file
;             is loaded at the address in its PRG header, $02A7
;
; ******************************************************************************

.basicVectors

 EQUW RunGMA            ; If the loader file is loaded at $02A7, this section is
 EQUW RunGMA            ; loaded at $0300, which is where the BASIC vectors live
 EQUW RunGMA            ;
 EQUW RunGMA            ; This therefore sets the execution address for the six
 EQUW RunGMA            ; vectors to the RunGMA routine, so as soon as BASIC
 EQUW RunGMA            ; starts up and tries to run the program, it calls the
                        ; RunGMA routine instead
                        ;
                        ; So between these vectors and the basicBootstrap BASIC
                        ; program, this ensures that Elite is loaded whether we
                        ; load the firebird binary as a BASIC program at $0801
                        ; or using its PRG address at $02A7

; ******************************************************************************
;
; Save firebird.bin
;
; ******************************************************************************

 SAVE "3-assembled-output/firebird.bin", CODE%-2, P%, LOAD%
