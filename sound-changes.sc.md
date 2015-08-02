# Sound changes in Sindarin

This file is in .sc format, which means the markdown source can be copy-pasted directly into [Zompist's Sound Change Applier](http://zompist.com/sca2). A sample lexicon to use with the SCA can be found at the end of this document.

## Sound Categories

Note on orthography: I use macrons (e.g. `ā`) to represent long vowels, and acute accents (`á`) to represent stress. If a vowel is both stressed and long, the combination is represented by a circumflex (`â`). Most representations of Eldarin languages don't mark stress like this, but I've done so here to get the sound change rules to work.

```code
<velar>=kgŋxʒ
<coronal>=tdtʰlrszþðn
<unvoiced stop>=ptk
<voiced stop>=dbg
<labial stop>=pbpʰ
<coronal stop>=tdtʰ
<dorsal stop>=kgkʰ
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
<nonzero>=aeiouáéíóúāēīōūâêîôûėȯppʰttʰkkʰdbgfþxszvðʒnmŋlrhwj
```

## Symbol Definitions (only relevant for SCA users)

```code
<velar>|G
<coronal>|Þ
<unvoiced stop>|T
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
<nonzero>|@
```

## Character Definitions (only relevant for SCA users)
```code
ḽ|ł
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

`t` and `d` assimilated to the POA of a following stop.
```code
<coronal stop>/<labial stop>/_<labial stop>
<coronal stop>/<dorsal stop>/_<dorsal stop>
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

Initial `nd`, `ŋg`, `mb` syllabified.

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
<unstressed vowel>//#[pbtdkgmŋ]_[r]<stressed vowel>
<unstressed vowel>//#[pbkgŋ]_[l]<stressed vowel>
```

Initial nasals in such clusters denasalized.
```code
m/b/_[lr]
ŋ/g/_[lr]
```

## Lexicon

```code
atakwē
baránda
endandorē
glibdā
glímta
jágwē
játmā
kátwā
kémtano
kírikta
kótʰtā
kʰagdā
kʰamwā
kʰarásse
kʰelkakaraksē
kʰótʰsē
laikwā
lábmē
líŋwi
lókʰsē
lótʰsē
lúktjēnē
morókō
másagā
mísidē
mísikā
negdē
netstaki
niŋkwē
néŋwi
nídwō
nôssē
nʲarna
ostotiriondō
péresta
ramja
ráŋku
ríkʰta
siwlē
sjádsḽa
sjádtā
smálu
tiwkā
tuilelindō
tárasta
tʲalja
tʰáurēnā
wédtā
wégte
wíŋta
ádnō
ákalarē
átalantā
ésedē
ókoto
úsukwē
ŋalâ
```
