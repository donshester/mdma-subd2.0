-- Unique ids in students
CREATE OR REPLACE TRIGGER unique_id_trigger
    BEFORE INSERT ON STUDENTS
    FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM STUDENTS WHERE ID = :NEW.ID;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Duplicate ID found in STUDENTS table');
    END IF;
END;

-- Unique ids in groups
CREATE OR REPLACE TRIGGER unique_id_trigger_groups
    BEFORE INSERT ON GROUPS
    FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM GROUPS WHERE ID = :NEW.ID;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Duplicate ID found in GROUPS table');
    END IF;
END;



-- Unique group name trigger
CREATE OR REPLACE TRIGGER unique_group_name_trigger
    BEFORE INSERT OR UPDATE ON GROUPS
    FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM GROUPS WHERE NAME = :NEW.NAME;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Duplicate NAME found in GROUPS table');
    END IF;
END;

-- Autoincrement for students
CREATE OR REPLACE TRIGGER auto_increment_trigger_students
    BEFORE INSERT ON STUDENTS
    FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT NVL(MAX(ID), 0) + 1 INTO :NEW.ID FROM STUDENTS;
    END IF;
END;

-- Autoincrement for groups
CREATE OR REPLACE TRIGGER auto_increment_trigger_students_groups
    BEFORE INSERT ON GROUPS
    FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        SELECT NVL(MAX(ID), 0) + 1 INTO :NEW.ID FROM GROUPS;
    END IF;
END;

