CREATE OR REPLACE FUNCTION GenerateInsertCommand(p_id NUMBER, p_val NUMBER) RETURN VARCHAR2 IS
BEGIN
  RETURN 'INSERT INTO MyTable (id, val) VALUES (' || p_id || ', ' || p_val || ');';
END GenerateInsertCommand;
