in(palo_alto, monday, luke).
in(palo_alto, tuesday, luke).
in(palo_alto, wednesday, luke).
in(palo_alto, thursday, luke).
in(palo_alto, friday, luke).

in(palo_alto, monday, phil).
in(palo_alto, tuesday, phil).
in(palo_alto, wednesday, phil).
in(palo_alto, thursday, phil).
in(palo_alto, friday, phil).

in(palo_alto, monday, don).
in(palo_alto, tuesday, don).
in(palo_alto, wednesday, don).
in(palo_alto, thursday, don).
in(palo_alto, friday, don).

in(sf, monday, charles).
in(sf, tuesday, charles).
in(palo_alto, wednesday, charles).
in(sf, thursday, charles).
in(sf, friday, charles).

in(sf, monday, jesse).
in(sf, tuesday, jesse).
in(palo_alto, wednesday, jesse).
in(sf, thursday, jesse).
in(sf, friday, jesse).

in_same_place(X, Y, Day) :- in(Z, Day, X), in(Z, Day, Y), \+(X=Y).

next_day(monday, tuesday).
next_day(tuesday, wednesday).
next_day(wednesday, thursday).
next_day(thursday, friday).

last_day(X, Y) :- next_day(Y, X).

