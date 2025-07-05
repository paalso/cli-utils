#!/bin/bash
# Script: inspire.sh
# This script stores an array of motivational poems in English and speaks one at random using the "say" command.

poems=(
"Awake, bold soul, embrace the light,
Rise and conquer with all your might.
Every challenge fuels your fire,
Your dreams ascend ever higher."

"Step forth into the shining day,
Let hope and courage light your way.
Within your heart, a spark resides,
Ignite it and let your spirit rise."

"Boldly face the trials ahead,
Let doubts and fears be put to bed.
Each step you take builds strength anew,
Victory waits, and it’s yours to pursue."

"In the quiet dawn, a chance is born,
A new day breaks, fresh as the morn.
Embrace the hope that lights your way,
And claim the promise of today."

"Let your heart be your guiding star,
Even when the journey seems far.
With every beat, let courage ring,
And soar on hope on fearless wings."

"Rise up, dear friend, and seize the day,
Let not the shadows lead you astray.
With passion as your steadfast guide,
Your dreams will bloom far and wide."

"Each sunrise whispers a new start,
A call to ignite the flame within your heart.
Step forward with unwavering grace,
And let your light illuminate the space."

"Unleash the strength that lies inside,
For every trial, you shall abide.
In every moment, find your fire,
And climb ever higher, ever higher."

"Stand tall and face the storm with pride,
Let courage be your constant guide.
Through every struggle, find your song,
And in your spirit, ever be strong."

"Awaken, rise, and claim your day,
Let no dark doubt hold you at bay.
With every breath, your dreams take flight,
Embrace the dawn and conquer the night."
)

# Choose a random poem from the array
index=$(( RANDOM % ${#poems[@]} ))

# Use 'say' command to speak the selected poem
say "${poems[$index]}"
