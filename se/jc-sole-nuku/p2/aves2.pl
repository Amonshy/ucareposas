% BIRDS.NKB - a sample bird identification system for use with the
% Native shell.
% top_goal where Native starts the inference.
top_goal(X) :-
bird(X).
order(tubenose) :-
nostrils(external_tubular),
live(at_sea),
bill(hooked).
order(waterfowl) :-
feet(webbed),
bill(flat).
order(falconiforms) :-
eats(meat),
feet(curved_talons),
bill(sharp_hooked).
order(passerformes) :-
feet(one_long_backward_toe).
family(albatross) :-
order(tubenose),
size(large),
wings(long_narrow).
family(swan) :-
order(waterfowl),
neck(long),
color(white),
flight(ponderous).
family(goose) :-
order(waterfowl),
size(plump),
flight(powerful).
family(duck) :-
order(waterfowl),
feed(on_water_surface),
flight(agile).
family(vulture) :-
order(falconiforms),
feed(scavange),
wings(broad).
family(falcon) :-
order(falconiforms),
wings(long_pointed),
head(large),
tail(narrow_at_tip).
family(flycatcher) :-
order(passerformes),
bill(flat),
eats(flying_insects).
family(swallow) :-
order(passerformes),
wings(long_pointed),
tail(forked),
bill(short).

bird(laysan_albatross) :-
family(albatross),
color(white).
bird(black_footed_albatross) :-
family(albatross),
color(dark).
bird(fulmar) :-
order(tubenose),
size(medium),
flight(flap_glide).
bird(whistling_swan) :-
family(swan),
voice(muffled_musical_whistle).
bird(trumpeter_swan) :-
family(swan),
voice(loud_trumpeting).
bird(canada_goose) :-
family(goose),
season(winter),
% rules can be further broken down
country(united_states), % to include regions and migration
head(black),
% patterns
cheek(white).
bird(canada_goose) :-
family(goose),
season(summer),
country(canada),
head(black),
cheek(white).
bird(snow_goose) :-
family(goose),
color(white).
bird(mallard) :-
family(duck),
% different rules for male
voice(quack),
head(green).
bird(mallard) :-
family(duck),
% and female
voice(quack),
color(mottled_brown).
bird(pintail) :-
family(duck),
voice(short_whistle).
bird(turkey_vulture) :-
family(vulture),
flight_profile(v_shaped).
bird(california_condor) :-
family(vulture),
flight_profile(flat).
bird(sparrow_hawk) :-
family(falcon),
eats(insects).
bird(peregrine_falcon) :-
family(falcon),
eats(birds).
bird(great_crested_flycatcher) :-
family(flycatcher),
tail(long_rusty).
bird(ash_throated_flycatcher) :-
family(flycatcher),
throat(white).
bird(barn_swallow) :-
family(swallow),
tail(forked).

bird(cliff_swallow) :-
family(swallow),
tail(square).
bird(purple_martin) :-
family(swallow),
color(dark).
country(united_states) :-
region(new_england).
country(united_states) :-
region(south_east).
country(united_states) :-
region(mid_west).
country(united_states) :-
region(south_west).
country(united_states) :-
region(north_west).
country(united_states) :-
region(mid_atlantic).
country(canada) :-
province(ontario).
country(canada) :-
province(quebec).
country(canada) :-
province(etc).
region(new_england) :-
state(X),
member(X,[massachusetts,vermont,etc]).
region(south_east) :-
state(X),
member(X,[florida,mississippi,etc]).
region(canada) :-
province(X),
member(X,[ontario,quebec,etc]).
nostrils(X) :-
ask(nostrils,X).
live(X) :-
ask(live,X).
bill(X) :-
ask(bill,X).
size(X) :-
menuask(size,X,[large,plump,medium,small]).
eats(X) :-
ask(eats,X).
feet(X) :-
ask(feet,X).
wings(X) :-
ask(wings,X).
neck(X) :-

ask(neck,X).
color(X) :-
ask(color,X).
flight(X) :-
menuask(flight,X,[ponderous,powerful,agile,flap_glide,other]).
feed(X) :-
ask(feed,X).
head(X) :-
ask(head,X).
tail(X) :-
menuask(tail,X,[narrow_at_tip,forked,long_rusty,square,other]).
voice(X) :-
ask(voice,X).
season(X) :-
menuask(season,X,[winter,summer]).
cheek(X) :-
ask(cheek,X).
flight_profile(X) :-
menuask(flight_profile,X,[flat,v_shaped,other]).
throat(X) :-
ask(throat,X).
state(X) :-
menuask(state,X,[massachusetts,vermont,florida,mississippi,etc]).
province(X) :-
menuask(province,X,[ontario,quebec,etc]).
multivalued(voice).
multivalued(color).
multivalued(eats).
