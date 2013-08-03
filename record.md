I work in Pivotal's new Palo Alto office. We only have a handful of developers, and we're currently remote pairing.

A lot.

Remote pairing is ok, but we've got 2 people in SF and 3 in Palo Alto.

The 2 SF pivots come down to PA on wednesday. The other 3 are always in PA.

Since Pivotal Labs does pair programming, we need to determine pairs on a daily basis.

But there are a lot of constraints on this project:

We want to minimize remote pairing.
We have 5 people. Ideally nobody should solo more than 2 times in a week. Never three. Ideally one.
On wednesday, the whole team is together. So we want to use those days for the two SF devs to pair with PA pivots.
Since we don't usually pair people multiple days in a row, we want to try to make sure that we plan our schedule on monday and tuesday so that we transition elegantly into a PA/SF cross-pairing on wednesday while limiting remote pairing during the week.

I've never written in Prolog before, but I read about it in '7 languages in 7 weeks', and this sounds like a good problem for it solve. I'd like to try.

Let's start out with some Prolog-isms. Prolog starts off with lists of facts.

so the first facts that I'll list are which days the team is in palo alto. If they're not in Palo Alto, maybe they're somewhere else, but they can remote pair.

{{put the initial commit version of palo_alto.pl here}}

So what's next. We need to tell it some rules about pairing. Good candidates are:

Prefer pairing with somebody different from the person from yesterday.
Prefer local pairing over remote pairing.

Ok, I forgot-- if you're in sf, it's better to pair with somebody is sf than palo alto

{{second verison of palo_alto.pl}}

So how to we express the idea of pairing. Maybe we need to teach it about days of the week too?

Conceptually, what I've found frustrating about Prolog is that you seem to have to tailor your way of expressing the data to the problem you're trying to answer. Reverse engineering the data structures from the problem you think you want to solve in a counter-intuitive way. Let's see if I can explain that better later.

It seems like you have to think very hard about your overall question in order to start to do anything in prolog.

I want a schedule for monday-friday that I can repeat every week. A few different variations of optimal schedules.

Prolog is good at answering questions. For example, now that it knows who's in Palo Alto on what days, I can ask it for a list of the people in PA and SF on monday.

Working backward, that's a list of pairs for each day. We could make a "nobody" member who you never want to pair with to represent soloing. I'm not sure how else to represent soloing. Maybe we should refactor it so that sf and palo alto are nouns rather than verbs.

{{v3}}

that's kind of cool. There's a lot of typing, and it would be nice if What could also be Who or Where. But it's pretty intuitive otherwise, and just weird enough to be entertaining.

---
Lukes-MacBook-Air-2% gprolog
GNU Prolog 1.4.4 (64 bits)
Compiled Aug  2 2013, 21:44:10 with cc
By Daniel Diaz
Copyright (C) 1999-2013 Daniel Diaz
| ?- ['facts'].
compiling /Users/rukednous/workspace/paprolog/facts.pl for byte code...
/Users/rukednous/workspace/paprolog/facts.pl compiled, 29 lines read - 3305 bytes written, 7 ms

(1 ms) yes
| ?- in(What, monday, luke).

What = palo_alto ? ;

no
| ?- in(palo_alto, monday, What).

What = luke ? a

What = phil

What = don

(1 ms) no
| ?- in(palo_alto, wednesday, What).

What = luke ? a

What = phil

What = don

What = charles

What = jesse

(1 ms) yes
| ?-
---

