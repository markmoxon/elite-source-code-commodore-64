; ******************************************************************************
;
; COMMODORE 64 ELITE GAME LOADER SOURCE
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
; This source file contains the game loader for Commodore 64 Elite, which itself
; gets loaded by the disk loader.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
;   * COMLOD.unprot.bin
;
; after reading in the following files:
;
;   * CODIALS.bin
;   * DATE4.bin
;   * LODATA.bin
;   * SHIPS.bin
;   * SPRITE.bin
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

 CODE% = $4000          ; The address where the code will be run

 LOAD% = $4000          ; The address where the code will be loaded

 KEY3 = $8E             ; The seed for decrypting COMLOD from U% to V%, which is
                        ; the second block of data, after the decryption routine

 KEY4 = $6C             ; The seed for decrypting COMLOD from W% to X%, which is
                        ; the first block of data, before the decryption routine

 L1 = $0001             ; The 6510 input/output port register, which we can use
                        ; to configure the Commodore 64 memory layout (see page
                        ; 260 of the Programmer's Reference Guide)

 SCBASE = $4000         ; The address of the screen bitmap

IF _GMA_RELEASE

 DSTORE% = SCBASE + $AF90       ; The address of a copy of the dashboard bitmap,
                                ; which gets copied into screen memory when
                                ; setting up a new screen

 SPRITELOC% = SCBASE + $2800    ; The address where the sprite bitmaps get
                                ; copied to during the loading process

ELIF _SOURCE_DISK

 DSTORE% = SCBASE + $2800       ; The address of a copy of the dashboard bitmap,
                                ; which gets copied into screen memory when
                                ; setting up a new screen

 SPRITELOC% = SCBASE + $3100    ; The address where the sprite bitmaps get
                                ; copied to during the loading process

ENDIF

 SPOFF% = (SPRITELOC% - SCBASE) / 64    ; Sprite pointers are defined as the
                                        ; offset from the start of the VIC-II
                                        ; screen bank to start of the sprite
                                        ; definitions, divided by 64, so SPOFF%
                                        ; is the offset for the first sprite
                                        ; definition at SPRITELOC%

 D% = $D000             ; The address where the ship data will be loaded
                        ; (i.e. XX21)

 VIC = $D000            ; Registers for the VIC-II video controller chip, which
                        ; are memory-mapped to the 46 bytes from $D000 to $D02E
                        ; (see page 454 of the Programmer's Reference Guide)

 COLMEM = $D800         ; Colour RAM, which is used (along with screen RAM) to
                        ; define the colour map of the dashboard in multicolour
                        ; bitmap mode

 CIA = $DC00            ; Registers for the CIA1 I/O interface chip, which
                        ; are memory-mapped to the 16 bytes from $DC00 to $DC0F
                        ; (see page 428 of the Programmer's Reference Guide)

 CIA2 = $DD00           ; Registers for the CIA2 I/O interface chip, which
                        ; are memory-mapped to the 16 bytes from $DD00 to $DD0F
                        ; (see page 428 of the Programmer's Reference Guide)

; ******************************************************************************
;
;       Name: ZP
;       Type: Workspace
;    Address: $0018 to $001B
;   Category: Workspaces
;    Summary: Important variables used by the loader
;
; ******************************************************************************

 ORG $0018              ; Set the assembly address to $0018

.ZP

 SKIP 2                 ; Stores addresses used for moving content around

.ZP2

 SKIP 2                 ; Stores addresses used for moving content around

; ******************************************************************************
;
; ELITE LOADER
;
; ******************************************************************************

 ORG CODE%              ; Set the assembly address to CODE%

; ******************************************************************************
;
;       Name: W%
;       Type: Variable
;   Category: Utility routines
;    Summary: Denotes the start of the first block of loader code, as used in
;             the encryption/decryption process
;
; ******************************************************************************

.W%

 SKIP 0

; ******************************************************************************
;
;       Name: LODATA
;       Type: Subroutine
;   Category: Loader
;    Summary: The binaries for recursive tokens and the game font
;
; ******************************************************************************

.LODATA

 INCBIN "3-assembled-output/LODATA.bin"

; ******************************************************************************
;
;       Name: SHIPS
;       Type: Subroutine
;   Category: Loader
;    Summary: The binaries for the ship blueprints
;
; ******************************************************************************

.SHIPS

 INCBIN "3-assembled-output/SHIPS.bin"

IF _GMA_RELEASE

 EQUB $1F, $3F          ; These bytes appear to be unused and just contain
 EQUB $58               ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $B3, $1F, $3F, $58, $98, $A0, $40, $20    ; These bytes appear to be
 EQUB $1F, $F0, $8C, $98, $1A, $46, $10, $8C    ; unused and just contain random
 EQUB $CF, $3C, $B2, $CF, $C2, $7D, $FF, $2A    ; workspace noise left over from
 EQUB $92, $AB, $A8, $BD, $3E, $85, $9E, $19    ; the BBC Micro assembly process
 EQUB $85, $F5, $3A, $EF, $06, $E6, $E4, $04
 EQUB $07, $E7, $E5, $EA, $AA, $2E, $98, $2F
 EQUB $10, $F0, $E2, $02, $12, $F2, $E3, $03
 EQUB $DA, $BA, $E4, $04, $DB, $BB, $E5, $19
 EQUB $39, $85, $25, $2E, $98, $3A, $BB, $B0
 EQUB $12, $13, $03, $E3, $F3, $F2, $E2, $7D
 EQUB $1A, $B2, $5D, $02, $E2, $F0, $10, $03
 EQUB $E3, $F2, $8D, $1A, $B2, $40, $78, $2F
 EQUB $E4, $01, $2C, $ED, $E3, $21, $2B, $5C
 EQUB $52, $22, $A8, $CB, $07, $2E, $DB, $BB
 EQUB $E5, $05, $DC, $BC

ELIF _SOURCE_DISK_FILES

 EQUB $38, $E0, $60, $3F, $0F, $7C, $24, $B2    ; These bytes appear to be
 EQUB $60, $56, $9C, $67, $23, $FA, $81, $91    ; unused and just contain random
 EQUB $3F, $7C, $29, $BC, $3D, $53, $65, $FB    ; workspace noise left over from
 EQUB $C3, $23, $B7, $9E, $7A, $2F, $29, $F5    ; the BBC Micro assembly process
 EQUB $EC, $CA, $E8, $0B, $EE, $CC, $CF, $94
 EQUB $D8, $C6, $C7, $3F, $00, $D2, $E4, $14
 EQUB $04, $D5, $E6, $DD, $94, $9E, $E8, $DF
 EQUB $96, $A0, $FE, $52, $BE, $AA, $53, $C6
 EQUB $D2, $F5, $6B, $C2, $25, $16, $E6, $D6
 EQUB $E5, $D4, $5F, $A3, $E5, $1D, $60, $E4
 EQUB $D2, $00, $13, $E6, $D5, $7F, $B3, $E5
 EQUB $00, $B9, $A7, $13, $E5, $2D, $19, $D0
 EQUB $04, $4C, $87, $AE, $74, $CA, $73, $D2
 EQUB $35, $09, $96, $A0, $EA, $E1, $98, $A2
 EQUB $66, $AE, $C6, $04

ENDIF

; ******************************************************************************
;
;       Name: X%
;       Type: Variable
;   Category: Utility routines
;    Summary: Denotes the end of the first block of loader code, as used in the
;             encryption/decryption process
;
; ******************************************************************************

.X%

 JMP $0185              ; This code is never run, but it was presumably added
                        ; to the code to act as a red herring to confuse any
                        ; crackers exploring the loader code

; ******************************************************************************
;
;       Name: FRIN
;       Type: Variable
;   Category: Loader
;    Summary: A temporary variable that's used for storing addresses
;
; ******************************************************************************

.FRIN

 JSR $0134              ; This code is never run (it is overwritten when the
                        ; FRIN variable is used), but it was presumably added
                        ; to the code to act as a red herring to confuse any
                        ; crackers exploring the loader code

; ******************************************************************************
;
;       Name: Elite loader (Part 1 of 7)
;       Type: Subroutine
;   Category: Loader
;    Summary: Unscramble the loader code and game data
;
; ******************************************************************************

.ENTRY

 CLD                    ; Clear the decimal flag, so we're not in decimal mode

 LDA #LO(U%-1)          ; Set FRIN(1 0) = U%-1 as the low address of the
 STA FRIN               ; decryption block, so we decrypt the loader routine
 LDA #HI(U%-1)          ; at U% below
 STA FRIN+1

 LDA #HI(V%-1)          ; Set (A Y) to V% as the high address of the decryption
 LDY #LO(V%-1)          ; block, so we decrypt to V% at the end of the loader
                        ; routine

 LDX #KEY3              ; Set X = KEY3 as the decryption seed (the value used to
                        ; encrypt the code, which is done in elite-checksum.py)

IF _REMOVE_CHECKSUMS

 NOP                    ; If we have disabled checksums, skip the call to DEEORS
 NOP
 NOP

ELSE

 JSR DEEORS             ; Call DEEORS to decrypt between U% and V%

ENDIF

 LDA #LO(W%-1)          ; Set FRIN(1 0) = W%-1 as the low address of the
 STA FRIN               ; decryption block, so we decrypt the game data at
 LDA #HI(W%-1)          ; at W% above
 STA FRIN+1

 LDA #HI(X%-1)          ; Set (A Y) to X% as the high address of the decryption
 LDY #LO(X%-1)          ; block, so we decrypt to X% at the end of the game data

 LDX #KEY4              ; Set X = KEY4 as the decryption seed (the value used to
                        ; encrypt the code, which is done in elite-checksum.py)

IF _REMOVE_CHECKSUMS

 NOP                    ; If we have disabled checksums, skip the call to DEEORS
 NOP
 NOP

ELSE

 JSR DEEORS             ; Call DEEORS to decrypt between W% and X%

ENDIF

 JMP U%                 ; Now that both the game data and the loader routine
                        ; have been decrypted, jump to the loader routine at U%
                        ; to load the game

; ******************************************************************************
;
;       Name: DEEORS
;       Type: Subroutine
;   Category: Loader
;    Summary: Decrypt a multi-page block of memory
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   FRIN(1 0)           The start address of the block to decrypt
;
;   (A Y)               The end address of the block to decrypt
;
;   X                   The decryption seed
;
; ******************************************************************************

.DEEORS

 STX ZP2                ; Store the decryption seed in ZP2 as our starting point

 STA ZP+1               ; Set ZP(1 0) = (A 0) to point to the start of page A,
 LDA #0                 ; so we can use ZP(1 0) + Y as our pointer to the next
 STA ZP                 ; byte to decrypt

.DEEORL

 LDA (ZP),Y             ; Set A to the Y-th byte of ZP(1 0)

 SEC                    ; Set A = A - ZP2
 SBC ZP2

 STA (ZP),Y             ; Update the Y-th byte of ZP to the new value in A

 STA ZP2                ; Update ZP2 with the new value in A

 TYA                    ; Set A to the current byte index in Y

 BNE P%+4               ; If A <> 0 then decrement the high byte of ZP(1 0) to
 DEC ZP+1               ; point to the previous page

 DEY                    ; Decrement the byte pointer

 CPY FRIN               ; Loop back to decrypt the next byte, until Y = the low
 BNE DEEORL             ; byte of FRIN(1 0), at which point we have decrypted a
                        ; whole page

 LDA ZP+1               ; Check whether ZP(1 0) matches FRIN(1 0) and loop back
 CMP FRIN+1             ; to decrypt the next byte until it does, at which point
 BNE DEEORL             ; we have decrypted the whole block

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: Elite loader (Part 2 of 7)
;       Type: Subroutine
;   Category: Loader
;    Summary: Copy the game data to their correct locations
;
; ******************************************************************************

.U%

 LDX #$16               ; Set X = $16 so we copy 22 pages of data from LODATA
                        ; into $0700 to $1CFF

 LDA #0                 ; Set ZP(1 0) = $0700
 STA ZP
 LDA #$7
 STA ZP+1

 LDA #LO(LODATA)        ; Set (A ZP2) = LODATA
 STA ZP2
 LDA #HI(LODATA)

 JSR mvblock            ; Call mvblock to copy 22 pages of data from LODATA to
                        ; $0700, so this copies the following data:
                        ;
                        ;   * QQ18 to $0700, the text token table
                        ;
                        ;   * SNE to $0AC0, the sine lookup table
                        ;
                        ;   * ACT to $0AE0, the arctan lookup table
                        ;
                        ;   * FONT to $0B00, the game's text font
                        ;
                        ;   * TKN1 to $0E00, the extended token table
                        ;
                        ; The data at TKN1 ends at $1CFF

 SEI                    ; Disable interrupts while we set the 6510 input/output
                        ; port register and configure the VIC-II chip

 LDA L1                 ; Set bits 0 to 2 of the 6510 port register at location
 AND #%11111000         ; L1 to %100 to set the input/output port to the
 ORA #%00000100         ; following:
 STA L1                 ;
                        ;   * LORAM = 0
                        ;   * HIRAM = 0
                        ;   * CHAREN = 1
                        ;
                        ; and return from the subroutine using a tail call
                        ;
                        ; This sets the entire 64K memory map to RAM
                        ;
                        ; See the memory map at the top of page 265 in the
                        ; "Commodore 64 Programmer's Reference Guide", published
                        ; by Commodore

IF _GMA_RELEASE

 LDX #$29               ; Set X = $29 so we copy 41 pages of data from SHIPS
                        ; into D% ($D000 to $F8FF)
                        ;
                        ; It isn't necessary to copy this number of pages, as
                        ; the ship data only takes up 32 pages of memory, and
                        ; the extra data that's copied from $F000 to $F8FF is
                        ; just ignored

ELIF _SOURCE_DISK

 LDX #$20               ; Set X = $20 so we copy 32 pages of data from SHIPS
                        ; to D% ($D000 to $EFFF)

ENDIF

 LDA #LO(D%)            ; Set ZP(1 0) = D% = $D000
 STA ZP
 LDA #HI(D%)
 STA ZP+1

 LDA #LO(SHIPS)         ; Set (A ZP2) = SHIPS
 STA ZP2
 LDA #HI(SHIPS)

 JSR mvblock            ; Call mvblock to copy X pages of data from SHIPS to D%
                        ; ($D000), so this copies the following data:
                        ;
                        ;   * XX21 to $D000, the ship blueprints
                        ;
                        ; The data at XX21 ends at $EF8C

; ******************************************************************************
;
;       Name: Elite loader (Part 3 of 7)
;       Type: Subroutine
;   Category: Loader
;    Summary: Configure the memory layout and the CIA chips
;
; ******************************************************************************

 LDA L1                 ; Set bits 0 to 2 of the 6510 port register at location
 AND #%11111000         ; L1 to %101 to set the input/output port to the
 ORA #%00000101         ; following:
 STA L1                 ;
                        ;   * LORAM = 1
                        ;   * HIRAM = 0
                        ;   * CHAREN = 1
                        ;
                        ; This sets the entire 64K memory map to RAM except for
                        ; the I/O memory map at $D000-$DFFF, which gets mapped
                        ; to registers in the VIC-II video controller chip, the
                        ; SID sound chip, the two CIA I/O chips, and so on
                        ;
                        ; See the memory map at the top of page 264 in the
                        ; "Commodore 64 Programmer's Reference Guide", published
                        ; by Commodore

 LDA CIA2+2             ; Set bits 0-1 of CIA2 port A to the output direction
 ORA #%00000011         ; so we can write to the VIC-II bank selector, which is
 STA CIA2+2             ; mapped here (0 means input, 1 means output)

 LDA CIA2+0             ; Set bits 0-1 of CIA2 port A to configure the VIC-II to
 AND #%11111100         ; use bank 1 ($4000 to $7FFF)
 ORA #%00000010         ;
 STA CIA2+0             ; The bank number is inverted, so setting bits 0-1 to
                        ; %10 actually sets bank %01

 LDA #%00000011         ; Set CIA1 register $0D to enable and disable interrupts
 STA CIA+$D             ; as follows:
                        ;
                        ;   * Bit 0 set = configure interrupts generated by
                        ;                 timer A underflow
                        ;
                        ;   * Bit 1 set = configure interrupts generated by
                        ;                 timer B underflow
                        ;
                        ;   * Bits 2-4 clear = do not change configuration of
                        ;                      other interrupts
                        ;
                        ;   * Bit 7 clear = disable interrupts whose
                        ;                   corresponding bits are set
                        ;
                        ; So this disables interrupts that are generated by
                        ; timer A underflow and timer B underflow, while leaving
                        ; other interrupts as they are

 STA CIA2+$D            ; Set CIA2 register $0D to enable and disable interrupts
                        ; as follows:
                        ;
                        ;   * Bit 0 set = configure interrupts generated by
                        ;                 timer A underflow
                        ;
                        ;   * Bit 1 set = configure interrupts generated by
                        ;                 timer B underflow
                        ;
                        ;   * Bits 2-4 clear = do not change configuration of
                        ;                      other interrupts
                        ;
                        ;   * Bit 7 clear = disable interrupts whose
                        ;                   corresponding bits are set
                        ;
                        ; So this disables interrupts that are generated by
                        ; timer A underflow and timer B underflow, while leaving
                        ; other interrupts as they are

; ******************************************************************************
;
;       Name: Elite loader (Part 4 of 7)
;       Type: Subroutine
;   Category: Loader
;    Summary: Configure the VIC-II for screen memory and sprites
;  Deep dive: The split-screen mode in Commodore 64 Elite
;             Sprite usage in Commodore 64 Elite
;
; ******************************************************************************

 LDA #$81               ; Set VIC register $18 to set the address of screen RAM
 STA VIC+$18            ; to offset $2000 within the VIC-II bank at $4000 (so
                        ; the screen's colour data is at $6000)

 LDA #0                 ; Set VIC register $20 to set the border colour to the
 STA VIC+$20            ; colour number in bits 0-3 (i.e. colour 0, black)

 LDA #0                 ; Set VIC register $21 to set the background colour to
 STA VIC+$21            ; the colour number in bits 0-3 (i.e. colour 0, black)

 LDA #%00111011         ; Set VIC register $11 to configure the screen control
 STA VIC+$11            ; register as follows:
                        ;
                        ;   * Bits 0-2 = vertical raster scroll of 3
                        ;
                        ;   * Bit 3 set = screen height of 25 rows
                        ;
                        ;   * Bit 4 set = enable screen
                        ;
                        ;   * Bit 5 set = bitmap mode
                        ;
                        ;   * Bit 6 clear = extended background mode off
                        ;
                        ;   * Bit 7 = bit 9 of raster line for interrupt

 LDA #%11000000         ; Set VIC register $11 to configure the screen control
 STA VIC+$16            ; register as follows:
                        ;
                        ;   * Bits 0-2 = horizontal raster scroll of 0
                        ;
                        ;   * Bit 3 clear = screen width of 38 columns
                        ;
                        ;   * Bit 4 clear = standard bitmap mode
                        ;
                        ; Bits 6 and 7 don't appear to have any effect, so I'm
                        ; not sure why they are being set

 LDA #%00000000         ; Clear bits 0 to 7 of VIC register $15 to disable all
 STA VIC+$15            ; eight sprites

 LDA #9                 ; Set VIC register $29 to set the colour of sprite 2 to
 STA VIC+$29            ; the colour number in bits 0-3 (i.e. colour 9, brown),
                        ; so this makes Trumble 0 brown

 LDA #12                ; Set VIC register $2A to set the colour of sprite 3 to
 STA VIC+$2A            ; the colour number in bits 0-3 (i.e. colour 12, grey),
                        ; so this makes Trumble 1 grey

 LDA #6                 ; Set VIC register $2B to set the colour of sprite 4 to
 STA VIC+$2B            ; the colour number in bits 0-3 (i.e. colour 6, blue),
                        ; so this makes Trumble 2 blue

 LDA #1                 ; Set VIC register $2C to set the colour of sprite 5 to
 STA VIC+$2C            ; the colour number in bits 0-3 (i.e. colour 1, white),
                        ; so this makes Trumble 3 white

 LDA #5                 ; Set VIC register $2D to set the colour of sprite 6 to
 STA VIC+$2D            ; the colour number in bits 0-3 (i.e. colour 5, green),
                        ; so this makes Trumble 4 green

 LDA #9                 ; Set VIC register $2E to set the colour of sprite 7 to
 STA VIC+$2E            ; the colour number in bits 0-3 (i.e. colour 9, brown),
                        ; so this makes Trumble 5 brown

 LDA #8                 ; Set VIC register $25 to set sprite extra colour 1 to
 STA VIC+$25            ; the colour number in bits 0-3 (i.e. colour 8, orange),
                        ; for the explosion sprite

 LDA #7                 ; Set VIC register $26 to set sprite extra colour 2 to
 STA VIC+$26            ; the colour number in bits 0-3 (i.e. colour 7, yellow),
                        ; for the explosion sprite

 LDA #%00000000         ; Clear bits 0 to 7 of VIC register $1C to set all seven
 STA VIC+$1C            ; sprites to single colour

 LDA #%11111111         ; Set bits 0 to 7 of VIC register $17 to set all seven
 STA VIC+$17            ; sprites to double height

 STA VIC+$1D            ; Set bits 0 to 7 of VIC register $1D to set all seven
                        ; sprites to double width

 LDA #0                 ; Clear bits 0 to 7 of VIC register $10 to zero bit 9 of
 STA VIC+$10            ; the x-coordinate for all seven sprite

 LDX #161               ; Position sprite 0 (the laser sights) at pixel
 LDY #101               ; coordinates (161, 101), in the centre of the space
 STX VIC+0              ; view
 STY VIC+1

 LDA #18                ; Position sprite 1 (the explosion sprite) at pixel
 LDY #12                ; coordinates (18, 12)
 STA VIC+2
 STY VIC+3

 ASL A                  ; Position sprite 2 (Trumble 0) at pixel coordinates
 STA VIC+4              ; (36, 12)
 STY VIC+5

 ASL A                  ; Position sprite 3 (Trumble 1) at pixel coordinates
 STA VIC+6              ; (72, 12)
 STY VIC+7

 ASL A                  ; Position sprite 4 (Trumble 2) at pixel coordinates
 STA VIC+8              ; (144, 12)
 STY VIC+9

 LDA #14                ; Position sprite 5 (Trumble 3) at pixel coordinates
 STA VIC+10             ; (14, 12)
 STY VIC+11

 ASL A                  ; Position sprite 6 (Trumble 4) at pixel coordinates
 STA VIC+12             ; (28, 12)
 STY VIC+13

 ASL A                  ; Position sprite 7 (Trumble 5) at pixel coordinates
 STA VIC+14             ; (56, 12)
 STY VIC+15

 LDA #%00000010         ; Set VIC register $1B to all clear bits apart from bit
 STA VIC+$1B            ; 1, so that:
                        ;
                        ;   * Sprite 0 (the laser sights) are drawn in front of
                        ;     the screen contents
                        ;
                        ;   * Sprite 1 (the explosion sprite) is drawn in behind
                        ;     the screen contents
                        ;
                        ;   * Sprites 2 to 7 (the Trumble sprites) are drawn in
                        ;     front of the screen contents
                        ;
                        ; This ensures that when we change views in-game, the
                        ; BLUEBAND routine will hide any part of the explosion
                        ; sprite that's in the screen border area, as it fills
                        ; the border with colour 1

; ******************************************************************************
;
;       Name: Elite loader (Part 5 of 7)
;       Type: Subroutine
;   Category: Loader
;    Summary: Configure the screen bitmap and copy colour data into screen RAM
;  Deep dive: Colouring the Commodore 64 bitmap screen
;
; ******************************************************************************

                        ; We start by clearing the screen bitmap from $4000 to
                        ; $5FFF by zeroing this part of memory

 LDA #0                 ; Set the low byte of ZP(1 0) to 0
 STA ZP

 TAY                    ; Set Y = 0 to act as a byte counter

 LDX #$40               ; Set X = $40 to use as the high byte of ZP(1 0), so the
                        ; next instruction initialises ZP(1 0) to $4000

.LOOP2

 STX ZP+1               ; Set the high byte of ZP(1 0) to X

.LOOP1

 STA (ZP),Y             ; Zero the Y-th byte of ZP(1 0)

 INY                    ; Increment the byte counter in Y

 BNE LOOP1              ; Loop back until we have zeroed a whole page at ZP(1 0)

 LDX ZP+1               ; Set X to the high byte of ZP(1 0)

 INX                    ; Increment X to point to the next page in memory

 CPX #$60               ; Loop back to zero the next page in memory until we
 BNE LOOP2              ; have zeroed all the way to $5FFF

                        ; We now reset the two banks of screen RAM from $6000 to
                        ; $63FF and $6400 to $67FF, so we can then populate them
                        ; with colour data for the text view ($6000 to $63FF)
                        ; and the space view ($6400 to $67FF)

 LDA #$10               ; Set A to the colour byte that we want to fill both
                        ; blocks of screen RAM with, which is $10 to set the
                        ; palette to foreground colour 1 (red) and background
                        ; colour 0 (black)

                        ; At this point, X = $60 from above, which we use as the
                        ; high byte of ZP(1 0), and ZP hasn't changed from zero,
                        ; so the next instruction initialises ZP(1 0) to $6000

.LOOP3

 STX ZP+1               ; Set the high byte of ZP(1 0) to X

.LOOP4

 STA (ZP),Y             ; Set the Y-th byte of ZP(1 0) to $10

 INY                    ; Increment the byte counter

 BNE LOOP4              ; Loop back until we have filled a whole page with the
                        ; red/black palette byte

 LDX ZP+1               ; Set X to the high byte of ZP(1 0)

 INX                    ; Increment X to point to the next page in memory

 CPX #$68               ; Loop back to zero the next page in memory until we
 BNE LOOP3              ; have zeroed all the way to $67FF

                        ; Next, we populate screen RAM for the space view ($6400
                        ; to $67FF), starting with the dashboard in the lower
                        ; part of the screen

 LDA #LO(SCBASE+$2400+$2D0)     ; Set ZP(1 0) to the address within the space
 STA ZP                         ; view's screen RAM that corresponds to the
 LDA #HI(SCBASE+$2400+$2D0)     ; dashboard (i.e. offset $2D0 within the screen
 STA ZP+1                       ; RAM at SCBASE + $2400, or $6400)

 LDA #LO(sdump)         ; Set (A ZP2) = sdump
 STA ZP2
 LDA #HI(sdump)

 JSR mvsm               ; Call mvsm to copy 280 bytes of data from sdump to the
                        ; dashboard's screen RAM for the space view, so this
                        ; sets the correct colour data for the dashboard (along
                        ; with the data that we copy into colour RAM in part 6)

;LDX #0                 ; These instructions are commented out in the original
;                       ; source
;.LOOP20
;
;LDA date,X
;STA SCBASE+$7A0,X
;
;DEX
;
;BNE LOOP20

                        ; Now we populate screen RAM for the text view ($6000
                        ; to $63FF) to set the correct colour for the border box
                        ; around the edges of the screen
                        ;
                        ; The screen borders are four character blocks wide on
                        ; each side of the screen (so the 256-pixel wide game
                        ; screen gets shown in the middle of the 320-pixel wide
                        ; screen mode)
                        ;
                        ; The outside three character blocks show nothing and
                        ; are plain black, which we achieve by setting both the
                        ; foreground and background colours to black for these
                        ; character blocks
                        ;
                        ; The innermost of the four character blocks on each
                        ; side is used to draw the border box, with the border
                        ; being right up against the game screen, so for this we
                        ; need a palette of yellow on black, so we can draw the
                        ; border box in yellow

 LDA #0                 ; Set ZP(1 0) = $6000
 STA ZP                 ;
 LDA #$60               ; So ZP(1 0) points to screen RAM for the text view
 STA ZP+1

 LDX #25                ; The text view is 25 character rows high, so set a row
                        ; counter in X

.LOOP10

 LDA #$70               ; Set A to the colour byte that we want to apply to the
                        ; border box, which is $70 to set the palette to
                        ; foreground colour 7 (yellow) and background colour 0
                        ; (black)

 LDY #36                ; Set the colour data for column 36 (i.e. the right edge
 STA (ZP),Y             ; of the border box) to the yellow/black palette

 LDY #3                 ; Set the colour data for column 3 (i.e. the left edge
 STA (ZP),Y             ; of the border box) to the yellow/black palette

                        ; Next, we set the palette to black on black for the
                        ; outside three character blocks on the left side of the
                        ; screen, so they don't show anything at all

 DEY                    ; Set Y = 2 to use as a column counter for the three
                        ; character blocks, so we work our way through columns
                        ; 2, 1 and 0

 LDA #$00               ; Set A to the colour byte that we want to apply to the
                        ; outer border area, which is $00 to set the palette to
                        ; foreground colour 0 (black) and background colour 0
                        ; (black)

.frogl

 STA (ZP),Y             ; Set the colour data for column Y to the black/black
                        ; palette

 DEY                    ; Decrement the column counter

 BPL frogl              ; Loop back until we have set all three character blocks
                        ; on the left edge of this character row to the
                        ; black/black palette

                        ; And now we set the palette to black on black for the
                        ; outside three character blocks on the right side of
                        ; the screen, so they also show nothing

 LDY #37                ; Set Y = 2 to use as a column counter for the three
                        ; character blocks, so we work our way through columns
                        ; 37, 38 and 39

 STA (ZP),Y             ; Set the colour data for column 37 to the black/black
                        ; palette

 INY                    ; Set the colour data for column 38 to the black/black
 STA (ZP),Y             ; palette

 INY                    ; Set the colour data for column 39 to the black/black
 STA (ZP),Y             ; palette

 LDA ZP                 ; Set ZP(1 0) = ZP(1 0) + 40
 CLC                    ;
 ADC #40                ; So ZP(1 0) points to the next character row in screen
 STA ZP                 ; RAM (as there are 40 character blocks on each row)
 BCC P%+4
 INC ZP+1

 DEX                    ; Decrement the row counter in X

 BNE LOOP10             ; Loop back until we have set the colour data for the
                        ; left and right border box edges in the text view

                        ; Now we populate screen RAM for the text view ($6000
                        ; to $63FF) to set the correct colour for the border box
                        ; around the edges of the space view

 LDA #0                 ; Set ZP(1 0) = $6400
 STA ZP                 ;
 LDA #$64               ; So ZP(1 0) points to screen RAM for the space view
 STA ZP+1

 LDX #18                ; The space view is 18 character rows high, so set a row
                        ; counter in X

.LOOP11

 LDA #$70               ; Set A to the colour byte that we want to apply to the
                        ; border box, which is $70 to set the palette to
                        ; foreground colour 7 (yellow) and background colour 0
                        ; (black)

 LDY #36                ; Set the colour data for column 36 (i.e. the right edge
 STA (ZP),Y             ; of the border box) to the yellow/black palette

 LDY #3                 ; Set the colour data for column 3 (i.e. the left edge
 STA (ZP),Y             ; of the border box) to the yellow/black palette

                        ; Next, we set the palette to black on black for the
                        ; outside three character blocks on the left side of the
                        ; screen, so they don't show anything at all

 DEY                    ; Set Y = 2 to use as a column counter for the three
                        ; character blocks, so we work our way through columns
                        ; 2, 1 and 0

 LDA #$00               ; Set A to the colour byte that we want to apply to the
                        ; outer border area, which is $00 to set the palette to
                        ; foreground colour 0 (black) and background colour 0
                        ; (black)

.newtl

 STA (ZP),Y             ; Set the colour data for column Y to the black/black
                        ; palette

 DEY                    ; Decrement the column counter

 BPL newtl              ; Loop back until we have set all three character blocks
                        ; on the left edge of this character row to the
                        ; black/black palette

                        ; And now we set the palette to black on black for the
                        ; outside three character blocks on the right side of
                        ; the screen, so they also show nothing

 LDY #37                ; Set Y = 2 to use as a column counter for the three
                        ; character blocks, so we work our way through columns
                        ; 37, 38 and 39

 STA (ZP),Y             ; Set the colour data for column 37 to the black/black
                        ; palette

 INY                    ; Set the colour data for column 38 to the black/black
 STA (ZP),Y             ; palette

 INY                    ; Set the colour data for column 39 to the black/black
 STA (ZP),Y             ; palette

 LDA ZP                 ; Set ZP(1 0) = ZP(1 0) + 40
 CLC                    ;
 ADC #40                ; So ZP(1 0) points to the next character row in screen
 STA ZP                 ; RAM (as there are 40 character blocks on each row)
 BCC P%+4
 INC ZP+1

 DEX                    ; Decrement the row counter in X

 BNE LOOP11             ; Loop back until we have set the colour data for the
                        ; left and right border box edges in the space view

                        ; Finally, we set the colour data for the bottom row in
                        ; the text view, so the bottom of the border box is also
                        ; shown in yellow

 LDA #$70               ; Set A to the colour byte that we want to apply to the
                        ; border box, which is $70 to set the palette to
                        ; foreground colour 7 (yellow) and background colour 0
                        ; (black)

 LDY #31                ; Set a counter in Y to work through the 31 character
                        ; columns in the text view

.LOOP16

 STA $63C4,Y            ; Set the colour data for column Y + 4 on row 24 to
                        ; yellow on black
                        ;
                        ; The address breaks down as follows:
                        ;
                        ;   $63C4 = $6000 + 24 * 40 + 4
                        ;
                        ; So $63C4 + Y is column Y + 4 on row 24 and this loop
                        ; sets the colour for the bottom character row of the
                        ; text view

 DEY                    ; Decrement the column counter

 BPL LOOP16             ; Loop back until we have set the colour for the bottom
                        ; border box in the text view

; ******************************************************************************
;
;       Name: Elite loader (Part 6 of 7)
;       Type: Subroutine
;   Category: Loader
;    Summary: Copy colour data into colour RAM and configure more screen RAM
;  Deep dive: Colouring the Commodore 64 bitmap screen
;
; ******************************************************************************

                        ; First we reset the contents of colour RAM, which we
                        ; use to determine the colour of the dashboard (along
                        ; with the space view's screen RAM, which we already
                        ; set up in part 5)

 LDA #0                 ; Set A = 0, so we can use this to zero the contents of
                        ; colour RAM

 STA ZP                 ; Zero the low byte of ZP(1 0)

 TAY                    ; Set Y = 0 to use as a byte counter in the following
                        ; loop

 LDX #HI(COLMEM)        ; Set ZP(1 0) = COLMEM
 STX ZP+1               ;
                        ; So ZP(1 0) points to colour RAM at COLMEM ($D800)

 LDX #4                 ; Set X = 4 so we zero all four pages of colour RAM

.LOOP19

 STA (ZP),Y             ; Zero the Y-th byte of colour RAM at SC(1 0)

 INY                    ; Increment the byte counter

 BNE LOOP19             ; Loop back until we have zeroed a whole page of
                        ; colour RAM

 INC ZP+1               ; Increment the high byte of ZP(1 0) to point to the
                        ; next page to zero

 DEX                    ; Decrement the page counter in X

 BNE LOOP19             ; Loop back until we have zeroed all four pages from
                        ; COLMEM to COLMEM + $3FF ($D800 to $DBFF)

 LDA #LO(COLMEM+$2D0)   ; Set ZP(1 0) to the address within the space view's
 STA ZP                 ; colour RAM that corresponds to the dashboard (i.e.
 LDA #HI(COLMEM+$2D0)   ; offset $2D0 within the colour RAM at COLMEM, or $DAD0)
 STA ZP+1

 LDA #LO(cdump)         ; Set (A ZP2) = cdump
 STA ZP2
 LDA #HI(cdump)

 JSR mvsm               ; Call mvsm to copy 280 bytes of data from cdump to the
                        ; dashboard's colour RAM for the space view, so this
                        ; sets the correct colour data for the dashboard (along
                        ; with the data that we already copied into screen RAM
                        ; in part 5)

                        ; Finally, we set the top row of colour RAM to yellow,
                        ; so the top of the border box in the space view is
                        ; shown in the correct colour in the event of the raster
                        ; interrupt firing slightly late
                        ;
                        ; To ensure we don't get a flicker effect on the top row
                        ; of the screen, we set colour RAM for the top row to
                        ; $07, which sets colour %11 in the multicolour bitmap
                        ; mode to colour 7 (yellow)
                        ;
                        ; The top border is drawn with bytes of %11111111, which
                        ; maps to pixels of colour %11, so this ensures that if
                        ; the switch to standard bitmap mode at the top of the
                        ; screen is delayed (by non-maskable interrupts, for
                        ; example), the VIC will fetch the colour of the top
                        ; border box from colour RAM, so the colour will still
                        ; be correct

 LDY #34                ; Set Y to a character counter so we set colour RAM for
                        ; characters 3 to 36 on the top row

 LDA #$07               ; Set the low nibble of A to colour 7 (yellow), as this
                        ; is where multicolour bitmap mode gets the palette for
                        ; colour %11

.LOOP15

 STA COLMEM+2,Y         ; Set the palette to yellow for character Y

 DEY                    ; Decrement the counter in Y

 BNE LOOP15             ; Loop back until we have set the correct colour for the
                        ; whole top row of the space view

; ******************************************************************************
;
;       Name: Elite loader (Part 7 of 7)
;       Type: Subroutine
;   Category: Loader
;    Summary: Set up the sprite pointers, make a copy of the dashboard bitmap in
;             DSTORE% and copy the sprite definitions to SPRITELOC%
;  Deep dive: Sprite usage in Commodore 64 Elite
;
; ******************************************************************************

                        ; We now set the sprite pointers to point to the sprite
                        ; definitions (the sprites themselves are defined in
                        ; elite-sprite.asm)

 LDA #SPOFF%            ; The first sprite definition at offset SPOFF% contains
                        ; the sights for the pulse laser, so we start by setting
                        ; Y to the sprite pointer for the first sprite, which is
                        ; for the pulse laser (the sprites are defined in
                        ; elite-sprite.asm)

 STA $63F8              ; Set the pointer for sprite 0 in the text view to A
                        ;
                        ; The sprite pointer for sprite 0 is at $63F8 for the
                        ; text view because screen RAM for the text view is
                        ; at $6000 to $63FF, and the sprite pointers always
                        ; live in the last eight bytes of screen RAM, so that's
                        ; from $63F8 to $63FF for sprites 0 to 7

 STA $67F8              ; Set the pointer for sprite 0 in the space view to A
                        ;
                        ; The sprite pointer for sprite 0 is at $67F8 for the
                        ; space view because screen RAM for the space view is
                        ; at $6400 to $67FF, and the sprite pointers always
                        ; live in the last eight bytes of screen RAM, so that's
                        ; from $67F8 to $67FF for sprites 0 to 7

                        ; Next we set the sprite pointer for the explosion
                        ; sprite in sprite 1

 LDA #SPOFF%+4          ; There are four laser sight sprite definitions, so to
                        ; get the offset of the fifth sprite definition, for
                        ; the explosion sprite, we need to set A to the sprite
                        ; offset plus 4 (as each increment in the pointer adds
                        ; 64 bytes to the address, or one sprite definition)

 STA $63F9              ; Set the pointer for sprite 1 in the text view to A

 STA $67F9              ; Set the pointer for sprite 1 in the space view to A

                        ; Next we set the sprite pointers for the Trumbles in
                        ; sprites 2, 4 and 6, so they all look to the right

 LDA #SPOFF%+5          ; Set A to the sprite pointer for the sixth sprite
                        ; definition (i.e. the first Trumble sprite, which
                        ; looks to the right)

 STA $63FA              ; Set the pointer for sprite 2 in the text view to A

 STA $67FA              ; Set the pointer for sprite 2 in the space view to A

 STA $63FC              ; Set the pointer for sprite 4 in the text view to A

 STA $67FC              ; Set the pointer for sprite 4 in the space view to A

 STA $63FE              ; Set the pointer for sprite 6 in the text view to A

 STA $67FE              ; Set the pointer for sprite 6 in the space view to A

                        ; And finally we set the sprite pointers for Trumble
                        ; sprites 3, 5 and 7, so they all look to the left

 LDA #SPOFF%+6          ; Set A to the sprite pointer for the seventh sprite
                        ; definition (i.e. the second Trumble sprite, which
                        ; looks to the left)

 STA $63FB              ; Set the pointer for sprite 3 in the text view to A

 STA $67FB              ; Set the pointer for sprite 3 in the space view to A

 STA $63FD              ; Set the pointer for sprite 5 in the text view to A

 STA $67FD              ; Set the pointer for sprite 5 in the space view to A

 STA $63FF              ; Set the pointer for sprite 7 in the text view to A

 STA $67FF              ; Set the pointer for sprite 7 in the space view to A

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

 CLI                    ; Allow interrupts again

 LDX #9                 ; Set X = $16 so we copy 9 pages of data from DIALS
                        ; into DSTORE%

 LDA #LO(DSTORE%)       ; Set ZP(1 0) = DSTORE%
 STA ZP
 LDA #HI(DSTORE%)
 STA ZP+1

 LDA #LO(DIALS)         ; Set (A ZP2) = DIALS
 STA ZP2
 LDA #HI(DIALS)

 JSR mvblock            ; Call mvblock to copy 9 pages of data from DIALS to
                        ; DSTORE%, so this makes a copy of the dashboard bitmap
                        ; that can be poked into screen memory when the
                        ; dashboard needs to be redrawn (when changing from a
                        ; text view to the space view, for example)

 LDY #0                 ; Finally, we copy two pages of sprite definitions from
                        ; spritp to SPRITELOC%, which is where the game expects
                        ; to find them

.LOOP12

 LDA spritp,Y           ; Copy the Y-th byte of the sprite definitions at spritp
 STA SPRITELOC%,Y       ; to the Y-th byte of SPRITELOC%

 DEY                    ; Decrement the byte counter

 BNE LOOP12             ; Loop back until we have copied a whole page of bytes

.LOOP13

 LDA spritp+$100,Y      ; Copy the Y-th byte of the second page of sprite
 STA SPRITELOC%+$100,Y  ; definitions at spritp + $100 into SPRITELOC%

 DEY                    ; Decrement the byte counter

 BNE LOOP13             ; Loop back until we have copied a second page of bytes

 JMP $CE0E              ; This loader was originally run from the GMA1 disk
                        ; loader, which set a return address in $CE0E before
                        ; running the above
                        ;
                        ; This therefore returns us to the GMA1 loader, so it
                        ; can load the game binary and finally run the game

; ******************************************************************************
;
;       Name: mvblock
;       Type: Subroutine
;   Category: Loader
;    Summary: Copy a number of pages in memory
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   (A ZP2)             The source address
;
;   ZP(1 0)             The destination address
;
;   X                   The number of pages to copy
;
; ******************************************************************************

.mvblock

 STA ZP2+1              ; Set ZP2(1 0) = (A ZP2)

 LDY #0                 ; Set Y = 0 to count through the bytes in each page

.LOOP5

 LDA (ZP2),Y            ; Copy the Y-th byte of ZP2(1 0) to the Y-th byte of
 STA (ZP),Y             ; ZP(1 0)

 DEY                    ; Decrement the byte counter to point to the next byte

 BNE LOOP5              ; Loop back to LOOP5 until we have copied a whole page

 INC ZP2+1              ; Increment the high byte of ZP2(1 0) to point to the
                        ; next page to copy from

 INC ZP+1               ; Increment the high byte of ZP(1 0) to point to the
                        ; next page to copy into

 DEX                    ; Decrement the page counter in X

 BNE LOOP5              ; Loop back to copy the next page until we have copied
                        ; all of them

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: mvsm
;       Type: Subroutine
;   Category: Loader
;    Summary: Copy 280 bytes in memory
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   (A ZP2)             The source address
;
;   ZP(1 0)             The destination address
;
; ******************************************************************************

.mvsm

 LDX #1                 ; Set X = 1 to pass to mvblock so it copies one page of
                        ; data

 JSR mvblock            ; Call mvblock to copy 1 page of data (256 bytes) from
                        ; (A ZP2) to ZP(1 0)

 LDY #23                ; We now want to copy the next 24 bytes to give a total
                        ; of 280 bytes (as 256 + 24 = 280), so set a byte
                        ; counter in Y

 LDX #1                 ; Set X = 1 (though this has no effect, so this is
                        ; presumably left over from development)

.LOOP5new

 LDA (ZP2),Y            ; Copy the Y-th byte of ZP2(1 0) to the Y-th byte of
 STA (ZP),Y             ; ZP(1 0)

 DEY                    ; Decrement the byte counter to point to the next byte

 BPL LOOP5new           ; Loop back to LOOP5new until we have copied all
                        ; 24 bytes

 LDX #0                 ; Set X = 0

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: sdump
;       Type: Variable
;   Category: Drawing the screen
;    Summary: Screen RAM colour data for the dashboard
;  Deep dive: Colouring the Commodore 64 bitmap screen
;
; ------------------------------------------------------------------------------
;
; The sdump and cdump variables contain screen and colour RAM that sets the
; default colours for the dashboard.
;
; ******************************************************************************

.sdump

 EQUB $00, $00, $00, $07, $17, $17, $74, $74
 EQUB $74, $74, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $67, $27, $27, $27
 EQUB $27, $27, $37, $37, $07, $00, $00, $00
 EQUB $00, $00, $00, $07, $17, $17, $24, $24
 EQUB $24, $24, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $67, $67, $67, $67, $23, $23
 EQUB $23, $23, $37, $37, $07, $00, $00, $00
 EQUB $00, $00, $00, $07, $37, $37, $29, $29
 EQUB $29, $29, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $67, $27, $23, $23
 EQUB $23, $23, $37, $37, $07, $00, $00, $00
 EQUB $00, $00, $00, $07, $37, $37, $28, $28
 EQUB $28, $28, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $24, $24
 EQUB $24, $24, $17, $17, $07, $00, $00, $00
 EQUB $00, $00, $00, $07, $37, $37, $2A, $2A
 EQUB $2A, $2A, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $24, $24
 EQUB $24, $24, $17, $17, $07, $00, $00, $00
 EQUB $00, $00, $00, $07, $37, $37, $2D, $2D
 EQUB $2D, $2D, $27, $07, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $07, $27, $24, $24
 EQUB $24, $24, $17, $17, $07, $00, $00, $00
 EQUB $00, $00, $00, $07, $C7, $C7, $07, $07
 EQUB $07, $07, $27, $07, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $27, $27, $27, $27
 EQUB $27, $27, $27, $27, $07, $27, $24, $24
 EQUB $24, $24, $17, $17, $07, $00, $00, $00

IF _GMA_RELEASE

 EQUB $60, $D3          ; These bytes appear to be unused and just contain
 EQUB $66, $1D          ; random workspace noise left over from the BBC Micro
 EQUB $A0, $40          ; assembly process
 EQUB $B3, $D3

ELIF _SOURCE_DISK_BUILD

 EQUB $B4, $48          ; These bytes appear to be unused and just contain
 EQUB $9F, $CD          ; random workspace noise left over from the BBC Micro
 EQUB $EA, $11          ; assembly process
 EQUB $F1, $19

ELIF _SOURCE_DISK_FILES

 EQUB $99, $02          ; These bytes appear to be unused and just contain
 EQUB $E5, $6B          ; random workspace noise left over from the BBC Micro
 EQUB $26, $B9          ; assembly process
 EQUB $37, $D7

ENDIF

; ******************************************************************************
;
;       Name: cdump
;       Type: Variable
;   Category: Drawing the screen
;    Summary: Colour RAM colour data for the dashboard
;  Deep dive: Colouring the Commodore 64 bitmap screen
;
; ------------------------------------------------------------------------------
;
; The sdump and cdump variables contain screen and colour RAM that sets the
; default colours for the dashboard.
;
; ******************************************************************************

.cdump

 EQUB $00, $00, $00, $00, $05, $05, $05, $05
 EQUB $05, $05, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $05, $05, $05, $05, $05, $05
 EQUB $05, $05, $05, $05, $00, $00, $00, $00
 EQUB $00, $00, $00, $00, $05, $05, $05, $05
 EQUB $05, $05, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $05, $05, $05, $05, $05, $05
 EQUB $05, $05, $05, $05, $00, $00, $00, $00
 EQUB $00, $00, $00, $00, $05, $05, $05, $05
 EQUB $05, $05, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $05, $05, $05, $05, $05, $05
 EQUB $05, $05, $05, $05, $00, $00, $00, $00
 EQUB $00, $00, $00, $00, $05, $05, $05, $05
 EQUB $05, $05, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $05, $05, $05, $05, $05
 EQUB $05, $05, $05, $05, $00, $00, $00, $00
 EQUB $00, $00, $00, $00, $05, $05, $05, $05
 EQUB $05, $05, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $05, $05
 EQUB $05, $05, $05, $05, $00, $00, $00, $00
 EQUB $00, $00, $00, $00, $05, $05, $05, $05
 EQUB $05, $05, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $05, $05
 EQUB $05, $05, $05, $05, $00, $00, $00, $00
 EQUB $00, $00, $00, $00, $0F, $0F, $07, $07
 EQUB $07, $07, $0D, $0D, $0D, $0D, $0D, $0D
 EQUB $0D, $03, $03, $03, $03, $03, $0D, $0D
 EQUB $0D, $0D, $0D, $0D, $0D, $0D, $07, $07
 EQUB $07, $07, $05, $05, $00, $00, $00, $00

IF _GMA_RELEASE

 EQUB $8D, $18          ; These bytes appear to be unused and just contain
 EQUB $8F, $50          ; random workspace noise left over from the BBC Micro
 EQUB $46, $7E          ; assembly process
 EQUB $A4, $F4

ELIF _SOURCE_DISK_BUILD

 EQUB $B3, $56          ; These bytes appear to be unused and just contain
 EQUB $2B, $6B          ; random workspace noise left over from the BBC Micro
 EQUB $74, $D4          ; assembly process
 EQUB $D8, $FF

ELIF _SOURCE_DISK_FILES

 EQUB $00, $FB          ; These bytes appear to be unused and just contain
 EQUB $0E, $F3          ; random workspace noise left over from the BBC Micro
 EQUB $79, $7D          ; assembly process
 EQUB $48, $96

ENDIF

; ******************************************************************************
;
;       Name: spritp
;       Type: Variable
;   Category: Drawing the screen
;    Summary: Sprite definitions
;
; ******************************************************************************

.spritp

 INCBIN "3-assembled-output/SPRITE.bin"

IF _GMA_RELEASE

 EQUB $38, $35, $25, $67, $FA, $B5, $A5, $A2    ; These bytes appear to be
 EQUB $22, $C1, $DF, $EB, $77, $CE, $F4, $07    ; unused and just contain random
 EQUB $37, $CF, $33, $4D, $A5, $89, $76, $CD    ; workspace noise left over from
 EQUB $6D, $69, $8D, $56, $CD, $94, $98, $F6    ; the BBC Micro assembly process
 EQUB $B8, $CE, $14, $13, $D1, $98, $CE, $B1
 EQUB $77, $CE, $F4, $1C, $B1, $40, $68, $30
 EQUB $87, $CD, $A9, $90, $B2, $08, $C1, $DB
 EQUB $CF, $33, $49, $80, $6B, $CA, $3A, $CF

ELIF _SOURCE_DISK_BUILD

 EQUB $97, $F3, $4F, $73, $B6, $DB, $39, $7A    ; These bytes appear to be
 EQUB $56, $EE, $F5, $D3, $4F, $E4, $C4, $F5    ; unused and just contain random
 EQUB $FE, $05, $D3, $4F, $68, $91, $3E, $F9    ; workspace noise left over from
 EQUB $00, $D3, $4F, $27, $53, $41, $F6, $FD    ; the BBC Micro assembly process
 EQUB $D6, $26, $CB, $24, $C5, $ED, $14, $3C
 EQUB $E9, $F0, $D3, $4F, $62, $8E, $41, $F1
 EQUB $F8, $D3, $4F, $30, $5F, $44, $05, $0C
 EQUB $D3, $4F, $68, $99, $A1, $CB, $B7, $34

ELIF _SOURCE_DISK_FILES

 EQUB $DC, $80, $1F, $87, $29, $80, $80, $E3    ; These bytes appear to be
 EQUB $8A, $42, $CE, $41, $9D, $20, $CB, $DC    ; unused and just contain random
 EQUB $44, $E3, $C8, $22, $33, $A8, $B9, $F3    ; workspace noise left over from
 EQUB $03, $D8, $22, $B7, $F9, $CF, $37, $F9    ; the BBC Micro assembly process
 EQUB $D3, $22, $76, $7A, $94, $37, $F3, $D3
 EQUB $FC, $F1, $EF, $E9, $B2, $01, $50, $25
 EQUB $D9, $C3, $22, $B1, $F0, $CF, $32, $E9
 EQUB $CB, $22, $7F, $8F, $A3, $49, $11, $48

ENDIF

; ******************************************************************************
;
;       Name: date
;       Type: Variable
;   Category: Loader
;    Summary: A date image that is included into the source disk binaries (this
;             is just random noise in the released game)
;
; ******************************************************************************

.date

IF _SOURCE_DISK

 INCBIN "1-source-files/images/C.DATE4.bin"

ELIF _GMA_RELEASE

 EQUB $33, $8D, $49, $EA, $53, $29, $2C, $2F    ; These bytes appear to be
 EQUB $87, $C4, $A0, $70, $96, $90, $B3, $38    ; unused and just contain random
 EQUB $B9, $53, $9A, $91, $AE, $2E, $70, $F8    ; workspace noise left over from
 EQUB $C8, $1B, $7C, $A1, $D1, $37, $2B, $4C    ; the BBC Micro assembly process
 EQUB $97, $F3, $4F, $73, $AD, $D2, $39, $71    ;
 EQUB $4D, $EE, $F5, $D3, $4F, $E7, $C7, $F5    ; They contain part of the
 EQUB $FE, $05, $D3, $4F, $68, $88, $35, $F9    ; encrypted HICODE binary, from
 EQUB $00, $D3, $4F, $27, $4A, $38, $F6, $FD    ; file offset $1C8A to $1D89,
 EQUB $D6, $26, $CB, $1B, $BC, $ED, $0B, $33    ; from when it was assembled in
 EQUB $E9, $F0, $D3, $4F, $62, $85, $38, $F1    ; memory
 EQUB $F8, $D3, $4F, $30, $56, $3B, $05, $0C
 EQUB $D3, $4F, $68, $90, $98, $CB, $B7, $34
 EQUB $ED, $01, $08, $D3, $4F, $07, $2F, $3D
 EQUB $D1, $D8, $D3, $4F, $62, $83, $36, $DB
 EQUB $E2, $DB, $2B, $07, $71, $1A, $93, $4F
 EQUB $F8, $34, $D4, $33, $6F, $51, $CE, $D5
 EQUB $EA, $66, $8D, $AF, $37, $04, $2B, $FE
 EQUB $D7, $03, $2A, $F7, $D0, $06, $0D, $DB
 EQUB $AD, $A5, $2F, $CE, $A4, $2E, $CE, $A3
 EQUB $4D, $06, $60, $D2, $5B, $BC, $9D, $13
 EQUB $4F, $A8, $CD, $3A, $F7, $1E, $3E, $17
 EQUB $F4, $FB, $DD, $B2, $4C, $97, $35, $EA
 EQUB $45, $C9, $E9, $B0, $2F, $8B, $12, $F7
 EQUB $B6, $8B, $AB, $45, $C9, $E9, $B0, $06
 EQUB $BB, $0B, $36, $E2, $B7, $AB, $CF, $E3
 EQUB $EA, $D9, $29, $A2, $F1, $8F, $B5, $D3
 EQUB $8A, $CE, $F1, $8F, $75, $C4, $14, $0B
 EQUB $56, $0A, $E0, $2B, $35, $E6, $BC, $0C
 EQUB $30, $EA, $44, $96, $1B, $AE, $8A, $EA
 EQUB $0B, $0C, $86, $44, $96, $38, $2C, $36
 EQUB $D3, $4F, $29, $50, $D3, $05, $45, $C9
 EQUB $E9, $B0, $E9, $19, $B5, $0B, $FB, $B9

ENDIF

; ******************************************************************************
;
;       Name: DIALS
;       Type: Variable
;   Category: Drawing the screen
;    Summary: The dashboard bitmap and colour data for screen RAM
;
; ******************************************************************************

.DIALS

 SKIP 24                ; This indents the image by three character blocks to
                        ; skip past the first three characters of the left
                        ; screen margin (the fourth character contains the
                        ; border box along the edge of the dashboard)

 INCBIN "1-source-files/images/C.CODIALS.bin"

IF _GMA_RELEASE

 EQUB $F5               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $B2               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_FILES

 EQUB $DB               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ENDIF

; ******************************************************************************
;
;       Name: V%
;       Type: Variable
;   Category: Utility routines
;    Summary: Denotes the end of the second block of loader code, as used in the
;             encryption/decryption process
;
; ******************************************************************************

.V%

 SKIP 0

; ******************************************************************************
;
; Save COMLOD.unprot.bin
;
; ******************************************************************************

 PRINT "P% = ", ~P%
 PRINT "S.C.COMLOD ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "3-assembled-output/COMLOD.unprot.bin", CODE%, P%, LOAD%

 PRINT "Addresses for the scramble routines in elite-checksum.py"
 PRINT "W% = ", ~W%
 PRINT "X% = ", ~X%
 PRINT "U% = ", ~U%
 PRINT "V% = ", ~V%
