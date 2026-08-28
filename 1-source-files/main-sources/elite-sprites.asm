; ******************************************************************************
;
; COMMODORE 64 ELITE SPRITES SOURCE
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
; This source file contains sprite definitions for Commodore 64 Elite.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
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

 CODE% = $7C3A          ; The address where the code will be run

 LOAD% = $7C3A          ; The address where the code will be loaded

; ******************************************************************************
;
; ELITE SPRITES
;
; ******************************************************************************

 ORG CODE%              ; Set the assembly address to CODE%

; ******************************************************************************
;
;       Name: SPRITE2
;       Type: Macro
;   Category: Sprites
;    Summary: Macro definition for a two-colour sprite pixel row
;
; ------------------------------------------------------------------------------
;
; This macro inserts three bytes of a two-colour sprite pixel row, with eight
; pixels per byte (i.e. eight pixels per character block).
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   pixel_row           A string containing a row of 24 pixels, where each pixel
;                       is defined as follows:
;
;                         * X denotes colour 1
;
;                         * Anything else denotes colour 0
;
; ******************************************************************************

MACRO SPRITE2 pixel_row

 SPRITE2_BYTE MID$(pixel_row, 1, 8)
 SPRITE2_BYTE MID$(pixel_row, 9, 8)
 SPRITE2_BYTE MID$(pixel_row, 17, 8)

ENDMACRO

; ******************************************************************************
;
;       Name: SPRITE2_BYTE
;       Type: Macro
;   Category: Sprites
;    Summary: Macro definition for a two-colour sprite pixel byte
;
; ------------------------------------------------------------------------------
;
; This macro inserts one byte of a two-colour sprite pixel row, with eight
; pixels per byte (i.e. eight pixels per character block).
;
; In BeebAsm, true statements evaluate to -1 while false statements evaluate to
; 0 (just as in BBC BASIC), so this statement:
;
;   bit7 = -(ASC(MID$(pixel_byte, 1, 1)) = ASC("X")) << 7
;
; does the same as this longer statement:
;
;   IF ASC(MID$(pixel_byte, 1, 1)) = ASC("X")
;    bit7 = 1 << 7
;   ELSE
;    bit7 = 0
;   ENDIF
;
; In other words, bit7 gets set to 1 << 7 (i.e. %10000000) if character 1 of
; pixel_byte is "X", otherwise it gets set to 0.
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   pixel_byte          A string containing a row of 8 pixels, where each pixel
;                       is defined as follows:
;
;                         * "X" denotes colour 1
;
;                         * Anything else (e.g. "." or "+") denotes colour 0
;
; ******************************************************************************

MACRO SPRITE2_BYTE pixel_byte

 bit7 = -(ASC(MID$(pixel_byte, 1, 1)) = ASC("X")) << 7
 bit6 = -(ASC(MID$(pixel_byte, 2, 1)) = ASC("X")) << 6
 bit5 = -(ASC(MID$(pixel_byte, 3, 1)) = ASC("X")) << 5
 bit4 = -(ASC(MID$(pixel_byte, 4, 1)) = ASC("X")) << 4
 bit3 = -(ASC(MID$(pixel_byte, 5, 1)) = ASC("X")) << 3
 bit2 = -(ASC(MID$(pixel_byte, 6, 1)) = ASC("X")) << 2
 bit1 = -(ASC(MID$(pixel_byte, 7, 1)) = ASC("X")) << 1
 bit0 = -(ASC(MID$(pixel_byte, 8, 1)) = ASC("X")) << 0

 EQUB bit7 + bit6 + bit5 + bit4 + bit3 + bit2 + bit1 + bit0

ENDMACRO

; ******************************************************************************
;
;       Name: SPRITE4
;       Type: Macro
;   Category: Sprites
;    Summary: Macro definition for a four-colour sprite pixel row
;
; ------------------------------------------------------------------------------
;
; This macro inserts three bytes of a four-colour sprite pixel row, with four
; pixels per byte (i.e. four pixels per character block).
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   pixel_row           A string containing a row of 12 pixels, where each pixel
;                       is defined as follows:
;
;                         * "/" denotes colour 1
;
;                         * "*" denotes colour 2
;
;                         * "@" denotes colour 3
;
;                         * Anything else (e.g. ".") denotes colour 0
;
; ******************************************************************************

MACRO SPRITE4 pixel_row

 SPRITE4_BYTE MID$(pixel_row, 1, 4)
 SPRITE4_BYTE MID$(pixel_row, 5, 4)
 SPRITE4_BYTE MID$(pixel_row, 9, 4)

ENDMACRO

; ******************************************************************************
;
;       Name: SPRITE4_BYTE
;       Type: Macro
;   Category: Sprites
;    Summary: Macro definition for a four-colour sprite pixel byte
;
; ------------------------------------------------------------------------------
;
; This macro inserts one byte of a four-colour sprite pixel row, with four
; pixels per byte (i.e. four pixels per character block).
;
; In BeebAsm, true statements evaluate to -1 while false statements evaluate to
; 0 (just as in BBC BASIC), so this statement:
;
;   bit67_1 = (%01 * -(ASC(MID$(pixel_byte, 1, 1)) = ASC("/"))) << 6
;
; does the same as this longer statement:
;
;   IF ASC(MID$(pixel_byte, 1, 1)) = ASC("/")
;    bit67_1 = %01 << 6
;   ELSE
;    bit67_1 = 0
;   ENDIF
;
; In other words, bit67_1 gets set to %01 << 6 (i.e. %01000000) if character 1
; of pixel_byte is "/", otherwise it gets set to 0.
;
; ------------------------------------------------------------------------------
;
; Arguments:
;
;   pixel_byte          A string containing a row of 4 pixels, where each pixel
;                       is defined as follows:
;
;                         * "/" denotes colour 1
;
;                         * "*" denotes colour 2
;
;                         * "@" denotes colour 3
;
;                         * Anything else (e.g. ".") denotes colour 0
;
; ******************************************************************************

MACRO SPRITE4_BYTE pixel_byte

 bit67_1 = (%01 * -(ASC(MID$(pixel_byte, 1, 1)) = ASC("/"))) << 6
 bit67_2 = (%10 * -(ASC(MID$(pixel_byte, 1, 1)) = ASC("*"))) << 6
 bit67_3 = (%11 * -(ASC(MID$(pixel_byte, 1, 1)) = ASC("@"))) << 6

 bit45_1 = (%01 * -(ASC(MID$(pixel_byte, 2, 1)) = ASC("/"))) << 4
 bit45_2 = (%10 * -(ASC(MID$(pixel_byte, 2, 1)) = ASC("*"))) << 4
 bit45_3 = (%11 * -(ASC(MID$(pixel_byte, 2, 1)) = ASC("@"))) << 4

 bit23_1 = (%01 * -(ASC(MID$(pixel_byte, 3, 1)) = ASC("/"))) << 2
 bit23_2 = (%10 * -(ASC(MID$(pixel_byte, 3, 1)) = ASC("*"))) << 2
 bit23_3 = (%11 * -(ASC(MID$(pixel_byte, 3, 1)) = ASC("@"))) << 2

 bit01_1 = (%01 * -(ASC(MID$(pixel_byte, 4, 1)) = ASC("/"))) << 0
 bit01_2 = (%10 * -(ASC(MID$(pixel_byte, 4, 1)) = ASC("*"))) << 0
 bit01_3 = (%11 * -(ASC(MID$(pixel_byte, 4, 1)) = ASC("@"))) << 0

 bit67 = bit67_1 + bit67_2 + bit67_3
 bit45 = bit45_1 + bit45_2 + bit45_3
 bit23 = bit23_1 + bit23_2 + bit23_3
 bit01 = bit01_1 + bit01_2 + bit01_3

 EQUB bit67 + bit45 + bit23 + bit01

ENDMACRO

; ******************************************************************************
;
;       Name: spritp
;       Type: Variable
;   Category: Sprites
;    Summary: Sprite definitions for four laser sights, the explosion sprite and
;             two Trumbles
;  Deep dive: Sprite usage in Commodore 64 Elite
;
; ******************************************************************************

.spritp

 SPRITE2 "........................"     ; The laser sights for a pulse laser
 SPRITE2 "........................"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "..XXXXX....+....XXXXX..."
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "........................"
 SPRITE2 "........................"

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 EQUB $3A               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $8C               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ENDIF

 SPRITE2 "........................"     ; The laser sights for a beam laser
 SPRITE2 "........................"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 ".....XXXXXXXXXXXXX......"
 SPRITE2 ".....X...........X......"
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "...........+............"
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 ".....X...........X......"
 SPRITE2 ".....XXXXXXXXXXXXX......"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "...........X............"
 SPRITE2 "........................"
 SPRITE2 "........................"

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 EQUB $31               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $02               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ENDIF

 SPRITE2 "........................"     ; The laser sights for a military laser
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "........XXXXXXX........."
 SPRITE2 ".........X...X.........."
 SPRITE2 "..........X.X..........."
 SPRITE2 "...........X............"
 SPRITE2 "..XX...............XX..."
 SPRITE2 "..X.X.............X.X..."
 SPRITE2 "..X..X...........X..X..."
 SPRITE2 "..X...X....+....X...X..."
 SPRITE2 "..X..X...........X..X..."
 SPRITE2 "..X.X.............X.X..."
 SPRITE2 "..XX...............XX..."
 SPRITE2 "...........X............"
 SPRITE2 "..........X.X..........."
 SPRITE2 ".........X...X.........."
 SPRITE2 "........XXXXXXX........."
 SPRITE2 "........................"
 SPRITE2 "........................"
 SPRITE2 "........................"

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 EQUB $45               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $9B               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ENDIF

 SPRITE2 "..XXXXXXXXXXXXXXXXXXX..."     ; The laser sights for a mining laser
 SPRITE2 "..X........X........X..."
 SPRITE2 "..X.......XXX.......X..."
 SPRITE2 "....X......X......X....."
 SPRITE2 "XX...X....XXX....X...XX."
 SPRITE2 "X.....X....X....X.....X."
 SPRITE2 "X......X..XXX..X......X."
 SPRITE2 "X..........X..........X."
 SPRITE2 "X........XXXXX........X."
 SPRITE2 "X.X..XX..X...X..XX..X.X."
 SPRITE2 "XXXXXX.....X.....XXXXXX."
 SPRITE2 "X.X..XX..X...X..XX..X.X."
 SPRITE2 "X........XXXXX........X."
 SPRITE2 "X..........X..........X."
 SPRITE2 "X......X..XXX..X......X."
 SPRITE2 "X.....X....X....X.....X."
 SPRITE2 "XX...X....XXX....X...XX."
 SPRITE2 "....X......X......X....."
 SPRITE2 "..X.......XXX.......X..."
 SPRITE2 "..X........X........X..."
 SPRITE2 "..XXXXXXXXXXXXXXXXXXX..."

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 EQUB $A3               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $A5               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ENDIF

 SPRITE2 "........................"     ; The explosion cloud sprite
 SPRITE2 ".........X....XX........"
 SPRITE2 "...X....XX..X...X......."
 SPRITE2 ".....X....XX...XXX......"
 SPRITE2 "...X..XX.....X..XX..X..."
 SPRITE2 "....X.....X.XX....X..X.."
 SPRITE2 ".X.XX..X..X.XX.XXX..XX.."
 SPRITE2 "...X..XX.X.X.XX...XXX..."
 SPRITE2 "XX..X.X..XX.XXX....X.XX."
 SPRITE2 "....XXX..XX.XX.XX...X.XX"
 SPRITE2 "..X.....XX.XX.XXX..XX..."
 SPRITE2 ".....XX.XX..X.XXX.XX...."
 SPRITE2 "..X...XXX.X.X..XX...X.X."
 SPRITE2 "X...XXX..XX.XX.XX...X.XX"
 SPRITE2 "...X..XX..X..X..XX..X..."
 SPRITE2 "..XX..XX..X.XX.XX..X.X.."
 SPRITE2 "....X....XX...XXX...X..."
 SPRITE2 "...XX........X....X....."
 SPRITE2 "...XX...XX....X.....XX.."
 SPRITE2 "........XX..X...X......."
 SPRITE2 ".............XX........."

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 EQUB $44               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $14               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ENDIF

 SPRITE4 ".....***...."     ; A Trumble looking to the right
 SPRITE4 "..*.*****..."
 SPRITE4 "..***/*/**.."
 SPRITE4 ".**********."
 SPRITE4 "..**********"
 SPRITE4 ".*/***/****."
 SPRITE4 "****/*******"
 SPRITE4 ".********/*."
 SPRITE4 "************"
 SPRITE4 "************"
 SPRITE4 ".**********."
 SPRITE4 "***@@***@@**"
 SPRITE4 "**@@@@*@@@@*"
 SPRITE4 "**@@*@*@@*@*"
 SPRITE4 "***@@***@@**"
 SPRITE4 ".**********."
 SPRITE4 "..********.."
 SPRITE4 "...******..."
 SPRITE4 "....*//*...."
 SPRITE4 ".....//....."
 SPRITE4 "............"

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 EQUB $44               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $18               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ENDIF

 SPRITE4 "............"     ; A Trumble looking to the left
 SPRITE4 "............"
 SPRITE4 "......**...."
 SPRITE4 "..**.****..."
 SPRITE4 ".*****/***.."
 SPRITE4 ".**********."
 SPRITE4 "****/******."
 SPRITE4 ".**********."
 SPRITE4 "************"
 SPRITE4 "************"
 SPRITE4 ".**********."
 SPRITE4 "***@@***@@**"
 SPRITE4 "**@@@@*@@@@*"
 SPRITE4 "**@*@@*@*@@*"
 SPRITE4 "***@@***@@**"
 SPRITE4 ".**********."
 SPRITE4 "..********.."
 SPRITE4 ".../****/..."
 SPRITE4 "....*//*...."
 SPRITE4 ".....//....."
 SPRITE4 "............"

IF _GMA_RELEASE OR _SOURCE_DISK_FILES

 EQUB $54               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ELIF _SOURCE_DISK_BUILD

 EQUB $02               ; This byte appears to be unused and just contains
                        ; random workspace noise left over from the BBC Micro
                        ; assembly process

ENDIF

; ******************************************************************************
;
; Save SPRITE.bin
;
; ******************************************************************************

 PRINT "P% = ", ~P%
 PRINT "S.C.SPRITE ", ~CODE%, " +1C0"
 SAVE "3-assembled-output/SPRITE.bin", CODE%, P%, LOAD%
