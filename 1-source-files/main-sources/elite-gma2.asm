; ******************************************************************************
;
; COMMODORE 64 ELITE GMA2 BYEBYEJULIE SOURCE
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
; This source file contains a disabled disk loader for Commodore 64 Elite. It is
; empty and is not used in this version of Elite.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
;   * byebyejulie.bin
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

 CODE% = $0801          ; The address where the code will be run

 LOAD% = $0801          ; The address where the code will be loaded

; ******************************************************************************
;
; ELITE GMA2 LOADER
;
; ******************************************************************************

 ORG CODE% - 2          ; Add a two-byte PRG header to the start of the file
 EQUW LOAD%             ; that contains the load address

 EQUW 0                 ; This file is empty bar a couple of null bytes
                        ;
                        ; Presumably it formed part of the loader at some point,
                        ; but was disabled
                        ;
                        ; The filename, byebyejulie, seems to confirm this

; ******************************************************************************
;
; Save byebyejulie.bin
;
; ******************************************************************************

 SAVE "3-assembled-output/byebyejulie.bin", CODE%-2, P%, LOAD%
