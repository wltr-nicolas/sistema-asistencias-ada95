with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Sequential_IO, Ada.Characters.Handling, Ada.IO_Exceptions;
use Ada.Text_IO,Ada.Integer_Text_IO,Ada.Characters.Handling,Ada.IO_Exceptions;

package body Empleados_IO is

   package Archivo is new Ada.Sequential_IO(Empleado);
   use  Archivo;

   procedure Sanitizar (R : in out Empleado) is
      procedure Clamp (L : in out Integer; Max : Integer) is
      begin
         if L < 0 then L := 0;
         elsif L > Max then L := Max;
         end if;
      end Clamp;
   begin
      Clamp (R.Long_Nom_Apellido,    50);
      Clamp (R.Long_Dni,             50);
      Clamp (R.Long_Empresa,         50);
      Clamp (R.Long_Horario_Laboral, 50);
   end Sanitizar;

   function Safe_Slice (S : String; L : Integer) return String is
   begin
      if L <= 0 then return "-";
      elsif L >= S'Length then return S;
      else return S (S'First .. S'First + L - 1);
      end if;
   end Safe_Slice;

        

procedure Alta_Empleado(Lista_E : in out Lista_Empleados.TipoLista;Reg:in Empleado) is
begin
   insertarEnLista_Final(Lista_E, Reg);
end Alta_Empleado;

   procedure Baja_Empleado(Lista_e : in out Lista_Empleados.tipolista; Dni : in  String; Long :in Integer)
   is
      Origen   : Lista_Empleados.tipolista := Lista_e;
      Destino  : Lista_Empleados.tipolista;
      R        : Empleado;
      Encontro : Boolean := False;
   begin
      lista_empleados.CrearLista(Destino);
      while not lista_empleados.ListaVacia(Origen) loop
         R := lista_Empleados.InfoDeLista(Origen);
         Origen := lista_empleados.SiguienteEnLista(Origen);
         Sanitizar (R);
         if not R.Anulado
           and then R.Dni(1..R.Long_Dni) = Dni(1..Long)
         then
            R.Anulado := True;
            Encontro := True;
         end if;
         lista_empleados.insertarEnLista_Final(Destino, R);
      end loop;
      lista_empleados.limpiarLista(Lista_E);
      Lista_E := Destino;
      if not Encontro then
         Put_Line ("No se encontro el empleado con ese DNI.");
      else
         Put_Line ("Empleado dado de baja.");
      end if;
   end Baja_Empleado;

    procedure Modificar_Empleado(Lista_e : in out Lista_Empleados.tipolista; Dni : in out String; Long : in out Integer; Nuevo : in out   Empleado) is
      Origen   : Lista_Empleados.tipolista := Lista_E;
      Destino  : Lista_Empleados.tipolista;
      R        : Empleado;
      Encontro : Boolean := False;
    begin
      
      Crearlista(Destino);
      
      while not Lista_Empleados.ListaVacia(Origen)and not encontro loop
          R := Lista_Empleados.Infodelista(Origen);
          --Busqueda_Dni(Lista_e  , Dni , Long);
         Origen := Lista_Empleados.SiguienteEnLista(Origen);
         Sanitizar (R);
         if not R.Anulado and then R.Dni(1..R.Long_Dni) = Dni(1..Long)then
            R := Nuevo;
            Encontro := True;
         end if;
         Lista_Empleados.insertarEnLista_Final(Destino, R);
      end loop;
      
      Lista_Empleados.limpiarLista(Lista_E);
      Lista_E := Destino;
         
   end Modificar_Empleado;



  procedure Consultar_Empleado(Lista_E: in Lista_Empleados.tipolista; Dni: in String; Long : in Integer) is
      Aux : Lista_Empleados.tipolista := Lista_E;
      R   : Empleado;
      Encontro : Boolean := False;
   begin
      while not Lista_Empleados.ListaVacia(Aux) loop
         R := Lista_Empleados.InfoDeLista(Aux);
         Aux := Lista_Empleados.SiguienteEnLista(Aux);
         Sanitizar (R);
         if not R.Anulado and R.Dni(1..R.Long_Dni) = Dni(1..Long) then
            Put_Line("  Nombre: "        & Safe_Slice(R.Nombre_Apellido, R.Long_Nom_Apellido));
            Put_Line("  DNI: "           & Safe_Slice(R.Dni, R.Long_Dni));
            Put_Line("  Sexo: "          & R.Sexo);
            Put_Line("  Fecha Nac.: "    &
               Integer'Image(R.Fecha_Nacimiento.Dia) & "/" &
               Integer'Image(R.Fecha_Nacimiento.Mes) & "/" &
               Integer'Image(R.Fecha_Nacimiento.Ano));
            Put_Line("  Funcion: "       & Safe_Slice(R.Funcion_En_La_Empresa, R.Long_Empresa));
            Put_Line("  Fecha Ingreso: " &
               Integer'Image(R.Fecha_Ingreso.Dia) & "/" &
               Integer'Image(R.Fecha_Ingreso.Mes) & "/" &
               Integer'Image(R.Fecha_Ingreso.Ano));
            Put_Line("  Horario: "       & Safe_Slice(R.Horario_Laboral, R.Long_Horario_Laboral));
            Encontro := True;
            exit;
         end if;
      end loop;
      if not Encontro then
         Put_Line ("No se encontro el empleado con ese DNI.");
      end if;
   end Consultar_Empleado;


   
   procedure Muestro_Regi (Reg: in Empleado) is
      R : Empleado := Reg;
   begin
      Sanitizar (R);
      Put_Line("  __________________");
      Put_Line(" /                  \");
      Put_Line("| Datos Del Empleado |");
      Put_Line(" \__________________/");
      New_Line; New_Line;
      Put_Line("[Nombre]");
      Put_Line(Safe_Slice(R.Nombre_Apellido, R.Long_Nom_Apellido));
      New_Line;
      Put_Line("[D.N.I]");
      Put_Line(Safe_Slice(R.Dni, R.Long_Dni));
      New_Line;
      Put_Line("[Sexo]");
      Put_Line (" " & R.Sexo);
      New_Line;
      Put_Line("[Fecha De Nacimiento]");
      Put_Line(Integer'Image(R.Fecha_Nacimiento.Dia) & " / " &
               Integer'Image(R.Fecha_Nacimiento.Mes) & " / " &
               Integer'Image(R.Fecha_Nacimiento.Ano));
      New_Line;
      Put_Line("[Funcion En La Empresa]");
      Put_Line(Safe_Slice(R.Funcion_En_La_Empresa, R.Long_Empresa));
      New_Line;
      Put_Line("[Fecha De Ingreso]");
      Put_Line(Integer'Image(R.Fecha_Ingreso.Dia) & " / " &
               Integer'Image(R.Fecha_Ingreso.Mes) & " / " &
               Integer'Image(R.Fecha_Ingreso.Ano));
      New_Line;
      Put_Line("[Horario Laboral xx:xx-xx:xx]");
      Put_Line(Safe_Slice(R.Horario_Laboral, R.Long_Horario_Laboral));
   end Muestro_Regi;

   
 procedure Listar_todos_los_empleados(Lista_E: in Lista_Empleados.Tipolista) is
   Ptr : Lista_Empleados.Tipolista := Lista_E;
   Reg : Empleado;
begin
   while not Lista_Empleados.ListaVacia(Ptr) loop
      Reg := Lista_Empleados.InfoDeLista(Ptr);

      if not Reg.Anulado then
         Muestro_Regi(Reg);
      end if;

      Ptr := Lista_Empleados.SiguienteEnLista(Ptr);
   end loop;
end Listar_Todos_Los_Empleados;

   procedure Guardar_Empleados_en_archivo (Lista_E : in Lista_Empleados.tipolista) is
      Arch : Archivo.File_Type;
      Aux  : Lista_Empleados.tipolista := Lista_E;
      R    : Empleado;
   begin
      Create(Arch, Out_File, "empleados.dat");
      while not Lista_Empleados.ListaVacia(Aux) loop
         R := Lista_Empleados.InfoDeLista(Aux);
         Write(Arch, R);
         Aux := Lista_Empleados.SiguienteEnLista(Aux);
      end loop;
      Close(Arch);
   end Guardar_Empleados_en_archivo;

   procedure Cargar_Empleados_en_archivo (Lista_E: out Lista_Empleados.tipolista) is
      Arch  : Archivo.File_Type;
      R     : Empleado;
      Abrio : Boolean := False;
   begin
      Lista_Empleados.CrearLista(Lista_E);
      begin
         Open(Arch, In_File, "empleados.dat");
         Abrio := True;
      exception
         when Ada.IO_Exceptions.Name_Error =>
            Put_Line("No existe archivo previo de empleados, lista vacia.");
      end;
      if Abrio then
         while not End_Of_File(Arch) loop
            Read(Arch, R);
            Sanitizar (R);
            Lista_Empleados.insertarEnLista_Final(Lista_E, R);
         end loop;
         Close(Arch);
      end if;
   end Cargar_Empleados_en_archivo;
end Empleados_IO;