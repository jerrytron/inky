// Choosatron Metadata Tags
# title: Revolver
# subtitle: The Loaded Gun
# author: Jerry Belich
# credits: Thanks to all my fans!
# contact: @j3rrytron
# ifid: 48914AC1-C99F-36DD-F5E6-7C2A0B0BE5B6
# published: 2020-07-02-0500
# version: 1.0.0
// End of Choosatron Tags

/* --------------------------
    Constants & Variables
-------------------------- */
// The gun can only hold 6 bullets.
CONST MAX_BULLETS = 6
// If you survive this many times you win!
CONST ROUNDS_TO_WIN = 5
// How many rounds of the game played (not ammunition rounds).
VAR rounds = 0
// The active chamber in the gun.
VAR chamber = 1
// If the chamber has spun since adding bullets.
VAR spun_chamber = false
// The number of bullets in the gun.
VAR bullets = 0

// Begin the story.
-> start

=== start ===
    // Using glue '<>' then '->' navigate to and append onto 'revolver'.
    You stand in a concrete room. The only visible features being the copper colored smears and cracks in the concrete. <>
    -> revolver

= revolver
    You feel the heft and cool sensation of the revolver in your hand.
    // Don't allow adding a bullet if the gun is full.
    // If gun is empty, reset the spun chamber state.
    + { bullets < MAX_BULLETS } Load a bullet into the gun.
        { bullets == 0:
            ~ spun_chamber = false
        }
        ~ bullets++ // Add a bullet.
        -> load_the_gun
    // Don't spin unless there are any bullets.
    + { bullets > 0 } Spin the barrel.
        ~ chamber = RANDOM(1, MAX_BULLETS) // Randomize the current chamber.
        ~ spun_chamber = true // Ok to fire after spinning.
        -> spin_the_barrel
    // To fire, must have bullets and chamber must be spun.
    // This choice and the next look the same, but this is the 'success'
    // choice where the next is the 'failure'. They will never both be visible.
    // If the chamber values is greater than the number of bullets, success!
    + { (bullets > 0) && spun_chamber && (chamber > bullets) } Fire the gun.
        ~ bullets--
        ~ chamber++
        { chamber > MAX_BULLETS:
            ~ chamber = 1
        }
        -> survive
    // Must have bullets and spun the chamber. Unfortunately the chamber
    // results is equal or lower than the bullets, so failure.
    + { (bullets > 0) && spun_chamber && (chamber <= bullets) } Fire the gun.
        -> dead
    
= load_the_gun
    You slide a bullet into one of the free chambers. <>
    -> revolver

= spin_the_barrel
    You spin the revolvers barrel, listening to the whir until it stops with a *click*. <>
    -> revolver

= survive
    // Keep track of rounds.
    ~ rounds++
    You feel a flood of fear until you hear the deafening sound of the hammer slamming down. To your relief, nothing follows after.
    + Play another round. -> revolver
    + Unload and pass the gun.
        ~ bullets = 0
        ~ spun_chamber = false
        -> revolver
    + { rounds < ROUNDS_TO_WIN } Give up and walk away. -> stop
    + { rounds >= ROUNDS_TO_WIN } Accept your survival award and retire.
        -> accept_award

= dead
    You feel your mind expand... literally. Blood and bone splatter across the concrete floor, reviving the dark copper palette.
    -> END

= accept_award
    It was an incredible risk, but you made it through! A handsome sum of money is transferred to your account and a Certificate of Dumb Luck will be mailed to your home already framed. <>
    -> stop

= stop
    You place the gun down on a nearby cart, and walk away alive.
    -> END