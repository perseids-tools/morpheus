# Morpheus

Morpheus is a morphological parsing tool originally written as part of the Perseus Project.
It takes Ancient Greek or Latin text as input and then lemmatizes the text and performs a morphological analysis.
For other versions of this codebase, see [PerseusDL/morpheus](https://github.com/PerseusDL/morpheus)
and [alpheios-project/morpheus](https://github.com/alpheios-project/morpheus).

## Building

Requirements:
- `make`
- `gcc`
- `flex`

### macOS

The Xcode command line tools come with a C compiler, make, and flex.
The following commands should compile the code
(tested on macOS High Sierra Version 10.13.5, Apple LLVM version 9.1.0).

```bash
cd src/
make clean

CFLAGS='-std=gnu89 -Wno-return-type' make LOADLIBES='-ll'
make install

cd ../stemlib/Greek/
PATH="$PATH:../../bin" MORPHLIB='..' make
PATH="$PATH:../../bin" MORPHLIB='..' make

cd ../Latin/
PATH="$PATH:../../bin" MORPHLIB='..' make
PATH="$PATH:../../bin" MORPHLIB='..' make
```

### Linux

Make sure flex is installed (`apt-get install flex` on Ubuntu).
The following commands should compile the code (tested on Ubuntu 16.04 and 18.04).

```bash
cd src/
make clean

CFLAGS='-std=gnu89' make
make install

cd ../stemlib/Greek/
PATH="$PATH:../../bin" MORPHLIB='..' make
PATH="$PATH:../../bin" MORPHLIB='..' make

cd ../Latin/
PATH="$PATH:../../bin" MORPHLIB='..' make
PATH="$PATH:../../bin" MORPHLIB='..' make
```

### Docker

#### Building container

`docker build -t morpheus-basic .`

#### Running container

`docker run -it morpheus-basic /bin/bash`

## Usage

Example usage:

```
$ echo 'a)/nqrwpos' | MORPHLIB=stemlib bin/cruncher -S
> a)/nqrwpos
> <NL>N a)/nqrwpos  masc nom sg			os_ou</NL>
```

```
$ echo 'a)nqrwpos' | MORPHLIB=stemlib bin/cruncher -S -n
> a)nqrwpos
> <NL>N a)/nqrwpos,a)/nqrwpos  masc nom sg			os_ou</NL>
```

```
$ echo 'cactus' | MORPHLIB=stemlib bin/cruncher -S -L
> cactus
> <NL>N cactus  masc nom sg			us_i</NL>
```

### Command line options

| Option | Description |
| - | - |
| -L | Set language to Latin |
| -S | Turn off Strict case. For Greek, this allows words with an initial capital to be recognized. For languages in the Roman alphabet, allows words with initial capital or in all capitals. |
| -n | Ignore accents.|
| -d | Database format. This switch changes the output from "Perseus format" to "database format." Output appears in a series of tagged fields. |
| -e | Ending index. Instead of showing the analysis in readable form, this switch gives the indices of the tense, mood, case, number, and so on (as appropriate) in the internal tables. |
| -k | Keep beta-code. When "Perseus format" is enabled (the default), this switch does nothing. When "Perseus format" is off, output (Greek as well as Latin) is converted to the old Greek Keys encoding. This switch disables that conversion so that Greek output stays in beta-code. |
| -l | Show lemma. When this switch is set, instead of printing the entire analysis, cruncher will only show the lemma or headword from which the given form is made. |
| -P | Turn off Perseus format. Output will be in the form `$feminam& is^M &from$ femina^M $fe\_minam^M [&stem $fe\_min-& ]^M & a\_ae fem acc sg^M`. Note the returns, without line feeds, between the fields. |
| -V | Analyze verbs only. |
