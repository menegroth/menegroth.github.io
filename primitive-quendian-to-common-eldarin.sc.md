# Sound Changes in Eldarin

This file describes the changes that affected the Primitive Quendian language, producing Common Eldarin. Common Eldarin is the latest common ancestor of all Elvish languages except the Avarin branch.

This file is in .sc format, which means the markdown source can be copy-pasted directly into [Zompist's Sound Change Applier](http://zompist.com/sca2). A sample Common Eldarin lexicon to use with the SCA can be found in the same Github repo as this document.

## Sound Categories

Note on orthography: I use macrons (e.g. `ā`) to represent long vowels, and acute accents (`á`) to represent stress. If a vowel is both stressed and long, the combination is represented by a circumflex (`â`). Most representations of Eldarin languages don't mark stress like this, but I've done so here to get the sound change rules to work.

```code
C=ptkφθχbdgnmñwlrjhsz
V=aeiouáéíóúāēīōūâêîôûėȯ
<unstressed short vowel>=aeiou
<stressed vowel>=áéíóúâêîôû
<long vowel>=āēīōūâêîôû
<short vowel>=aeiouáéíóú
```

## Character Definitions (only relevant for SCA users)

```code
<unstressed short vowel>|A
<stressed vowel>|B
<long vowel>|C
<short vowel>|D
```

## The Phonology of Primitive Quendian

Tolkien, in _Vinyar Tengwar_ issue 46, organizes the consonants of Primitive Quendian into a grid with three _series_, echoing the organization of the later (in the internal history) tengwar.

type         | P-series | T-series | K-series
------------ | -------- | -------- | --------
stop         | p        | t        | k
aspirate     | φ        | θ        | χ
voiced stop  | b        | d        | g
nasal stop   | mb       | nd       | ñg
nasal sonant | m        | n        | ñ
oral sonant  | w        | l r      | j h

The consonant `s`, with voiced allophone `z`, existed in Primitive Quendian but did not fit into any of the series (VT46).

`j` was a consonantal y-sound. `h` may have been a voiced velar spirant. In the Etymologies, Tolkien used `ʒ` (ezh) for this sound where in War of the Jewels he used `h`. Since Primitive Quendian was a reconstructed language even inside the mythos, the exact nature of this sound cannot be determined with certainty.


## Changes Between Primitive Quendian and Common Eldarin

`s` voiced to `z` before a voiced stop.

```code
s/z/_<voiced stop>
```

`ñw` changed to `ñgw`.

```code
ñw/ñgw/_
```

Unstressed short vowels often disappeared following a stressed syllable.

Salo describes this change at (4.3); however, he includes some examples that seem to be contradicted by the Etymologies, while leaving out many relevant ones: e.g. he cites a change `ókotō -> óktō`, when the Etymologies list OKTĀ as the root yielding Noldorin _auth_.

Here I attempt to list all the examples from the Etymologies to which this change might apply.

- másagā -> másgā (Salo 4.3, Ety:MASAG)
- úsukwē -> úskwē (Salo 4.3, Ety:USUK; Tolkien lists the "reconstructed" CE form as us(u)k-wē)
- álak-wā -> álkwā "swan" (Ety:ÁLAK)
- !ásatō -> !ástō "dust" (Ety:ÁSAT) (-ō ending assumed on the basis of Q. _asto_)
- !gayasā -> !gaisā "dread" (Ety:GÁYAS)
- !gayastā -> !gaistā "to fear" (Ety:GÁYAS)
- !gayasrā -> gaisrā "dreadful" (Ety:GÁYAS)
- !golobā -> golbā "branch" (Ety:GÓLOB)
- !layakwā -> laik-wā "green" (Ety:LÁYAK)
- !nayakē -> !naikē "pain" (Ety:NÁYAK)
- ñganad- -> ñgand- "play a harp" (Ety:ÑGÁNAD)
- !oroku -> órku "orc" (Ety:ÓROK)
- !parakā -> !parkā "dry" (Ety:PÁRAK)
- !penedē -> !pendē "slope" (Ety:PÉNED)
- !phelegā -> !phelgā "cave" (Ety:PHÉLEG)
- rayak- -> raik- "crooked" (Ety:RÁYAK)
- salap- -> salp- "lick up" (Ety:SÁLAP)
- spanag- -> spang- "beard" (Ety:SPÁNAG)
- stalag- -> stalg- "stalwart" (Ety:STÁLAG)
- tarag- -> targ- "stiff" (Ety:TÁRAG)
- !telekō -> telkō "stem" (Ety:TÉLEK) (-ō ending assumed on the basis of Q. _telco_, cf. RotK/E)
- ulug- -> ulg- "monster" (Ety:ÚLUG)

And also possibly:

- eter- -> etr- "open" (Ety:ETER) if nothing else explains the loss of the vowel in "edro". If the vowel was lost at this stage, the cluster -tr- must have been changed in Quenya (if the word indeed survived in that language), since Q. does not allow the cluster -tr-. It seems no Quenya cognate exists, however.
- ánad- -> ánd- "long" (Ety:ÁNAD), but the root ANDA- is also listed
- ának- -> ánk- "bite" (Ety:ÁNAK)
- kirik- -> kirk- "sickle" (Ety:KIRIK)
- milik- -> milk- "greedy" (Ety:MIL-IK)
- mbarat- -> mbart- "doom" (Ety:MBARAT)
- wened- -> wend- "maiden" (Ety:WENED)

Examples of words in which this change did *not* occur include:

- dóron- "oak" (Ety:DÓRON)
- éned- "centre" (Ety:ÉNED)
- ének- "six" (Ety:ÉNEK)
- kánat- "four" (Ety:KÁNAT)
- néter- "nine" (Ety:NÉTER)
- néled- "three" (Ety:NÉLED)
- !nélekī "teeth" (Ety:NÉLEK) (OS form not glossed in Ety, but looks like a plural)
- phéren- "beech" (Ety:PHÉREN)
- tawar- "wood" (Ety:TÁWAR)

This sound change rule will delete the vowel from the above words. Care must therefore be taken when using its output, as it contradicts data from the Etymologies.

```code
<unstressed short vowel>//<stressed vowel>[ys]_C
<unstressed short vowel>//<stressed vowel>[lrn]_[ptkφθχbdgn]
```

Long vowels shortened in closed syllables.

```code
<long vowel>/<short vowel>/_C[ptkφθχbdgnmñlrh]
```

Voiced stops followed by nasals at the same place of articulation underwent metathesis.

```code
dn/nd/_
bm/mb/_
gñ/ñg/_
```
[Thorsten  Renk](http://www.science-and-fiction.org/elvish/rogue.html) posits a change `ds -> ts` at this stage, probably based on the development `sjadsē -> sjatsē` (Ety:SYAD). Salo places this change after the Noldor/Lindar split. Renk also places the loss of intervocalic -h- and final -a, -e, -o, as well as the lowering of final -i, before the CE stage. The loss of final -o, at least, is supported by `abaro -> abar` (WJ). It is possible that the lowering of final short -i in CE explains Q. ringe, ON. ringe < RINGI- (Ety:RINGI).

I am not sure which words are supposed to have lost -h-, since this would produce an unusual vowel hiatus; maybe `awāwiiē`?

```code
ds/ts/_
```

```code
h//V_V
```

```code
[aeo]//VC_#
i/e/_#
```
