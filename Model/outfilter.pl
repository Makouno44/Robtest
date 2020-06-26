:- use_module(library(lists)).
:- use_module(library(codesio)).

main :-
	read_line(Line),
	main(Line, [], false).

main(end_of_file, Succ, Opt) :- !,
	(   nth1(Sink, Succ, 1)
	->  itinerary(Succ, 1, Sink, Itin, []),
	    format('itinerary = ~w\n', [Itin])
	;   true
	),
	format('opt = ~w\n', [Opt]).
main(Line, _, Opt) :-
	append("S = ", Rest, Line), !,
	append(Rest, ".", Codes),
	read_from_codes(Codes, Succ),
	write_line(Line),
	read_line(Next),
	main(Next, Succ, Opt).
main("----------", Succ, Opt) :- !,
	read_line(Next),
	main(Next, Succ, Opt).
main("==========", Succ, _) :- !,
	read_line(Next),
	main(Next, Succ, true).
main(Line, Succ, Opt) :-
	write_line(Line),
	read_line(Next),
	main(Next, Succ, Opt).

itinerary(_, Sink, Sink) --> !, [Sink].
itinerary(Succ, Cur, Sink) --> [PhyNode],
	{PhyNode is (Cur-1) mod Sink + 1},
	{nth1(Cur, Succ, Next)},
	itinerary(Succ, Next, Sink).

write_line(String) :-
	format('~s\n', [String]).

:- initialization main, halt.
