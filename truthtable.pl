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












