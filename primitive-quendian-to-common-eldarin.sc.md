# Sound Changes in Eldarin

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

`j` was a consonantal y-sound. `h` may have been a voiced velar spirant. In the Etymologies, Tolkien used `ʒ` (ezh) where in War of the Jewels he used `h`. Since Primitive Quendian was a reconstructed language inside the mythos, the exact nature of this sound cannot be determined with certainty.


## Changes Between Primitive Quendian and Common Eldarin

`s` voiced to `z` before a voiced stop.

```code
s/z/_<voiced stop>
```

`ñw` changed to `ñgw`.

```code
ñw/ñgw/_
```

Unstressed short vowels often disappeared following a stressed syllable. Most of the resulting consonant clusters would be allowed by Quenya phonology, though a few would change further in later Quenya, e.g. `kl -> lc`

Examples of words that underwent this change include:
- ókotō -> óktō (Salo 4.3) (though the Etymologies list OKTĀ as the root yielding N. _auth_.)
- ésedē -> esdē (Salo 4.3) (Ety. has root EZDĒ)
- mísidē -> mísdē (Salo 4.3) (this example seems erroneous; the Etymologies list a stem MIZD, while Salo:305 marks a stem MÍS-ID as conjectural. It seems more likely that the root of this word was a single syllable.)
- mísikā -> mískā (Salo 4.3) (Ety. lists root MISK)
- másagā -> másgā (Salo 4.3, Ety:MASAG)
- úsukwē -> úskwē (Salo 4.3, Ety:USUK; Tolkien lists the "reconstructed" CE form as us(u)k-wē)
- ákalarē -> áklarē (Salo 4.3) (Ety. lists root AKLA-R-)
- átalantā -> átlantā (Salo 4.3) (It seems to me extremely unlikely that the disappearance of -a- occurred at this early stage; Q. has _atalante_)
- álak-wā -> álkwā "swan" (Ety:ÁLAK)
- ásat- -> ást- "dust" (Ety:ÁSAT)
- gayas- -> gais- "fear" (Ety:GÁYAS)
- golob- -> golb- "branch" (Ety:GÓLOB)
- layak- -> laik- "green" (Ety:LÁYAK)
- nayak- -> naik- "pain" (Ety:NÁYAK)
- ñganad- -> ñgand- "play a harp" (Ety:ÑGÁNAD)
- orok- -> ork- "orc" (Ety:ÓROK)
- parak- -> park- "dry" (Ety:PÁRAK)
- pened- -> pend- "slope" (Ety:PÉNED)
- pheleg- -> phelg- "cave" (Ety:PHÉLEG)
- rayak- -> raik- "crooked" (Ety:RÁYAK)
- salap- -> salp- "lick up" (Ety:SÁLAP)
- spanag- -> spang- "beard" (Ety:SPÁNAG)
- stalag- -> stalg- "stalwart" (Ety:STÁLAG)
- tarag- -> targ- "stiff" (Ety:TÁRAG)
- telek- -> telk- "stem" (Ety:TÉLEK)
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
- nélek- "tooth" (Ety:NÉLEK)
- phéren- "beech" (Ety:PHÉREN)
- tawar- "wood" (Ety:TÁWAR)

Interestingly, all of these words later lost the unstressed vowel in Quenya, but preserved it in Sindarin. This leads me to believe that certain environments caused the unstressed second vowel to be preserved in CE - perhaps the very same environments that conditioned its loss in Quenya.

```code
<unstressed short vowel>//<stressed vowel>k_[lstw]V
<unstressed short vowel>//<stressed vowel>l_[kdlmptwj]V
<unstressed short vowel>//<stressed vowel>m_[bmnpj]V
<unstressed short vowel>//<stressed vowel>n_[kdgntwj]V
<unstressed short vowel>//<stressed vowel>n_gwV
<unstressed short vowel>//<stressed vowel>[nrls]_kwV
<unstressed short vowel>//<stressed vowel>[nrks]_tjV
<unstressed short vowel>//<stressed vowel>p_[st]V
<unstressed short vowel>//<stressed vowel>r_[kdmnrtswj]
<unstressed short vowel>//<stressed vowel>s_[kstw]
<unstressed short vowel>//<stressed vowel>t_[stwj]
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
[Renk](http://www.science-and-fiction.org/elvish/rogue.html) posits a change `ds -> ts` at this stage that Salo does not mention. He also places the loss of intervocalic -h- and final -a, -e, -o, as well as the lowering of final -i, before the CE stage. It is possible that the lowering of final short -i in CE explains Q. ringe, ON. ringe < RINGI- (Ety:RINGI)
