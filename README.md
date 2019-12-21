# A localizable version of [**Pokémon Yellow**][pokeyellow] disassembly
## Working branch of a Czech localization

* Makefile and some structures modified to allow building multiple images for different languages
* Each new language requires makefile modifications and some elif through the code (as some texts are spread accross multiple files - menu, options etc.)
* The original image output still matches the original (can be checked with `make compare`), md5 of new image(s) is not checked as the translation is still a work-in-progress

## Original README of [**Pokémon Yellow**][pokeyellow]

# Pokémon Yellow

This is a disassembly of Pokémon Yellow.

It builds the following rom:

* Pokemon Yellow (UE) [C][!].gbc  `md5: d9290db87b1f0a23b89f99ee4469e34b`

To set up the repository, see [**INSTALL.md**](INSTALL.md).


## See also

* Disassembly of [**Pokémon Red/Blue**][pokered]
* Disassembly of [**Pokémon Gold**][pokegold]
* Disassembly of [**Pokémon Crystal**][pokecrystal]
* Disassembly of [**Pokémon Pinball**][pokepinball]
* Disassembly of [**Pokémon TCG**][poketcg]
* Disassembly of [**Pokémon Ruby**][pokeruby]
* Disassembly of [**Pokémon Fire Red**][pokefirered]
* Disassembly of [**Pokémon Emerald**][pokeemerald]
* Discord: [**pret**][Discord]
* irc: **irc.freenode.net** [**#pret**][irc]

[pokeyellow]: https://github.com/pret/pokeyellow
[pokered]: https://github.com/pret/pokered
[pokegold]: https://github.com/pret/pokegold
[pokecrystal]: https://github.com/pret/pokecrystal
[pokepinball]: https://github.com/pret/pokepinball
[poketcg]: https://github.com/pret/poketcg
[pokeruby]: https://github.com/pret/pokeruby
[pokefirered]: https://github.com/pret/pokefirered
[pokeemerald]: https://github.com/pret/pokeemerald
[Discord]: https://discord.gg/d5dubZ3
[irc]: https://kiwiirc.com/client/irc.freenode.net/?#pret
