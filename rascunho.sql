-- log das mudanças salariais dos funcionarios
CREATE TABLE log_salario (
    codigo NUMBER(7, 2) PRIMARY KEY,
    salario_anterior NUMBER(7, 2),
    salario_atual NUMBER(7, 2),
    data_alteracao DATE,
    usuario VARCHAR2(40)
);

-- gatilho da mudança salarial
CREATE OR REPLACE TRIGGER trg_salario_aud
AFTER UPDATE ON EMP
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    INSERT INTO log_salario(codigo, salario_anterior, salario_atual, data_alteracao, usuario)
    VALUES (:NEW.empno, :OLD.sal, :NEW.sal, SYSDATE, USER);
END;

-- mudando o salário do funcionário nº 5000
UPDATE EMP SET SAL = SAL * 1.1 WHERE empno = 5000;

-- confirmando se a trigger rodou
SELECT * FROM log_salario;
-- RESULTADO:
--     CODIGO SALARIO_ANTERIOR SALARIO_ATUAL DATA_ALT USUARIO
-- ---------- ---------------- ------------- -------- -------------
--       5000             1100          1210 06/12/19 USER1        

-- gatilho que verifica se o novo salário é maior que o salário mínimo
CREATE OR REPLACE TRIGGER trg_salario_check
AFTER UPDATE ON EMP
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    IF :NEW.sal < 980 THEN
        RAISE_APPLICATION_ERROR(-20004, 'EMP.sal PRECISA SER MAIOR QUE O SALARIO MINIMO VIGENTE');
    END IF;
END;
