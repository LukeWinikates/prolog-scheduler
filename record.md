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

hat = wednesday ? ;

What = thursday ? ;

What = friday ? ;

no
| ?- in(What, wednesday, luke).

What = palo_alto ? ;

no
| ?- in(What, wednesday, What).

no
| ?- in(What, wednesday, Why).

What = palo_alto
Why = luke ? ;

What = palo_alto
Why = phil ? ;

What = palo_alto
Why = don ? ;

What = palo_alto
Why = charles ? ;

What = palo_alto
Why = jesse ? ;

(1 ms) no
| ?- in(What, monday, Why).

What = palo_alto
Why = luke ? ;

What = palo_alto
Why = phil ? ;

What = palo_alto
Why = don ? ;

What = sf
Why = charles ? ;

What = sf
---

Oh, crazy. I can use an Capitalized symbol as a variable to filled in with possible solutions.

Let's add a rule. Two Pivots are a good pair if they're in the same place on the same day. There will be other criteria. And Prolog is better at "solve for X" than it is at "optimize for X" (which is a problem with different algorithmic complexity(?))

Turns out order of operations matters a lot. if I express my rule with the X != Y part first, I get no matches for some of my scenarios. Putting it last seems to work better.

good_pair(X, Y, Day) :- \+(X=Y), in(Z, Day, X), in(Z, Day, Y).

vs

good_pair(X, Y, Day) :- in(Z, Day, X), in(Z, Day, Y), \+(X=Y).


we should rename that to same_place

a quick mention-- I was reading about Git Best Practices (committing often for checkpointing purposes, even when you don't have a good state per se). I also watched the latest video from the WorryDream guy, which briefly mentioned Prolog under the heading of goal-based programming. That inspired my approach for writing this blog post, both in terms of experimenting with Prolog and with keeping the git log of the composition of this post.


---
moving on: I want to end up with a data structure representing a schedule. It could look something like this:

monday: [
  pair(luke, phil).
  pair(jesse, charles).
  solo(don)
]

tuesday: [
  pair(luke, charles).
  pair(jesse, don).
  solo(phil).
]

wednesday: [
  pair(charles, don).
  pair(phil, jesse).
  solo(luke)
]

thursday: [
  pair(don, luke).
  pair(charles, phil).
  solo(jesse).
]

friday: [
  pair(luke, jesse).
  pair(don, phil).
  solo(charles).
]

I've just written a tolerable schedule for our rotation: everybody solos once; we remote pair 3 days.

I think we can define this in terms of rules using Prolog data structures without too much trouble. solo(X) is a pair of (X) and the mystery symbol nobody.

A schedule is a day plus a list such that all people have a pair (including solo). In fact maybe solo(X) is just pair(X); pair with an arity of 1 instead of 2.

A week_schedule is a schedule for the five work days of the week, such that people don't pair on consecutive days.

I think that this is a feasible way to build this up. Prolog will solve all possible schedules for us. Maybe then we can add additional constraints to make it find the best possible schedule (1 day of soloing, SF pivots pair with PA pivots on wednesday, no repeat pairing, no soloing for new people, nobody remote pairs more than twice). Or maybe we can attach scores to schedules based how many times these rules are violated, and let prolog churn them all out and then rank them. That wouldn't be terribly efficient, but for N of 5, we might not need to worry about its Big-O properties.

---

refining this somewhat, we can define a schedule more easily by using a plain old list. It must be only people, and there must be no duplicates. It needs to also ensure that it includes ALL the people.

Maybe it's time to revisit how to ask the question. I'd like to be able to constrain it in various ways, computing a full week's or partial week's schedule. It needs to plan for wednesday's constraints on the earlier days of the week. But given a free enough hand, Prolog probably does this already.

----
A revelation: In prolog, rules look like functions, but they're not. A function has inputs and produces output. Prolog rules have arity, but what any parameter can be left out. A prolog rule can be invoked in many directions, and can act like many functions at once: up to N! directions, where N is the arity of the rule.
