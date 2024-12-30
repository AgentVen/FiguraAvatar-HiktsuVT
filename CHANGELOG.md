# Guide
- 3<sup>rd</sup> Headings are formated as `<release-type> <DD>/<MM>/<YYYY> #<number-of-release-that-day>`
- Releases are listed here starting from the top newest down to the to oldest.


# Changes

### Dev. Update 29/12/2024 #1
- Added a "Changes" Header to `CHANGELOG.md`.
- Due to potentially needing to have to *very* closely handle the Tail's gapfilling and animations, the `scripts/FoxTailGapfill.lua` script was renamed to `scripts/FoxTailHandler.lua`. *(this might actually be subject to being reverted.)*
- I believe I've figured out how to get the gapfilling functionality to actually work! *(after literal weeks, heck months!)* An implementation is in the works!
- The belt has been Modelled given a *Basic* texture, *Proper* texturing still needs to be done.
- `textures/skin.png` has been renamed to `textures/skin_jacket.png`, and a slightly modified copy of it has been added called `textures/skin.png` *(ironic isn't)*.
  - The modifications in question made, simply remove the jacket letting the turtle next underneath be seen.
  - This so to allow "taking the jacket off". *(This implementation may be subject to be replaced)*
- A bit of geometry on the Left & Right Arms have been added that give the "rolled-up" part of the jacket a unique visual.
- A small cube has been added between the Head and the Body in the "Neck" region called the `TurtleNeck`.
- A mesh has been added to the back of the torso, made to look like the Hood. (***VERY*** incomplete! I didn't even fix its UV mapping.)

### Dev. Update 15/12/2024 #1
- Started work on Gapfilling functionality for the Tail. (`scripts/FoxTailGapfill.lua`)
- Finalized the *"Hair Plates"*. These add depth to the parts of the Head Layer (Hat) that are ment to be part of the hair.
  - Also created a copy of the "Hair Plates" (`models/.hair_plates.bbmodel`) for if modifications are made. And we need to restore them.

### Dev. Update 12/12/2024 #2
- Updated `README.md`. Added "quick access" links to the `TODO.md` & `CHANGELOG.md` files.
- Fixed `TODO.md` formating.

### Dev. Update 12/12/2024 #1
- Added `CHANGELOG.md` *(this file)*, to track changes between Releases.
- Updated `README.md` formating. Changed out the "NOTE:" header for GitHub's "NOTE" alert.
- Turned `TODO.txt` into `TODO.md` and added formating.