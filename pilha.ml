(*

Nesse código vou botar em prática os conteúdos dados sobre módulos em Ocaml
Os módulos em OCaml permitem agrupar tipos de dados, funções e valores em um único escopo
Facilita a utilização e a reutilização de código.

Na prática módulos funcionam de forma semelhante à classes ou estruturas em outras Linguagens de Programação,
no entanto não há objetos, ficando mais parecido com pacotes

*)

(*Para exemplificar temos um módulo de uma PILHA*)

module Pilha = struct

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