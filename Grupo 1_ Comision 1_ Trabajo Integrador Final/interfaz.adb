with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Characters.Handling, Empleados_IO, Asistencia_IO, Reportes_IO, grupo1_TAD_lista;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Characters.Handling, Empleados_IO, Asistencia_IO, Reportes_IO;

package body Interfaz is

   subtype Cade8 is String (1 .. 8);

   Lista_Emp   : Empleados_IO.Lista_Empleados.tipolista;
   Lista_Asis  : Asistencia_IO.Lista_Asis.TipoLista;
   Inicializado : Boolean := False;

   ----------------------------------------------------------------
   -- Carga inicial: levanta los archivos si existen.
   ----------------------------------------------------------------
   procedure Cargar_Inicial is
   begin
      Cargar_Empleados_en_archivo (Lista_Emp);
      Cargar_Asistencia_en_archivo (Lista_Asis);
      Inicializado := True;
   end Cargar_Inicial;

   ----------------------------------------------------------------
   -- Submenu de gestion de empleados.
   ----------------------------------------------------------------
   procedure Menu_Empleados is
      Op : Integer;
      Dni_Busq : Cade8;
      Long     : Integer;
      Reg      : Empleados_IO.Empleado;
   begin
      loop
           New_Line;
         Put_Line ("====== GESTION DE EMPLEADOS ======");
         Put_Line ("1) Alta de empleado");
         Put_Line ("2) Baja de empleado (por DNI)");
         Put_Line ("3) Modificar empleado (por DNI)");
         Put_Line ("4) Consultar empleado (por DNI)");
         Put_Line ("5) Listar todos los empleados");
         Put_Line ("0) Volver al menu principal");
         Put     ("Opcion: ");
         Get (Op);

         Skip_Line;

         case Op is
            when 1 =>
               Reg.Anulado := False;--esta bandera cuando esta en true no imprime ningun empleado
               
               Put_line("Nombre y Apellido: ");
               Get_Line (Reg.Nombre_Apellido, Reg.Long_Nom_Apellido);

               Put_line("Sexo (M/F): ");
               Get (Reg.Sexo);
               Skip_Line;

               Put_line("DNI: ");
               Get_Line (Reg.Dni, Reg.Long_Dni);

               Put_line("Fecha de nacimiento (dia mes anio): ");
               Get (Reg.Fecha_Nacimiento.Dia);
               Get (Reg.Fecha_Nacimiento.Mes);
               Get (Reg.Fecha_Nacimiento.Ano);
               Skip_Line;

               Put_line("Funcion en la empresa: ");
               Get_Line (Reg.Funcion_En_La_Empresa, Reg.Long_Empresa);

               Put_line("Fecha de ingreso (dia mes anio): ");
               Get (Reg.Fecha_Ingreso.Dia);
               Get (Reg.Fecha_Ingreso.Mes);
               Get (Reg.Fecha_Ingreso.Ano);
               Skip_Line;

               Put_line("Horario laboral xx:xx-xx:xx: ");
               Get_Line (Reg.Horario_Laboral, Reg.Long_Horario_Laboral);

               Put_Line("Antes del alta:");
               
               Listar_todos_los_empleados(Lista_Emp);

               Alta_Empleado(Lista_Emp, Reg);

               Put_Line("Despues del alta:");
               Listar_todos_los_empleados(Lista_Emp);
               Guardar_Empleados_en_archivo (Lista_Emp);

            when 2 =>
               Put ("DNI del empleado a dar de baja: ");
               Get_Line (Dni_Busq, Long);
               Baja_Empleado (Lista_Emp, Dni_Busq, Long);
               Guardar_Empleados_en_archivo (Lista_Emp);

            when 3 =>
               Put_line("DNI del empleado a modificar: ");
               Get_Line (Dni_Busq, Long);   
            
               Put_line ("Ingrese los datos nuevamente .");
               skip_line;
               Put_line ("Nuevo nombre: ");
               Get_Line (Reg.Nombre_Apellido, Reg.Long_Nom_Apellido);

               Put_line("Sexo (M/F): ");
               Get (Reg.Sexo);
               Skip_Line;

               Put_Line("Ingrese un nuevo dni ");
               Get_line(Reg.Dni , Reg.Long_Dni);
               
               Put_line("Nueva funcion: ");
               Get_Line (Reg.Funcion_En_La_Empresa, Reg.Long_Empresa);
               skip_line;
               Put_line("Ingrese nueva de Fecha de  Nacimiento del Empleado ");
               Get(Reg.Fecha_Nacimiento.Dia );
               Get(Reg.Fecha_Nacimiento.Mes);
               Get(Reg.Fecha_Nacimiento.Ano);
               
               Put_line("Fecha de ingreso (dia mes anio): ");
               Get (Reg.Fecha_Ingreso.Dia);
               Get (Reg.Fecha_Ingreso.Mes);
               Get (Reg.Fecha_Ingreso.Ano);
               Skip_Line;

               Put_line("Horario laboral xx:xx-xx:xx: ");
               Get_Line (Reg.Horario_Laboral, Reg.Long_Horario_Laboral);

               Modificar_Empleado (Lista_Emp, Dni_Busq, Long, Reg);
               Guardar_Empleados_En_Archivo (Lista_Emp);
            
                                     
            when 4 =>
                     Put_line("DNI a consultar: ");
                     Get_Line (Dni_Busq, Long);
                     Consultar_Empleado (Lista_Emp, Dni_Busq, Long);
                     
            when 5 =>
               Listar_todos_los_empleados(Lista_Emp);
            when 0 =>
               Guardar_Empleados_en_archivo (Lista_Emp);
               return;

            when others =>
               Put_Line ("Opcion invalida.");
         end case;
      end loop;
   end Menu_Empleados;

   ----------------------------------------------------------------
   -- Submenu de gestion de asistencia.
   ----------------------------------------------------------------
   procedure Menu_Asistencia is
      Op : Integer;
      Dni_Busq : Cade8;
      Long     : Integer;
      Reg      : Asistencia_IO.Registro_Asistencia;
   begin
      loop
         New_Line;
         Put_Line ("====== GESTION DE ASISTENCIA ======");
         Put_Line ("1) Ingresar registros manualmente");
         Put_Line ("2) Baja por DNI");
         Put_Line ("3) Modificar por DNI"); 
         Put_Line ("4) Consultar por DNI");
         Put_Line ("0) Volver al menu principal");
         Put     ("Opcion: ");
         Get (Op);
         Skip_Line;

         case Op is
            
            when 1 =>
               Ingreso_Asis (Lista_Asis);   
               Guardar_asistencia_en_Archivo(Lista_Asis);   
            when 2 =>
               Put_line("DNI del empleado a dar de baja: ");
               Get_Line (Dni_Busq, Long);
               Baja_Asis_Por_Dni (Lista_Asis, Dni_Busq, Long);
               Guardar_asistencia_en_Archivo(Lista_Asis);      
            when 3 => 
               Put_Line("Dni a Modificar la asistencia");
               Get_Line (Dni_Busq, Long);
                               
               
               Put_Line("Ingrese los siguientes datos del empleado:");
               Skip_line;
               Put_Line("Nombre y Apellido (max 20):");
               Get_Line(Reg.Nombre_Apellido, Reg.Long_Nom_Apell);
               
               Put_Line("DNI (max 8):");
               Get_Line(Reg.Dni, Reg.Long_Dni);
               Put_Line("Fecha entrada (dia mes anio):");
               Get(Reg.Fecha_Ent.Dia);
               Get(Reg.Fecha_Ent.Mes);
               Get(Reg.Fecha_Ent.Ano);
               Skip_Line;
               
               Put_Line("Hora entrada (se ingresa uno por uno como entero)(hora minuto):");
               Get(Reg.Fecha_Ent.Hora);
               Get(Reg.Fecha_Ent.Min);
               Skip_Line;
               
               Put_Line("Hora salida (se ingresa uno por uno como entero) (hora minuto):");
               Get(Reg.Fecha_Sal.Hora);
               Get(Reg.Fecha_Sal.Min);
               Skip_Line;
               
               Put_Line("Fecha salida  (dia mes anio):");
               Get(Reg.Fecha_Sal.Dia);
               Get(Reg.Fecha_Sal.Mes);
               Get(Reg.Fecha_Sal.Ano);
               Skip_Line;
               
               Modificar_asis (Lista_asis, Dni_Busq, Long, Reg);
               Guardar_asistencia_en_Archivo(Lista_Asis);   

            when 4 =>
               Put_line("DNI a consultar: ");
               Get_Line (Dni_Busq, Long);
               Consultar_Asistencia (Lista_Asis, Dni_Busq, Long);
               
            when 0 =>
               Guardar_Asistencia_en_archivo (Lista_Asis);
               return;
               
            when others =>
               Put_Line ("Opcion invalida.");
         end case;
      end loop;
   end Menu_Asistencia;

   ----------------------------------------------------------------
   -- Submenu de reportes.
   ----------------------------------------------------------------


   procedure Menu_Reportes is
      Op  : Integer;
      Mes : Integer;
      Anio: Integer;
     begin
        New_Line;
        Put_Line ("====== REPORTES ======");
        Put_Line ("1) Empleados por funcion");
        Put_Line ("2) Proximos a jubilarse");
        Put_Line ("3) Asistencia diaria");
        Put_Line ("4) Empleados con mas horas en un mes");
        Put_Line ("5) Empleados con menos horas en un mes");
        Put_Line ("6) Empleados con mas inasistencias en un mes");
        Put_Line ("7) Horas por empleado en un mes");
        Put_Line ("8) Empleados con mas inasistencias en total");
        Put_Line ("9) Totales de asistencias e inasistencias por empleado");
        Put_Line ("0) Volver al menu principal");
        Put     ("Opcion: ");
        Get (Op);
        Skip_Line;

        case Op is
           when 1 =>
              Listar_Por_Funcion (Lista_Emp);
           when 2 =>
              Listar_Proximos_Jubilarse (Lista_Emp);
           when 3 =>
              Reporte_Diario (Lista_Emp, Lista_Asis);
           when 4 | 5 | 6 =>
              Put ("Mes: ");
              Get (Mes);
              Skip_Line;
              Put ("Anio: ");
              Get (Anio);
              Skip_Line;
              if Op = 4 then
                 Empleados_Mas_Horas_Mes (Lista_Asis, Mes, Anio);
              elsif Op = 5 then
                 Empleados_Menos_Horas_Mes (Lista_Asis, Mes, Anio);
              else
                 Empleados_Mas_Inasistencias_Mes (Lista_Asis, Mes, Anio);
              end if;
           when 7 =>
              Put ("Mes: ");
              Get (Mes);
              Skip_Line;
              Put ("Anio: ");
              Get (Anio);
              Skip_Line;
              Horas_Por_Empleado (Lista_Emp, Lista_Asis, Mes, Anio);
           when 8 =>
              Empleados_Mas_Inasistencias_Total (Lista_Asis);
           when 9 =>
              Listar_Totales_Empleados (Lista_Asis);
           when 0 =>
                 return;
           when others =>
              Put_Line ("Opcion invalida.");
        end case;
     end Menu_Reportes;

   ----------------------------------------------------------------
   -- Procedimiento principal expuesto en interfaz.ads.
   ----------------------------------------------------------------
   
   --- falta una excepcion para que no se ingrese un caracter  
   --- en cada submenu y el menu principal
   procedure Ejecutar is
      Op : Integer;
   begin
      Cargar_Inicial;

      loop
         New_Line;
         Put_Line ("============================================");
         Put_Line ("   SISTEMA DE EMPLEADOS Y ASISTENCIA");
         Put_Line ("============================================");
         Put_Line ("1) Gestion de empleados");
         Put_Line ("2) Gestion de asistencia");
         Put_Line ("3) Reportes");
         Put_Line ("0) Salir");
         Put     ("Opcion: ");
         Get (Op);
         Skip_Line;

         case Op is
            when 1 => Menu_Empleados;
            when 2 => Menu_Asistencia;
            when 3 => Menu_Reportes;
            when 0 =>
               Guardar_Empleados_en_archivo (Lista_Emp);
               Guardar_Asistencia_en_archivo (Lista_Asis);
               Put_Line ("Saliendo...");
               return;
            when others => Put_Line ("Opcion invalida.");
         end case;
      end loop;
   end Ejecutar;

end Interfaz;
