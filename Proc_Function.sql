--%type = ele muda conforme tamanho da coluna

--Estrutura
DECLARE --VARIAVEL
BEGIN
EXCEPTION --TRATAMENTO DE ERRO
END

--Criar Proc para adicionar valores na BASE
CREATE PROCEDURE incluir_segmercado (p_id IN NUMBER, p_descricao IN VARCHAR2)
IS
BEGIN

    INSERT into segmercado values(p_id, UPPER(p_descricao));
    COMMIT;

END;

--Alterar para que seja reconhecido o tamanho setado no DB
CREATE OR REPLACE PROCEDURE incluir_segmercado (p_id IN segmercado.id%type, p_descricao IN segmercado.descricao%type)
IS
BEGIN

    INSERT into segmercado values(p_id, UPPER(p_descricao));
    COMMIT;

END;

--Adicionar valor na PROC
EXECUTE incluir_segmercado(3,'Farmaceutico')

--Adicionar valor na PROC dentro do PL/SQL
BEGIN
	incluir_segmercado(4,'Industrial');
END;

--FUNCTION
--PEGA o valor da tabela segmercado, coluna descricao e salva na variável
--retorna valor da variável
CREATE OR REPLACE FUNCTION obter_descricao_segmercado
 (p_id IN segmercado.id%type)
RETURN segmercado.descricao%type
IS
 v_descricao segmercado.descricao%type;
BEGIN
 SELECT descricao INTO v_descricao
 FROM segmercado
 WHERE id = p_id;
 RETURN v_descricao;
END;

--chamar função
VARIABLE g_descricao varchar2(100)
EXECUTE :g_descricao := obter_descricao_segmercado (1)
PRINT g_descricao

--Chamar função por PL/SQL
SET SERVEROUTPUT ON
DECLARE
 v_descricao segmercado.descricao%type;
BEGIN
 v_descricao := obter_descricao_segmercado(2);
 dbms_output.put_line('Descricao: '||v_descricao);
END;


--Criar Function com logica IF
CREATE OR REPLACE FUNCTION categoria_cliente (p_faturamento_previsto IN cliente.faturamento_previsto%type) RETURN cliente.categoria%type

IS
BEGIN

    IF p_faturamento_previsto < 10000 THEN
           RETURN 'PEQUENO';
        ELSIF p_faturamento_previsto < 50000 THEN
            RETURN 'MEDIO';
        ELSIF p_faturamento_previsto < 100000 THEN
            RETURN 'MEDIO GRANDE';
        ELSE
            RETURN 'GRANDE';
        END IF;
END;

--Procedure Insere valor através da Function
CREATE OR REPLACE PROCEDURE INCLUIR_CLIENTE 
   (p_id in cliente.id%type,
    p_razao_social IN cliente.razao_social%type,
    p_CNPJ cliente.CNPJ%type ,
    p_segmercado_id IN cliente.segmercado_id%type,
    p_faturamento_previsto IN cliente.faturamento_previsto%type)
IS
    v_categoria cliente.categoria%type;

BEGIN

    v_categoria := categoria_cliente(p_faturamento_previsto);

    INSERT INTO cliente VALUES (p_id, UPPER(p_razao_social), p_CNPJ,p_segmercado_id, SYSDATE, p_faturamento_previsto, v_categoria);
    COMMIT;

END;

--Inserir valor
BEGIN
INCLUIR_CLIENTE(2, 'SUPERMERCADO IJR', '67890', NULL, 90000);
END;