# Sound changes in Sindarin

This file is in .sc format, which means the markdown source can be copy-pasted directly into [Zompist's Sound Change Applier](http://zompist.com/sca2). A sample lexicon to use with the SCA can be found at the end of this document.

## Sound Categories

```code
<velar>=kgŋxʒ
<unvoiced stop>=ptk
<voiced stop>=dbg
<labial stop>=pbpʰ
<coronal stop>=tdtʰ
<dorsal stop>=kgkʰ
<short vowel>=aeiouáéíóúėȯ
<unstressed short vowel>=aeiouėȯ
<stressed short vowel>=áéíóú
<long vowel>=āēīōūâêîôû
<unstressed long vowel>=āēīōū
<stressed long vowel>=âêîôû
V=aeiouáéíóúāēīōūâêîôûėȯ
C=ppʰttʰkkʰdbgfþxvðʒnmŋlrsz
<nonzero>=aeiouáéíóúāēīōūâêîôûėȯppʰttʰkkʰdbgfþxvðʒnmŋlrsz
```

## Symbol Definitions (only relevant for SCA users)

```code
<velar>|G
<unvoiced stop>|T
<short vowel>|H
<unstressed short vowel>|Ħ
<stressed short vowel>|Ĥ
<long vowel>|L
<unstressed long vowel>|Ł
<stressed long vowel>|Ĺ
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

̭̭Stops devoiced and deaspirated before `t` and `s`.
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

## Lexicon

```code
atakwē
laikwā
jágwē
néŋwi
líŋʷi
ókoto
ésedē
mísidē
mísikā
másagā
úsukwē
ákalarē
átalantā
lábmē
ádnō
nôssē
sjádsḽa
kʰótʰsē
lótʰsē
lókʰsē
sjádtā
wédtā
kótʰtā
ríkʰta
wégte
glímta
kémtano
wíŋta
netstaki
smálu
ráŋku
tʰáurēnā
lúktjēnē
nídwō
kátwā
játmā
```