(*Código de exemplo de um programa que utiliza o Modulo PILHA criado em outro arquivo*)

(*
  Existem algums formas de "importar", mas a que eu mais gostei foi:
  nome do modulo é o mesmo do arquivo e você inclui o modulo e na compilação faz:
  ocamlopt -o saida.exe modulo.ml programa.ml
*)

include Pilha

let programa () = 
  let p = Pilha.criar 0 in
  let m = ref 1 in 
  while !m > 0 do
    print_endline "Digite um número inteiro maior que 0 (menor que 0 para parar): ";
    m := read_int ();
    if !m > 0 then 
    begin
      Printf.printf "Adicionando o valor %d a Pilha\n" !m;
      Pilha.empilhar p !m;
    end
  done;

  print_endline "Esvaziando Pilha...\n";
  while not (Pilha.vazio p) do 
    Printf.printf "Retiro da pilha o valor: %d\n" (Pilha.desempilhar p );
  done;

  Printf.printf "Pilha vazia? %b\n" (Pilha.vazio p)
;;

programa ();;