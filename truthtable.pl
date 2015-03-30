/* defines boolean operators "and", "or", "not"*/

:- op(1000,xfy,'and').
:- op(1000,xfy,'or').
:- op(900,fy,'not').  





/* identifies the variables in the expression */

identify_variables(N,V,V) :- member(N,[0,1]),!. 

identify_variables(X,Vin,Vout) :- atom(X), (member(X,Vin) -> Vout = Vin ; Vout = [X|Vin]).

identify_variables(X and Y,Vin,Vout) :- identify_variables(X,Vin,Vtemp),identify_variables(Y,Vtemp,Vout).

identify_variables(X or Y,Vin,Vout) :-  identify_variables(X,Vin,Vtemp),identify_variables(Y,Vtemp,Vout).

identify_variables(not X,Vin,Vout) :-   identify_variables(X,Vin,Vout).






/*Generates the initial truth assignment*/
initial_assign([],[]).
initial_assign([X|T],[0|NewList]) :- initial_assign(T,NewList).

/*Generates the next truth assignment*/
successor(A,NewList) :- reverse(A,T),next(T,N),reverse(N,NewList).

next([0|T],[1|T]).
next([1|T],[0|NewList]) :- next(T,NewList).






truth_value(N,_,_,N) :- member(N,[0,1]).
truth_value(X,Vars,A,Val) :- atom(X), lookup(X,Vars,A,Val).
truth_value(X and Y,Vars,A,Val) :- truth_value(X,Vars,A,VX), truth_value(Y,Vars,A,VY), and_op(VX,VY,Val).
truth_value(X or Y,Vars,A,Val) :-  truth_value(X,Vars,A,VX), truth_value(Y,Vars,A,VY), or_op(VX,VY,Val).
truth_value(not X,Vars,A,Val) :-   truth_value(X,Vars,A,VX), not_op(VX,Val).

lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).


/*possible boolen outcomes*/ 
and_op(0,0,0).      
and_op(0,1,0).
and_op(1,0,0).
and_op(1,1,1).

or_op(0,0,0).      
or_op(0,1,1).      
or_op(1,0,1).
or_op(1,1,1).

not_op(1,0).
not_op(0,1).




/* Prints the truth table */
tt(Boolean_exp) :- identify_variables(Boolean_exp,[],V),
         reverse(V,Vars),
         initial_assign(Vars,A),
         write('  '), write(Vars), write('    '), write(Boolean_exp), nl,
         write('-----------------------------------------'), nl,
         print_row(Boolean_exp,Vars,A),
         write('-----------------------------------------'), nl.

print_row(Boolean_exp,Vars,A) :- write('  '), write(A), write('        '), 
                       truth_value(Boolean_exp,Vars,A,V), write(V), nl,
                       (successor(A,N) -> print_row(Boolean_exp,Vars,N) ; true).



