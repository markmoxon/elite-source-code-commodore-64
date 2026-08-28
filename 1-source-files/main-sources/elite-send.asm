; ******************************************************************************
;
; COMMODORE 64 ELITE PDS SEND SOURCE FILE
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
; This source file contains a *SEND utility that sends assembled binaries to a
; Commodore 64 that's attached to a BBC Micro.
;
; It forms part of the PDS (Programmers' Development System) that was used when
; developing Commodore 64 Elite on a BBC Micro.
;
; ------------------------------------------------------------------------------
;
; This source file produces the following binary file:
;
;   * SEND.bin
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

 CODE% = $1100          ; The address where the code will be run

 LOAD% = $1100          ; The address where the code will be loaded

 fileBuffer = $1500     ; The address of the file buffer where we can load the
                        ; file to be sent

 VIA = $FE00            ; Memory-mapped space for accessing internal hardware,
                        ; such as the video ULA, 6845 CRTC and 6522 VIAs (also
                        ; known as SHEILA)

 OSWRCH = $FFEE         ; The address for the OSWRCH routine

 OSASCI = $FFE3         ; The address for the OSASCI routine

 OSBYTE = $FFF4         ; The address for the OSBYTE routine

 OSWORD = $FFF1         ; The address for the OSWORD routine

 OSFILE = $FFDD         ; The address for the OSFILE routine

 OSCLI = $FFF7          ; The address for the OSCLI routine

; ******************************************************************************
;
; ELITE PDS SEND
;
; ******************************************************************************

 ORG CODE%              ; Set the assembly address to CODE%

; ******************************************************************************
;
;       Name: SendFile
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Ask for a file's details and send it to a connected Apple II
;
; ******************************************************************************

.SendFile

 JSR PrintInlineString  ; Print the following null-terminated inline string and
                        ; continue execution after the null terminator

 EQUB 13
 EQUS "File to transmit : "
 EQUB 0

 LDA #0                 ; Call OSWORD with A = 0 to read a line from the current
 LDX #LO(filenameBlock) ; input stream (i.e. the keyboard) and store it in the
 LDY #HI(filenameBlock) ; first two bytes of the OSWORD blobk at filenameBlock
 JSR OSWORD

 BCC LoadFile           ; The C flag will be set if we pressed ESCAPE when
                        ; entering the name, so this jumps to LoadFile if ESCAPE
                        ; was not pressed

 LDA #126               ; Otherwise call OSBYTE with A = 126 to acknowledge the
 JSR OSBYTE             ; escape condition

 JMP SendFile           ; Loop back to SendFile to fetch another filename

; ******************************************************************************
;
;       Name: SetRegisters
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Set the registers before returning to SendFile
;
; ******************************************************************************

.SetRegisters

 LDX $F4                ; These instructions have no effect, as we only call
 LDY $03A3              ; SetRegisters before returning to the SendFile routine,
 LDA #0                 ; after the BCC LoadFile branch instruction, at which
                        ; point A is overwritten, Y is corrupted by OSBYTE and
                        ; X is ignored

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: PrintInlineString
;       Type: Subroutine
;   Category: Text
;    Summary: Print the null-terminated string that follows the function call
;             and continue execution from after the inline string
;
; ******************************************************************************

.PrintInlineString

 PLA                    ; Pull the return address from the stack and store it in
 STA $F8                ; ($F9 $F8), as it points to the instruction after the
 PLA                    ; JSR PrintInlineString instruction (so it points to the
 STA $F9                ; inline string we want to print)

 TYA                    ; Store Y on the stack so we can preserve it across the
 PHA                    ; call to PrintInlineString

 LDY #0                 ; Set Y = 0 to use in the following, so we can implement
                        ; an LDA ($F8) instruction using LDA ($F8),Y (as Y stays
                        ; at zero throughout

 JSR IncrementPointer   ; Increment the address in ($F9 $F8)

.prin1

 LDA ($F8),Y            ; Fetch the next character from ($F9 $F8), so we work
                        ; along the string to print

 JSR IncrementPointer   ; Increment the address in ($F9 $F8) to point to the
                        ; next character (or, if this is the last character, the
                        ; instruction after the null terminator)

 CMP #0                 ; If this is the null terminator at the end of the
 BEQ prin2              ; string, jump to prin2 to finish printing and jump to
                        ; the code following the terminator

 JSR OSASCI             ; Print the character in A, making sure that ASCII 13
                        ; prints a carriage return

 JMP prin1              ; Loop back to print the next character in the string

.prin2

 PLA                    ; Restore the value of Y that we stored on the stack
 TAY

 JMP ($00F8)            ; Jump to the address in ($F9 $F8), which by this point
                        ; is pointing to the code following the terminator

; ******************************************************************************
;
;       Name: IncrementPointer
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Increment the string pointer in ($F9 $F8)
;
; ******************************************************************************

.IncrementPointer

 INC $F8                ; Increment the address in ($F9 $F8)
 BNE incp1
 INC $F9

.incp1

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: PrintHexByte
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Print the byte in A in hexadecimal
;
; ******************************************************************************

.PrintHexByte

 PHA                    ; Store A on the stack

 AND #$F0               ; Extract the top nibble of A into bits 0-3 of A
 LSR A
 LSR A
 LSR A
 LSR A

 JSR PrintHexDigit      ; Call PrintHexDigit to print the top nibble as a
                        ; hexedecimal digit

 PLA                    ; Restore the original value of A from the stack and
 AND #$0F               ; extract the bottom nibble of A into bits 0-3 of A

                        ; Fall into PrintHexDigit to print the bottom nibble as
                        ; a hexedecimal digit

; ******************************************************************************
;
;       Name: PrintHexDigit
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Print the nibble in A in hexadecimal
;
; ******************************************************************************

.PrintHexDigit

 CLC                    ; Set A to ASCII "0" plus A, so A contains the ASCII
 ADC #'0'               ; character that represents A

 CMP #'9'+1             ; If A is in the range "0" to "9" then it is already a
 BCC phex1              ; valid hexdecimal digit, so jump to phex1 to print it

 CLC                    ; Otherwise the hexadecimal value is in the range "A" to
 ADC #7                 ; "F", so add 7 to bump ":" to ">" up to "A" to "F"

.phex1

 JMP OSWRCH             ; Print the hexadecimal digit in A and return from the
                        ; subroutine using a tail call

; ******************************************************************************
;
;       Name: LoadFile
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Load the specified file into memory
;
; ******************************************************************************

.LoadFile

 LDA fileToLoad         ; If the first character in the filename is not a
 CMP #13                ; carriage return (ASCII 13) then the string is not
 BNE send1              ; empty, so jump to send1 to load the file

 JMP SetRegisters       ; Otherwise the specified filename is empty, so jump to
                        ; SetRegisters to set the registers and return from the
                        ; subroutine, which takes us back to SendFile, just
                        ; after the branch instruction we took (BCC LoadFile)

.send1

 LDA #LO(fileBuffer)    ; Modify the LDA instruction at send4 to LDA fileBuffer
 STA send4+1            ;
 LDA #HI(fileBuffer)    ; This instruction is modified as we send the file to
 STA send4+2            ; the PDS, so this resets the instruction to the default
                        ; so we start sending the file from the fileBuffer
                        ; address

 LDX #12                ; Set a character counter in X so we can blank out the
                        ; 13 characters in the loadCommand string, between the
                        ; "LOAD " and file buffer address
                        ;
                        ; This will contain the filename for the *LOAD command
                        ; we will use to load the file at address fileBuffer

 LDA #' '               ; Set A to a space character so we can blank out the
                        ; filename

.send2

 STA loadCommand+5,X    ; Set character X + 5 of the loadCommand string to a
                        ; space, so we start after the "LOAD " part and work
                        ; our way along the string

 DEX                    ; Decrement the character counter

 BPL send2              ; Loop back until we have blanked the filename part
                        ; of the loadCommand string

 LDY #0                 ; Next we copy the filename that was entered above into
                        ; the load command and into $1400, so set a character
                        ; counter in Y

 LDX #0                 ; Set a character index in X to work through the
                        ; filename, starting from the beginning

.send3

 LDA fileToLoad,X       ; Copy the X-th character of the filename into fileData
 STA fileData,X         ; so the OSFILE call to fetch catalogue information can
                        ; use the filename

 STA loadCommand+5,X    ; Copy the X-th character of the filename into the *LOAD
                        ; command string at loadCommand, so we can use this to
                        ; load the file

 INX                    ; Increment the character index in X

 INY                    ; Increment the character counter in Y

 CMP #13                ; Loop back to copy the next character until we have
 BNE send3              ; copied all 13 characters

 DEX                    ; The filename that was entered above is terminated by a
 LDA #' '               ; carriage return, so decrement X to point to the
 STA loadCommand+5,X    ; carriage return character in the load command, and
                        ; replace it with a space to prevent it from truncating
                        ; the *LOAD command

                        ; We now send the file via PDS to the Commodore 64
                        ; attached to the user port, starting with the file
                        ; information, and then the file itself

 JSR PrintInlineString  ; Print the following null-terminated inline string and
                        ; continue execution after the null terminator

 EQUS "Sending parallel file..."
 EQUB 13
 EQUB 13
 EQUB 0

 JSR GetFile            ; Load the specified file to the file buffer, fetch its
                        ; catalogue information and send the catalogue
                        ; information via PDS to the Commodore 64 attached to
                        ; the user port

.send4

 LDA fileBuffer         ; This instruction starts with the address of fileBuffer
                        ; and gets modified below as we work our way through the
                        ; file
                        ;
                        ; It sets A to the next byte of the file to send,
                        ; starting from fileBuffer (which is where we loaded the
                        ; file above)

 JSR SendDataToPDS      ; Send the byte in A via PDS to the Commodore 64
                        ; attached to the user port

 LDA fileDataBlock+10   ; Decrement the file length in fileDataBlock(11 10),
 SEC                    ; which we fetched as part of the catalogue information
 SBC #1
 STA fileDataBlock+10
 LDA fileDataBlock+11
 SBC #0
 STA fileDataBlock+11

 ORA fileDataBlock+10   ; If both bytes in fileDataBlock(11 10) are zero, then
 BEQ send5              ; jump to send5 to finish off as we have sent the whole
                        ; file

 INC send4+1            ; Otherwise increment the address in the LDA instruction
 BNE send4              ; at send4 so it points to the next byte to send
 INC send4+2

 JMP send4              ; Loop back to send4 to send the next byte

.send5

 JSR PrintInlineString  ; Print the following null-terminated inline string and
                        ; continue execution after the null terminator

 EQUB 13
 EQUS "Done."
 EQUB 13
 EQUB 13
 EQUB 0

 JMP SendFile           ; Jump to SendFile to fetch another filename

; ******************************************************************************
;
;       Name: GetFile
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Load the specified file, fetch its catalogue information and send
;             the catalogue information to the Commodore 64 on the user port
;
; ******************************************************************************

.GetFile

 LDA #%11111111         ; Set the Data Direction Register (DDR) of port B of the
 STA VIA+$62            ; user port to use PB0 to PB7 as output

 LDA #%00011000         ; Set 6522 User VIA interrupt enable register IER
 STA VIA+$6E            ; (SHEILA $6E) bits 3-4 (i.e. disable all hardware
                        ; interrupts from the User VIA apart from CB1 and CB2)

 LDA VIA+$6C            ; Set 6522 User VIA peripheral control register PCR
 AND #%00001111         ; (SHEILA $6C) bits 4-7 to %1110, so CB1 interrupt
 ORA #%11100000         ; control has a negative active edge, and CB2 control
 STA VIA+$6C            ; has a high output

 LDX #LO(fileDataBlock) ; Set (Y X) = fileDataBlock to pass to OSFILE
 LDY #HI(fileDataBlock)

 LDA #LO(fileData)      ; Set the first two bytes of the fileDataBlock OSFILE
 STA fileDataBlock      ; block to fileData, so the call to OSFILE puts the
 LDA #HI(fileData)      ; file's catalogue information into fileData
 STA fileDataBlock+1

 LDA #5                 ; Call OSFILE with A = 5 to fetch catalogue information
 JSR OSFILE             ; for the file into fileData, returning the file type
                        ; in A

 CMP #1                 ; If A = 1 then the file is readable, so jump to getf1
 BEQ getf1              ; to load the file

                        ; Otherwise the file is not readable, so we need to show
                        ; an error

 JSR PrintInlineString  ; Print the following null-terminated inline string and
                        ; continue execution after the null terminator

 EQUS "Tough Luck!! No can do!! Won't open!"
 EQUB 13
 EQUB 0

 PLA                    ; Remove the return address from the stack so we can
 PLA                    ; jump back to the start of the process

 JMP SendFile           ; Jump to SendFile to fetch another filename

.getf1

 LDX #LO(loadCommand)   ; Execute the *LOAD command in loadCommand to load the
 LDY #HI(loadCommand)   ; specified file to the file buffer
 JSR OSCLI

 LDX fileDataBlock+2    ; Set (Y X) to the load address of the file from the
 LDY fileDataBlock+3    ; catalogue information that we just fetched

 STX $74                ; This appears to have no effect as location $74 is
                        ; never read

 TXA                    ; Send the low byte of the load address via PDS to the
 JSR SendDataToPDS      ; Commodore 64 attached to the user port

 STY $75                ; This appears to have no effect as location $75 is
                        ; never read

 TYA                    ; Send the high byte of the load address via PDS to the
 JSR SendDataToPDS      ; Commodore 64 attached to the user port

 JSR PrintInlineString  ; Print the following null-terminated inline string and
                        ; continue execution after the null terminator

 EQUS "Start : &"
 EQUB 0

 JSR PrintHexWord       ; Print the 16-bit load address in (Y X) in hexadecimal

 LDX fileDataBlock+10   ; Set (Y X) to the length of the file from the catalogue
 LDY fileDataBlock+11   ; information that we just fetched

 STX $76                ; This appears to have no effect as location $76 is
                        ; never read

 TXA                    ; Send the low byte of the file length via PDS to the
 JSR SendDataToPDS      ; Commodore 64 attached to the user port

 STY $77                ; This appears to have no effect as location $77 is
                        ; never read

 TYA                    ; Send the high byte of the file length via PDS to the
 JSR SendDataToPDS      ; Commodore 64 attached to the user port

 JSR PrintInlineString  ; Print the following null-terminated inline string and
                        ; continue execution after the null terminator

 EQUS "Length: &"
 EQUB 0

 JSR PrintHexWord       ; Print the 16-bit file length in (Y X) in hexadecimal

 LDX fileDataBlock+6    ; Set (Y X) to the execution address of the file from
 LDY fileDataBlock+7    ; the catalogue information that we just fetched

 STX $78                ; This appears to have no effect as location $78 is
                        ; never read

 TXA                    ; Send the low byte of the execution address via PDS to
 JSR SendDataToPDS      ; the Commodore 64 attached to the user port

 STY $79                ; This appears to have no effect as location $78 is
                        ; never read

 TYA                    ; Send the high byte of the execution address via PDS to
 JSR SendDataToPDS      ; the Commodore 64 attached to the user port

 JSR PrintInlineString  ; Print the following null-terminated inline string and
                        ; continue execution after the null terminator

 EQUS "Exec  : &"
 EQUB 0

 JSR PrintHexWord       ; Print the 16-bit execution address in (Y X) in
                        ; hexadecimal

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: SendDataToPDS
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Send the byte in A via PDS to the Commodore 64 attached to the
;             user port
;
; ******************************************************************************

.SendDataToPDS

 STA VIA+$60        ; Set 6522 User VIA output register ORB (SHEILA $60) to
                    ; A, so set bits in A will configure the specified pins to
                    ; output (so this will effectively output the value of A
                    ; via the user port)

 LDA VIA+$6C        ; Flip 6522 User VIA peripheral control register PCR
 EOR #%00100000     ; (SHEILA $6C) bit 5, so CB2 interrupt has a low output
 STA VIA+$6C        ; (as we set this to high output in GetFile)

.data1

 LDA VIA+$6D        ; Set A to the 6522 User VIA interrupt flag register IFR
                    ; (SHEILA $6D)

 AND #%00010000     ; Loop back to keep reading the IFR until bit 4 is set,
 BEQ data1          ; which will happen when an active edge occurs on CB1

 LDA VIA+$6D        ; Set bit 5 of the IFR to clear the timer 2 interupt
 ORA #%00100000
 STA VIA+$6D

 LDA VIA+$6C        ; Flip 6522 User VIA peripheral control register PCR
 EOR #%00100000     ; (SHEILA $6C) bit 5, so CB2 interrupt has a high output
 STA VIA+$6C        ; again

 RTS                ; Return from the subroutine

; ******************************************************************************
;
;       Name: PrintHexWord
;       Type: Subroutine
;   Category: Utility routines
;    Summary: Print the 16-bit word in (Y X) in hexadecimal, followed by a full
;             stop and a carriage return
;
; ******************************************************************************

.PrintHexWord

 TYA                    ; Print the value in Y in hexadecimal
 JSR PrintHexByte

 TXA                    ; Print the value in X in hexadecimal
 JSR PrintHexByte

                        ; So we have just printed (Y X) in hexadecimal

 JSR PrintInlineString  ; Print the following null-terminated inline string and
                        ; continue execution after the null terminator

 EQUS "."
 EQUB 13
 EQUB 0

 RTS                    ; Return from the subroutine

; ******************************************************************************
;
;       Name: filenameBlock
;       Type: Variable
;   Category: Utility routines
;    Summary: OSFILE configuration block for entering a string
;
; ******************************************************************************

.filenameBlock

 EQUW fileToLoad        ; The address where we store the entered string

 EQUB 12                ; Maximum line length = 12

 EQUB ' '               ; Allow ASCII characters from " " through to 126 in
 EQUB 126               ; the name

; ******************************************************************************
;
;       Name: loadCommand
;       Type: Variable
;   Category: Utility routines
;    Summary: An OSCLI command for loading the specified file
;
; ******************************************************************************

.loadCommand

 EQUS "LOAD               "
 EQUS STR$~(fileBuffer)
 EQUB 13

; ******************************************************************************
;
;       Name: fileToLoad
;       Type: Variable
;   Category: Utility routines
;    Summary: Storage for the fileToLoad of the specified file
;
; ******************************************************************************

.fileToLoad

 EQUS "            "

.endCode

; ******************************************************************************
;
;       Name: fileData
;       Type: Variable
;   Category: Utility routines
;    Summary: A block for storing file catalogue information
;
; ******************************************************************************

 ORG $1400              ; Set the assembly address to $1400

.fileData

 SKIP 2                 ; Address of filename

 SKIP 4                 ; Load address of file

 SKIP 4                 ; Execution address of file

 SKIP 4                 ; Length of file

 SKIP 4                 ; File attributes

; ******************************************************************************
;
;       Name: fileDataBlock
;       Type: Variable
;   Category: Utility routines
;    Summary: OSFILE configuration block for fetching a file's catalogue
;             information
;
; ******************************************************************************

 ORG $1450              ; Set the assembly address to $1450

.fileDataBlock

 SKIP 2                 ; Address of filename

; ******************************************************************************
;
; Save SEND.bin
;
; ******************************************************************************

 SAVE "3-assembled-output/SEND.bin", CODE%, endCode, LOAD%
