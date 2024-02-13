create or replace NONEDITIONABLE PROCEDURE restore_students_info(
    p_restore_date TIMESTAMP,
    p_offset INTERVAL DAY TO SECOND DEFAULT NULL
)
AS
BEGIN
    EXECUTE IMMEDIATE 'ALTER TRIGGER UNIQUE_ID_TRIGGER DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER STUDENTS_AUDIT_TRIGGER DISABLE';

    IF p_offset IS NULL THEN
        DELETE FROM STUDENTS
        WHERE ID IN (
            SELECT student_id
            FROM students_audit_table
            WHERE action_date >= p_restore_date
        );

        INSERT INTO STUDENTS (ID, NAME, GROUP_ID)
        SELECT student_id, student_name, group_id
        FROM students_audit_table
        WHERE action_type = 'DELETE'
          AND action_date >= p_restore_date;

        MERGE INTO STUDENTS s
        USING (
            SELECT DISTINCT student_id, old_student_name, old_group_id
            FROM students_audit_table
            WHERE action_type = 'UPDATE'
              AND action_date >= p_restore_date
        ) u
        ON (s.ID = u.student_id)
        WHEN MATCHED THEN UPDATE SET
                                     s.NAME = u.old_student_name,
                                     s.GROUP_ID = u.old_group_id;
    ELSE
        DELETE FROM STUDENTS
        WHERE ID IN (
            SELECT student_id
            FROM students_audit_table
            WHERE action_date BETWEEN p_restore_date AND p_restore_date + p_offset
        );

        INSERT INTO STUDENTS (ID, NAME, GROUP_ID)
        SELECT student_id, student_name, group_id
        FROM students_audit_table
        WHERE action_type = 'DELETE'
          AND action_date BETWEEN p_restore_date AND p_restore_date + p_offset;

        MERGE INTO STUDENTS s
        USING (
            SELECT student_id, old_student_name, old_group_id
            FROM students_audit_table
            WHERE action_type = 'UPDATE'
              AND action_date BETWEEN p_restore_date AND p_restore_date + p_offset
        ) u
        ON (s.ID = u.student_id)
        WHEN MATCHED THEN UPDATE SET
                                     s.NAME = u.old_student_name,
                                     s.GROUP_ID = u.old_group_id;
    END IF;
    EXECUTE IMMEDIATE 'ALTER TRIGGER UNIQUE_ID_TRIGGER ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER STUDENTS_AUDIT_TRIGGER ENABLE';
END restore_students_info;