-- PL/pgSQL
-- Contenedor que contiene el código plsql en postgre, donde tiene los declare, etc.

-- Ejemplo

DO $$
DECLARE nombre varchar(30) := 'Juán López';
BEGIN
RAISE NOTICE 'Bienvenido %',nombre;
END $$ language 'plpgsql';

-- EJERCICIOS
/*

1 - Escriba un bloque de codigo PL/pgSQL que reciba una nota como parametro
    y notifique en la consola de mensaje las letras A,B,C,D,E o F segun el valor de la nota

*/

DO $$
DECLARE nota char(1) := 'A';
DECLARE nota_num integer := 0;
BEGIN
CASE nota_num
	WHEN 10 THEN
		nota := 'A';
	WHEN 8 THEN
		nota := 'B';
	WHEN 6 THEN
		nota := 'C';
	WHEN 5 THEN
		nota := 'D';
	WHEN 3 THEN
		nota := 'E';
	WHEN 0 THEN
		nota := 'F';
	ELSE
		nota := 'F';
END CASE;
		
RAISE NOTICE 'La nota obtenida es de: %',nota;
END $$ language 'plpgsql';

/*
2 - Escriba un bloque de codigo PL/pgSQL que reciba un numero como parametro
    y muestre la tabla de multiplicar de ese numero.
*/

DO $$
DECLARE num_e integer := 4;
DECLARE resultado integer := 0;
BEGIN
	FOR x IN 1..10 LOOP	
		resultado := num_e*x;
		RAISE NOTICE 'Valor: %',resultado;
	END LOOP;	
END $$ language 'plpgsql';

/*
3 - Escriba una funcion PL/pgSQL que convierta de dolares a moneda nacional.
    La funcion debe recibir dos parametros, cantidad de dolares y tasa de cambio.
    Al final debe retornar el monto convertido a moneda nacional.
*/

CREATE OR REPLACE FUNCTION calcular_dolares(dolares numeric, tasa_cambio numeric) RETURNS integer language plpgsql AS $$
	DECLARE resultado numeric := 0;
	BEGIN
		resultado := dolares * tasa_cambio;
		RETURN resultado;
	END;$$

DO $$
	BEGIN
		RAISE NOTICE 'Resultado: %',calcular_dolares(10,1.5);	
END $$ LANGUAGE 'plpgsql';

/*

4 - Escriba una funcion PL/pgSQL que reciba como parametro el monto de un prestamo,
    su duracion en meses y la tasa de interes, retornando el monto de la cuota a pagar.
    Aplicar el metodo de amortizacion frances.

*/

CREATE OR REPLACE FUNCTION calcular_amortizacion(prestamo numeric, tiempo int, tasa numeric) RETURNS numeric LANGUAGE plpgsql AS $$
	DECLARE resultado numeric := 0;
	BEGIN
		RETURN (prestamo *tasa)/(1-(1+tasa)^(-tiempo));
END;$$

DO $$
	BEGIN
		RAISE NOTICE 'El calculo de la amortización: %',calcular_amortizacion(3000,12,1.5);
END $$ LANGUAGE 'plpgsql';