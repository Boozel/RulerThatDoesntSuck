# RulerThatDoesntSuck
A TableTopSimulator ruler that doesn't suck.

PREPARING:
--------------------------------
- Open a table
- Copy the raw text in the .lua file here
- Open "Modding" (top-center of screen) > "Scripting"
- Make sure "Lua", "Auto Run", and "Global" are selected
- Paste the copied .lua text into this "Global" dialogue

Ta-da! Now you can ping models for distances instead of trying to use the ruler.

USE:
--------------------------------
- Hover cursor over a model and press Scripting 1 (default Numpad 1)
- Hover cursor over a model and press Scripting 2 (default Numpad 2)
- A dialogue will now appear at the top-center of your screen listing a 2D and 2D measurement.
- The '2D' measurement is raw X and Y - no verticality is included. Useful for fliers.
- The '3D' measurement is a vector between the models.

ISSUES:
--------------------------------
- These measurements try their best to be base-to-base, but severe verticality (e.g. bottom of ruins to top of ruins) can cause the measurement to include the height of one of the models.
- If you are trying to measure around walls, this will not help. It does direct vectors only. However, it will work with any object, so you could use tokens to measure movement in segments.

The script is bound to "Scripting 1" and "Scripting 2".
By default, these are Numpad 1 and Numpad 2. You can change the use key in the keybinding menu.
