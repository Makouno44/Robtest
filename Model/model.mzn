include "globals.mzn";

int: n;

set of int: node = 1..n;
set of int: butsink = 1..n-1;

array[int,int] of int: costtab;

int: maxcost = min(costtab[..,4]);

array[node] of var node: S;
array[node] of var node: P;
array[butsink] of var maxcost..0: C;

var int: cost = sum(C);

constraint
  inverse(S, P) :: domain;

constraint
  S[n] = 1;

constraint
  subcircuit(S) :: domain;

constraint
  forall(i in butsink)(
    table([i,S[i],P[i],C[i]], costtab)
  );

solve
  :: int_search(C, max_regret, indomain_min, complete)
  minimize cost;

output
  ["S = \(S)\nP = \(P)\ncost = \(-cost)\n"];
