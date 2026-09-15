with Ada.Text_IO, grupo1_TAD_lista;
use Ada.Text_IO;
package Empleados_IO is
   

   subtype Cade50 is String(1..50);

   type Fecha is record
      Dia : Integer;
      Mes : Integer;
      Ano : Integer;
   end record;

   type Empleado is record
      Nombre_Apellido      : Cade50;
      Long_Nom_Apellido    : Integer;
      Dni                  : Cade50;
      Long_Dni             : Integer;
      Sexo                 : Character;
      Fecha_Nacimiento     : Fecha;
      Fecha_Ingreso        : Fecha;
      Funcion_En_La_Empresa: Cade50;
      Long_Empresa         : Integer;
      Horario_Laboral      : Cade50;
      Long_Horario_Laboral : Integer;
      Anulado              : Boolean;
   end record;

   package Lista_Empleados is new Grupo1_Tad_Lista(Empleado);
   use Lista_empleados;


   procedure Cargar_Empleados_en_archivo      (Lista_E : out Lista_Empleados.tipolista);
   procedure Guardar_Empleados_En_Archivo     (Lista_E : in  Lista_Empleados.Tipolista);
  --procedure Busqueda_Dni                     ( Lista_E : in out Lista_Empleados.tipolista; Dni : in out String; Long :in out Integer);
   procedure Alta_Empleado         (Lista_E : in out Lista_Empleados.tipolista; Reg :in Empleado);
   procedure Baja_Empleado         (Lista_E : in out Lista_Empleados.tipolista; Dni : in  String; Long : in  Integer);
   procedure Modificar_Empleado    (Lista_E : in out Lista_Empleados.tipolista; Dni :in out String; Long : in out Integer; Nuevo :in out Empleado);
   procedure Consultar_Empleado    (Lista_E : in Lista_Empleados.Tipolista; Dni :in String; Long : in Integer);
   procedure Listar_todos_los_empleados(Lista_E: in Lista_Empleados.Tipolista); 

end Empleados_IO;