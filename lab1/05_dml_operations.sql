CREATE OR REPLACE PROCEDURE InsertRecord(p_id NUMBER, p_val NUMBER) AS
BEGIN
  INSERT INTO MyTable (id, val) VALUES (p_id, p_val);
END InsertRecord;

CREATE OR REPLACE PROCEDURE UpdateRecord(p_id NUMBER, p_new_val NUMBER) AS
BEGIN
  UPDATE MyTable SET val = p_new_val WHERE id = p_id;
END UpdateRecord;

CREATE OR REPLACE PROCEDURE DeleteRecord(p_id NUMBER) AS
BEGIN
  DELETE FROM MyTable WHERE id = p_id;
END DeleteRecord;
