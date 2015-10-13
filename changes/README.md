# Sound changes in Sindarin

To run the sound changes, you will need Ruby >= 2.0.0.

Each sound change script represents the changes that occurred between two _epochs_. I define an epoch as a (hypothetical) snapshot of a language at one point in time. For example, Common Eldarin is the last epoch that is an ancestor of both Sindarin and Quenya.

This idea of epochs is somewhat artificial. Tolkien wrote about divergent dialects that were still considered the same language, and changes _within_ a stage of a language, so that, for example, we might speak of "Early Old Sindarin" and "Late Old Sindarin". When multiple forms of a language exist, I have tried to pinpoint the latest form as the epoch.

The epochs are:

* PQ = Primitive Quendian - the ultimate ancestor of all Elvish languages
* CE = Common Eldarin - the last common ancestor of Sindarin, Telerin, and Quenya.
* EQ = Exilic Quenya - Quenya as spoken in Middle-earth
* CT = Common Telerin - the last common ancestor of Sindarin and Telerin
* T = Telerin
* OS = Old Sindarin - a (recorded?) archaic form of Sindarin
* CS = Classical Sindarin, as spoken in Rivendell in the Third Age

## Usage

The change scripts read a lexicon from standard input and print it back, with changes applied, to standard output. You can thus compose scripts with the unix pipe operator:

```bash
cat pq_lexicon | ruby pq_to_ce.rb | ruby ce_to_ct.rb
```

Change scripts may also take an argument, which should refer to a _golden master_ file representing the expected output from the change. If any words in the golden master file are missing from the output, a warning will be printed to standard error. This is useful when experimenting with sound changes, as it ensures the hypothesized changes don't contradict the data.

```bash
cat pq_lexicon | ruby pq_to_ce.rb ce_lexicon
```

## Lexicon Format

Words in the lexicon files are separated from their gloss by ` = ` (an equals sign surrounded by spaces), and from each other by line breaks. Symbols may precede a word to indicate that it should not be treated as authoritative when using that lexicon as a golden master. A leading `!` indicates that a word is irregular or an innovation, and so can't be derived via sound change rules. A leading `*` means that the word is reconstructed from a later attested form.
