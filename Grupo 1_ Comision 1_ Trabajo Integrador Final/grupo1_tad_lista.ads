generic

   type tipoElemento is private;
   
package grupo1_TAD_Lista is

   type tipoLista is private;
   
   function listaVacia (lista: tipoLista) return boolean;
   function estaEnLista (lista: tipoLista; elemento: tipoElemento) return boolean;
   function infoDeLista (lista: in tipoLista) return tipoElemento;
   function siguienteEnLista (lista: in tipoLista) return tipoLista;
   procedure crearLista (lista: in out tipoLista);
   procedure insertarEnLista_Frente (lista: in out tipoLista; elemento: in tipoElemento);
   procedure insertarEnLista_Final (lista: in out tipoLista; elemento: in tipoElemento);
   procedure suprimirDeLista (lista: in out tipoLista; elemento: in tipoElemento);
   procedure suprimirDeLista_Frente (lista: in out tipoLista; elemento: out tipoElemento);
   procedure limpiarLista (lista: in out tipoLista);
      
   ex_ListaVacia: exception;
   
   private
   type tipoNodo;
   type tipoLista is access tipoNodo;
   type tipoNodo is record
      info: tipoElemento;
      siguiente: tipoLista;
   end record;
   
end grupo1_TAD_Lista;