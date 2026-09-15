with Ada.Text_IO ,grupo1_TAD_lista;
use Ada.Text_IO;
package Asistencia_IO is
   

   subtype Cade20 is String(1..20);
   subtype Cade8  is String(1..8);

   type Fecha_Hora is record
      Dia  : Integer;
      Mes  : Integer;
      Ano  : Integer;
      Hora : Integer;
      Min  : Integer;
   end record;

   type Registro_Asistencia is record
      Nombre_Apellido : Cade20;
      Long_Nom_Apell  : Integer;
      Dni             : Cade8;
      Long_Dni        : Integer;
      Fecha_Ent       : Fecha_Hora;
      Fecha_Sal       : Fecha_Hora;
      Anulado         : Boolean;
   end record;

   package Lista_Asis is new grupo1_TAD_lista(Registro_Asistencia);
   use Lista_asis;
   procedure Ingreso_Asis        (Lista :  in out Lista_Asis.TipoLista);
   procedure Cargar_Asistencia_en_archivo   (Lista : out Lista_Asis.TipoLista);
   procedure Guardar_Asistencia_en_archivo  (Lista : in  Lista_Asis.TipoLista);
   procedure Baja_Asistencia     (Lista : in out Lista_Asis.TipoLista);

   procedure Alta_Asistencia      (Lista : in out Lista_Asis.TipoLista; Reg : Registro_Asistencia);
   procedure Baja_Asis_Por_Dni    (Lista : in out Lista_Asis.TipoLista; Dni : String; Long : Integer);
   procedure Modificar_Asis(Lista_a : in out Lista_Asis.TipoLista; Dni : in out String; Long : in out Integer; Nuevo : in out Registro_Asistencia   ); 
   procedure Consultar_Asistencia (Lista : in Lista_Asis.TipoLista; Dni : String; Long : Integer);

   function Calcular_Horas_Asistencia (R : Registro_Asistencia) return Integer;

end Asistencia_IO;