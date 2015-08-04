# Sound changes in Sindarin

This file is in .sc format, which means the markdown source can be copy-pasted directly into [Zompist's Sound Change Applier](http://zompist.com/sca2). A sample Common Eldarin lexicon to use with the SCA can be found in the same Github repo as this document.

## Sound Categories

Note on orthography: I use macrons (e.g. `ā`) to represent long vowels, and acute accents (`á`) to represent stress. If a vowel is both stressed and long, the combination is represented by a circumflex (`â`). Most representations of Eldarin languages don't mark stress like this, but I've done so here to get the sound change rules to work.

```code
<velar>=kkʰgŋxʒ
<nasal>=nmŋ
<coronal>=tdtʰlrszþðn
<unvoiced stop>=ptk
<aspirated stop>=pʰtʰkʰ
<voiced stop>=bdg
<labial stop>=pbpʰ
<coronal stop>=tdtʰ
<dorsal stop>=kgkʰ
<sonorant>=lrnmwj
<voiceless sonorant>=ḽr̭ṋm̭ƕç
<short vowel>=aeiouáéíóúėȯ
<unstressed vowel>=aeiouāēīōūėȯ
<stressed vowel>=áéíóúâêîôû
<unstressed short vowel>=aeiouėȯ
<stressed short vowel>=áéíóú
<long vowel>=āēīōūâêîôû
<unstressed long vowel>=āēīōū
<stressed long vowel>=âêîôû
<front vowel>=eiéíēīêî
<back vowel>=aouáóúāōūâôû
V=aeiouáéíóúāēīōūâêîôûėȯ
C=ppʰttʰkkʰdbgfþxszvðʒnmŋlrhwj
<nonstrident>=ppʰttʰkkʰdbgfþxzvðʒnmŋlrhwj
<nonzero>=aeiouáéíóúāēīōūâêîôûėȯppʰttʰkkʰdbgfþxszvðʒnmŋlrhwj
```

## Symbol Definitions (only relevant for SCA users)

```code
<velar>|G
<coronal>|Þ
<unvoiced stop>|T
<aspirated stop>|Ʈ
<sonorant>|M
<voiceless sonorant>|Ɯ
<short vowel>|H
<unstressed short vowel>|Ħ
<stressed short vowel>|Ĥ
<long vowel>|L
<unstressed long vowel>|Ł
<stressed long vowel>|Ĺ
<unstressed vowel>|À
<stressed vowel>|Á
<front vowel>|E
<back vowel>|O
<voiced stop>|B
<labial stop>|P
<coronal stop>|D
<dorsal stop>|K
<nasal>|N
<nonstrident>|Ś
<nonzero>|@
```

## Character Definitions (only relevant for SCA users)
```code
ḽ|ł
r̭|ř
ṋ|ň
m̭|ɱ

tʰ|1
kʰ|2
pʰ|3
```

## Changes Preceding Common Eldarin

Velars labialized before `w`, and `ŋʷ` became `ŋʷgʷ`
```code
w/ʷ/<velar>_
ŋʷ/ŋʷgʷ/_
```

The second vowel in a word sometimes (when?) disappeared when unstressed. NOTE: this is based on Salo 4.3, but the environments are conjectural.
```code
<unstressed short vowel>//#(C)Vk_t
<unstressed short vowel>//#(C)Vs_C
<unstressed short vowel>//#(C)V<unvoiced stop>_l
```

`s` became `z` before voiced stops.
```code
s/z/_<voiced stop>
```

Voiced stops followed by nasals at the same place of articulation underwent metathesis.
```code
dn/nd/_
bm/mb/_
gŋ/ŋg/_
```

Long vowels shortened in closed syllables.
```code
<long vowel>/<short vowel>/_CC
```

## Early changes in Common Eldarin

Stops devoiced and deaspirated before `t` and `s`.
```code
[dtʰ]/t/_[ts]
[gkʰ]/k/_[ts]
[bpʰ]/p/_[ts]
```

`tt` > `tst` > `st`
```code
/s/t_t
t//_st
```

`t` and `d` assimilated to the POA of a following stop, even across word boundaries.
```code
<coronal stop>/<labial stop>/_(·)<labial stop>
<coronal stop>/<dorsal stop>/_(·)<dorsal stop>
```

`m` and `ŋ` assimilated to `n` before nonnasal coronals.
```code
[mŋ]/n/_<coronal stop>
```

Final high vowels were laxed.
```code
i/ė/_#
u/ȯ/_#
```

Unstressed nonfinal long vowels were shortened.
```code
<unstressed long vowel>/<unstressed short vowel>/_<nonzero>
```

Final `wō` > `wā`.
```code
ō/ā/w_#
```

The suffixes `wā` and `mā` became `wē` and `mē` following `t`.
```code
ā/ē/t[wm]_
```

`āu` simplified to `ā`
```code
u//ā_
```

Initial `nd`, `ŋg`, `mb` syllabified in certain words.

```code
mbártā/ṃbártā/#_#
ndûnē/ṇdûnē/#_#
ŋgólē/ŋ̣gólē/#_#
ŋgʲô/ŋ̣gʲô/#_#
```

Where two identical consonants flanked a vowel, they collapsed into a single consonant.
```code
tVt/t/_
kVk/k/_
lVl/l/_
ndVnd/nd/_
mbVmb/mb/_
```

## Early Lindarin Changes

`gʷ` became `gw`, and the other labiovelars became labials.
```code
ŋʷgʷ/mb/_
ŋʷkʷ/mp/_
kʷ/p/_
gʷ/gw/_
```

`b` became `w` before `d`.
```code
b/w/_d
```

`g` before `d` became a glide: `j` after a front vowel, and `w` after a back vowel.
```code
g/j/<front vowel>_d
g/w/<back vowel>_d
```

`z` became `j` before a voiced stop.
```code
z/j/_<voiced stop>
```

`iw` became `jū` after a coronal.
```code
iw/jū/<coronal>_
```

Initial coronals (except s) were palatalized before `j`. The palatalization was then lost.
```code
j/ʲ/#[tdlrþðn]_
ʲ//#[tdlrþðn]_
```

`m` became `n` before a glide.
```code
m/n/_[wj]
```

`j` became `i` before a vowel.
```code
j/i/_V
```

## Changes Following the Split between the Sindar and the Amanyar Teleri

Final diphthongs in `-i` simplified.
```code
āi/ī/_#
ēi/ī/_#
ōi/ī/_#
```

The vowel of the first syllable often disappeared to form a stop-liquid consonant cluster.
```code
<unstressed vowel>/<stressed vowel>/#C<stressed vowel>r_CC/
<stressed vowel>/<unstressed vowel>/#C_rVCC/
<unstressed vowel>//[pbttʰdkgmŋ]_[r]<stressed vowel>
<unstressed vowel>//[pbkgŋ]_[l]<stressed vowel>
```

Initial nasals in these clusters then denasalized.
```code
m/b/_[lr]
ŋ/g/_[lr]
```

Final long vowels of polysyllabic words shortened.
```code
<long vowel>/<short vowel>/V…_#
```

Initial `ŋ` was fortified to `ŋg`, except in the word `ŋōle`, where it disappeared instead.
```code
ŋôle/ôle/#_#
ŋ/ŋg/_V
```

Palatalization was lost on velars.
```code
ʲ//<velar>_
```

Initial syllabic nasals gained a vowel.
```code
ṃ/am/#_
ṇ/an/#_
ŋ/aŋ/#_
```

`h` underwent many changes. It disappeared before a vowel, became `g` before a nasal, assimilated to a following `t` or `s`, and lengthened the preceding vowel before `r` or a word boundary.
```code
h//_V
h/g/_<nasal>
h/t/_t
h/s/_s
<short vowel>h/<long vowel>/_r
<short vowel>h/<long vowel>/_#
```

Stops became voiced before nasals.
```code
<unvoiced stop>/<voiced stop>/_<nasal>
```

`d` and `b` nasalized before a nasal, even across word boundaries.
```code
d/n/_(·)<nasal>
b/m/_(·)<nasal>
```

`ln` became `ll`.
```code
ln/ll/_
```

`tʰn` became `tʰtʰ` and then `ttʰ`.
```code
tʰn/tʰtʰ/_
tʰtʰ/ttʰ/_
```

`m` became `w` after a coronal or velar nasal.
```code
m/w/<coronal>_
m/w/ŋ_
```

`nt` sometimes, irregularly, became `nd`.
```code
lanta/landa/_
```

Unaspirated voiceless final stops disappeared, as did final `m`. `tʰ` then deaspirated word-finally.
```code
<unvoiced stop>//_#
m//_#
tʰ/t/_#
```

Long mid vowels raised. `i` then merged with a following long `ī`.
```code
ē/ī/_
ê/î/_
ō/ū/_
ô/û/_
iī/ī/_
iî/î/_
```

Long `ā` rounded to take the place of `ō`.
```code
ā/ō/_
â/ô/_
```

Mid vowels raised before `i`. `e` also raised before `u`.
```code
e/i/_[iíuú]
é/í/_[iíuú]
o/u/_[ií]
ó/ú/_[ií]
```

Long `ū` shortened before `i`.
```code
ū/u/_[ií]
û/ú/_[ií]
```

`j` and `i` disappeared before `ui`.
```code
[ji]//_ui
[ji]//_úi
```

`n` assimilated to the POA of a following stop, even across word boundaries.
```code
n/m/_(·)[bp]
n/m/_(·)mb
n/ŋ/_(·)[kg]
n/ŋ/_(·)ng
```

Voiceless stops aspirated after another consonant (except for `s`), even across word boundaries.
```code
<unvoiced stop>/<aspirated stop>/<nonstrident>(·)_
```

Stops in initial clusters in `s-` did aspirate, however.
```code
<unvoiced stop>/<aspirated stop>/#s_
``

Sonorants devoiced after voiceless fricatives.
```code
<sonorant>/<voiceless sonorant>/s_
```

`ts` became `ttʰ`.
```code
ts/ttʰ/_
```

In clusters with `r`, `ttʰ` simplified to `tʰ`.
```code
ttʰ/tʰ/_[r̭r]
```

`s` disappeared or changed in many positions.

`s` disappeared from initial clusters with voiceless sonorants.
```code
s//#_[ḽr̭ṋm̭ƕç]
```

After a vowel (or a preposition or article ending in a vowel), `s` assimilated to a following voiceless sonorant.
```code
<voiceless sonorant>/<voiceless sonorant>²/V(·)s_
s//V(·)_<voiceless sonorant>
```

`s` changed to `h` between vowels.
```code
s/h/V_V
```

`s` at the end of a word disappeared.
```code
s//_#
```

`ja` became `ji` before a stressed syllable.
```code
ja/ji/_(C)(C)(C)(C)<stressed vowel>
```

`ji` shortened to `i`.
```code
j//_[iīíî]
```

`ii` became long `ī`.
```code
ii/ī/_
íi/î/_
ií/î/_
```

Stressed `wo` became `wa`.
```code
wó/wá/_
```
