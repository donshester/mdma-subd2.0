-- Updated trigger to new table
    CREATE OR REPLACE TRIGGER students_audit_trigger
    BEFORE INSERT OR UPDATE OR DELETE ON STUDENTS
    FOR EACH ROW
DECLARE
    v_action VARCHAR2(20);
BEGIN
    IF INSERTING THEN
        v_action := 'INSERT';
        INSERT INTO students_audit_table (action_type, student_id, student_name, group_id, action_date)
        VALUES (v_action, :NEW.ID, :NEW.NAME, :NEW.GROUP_ID, SYSTIMESTAMP);
    ELSIF UPDATING THEN
        v_action := 'UPDATE';
        INSERT INTO students_audit_table (action_type, student_id, student_name, group_id, old_student_name, old_group_id, action_date)
        VALUES (v_action, :NEW.ID, :NEW.NAME, :NEW.GROUP_ID, :OLD.NAME, :OLD.GROUP_ID, SYSTIMESTAMP);
    ELSE
        v_action := 'DELETE';
        INSERT INTO students_audit_table (action_type, student_id, student_name, group_id, old_student_name, old_group_id, action_date)
        VALUES (v_action, :OLD.ID, :OLD.NAME, :OLD.GROUP_ID, :OLD.NAME, :OLD.GROUP_ID, SYSTIMESTAMP);
    END IF;
END;
/
