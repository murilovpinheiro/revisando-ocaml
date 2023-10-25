(*Outro exemplo de interface, demonstrando melhor o seu uso é:*)

module type Data = sig

  type t (*Todos os tipos t serão o mesmo, definidos no Modulo REAL*)

  val dia: t -> int

  val mes: t -> int

  val ano: t -> int

  val criar: int -> int -> int -> t

end;;

(*Diferença além do : Data é que você não define o module type novamente*)
module DataTupla : Data = struct
  type t = int * int * int (*Definindo o tipo t, todos os tipos t serão tupla de 3 ints*)

  let dia ((d, _, _): t): int = d

  let mes ((_, m, _): t): int = m

  let ano ((_, _, a): t): int = a

  let criar (dia: int) (mes: int) (ano: int) : t = (dia, mes, ano)

end;;


module DataReg : Data = struct
  type t = {dia: int; ano: int; mes: int} (*Definindo o tipo t, todos os tipos t serão tupla de 3 ints*)

  let dia (data: t): int = data.dia

  let mes (data: t): int = data.mes

  let ano (data: t): int = data.ano

  let criar (dia: int) (mes: int) (ano: int) : t = {dia; mes; ano}
  
end;;

(* ESSES dois exemplos mostram bem como uma interface pode ser utilizada:
   Internamente dos módulos o funcionamento é diferente pois utilizam tipos de dados "t" diferentes
   Externamente para quem só utiliza por fora, enviando e requisitando o funcionamento é o mesmo
*)


(*Agora a última parte de Módulos, Módulos que Recebem como argumento outros Módulos, Funtores*)

(*Definir rapidamente a interface do Funtor*)

module type ManipDatas = sig
  type t

  val anterior: t -> t -> bool

end;;

(*Criando o Funtor*)

module Manip (D: Data) : ManipDatas with type t := D.t = struct 
  (*
    Verboso, mas basicamente é um Funtor Manip, 
    que tem como interface ManipDatas
    e recebe um Módulo D do tipo Data
  *)

  (*
    O "type := D.t" na criação do Funtor significa:
    O uso do := é uma restrição que estabelece uma
    relação de igualdade entre os tipos "t" nos 
    dois módulos, permitindo que você trabalhe com 
    eles de forma intercambiável, como se fossem o mesmo tipo.
  *)

  type t = D.t

  let anterior (ano1 : t) (ano2: t): bool = 
    D.ano ano1 < D.ano ano2 ||
   (D.ano ano1 = D.ano ano2 &&
   (D.mes ano1 < D.mes ano2 ||
   (D.mes ano1 = D.mes ano2 && D.dia ano1 < D.dia ano2
   )))

end;;


module ManipTuplas = Manip (DataTupla);; (*Criando Módulo REAL agora, que é o módulo*)

let programa () =
  let hoje = DataTupla.criar 25 10 2023 in
  let aman = DataTupla.criar 26 10 2023 in

  Printf.printf "%B\n" (ManipTuplas.anterior hoje aman)
;;

programa ();;