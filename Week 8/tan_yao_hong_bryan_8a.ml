(* TAN YAO HONG BRYAN ASSIGNMENT no. 8a *)

(* question 1 *)

type 'a tree =
  | Lf
  | Br of 'a * ('a tree) * ('a tree);;

let empty_dict = Lf;;

let rec lookup t k =
  match t with
  | Lf -> raise Not_found
  | Br((key,value,_),left, right) ->
     if k = key then value
     else if k < key then lookup left k
     else lookup right k;;


let rec height t =
  match t with
  | Lf -> 0
  | Br( (_,_,h),_, _) -> h


let rec insert t k v =
  (* update just updates the height of the Br _after_ insertion, and takes O(1) since height is O(1) and max is O(1) *)
  (* insert is O(log n) in average cause with O(n) in the worst-case wherein height = number of nodes such as a very unbalanced tree *)
  let update t =
     match t with
     | Lf -> Lf
     | Br((k,v,h), left, right) -> Br((k,v, 1 + (max (height left) (height right))), left, right)
   in 
  match t with
  | Lf -> Br((k,v, 1),Lf,Lf)
  | Br((key,value,h),left, right) ->
     if k = key then Br((k,v,h),left,right)
     else if k < key then update(Br((key,value,h),insert left k v,right))
     else update(Br((key,value,h),left,insert right k v));;


(* question 2 w/ 1 mark extra-credit problem*)

let listtree = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31];;

let rec take n l =
  if n = 0 then [] else
    match l with
    | [] -> []
    | h :: t -> h :: take (n-1) t;;
let rec drop n l =
  if n = 0 then l else
    match l with
    | [] -> []
    | h :: t -> drop (n-1) t;;
let rec fold_left f i l = match l with
  | [] -> i
  |h :: t -> fold_left f (f i h) t;;
let length l = fold_left (fun i _ -> i + 1) 0 l;;

let midpoint l =
  let n = (length l / 2) in 
  let rec midpoint_helper l acc =
    match l with
    | [] -> raise Not_found
    | h :: t -> if acc <> n then midpoint_helper t (acc + 1)
                else h
  in midpoint_helper l 0;;

let treeify lst =
  let rec treeify_helper lst =
    match lst with
    | [] -> Lf
    | [x] -> Br(x, Lf, Lf)
    | _ -> let left = take (length lst / 2) lst in
           let right = drop ((length lst / 2) + 1) lst in
           Br(midpoint lst, treeify_helper left, treeify_helper right)
  in treeify_helper lst;;

(* 1 mark extra-credit problem *)

(* My solution takes O(n * log n) time.

 The functions take, drop, and midpoint take O(n) time. treeify_helper splits the list into half with the help of take & drop. Splitting a list into two halves until every element of is a single element or a Leaf takes time proportional to the number of time you can split that list in half, or O(log base 2 n) = O(log n). That is, the number of time you can split a list into half is proportional to log n.

treeify_helper calls midpoint, take, and drop each time it splits into half. Hence, there is an additional O(n)+O(n)+O(n) = O(n) operations every time treeify_helper splits the list into half, which is O(log n). Thus, treeify takes O(n log n) *)


(* question 3 *)

let rec height (t : 'a tree) = match t with
 | Lf -> 0
 | Br (_, l, r) -> 1 + max (height l) (height r);;


let rec right_tree t k =
  match t with
  | Lf -> raise Not_found
  | Br(v, left, right) -> if k > v then right_tree right k
                          else if k < v then Br(v, right_tree left k, right)
                          else right;;

let rec left_tree t k =
  match t with
  | Lf -> raise Not_found
  | Br(v, left, right) -> if k > v then Br(v, left, left_tree right k)
                          else if k < v then left_tree left k
                          else Br(v, left, Lf);;

let partition t k =
  ((left_tree t k), (right_tree t k));;

(* extra-credit solution *)

(* My solution takes O(h) time, where h is the height of the input tree. 

In the worst case, the function left_tree and right_tree traverse the height of the sorted tree, h, because the data structure of the binary tree means that everytime they are called they go one branch/node/level deeper. The maximum number of branches/nodes/levels they can travel is thus the height h of the tree.  Within left_tree and right_tree, they carry out O(1) operations. Thus, O(left_tree) = O(h) and O(right_tree) = O(h).  

 
The creation of a pair ((left_tree t k), (right_tree t k)) in partition takes takes O(1). Hence, partition overall takes O(1) + O(h) + O(h) = O(h), and O(partition) = O(h). The corollary is that if the tree is a balanced binary search tree and has n elements, then its height will be log n, and as a result partition will take O(h = logn) time.*)

