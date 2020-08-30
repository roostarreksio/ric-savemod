# ric-savemod
A mod for Rex and Wizards game that reorganizes save-state files.

---

### How to install:
* Download the latest release ZIP [here](https://github.com/roostarreksio/ric-savemod/releases/latest). 
* Copy contents of the archive to your game's installation folder (e.g. *C:/Program Files/AidemMedia/Reksio i Czarodzieje*)
* Start the "*ric-savemod.bat*" file and continue with instructions on screen.

Before changing any files, the script crates **backups** of all the required files, and saves them with **.bak* extension. Those files can be restored using the second *(2)* option in the installer.

#### **! Important:**

If the game is installed in a folder on system drive, running the .bat file as **Administrator** is required! Otherwise the script can't modify any files.

---

After installation, savestate files will be saved in "Common\save\" folder, and individual slots will be saved to matching folders. Also, all savestate files from the slots are now interchangable.

![](https://i.imgur.com/RzIUHwV.jpg)

---

*Note:* This is still an experimental mod, which needs more testing to make sure it is stable.

---

### The script uses:

[fart-it](https://github.com/lionello/fart-it) by [lionello](https://github.com/lionello/) to modify game files

 [AMkd](https://github.com/Dove6/AMkd) by [Dove6](https://github.com/Dove6) to decode game files
