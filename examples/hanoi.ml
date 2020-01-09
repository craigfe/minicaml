let rec hanoi = fun n a b c ->
  if n != 0 then (
    hanoi (n - 1) a c b;
    print_endline ("Move disk from pole " ^ (show a) ^ " to pole " ^ (show b));
    hanoi (n - 1) c b a
  ) else ();;

hanoi 4 1 2 3;;
