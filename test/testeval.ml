open Minicaml.Types
open Util

module A = Alcotest

let plus_one = (Lambda(["n"], Plus(Symbol "n", Integer 1)))

let fib =
  (Lambda (["n"],
      (IfThenElse ((Lt ((Symbol "n"), (Integer 2))), (Symbol "n"),
         (Plus ((Apply ((Symbol "fib"), [(Sub ((Symbol "n"), (Integer 1)))])),
            (Apply ((Symbol "fib"), [(Sub ((Symbol "n"), (Integer 2)))]))))
         ))
      ))

let test_constants () =
  checkeval (Integer 32) (EvtInt 32);
  checkeval (Boolean true) (EvtBool true);
  checkeval (Unit) (EvtUnit)

let test_apply () =
  checkeval (Let(["f", plus_one], (Apply(Symbol "f", [Integer 1])))) (EvtInt 2);
  checkeval (Letrec("fib", fib, (Apply(Symbol "fib", [Integer 10])))) (EvtInt 55);
  checkeval (Letreclazy("fib", fib, (Apply(Symbol "fib", [Integer 10])))) (EvtInt 55);
  checkevalfail (Let(["f", plus_one], (Apply(Symbol "f", [Integer 1; Integer 2]))))

let test_let () =
  checkeval (Let(["f", Integer 5], Symbol "f")) (EvtInt 5);
  checkeval (Letlazy(["f", Integer 5], Symbol "f")) (EvtInt 5);
  checkevalfail (Letrec("f", Integer 5, Symbol "f"));
  checkevalfail (Letreclazy("f", Integer 5, Symbol "f"))

let test_arithmetic () =
  checkeval (Plus(Integer 4, Integer 3)) (EvtInt 7);
  checkeval (Sub (Integer 4, Integer 3)) (EvtInt 1);
  checkeval (Mult(Integer 4, Integer 3)) (EvtInt 12);
  checkevalfail (Plus (Integer 4, String "x"))

let test_boolops () =
  checkeval (And (Boolean true, Boolean false)) (EvtBool false);
  checkeval (Or (Boolean true, Boolean false)) (EvtBool true);
  checkeval (Not (Boolean true)) (EvtBool false);
  checkeval (Not (Not (Boolean true))) (EvtBool true)

let test_comparisons () =
  checkeval (Eq (Integer 5, Integer 5)) (EvtBool true);
  checkeval (Eq (Integer 5, String "x")) (EvtBool false);
  checkeval (Gt (Integer 9, Integer 3)) (EvtBool true);
  checkeval (Lt (Integer 9, Integer 3)) (EvtBool false)

let test_pipe () =
  checkeval
  (Let (
   [("f",
     (Pipe (
        (Letrec ("fib",
           (Lambda (["n"],
              (IfThenElse ((Lt ((Symbol "n"), (Integer 2))), (Symbol "n"),
                 (Plus (
                    (Apply ((Symbol "fib"),
                       [(Sub ((Symbol "n"), (Integer 1)))])),
                    (Apply ((Symbol "fib"),
                       [(Sub ((Symbol "n"), (Integer 2)))]))
                    ))
                 ))
              )),
           (Symbol "fib"))),
        (Lambda (["x"], (Plus ((Symbol "x"), (Integer 1))))))))
     ],
   (Apply (Symbol "f", [Integer 10]))))
  (EvtInt 56)

let test_sequence () =
  checkevalfail (Sequence([]));
  checkeval (Sequence([Integer 1; Integer 2])) (EvtInt 2)

let test_suite = List.map quickcase [
  ("constants", test_constants);
  ("arithmetics", test_arithmetic);
  ("boolean operators", test_boolops);
  ("comparisons", test_comparisons);
  ("let", test_let);
  ("apply", test_apply);
  ("pipe", test_pipe);
  ("sequence", test_sequence);
]