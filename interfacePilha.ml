(*
  Assim como classes possuem Interfaces para suas classes, 
  Modulos possuem Modulos de interface essa Interface 
  é onde você define as funções que terão naqueles módulos, 
  como seus tipos de entrada e saída
*)

module type InterfacePilha = sig
  type 't pilha (*Você pode utilizar apenas "t", caso:
                  todos os tipos 't devam ser o mesmo no modulo, 
                  simulando ainda mais uma classe
                 *)

  val criar: 't -> 't pilha

  val empilhar: 't pilha -> 't -> unit

  val desempilhar: 't pilha -> 't

  val vazio: 't pilha -> bool

  val retornar_topo: 't pilha -> 't

end ;;

(*Para utilizar a interface você deve: *)

module Pilha : InterfacePilha = struct

  type 't pilha = 't list ref 
  (*'t list ref basicamente é uma lista mútavel de tipos 't,
    ou seja uma referência para uma lista do tipo 't e não uma lista de referências para tipos 't*)

  let criar (elem: 't) : 't pilha = 
    ref [] (*A função criar recebe um tipo 't e retorna uma pilha do tipo 't, 
             no caso uma referência para uma lista vazia*)

  let empilhar (p: 't pilha) (elem: 't) : unit =
    p := elem :: !p (*Adicionando elem ao topo da pilha*)
  
  let desempilhar (p: 't pilha) : 't = 
    match !p with
    | [] -> failwith "Pilha vazia."
    | h :: t -> p := t;
                h

  let vazio (p: 't pilha) : bool= 
    !p = []

  let retornar_topo (p: 't pilha) : 't = 
    match !p with
    | [] -> failwith "Pilha vazia."
    | h :: t -> h
end ;;