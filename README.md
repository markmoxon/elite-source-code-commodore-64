# Fully documented source code for Elite on the Commodore 64

<details>
<summary>Links to my other software archaeology repositories</summary>
<hr>

**Elite sources:** [BBC Micro cassette](https://github.com/markmoxon/elite-source-code-bbc-micro-cassette) | [BBC Micro disc](https://github.com/markmoxon/elite-source-code-bbc-micro-disc) | [Acorn Electron](https://github.com/markmoxon/elite-source-code-acorn-electron) | [6502 Second Processor](https://github.com/markmoxon/elite-source-code-6502-second-processor) | [Commodore 64](https://github.com/markmoxon/elite-source-code-commodore-64) | [Apple II](https://github.com/markmoxon/elite-source-code-apple-ii) | [BBC Master](https://github.com/markmoxon/elite-source-code-bbc-master) | [NES](https://github.com/markmoxon/elite-source-code-nes) | [Elite-A](https://github.com/markmoxon/elite-a-source-code-bbc-micro) | [Teletext Elite](https://github.com/markmoxon/teletext-elite) | [Elite Universe Editor](https://github.com/markmoxon/elite-universe-editor) | [Flicker-free Commodore 64 Elite](https://github.com/markmoxon/c64-elite-flicker-free) | [Elite over Econet](https://github.com/markmoxon/elite-over-econet) | [!EliteNet](https://github.com/markmoxon/elite-over-econet-acorn-archimedes)

**Elite Compendium:** [BBC Master](https://github.com/markmoxon/elite-compendium-bbc-master) | [BBC Micro](https://github.com/markmoxon/elite-compendium-bbc-micro) | [BBC Micro B+](https://github.com/markmoxon/elite-compendium-bbc-micro-b-plus) | [Acorn Electron](https://github.com/markmoxon/elite-compendium-acorn-electron)

**Other sources:** [Aviator (BBC Micro)](https://github.com/markmoxon/aviator-source-code-bbc-micro) | [Revs (BBC Micro)](https://github.com/markmoxon/revs-source-code-bbc-micro) | [The Sentinel (BBC Micro)](https://github.com/markmoxon/the-sentinel-source-code-bbc-micro) | [Lander (Acorn Archimedes)](https://github.com/markmoxon/lander-source-code-acorn-archimedes)

See [my profile](https://github.com/markmoxon) for more repositories to explore.
<hr>
</details>

![Screenshot of Elite on the Commodore 64](https://elite.bbcelite.com/images/github/Elite-Commodore64.png)

This repository contains the original source code for Ian Bell and David Braben's classic game Elite on the Commodore 64, with every single line documented and (for the most part) explained. It is literally the original source code, just heavily commented.

It is a companion to the [elite.bbcelite.com website](https://elite.bbcelite.com).

See the [introduction](#introduction) for more information, or jump straight into the [documented source code](1-source-files/main-sources).

## Contents

* [Introduction](#introduction)

* [Acknowledgements](#acknowledgements)

  * [A note on licences, copyright etc.](#user-content-a-note-on-licences-copyright-etc)

* [Browsing the source in an IDE](#browsing-the-source-in-an-ide)

* [Folder structure](#folder-structure)

* [Flicker-free Elite](#flicker-free-elite)

* [Building Commodore 64 Elite from the source](#building-commodore-64-elite-from-the-source)

  * [Requirements](#requirements)
  * [Windows](#windows)
  * [Mac and Linux](#mac-and-linux)
  * [Build options](#build-options)
  * [Updating the checksum scripts if you change the code](#updating-the-checksum-scripts-if-you-change-the-code)
  * [Verifying the output](#verifying-the-output)
  * [Log files](#log-files)

* [Building different variants of Commodore 64 Elite](#building-different-variants-of-commodore-64-elite)

  * [Building the Firebird GMA85 NTSC variant](#building-the-firebird-gma85-ntsc-variant)
  * [Building the Firebird GMA86 PAL variant](#building-the-firebird-gma86-pal-variant)
  * [Building the source disk build variant](#building-the-source-disk-build-variant)
  * [Building the source disk files variant](#building-the-source-disk-files-variant)
  * [Differences between the variants](#differences-between-the-variants)

* [Notes on the original source files](#notes-on-the-original-source-files)

  * [Producing byte-accurate binaries](#producing-byte-accurate-binaries)

## Introduction

This repository contains the original source code for Elite on the Commodore 64, with every single line documented and (for the most part) explained.

You can build the fully functioning game from this source. [Four variants](#building-different-variants-of-commodore-64-elite) are currently supported: the Firebird GMA85 NTSC variant, the Firebird GMA86 PAL variant, the variant built by the source disk build process, and the variant built from the binary files already on the source disk.

This repository is a companion to the [elite.bbcelite.com website](https://elite.bbcelite.com), which contains all the code from this repository, but laid out in a much more human-friendly fashion. The links at the top of this page will take you to repositories for the other versions of Elite that are covered by this project.

* If you want to browse the source and read about how Elite works under the hood, you will probably find [the website](https://elite.bbcelite.com) a better place to start than this repository.

* If you would rather explore the source code in your favourite IDE, then the [annotated source](1-source-files/main-sources) is what you're looking for. It contains the exact same content as the website, so you won't be missing out (the website is generated from the source files, so they are guaranteed to be identical). You might also like to read the section on [browsing the source in an IDE](#browsing-the-source-in-an-ide) for some tips.

* If you want to build Commodore 64 Elite from the source on a modern computer, to produce a working game disk that can be loaded into a Commodore 64 or an emulator, then you want the section on [building Commodore 64 Elite from the source](#building-commodore-64-elite-from-the-source).

My hope is that this repository and the [accompanying website](https://elite.bbcelite.com) will be useful for those who want to learn more about Elite and what makes it tick. It is provided on an educational and non-profit basis, with the aim of helping people appreciate one of the most iconic games of the 8-bit era.

## Acknowledgements

Commodore 64 Elite was written by Ian Bell and David Braben and is copyright &copy; D. Braben and I. Bell 1985.

The code on this site is identical to the source disks released on [Ian Bell's personal website](http://www.elitehomepage.org/) (it's just been reformatted to be more readable).

The commentary is copyright &copy; Mark Moxon. Any misunderstandings or mistakes in the documentation are entirely my fault.

Huge thanks are due to the original authors for not only creating such an important piece of my childhood, but also for releasing the source code for us to play with. Also, a big thumbs up to Kroc Camen for his epic [Elite Harmless](https://github.com/Kroc/elite-harmless) project, which is a really useful reference for anyone exploring the Commodore 64 binaries. Finally, thanks to the gurus in this [Lemon64 forum thread](https://www.lemon64.com/forum/viewtopic.php?t=67762&start=90) for their sage advice.

The following archive from Ian Bell's personal website forms the basis for this project:

* [Commodore 64 Elite sources as a BBC Micro disc image](http://www.elitehomepage.org/archive/a/a5050010.zip)

### A note on licences, copyright etc.

This repository is _not_ provided with a licence, and there is intentionally no `LICENSE` file provided.

According to [GitHub's licensing documentation](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/licensing-a-repository), this means that "the default copyright laws apply, meaning that you retain all rights to your source code and no one may reproduce, distribute, or create derivative works from your work".

The reason for this is that my commentary is intertwined with the original source code for Elite, and the original source code is copyright. The whole site is therefore covered by default copyright law, to ensure that this copyright is respected.

Under GitHub's rules, you have the right to read and fork this repository... but that's it. No other use is permitted, I'm afraid.

My hope is that the educational and non-profit intentions of this repository will enable it to stay hosted and available, but the original copyright holders do have the right to ask for it to be taken down, in which case I will comply without hesitation. I do hope, though, that along with the various other disassemblies and commentaries of this source, it will remain viable.

## Browsing the source in an IDE

If you want to browse the source in an IDE, you might find the following useful.

* The most interesting files are in the [main-sources](1-source-files/main-sources) folder:

  * The main game's source code is in the [elite-source.asm](1-source-files/main-sources/elite-source.asm) and [elite-data.asm](1-source-files/main-sources/elite-data.asm) files (containing the game code and game data respectively) - this is the motherlode and probably contains all the stuff you're interested in.

  * The game's loader is in the [elite-loader.asm](1-source-files/main-sources/elite-loader.asm) file - this is mainly concerned with setup and copy protection.

* It's probably worth skimming through the [notes on terminology and notations](https://elite.bbcelite.com/terminology/) on the accompanying website, as this explains a number of terms used in the commentary, without which it might be a bit tricky to follow at times (in particular, you should understand the terminology I use for multi-byte numbers).

* The accompanying website contains [a number of "deep dive" articles](https://elite.bbcelite.com/deep_dives/), each of which goes into an aspect of the game in detail. Routines that are explained further in these articles are tagged with the label `Deep dive:` and the relevant article name.

* There are loads of routines and variables in Elite - literally hundreds. You can find them in the source files by searching for the following: `Type: Subroutine`, `Type: Variable`, `Type: Workspace` and `Type: Macro`.

* If you know the name of a routine, you can find it by searching for `Name: <name>`, as in `Name: SCAN` (for the 3D scanner routine) or `Name: LL9` (for the ship-drawing routine).

* The entry point for the [main game code](1-source-files/main-sources/elite-source.asm) is routine `BEGIN`, which you can find by searching for `Name: BEGIN`. If you want to follow the program flow all the way from the title screen around the main game loop, then you can find a number of [deep dives on program flow](https://elite.bbcelite.com/deep_dives/) on the accompanying website.

* The source code is designed to be read at an 80-column width and with a monospaced font, just like in the good old days.

I hope you enjoy exploring the inner workings of Commmodore 64 Elite as much as I have.

## Folder structure

There are five main folders in this repository, which reflect the order of the build process.

* [1-source-files](1-source-files) contains all the different source files, such as the main assembler source files, image binaries, fonts, boot files and so on.

* [2-build-files](2-build-files) contains build-related scripts, such as the checksum, encryption and crc32 verification scripts.

* [3-assembled-output](3-assembled-output) contains the output from the assembly process, when the source files are assembled and the results processed by the build files.

* [4-reference-binaries](4-reference-binaries) contains the correct binaries for each variant, so we can verify that our assembled output matches the reference.

* [5-compiled-game-disks](5-compiled-game-disks) contains the final output of the build process: a d64 disk image that contains the compiled game and which can be run on real hardware or in an emulator.

## Flicker-free Elite

This repository also includes a flicker-free version, which incorporates the backported flicker-free ship-drawing routines from the BBC Master, as well as a fix for planets so they no longer flicker. The flicker-free code is in a separate branch called `flicker-free`, and apart from the code differences for reducing flicker, this branch is identical to the main branch and the same build process applies.

The annotated source files in the `flicker-free` branch contain both the original Firebird code and all of the modifications for flicker-free Elite, so you can look through the source to see exactly what's changed. Any code that I've removed from the original version is commented out in the source files, so when they are assembled they produce the flicker-free binaries, while still containing details of all the modifications. You can find all the diffs by searching the sources for `Mod:`.

For more information on flicker-free Elite, see the [hacks section of the accompanying website](https://elite.bbcelite.com/hacks/flicker-free_elite.html).

Note that the `flicker-free` branch contains the same code changes as the [flicker-free Commodore 64 Elite](https://github.com/markmoxon/c64-elite-flicker-free) repository. However, in this repository the modifications are integrated into the original source code and the whole game is rebuilt, while in the other repository the changes are patched into the game binary. The end result is exactly the same, but this repository is much easier to follow if you want to explore the modifications.

## Building Commodore 64 Elite from the source

Builds are supported for both Windows and Mac/Linux systems. In all cases the build process is defined in the `Makefile` provided.

### Requirements

You will need the following to build Commodore 64 Elite from the source:

* BeebAsm, which can be downloaded from the [BeebAsm repository](https://github.com/stardot/beebasm). Mac and Linux users will have to build their own executable with `make code`, while Windows users can just download the `beebasm.exe` file.

* Python. The build process has only been tested on 3.x, but 2.7 might work.

* c1541 from the VICE emulator, which can be downloaded from the [VICE site](https://vice-emu.sourceforge.io).

* Mac and Linux users may need to install `make` if it isn't already present (for Windows users, `make.exe` is included in this repository).

You may be wondering why we're using BeebAsm - a BBC Micro assembler - to build the Commodore 64 version of Elite. This is because Commodore 64 Elite is a conversion of 6502 Second Processor Elite, which itself is a direct descendant of the original 1984 release for the BBC Micro and Acorn Electron (and the same is true of the Apple II and NES versions of Elite - they are all cut from the same cloth). The NES version aside, all of the 6502 versions of Elite were built and assembled on a BBC Micro, including the Commodore and Apple versions, so BeebAsm is a good modern assembler to use for the Commodore 64 version as well.

For details of how the build process works, see the [build documentation on bbcelite.com](https://elite.bbcelite.com/about_site/building_elite.html).

Let's look at how to build Commodore 64 Elite from the source.

### Windows

For Windows users, there is a batch file called `make.bat` which you can use to build the game. Before this will work, you should edit the batch file and change the values of the `BEEBASM`, `PYTHON` and `C1451` variables to point to the locations of your `beebasm.exe`, `python.exe` and `c1541.exe` executables. You also need to change directory to the repository folder (i.e. the same folder as `make.bat`).

All being well, entering the following into a command window:

```
make.bat
```

will produce a file called `elite-commodore-64-gma85-ntsc.d64` in the `5-compiled-game-disks` folder that contains the Firebird GMA85 NTSC variant, which you can then load into an emulator, or into a real Commodore 64.

### Mac and Linux

The build process uses a standard GNU `Makefile`, so you just need to install `make` if your system doesn't already have it. If BeebAsm, Python or c1541 are not on your path, then you can either fix this, or you can edit the `Makefile` and change the `BEEBASM`, `PYTHON` and `C1451` variables in the first three lines to point to their locations. You also need to change directory to the repository folder (i.e. the same folder as `Makefile`).

All being well, entering the following into a terminal window:

```
make
```

will produce a file called `elite-commodore-64-gma85-ntsc.d64` in the `5-compiled-game-disks` folder that contains the Firebird GMA85 NTSC variant, which you can then load into an emulator, or into a real Commodore 64.

### Build options

By default the build process will create a typical Elite game disk with a standard commander and verified binaries. There are various arguments you can pass to the build to change how it works. They are:

* `variant=<name>` - Build the specified variant:

  * `variant=gma85-ntsc` (default)
  * `variant=gma86-pal`
  * `variant=source-disk-build`
  * `variant=source-disk-files`

* `commander=max` - Start with a maxed-out commander (specifically, this is the test commander file from the original source, which is almost but not quite maxed-out)

* `encrypt=no` - Disable encryption and checksum routines

* `match=no` - Do not attempt to match the original game binaries (i.e. omit workspace noise)

* `verify=no` - Disable crc32 verification of the game binaries

So, for example:

`make variant=gma86-pal commander=max encrypt=no match=no verify=no`

will build an unencrypted GMA85 PAL variant with a maxed-out commander, no workspace noise and no crc32 verification.

The unencrypted version should be more useful for anyone who wants to make modifications to the game code. As this argument produces unencrypted files, the binaries produced will be quite different to the binaries on the original source disk, which are encrypted.

See below for more on the verification process.

### Updating the checksum scripts if you change the code

If you change the source code in any way, you may break the game; if so, it will typically hang at the loading screen, though in some versions it may hang when launching from the space station.

To fix this, you may need to update some of the hard-coded addresses in the checksum script so that they match the new addresses in your changed version of the code. See the comments in the [elite-checksum.py](2-build-files/elite-checksum.py) script for details.

### Verifying the output

The default build process prints out checksums of all the generated files, along with the checksums of the files from the original sources. You can disable verification by passing `verify=no` to the build.

The Python script `crc32.py` in the `2-build-files` folder does the actual verification, and shows the checksums and file sizes of both sets of files, alongside each other, and with a Match column that flags any discrepancies. If you are building an unencrypted set of files then there will be lots of differences, while the encrypted files should mostly match (see the Differences section below for more on this).

The binaries in the `4-reference-binaries` folder are those extracted from the released version of the game, while those in the `3-assembled-output` folder are produced by the build process. For example, if you don't make any changes to the code and build the project with `make`, then this is the output of the verification process:

```
Results for variant: gma85-ntsc
[--originals--]  [---output----]
Checksum   Size  Checksum   Size  Match  Filename
-----------------------------------------------------------
cea8c062  18016  cea8c062  18016   Yes   COMLOD.bin
442eabc1  18016  442eabc1  18016   Yes   COMLOD.unprot.bin
992bbfe6   2980  992bbfe6   2980   Yes   ELTA.bin
0f94099a   2426  0f94099a   2426   Yes   ELTB.bin
bd3453c7   3252  bd3453c7   3252   Yes   ELTC.bin
ff3d3005   3305  ff3d3005   3305   Yes   ELTD.bin
a9dfd514   2954  a9dfd514   2954   Yes   ELTE.bin
84c77035   4172  84c77035   4172   Yes   ELTF.bin
9ec62ad9   4065  9ec62ad9   4065   Yes   ELTG.bin
2675f20e   1253  2675f20e   1253   Yes   ELTH.bin
51878ce7    932  51878ce7    932   Yes   ELTI.bin
08d1c413   2466  08d1c413   2466   Yes   ELTJ.bin
7c826b65   6156  7c826b65   6156   Yes   ELTK.bin
b7493cd2  25312  b7493cd2  25312   Yes   HICODE.bin
d3672d96  25312  d3672d96  25312   Yes   HICODE.unprot.bin
42d63335   3789  42d63335   3789   Yes   IANTOK.bin
e2edb521   8661  e2edb521   8661   Yes   LOCODE.bin
7c92152c   8661  7c92152c   8661   Yes   LOCODE.unprot.bin
41dab672   5632  41dab672   5632   Yes   LODATA.bin
9f5fee4d    549  9f5fee4d    549   Yes   SEND.bin
43f25e32   8077  43f25e32   8077   Yes   SHIPS.bin
f5cf6c33    448  f5cf6c33    448   Yes   SPRITE.bin
57406380   1024  57406380   1024   Yes   WORDS.bin
97ebe9c1      4  97ebe9c1      4   Yes   byebyejulie.bin
41e6ba2f    103  41e6ba2f    103   Yes   firebird.bin
fd1e9c6d   1096  fd1e9c6d   1096   Yes   gma1.bin
c70d57b0   1096  c70d57b0   1096   Yes   gma1.unprot.bin
ba6d10a3    290  ba6d10a3    290   Yes   gma3.bin
4247ad85  18018  4247ad85  18018   Yes   gma4.bin
941dac49   8663  941dac49   8663   Yes   gma5.bin
24d06bc5  25314  24d06bc5  25314   Yes   gma6.bin
```

All the compiled binaries match the originals, so we know we are producing the same final game as the Firebird GMA85 NTSC variant.

### Log files

During compilation, details of every step are output in a file called `compile.txt` in the `3-assembled-output` folder. If you have problems, it might come in handy, and it's a great reference if you need to know the addresses of labels and variables for debugging (or just snooping around).

## Building different variants of Commodore 64 Elite

This repository contains the source code for four different variants of Commodore 64 Elite:

* The Firebird GMA85 NTSC variant, which was the second official release of Commodore 64 Elite from 1986

* The Firebird GMA86 PAL variant, which is identical to the GMA85 version apart from some small changes to make it suitable for PAL systems

* The variant produced by running the build process on the source disk from Ian Bell's personal website

* The variant produced using the binaries from the source disk on Ian Bell's personal website, which differ slightly from the binaries that are produced by running the build process

By default the build process builds the Firebird GMA85 NTSC variant, but you can build a specified variant using the `variant=` build parameter.

### Building the Firebird GMA85 NTSC variant

You can add `variant=gma85-ntsc` to produce the `elite-commodore-64-gma85-ntsc.d64` file that contains the Firebird GMA85 NTSC variant, though that's the default value so it isn't necessary. In other words, you can build it like this:

```
make.bat variant=gma85-ntsc
```

or this on a Mac or Linux:

```
make variant=gma85-ntsc
```

This will produce a file called `elite-commodore-64-gma85-ntsc.d64` in the `5-compiled-game-disks` folder that contains the Firebird GMA85 NTSC variant.

The verification checksums for this version are as follows:

```
Results for variant: gma85-ntsc
[--originals--]  [---output----]
Checksum   Size  Checksum   Size  Match  Filename
-----------------------------------------------------------
cea8c062  18016  cea8c062  18016   Yes   COMLOD.bin
442eabc1  18016  442eabc1  18016   Yes   COMLOD.unprot.bin
992bbfe6   2980  992bbfe6   2980   Yes   ELTA.bin
0f94099a   2426  0f94099a   2426   Yes   ELTB.bin
bd3453c7   3252  bd3453c7   3252   Yes   ELTC.bin
ff3d3005   3305  ff3d3005   3305   Yes   ELTD.bin
a9dfd514   2954  a9dfd514   2954   Yes   ELTE.bin
84c77035   4172  84c77035   4172   Yes   ELTF.bin
9ec62ad9   4065  9ec62ad9   4065   Yes   ELTG.bin
2675f20e   1253  2675f20e   1253   Yes   ELTH.bin
51878ce7    932  51878ce7    932   Yes   ELTI.bin
08d1c413   2466  08d1c413   2466   Yes   ELTJ.bin
7c826b65   6156  7c826b65   6156   Yes   ELTK.bin
b7493cd2  25312  b7493cd2  25312   Yes   HICODE.bin
d3672d96  25312  d3672d96  25312   Yes   HICODE.unprot.bin
42d63335   3789  42d63335   3789   Yes   IANTOK.bin
e2edb521   8661  e2edb521   8661   Yes   LOCODE.bin
7c92152c   8661  7c92152c   8661   Yes   LOCODE.unprot.bin
41dab672   5632  41dab672   5632   Yes   LODATA.bin
9f5fee4d    549  9f5fee4d    549   Yes   SEND.bin
43f25e32   8077  43f25e32   8077   Yes   SHIPS.bin
f5cf6c33    448  f5cf6c33    448   Yes   SPRITE.bin
57406380   1024  57406380   1024   Yes   WORDS.bin
97ebe9c1      4  97ebe9c1      4   Yes   byebyejulie.bin
41e6ba2f    103  41e6ba2f    103   Yes   firebird.bin
fd1e9c6d   1096  fd1e9c6d   1096   Yes   gma1.bin
c70d57b0   1096  c70d57b0   1096   Yes   gma1.unprot.bin
ba6d10a3    290  ba6d10a3    290   Yes   gma3.bin
4247ad85  18018  4247ad85  18018   Yes   gma4.bin
941dac49   8663  941dac49   8663   Yes   gma5.bin
24d06bc5  25314  24d06bc5  25314   Yes   gma6.bin
```

### Building the Firebird GMA86 PAL variant

You can build the Firebird GMA86 PAL variant by appending `variant=gma86-pal` to the `make` command, like this on Windows:

```
make.bat variant=gma86-pal
```

or this on a Mac or Linux:

```
make variant=gma86-pal
```

This will produce a file called `elite-commodore-64-gma86-pal.d64` in the `5-compiled-game-disks` folder that contains the Firebird GMA86 PAL variant.

The verification checksums for this version are as follows:

```
Results for variant: gma86-pal
[--originals--]  [---output----]
Checksum   Size  Checksum   Size  Match  Filename
-----------------------------------------------------------
cea8c062  18016  cea8c062  18016   Yes   COMLOD.bin
442eabc1  18016  442eabc1  18016   Yes   COMLOD.unprot.bin
992bbfe6   2980  992bbfe6   2980   Yes   ELTA.bin
0f94099a   2426  0f94099a   2426   Yes   ELTB.bin
bd3453c7   3252  bd3453c7   3252   Yes   ELTC.bin
ff3d3005   3305  ff3d3005   3305   Yes   ELTD.bin
a9dfd514   2954  a9dfd514   2954   Yes   ELTE.bin
84c77035   4172  84c77035   4172   Yes   ELTF.bin
9ec62ad9   4065  9ec62ad9   4065   Yes   ELTG.bin
2675f20e   1253  2675f20e   1253   Yes   ELTH.bin
51878ce7    932  51878ce7    932   Yes   ELTI.bin
08d1c413   2466  08d1c413   2466   Yes   ELTJ.bin
7c826b65   6156  7c826b65   6156   Yes   ELTK.bin
b7493cd2  25312  b7493cd2  25312   Yes   HICODE.bin
d3672d96  25312  d3672d96  25312   Yes   HICODE.unprot.bin
42d63335   3789  42d63335   3789   Yes   IANTOK.bin
e2edb521   8661  e2edb521   8661   Yes   LOCODE.bin
7c92152c   8661  7c92152c   8661   Yes   LOCODE.unprot.bin
41dab672   5632  41dab672   5632   Yes   LODATA.bin
9f5fee4d    549  9f5fee4d    549   Yes   SEND.bin
43f25e32   8077  43f25e32   8077   Yes   SHIPS.bin
f5cf6c33    448  f5cf6c33    448   Yes   SPRITE.bin
57406380   1024  57406380   1024   Yes   WORDS.bin
97ebe9c1      4  97ebe9c1      4   Yes   byebyejulie.bin
41e6ba2f    103  41e6ba2f    103   Yes   firebird.bin
bd5ece7b   1042  bd5ece7b   1042   Yes   gma1.bin
b6adf486   1042  b6adf486   1042   Yes   gma1.unprot.bin
f5a01242    294  f5a01242    294   Yes   gma3.bin
4247ad85  18018  4247ad85  18018   Yes   gma4.bin
941dac49   8663  941dac49   8663   Yes   gma5.bin
24d06bc5  25314  24d06bc5  25314   Yes   gma6.bin
```

### Building the source disk build variant

You can build the source disk build variant by appending `variant=source-disk-build` to the `make` command, like this on Windows:

```
make.bat variant=source-disk-build
```

or this on a Mac or Linux:

```
make variant=source-disk-build
```

This does not currently produce a game disk, but instead produces the same binaries as the original build process. In the original development system, these files would then be transmitted from the BBC Micro to the Commodore 64 via a serial link, but that setup isn't emulated here.

The verification checksums for this version are as follows:

```
Results for variant: source-disk-build
[--originals--]  [---output----]
Checksum   Size  Checksum   Size  Match  Filename
-----------------------------------------------------------
40069fb5  18124  40069fb5  18124   Yes   COMLOD.bin
ab2132e5  18124  ab2132e5  18124   Yes   COMLOD.unprot.bin
237ccd96   2977  237ccd96   2977   Yes   ELTA.bin
4cf448f2   2426  4cf448f2   2426   Yes   ELTB.bin
899dd1a4   3252  899dd1a4   3252   Yes   ELTC.bin
5e47acfd   3305  5e47acfd   3305   Yes   ELTD.bin
1d1b6a63   2938  1d1b6a63   2938   Yes   ELTE.bin
2d1f6439   4142  2d1f6439   4142   Yes   ELTF.bin
4c4887f4   4111  4c4887f4   4111   Yes   ELTG.bin
8f9317f1   1253  8f9317f1   1253   Yes   ELTH.bin
9ba1820f    932  9ba1820f    932   Yes   ELTI.bin
b5f82155   2466  b5f82155   2466   Yes   ELTJ.bin
22259361   3222  22259361   3222   Yes   ELTK.bin
90f6fefb  22369  90f6fefb  22369   Yes   HICODE.bin
1c01948a  22369  1c01948a  22369   Yes   HICODE.unprot.bin
42d63335   3789  42d63335   3789   Yes   IANTOK.bin
56cbbd68   8655  56cbbd68   8655   Yes   LOCODE.bin
7fcc5af9   8655  7fcc5af9   8655   Yes   LOCODE.unprot.bin
2771f34f   5632  2771f34f   5632   Yes   LODATA.bin
9f5fee4d    549  9f5fee4d    549   Yes   SEND.bin
43f25e32   8077  43f25e32   8077   Yes   SHIPS.bin
15867853    448  15867853    448   Yes   SPRITE.bin
52bac547   1024  52bac547   1024   Yes   WORDS.bin
```

### Building the source disk files variant

You can build the source disk files variant by appending `variant=source-disk-files` to the `make` command, like this on Windows:

```
make.bat variant=source-disk-files
```

or this on a Mac or Linux:

```
make variant=source-disk-files
```

This does not currently produce a game disk, but instead produces the same binaries as the original build process. In the original development system, these files would then be transmitted from the BBC Micro to the Commodore 64 via a serial link, but that setup isn't emulated here.

The verification checksums for this version are as follows:

```
Results for variant: source-disk-files
[--originals--]  [---output----]
Checksum   Size  Checksum   Size  Match  Filename
-----------------------------------------------------------
58259b1a  18124  58259b1a  18124   Yes   COMLOD.bin
39253b9c  18124  39253b9c  18124   Yes   COMLOD.unprot.bin
237ccd96   2977  237ccd96   2977   Yes   ELTA.bin
4cf448f2   2426  4cf448f2   2426   Yes   ELTB.bin
899dd1a4   3252  899dd1a4   3252   Yes   ELTC.bin
5e47acfd   3305  5e47acfd   3305   Yes   ELTD.bin
1d1b6a63   2938  1d1b6a63   2938   Yes   ELTE.bin
2d1f6439   4142  2d1f6439   4142   Yes   ELTF.bin
4c4887f4   4111  4c4887f4   4111   Yes   ELTG.bin
8f9317f1   1253  8f9317f1   1253   Yes   ELTH.bin
9ba1820f    932  9ba1820f    932   Yes   ELTI.bin
b5f82155   2466  b5f82155   2466   Yes   ELTJ.bin
d0ee2f81   3222  d0ee2f81   3222   Yes   ELTK.bin
5fdb0db0  22369  5fdb0db0  22369   Yes   HICODE.bin
eeca286a  22369  eeca286a  22369   Yes   HICODE.unprot.bin
42d63335   3789  42d63335   3789   Yes   IANTOK.bin
56cbbd68   8655  56cbbd68   8655   Yes   LOCODE.bin
7fcc5af9   8655  7fcc5af9   8655   Yes   LOCODE.unprot.bin
41dab672   5632  41dab672   5632   Yes   LODATA.bin
9f5fee4d    549  9f5fee4d    549   Yes   SEND.bin
43f25e32   8077  43f25e32   8077   Yes   SHIPS.bin
f5cf6c33    448  f5cf6c33    448   Yes   SPRITE.bin
57406380   1024  57406380   1024   Yes   WORDS.bin
```

### Differences between the variants

You can see the differences between the variants by searching the source code for `_GMA85_NTSC` (for features in the Firebird GMA85 NTSC variant), `_GMA86_PAL` (for features in the Firebird GMA86 PAL variant), `_SOURCE_DISK_BUILD` (for features in the source disk build variant) or `_SOURCE_DISK_FILES` (for features in the source disk files variant). You can also search for `_GMA_RELEASE` for features in both GMA variants, or `_SOURCE_DISK` for features in all the source disk variants.

The main differences in the GMA86 PAL variant compared to the GMA85 NTSC variant are:

* The disk loaders are different, particularly in the fast loader routine. This does not affect gameplay in any way.

* There is a configuration variable called USA% that you might expect to be set to FALSE for the PAL variant, but it is set to TRUE for both, so this is not a difference between the two variants.

The main differences in the source disk variants compared to the Firebird variants are:

* Some of the game data is stored at different addresses.

* A smaller block of ship data is copied the game loader, though this doesn't make any difference.

* An image containing the build date is included in the disk loader.

* There is no Elite Theme music, only The Blue Danube.

* The joystick is read differently.

* The frequency change when implementing vibrato in voice 3 is different.

* The period when implementing vibrato in voices 2 and 3 is different.

* The music counter stops counting when it reaches 2 rather than 0.

* The format of the music data file is slightly different.

* In the source disk build variant only, the text token for the energy unit is "ENERGY UNIT", rather than the "EXTRA ENERGY UNIT" that is found in all the other variants.

See the [accompanying website](https://elite.bbcelite.com/c64/releases.html) for a comprehensive list of differences between the variants.

## Notes on the original source files

### Producing byte-accurate binaries

Instead of initialising workspaces with null values like BeebAsm, the original BBC Micro source code creates its workspaces by simply incrementing the `P%` and `O%` program counters, which means that the workspaces end up containing whatever contents the allocated memory had at the time. As the source files are broken into multiple BBC BASIC programs that run each other sequentially, this means the workspaces in the source code tend to contain either fragments of these BBC BASIC source programs, or assembled code from an earlier stage. This doesn't make any difference to the game code, which either initialises the workspaces at runtime or just ignores their initial contents, but if we want to be able to produce byte-accurate binaries from the modern BeebAsm assembly process, we need to include this "workspace noise" when building the project. Workspace noise is only loaded by the `encrypt` target; for the `build` target, workspaces are initialised with zeroes.

You can disable the production of byte-accurate binaries by passing `match=no` to the build. This will omit most workspace noise, leaving workspaces initialised with zeroes instead.

Here's an example of how workspace noise is included, from the main source in elite-source.asm:

```
.LSX2

IF _MATCH_ORIGINAL_BINARIES

 IF _GMA_RELEASE

  EQUB &76, &85, &9C, &A5, &8B, &85, &9A, &A5
  EQUB &8D, &20, &0C, &9A, &B0, &D2, &85, &6F
  EQUB &A5, &9C, &85, &70, &A5, &6B, &85, &9B
  EQUB &A5, &72, &85, &9C, &A5, &85, &85, &9A
  EQUB &A5, &87, &20, &0C, &9A, &B0, &B9, &85
  EQUB &6B, &A5, &9C, &85, &6C, &A5, &6D, &85
  EQUB &9B, &A5, &74, &85, &9C, &A5, &88, &85
  EQUB &9A, &A5, &8A, &20, &0C, &9A, &B0, &A0
  EQUB &85, &6D, &A5, &9C, &85, &6E, &A5, &71
  EQUB &85, &9A, &A5, &6B, &20, &EA, &39, &85
  EQUB &BB, &A5, &72, &45, &6C, &85, &9C, &A5
  EQUB &73, &85, &9A, &A5, &6D, &20, &EA, &39
  EQUB &85, &9A, &A5, &BB, &85, &9B, &A5, &74
  EQUB &45, &6E, &20, &0C, &9A, &85, &BB, &A5
  EQUB &75, &85, &9A, &A5, &6F, &20, &EA, &39
  EQUB &85, &9A, &A5, &BB, &85, &9B, &A5, &70
  EQUB &45, &76, &20, &0C, &9A, &48, &98, &4A
  EQUB &4A, &AA, &68, &24, &9C, &30, &02, &A9
  EQUB &00, &95, &35, &C8, &C4, &AE, &B0, &FE
  EQUB &4C, &F2, &9B, &A4, &47, &A6, &48, &A5
  EQUB &4B, &85, &47, &A5, &4C, &85, &48, &84
  EQUB &4B, &86, &4C, &A4, &49, &A6, &4A, &A5
  EQUB &51, &85, &49, &A5, &52, &85, &4A, &84
  EQUB &51, &86, &52, &A4, &4F, &A6, &50, &A5
  EQUB &53, &85, &4F, &A5, &54, &85, &50, &84
  EQUB &53, &86, &54, &A0, &08, &B1, &57, &85
  EQUB &AE, &A5, &57, &18, &69, &14, &85, &5B
  EQUB &A5, &58, &69, &00, &85, &5C, &A0, &00
  EQUB &84, &AA, &84, &9F, &B1, &5B, &85, &6B
  EQUB &C8, &B1, &5B, &85, &6D, &C8, &B1, &5B
  EQUB &85, &6F, &C8, &B1, &5B, &85, &BB, &29
  EQUB &1F, &C5, &AD, &90, &FB, &C8, &B1, &5B

 ELIF _SOURCE_DISK

  EQUB &60, &6D, &A5, &8A, &85, &6E, &A5, &8B
  EQUB &85, &6F, &A5, &8D, &85, &70, &4C, &40
  EQUB &A5, &46, &85, &46, &8B, &46, &88, &A2
  EQUB &01, &A5, &71, &85, &6B, &A5, &73, &85
  EQUB &6D, &A5, &75, &CA, &30, &FE, &46, &6B
  EQUB &46, &6D, &4A, &CA, &10, &F8, &85, &9B
  EQUB &A5, &76, &85, &9C, &A5, &8B, &85, &9A
  EQUB &A5, &8D, &20, &0C, &A3, &B0, &D2, &85
  EQUB &6F, &A5, &9C, &85, &70, &A5, &6B, &85
  EQUB &9B, &A5, &72, &85, &9C, &A5, &85, &85
  EQUB &9A, &A5, &87, &20, &0C, &A3, &B0, &B9
  EQUB &85, &6B, &A5, &9C, &85, &6C, &A5, &6D
  EQUB &85, &9B, &A5, &74, &85, &9C, &A5, &88
  EQUB &85, &9A, &A5, &8A, &20, &0C, &A3, &B0
  EQUB &A0, &85, &6D, &A5, &9C, &85, &6E, &A5
  EQUB &71, &85, &9A, &A5, &6B, &20, &E7, &39
  EQUB &85, &BB, &A5, &72, &45, &6C, &85, &9C
  EQUB &A5, &73, &85, &9A, &A5, &6D, &20, &E7
  EQUB &39, &85, &9A, &A5, &BB, &85, &9B, &A5
  EQUB &74, &45, &6E, &20, &0C, &A3, &85, &BB
  EQUB &A5, &75, &85, &9A, &A5, &6F, &20, &E7
  EQUB &39, &85, &9A, &A5, &BB, &85, &9B, &A5
  EQUB &70, &45, &76, &20, &0C, &A3, &48, &98
  EQUB &4A, &4A, &AA, &68, &24, &9C, &30, &02
  EQUB &A9, &00, &95, &35, &C8, &C4, &AE, &B0
  EQUB &FE, &4C, &F2, &A4, &A4, &47, &A6, &48
  EQUB &A5, &4B, &85, &47, &A5, &4C, &85, &48
  EQUB &84, &4B, &86, &4C, &A4, &49, &A6, &4A
  EQUB &A5, &51, &85, &49, &A5, &52, &85, &4A
  EQUB &84, &51, &86, &52, &A4, &4F, &A6, &50
  EQUB &A5, &53, &85, &4F, &A5, &54, &85, &50
  EQUB &84, &53, &86, &54, &A0, &08, &B1, &57

 ENDIF

ELSE

 SKIP 256               \ The ball line heap for storing x-coordinates

ENDIF
```

---

Right on, Commanders!

_Mark Moxon_