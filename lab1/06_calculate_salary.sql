CREATE OR REPLACE FUNCTION CalculateTotalSalary(p_monthly_salary NUMBER, p_annual_bonus_percent NUMBER) RETURN NUMBER IS
  v_annual_bonus_factor NUMBER;
BEGIN
  IF p_annual_bonus_percent IS NULL OR p_annual_bonus_percent < 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Invalid bonus percent');
  END IF;

  v_annual_bonus_factor := 1 + p_annual_bonus_percent / 100;
  RETURN (v_annual_bonus_factor * 12 * p_monthly_salary);
END CalculateTotalSalary;
