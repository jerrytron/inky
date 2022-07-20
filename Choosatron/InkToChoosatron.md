# Ink to Choosatron Story Compilation

It should be noted that Ink is an extremely flexible and powerful language that allows crafting complex interactive narrative. The Choosatron story format was designed in 2013 and meant to emulate interactive game books, meaning you read content (a 'passage') until you are confronted with a set of choices. Each choice sends you to another passage followed by either another set of choices or an ending. The Choosatron spec did build on this by providing variable data storage and logic to evaluate and manipulate that data.

There are three points in the story structure that logic is allowed. First, when a passage is reached, you can apply any number of updates to your data. Second, when the choices are listed, each one can have conditional logic to determine if a particular choice should be available. Third, when a choice is selected, update logic can be applied, just like visiting a passage.

Ink goes so far beyond this. The story structure is so fundamentally different (and took me a bit to understand) that a lot of assumptions are made based on the Ink story structure to translate it to the nearest equivalent in original Choosatron format. There are also features that simply aren't supported. In this document I will show how to compile an Ink story to Choosatron, how to construct a compatible story, and what features are and are not supported.

At the end of the day, if the feature isn't demonstrated here, assume it is not supported. This was hodge-podged together to serve as a bridge until I can write new firmware to fully support the Ink language.

## Don't Use this to Learn Ink

If you haven't read the [Writing with Ink](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md) official documentation, go do that! It is tricky enough explaining how syntax will be translated to a Choosatron story without having to teach what all the syntax means in the first place. :)

## Example Ink Stories

A number of examples are provided with the compiler to help you verify the compiler is functioning, and for you to understand the available functionality and structural options. There are a few templates and two unique stories included; the first story is _Another Day at the MIA_ (`another-day.ink`). There is an alternate version of that story that just messes with the structure a bit to show off some things you can do (`another-day-alt.ink`). There are a number of variations included to show how structure can differ but still provide identical Choosatron stories in the end. In Ink, 'knots' are For instance, using 'knots' as headers to organize 'stitches' is perfectly valid. Or every passage of content can be a knot. The second story is _Revolver_ (`revolver.ink`). This demonstrates the use of logic in a story in a way that makes sense, whereas the following story examples are more about demonstrating particular capabilities and not trying to be cohesive games.

There are two 'template' stories, `choosatron-ink-template.ink` and `choosatron-ink-template-vars.ink` included. They are both meant to be useful as starting points, while having just enough content to make it clear what is happening. The latter includes the use of variables and some logic.

The `choosatron-condition-test.ink` story included tests just about every single logical function that can be run on the Choosatron. This is a great story to look at if you want to know what is possible using logic.

## Translation of Terms

For Choosatron stories there are basically two components. Passages and choices. A passage is a piece of content and may or may not be followed by a set of choices. Choices are a combination of content (the choice text) and a link to another passage.

### Passages to Knots & Stiches

In Ink, [Knots](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#3-knots) are the closest equivalent to a Passage. They can also include sub-sections called [Stitches](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#6-includes-and-stitches). For our purposes Knots and Stitches behave identically as Passages, but allow a bit of flexibility in organizing your story. 

The compiler supports having a Knot with no content followed directly by Stitches with content, or having a Knot with content followed by Stitches with content. Or, every 'Passage' in your story could just be a Knot. It's up to you.

### Choices to Choices & Diverts

Choosatron choices are a bundle of content and a link (plus optional logic we'll get into later). The equivalent in Ink is using their [Choice](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#2-choices) syntax, which consists of using a special character (a `+` or `*`) followed by content then a [Divert](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#4-diverts). Diverts are equivalent to links.

### Append to Glue

Ink has a [Glue](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#glue) command (looks like `<>`) that you follow immediately with a Divert. This has the same functionality as a Choosatron passage set to append. When you get to that passage in the story it immediately jumps to the linked passage and continues on, without even printing a newline. The player will see it as a single passage.

### Endings

Ink reserves the name **END** for indicating that your story should end. Instead of choices, you simply divert to END after the passage / knot / stitch content like so: `-> END`.

## Compiling as a Choosatron Story

If you are reading this from the Ink repository _Documentation_ folder, go ahead and navigate to [Releases](https://github.com/jerrytron/ink/releases) and download the latest. This file will also be present in the release zip file along with an examples directory that contains the same Ink stories that are in the _InkChoosatronStories_ folder in the repository. Uncompress the release and navigate to the resulting folder in a command-line.

Inside the release folder is a copy of this document, the compiler `inklecate` and related DLLs, and an _examples_ folder.

This is the structure of the Choosatron compilation command:
`./inklecate -o <story.dam> -d <story.ink>`

The `-o` is the output path and filename. Stories for the Choosatron have the extension `dam`. Without it the Choosatron will ignore them. The `-d` argument indicates that you wish to compile to the Choosatron story format and is once again provided a path and filename. For instance, if you provided `-j` instead, it would output Ink's JSON format. You can simply execute the compiler with no arguments for help output. For this example we will reference the `revolver.ink` story from the _examples_ folder. 

This will compile the revolver story to the same folder as the compiler.
`./inklecate -o revolver.dam -d examples/revolver.ink`

If we wanted to output the file into a folder called `output` it would be the following (you must create the folder first).
`./inklecate -o output/revolver.dam -d examples/revolver.ink`

If you want verbose output which will print out the parsed story structure you can add the `-v` argument.
`./inklecate -v -o revolver.dam -d examples/revolver.ink`

## What You Can't Do

Ink stories can get _crazy_. It is amazing, but again, we are reducing down to something much closer to Twine or traditional Choose-Your-Own-Adventure stories. 

* [Weaves and Gathers](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#part-2-weave)
* [Nested Flow](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#2-nested-flow)
* [Tunnels](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#1-tunnels)
* [Threads](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#2-threads)
* [Function](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#5-functions)
* [External Functions & Variables](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#7-advanced-game-side-logic)
* [Game Queries & Functions](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#9-game-queries-and-functions)
* [Variable Text](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#8-variable-text)
   * The current Choosatron firmware doesn't support variable text. Ink has strong support for using special syntax within any kind of content to alter the content itself. I am undecided on whether or not I will attempt to add support for this.
* [Temporary Variables](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#4-temporary-variables)
* [Lists](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#1-basic-lists)
   * This includes and operations or functions requiring lists and the advanced state tracking Ink examples.
* [Switch Blocks](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#switch-blocks)
* [Multiline Block](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#multiline-blocks)
* Assigning strings/content, floats, and diverts to variables are not supported.

So yeah, _a lot_. There is probably more not listed here, but hopefully this sets expectations a bit. Again, if it isn't demonstrateed in this document or the Choosatrin Ink story examples, it probably isn't supported and will cause the compiler to fail.

## Features in Progress

### Operation Subset

### [Square Brackets in Choices](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#suppressing-choice-text)

Ink allows special manipulation of the content in a choice using square brackets by optionally suppressing choice content. For digital mediums this makes a lot of sense. Have one version of the content as the choice and another for having made that choice. For example:

> + Hello [back!] right back to you!

The choice would be output as _Hello back!_ but after making the choice it would output _Hello right back to you!_.

**Current Behavior:** You can just ignore using square brackets and you'll get what you expect. If you use them, the compiler will starting content first, and post-bracket content if that isn't available.

- [ ] Update binary spec to allow for multi-part choice content.
- [ ] Update compiler to export against new spec.
- [ ] Add firmware support for choice content suppression.

### [Varying Choices](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#7-varying-choices)

As mentioned above, the choice syntax or Ink is either a `+` or `*`. The former is a [Sticky Choice](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#sticky-choices) which is always available. The latter is a once-only choice; meaning the choice will disappear from the list of choices indefinitely after being chosen.

**Current Behavior:** Until firmware is updated to support this, all choices are _Sticky_. You can still use conditions to manually set a choice to disappear from the available options.

- [x] Add choice flag to compiled story to indicate sticky or once-only.
- [x] Update binary spec labeling.
- [ ] Add firmware support to enforce this behavior.

### Visit Count

Every knot/stitch has a unique address/name. Varable names and knot/stitch names must all be unique. One reason is that Ink allows using the name of a knot/stitch in logic just like a variable. Every knot/stitch keeps track of how many times it has been visited (starting at 0). This would be easy

**Current Behavior:** I believe if you try to reference a knot/stitch in logic now it will just always be 0.

- [ ] Add compiler support reserving variable space for passage visits.
- [ ] Update binary spec.
- [ ] Add firmware support handling passage visit incrementing.

## Supported Features

### Choosatron Special Tags

Tags in Ink are a `#` followed by arbitrary content. Choosatron stories embed special metadata that defines important details about a story, such as the title, author, and more. Below is a list of each tag you can set that is compatible with the Choosatron (along with character limits if applicable).

**Note:** These tags must be at the _top_ of your Ink story file. As long as they are before and global variables and story content you are good.

|    Tag    | Max |                     Notes                    |
|:---------:|-----|:--------------------------------------------:|
| title     | 64  | The story title.                             |
| subtitle  | 32  | A subtitle to list with the title.           |
| author    | 48  | The name of the author(s).                   |
| credits   | 80  | Additional credits for the story.            |
| contact   | 128 | Displayed after story play.                  |
| language  | 3   | Not being used, just ignore.                 |
| ifid      | 36  | Ignore & title + author is used to generate. |
| published | n/a | 2020-07-02-0500 format, offset from GMT.     |
| version   | n/a | #.#.# integer format.                        |

To properly use a Choosatron Tag in a story you must use the following format:
`#title: The Greatest Story`

Space between the hash and tag is also acceptable.
`# author: Jane Jinglejam`

### Append Passage

There are three ways to force a knot/stitch to append itself to a linked knot/stitch. First is using the Glue Ink syntax `<>` followed by a divert. For example:

```
=== start ===
    You stand in a concrete room. The only visible features being the copper colored smears and cracks in the concrete. <>
    -> next
```

The content of _start_ will append to the content of _next_ without a pause or newline.

You can also use a reserved Choosatron command a single choices content. This will perform the same function. Essentially just a longform version of the previous method, but sometimes being verbose can help you keep track of your story's structure.

```
=== start ===
    You stand in a concrete room. The only visible features being the copper colored smears and cracks in the concrete.
    + <append> -> next
```

This is not a preferred syntax as it makes the strong assumption that you _didn't_ simply forgot to include content in your choice. If you have a _single_ choice and you _don't_ include content for that choice, it will be treated as an append. Currently it will output a warning to ensure you intended this. The warning may be removed in the future if this functionality doesn't cause issues, but it is better if you use either of the officially supported methods above to append.

```
=== start ===
    You stand in a concrete room. The only visible features being the copper colored smears and cracks in the concrete.
    + -> next
```

### Continue Choice

This is a Choosatron specific features. When used, instead of listing and numbering choices, it will output _Continue..._ and wait for any input to process the divert to another knot/stitch. This is a bit more elegant than listing a single choice with the number and only allowing a '1' button press.

```
=== start ===
    You stand in a concrete room. The only visible features being the copper colored smears and cracks in the concrete.
    + <continue> -> next
```

### Endings

Endings are defined by including a divert to the keyword **END** after the content of a knot/stitch.

```
=== murdered
    You stand in a concrete room. The only visible features being the copper colored smears and cracks in the concrete. You are shot from behind.
    -> END
```

A Choosatron specific feature is setting the ending quality using a special `eq` tag. This displays when reaching an ending on the Choosatron to give the player a sense of whether or not they 'won'. For example, the best ending would be the tag `#eq:5` and the worst `#eq:1`. Space between the hash and tag is ok, `# eq:3`.

The quality value can range from **1** to **5**.

```
=== murdered
    You stand in a concrete room... dead.
    # eq:1
    -> END
```

### [Fallback Choices](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#fallback-choices)

A fallback choice is essentially a choice made for the player if all other potential choices aren't available. Choices can become unavailable if they have conditional that evaluates false, or if they are once-only choices that have already been selected.

**Fallback Choice Example**
```
   * First choice. -> a_knot
   * Second choice. -> another_knot
   + -> last_resort
```

The `last_resort` divert will automatically occur if the other two choices aren't available to select.

**Current Behavior:** Fallback choices can only be used as a way to auto-forward to another knot/stitch. They cannot include any content at this time.

**Currently Unsupported**
```
   * First choice. -> a_knot
   * Second choice. -> another_knot
   + ->
      You are out of options. You lose your grip and fall. -> last_resort
```

In this case, if the fallback is triggered it will also print out content before it diverts to `last_resort`.

### Variables and Logic

There is a lot that doesn't translate to Choosatron with the variable and logic system of Ink. This section will outline exactly what you _can_ do. Outside of what is demonstrated is not supported. It is still recommended that you skim over [Ink Logic Docs](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#2-logic) before moving ahead to become familiar with the syntax.

Choosatron variables are all Int_16, meaning signed 16 bit integers (positive and negative values). Results will always reduce to this type. That means:
   * The largest and smallest supported values are **32767** and **-32768**.
   * Strings (content) and floats are not supported.
   * Storing a [story address](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#advanced-storing-diverts-as-variables) isn't supported.
   * Boolean values (in ink `true` and `false` lowercase) are fine and always reduce down to `1` and `0` respectively.

Keeping the above restrictions in mind, you can see examples of the syntax in the [Defining Global Variables](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#defining-global-variables) in the Ink docs. Below is a list of all valid definitions for Choosatron.

```
VAR a_var = 3452
VAR another = -10002
VAR a_bool = true
VAR not_true = false
```

Choosatron only supports global variables. They should be initialized right after any [Choosatron Special Tags](#choosatron-special-tags).

#### Operations

All operations listed can be used in valid assignment or conditional logic. This includes variable updates triggered by a passage or choice, and conditions applied to choices. You can also use paranthesis to ensure the proper order of operations.

|      Operation     |    Ink Syntax    |
|:------------------:|:----------------:|
| Add                |         +        |
| Subtract           |         -        |
| Divide             |         /        |
| Multiply           |         *        |
| Mod                |         %        |
| Equal              |        ==        |
| Greater            |         >        |
| Less               |         <        |
| Greater or Equal   |        >=        |
| Less or Equals     |        <=        |
| Not Equals         |        !=        |
| And                |     and / &&     |
| Or                 |     or / \|\|    |
| Random (Inclusive) | RANDOM(min, max) |
| Dice               | DICE(num, sides) |
| Not                |      not / !     |
| Negate             |         _        |
| Min                |     MIN(x, y)    |
| Max                |     MAX(x, y)    |
| Pow                |     POW(x, y)    |

#### [Logic](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#2-logic)

The Ink explanation is good to read but the basic syntax will be repeated here. With Choosatron Ink, however, here are specific places in the story format you can place assignments or conditional evaluations. We'll get into that after looking at the basic syntax.

**Assigning to a Variables**
To indicate an assignment and mathematical work will be done, the `~` symbol is used.
`~ x = x + 1`

On Choosatron we call these 'updates' as they only occur when you arrive at a new passage (knot/stitch) or after you have made a choice. Further below we'll show where to place these so they are compiled correctly for the Choosatron.

They are allows to get as complex as you like as long as the syntax is valid. Paranthesis will also ensure the operations occur in the proper order.
` x = (x * x) - (y * y) + RANDOM(1, 6)`

**Evaluating Logic as a Condition**
The following syntax will test conditions. Operational statements wrapped inside a set of curly brackets (`{ operations }`) will evaluate and return the result. For Choosatron these are only used in front of Choice content to determine if the choice will be available.
`{ not visit_paris }`

That will be true if `visit_paris` is false. Or check how much ammo the player has.
`{ bullets_left == 0 }`

### [Conditional Blocks - If/Else](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md#3-conditional-blocks-ifelse)

There is support for 'If', 'If, Else', 'If, Else If...', and 'If, Else If..., Else'. 

See the [Conditional Block](#conditional-blocks) section for explanation on current functionality.

#### Choosatron Compatible Updates

There are two valid places to put assignment operations in Choosatron Ink format, or _Updates_ in Choosatron parlance. First on arriving at a new knot/stitch and second on selecting a choice. For either, you may include as many individual updates as you like. Just be sure to give them all their own line.

**Passage Updates**
Below is not a functional story but show initializing a variable and incrementing it when you arrive at the knot. Future examples won't bother showing intialization.

```
# This glob var should be initialized above all knots/stitches.
VAR total_rides = 0

=== ride_the_carousel ===
    ~ total_rides = total_rides + 1
    It's a wonderful time! Round and round you go!
    
    + Ride again! -> ride_the_carousel
    + Go back to the plaza. -> park_plaza
```

**Tip:** When incrementing or decrementing 1, you can also use the shorthand `~ total_rides++` or `~ bullet_count--`.

Same example but with multiple updates. Add as many as you like on new lines. Then follow with the knot/stitch content. The updates **must** be after the knot/stitch definition (the unique name) and **before** the knot/stitch text content.

```
=== ride_the_carousel ===
    ~ total_rides++
    ~ money_left = money_left - 2
    It's a wonderful time! Round and round you go!

    + Ride again! -> ride_the_carousel
    + Go back to the plaza. -> park_plaza
```

**Choice Updates**
Sometimes it makes more sense to update a variable when making a choice. What if in this story there was a path where you get to ride for free? We don't want to assume you have to pay at the passage then. Let's move the `money_left` update to choosing to buy a ticket. Perhaps riding too much makes you motion sick, for the sake of showing multiple updates.

```
=== ride_the_carousel ===
    ~ total_rides++
    It's a wonderful time! Round and round you go!

    + Purchase a ticket and ride again.
        ~ money_left = money_left - 2
        ~ motion_sick++
        -> ride_the_carousel
    + Go back to the plaza. -> park_plaza
```

Just like with passage updates, just add as many updates as you need on new lines. When done, put the divert and name of the linked knot/stitch. These updates will _only_ execute if the choice is selected.

#### Choosatron Choice Conditions

Let's take the example a bit further. You don't have infinite money, so what happens when you run out? We can add a condition to the choice to purchase a carousel ticket to make sure you have enough money, or not display the choice. A condition **must** appear after the `+` or `*` choice syntax and **before** the choice text content.

In this example you start with $20 and it costs $2 per ride. The condition checks that you have at least $2 remaining.

```
VAR money_left = 20

=== ride_the_carousel ===
    ~ total_rides++
    It's a wonderful time! Round and round you go!

    + { money_left >= 2 } Purchase a ticket and ride again.
        ~ money_left = money_left - 2
        ~ motion_sick++
        -> ride_the_carousel
    + Go back to the plaza. -> park_plaza
```

You can also put the content on the next line to keep it more legible. The result is the same.

```
    + { money_left >= 2 }
        Purchase a ticket and ride again.
        ~ money_left = money_left - 2
        ~ motion_sick++
        -> ride_the_carousel
```

You can make your conditions as complex as you like. Use paranthesis to ensure they evaluate in the order you want. Notice the use of **CONST** instead of **VAR**. This just means you can't assign to `MAX_SICKNESS` or Ink will give you a warning. How you capitalize the name of your CONST or VAR is up to you, but it is a good convention to differentiate your CONSTs from your VARs. Naming them in all caps is a good way to differentiate.

```
CONST MAX_SICKNESS = 5
VAR money_left = 20

=== ride_the_carousel ===
    It's a wonderful time! Round and round you go!

    + { (money_left >= 2) && (motion_sickness < max_sickness) }
      Purchase a ticket and ride again.
        ~ money_left = money_left - 2
        ~ motion_sick++
        -> ride_the_carousel
    + Go back to the plaza. -> park_plaza
```

One more example. You _can_ have multiple condition, but keep in mind they mush _all_ be true for the choice to appear. Here's an alternate way to achieve the condition in the example above.

```
=== ride_the_carousel ===
    It's a wonderful time! Round and round you go!

    + { money_left >= 2 }
        { motion_sickness < max_sickness }
        Purchase a ticket and ride again.
        ~ money_left = money_left - 2
        ~ motion_sick++
        -> ride_the_carousel
    + Go back to the plaza. -> park_plaza
```

#### Conditional Blocks

A special condition format behaving as an 'IF' statement. If the condition is false, 0 is returned.

**A Valid 'IF' Block**
```
{ x > 0:
	~ y = x - 1
}
```

If 'x' is greater than 0, then set 'y' to 'x' - 1. The following is identical in functionality.

```
{
	- x > 0:
		~ y = x - 1
}
```

Here is the carousel example again using an IF block.

```
CONST max_sickness = 5
VAR money_left = 20
VAR time_to_vomit = false

=== ride_the_carousel ===
    It's a wonderful time! Round and round you go!

    + { (money_left >= 2) && (time_to_vomit == false) }
        Purchase a ticket and ride again.
        ~ money_left = money_left - 2
        ~ motion_sick++
        { motion_sick == max_sickness:
            ~ time_to_vomit = true
        }
        -> ride_the_carousel
    + Go back to the plaza. -> park_plaza
    + { time_to_vomit } Run to a bush and vomit.
        ~ motion_sick = 0
        ~ time_to_vomit = false
        -> park_plaza
```

You can see how quickly a choice can get complex, yet how powerful the logic is to make your story more dynamic. Here is a breakdown.
* You can only purchase a ticket to ride if you have enough money and you don't have to vomit.
* Every time you do, you lose $2 and you get a bit more motion sick.
* After 5 rides the IF block checking if your motion sickness is at its maximum, it will set the vomit variable to true.
* When having to vomit is true the choice to ride will not be available, but a new choice will become available.
* If you choose the new option to vomit in the bushes, your sickeness will be reset to 0 and vomit state set back to false.
* Now you can continue buying tickets, until you run out of money!

What started as a simple example has grown into something managing multiple states that affect the choices availabe to the player. 

Please take a look at the included story example `revolver.ink` for a complete game of high stakes using most of what you've learned here.
