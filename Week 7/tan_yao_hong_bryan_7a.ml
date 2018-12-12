(* TAN YAO HONG BRYAN ASSIGNMENT no. 7a *)

(* question 1 *)
(* question 1 non-EC solution *)
let mapi f l =
  let rec mapi_helper f acc l =
    match l with
    | [] -> []
    | x :: xs -> (f acc x) :: mapi_helper f (acc + 1) xs
  in mapi_helper f 0 l;;

(*question 1 EC solution *)

let rec fold_right f b l=
  match l with
  | [] -> b
  | x :: xs -> f x (fold_right f b xs);;
let length l =
  fold_right (fun _ p -> p + 1) 0 l;;

let mapi f l =
  fold_right (fun a b -> (f ((length l) - (length b) - 1) a) :: b) [] l;;

                           
(* question 2 with EC (not using a tree-based dictionary) *)


let rec traverse parcel l =
  match l with
  | [] -> false
  | x :: xs -> if parcel = x then true
               else traverse parcel xs;;

let rec fill_queue l q =
  match l with
  | [] -> q
  | x :: xs -> (match q with
                |(inbox, outbox) -> if traverse x inbox = false
                                    then fill_queue xs (x :: inbox, outbox)
                                    else fill_queue xs (inbox, outbox));;

let rev l =
  let rec rev_helper l acc =
  match l with
  | [] -> acc
  | x :: xs -> rev_helper xs (x :: acc)
  in rev_helper l [];;


let rec empty_outbox q =
  match q with (inbox, outbox) ->
    match outbox with
    | parcel :: outbox_t -> parcel :: empty_outbox (inbox, outbox_t)
    | [] -> (match inbox with
             | [] -> []
             | _ -> empty_outbox ([], rev inbox));;
                 

let remove_duplicates l =
  empty_outbox (fill_queue l ([], []));;

(* question 3 *)
(* i don't know if this counts for extra credit, but I could generate n=15 in 30 seconds on my computer*)

let brackets = [['(']; ['[']; ['{']];;
let brackets1= ['('; '['; '{'];;

let rev l =
  let rec rev_helper l acc =
    match l with
    | [] -> acc
    | x :: xs -> rev_helper xs (x::acc)
  in rev_helper l [];;

let map_g f l =
  let rec map_helper f acc l =
    match l with
    | [] -> rev acc
    | x :: xs -> map_helper f ((f x) @ acc) xs
  in map_helper f [] l;;

        
let rec fold_left f acc l =
  match l with
  | [] -> acc
  | x :: xs -> fold_left f (f acc x) xs;;

let rec create x =
  fold_left (fun a b -> (b::x)::a) [] brackets1

let rec generate n =
  if n = 0 then []
  else if n = 1 then brackets
  else map_g create (generate (n-1));;


let form_matching_parentheses l s =
  l @ (rev (map_g (fun a -> if a = '(' then ')'::s else if a = '[' then ']'::s else '}'::s) l));;

let rec generate_matching_parentheses lol acc =
  match lol with
  | [] -> rev acc
  | x :: xs -> generate_matching_parentheses xs ((form_matching_parentheses x []) :: acc);;

let generate_tests n =
  generate_matching_parentheses (generate n) [];;

