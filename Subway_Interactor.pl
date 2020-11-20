:- style_check(-singleton).

ask(X):-
    reset(X),
    print("Welcome!Please key in your choices carefully!"),nl,
    print("--------------------------------------------"),nl,nl,
    choose_bread(Bread),
    choose_meal(Meal),
    choose_meat(Meat),
    choose_topup(Topup),
    choose_veg(Vege),
    choose_sauce(Sauce),
    choose_set(Set),
    choose_drink(Drink),
    choose_side(Side),
    print("--------------------------------------------"),nl,
    print("Order recorded. Thank you!").

%to store user input
selected_bread().
selected_meal().
selected_topup().
selected_meat().
selected_vege().
selected_sauce().
selected_set().
selected_drink().
selected_side().

%Conditional Facts for meal Choice
choice_veggie(veg).
choice_vegan(vegan).
choice_healthy(healthy).
choice_set(set_meal).

%selections
meal([veggie, vegan, regular, healthy]).
bread([hearty_italian, wheat, multi_grain, honey_oat, flatbread]).
meat([chicken, ham, beef, pork, salmon, tuna]).
vegetable([lettuce, onion, tomato, pickle, chilli]).
healthy_sauce([honey_mustard, ranch]).
sauce([bbq, sweet_onion, mayo, ranch, honey_mustard]).
all_topup([avocado, olives, extra_meat, cheddar]).
no_cheese([avocado, olives, extra_meat]).
set([set_meal, alacarte]).
drinks([sprite, coke, ice_lemon_tea]).
side([chips, cookies]).

choose_bread(X):- print("Which bread do you prefer?"),nl,
    bread(X),maplist(writeln, X), read(Choice),
    assert(selected_bread(Choice)).

choose_meal(X):- print("What type of meal do you want?"),nl,
    meal(X),maplist(writeln, X), read(Choice),
    assert(selected_meal(Choice)).

choose_meat(X):- findall(X,(selected_meal(Y),
                            \+ choice_vegan(Y),
                            \+ choice_veggie(Y),
                            print("What meat would you like to add?"),nl,
                            meat(X), maplist(writeln,X),read(Choice),
                            assert(selected_meat(Choice))),X).

choose_topup(X):- findall(X,(selected_meal(Y),
                             choice_vegan(Y) -> (print("Please choose a vegan topping:"),nl,no_cheese(X),maplist(writeln, X),
                              read(Choice),assert(selected_topup(Choice)));(print("Please choose a topping:"),nl,all_topup(X),maplist(writeln,X), read(Choice), assert(selected_topup(Choice)))),X).

choose_veg(X):- print("What vegetables would you like to add?"),nl,
    vegetable(X), maplist(writeln,X), read(Choice),
    assert(selected_vege(Choice)).

choose_sauce(X):- findall(X, (selected_meal(Y),
                              choice_healthy(Y)->(print("Please choose a healthy sauce:"),nl, healthy_sauce(X),maplist(writeln,X),read(Choice),
                                                  assert(selected_sauce(Choice))); (print("Please choose a sauce:"),nl,sauce(X),maplist(writeln,X), read(Choice), assert(selected_sauce(Choice)))),X).

% If alacarte chosen return empty string.
% User cannot choose drinks or side.

choose_set(X):- print("Do you want a set meal or alacarte?"),nl,
                 set(X), maplist(writeln,X),
                 read(Choice), assert(selected_set(Choice)).
choose_drink(X):- findall(X, (selected_set(Z), choice_set(Z)-> print("Please choose a drink:"),nl, drinks(X), maplist(writeln,X),
                                                              read(Choice),assert(seleted_drink(Choice)));nl, X).
choose_side(X):- findall(X, (selected_set(Z), choice_set(Z)-> print("Please choose a side:"),nl, side(X), maplist(writeln,X),
                                                              read(Choice),assert(seleted_side(Choice)));nl, X).

reset(X):-
    abolish(selected_bread/1),
    abolish(selected_meal/1),
    abolish(selected_meat/1),
    abolish(selected_topup/1),
    abolish(selected_vege/1),
    abolish(selected_sauce/1),
    abolish(selected_set/1),
    abolish(selected_drink/1),
    abolish(selected_side/1).
