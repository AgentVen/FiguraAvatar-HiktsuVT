# Head
- [ ] Spend some time working out the hair.

## Mask
- [ ] Simulated Gravity on the "dangling" parts on the "mask_fox" model.

## Ears
- [ ] Ears droop as the user's percentage of health gets lower.
- [ ] Maybe when wearing a helment, the ears are forced into lower position. So that we don't have a problem with cliping.


# Body

## Tail
- [ ] Tail drops as the user gets hungrier. At 3 or less hungry points, tail is dragging on the ground.
- [ ] When sitting, the tail will be proped up like how it show on Hiktsu's live model whilst streaming.

## Jacket
- [ ] In colder biomes, the jacket closes.
- [ ] In hotter biomes, the jacket is removed.
- [ ] \(maybe) In the Nether, the jacket is removed and the turtle neck is replaced with a slimmer shirt.


# Animations
- [ ] The addition of a proper Crawling animation, instead of reusing the Swim animation. 
	> Normally, We can't detect if the player is in the "crawling state" like we can with the other states. This is because a "crawling state" doesn't exist, Mojang never added such a state. Instead it uses the "swiming state", as Crawling is just Swiming but with a few changes.\
	> With Figura, while we still don't have a "crawling state" to detect, we can create artifical detections of one. Because Figura alows us to get if the player is in the swiming state, and also if the player is in water. So we can just check for if the player is 1. Swiming and 2. Not in water.


# Other

## Global Variables
- [ ] Ability to control Mask state.

## Configuration
- [ ] For changing how the Avatar deals with certain pieces of different Armor sets when equiped.
- [ ] Whether the ears should be unchanged (default), forced into a lower position (default for Vanllia Armors' Helments), or be disabled.
	