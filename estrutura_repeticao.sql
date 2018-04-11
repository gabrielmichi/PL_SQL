--Base UPDATE
CREATE OR REPLACE PROCEDURE ATUALIZAR_CLI_SEG_MERCADO
	(p_id cliente.id%type,
	p_segmercado_id IN cliente.segmercado_id%type)
IS
BEGIN
	UPDATE cliente
		SET segmercado_id = p_segmercado_id
		WHERE id = p_id;
		COMMIT;
END;

--Estrutura de repetição
DECLARE
    v_segmercado_id cliente.segmercado_id%type := 1;
    v_i number(3);
BEGIN
    v_i := 1;
LOOP
    ATUALIZAR_CLI_SEG_MERCADO(v_i, v_segmercado_id);
    v_i := v_i +1;
    EXIT WHEN v_i > 3;
 END LOOP;
END;

select * from cliente

--Outra estrutura de repetição FOR LOOP
--Passamos o valor 2 para a estrutura
DECLARE
    v_segmercado_id cliente.segmercado_id%type := 2;
BEGIN
    FOR i in 1..3 LOOP
        ATUALIZAR_CLI_SEG_MERCADO(i, v_segmercado_id);
    END LOOP;
     COMMIT;
END;

select * from cliente

--Utilização de CURSOS para percorrer o algoritmo
DECLARE
    v_segmercado_id cliente.segmercado_id%type := 2;
    v_id cliente.id%type;
    CURSOR cur_cliente is SELECT id from cliente; 
BEGIN
    FOR cli_rec IN cur_cliente LOOP
       ATUALIZAR_CLI_SEG_MERCADO(cli_rec.id, v_segmercado_id);
    END LOOP;
END;

--Realizar A CHAMADA indicando o parêmetro
DECLARE 
    v_id NUMBER;
    v_segmercado_id NUMBER;
BEGIN
    v_id := 1;
    v_segmercado_id := 2;
    atualizar_cli_seg_mercado(p_id => v_id, p_segmercado_id => v_segmercado_id);
END;

select * from cliente

--CURSOR
DECLARE
 v_id cliente.id%type;
 --ATUALIZAR P/ VALOR 1
 v_segmercado_id cliente.segmercado_id%type := 1;
 CURSOR cur_cliente is
 --CONSULTA QUE O CURSOR IRA PERCORRER
	SELECT ID
	FROM cliente;
BEGIN
	--GUARDA AS LINHAS DENTRO DA MEMORIA
	OPEN cur_cliente;
	LOOP
		FETCH cur_cliente into v_id;
		EXIT WHEN cur_cliente%NOTFOUND;
		ATUALIZAR_CLI_SEG_MERCADO(v_id, v_segmercado_id);
		END LOOP;
		--fechar o cursor
		CLOSE cur_cliente;
		
		COMMIT;
END;
 
--OTIMIZAR CURSOR
DECLARE
    v_segmercado_id cliente.segmercado_id%type := 2;
    CURSOR cur_cliente is SELECT id FROM cliente;

BEGIN

    FOR cli_rec IN cur_cliente LOOP
        ATUALIZAR_CLI_SEG_MERCADO(cli_rec.id, v_segmercado_id);
    END LOOP;

    COMMIT;

END;