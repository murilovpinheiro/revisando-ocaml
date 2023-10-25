let permutacaoAleatoria n =
  Random.self_init (); (*Pra criar a semente*)
  let v = Array.init n (fun i -> i + 1) in 
  
  for last = (n - 1) downto 1 do
    let i = Random.int (last + 1) in (* Retorna um inteiro entre [0, last + 1) *)
    let cp_i = v.(i) in
    v.(i) <- v.(last);
    v.(last) <- cp_i
  done ;
  v 
;;

(*
Basicamente ele vai iterando do ultimo ao segundo
vai sorteando indice a cada iteração, o indice sorteado
troca com o valor da iteração atual e assim sucessivamente.   
*)

Array.iter (fun i -> Printf.printf "%d; " i) (permutacaoAleatoria 10);
print_endline "";;
