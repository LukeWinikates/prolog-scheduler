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

