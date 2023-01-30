# Morpheus

Morpheus is a morphological parsing tool originally written as part of the Perseus Project.
It takes Ancient Greek or Latin text as input and then lemmatizes the text and performs a morphological analysis.
For other versions of this codebase, see [PerseusDL/morpheus](https://github.com/PerseusDL/morpheus)
and [alpheios-project/morpheus](https://github.com/alpheios-project/morpheus).

## Building

### Docker

#### From Docker Hub

```bash
docker pull perseidsproject/morpheus

docker run -it perseidsproject/morpheus /bin/bash
```

(See project on [Docker Hub](https://hub.docker.com/r/perseidsproject/morpheus/).)

#### Building container

```
docker build -t morpheus .

docker run -it morpheus /bin/bash
```

### macOS

Requirements:

- Xcode command line tools

```bash
cd src/
make clean
CFLAGS='-std=gnu89 -Wno-return-type -Wno-implicit-function-declaration' make LOADLIBES='-ll'
make install
```

(Tested on Apple M1, macOS Ventura 13.1, Apple clang version 14.0.0.)

### Linux

Requirements:

- `make`
- `gcc`
- `flex`

```bash
cd src/
make clean
CFLAGS='-std=gnu89 -fcommon' make
make install
```

(Tested on Ubuntu 22.04)

### Stemlibs

The stemlibs are checked in and included in the repository.
To rebuild the stemlibs, run the following commands (with the same
`CFLAGS` used when compiling the binaries):

```
cd stemlib/Greek/
make clean
PATH="$PATH:../../bin" MORPHLIB='..' make
PATH="$PATH:../../bin" MORPHLIB='..' make

cd ../Latin/
make clean
PATH="$PATH:../../bin" MORPHLIB='..' make
PATH="$PATH:../../bin" MORPHLIB='..' make
```

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

## Tests

Requirements:

- `ruby` (~3.0)

`./test/test.rb`
