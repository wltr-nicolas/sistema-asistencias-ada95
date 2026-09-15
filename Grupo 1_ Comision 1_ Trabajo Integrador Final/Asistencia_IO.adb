with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Sequential_IO, Ada.Characters.Handling, Ada.Io_Exceptions , grupo1_TAD_Lista; 
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Characters.Handling,  Ada.IO_Exceptions;
package body Asistencia_Io is

   package Archivo is new Ada.Sequential_IO(Registro_Asistencia);
   use  Archivo;

   procedure Alta_Asistencia(Lista : in out Lista_Asis.TipoLista; Reg : Registro_Asistencia) is
   begin
      insertarEnLista_Final(Lista, Reg);
   end Alta_Asistencia;

   procedure Baja_Asis_Por_Dni(Lista : in out Lista_Asis.TipoLista; Dni : String; Long : Integer)is
      Origen  : Lista_Asis.TipoLista := Lista;
      Destino : Lista_Asis.TipoLista;
      R       : Registro_Asistencia;
   begin
      CrearLista(Destino);
      while not ListaVacia(Origen) loop
         R := InfoDeLista(Origen);
         Origen := SiguienteEnLista(Origen);
         if not R.Anulado
           and then R.Dni(1..R.Long_Dni) = Dni(1..Long)
         then
            R.Anulado := True;
         end if;
         insertarEnLista_Final(Destino, R);
      end loop;
      limpiarLista(Lista);
      Lista := Destino;
   end Baja_Asis_Por_Dni;

   procedure Modificar_Asistencia(Lista : in out Lista_Asis.TipoLista;Dni : in String;Long  : in Integer;Nuevo : in Registro_Asistencia)is
      Origen  : Lista_Asis.TipoLista := Lista;
      Destino : Lista_Asis.TipoLista;
      R       : Registro_Asistencia;
   begin
      CrearLista(Destino);
      while not ListaVacia(Origen) loop
         R := InfoDeLista(Origen);
         Origen := SiguienteEnLista(Origen);
         if not R.Anulado
           and then R.Dni(1..R.Long_Dni) = Dni(1..Long)
         then
            R := Nuevo;
         end if;
         insertarEnLista_Final(Destino, R);
      end loop;
      limpiarLista(Lista);
      Lista := Destino;
   end Modificar_Asistencia;
   
   function Dos_Digitos(N : Integer) return String is
      S : constant String := Integer'Image(N);
   begin
      if N < 10 then
         return "0" & S(S'Last .. S'Last);
      else
         return S(S'First + 1 .. S'Last);
      end if;
   end Dos_Digitos;

    procedure Modificar_Asis(Lista_a : in out Lista_Asis.TipoLista; Dni : in out String; Long : in out Integer; Nuevo : in out Registro_Asistencia   ) is
      Origen   : Lista_Asis.TipoLista := Lista_a;
      Destino  : Lista_Asis.TipoLista;
      R        : Registro_Asistencia;
      Encontro : Boolean := False;
    begin
      
      Crearlista(Destino);
      
      while not Lista_Asis.ListaVacia(Origen)and not encontro loop
          R := Lista_Asis.Infodelista(Origen);
          
         Origen := Lista_Asis.SiguienteEnLista(Origen);
         
         if not R.Anulado and then R.Dni(1..R.Long_Dni) = Dni(1..Long)then
            R := Nuevo;
            Encontro := True;
         end if;
         Lista_Asis.insertarEnLista_Final(Destino, R);
      end loop;
      
      Lista_Asis.limpiarLista(Lista_A);
      Lista_A := Destino;
         
   end Modificar_asis;

   procedure Consultar_Asistencia(Lista : in Lista_Asis.TipoLista;Dni   : in String; Long  : in  Integer) is

      Aux : Lista_Asis.TipoLista := Lista;
      R   : Registro_Asistencia;
      Encontro : Boolean := False;

   begin
      while not ListaVacia(Aux) loop
         R := InfoDeLista(Aux);
         --Aux := SiguienteEnLista(Aux);

         if not R.Anulado and R.Dni(1..R.Long_Dni) = Dni(1..Long) then
           
            Put_Line("--------------------------------------");
            Put_Line("DNI           : " & R.Dni(1..R.Long_Dni));
            Put_Line("Empleado      : " &R.Nombre_Apellido(1..R.Long_Nom_Apell));

            Put_Line("Fecha Entrada : "& Dos_Digitos(R.Fecha_Ent.Dia) & "/"& Dos_Digitos(R.Fecha_Ent.Mes) & "/"& Integer'Image(R.Fecha_Ent.Ano)
                       (2 .. Integer'Image(R.Fecha_Ent.Ano)'Last));

            Put_Line("Hora Entrada  : "& Dos_Digitos(R.Fecha_Ent.Hora) & ":"& Dos_Digitos(R.Fecha_Ent.Min));

            Put_Line("Fecha Salida  : "& Dos_Digitos(R.Fecha_Sal.Dia) & "/"& Dos_Digitos(R.Fecha_Sal.Mes) & "/"& Integer'Image(R.Fecha_Sal.Ano)
                       (2 .. Integer'Image(R.Fecha_Sal.Ano)'Last));

            Put_Line("Hora Salida   : "& Dos_Digitos(R.Fecha_Sal.Hora) & ":"& Dos_Digitos(R.Fecha_Sal.Min));

            Put_Line("--------------------------------------");

            Encontro := True;
            --exit;
         end if;
         
         Aux := Siguienteenlista(Aux);
         
      end loop;

      if not Encontro then
         Put_Line("No se encontraron registros para este DNI.");
      end if;
   end Consultar_Asistencia;


   function Calcular_Horas_Asistencia (R : Registro_Asistencia) return Integer is
      Ent_Min : Integer;
      Sal_Min : Integer;
   begin
      
      
      Ent_Min := R.Fecha_ent.Hora * 60 + R.Fecha_Ent.Min;
      Sal_Min := R.Fecha_sal.Hora * 60 + R.Fecha_Sal.Min;
      if Sal_Min < Ent_Min then
         return 0;
      else
         return (Sal_Min - Ent_Min) / 60;
      end if;
   end Calcular_Horas_Asistencia;


   procedure Ingreso_Asis (Lista : in out Lista_Asis.TipoLista) is
      Res  : Character;
      Regi : Registro_Asistencia;
      
   begin

      loop
 
         Put_Line("Ingrese los siguientes datos del empleado:");
         Put_Line("Nombre y Apellido (max 20):");
         Get_Line(Regi.Nombre_Apellido, Regi.Long_Nom_Apell);
         Put_Line("DNI (max 8):");
         Get_Line(Regi.Dni, Regi.Long_Dni);
         Put_Line("Fecha entrada (dia mes anio):");
         Get(Regi.Fecha_Ent.Dia);
         Get(Regi.Fecha_Ent.Mes);
         Get(Regi.Fecha_Ent.Ano);
         Skip_Line;
         
         Put_Line("Hora entrada (hora minuto):");
         Get(Regi.Fecha_Ent.Hora);
         Get(Regi.Fecha_Ent.Min);
         Skip_Line;
         Put_Line("Hora salida (hora minuto):");
         Get(Regi.Fecha_Sal.Hora);
         Get(Regi.Fecha_Sal.Min);
         Skip_Line;
         Put_Line("Fecha salida  (dia mes anio):");
         Get(Regi.Fecha_Sal.Dia);
         Get(Regi.Fecha_Sal.Mes);
         Get(Regi.Fecha_Sal.Ano);                     
         Skip_Line;
         
         Regi.Anulado := False;
         insertarEnLista_Final(Lista, Regi);

         Put_Line("Desea ingresar otro? <S> = Si | <Otra> = No");
         Get_Immediate(Res);
         Skip_Line;
         exit when To_Upper(Res) /= 'S';
      end loop;
   end Ingreso_Asis;

   procedure Guardar_Asistencia_en_archivo(Lista : in Lista_Asis.TipoLista) is
      Arch : Archivo.File_Type;
      Aux  : Lista_Asis.TipoLista := Lista;
      Reg  : Registro_Asistencia;
   begin
      Create(Arch, Out_File, "asistencia.dat");
      while not ListaVacia(Aux) loop
         Reg := Infodelista(Aux);
         
         Put_Line("Guardando DNI: " & Reg.Dni(1..Reg.Long_Dni));
         Write(Arch, Reg);
         Aux := SiguienteEnLista(Aux);
      end loop;
      Close(Arch);
   end Guardar_Asistencia_en_archivo;
   
   procedure Cargar_Asistencia_en_archivo (Lista : out Lista_Asis.TipoLista) is
      Arch  : Archivo.File_Type;
      Reg   : Registro_Asistencia;
      Abrio : Boolean := False;
   begin
      CrearLista(Lista);
      begin
         Open(Arch, In_File, "asistencia.dat");
         Abrio := True;
      exception
         when Ada.IO_Exceptions.Name_Error =>
            Put_Line("No existe archivo previo de asistencia, lista vacia.");
      end;
      if Abrio then
         while not End_Of_File(Arch) loop
            Read(Arch, Reg);
             Put_Line("Leyendo DNI: " & Reg.Dni(1..Reg.long_dni));
            Lista_Asis.insertarEnLista_Final(Lista, Reg);
         end loop;
         Close(Arch);
      end if;
   end Cargar_Asistencia_en_archivo;

   procedure Baja_Asistencia (Lista : in out Lista_Asis.TipoLista) is
      Dni_Busq : String(1..8);
      Long     : Integer;
   begin
      Put_Line("Ingrese el DNI del empleado a dar de baja:");
      Get_Line(Dni_Busq, Long);
      Baja_Asis_Por_Dni(Lista, Dni_Busq, Long);
      Put_Line("Baja realizada.");
   end Baja_Asistencia;

end Asistencia_IO;