#!/usr/bin/env python
#
# ******************************************************************************
#
# COMMODORE 64 ELITE CHECKSUM SCRIPT
#
# Written by Mark Moxon, and inspired by Kieran Connell's version for the
# cassette version of Elite
#
# This script applies encryption and checksums to the compiled binaries for the
# Commodore 64 version of Elite
#
# ******************************************************************************

from __future__ import print_function
import sys

argv = sys.argv
encrypt = True
release = 1

for arg in argv[1:]:
    if arg == "-u":
        encrypt = False
    if arg == "-rel1":
        release = 1
    if arg == "-rel2":
        release = 2
    if arg == "-rel3":
        release = 3
    if arg == "-rel4":
        release = 4

print("Commodore 64 Elite Checksum")
print("Encryption = ", encrypt)

# Configuration variables for scrambling code and calculating checksums
#
# Values must match those in 3-assembled-output/compile.txt
#
# If you alter the source code, then you should extract the correct values for
# the following variables and plug them into the following, otherwise the game
# will fail the checksum process and will hang on loading
#
# You can find the correct values for these variables by building your updated
# source, and then searching compile.txt for "elite-checksum.py", where the new
# values will be listed

if release == 1 or release == 2:

    # GMA85
    b = 0x1D00                  # B%
    g = 0x1D81                  # G%
    na2_per_cent = 0x2611       # NA2%
    w = 0x4000                  # W%
    x = 0x7590                  # X%
    u = 0x75E4                  # U%

    prg_comlod = b'\x00\x40'    # gma4
    prg_locode = b'\x00\x1D'    # gma5
    prg_hicode = b'\x00\x6A'    # gma6

    # Use padding_comlod to load EXTRA.bin into memory for Compendium
    padding_comlod = bytearray()
    extend_file = open("3-assembled-output/EXTRA.bin", "rb")
    padding_comlod.extend(extend_file.read())
    extend_file.close()

    # padding_comlod = b'\x00\xFF\x00\xFF\x00'
    padding_locode = b'\x00\xFF\x00'
    padding_hicode = b'\xFF\x00\xFF\x00\xFF\x00\xFF\x00\xFF'

elif release == 3 or release == 4:

    # Source disk
    b = 0x1D00                  # B%
    g = 0x1D7E                  # G%
    na2_per_cent = 0x2616       # NA2%
    w = 0x4000                  # W%
    x = 0x7601                  # X%
    u = 0x7655                  # U%

    prg_comlod = b''
    prg_locode = b''
    prg_hicode = b''
    padding_comlod = b''
    padding_locode = b''
    padding_hicode = b''

# Load assembled code files that make up the LOCODE and HICODE files

data_block = bytearray()
elited_offset = 0

# Append all assembled code files

elite_names = ("ELTA", "ELTB", "ELTC", "ELTD", "ELTE", "ELTF", "ELTG", "ELTH", "ELTI", "ELTJ", "ELTK")

for file_name in elite_names:
    print(str(len(data_block)), file_name)
    if file_name == "ELTD":
        elited_offset = len(data_block)
    elite_file = open("3-assembled-output/" + file_name + ".bin", "rb")
    data_block.extend(elite_file.read())
    elite_file.close()

# Commander data checksum

commander_start = na2_per_cent - b
commander_offset = 0x52
CH = 0x4C - 3
CY = 0
for i in range(CH, 0, -1):
    CH = CH + CY + data_block[commander_start + i + 7]
    CY = (CH > 255) & 1
    CH = CH % 256
    CH = CH ^ data_block[commander_start + i + 8]

print("Commander checksum = ", hex(CH))

data_block[commander_start + commander_offset] = CH ^ 0xA9
data_block[commander_start + commander_offset + 2] = CH

CH3 = 0x4C - 3
CY = 0
for i in range(CH3, 0, -1):
    CH3 = CH3 ^ i
    CY3 = CH3 & 1
    CH3 = (CH3 >> 1) | (CY << 7)
    CY = CY3
    CH3 = CH3 + CY + data_block[commander_start + i + 7]
    CY = (CH3 > 255) & 1
    CH3 = CH3 % 256
    CH3 = CH3 ^ data_block[commander_start + i + 8]

print("Commander checksum 3 = ", hex(CH3))

data_block[commander_start + commander_offset + 1] = CH3

# Write output file for LOCODE.unprot.bin

output_file = open("3-assembled-output/LOCODE.unprot.bin", "wb")
output_file.write(data_block[:elited_offset])
output_file.write(padding_locode)
output_file.close()

print("versions/c64/3-assembled-output/LOCODE.unprot.bin file saved")

# Write output file for HICODE.unprot.bin

output_file = open("3-assembled-output/HICODE.unprot.bin", "wb")
output_file.write(data_block[elited_offset:])
output_file.write(padding_hicode)
output_file.close()

print("versions/c64/3-assembled-output/HICODE.unprot.bin file saved")

# Encrypt the LOCODE file

scramble_from = g - b
scramble_to = elited_offset - 1
seed = 0x36

if encrypt:
    for n in range(scramble_from, scramble_to):
        data_block[n] = (data_block[n] + data_block[n + 1]) % 256

    data_block[scramble_to] = (data_block[scramble_to] + seed) % 256

# Write output file for LOCODE

output_file = open("3-assembled-output/LOCODE.bin", "wb")
output_file.write(data_block[:elited_offset])
output_file.write(padding_locode)
output_file.close()

print("versions/c64/3-assembled-output/LOCODE.bin file saved")

# Write output file for gma5

output_file = open("3-assembled-output/gma5.bin", "wb")
output_file.write(prg_locode)
output_file.write(data_block[:elited_offset])
output_file.write(padding_locode)
output_file.close()

print("versions/c64/3-assembled-output/gma5.bin file saved")

# Encrypt the HICODE file

scramble_from = elited_offset
scramble_to = len(data_block) - 1
seed = 0x49

if encrypt:
    for n in range(scramble_from, scramble_to):
        data_block[n] = (data_block[n] + data_block[n + 1]) % 256

    data_block[scramble_to] = (data_block[scramble_to] + seed) % 256

# Write output file for HICODE

output_file = open("3-assembled-output/HICODE.bin", "wb")
output_file.write(data_block[elited_offset:])
output_file.write(padding_hicode)
output_file.close()

print("versions/c64/3-assembled-output/HICODE.bin file saved")

# Write output file for gma6

output_file = open("3-assembled-output/gma6.bin", "wb")
output_file.write(prg_hicode)
output_file.write(data_block[elited_offset:])
output_file.write(padding_hicode)
output_file.close()

print("versions/c64/3-assembled-output/gma6.bin file saved")

# Load assembled code file for COMLOD

data_block = bytearray()

elite_file = open("3-assembled-output/COMLOD.unprot.bin", "rb")
data_block.extend(elite_file.read())
elite_file.close()

# Write output file for COMLOD.unprot.bin

output_file = open("3-assembled-output/COMLOD.unprot.bin", "wb")
output_file.write(data_block)
output_file.write(padding_comlod)
output_file.close()

# Encrypt the second half of the COMLOD file

scramble_from = u - w
scramble_to = len(data_block) - 1
seed = 0x8E

if encrypt:
    for n in range(scramble_from, scramble_to):
        data_block[n] = (data_block[n] + data_block[n + 1]) % 256

    data_block[scramble_to] = (data_block[scramble_to] + seed) % 256

# Encrypt the first half of the COMLOD file

scramble_from = 0
scramble_to = x - w - 1
seed = 0x6C

if encrypt:
    for n in range(scramble_from, scramble_to):
        data_block[n] = (data_block[n] + data_block[n + 1]) % 256

    data_block[scramble_to] = (data_block[scramble_to] + seed) % 256

# Write output file for COMLOD

output_file = open("3-assembled-output/COMLOD.bin", "wb")
output_file.write(data_block)
output_file.write(padding_comlod)
output_file.close()

print("versions/c64/3-assembled-output/COMLOD.bin file saved")

# Write output file for gma4

output_file = open("3-assembled-output/gma4.bin", "wb")
output_file.write(prg_comlod)
output_file.write(data_block)
output_file.write(padding_comlod)
output_file.close()

print("versions/c64/3-assembled-output/gma4.bin file saved")

# Load assembled code file for gma1

data_block = bytearray()

elite_file = open("3-assembled-output/gma1.bin", "rb")
data_block.extend(elite_file.read())
elite_file.close()

# Disable the disk protection in gma1

if release == 2:
    # GMA86 PAL
    data_block[0x25] = 0xEA
    data_block[0x26] = 0xEA
    data_block[0x27] = 0xEA
    data_block[0x2C] = 0xD0
else:
    # GMA85 NTSC and source disk
    data_block[0x14] = 0xEA
    data_block[0x16] = 0xEA
    data_block[0x15] = 0xEA

# Write output file for gma1.unprot.bin

output_file = open("3-assembled-output/gma1.unprot.bin", "wb")
output_file.write(data_block)
output_file.close()

print("versions/c64/3-assembled-output/gma1.unprot.bin file saved")
