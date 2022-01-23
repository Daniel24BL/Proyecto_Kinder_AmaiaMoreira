/* TRIGGER PARA IMPEDIR QUE UN ESTUDIANTE SE MATRICULE DOS VECES EN UN MISMO CURSO */

create or replace function ImpedirMatrucula() returns trigger
AS
$$
declare
	NMatriculas int;
	Maximo int:= 1;
begin
select count(*) into NMatriculas
from matricula 
inner join estudiante on estudiante.id_est = matricula.id_est
inner join detalle_matricula on detalle_matricula.id_matricula = matricula.id_matricula
where matricula.id_est = new.id_est;
if(NMatriculas >= Maximo) THEN
	raise exception
	'El estudiante ya se encuentra matriculado en este curso';
end if;
return new;
end;
$$
language PLPGSQL;

create trigger DenegarMatricula 
before
insert on matricula
for each row
execute procedure ImpedirMatrucula();


INSERT INTO MATRICULA VALUES (017, 2, 016,40.00,'2021-05-05');




/* Cursor */
do
	$$
	Declare 
		datos_estudiantes RECORD;
		cursor_estudiantes cursor for
	Select
		sum ((select count (estudiante.Genero_Est) from estudiante where estudiante.Genero_Est ='Masculino'
			 and id_Est=matricula.id_Est)) as Hombres,
			 
		sum ((select count (estudiante.Genero_Est) from estudiante where estudiante.Genero_Est ='Femenino'
			 and id_Est=matricula.id_Est)) as Mujeres,
		matricula.fecha_matricula as fecha
			 
	From matricula
		inner join estudiante on estudiante.id_est = matricula.id_est
		group by matricula.fecha_matricula;
		
	Begin 
		OPEN cursor_estudiantes;
		FETCH cursor_estudiantes INTO datos_estudiantes;
		WHILE (found) Loop
		RAISE NOTICE
		'	Fecha: %
			Cantidad de Niños: %
			Cantidad de Niñas: %   ',
		datos_estudiantes.fecha, datos_estudiantes.Hombres, datos_estudiantes.Mujeres;
		FETCH cursor_estudiantes INTO datos_estudiantes;
	end Loop;
end $$
language 'plpgsql';





/* Procedimiento almacenado */

Create or Replace Function Mostrar_Datos (varchar (50))
returns Text  as $$
		Declare 
			nombre_programa alias for $1;
			datos_programas RECORD;
			cur_programa cursor for select
				programa.Nombre_Programa as Nombre,
				programa.Descripcion_Actividades as Descripcion,
				programa.Materiales_a_Usar as Materiales,
				programa.Duracion_Programa as Duracion
			from public.programa
			where programa.Nombre_Programa = $1;
		Begin 
			open cur_programa;
				Fetch cur_programa into datos_programas;
				while (found) Loop
				Raise NOTICE'	
Nombre: %
Descripcion: %
Materiales: %				
Duracion: % ',												
				datos_programas.Nombre,
				datos_programas.Descripcion,
				datos_programas.Materiales,
				datos_programas.Duracion;
				Fetch cur_programa into datos_programas;
				end Loop;
		end;
$$ LANGUAGE plpgsql;


/*=======consulta de procedimiento almacenado */

select Mostrar_Datos ('Desarrollo Intelectual');



