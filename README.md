# Notoriety Auto "Win"
```diff
- Discontinued
```

An Open-Source Script that basically finishes one heist in around 23 to 28 seconds.

You should get 90M cash every 15 minutes, if you put this into the auto-execute folder.

## Source

 - [Shadow Raid Heist](https://raw.githubusercontent.com/frel0/notoriety-autowin/main/heists/shadow-raid.lua)
 - [Loader](https://raw.githubusercontent.com/frel0/notoriety-autowin/main/main.lua)

## Script

```lua
shared.Heist = "Shadow Raid"
shared.DenyIfMaxLevel = false

loadstring(game:HttpGet("https://raw.githubusercontent.com/wintermyfavss/notoriety-autowin/main/main.lua"))();
```

## FAQ

#### How do i use this?

1. Make sure you are in the lobby, not in-game.
2. Execute the script.
3. boom, youre done. (dont click anything, it will do everything for you.)

#### Will this get me banned?

No.

#### What does DenyIfMaxLevel do?

If your level is 100 (max level), the auto-win will stop so you can do a rebirth or whatever the hell u wanna do
