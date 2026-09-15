with ada.Unchecked_Deallocation;

package body grupo1_TAD_Lista is

   procedure free is new ada.Unchecked_Deallocation (tipoNodo, tipoLista);

   ----------------
   -- listaVacia --
   ----------------

   function listaVacia (lista: in tipoLista) return boolean is
   begin
      return lista = null;
      end listaVacia;
      
   -----------------
   -- estaEnLista --
   -----------------

   function estaEnLista (lista: tipoLista; elemento: tipoElemento) return boolean is
   puntero: tipoLista:= lista;
   begin
      if listaVacia (lista) then
         return false;
      else
         if puntero /= null and then puntero.info = elemento then
            return true;
         else
            return estaEnLista (lista.siguiente, elemento);  
         end if;
      end if;
      end estaEnLista;

   ----------------
   -- crearLista --
   ----------------

   procedure crearLista (lista: in out tipoLista) is
   begin
   lista:= null;
   end crearLista;
   
   -----------------
   -- infoDeLista --
   -----------------

   function infoDeLista (lista: in tipoLista) return tipoElemento is
   begin
      if lista /= null then
         return lista.info;
      else
         raise ex_ListaVacia;
      end if;
      end infoDeLista;

   ----------------------
   -- siguienteEnLista --
   ----------------------

   function siguienteEnLista (lista: in tipoLista) return tipoLista is
   begin
      return lista.siguiente;
      end siguienteEnLista;

   ----------------------------
   -- insertarEnLista_Frente --
   ----------------------------

   procedure insertarEnLista_Frente (lista: in out tipoLista; elemento: in tipoElemento) is
   nuevoNodo: tipoLista:= new tipoNodo'(elemento, null);
   begin
      if listaVacia (lista) then
         lista:= nuevoNodo;
      else
         nuevoNodo.siguiente:= lista;
         lista:= nuevoNodo;
      end if;
      end insertarEnLista_Frente;

   ---------------------------
   -- insertarEnLista_Final --
   ---------------------------

   procedure insertarEnLista_Final (lista: in out tipoLista; elemento: in tipoElemento) is
   nuevoNodo: tipoLista:= new tipoNodo'(elemento, null);
   puntero: tipoLista:= lista;
   begin
      if puntero = null then
         lista:= nuevoNodo;
      else
         puntero:= lista;
         while puntero.siguiente /= null loop
            puntero:= puntero.siguiente;
         end loop;
         puntero.siguiente:= nuevoNodo;
      end if;
      end insertarEnLista_Final;

   ---------------------
   -- suprimirDeLista --
   ---------------------

   procedure suprimirDeLista (lista: in out tipoLista; elemento: in tipoElemento) is
   actual: tipoLista:= lista;
   anterior: tipoLista:= null;
   begin
      if listaVacia (lista) then
         raise ex_ListaVacia;
      else
         while actual /= null and then actual.info /= elemento loop
            anterior:= actual;
            actual:= actual.siguiente;
         end loop;
         if anterior = null then
            lista:= lista.siguiente;
         else
            anterior.siguiente:= actual.siguiente;
         end if;
         free (actual);
      end if;
      end suprimirDeLista;

   ----------------------------
   -- suprimirDeLista_Frente --
   ----------------------------

   procedure suprimirDeLista_Frente (lista: in out tipoLista; elemento: out tipoElemento) is
   puntero: tipoLista:= lista;
   begin
      if not listaVacia (lista) then
         elemento:= lista.info;
         lista:= lista.siguiente;
         free (puntero);
      else
         raise ex_ListaVacia;
      end if;
      end suprimirDeLista_Frente;

   ------------------
   -- limpiarLista --
   ------------------

   procedure limpiarLista (lista: in out tipoLista) is
   temporal: tipoLista:= lista;
   begin
      while lista /= null loop
         temporal:= lista;
         lista:= lista.siguiente;
         free (temporal);
      end loop;
      end limpiarLista;

   --------------------

end grupo1_TAD_Lista;