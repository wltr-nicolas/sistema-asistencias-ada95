with Empleados_IO, Asistencia_IO;

procedure Cargar_Datos is
   ListaEmp   : Empleados_IO.Lista_Empleados.tipolista;
   ListaAsis  : Asistencia_IO.Lista_Asis.TipoLista;
   Emp        : Empleados_IO.Empleado;
   Reg        : Asistencia_IO.Registro_Asistencia;
begin
   Empleados_IO.Cargar_Empleados_en_archivo(ListaEmp);
   Asistencia_IO.Cargar_Asistencia_en_archivo(ListaAsis);

   -- Employee 1: Juan Perez
   Emp.Nombre_Apellido := (others => ' ');
   Emp.Nombre_Apellido(1..10) := "Juan Perez";
   Emp.Long_Nom_Apellido := 10;

   Emp.Dni := (others => ' ');
   Emp.Dni(1..8) := "12345678";
   Emp.Long_Dni := 8;

   Emp.Sexo := 'M';
   Emp.Fecha_Nacimiento.Dia := 1;
   Emp.Fecha_Nacimiento.Mes := 1;
   Emp.Fecha_Nacimiento.Ano := 1990;
   Emp.Fecha_Ingreso.Dia := 1;
   Emp.Fecha_Ingreso.Mes := 1;
   Emp.Fecha_Ingreso.Ano := 2020;
   Emp.Funcion_En_La_Empresa := (others => ' ');
   Emp.Funcion_En_La_Empresa(1..8) := "Analista";
   Emp.Long_Empresa := 9;
   Emp.Horario_Laboral := (others => ' ');
   Emp.Horario_Laboral(1..11) := "09:00-18:00";
   Emp.Long_Horario_Laboral := 11;
   Emp.Anulado := False;

   Empleados_IO.Alta_Empleado(ListaEmp, Emp);
   Empleados_IO.Guardar_Empleados_En_Archivo(ListaEmp);

   -- Attendance for Juan Perez: one present (8 hours) and one absent (0 hours)
   -- Present
   Reg.Nombre_Apellido := (others => ' ');
   Reg.Nombre_Apellido(1..10) := "Juan Perez";
   Reg.Long_Nom_Apell := 10;

   Reg.Dni := (others => ' ');
   Reg.Dni(1..8) := "12345678";
   Reg.Long_Dni := 8;

   Reg.Fecha_Ent.Dia := 2;
   Reg.Fecha_Ent.Mes := 7;
   Reg.Fecha_Ent.Ano := 2026;
   Reg.Fecha_Ent.Hora := 9;
   Reg.Fecha_Ent.Min := 0;

   Reg.Fecha_Sal.Dia := 2;
   Reg.Fecha_Sal.Mes := 7;
   Reg.Fecha_Sal.Ano := 2026;
   Reg.Fecha_Sal.Hora := 17; -- 9 to 17 = 8 hours
   Reg.Fecha_Sal.Min := 0;

   Reg.Anulado := False;

   Asistencia_IO.Alta_Asistencia(ListaAsis, Reg);
   Asistencia_IO.Guardar_Asistencia_en_archivo(ListaAsis);

   -- Absent (same hour entry and exit -> 0 hours)
   Reg.Fecha_Ent.Dia := 3;
   Reg.Fecha_Ent.Mes := 7;
   Reg.Fecha_Ent.Ano := 2026;
   Reg.Fecha_Ent.Hora := 9;
   Reg.Fecha_Ent.Min := 0;

   Reg.Fecha_Sal.Dia := 3;
   Reg.Fecha_Sal.Mes := 7;
   Reg.Fecha_Sal.Ano := 2026;
   Reg.Fecha_Sal.Hora := 9; -- same as entrance -> 0 hours
   Reg.Fecha_Sal.Min := 0;

   Asistencia_IO.Alta_Asistencia(ListaAsis, Reg);
   Asistencia_IO.Guardar_Asistencia_en_archivo(ListaAsis);

   -- Employee 2: Maria Lopez
   Emp.Nombre_Apellido := (others => ' ');
   Emp.Nombre_Apellido(1..11) := "Maria Lopez";
   Emp.Long_Nom_Apellido := 11;

   Emp.Dni := (others => ' ');
   Emp.Dni(1..8) := "87654321";
   Emp.Long_Dni := 8;

   Emp.Sexo := 'F';
   Emp.Fecha_Nacimiento.Dia := 15;
   Emp.Fecha_Nacimiento.Mes := 5;
   Emp.Fecha_Nacimiento.Ano := 1985;
   Emp.Fecha_Ingreso.Dia := 1;
   Emp.Fecha_Ingreso.Mes := 3;
   Emp.Fecha_Ingreso.Ano := 2019;
   Emp.Funcion_En_La_Empresa := (others => ' ');
   Emp.Funcion_En_La_Empresa(1..9) := "Disenador";
   Emp.Long_Empresa := 9;
   Emp.Horario_Laboral := (others => ' ');
   Emp.Horario_Laboral(1..11) := "08:00-17:00";
   Emp.Long_Horario_Laboral := 11;
   Emp.Anulado := False;

   Empleados_IO.Alta_Empleado(ListaEmp, Emp);
   Empleados_IO.Guardar_Empleados_En_Archivo(ListaEmp);

   -- Maria Lopez: two present days, one absent
   -- Present day 1
   Reg.Nombre_Apellido := (others => ' ');
   Reg.Nombre_Apellido(1..11) := "Maria Lopez";
   Reg.Long_Nom_Apell := 11;

   Reg.Dni := (others => ' ');
   Reg.Dni(1..8) := "87654321";
   Reg.Long_Dni := 8;

   Reg.Fecha_Ent.Dia := 5;
   Reg.Fecha_Ent.Mes := 7;
   Reg.Fecha_Ent.Ano := 2026;
   Reg.Fecha_Ent.Hora := 8;
   Reg.Fecha_Ent.Min := 0;

   Reg.Fecha_Sal.Dia := 5;
   Reg.Fecha_Sal.Mes := 7;
   Reg.Fecha_Sal.Ano := 2026;
   Reg.Fecha_Sal.Hora := 16; -- 8 to 16 = 8 hours
   Reg.Fecha_Sal.Min := 0;

   Reg.Anulado := False;

   Asistencia_IO.Alta_Asistencia(ListaAsis, Reg);
   Asistencia_IO.Guardar_Asistencia_en_archivo(ListaAsis);

   -- Present day 2
   Reg.Fecha_Ent.Dia := 6;
   Reg.Fecha_Ent.Mes := 7;
   Reg.Fecha_Ent.Ano := 2026;
   Reg.Fecha_Ent.Hora := 8;
   Reg.Fecha_Ent.Min := 0;

   Reg.Fecha_Sal.Dia := 6;
   Reg.Fecha_Sal.Mes := 7;
   Reg.Fecha_Sal.Ano := 2026;
   Reg.Fecha_Sal.Hora := 16;
   Reg.Fecha_Sal.Min := 0;

   Asistencia_IO.Alta_Asistencia(ListaAsis, Reg);
   Asistencia_IO.Guardar_Asistencia_en_archivo(ListaAsis);

   -- Absent
   Reg.Fecha_Ent.Dia := 7;
   Reg.Fecha_Ent.Mes := 7;
   Reg.Fecha_Ent.Ano := 2026;
   Reg.Fecha_Ent.Hora := 8;
   Reg.Fecha_Ent.Min := 0;

   Reg.Fecha_Sal.Dia := 7;
   Reg.Fecha_Sal.Mes := 7;
   Reg.Fecha_Sal.Ano := 2026;
   Reg.Fecha_Sal.Hora := 8; -- same -> 0 hours
   Reg.Fecha_Sal.Min := 0;

   Asistencia_IO.Alta_Asistencia(ListaAsis, Reg);
   Asistencia_IO.Guardar_Asistencia_en_archivo(ListaAsis);
end Cargar_Datos;
