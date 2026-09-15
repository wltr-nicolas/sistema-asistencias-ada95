with Ada.Text_Io, Ada.Integer_Text_Io, Empleados_Io , Asistencia_Io , Grupo1_Tad_Lista;
with Ada.Text_Io, Ada.Integer_Text_Io ;

package body Reportes_IO is


   Anio_Actual    : constant Integer := 2026;
   Edad_Jubilacion: constant Natural := 65;

   function Edad_De (F : Empleados_IO.Fecha) return Natural is
   begin
      if F.Ano <= 0 then
         return 0;
      else
         return Anio_Actual - F.Ano;
      end if;
   end Edad_De;
   
   function Dos_Digitos (N : Integer) return String is
begin
   if N < 10 then
      return "0" & Integer'Image(N)(2 .. Integer'Image(N)'Last);
   else
      return Integer'Image(N)(2 .. Integer'Image(N)'Last);
   end if;
end Dos_Digitos;


function Fecha_Str (D, M, A : Integer) return String is
begin
   return Dos_Digitos(D) & "/" &
          Dos_Digitos(M) & "/" &
          Integer'Image(A)(2 .. Integer'Image(A)'Last);
end Fecha_Str;
   
procedure Resumen_Mes(Lista_Asis : in  Asistencia_IO.Lista_Asis.TipoLista;Mes: in  Integer;Anio: in  Integer; Resumen: out Lista_Resumen.TipoLista)is
      Aux     : Asistencia_IO.Lista_Asis.TipoLista := Lista_Asis;
      R       : Registro_Asistencia;
      Ptr     : Lista_Resumen.TipoLista;
      Encontro: Boolean;
      H       : Integer;
      Nuevo   : Resumen_Mensual;
   begin
      lista_resumen.CrearLista(Resumen);

      while not asistencia_Io.Lista_asis.ListaVacia(Aux) loop
         R := asistencia_Io.Lista_asis.InfoDeLista(Aux);
         Aux := asistencia_Io.Lista_asis.SiguienteEnLista(Aux);

         if not R.Anulado and then (Mes = 0 or else R.Fecha_Ent.Mes = Mes)and then (Anio = 0 or else R.Fecha_Ent.Ano = Anio)then
            Ptr := Resumen;
            Encontro := False;
            while not ListaVacia(Ptr) and not Encontro loop
               if InfoDeLista(Ptr).Dni(1..8) = R.Dni(1..R.Long_Dni) then
                  Encontro := True;
               else
                  Ptr := SiguienteEnLista(Ptr);
               end if;
            end loop;

            H := Calcular_Horas_Asistencia(R);

            if Encontro then
               declare
                  R2 : Resumen_Mensual := InfoDeLista(Ptr);
                  O  : Lista_Resumen.TipoLista := Resumen;
                  D  : Lista_Resumen.TipoLista;
                  X  : Resumen_Mensual;
               begin
                  R2.Horas_Tot := R2.Horas_Tot + Natural(H);
                  if H > 0 then
                     R2.Asistencias := R2.Asistencias + 1;
                  else 
                     R2.Inasistencias := R2.Inasistencias + 1;
                  end if;
                  CrearLista(D);
                  while not ListaVacia(O) loop
                     X := InfoDeLista(O);
                     O := SiguienteEnLista(O);
                     if X.Dni(1..X.Long_Dni) = R.Dni(1..R.Long_Dni) then
                        X := R2;
                     end if;
                     insertarEnLista_Final(D, X);
                  end loop;
                  limpiarLista(Resumen);
                  Resumen := D;
               end;
            else
               Nuevo := (Dni => R.Dni,
                         Long_Dni => R.Long_Dni,
                         Asistencias => 0,
                         Inasistencias => 0,
                         Horas_Tot => 0);
               if H > 0 then
                  Nuevo.Asistencias := 1;
               else
                  Nuevo.Inasistencias := 1;
               end if;
               Nuevo.Horas_Tot := Natural(H);
               insertarEnLista_Final(Resumen, Nuevo);
            end if;
         end if;
      end loop;
   end Resumen_Mes;

   procedure Listar_Por_Funcion (Empleados : in Empleados_IO.Lista_Empleados.tipolista) is
      Aux   : Empleados_IO.Lista_Empleados.tipolista := Empleados;
      E     : Empleados_IO.Empleado;
      F_Act : String(1..50);
      L_Act : Integer := 0;
      Funcion: String(1..50);
      Long_Funcion:Integer;
      enc: boolean:= false;
   begin
      
      Put_Line("Ingrese la funcion ");
      Get_Line(Funcion, Long_Funcion);
      
      if Funcion = E.Funcion_EN_la_Empresa then
         Put_Line("===== EMPLEADOS POR FUNCION =====");
      
         end if;
          
      while not Empleados_IO.lista_empleados.ListaVacia(Aux) loop
         
         E := Empleados_IO.lista_empleados.InfoDeLista(Aux);
         
         
         if Funcion (1..long_funcion) = E.Funcion_EN_la_Empresa(1..e.long_empresa) then
         
            if not E.Anulado then

                  enc:= true;
                  F_Act := E.Funcion_En_La_Empresa;
                  L_Act := E.Long_Empresa;
                  New_Line;
                  Put_Line("Funcion: " & F_Act(1..L_Act));

               Put_Line("----------------------------------------");
               Put_Line("Nombre   : " & E.Nombre_Apellido(1..E.Long_Nom_Apellido));
               Put_Line("DNI      : " & E.Dni(1..E.Long_Dni));
               Put_Line("----------------------------------------");
            end if;
            end if;
            
         Aux :=  Empleados_IO.lista_empleados.SiguienteEnLista(Aux);
         end loop;

   if not enc then 
      Put_Line("(lista vacia)");
      return;
   end if;
   
   end Listar_Por_Funcion;

   procedure Listar_Proximos_Jubilarse (Empleados : in Empleados_IO.Lista_Empleados.tipolista) is
      Aux  : Empleados_IO.Lista_Empleados.tipolista := Empleados;
      E    : Empleados_IO.Empleado;
      Edad : Natural;
   begin
      Put_Line("===== PROXIMOS A JUBILARSE (en los proximos 2 anios) =====");
      if Empleados_IO.lista_empleados.ListaVacia(Aux) then
         Put_Line("(lista vacia)");
         return;
      end if;
      while not Empleados_IO.lista_empleados.ListaVacia(Aux) loop
         E := Empleados_IO.lista_empleados.InfoDeLista(Aux);
         Aux := Empleados_IO.lista_empleados.SiguienteEnLista(Aux);
         if not E.Anulado then
            Edad := Edad_De(E.Fecha_Nacimiento);
            if Edad >= Edad_Jubilacion - 2
              and then Edad >= Edad_Jubilacion
            then
              Put_Line("----------------------------------------");
              Put_Line("Empleado : " & E.Nombre_Apellido(1..E.Long_Nom_Apellido));
              Put_Line("DNI      : " & E.Dni(1..E.Long_Dni));
              Put_Line("Edad     : " & Integer'Image(Edad));
              Put_Line("----------------------------------------");
            end if;
         end if;
      end loop;
   end Listar_Proximos_Jubilarse;

procedure Reporte_Diario(Empleados : in Empleados_IO.Lista_Empleados.tipolista;Asist: in Asistencia_IO.Lista_Asis.TipoLista) is

   E_Aux : Empleados_IO.Lista_Empleados.tipolista := Empleados;
   E     : Empleados_IO.Empleado;
   H     : Integer;

begin
   Put_Line("==========================================");
   Put_Line("      REPORTE DIARIO DE ASISTENCIA");
   Put_Line("==========================================");

   if Empleados_IO.Lista_Empleados.ListaVacia(E_Aux) then
      Put_Line("No hay empleados cargados.");
      return;
   end if;

   while not Empleados_IO.Lista_Empleados.ListaVacia(E_Aux) loop

      E := Empleados_IO.Lista_Empleados.InfoDeLista(E_Aux);
      E_Aux := Empleados_IO.Lista_Empleados.SiguienteEnLista(E_Aux);

      if not E.Anulado then

         declare
            A_Aux : Asistencia_IO.Lista_Asis.TipoLista := Asist;
            A     : Registro_Asistencia;
            Encontro_Reg : Boolean := False;
         begin

            while not Asistencia_IO.Lista_Asis.ListaVacia(A_Aux) loop

               A := Asistencia_IO.Lista_Asis.InfoDeLista(A_Aux);
               A_Aux := Asistencia_IO.Lista_Asis.SiguienteEnLista(A_Aux);

               if not A.Anulado
                 and then A.Dni(1..A.Long_Dni) = E.Dni(1..E.Long_Dni)
               then

                  H := Calcular_Horas_Asistencia(A);

                  Put_Line("------------------------------------------");
                  Put_Line("Empleado      : "& E.Nombre_Apellido(1..E.Long_Nom_Apellido));
                  Put_Line("DNI           : "& E.Dni(1..E.Long_Dni));

                  Put_Line("Fecha Entrada : "& Fecha_Str(A.Fecha_Ent.Dia,A.Fecha_Ent.Mes,A.Fecha_Ent.Ano));

                  Put_Line("Hora Entrada  : "& Dos_Digitos(A.Fecha_Ent.Hora)& ":"& Dos_Digitos(A.Fecha_Ent.Min));

                  Put_Line("Fecha Salida  : "& Fecha_Str(A.Fecha_Sal.Dia,A.Fecha_Sal.Mes,A.Fecha_Sal.Ano));

                  Put_Line("Hora Salida   : " & Dos_Digitos(A.Fecha_Sal.Hora)& ":"& Dos_Digitos(A.Fecha_Sal.Min));

                  Put_Line("Horas Totales : "& Integer'Image(H));

                  Put_Line("------------------------------------------");
                  New_Line;

                  Encontro_Reg := True;

               end if;

            end loop;

            if not Encontro_Reg then
               Put_Line("------------------------------------------");
               Put_Line("Empleado : "& E.Nombre_Apellido(1..E.Long_Nom_Apellido));
               Put_Line("DNI      : "& E.Dni(1..E.Long_Dni));
               Put_Line("Estado   : INASISTENCIA");
               Put_Line("------------------------------------------");
               New_Line;
            end if;

         end;

      end if;

   end loop;

end Reporte_Diario;

   procedure Buscar_Extremo_Horas(Res  : in  Lista_Resumen.TipoLista;Max  : in  Boolean;OutR : out Resumen_Mensual;Hay  : out Boolean)is
      Aux : Lista_Resumen.TipoLista := Res;
      X   : Resumen_Mensual;
      Sel : Resumen_Mensual;
      Ini : Boolean := True;
   begin
      Hay := False;
      while not ListaVacia(Aux) loop
         X := InfoDeLista(Aux);
         Aux := SiguienteEnLista(Aux);
         if Ini
           or else (Max and then X.Horas_Tot > Sel.Horas_Tot)
           or else (not Max and then X.Horas_Tot < Sel.Horas_Tot)
         then
            Sel := X;
            Hay := True;
            Ini := False;
         end if;
      end loop;
      OutR := Sel;
   end Buscar_Extremo_Horas;

   procedure Empleados_Mas_Horas_Mes(Asist : in Asistencia_IO.Lista_Asis.TipoLista;Mes   : in Integer;Anio  : in Integer) is
      R   : Lista_Resumen.TipoLista;
      Sel : Resumen_Mensual;
      Hay : Boolean;
   begin
      Put_Line("===== Empleados con mas horas en el mes =====");
      Resumen_Mes(Asist, Mes, Anio, R);
      if ListaVacia(R) then
         Put_Line("(sin datos)");
         return;
      end if;
      Buscar_Extremo_Horas(R, True, Sel, Hay);
      if Hay then
         Put_Line("  DNI " & Sel.Dni(1..Sel.Long_Dni)& " - " & Integer'Image(Sel.Horas_Tot) & " horas");
      end if;
   end Empleados_Mas_Horas_Mes;

   procedure Empleados_Menos_Horas_Mes(Asist : in Asistencia_IO.Lista_Asis.TipoLista;Mes   : in Integer;Anio  : in Integer) is
      R   : Lista_Resumen.TipoLista;
      Sel : Resumen_Mensual;
      Hay : Boolean;
   begin
      Put_Line("===== Empleados con menos horas en el mes =====");
      Resumen_Mes(Asist, Mes, Anio, R);
      if ListaVacia(R) then
         Put_Line("(sin datos)");
         return;
      end if;
      Buscar_Extremo_Horas(R, False, Sel, Hay);
      if Hay then
         Put_Line("  DNI " & Sel.Dni(1..Sel.Long_Dni)& " - " & Integer'Image(Sel.Horas_Tot) & " horas");
      end if;
   end Empleados_Menos_Horas_Mes;
   



  procedure Empleados_Mas_Inasistencias_Mes(Asist : in Asistencia_IO.Lista_Asis.TipoLista;Mes   : in Integer;Anio  : in Integer) is
      R   : Lista_Resumen.TipoLista;
      Aux : Lista_Resumen.TipoLista;
      X   : Resumen_Mensual;
      Max : Natural := 0;
   begin
      Put_Line("===== Empleados con mas inasistencias en el mes =====");
      Resumen_Mes(Asist, Mes, Anio, R);
      if ListaVacia(R) then
         Put_Line("(sin datos)");
         return;
      end if;
      -- First pass: find maximum
      declare
         Aux2 : Lista_Resumen.TipoLista := R;
         X2   : Resumen_Mensual;
      begin
         while not ListaVacia(Aux2) loop
            X2 := InfoDeLista(Aux2);
            if X2.Inasistencias > Max then
               Max := X2.Inasistencias;
            end if;
            Aux2 := SiguienteEnLista(Aux2);
         end loop;
      end;
      if Max = 0 then
         Put_Line("(ninguna inasistencia)");
         return;
      end if;
      
      declare
         Aux2 : Lista_Resumen.TipoLista := R;
         X2   : Resumen_Mensual;
         First : Boolean := True;
      begin
         while not ListaVacia(Aux2) loop
            X2 := InfoDeLista(Aux2);
            if X2.Inasistencias = Max then
               if First then
                  Put_Line("  DNI " & X2.Dni(1..X2.Long_Dni)& " - " & Integer'Image(X2.Inasistencias)& " inasistencias");
                  First := False;
               else
                  Put_Line("  DNI " & X2.Dni(1..X2.Long_Dni)& " - " & Integer'Image(X2.Inasistencias)& " inasistencias");
               end if;
            end if;
            Aux2 := SiguienteEnLista(Aux2);
         end loop;
      end;
   end Empleados_Mas_Inasistencias_Mes;


   procedure Horas_Por_Empleado(Empleados_h : in Empleados_IO.Lista_Empleados.tipolista;Asist: in Asistencia_IO.Lista_Asis.TipoLista;Mes: in Integer;Anio: in Integer) is
      R   : Lista_Resumen.TipoLista;
      Aux : Lista_Resumen.TipoLista;
      E_Aux: Empleados_IO.Lista_Empleados.tipolista := Empleados_h;
      E    : Empleados_IO.Empleado;
      X    : Resumen_Mensual;
      Encontro: Boolean;
   begin  
      Put_Line("===== Horas trabajadas por empleado en el mes =====");
      Resumen_Mes(Asist, Mes, Anio, R);
      while not Empleados_IO.Lista_Empleados.ListaVacia(E_Aux) loop
         E := Empleados_IO.Lista_Empleados.InfoDeLista(E_Aux);
         E_Aux := Empleados_IO.Lista_Empleados.SiguienteEnLista(E_Aux);
         if not E.Anulado then
            Aux := R;
            Encontro := False;
            X := (Dni => (others => ' '), Long_Dni => 0,Asistencias => 0, Inasistencias => 0, Horas_Tot => 0);
            while not ListaVacia(Aux) and not Encontro loop
               X := InfoDeLista(Aux);
               if X.Dni(1..X.Long_Dni) = E.Dni(1..E.Long_Dni) then
                  Encontro := True;
               else
                  Aux := SiguienteEnLista(Aux);
               end if;
            end loop;
            if Encontro then
               Put_Line("  " & E.Nombre_Apellido(1..E.Long_Nom_Apellido)& ": " & Integer'Image(X.Horas_Tot) & " horas ("& Integer'Image(X.asistencias) & " dias)");
            else
               Put_Line("  " & E.Nombre_Apellido(1..E.Long_Nom_Apellido)
                        & ": sin registros en el mes");
            end if;
         end if;
      end loop;
   end Horas_Por_Empleado;

      procedure Empleados_Mas_Inasistencias_Total(Asist : in Asistencia_IO.Lista_Asis.TipoLista) is
      R   : Lista_Resumen.TipoLista;
      Max : Natural := 0;
   begin
      Put_Line("===== Empleados con mas inasistencias en total =====");
      Resumen_Mes(Asist, 0, 0, R);
      if ListaVacia(R) then
         Put_Line("(sin datos)");
         return;
      end if;
      -- First pass: find maximum
      declare
         Aux : Lista_Resumen.TipoLista := R;
         X   : Resumen_Mensual;
      begin
         while not ListaVacia(Aux) loop
            X := InfoDeLista(Aux);
            if X.Inasistencias > Max then
               Max := X.Inasistencias;
            end if;
            Aux := SiguienteEnLista(Aux);
         end loop;
      end;
      if Max = 0 then
         Put_Line("(ninguna inasistencia)");
         return;
      end if;
      -- Second pass: output all with Max
      declare
         Aux : Lista_Resumen.TipoLista := R;
         X   : Resumen_Mensual;
         First : Boolean := True;
      begin
         while not ListaVacia(Aux) loop
            X := InfoDeLista(Aux);
            if X.Inasistencias = Max then
               if First then
                  Put_Line("  DNI " & X.Dni(1..X.Long_Dni)& " - " & Integer'Image(X.Inasistencias)& " inasistencias");
                  First := False;
               else
                  Put_Line("  DNI " & X.Dni(1..X.Long_Dni)& " - " & Integer'Image(X.Inasistencias)& " inasistencias");
               end if;
            end if;
            Aux := SiguienteEnLista(Aux);
         end loop;
      end;
   end Empleados_Mas_Inasistencias_Total;

      procedure Listar_Totales_Empleados(Asist : in Asistencia_IO.Lista_Asis.TipoLista) is
      R   : Lista_Resumen.TipoLista;
      Aux : Lista_Resumen.TipoLista;
      X   : Resumen_Mensual;
   begin
      Put_Line("===== Totales de asistencias e inasistencias por empleado =====");
      Resumen_Mes(Asist, 0, 0, R);
      if ListaVacia(R) then
         Put_Line("(sin datos)");
         return;
      end if;
      Aux := R;
      while not ListaVacia(Aux) loop
         X := InfoDeLista(Aux);
         Put_Line("  DNI " & X.Dni(1..X.Long_Dni) &
                  " - Asistencias: " & Integer'Image(X.Asistencias) &
                  ", Inasistencias: " & Integer'Image(X.Inasistencias) &
                  ", Horas totales: " & Integer'Image(X.Horas_Tot));
         Aux := SiguienteEnLista(Aux);
      end loop;
   end Listar_Totales_Empleados;
end Reportes_IO;







