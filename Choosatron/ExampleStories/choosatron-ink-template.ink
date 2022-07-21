// Choosatron Metadata Tags
# title: Example Title
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

// You need to tell the story where to begin. This is called a 'divert' and will get the ball rolling.
-> start

=== start ===
    Here is content for the first passage in the story. This story is just a simple example and will focus on basic functionality. All the 'passages' of content are 'knots', the main container of content for Ink stories.
    + This is the first choice. -> first_choice_content
    + This is the second choice. -> second_choice_content

=== first_choice_content
    This is content resulting from choosing the first choice in the first passage. This content will output and then append directly in front of the passage we link to. First we'll end this content with a special Ink command called 'glue' which is two angle brackets together. We'll follow that up with a 'divert' (you can think of it as a link) to the next 'knot' or passage of content. Here we go! <>
    -> a_diversion

=== second_choice_content
    This is content resulting from choosing the second choice in the first passage.
    + Let's have a little diversion. -> a_diversion
    + Let's end on a high. -> a_high_note

=== a_diversion
    Zooooooooom! Woooeee what a great diversion! This content might be after making a choice, or it could look like it is part of the 'first_choice_content' because it used glue to connect right up to this passage. That's enough for one day don't you think?
    + End on a high note. -> a_high_note
    + End on a low note. -> a_low_note

=== a_high_note
    LA LA LA LAAAAAAAAA!!!!! *glass shatters*. Yikes! This is an example of an ending. You simply just include the content you want and follow it with a divert to 'END'. Before we end however, there is a special feature for the Choosatron where you can provide a value to the quality of ending. Before the end divert just add a tag (which is a hash symbol followed by text) with the text 'eq:' followed by a number one through five. If you do this for one ending you should do it for all, but also you don't need to include this.
    # eq:5
    -> END

=== a_low_note
    BWWWWAAAAAAAAAAAMMMMMM. *the earth shakes*. Maybe a bit much! Just like with 'a_high_note' let's end this. Normally if you add the 'eq' (or ending quality) tag to one ending, you add it to all, but here is an example of a regular story ending.
    -> END