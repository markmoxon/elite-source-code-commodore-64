; ******************************************************************************
;
; COMMODORE 64 ELITE GMA3 DISK PROTECTION SOURCE
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
; This source file contains disk protection for Commodore 64 Elite. The disk
; protection code is disabled in this version of Elite, so it gets loaded but is
; not run.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
;   * gma3.bin
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

 CODE% = $C800          ; The address where the code will be run

 LOAD% = $C800          ; The address where the code will be loaded

; ******************************************************************************
;
; ELITE GMA3 LOADER
;
; ******************************************************************************

 ORG CODE% - 2          ; Add a two-byte PRG header to the start of the file
 EQUW LOAD%             ; that contains the load address

; ******************************************************************************
;
;       Name: LC800
;       Type: Subroutine
;   Category: Copy protection
;    Summary: A routine that implements disk protection (this is disabled in
;             this version of Elite)
;
; ******************************************************************************

.LC800

 LDA #$00
 STA $FB
 LDA #$03
 STA $FC

 LDA #LO(LC893)
 STA $FD
 LDA #HI(LC893)
 STA $FE

.LC810

 JSR LC873
 LDA #$57
 JSR $FFD2
 LDA $FB
 JSR $FFD2
 LDA $FC
 JSR $FFD2
 LDA #$20
 JSR $FFD2

 LDX #$20
 LDY #$00
 CLC
 LDA $FB
 ADC #$20
 STA $FB
 LDA #$00
 ADC $FC
 STA $FC

.LC838

 LDA ($FD),Y
 JSR $FFD2
 INC $FD
 BNE LC843
 INC $FE

.LC843

 DEX
 BNE LC838
 JSR $FFCC
 LDA $FB
 CMP #$8D
 LDA $FC
 SBC #$03
 BCC LC810
 JSR LC873
 LDA #$45
 JSR $FFD2
 LDA #$64
 JSR $FFD2
 LDA #$03
 JSR $FFD2
 JSR $FFCC

.LC868

 BIT $DD00
 BMI LC868

.LC86D

 BIT $DD00
 BPL LC86D
 RTS

; ******************************************************************************
;
;       Name: LC873
;       Type: Subroutine
;   Category: Copy protection
;    Summary: A routine that implements disk protection (this is disabled in
;             this version of Elite)
;
; ******************************************************************************

.LC873

 LDA #$00
 JSR $FFBD
 LDA #$0F
 TAY
 LDX #$08
 JSR $FFBA
 JSR $FFC0
 LDX #$0F
 JSR $FFC9

IF _GMA86_PAL

 LDA #$97
 STA $02

ENDIF

 LDA #$4D
 JSR $FFD2
 LDA #$2D
 JSR $FFD2
 RTS

; ******************************************************************************
;
;       Name: LC893
;       Type: Subroutine
;   Category: Copy protection
;    Summary: A routine that implements disk protection (this is disabled in
;             this version of Elite)
;
; ******************************************************************************

.LC893

 LDA #$0F
 STA $1800
 STA $1800
 LDA $1C00
 AND #$9F
 STA $1C00
 LDY #$5A

.LC8A5

 DEY
 BNE LC8AD
 LDA #$02
 JMP $F969

.LC8AD

 BIT $1C00
 BMI LC8AD
 LDA $1C01
 CLV
 LDX #$04

.LC8B8

 BVC LC8B8

 CLV
 LDA $1C01
 STA $0500,X
 DEX
 BPL LC8B8
 CMP #$69
 BNE LC8A5
 LDA $0501
 CMP #$A9
 BNE LC8A5

.LC8CF

 BIT $1C00
 BMI LC8CF
 CLV
 LDA $1C01
 LDX #$00

.LC8DA

 BVC LC8DA
 CLV
 LDA $1C01
 STA $0508,X
 INX
 BNE LC8DA

.LC8E6

 BVC LC8E6

 CLV
 LDA $1C01
 STA $0608,X
 INX
 BNE LC8E6
 LDA #$01
 JMP $F969
 JSR $D042
 LDA #$25
 STA $06
 LDA #$01
 STA $07
 JSR $C118
 LDA #$E0
 STA $00

.LC909

 LDA $00
 BMI LC909
 CMP #$02
 BCC LC917
 JMP $037E
 JSR $C12C

.LC917

 LDA #$00
 STA $1800
 STA $1800
 RTS

; ******************************************************************************
;
; Save gma3.bin
;
; ******************************************************************************

 SAVE "3-assembled-output/gma3.bin", CODE%-2, P%, LOAD%
