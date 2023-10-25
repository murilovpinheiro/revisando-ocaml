(*
Código de exemplo que coloca em prática diversas técnicas de Programação Imperativa, sendo eles
   - Registros Mutáveis
   - Arrays
   - Laços (For e While)   
   - Variáveis "Mutáveis" (Referências)
   - Criando Operadores Personalizados
*)

(*Registros Mutáveis utilizados na parte deles*)
type registroMut = {mutable x: int; mutable y: int};; 
(* Semelhant ao registro padrão porém com a tag mutable *)

type 't pointer = {mutable value: 't};;
(*Um Apontador do tipo t*)

let parte1 () = 
  (*Exemplos bem simples de como criar um laço for em OCAML*) 
  Printf.printf "\nPARTE 1 - LAÇO FOR\n\n";

  for i = 1 to 3 do
    Printf.printf "Exemplo de FOR: Iteração Numero %d\n" i;
  done;

  print_endline "";

  for i = 3 downto 1 do
    Printf.printf "Exemplo de FOR: Iteração Numero %d\n" i;
  done;
;;

(*Exemplo de Criação e Utilização de um Registro Mutável*)

let parte2 () =
  Printf.printf "\nPARTE 2 - REGISTRO MUTÁVEL\n\n";

  (*Atribuição comum, utiliza igual
    exceto uma atribuição, onde possui um valor já atribuido, deve-se utilizar "<-" para todos os mutáveis*)

  let p = {x = -1; y = -1} in 
  let rec ler () = 
    print_string "X: ";
    p.x <- read_int ();
    print_string "Y: ";
    p.y <- read_int ();
    if p.x < 0 || p.y < 0 then ler ()
  in
  ler ();
  Printf.printf "O par digitado foi (%d, %d)\n" p.x p.y;

  (*
    Um tipo de registro mutável muito utilizado é o "apontador"
    Ele basicamente é um registro com um único valor mútavel, simulando uma variável mútavel*)

  let m = {value = 0} in
  (* Após definido o tipo do value, esse tipo não pode mudar, ou seja esse é um apontador do tipo INT*)
  Printf.printf "Valor do Apontador do tipo INT: %d\n" m.value;
  print_endline "Digite um número para substituir: ";
  m.value <- read_int ();
  Printf.printf "Valor do Apontador do tipo INT mudado: %d\n" m.value;
  (*Exemplo e Utilização básica de Arrays*)
;;

let parte3 () =
  Printf.printf "\nPARTE 3 - ARRAYS\n\n";

  let v  = [|9; 0; 91; 42; 76|] in  (*Criando um Array Simples do tipo int array*)

  Printf.printf "O valor na Primeira Posição do Array V é %d.\n" v.(0); (*Acessando as posições do Array*)

  print_string "Digite um inteiro para substituir a Primeira Posição do Array V: ";
  v.(0) <- read_int (); (* Mudando o valor numa posição *)

  for i = 0 to 4 do
    Printf.printf "Array V posição %d -> valor %d\n" i v.(i);
  done; (* Quando coloco done;; o escopo de V acaba aqui*)

  (*Existe o módulo Array que implementa diversas funções úteis para arrays*)
  Printf.printf "O tamanho do Array V é %d\n" (Array.length v);

  print_string "Digite o tamanho do novo vetor: ";
  let n = read_int () in 
  let new_v = Array.make n 0 in (* Criando um Array de tamanho n, todo zerado*)
  Printf.printf "Criando array de tamanho %d com Array.make zerado\n" n;
  for i = 0 to Array.length new_v - 1 do
    Printf.printf "%d\n" new_v.(i);
  done;

  (*O Init cria um array que pega o valor da posição e aplica uma função e o resultado é colocado no valor*)
  let new_v2 = Array.init n (fun i -> i+10) in 
  Printf.printf "Criando array de tamanho %d com Array.length com função i + 10\n" n;
  Printf.printf "Printando utilizando Array.iter\n";

  Array.iter (fun elem -> Printf.printf "%d\n" elem) new_v2; 
  (*Itera pelo array e faz alguma coisa a cada elemento*)
;;

(*Exemplo e Utilização básica do Laço While*)

let parte4 () =
  Printf.printf "\nPARTE 4 - LAÇO WHILE\n\n";

  let m = {value = 0} in
  while m.value <= 0 do
    print_endline "Digite um número inteiro positivo maior que 0: ";
    m.value <- read_int ();
  done;

  Printf.printf "O número digitado foi %d.\n" m.value
;;


(*Exemplo de Operadores Personalizados*)

let parte5 () = 
  Printf.printf "\nPARTE 5 - CRIANDO OPERADORES E OUTROS DETALHES\n\n";

  (*Em Ocaml você é capaz de utilizar alguns operadores para tipos específicos
    Você pode criar operadores tanto infixos, como prefixos ou posfixos.*)

  (*Exemplo Infixo, símbolo :*)
  let (:=) var novo_valor = 
    var.value <- novo_valor 
  in

  (*Exemplo Prefixo, símbolo !, ? ou ~*)
  let (!++) var = 
    var.value <- var.value + 1
  in

  (*Esse operador pode ser utilizado como valor := novo_valor*)

  let m = {value = 0} in
  print_endline "Digite um número inteiro: ";
  m := (read_int ()); 
  !++ m; 
  Printf.printf "O número incrementado é digitado foi %d\n" m.value;

  let v = ref 10 in
  let w = ref 10 in

  let sim_ou_nao valor_bool =
    if valor_bool then "Sim"
    else "Não"
  in

  (* Diferenças entre <> e !=, e entre == e =   *)

  Printf.printf "v = 10 e w = 10, são iguais ? (=)  %s \n" (sim_ou_nao (v =  w));
  Printf.printf "v = 10 e w = 10, são iguais ? (==) %s \n" (sim_ou_nao (v == w));
  Printf.printf "v = 10 e w = 10, são difer. ? (<>) %s \n" (sim_ou_nao (v <> w));
  Printf.printf "v = 10 e w = 10, são difer. ? (!=) %s \n" (sim_ou_nao (v != w));
  print_endline "Os Operadores (==) e (!=) referem-se a igualdade física na memória."

  
;;
(*Exemplo de refẽrencias e suas utilizações em OCAML*)

let parte6 () =
Printf.printf "\nPARTE 6 - REFERÊNCIAS\n\n";

(*Os apontadores mostrados anteriormentes 
  não são nada mais do quê as REFERÊNCIAS 
  da biblioteca padrão do OCAML
*)

(*Uso das Referências*)

  let m = ref 0 in
  while m.contents <= 0 do
    print_endline "Digite um número inteiro positivo maior que 0: ";
    m := read_int (); (*Operador utilizado como m.contents <- read_int () *)
  done;

Printf.printf "Número Digitado posto na Referência: %d\n" !m (* !m é o mesmo que m.contents*)

;;

let main parte =
match parte with
| 1 -> parte1 ()
| 2 -> parte2 ()
| 3 -> parte3 ()
| 4 -> parte4 ()
| 5 -> parte5 ()
| 6 -> parte6 ()
| _ -> ()
;;

print_endline "Qual parte você deseja rodar: 1 a 6";
main (read_int ());;
