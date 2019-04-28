# dice

Generate passphrase from diceware (or other source of your choosing).

Optionally initiate your own dictionary by running diceware_convert.lua:

```
lua diceware_convert.lua inputfile.txt
```

This will create the file diceware.lua. Put diceware.lua in the same directory as dice.lua.

Then you can invoke dice with e.g.

```
lua dice.lua 5
```

to generate 5 dictionary lookups.
