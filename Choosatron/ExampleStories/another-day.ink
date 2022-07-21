// Choosatron Metadata Tags
# title: Another Day at the MIA
# subtitle: test subtitle
# author: Jerry Belich
# credits: All my friends!
# contact: @jerrytron
# ifid: CA8901D9-8129-CFF6-2413-FAD496F21C63
# published: 2013-08-31-0500
# version: 1.0.0
// End of Choosatron Tags

// Begin the story.
-> start

// This version of the story uses all 'knots'.

=== start ===
    Wandering the galleries of the Minneapolis Institute of Arts, you are mentally commenting on what you see and hear. Art, art, art...artists looking at art, wanting to talk about the art they think should be there instead of the art that is. GOD.
    + Boy, I've been cynical lately. -> cynical_lately
    + I want to PUNCH the art! -> punch_the_art

=== cynical_lately
    Why is that? What is wrong with me? Have I not been arting enough?
    + Wait, arting isn't a word. -> arting_not_a_word
    + That's it, I'm going to art something FIERCE. -> art_fierce

=== arting_not_a_word
    But why not? I CREATED it. I just MADE an art! Heh...these posers are looking at art, I'm making it, in my HEAD!
    + I'm getting a headache. -> headache
    + I need to prove it somehow. -> prove_it

=== headache
    Ugh...that's right, the doctor told me if the cynicism doesn't get me, the internal dialogue will. I better take my medication.
    + Take the red pill. -> red_pill
    + Take the blue pill. -> blue_pill
        
=== red_pill 
    Eh, vitamins are always good. Huh? Aw, they're closing. I barely got to see ANY arts!
    // With this special tag you can set the ending quality, 1-5.
    # eq:2
    -> END
    
=== blue_pill
    The Ecstasy will probably calm me down. Hmm..mmm. Art is soft. I didn't realize that before. I'm gonna hug *this* guy for a while.
    + You're cute and ceramic. -> warrior_selfie
    + Nice horse warrior. -> horse_warrior

=== warrior_selfie
    Ok, *hug* and my phone...ready, and *click-slip-SMASH* OW! Oh, oh damn, I killed him! Huh, cool photo though...lemme quick tweet that. Done! Ok...oh *$@%!!! Ok, what should I do? Oh, put it back together! Heh-heh, I even keep super glue on me!
    
    ...Time passes...
    
    Phew! It took all night, but I think he looks pretty good! I better get going,though. Unemployment won't file itself!
    # eq:4
    -> END

=== horse_warrior
    Hmm? What's that? Oh...this isn't the MIA. Your horse isn't even ceramic! A cop on a horse? Oh. No, yeah, it was a vitamin. Yes, I'll stop hugging you. Wait, I still have my vitamin. It was Ecstasy, then.
    # eq:1
    -> END

=== prove_it
    Art is pain, right? Or at least,art comes from pain— kind of like charging your power meter in video games! I need POWER.
    + There are some hipsters over there! -> hipsters
    + Maybe the warriors can come out and play. *clink, clink* -> warriors

=== hipsters
    \*SMACK* *POW* *ZOOM* Right in the kisser! Man, those thick-rimmed glasses HURT, though! Ok...after taking their pelts I should have enough flannels for the rest of the winter. I better get all this into my Ford Escort Hatchback and go home.
    # eq:3
    -> END

=== warriors
    I know, back around this way...yes! The Terracotta Warriors!
    + Ride one of the horses. -> ride_horse
    + Take a photo with a warrior. -> warrior_selfie

=== ride_horse
    Unf! Ok! I got up here. Wow. This is cool! Nice horsey...*pet pet*. Huh? Why is it starting to glow?? OH. MY. GOD. It's a MAGIC HORSE! *Neigh!* I love you, warrior horse! C'mon, let's ride! *clompity clompity clomp, into the sunset*
    # eq:5
    -> END

=== art_fierce
    YES! I still have the crayons in my pocket from Denny's! Ok, there's a blank spot on the wall over there...but what to art? I need inspiration. What was the last movie I watched?
    + Jurassic Park. -> jurassic_park
    + Koyaanisqatsi. -> koyaanisqatsi

=== jurassic_park
    Oh, yeah! *long scribbles of black* Done! It's the perfect likeness of that one guy's severed arm, but it needs just a touch more red for the blood...
    + I need an artist's statement. -> artist_statement
    + I need to price it. -> price_it
    
=== artist_statement
    Ok. *scrawling...* I ARTED HERE. MOVE ALONG. Nice. I think that expresses it perfectly. Huh? The museum is closing! That's stupid. Maybe I can come back tomorrow.
    # eq:3
    -> END

=== price_it
    Let's see. I would say this is worth me not having to get a job...so $209,100.13 ought to cover it. *tap tap* Yeah? Huh? Yeah, it's mine. Really? Oh, well, I'm afraid I don't take checks. Yeah, sorry. Look, I gotta go.
    # eq:4
    -> END

=== koyaanisqatsi
    Ok, here we go. *large swirls of red, orange and yellow* There! The exhaust from a shuttle launch. Huh, even as a still life it moves about as fast as the film.
    + I need to price it. -> price_it
    + I need an artist's statement. -> artist_statement

=== punch_the_art
    \*CRACK* OW!! MUTHER@%*$ing bronze statue! Why couldn't I have been passing a triptych dissecting the philosophy of cushion softness?!?
    + I should find some ice. -> find_ice
    + Maybe the pain is GOOD. -> prove_it
    
=== find_ice
    I'll just lean on this ice sculpture. Ah...yes, that's better. What is this a sculpture of, anyway? Oh, &$@% no, a giant ice PBR can? Ok, calm down. The doc said if I don't get my cynicism under control it'll affect my lymph nodes, and then I'm DONE. *sigh*
    + Hmmm... feels loose... -> feels_loose
    + I think I need a beer. -> need_beer

=== feels_loose
    NNNGGH! There. *CRASH-SHATTER* Whoa. I'd better hide. <>
    -> warriors
    // The above uses Ink 'glue' to append. Below are two other ways to do the same thing without the '<>' glue.
    // + -> start.warriors
    // + <append> -> start.warriors
    
=== need_beer
    Oh, there's a bunch of them on the other side. *krcssssshhh* Ah...tastes like hard work I didn't have to do. I'll have a couple more...zzzzzzzzzzzz.....
    # eq:3
    -> END