(* TAN YAO HONG BRYAN ASSIGNMENT NUMBER 2a *)


(* question 1a. *)
let rec sublist_evens l = match l with
  | [] -> []
  | x :: xs -> if x mod 2 = 0 then x :: sublist_evens xs else sublist_evens xs;;

(*question 1b. *)
let rec sublist_odds l = match l with
  | [] -> []
  | x :: xs -> if x mod 2 = 1 then x :: sublist_odds xs else sublist_odds xs;;

(*question 1c. *)
let rec double l = match l with
  | [] -> []
  | x :: xs -> 2 * x :: double xs;;

(*question 1d. *)
let rec char_list_to_int_list l = match l with
  | [] -> []
  | x :: xs -> int_of_char x :: char_list_to_int_list xs;;



(*question 2 *)
let simple_paren_match l =
  let rec helper l acc = match l with
    | [] -> acc = 0
    | x :: xs -> if acc < 0 then false
                 else if x = '(' then helper xs (acc + 1)
                 else helper xs (acc - 1)
  in helper l 0;


  
(*true cases*)
let test3 = ['('; '('; ')'; '('; ')'; ')'; '('; ')'];;
let test4 = ['('; '('; '('; ')'; ')'; ')'];;
let test5 = ['('; ')'; '('; ')'; '('; '('; ')'; ')';];;
(*false cases*)
let test1 = ['('; '('; ')'];;
let test2 = ['('; ')'; '('; '('; ')'];;
let test6 = ['('; ')'; ')'; '('; ')'];;
let test7 = [')'; '('; '('; ')'; ')'];;
(*my own cases*)
let testa = [')'; ')'; ')'; ')'; '('; '('; '('; '('];;
let testb = [')'; '('; ')'; '('];;
let testc = ['('; '('; ')'; ')'; ')'; '('];;
let testz = test3 @ test3 @ test3 @ ('(' :: test4) @ (')' :: test3);;
                                     
