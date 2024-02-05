DECLARE
  v_id NUMBER;
  v_val NUMBER;
BEGIN
  FOR i IN 1..10000 LOOP
    v_id := i;
    v_val := ROUND(DBMS_RANDOM.VALUE * 100);
    INSERT INTO MyTable (id, val) VALUES (v_id, v_val);
  END LOOP;
END;
