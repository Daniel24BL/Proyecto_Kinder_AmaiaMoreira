create or replace procedure transaccion1_PagoMatricula2 (int, int, double precision)
as 
$$
DECLARE
	PagoMatric int;
	PagoMatric2 int;
	PagoPendiente double precision;
	
	BEGIN
		insert into PAGO_MATRICULA (ID_PAGO, ID_MATRICULA, PAGO_REALIZADO) values ($1,$2,$3);
		update MATRICULA set VALOR_PENDIENDE_A_PAGAR = VALOR_PENDIENDE_A_PAGAR - $3 where ID_MATRICULA = $2;
		select VALOR_MATRICULA into PagoMatric from MATRICULA where ID_MATRICULA = $2;
		select PAGO_REALIZADO into PagoMatric2 from PAGO_MATRICULA where ID_MATRICULA = $2;
		select VALOR_PENDIENDE_A_PAGAR into PagoPendiente from MATRICULA where ID_MATRICULA = $2;
		if (PagoMatric = PagoMatric2 ) THEN
			update MATRICULA set ESTADO_CUENTA = 'Cancelado' where ID_MATRICULA  = $2;
			ROLLBACK;
		end if; 
		if (PagoPendiente = 0.0)THEN
			update MATRICULA set ESTADO_CUENTA = 'Cancelado' where ID_MATRICULA = $2;
		end if;
	COMMIT;
end;
$$
language plpgsql;