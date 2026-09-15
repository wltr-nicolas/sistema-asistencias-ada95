with Ada.Text_Io, Empleados_Io,Asistencia_Io , grupo1_TAD_lista;
use Ada.Text_IO,Empleados_IO,Asistencia_IO;
package Reportes_IO is


   type Resumen_Mensual is record
      Dni           : Cade8;
      Long_Dni      : Integer;
      Asistencias   : Natural;
      Inasistencias : Natural;
      Horas_Tot     : Natural;
   end record;

   package Lista_Resumen is new grupo1_TAD_lista(Resumen_Mensual);
   use  Lista_Resumen;

   procedure Resumen_Mes(Lista_Asis : in  Asistencia_IO.Lista_Asis.TipoLista;Mes: in  Integer; Anio: in  Integer;Resumen    : out Lista_Resumen.TipoLista);

   procedure Listar_Por_Funcion(Empleados : in Empleados_IO.Lista_Empleados.tipolista);

   procedure Listar_Proximos_Jubilarse(Empleados : in Empleados_IO.Lista_Empleados.tipolista);

   procedure Reporte_Diario(Empleados : in Empleados_IO.Lista_Empleados.tipolista;Asist     : in Asistencia_IO.Lista_Asis.TipoLista);

   procedure Empleados_Mas_Horas_Mes(Asist : in Asistencia_IO.Lista_Asis.TipoLista;Mes   : in Integer;Anio  : in Integer);

   procedure Empleados_Menos_Horas_Mes(Asist : in Asistencia_IO.Lista_Asis.TipoLista;Mes   : in Integer;Anio  : in Integer);

   procedure Empleados_Mas_Inasistencias_Mes(Asist : in Asistencia_IO.Lista_Asis.TipoLista;Mes   : in Integer;Anio  : in Integer);

   procedure Horas_Por_Empleado(Empleados_h : in Empleados_IO.Lista_Empleados.tipolista;Asist: in Asistencia_IO.Lista_Asis.TipoLista;Mes: in Integer;Anio: in Integer);
   procedure Empleados_Mas_Inasistencias_Total(Asist : in Asistencia_IO.Lista_Asis.TipoLista);

   procedure Listar_Totales_Empleados(Asist : in Asistencia_IO.Lista_Asis.TipoLista);
end Reportes_IO;
