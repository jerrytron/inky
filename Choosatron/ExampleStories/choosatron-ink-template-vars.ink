// Choosatron Metadata Tags
# title: Example Title w/ Vars
# subtitle: The Epic Tale
# author: Author Person
# credits: My frans and fam.
# contact: @twitter, email, perhaps website
// If the ifid isn't present, one will be generated using the author and title as a seed.
# ifid: 00000000-0000-0000-0000-000000000000
// Date + time in hours offset from GMT.
# published: 2020-07-02-0500
# version: 1.0.0
// End of Choosatron Tags

/* --------------------------
    Constants & Variables
-------------------------- */
/* These are constants. The Inky editor won't let you alter it in your story.
   This is the speed added if you spin faster. */
CONST SPEED_BOOST = 3
// If you this fast or faster, you'll get sick!
CONST MAX_SPEED = 9
/* These are variables. To stay compatible with the Choosatron,
   this much be a positive or negative integer, or a boolean; 'true' or 'false' */
// This tracks the spinning chair speed.
VAR chair_speed = 0
// This tracks what direction you are spinning.
VAR spinning_right = false

// You need to tell the story where to begin. This is called a 'divert' and will get the ball rolling.
-> start

=== start ===
    The first passage of the story (and the three '=' mean it is an Ink 'knot'). You can also just write a knot as "=== name" without the additional "===" after the name. Or to organize differently you could skip including content in the knot and go directly to a stich which just uses one '=' before its title.
    + This is the first choice. -> passage_it_links_to
    + Let's play a little game. -> a_little_game.small_office

= passage_it_links_to
    This is a stitch. Knots and stitches help you organize, but for Choosatron you can't go crazy nesting content in deeper levels of stitches.
    + This will link to a stitch in another knot. -> another_knot.first_passage
    + This goes to the same place because 'another_not' doesn't have its own content, and 'first_passage' is the first stitch. -> another_knot

// Unlike the previous know 'start', this knot doesn't have any content directly, it goes right to a stitch.
=== another_knot
   
= first_passage
    When this is parsed, the compiler will see that 'another_knot' is just a container to help organize. You can still reference passages / stitches in other knots, just like above in the 'passage_it_links_to' stitch. Let's show off using a 'Continue...'.
    + <continue> -> test_append_next

= test_append_next
    This passsage will append to the next using Ink 'glue' syntax. <>
    -> test_append_two

= test_append_two
    If you are playing this story, you won't even realize the first append even happened. This append is a keyword for how Choosatron stories used to be written, so it is still supported.
    + <append> -> test_append_three

= test_append_three
    {
        - chair_speed > 0:
            ~ chair_speed--
    }
    {
        - chair_speed > 0:
            ~ chair_speed--
        - else:
            ~ spinning_right = false
    }
    {
        - chair_speed > 9:
            ~ chair_speed--
        - spinning_right == false:
            ~ spinning_right = true
    }
    {
        - chair_speed > 9:
            ~ chair_speed--
        - spinning_right == false:
            ~ spinning_right = true
        - else:
            ~ chair_speed = 5
    }
    Could you tell? This final append example works but the previous two methods are preferred. This one happens automatically if you only have one choice and no choice content. Forgot about this stuff. Haven't you wondered where you are in this story?
    + -> a_little_game

=== a_little_game

= small_office
    { chair_speed > 0:
        ~ chair_speed--
    - else:
        ~ chair_speed = RANDOM(1, 6)
    }
    // Since you have to spin to start, setting the speed here instead on the choices below.
    ~ chair_speed = SPEED_BOOST
    You are in a small office cubicle. It has the usual beige office junk, but in the center is a bright red chair. Not just any chair, but a Spinmaster 5000! Hard to resist an invitation like that right? Right. You sit in the chair. Let's do this.
    + You start spinning left!
        ~ spinning_right = false
        -> spin_faster
    + You start spinning right!
        ~ spinning_right = true
        -> spin_faster

= spin_again
    // The chair looses speed every turn.
    {
        - chair_speed > 0:
            ~ chair_speed--
        - spinning_right == false:
            ~ spinning_right = true
        - else:
            ~ chair_speed = RANDOM(1, 6)
    }
    The world blurs and the sensation makes you tingle!
    // By tracking the direction the choice content can be more contextual.
    + { (spinning_right == false) and (chair_speed > 0) } Give another kick spinning left!
        -> spin_faster
    + { spinning_right and (chair_speed > 0) } Give another kick spinning right!
        -> spin_faster
    + { chair_speed > 0 } Slow down.
        ~ chair_speed -= SPEED_BOOST
        { chair_speed < 0:
            ~ chair_speed = 0
        }
        -> spin_again
    + { chair_speed == 0 } Start spinning left.
        ~ spinning_right = false
        -> spin_faster
    + { chair_speed == 0 } Start spinning right.
        ~ spinning_right = true
        -> spin_faster
    + { chair_speed == 0 } Better call it a day. -> head_home

= spin_faster
    // Add to the speed here instead of every spin choice.
    ~ chair_speed += SPEED_BOOST
    Wooo you spin and spin and spin!!!
    // If you spin too fast you'll get sick!
    + { chair_speed >= MAX_SPEED } <continue> -> too_fast
    + { chair_speed < MAX_SPEED } <continue> -> spin_again

= too_fast
    The world around you is a blur, the rare points of color in the cubicle stretch until they seem to surround you. For a moment it is incredible, but then you realize something is wrong. Even as the chair slows a small amount the fluid in your head doesn't keep pace and you are overcome with nausea. You reach out your limbs to catch whatever you can, coming to an abrupt, clumsey stop. You barely make it to the trashcan before your lose your lunch!
    -> END
    
= head_home
    Wow! That is a great chair, at least for spinning. But all good things must end. You head on home feeling great!
    -> END