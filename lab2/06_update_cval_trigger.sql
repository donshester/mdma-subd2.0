create or replace TRIGGER update_groups_info
    BEFORE INSERT OR UPDATE OR DELETE ON STUDENTS
    FOR EACH ROW
DECLARE
BEGIN
    IF INSERTING OR UPDATING OR DELETING THEN
        UPDATE GROUPS g
        SET C_VAL = (
            SELECT COUNT(*)
            FROM STUDENTS s
            WHERE s.GROUP_ID = g.ID
        )
        WHERE g.ID = :NEW.GROUP_ID OR g.ID = :OLD.GROUP_ID;
    END IF;
END;
