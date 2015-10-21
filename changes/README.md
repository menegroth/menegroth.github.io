# _Lumenyárë Lambion Eldaliéva_ : A Historical View of Eldarin Languages

To run the sound changes, you will need Ruby >= 2.0.0.

## Running the Tests

You can run

```
./test > /dev/null
```

from the `changes` directory to run the test suite. If nothing is printed to STDERR, it means everything works. If you see error messages beginning with `NOT FOUND`, something's wrong; you can run `./test` to see which sequence of changes is messing up.

To see how an individual Primitive Quendian word changes in the Quenya, Telerin, and Sindarin branches, use the `./trace` script, like so:

```
./trace álakwā
```

If you run the exact command above, you'll notice that each language has multiple lines of output. For example, the Sindarin reflexes of `álakwā` are given as `alph` and `alab`. Here, only `alph` is correct; `**alab` is a misderived form. The reason for outputting multiple forms is that some of the sound changes appear to be "optional"—Tolkien may simply have applied them or not according to which resulting form he preferred, or he may have had a more formal system that eludes us due to lack of data. The best way for a computer program to handle this apparent indeterminacy is to print all plausible forms and let the human choose the most appropriate one.

## The Sound Changes

Each sound change script represents the changes that occurred between two _epochs_. I define an epoch as a (hypothetical) snapshot of a language at one point in time. For example, Common Eldarin is the last epoch that is an ancestor of both Sindarin and Quenya.

This idea of epochs is somewhat artificial. Tolkien wrote about divergent dialects that were still considered the same language, and changes _within_ a stage of a language, so that, for example, we might speak of "Early Old Sindarin" and "Late Old Sindarin". When multiple forms of a language exist, I have tried to pinpoint the latest form as the epoch.

The epochs are:

* PQ = Primitive Quendian - the ultimate ancestor of all Elvish languages
* CE = Common Eldarin - the last common ancestor of Sindarin, Telerin, and Quenya.
* EQ = Exilic Quenya - Quenya as spoken in Middle-earth
* CL = Common Lindarin - the last common ancestor of Sindarin and Telerin
* T = Telerin
* OS = Old Sindarin - a (recorded?) archaic form of Sindarin
* MS = Middle Sindarin
* CS = Classical Sindarin, as spoken in Rivendell in the Third Age

Tolkien never used the terms "Old/Middle Sindarin" himself. In the Etymologies, he listed many Old Noldorin forms; we may assume that Old Noldorin would have become Old Sindarin when Tolkien renamed the classical language and changed its place in the mythos. Middle Sindarin is, AFAICT, an term invented by David Salo to describe an intermediate stage between Old Sindarin and Classical Sindarin, but it is unclear why this particular stage of the language was chosen.

## Usage

The change scripts read a lexicon from standard input and print it back, with changes applied, to standard output. You can thus compose scripts with the unix pipe operator:

```bash
cat pq_lexicon | ruby pq_to_ce.rb | ruby ce_to_cl.rb
```

Change scripts may also take an argument, which should refer to a _golden master_ file representing the expected output from the change. If any words in the golden master file are missing from the output, a warning will be printed to standard error. This is useful when experimenting with sound changes, as it ensures the hypothesized changes don't contradict the data.

```bash
cat pq_lexicon | ruby pq_to_ce.rb ce_lexicon
```

## Lexicon Format

Words in the lexicon files are separated from their gloss by ` = ` (an equals sign surrounded by spaces), and from each other by line breaks. A `!` before a word indicates that it is irregular or an innovation, and so can't be derived via sound change rules. A leading `*` means that the word is reconstructed from an attested form in a different epoch, and is only as accurate as the sound change scripts.

Lines beginning with `#` are treated as comments–they aren't affected by sound changes or printed in the output.

## Typographic and Orthographic Conventions

I use a `+` to separate elements of a compound, and `-` to separate words that are closely associated (for example, a preposition and its object).  An acute accent over a vowel (áéíóú) marks stress; a macron (āēīōū) marks length. Where a vowel is both stressed and long, the combination is represented by a circumflex (âêîôû). Stress is marked sporadically–only where necessary for the correct sound changes to take effect. This is in part because *Tolkien* marked stress only occasionally in the Etymologies. Adding stress marking of my own would have required me to asterisk and explain forms that are attested with no indication of stress.

Late in the development of Sindarin, _overlong_ vowels arose in monosyllables. Tolkien marked these with a circumflex. I don't distinguish them from normal long vowels until the final orthographic adjustments to Classical Sindarin that present it in its LOTR-style form, since no sound changes depend on the long/overlong distinction.

In all epochs except the terminal ones (Telerin, Sindarin, and Exilic Quenya), I use `k` and `j` for their IPA values, and `ñ` for the velar nasal. Quendian roots are spelled as printed in the Etymologies of _The Lost Road_. I don't distinguish palatalization, labialization, or aspiration of consonants from full `j`, `w`, and `h`, since such distinctions are not necessary for the sound changes to work.

The lexicon files should not be used for new scholarly investigations, since the forms given are normalized and so deviate from those in the primary sources (usually without comment).
