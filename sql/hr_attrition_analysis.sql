-- ============================================================
-- HR EMPLOYEE ATTRITION ANALYSIS
-- SQL WORK FROM THE ORIGINAL PROJECT
-- MySQL 8+
-- Table: attrition
--
-- NOTE:
-- The original SQL file was lost. This file reconstructs the SQL
-- analysis/tasks we previously worked through for this project,
-- using the original IBM HR dataset schema and the documented
-- Day 1 / Day 2 SQL practice topics.
-- It is a reconstruction of the work, not a byte-for-byte recovery
-- of the deleted file.
-- ============================================================


-- ============================================================
-- PART A — DATASET / TABLE SETUP & BASIC EDA
-- ============================================================

-- Q1. Preview the dataset
SELECT *
FROM attrition
LIMIT 10;


-- Q2. Total number of employees
SELECT COUNT(*) AS total_employees
FROM attrition;


-- Q3. Distinct attrition values
SELECT DISTINCT Attrition
FROM attrition;


-- Q4. Employee count by attrition
SELECT
    Attrition,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY Attrition;


-- Q5. Distinct departments
SELECT DISTINCT Department
FROM attrition
ORDER BY Department;


-- Q6. Distinct job roles
SELECT DISTINCT JobRole
FROM attrition
ORDER BY JobRole;


-- Q7. Distinct overtime values
SELECT DISTINCT OverTime
FROM attrition;


-- Q8. Distinct business travel categories
SELECT DISTINCT BusinessTravel
FROM attrition;


-- Q9. Check duplicate EmployeeNumber values
SELECT
    EmployeeNumber,
    COUNT(*) AS record_count
FROM attrition
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;


-- Q10. Check important NULL values
SELECT
    SUM(Age IS NULL) AS null_age,
    SUM(Attrition IS NULL) AS null_attrition,
    SUM(Department IS NULL) AS null_department,
    SUM(JobRole IS NULL) AS null_job_role,
    SUM(MonthlyIncome IS NULL) AS null_monthly_income,
    SUM(OverTime IS NULL) AS null_overtime
FROM attrition;


-- Q11. Basic numeric statistics
SELECT
    MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    ROUND(AVG(Age), 2) AS avg_age,
    MIN(MonthlyIncome) AS min_income,
    MAX(MonthlyIncome) AS max_income,
    ROUND(AVG(MonthlyIncome), 2) AS avg_income
FROM attrition;


-- ============================================================
-- PART B — SELECT / WHERE / DISTINCT / ORDER BY / LIMIT
-- ============================================================

-- Q12. Employees aged above 40
SELECT *
FROM attrition
WHERE Age > 40;


-- Q13. Employees with attrition
SELECT *
FROM attrition
WHERE Attrition = 'Yes';


-- Q14. Employees without attrition
SELECT *
FROM attrition
WHERE Attrition = 'No';


-- Q15. Employees in Sales department
SELECT *
FROM attrition
WHERE Department = 'Sales';


-- Q16. Employees with monthly income above 10000
SELECT
    EmployeeNumber,
    JobRole,
    MonthlyIncome
FROM attrition
WHERE MonthlyIncome > 10000
ORDER BY MonthlyIncome DESC;


-- Q17. Employees aged between 25 and 35
SELECT
    EmployeeNumber,
    Age,
    JobRole,
    Department
FROM attrition
WHERE Age BETWEEN 25 AND 35;


-- Q18. Employees in selected departments
SELECT
    EmployeeNumber,
    Department,
    JobRole
FROM attrition
WHERE Department IN ('Sales', 'Human Resources');


-- Q19. Employees whose job role contains "Sales"
SELECT
    EmployeeNumber,
    JobRole,
    Department
FROM attrition
WHERE JobRole LIKE '%Sales%';


-- Q20. Top 10 employees by monthly income
SELECT
    EmployeeNumber,
    JobRole,
    MonthlyIncome
FROM attrition
ORDER BY MonthlyIncome DESC
LIMIT 10;


-- ============================================================
-- PART C — AGGREGATION / GROUP BY / HAVING
-- ============================================================

-- Q21. Employee count by department
SELECT
    Department,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY Department
ORDER BY employee_count DESC;


-- Q22. Average salary by department
SELECT
    Department,
    ROUND(AVG(MonthlyIncome), 2) AS avg_salary
FROM attrition
GROUP BY Department;


-- Q23. Maximum salary by department
SELECT
    Department,
    MAX(MonthlyIncome) AS max_salary
FROM attrition
GROUP BY Department;


-- Q24. Minimum salary by department
SELECT
    Department,
    MIN(MonthlyIncome) AS min_salary
FROM attrition
GROUP BY Department;


-- Q25. Average age by department
SELECT
    Department,
    ROUND(AVG(Age), 2) AS avg_age
FROM attrition
GROUP BY Department;


-- Q26. Employee count by job role
SELECT
    JobRole,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY JobRole
ORDER BY employee_count DESC;


-- Q27. Average salary by job role
SELECT
    JobRole,
    ROUND(AVG(MonthlyIncome), 2) AS avg_salary
FROM attrition
GROUP BY JobRole
ORDER BY avg_salary DESC;


-- Q28. Job roles with more than 100 employees
SELECT
    JobRole,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY JobRole
HAVING COUNT(*) > 100;


-- Q29. Average job satisfaction by department
SELECT
    Department,
    ROUND(AVG(JobSatisfaction), 2) AS avg_job_satisfaction
FROM attrition
GROUP BY Department;


-- ============================================================
-- PART D — CASE WHEN / BAND CREATION
-- ============================================================

-- Q30. Create age groups
SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS Age_Group,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY Age_Group;


-- Q31. Age groups with attrition rate
SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS Age_Group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100, 2
    ) AS attrition_rate
FROM attrition
GROUP BY Age_Group;


-- Q32. Create income bands
SELECT
    CASE
        WHEN MonthlyIncome < 3000 THEN '$0-$3000'
        WHEN MonthlyIncome < 5000 THEN '$3000-$5000'
        WHEN MonthlyIncome < 7000 THEN '$5000-$7000'
        WHEN MonthlyIncome < 10000 THEN '$7000-$10000'
        WHEN MonthlyIncome < 15000 THEN '$10000-$15000'
        ELSE '$15000+'
    END AS Income_Band,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY Income_Band;


-- Q33. Create tenure bands
SELECT
    CASE
        WHEN YearsAtCompany <= 1 THEN '0-1 Years'
        WHEN YearsAtCompany <= 5 THEN '2-5 Years'
        WHEN YearsAtCompany <= 10 THEN '6-10 Years'
        ELSE '11+ Years'
    END AS Tenure_Band,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY Tenure_Band;


-- Q34. Create promotion bands
SELECT
    CASE
        WHEN YearsSinceLastPromotion <= 1 THEN '0-1 Years'
        WHEN YearsSinceLastPromotion <= 4 THEN '2-4 Years'
        WHEN YearsSinceLastPromotion <= 7 THEN '5-7 Years'
        WHEN YearsSinceLastPromotion <= 10 THEN '8-10 Years'
        ELSE '10+ Years'
    END AS Promotion_Band,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY Promotion_Band;


-- ============================================================
-- PART E — CORE ATTRITION ANALYSIS
-- ============================================================

-- Q35. Number of employees who left
SELECT COUNT(*) AS employees_left
FROM attrition
WHERE Attrition = 'Yes';


-- Q36. Overall attrition rate
SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition;


-- Q37. Active employees
SELECT
    COUNT(*) AS active_employees
FROM attrition
WHERE Attrition = 'No';


-- Q38. Attrition count by department
SELECT
    Department,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count
FROM attrition
GROUP BY Department
ORDER BY attrition_count DESC;


-- Q39. Attrition rate by department
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY Department
ORDER BY attrition_rate DESC;


-- Q40. Attrition by job role
SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY JobRole
ORDER BY attrition_rate DESC;


-- Q41. Top 5 job roles by attrition rate
SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY JobRole
ORDER BY attrition_rate DESC
LIMIT 5;


-- Q42. Attrition by overtime
SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY OverTime
ORDER BY attrition_rate DESC;


-- Q43. Attrition by business travel
SELECT
    BusinessTravel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY BusinessTravel
ORDER BY attrition_rate DESC;


-- Q44. Attrition by gender
SELECT
    Gender,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY Gender
ORDER BY attrition_rate DESC;


-- Q45. Attrition by job level
SELECT
    JobLevel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY JobLevel
ORDER BY JobLevel;


-- ============================================================
-- PART F — SALARY / AGE / EXPERIENCE
-- ============================================================

-- Q46. Employees earning above overall average salary
SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM attrition
WHERE MonthlyIncome > (
    SELECT AVG(MonthlyIncome)
    FROM attrition
)
ORDER BY MonthlyIncome DESC;


-- Q47. Employees earning below overall average salary
SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM attrition
WHERE MonthlyIncome < (
    SELECT AVG(MonthlyIncome)
    FROM attrition
)
ORDER BY MonthlyIncome;


-- Q48. Employee(s) with maximum salary
SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM attrition
WHERE MonthlyIncome = (
    SELECT MAX(MonthlyIncome)
    FROM attrition
);


-- Q49. Employees older than average age
SELECT
    EmployeeNumber,
    Age,
    JobRole,
    Department
FROM attrition
WHERE Age > (
    SELECT AVG(Age)
    FROM attrition
)
ORDER BY Age DESC;


-- Q50. Attrition employees older than average age
SELECT
    EmployeeNumber,
    Age,
    JobRole,
    Department,
    Attrition
FROM attrition
WHERE Attrition = 'Yes'
  AND Age > (
      SELECT AVG(Age)
      FROM attrition
  )
ORDER BY Age DESC;


-- Q51. Salary statistics
SELECT
    ROUND(AVG(MonthlyIncome), 2) AS avg_income,
    MIN(MonthlyIncome) AS min_income,
    MAX(MonthlyIncome) AS max_income
FROM attrition;


-- Q52. Attrition by total working experience
SELECT
    TotalWorkingYears,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY TotalWorkingYears
ORDER BY TotalWorkingYears;


-- ============================================================
-- PART G — SUBQUERIES / CORRELATED SUBQUERIES
-- ============================================================

-- Q53. Employees earning above their department's average salary
SELECT
    a.EmployeeNumber,
    a.Department,
    a.JobRole,
    a.MonthlyIncome
FROM attrition a
WHERE a.MonthlyIncome > (
    SELECT AVG(b.MonthlyIncome)
    FROM attrition b
    WHERE b.Department = a.Department
)
ORDER BY a.Department, a.MonthlyIncome DESC;


-- Q54. Employees earning above department average with attrition
SELECT
    a.EmployeeNumber,
    a.Department,
    a.JobRole,
    a.MonthlyIncome
FROM attrition a
WHERE a.Attrition = 'Yes'
  AND a.MonthlyIncome > (
      SELECT AVG(b.MonthlyIncome)
      FROM attrition b
      WHERE b.Department = a.Department
  )
ORDER BY a.Department, a.MonthlyIncome DESC;


-- Q55. Employees older than their department average
SELECT
    a.EmployeeNumber,
    a.Department,
    a.Age,
    a.JobRole
FROM attrition a
WHERE a.Age > (
    SELECT AVG(b.Age)
    FROM attrition b
    WHERE b.Department = a.Department
)
ORDER BY a.Department, a.Age DESC;


-- Q56. Highest-paid employee in each department
SELECT
    a.EmployeeNumber,
    a.Department,
    a.JobRole,
    a.MonthlyIncome
FROM attrition a
WHERE a.MonthlyIncome = (
    SELECT MAX(b.MonthlyIncome)
    FROM attrition b
    WHERE b.Department = a.Department
)
ORDER BY a.Department;


-- ============================================================
-- PART H — CTEs
-- ============================================================

-- Q57. Department salary CTE
WITH department_salary AS (
    SELECT
        Department,
        AVG(MonthlyIncome) AS avg_salary
    FROM attrition
    GROUP BY Department
)
SELECT
    Department,
    ROUND(avg_salary, 2) AS avg_salary
FROM department_salary
ORDER BY avg_salary DESC;


-- Q58. Employees above department average using CTE
WITH department_salary AS (
    SELECT
        Department,
        AVG(MonthlyIncome) AS avg_salary
    FROM attrition
    GROUP BY Department
)
SELECT
    a.EmployeeNumber,
    a.Department,
    a.JobRole,
    a.MonthlyIncome,
    ROUND(ds.avg_salary, 2) AS department_avg_salary
FROM attrition a
JOIN department_salary ds
    ON a.Department = ds.Department
WHERE a.MonthlyIncome > ds.avg_salary
ORDER BY a.Department, a.MonthlyIncome DESC;


-- Q59. Department attrition CTE
WITH department_attrition AS (
    SELECT
        Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            AS attrition_count
    FROM attrition
    GROUP BY Department
)
SELECT
    Department,
    total_employees,
    attrition_count,
    ROUND(attrition_count / total_employees * 100, 2)
        AS attrition_rate
FROM department_attrition
ORDER BY attrition_rate DESC;


-- Q60. Job-role attrition CTE
WITH role_attrition AS (
    SELECT
        JobRole,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            AS attrition_count
    FROM attrition
    GROUP BY JobRole
)
SELECT
    JobRole,
    total_employees,
    attrition_count,
    ROUND(attrition_count / total_employees * 100, 2)
        AS attrition_rate
FROM role_attrition
ORDER BY attrition_rate DESC;


-- ============================================================
-- PART I — WINDOW FUNCTIONS
-- ============================================================

-- Q61. ROW_NUMBER by department and salary
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    ROW_NUMBER() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS salary_row_number
FROM attrition;


-- Q62. RANK employees by salary within department
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    RANK() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS salary_rank
FROM attrition;


-- Q63. DENSE_RANK employees by salary within department
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    DENSE_RANK() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS salary_rank
FROM attrition;


-- Q64. Top 2 employees by salary in each department
WITH ranked_employees AS (
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome,
        DENSE_RANK() OVER (
            PARTITION BY Department
            ORDER BY MonthlyIncome DESC
        ) AS salary_rank
    FROM attrition
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 2
ORDER BY Department, salary_rank;


-- Q65. Department average salary using AVG OVER
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    ROUND(
        AVG(MonthlyIncome) OVER (PARTITION BY Department),
        2
    ) AS department_avg_salary
FROM attrition;


-- Q66. Employees above department average using AVG OVER
WITH employee_salary AS (
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome,
        AVG(MonthlyIncome) OVER (
            PARTITION BY Department
        ) AS department_avg_salary
    FROM attrition
)
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    ROUND(department_avg_salary, 2) AS department_avg_salary
FROM employee_salary
WHERE MonthlyIncome > department_avg_salary
ORDER BY Department, MonthlyIncome DESC;


-- Q67. LAG monthly income within department
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    LAG(MonthlyIncome) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
    ) AS previous_income
FROM attrition;


-- Q68. LEAD monthly income within department
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    LEAD(MonthlyIncome) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
    ) AS next_income
FROM attrition;


-- ============================================================
-- PART J — TOP-N / RANKING ANALYSIS
-- ============================================================

-- Q69. Top 5 highest-paid employees
SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM attrition
ORDER BY MonthlyIncome DESC
LIMIT 5;


-- Q70. Top 5 job roles by employee count
SELECT
    JobRole,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY JobRole
ORDER BY employee_count DESC
LIMIT 5;


-- Q71. Top 5 departments by employee count
SELECT
    Department,
    COUNT(*) AS employee_count
FROM attrition
GROUP BY Department
ORDER BY employee_count DESC
LIMIT 5;


-- Q72. Rank departments by attrition rate
WITH department_attrition AS (
    SELECT
        Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            AS attrition_count
    FROM attrition
    GROUP BY Department
)
SELECT
    Department,
    total_employees,
    attrition_count,
    ROUND(attrition_count / total_employees * 100, 2)
        AS attrition_rate,
    DENSE_RANK() OVER (
        ORDER BY attrition_count / total_employees DESC
    ) AS attrition_rank
FROM department_attrition
ORDER BY attrition_rank;


-- Q73. Rank job roles by attrition rate
WITH role_attrition AS (
    SELECT
        JobRole,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            AS attrition_count
    FROM attrition
    GROUP BY JobRole
)
SELECT
    JobRole,
    total_employees,
    attrition_count,
    ROUND(attrition_count / total_employees * 100, 2)
        AS attrition_rate,
    DENSE_RANK() OVER (
        ORDER BY attrition_count / total_employees DESC
    ) AS attrition_rank
FROM role_attrition
ORDER BY attrition_rank;


-- ============================================================
-- PART K — PROJECT-SPECIFIC ATTRITION KPIs
-- ============================================================

-- Q74. Main dashboard KPI query
SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate,
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END)
        AS active_employees,
    ROUND(AVG(MonthlyIncome), 2) AS avg_income,
    ROUND(AVG(JobSatisfaction), 2) AS avg_job_satisfaction
FROM attrition;


-- Q75. Overtime attrition KPI
SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY OverTime;


-- Q76. Attrition KPI for employees with overtime
SELECT
    COUNT(*) AS overtime_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS overtime_attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS overtime_attrition_rate
FROM attrition
WHERE OverTime = 'Yes';


-- Q77. Attrition KPI for employees without overtime
SELECT
    COUNT(*) AS non_overtime_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS non_overtime_attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS non_overtime_attrition_rate
FROM attrition
WHERE OverTime = 'No';


-- Q78. Department attrition KPI
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY Department
ORDER BY attrition_rate DESC;


-- Q79. Job role attrition KPI with satisfaction
SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate,
    ROUND(AVG(JobSatisfaction), 2) AS avg_job_satisfaction
FROM attrition
GROUP BY JobRole
HAVING AVG(JobSatisfaction) >= 2
ORDER BY attrition_rate DESC;


-- Q80. Attrition by department and overtime
SELECT
    Department,
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY Department, OverTime
ORDER BY Department, attrition_rate DESC;


-- ============================================================
-- PART L — CAREER PROGRESSION / PROMOTION ANALYSIS
-- ============================================================

-- Q81. Attrition by YearsInCurrentRole
SELECT
    YearsInCurrentRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY YearsInCurrentRole
ORDER BY YearsInCurrentRole;


-- Q82. Attrition by YearsSinceLastPromotion
SELECT
    YearsSinceLastPromotion,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;


-- Q83. Attrition by promotion band
SELECT
    CASE
        WHEN YearsSinceLastPromotion <= 1 THEN '0-1 Years'
        WHEN YearsSinceLastPromotion <= 4 THEN '2-4 Years'
        WHEN YearsSinceLastPromotion <= 7 THEN '5-7 Years'
        WHEN YearsSinceLastPromotion <= 10 THEN '8-10 Years'
        ELSE '10+ Years'
    END AS Promotion_Band,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY Promotion_Band
ORDER BY
    CASE Promotion_Band
        WHEN '0-1 Years' THEN 1
        WHEN '2-4 Years' THEN 2
        WHEN '5-7 Years' THEN 3
        WHEN '8-10 Years' THEN 4
        WHEN '10+ Years' THEN 5
    END;


-- Q84. Career progression by JobLevel and tenure band
SELECT
    JobLevel,
    CASE
        WHEN YearsAtCompany <= 1 THEN '0-1 Years'
        WHEN YearsAtCompany <= 3 THEN '2-3 Years'
        WHEN YearsAtCompany <= 5 THEN '4-5 Years'
        ELSE '6+ Years'
    END AS Tenure_Band,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY
    JobLevel,
    Tenure_Band
ORDER BY
    JobLevel,
    CASE Tenure_Band
        WHEN '0-1 Years' THEN 1
        WHEN '2-3 Years' THEN 2
        WHEN '4-5 Years' THEN 3
        WHEN '6+ Years' THEN 4
    END;


-- ============================================================
-- PART M — FINAL BUSINESS QUESTIONS
-- ============================================================

-- Q85. Highest attrition age group
SELECT
    Age_Group,
    attrition_rate
FROM (
    SELECT
        CASE
            WHEN Age < 25 THEN 'Under 25'
            WHEN Age BETWEEN 25 AND 34 THEN '25-34'
            WHEN Age BETWEEN 35 AND 44 THEN '35-44'
            WHEN Age BETWEEN 45 AND 54 THEN '45-54'
            ELSE '55+'
        END AS Age_Group,
        ROUND(
            SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            / COUNT(*) * 100,
            2
        ) AS attrition_rate
    FROM attrition
    GROUP BY Age_Group
) x
ORDER BY attrition_rate DESC
LIMIT 1;


-- Q86. Highest attrition job role
SELECT
    JobRole,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY JobRole
ORDER BY attrition_rate DESC
LIMIT 1;


-- Q87. Highest attrition department
SELECT
    Department,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY Department
ORDER BY attrition_rate DESC
LIMIT 1;


-- Q88. Early-tenure attrition
SELECT
    CASE
        WHEN YearsAtCompany <= 1 THEN '0-1 Years'
        WHEN YearsAtCompany <= 5 THEN '2-5 Years'
        WHEN YearsAtCompany <= 10 THEN '6-10 Years'
        ELSE '11+ Years'
    END AS Tenure_Band,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
GROUP BY Tenure_Band
ORDER BY attrition_rate DESC;


-- Q89. High-risk combination: overtime + early tenure
SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition
WHERE OverTime = 'Yes'
  AND YearsAtCompany <= 1;


-- Q90. Final project KPI query
SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left,
    COUNT(*) - SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        AS active_employees,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate,
    ROUND(AVG(Age), 2) AS avg_age,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
    ROUND(AVG(YearsAtCompany), 2) AS avg_tenure,
    ROUND(AVG(JobSatisfaction), 2) AS avg_job_satisfaction
FROM attrition;


-- ============================================================
-- SQL → POWER BI / DAX REFERENCE
-- ============================================================
--
-- SQL:
-- COUNT(*) / COUNT(EmpID)
-- DAX:
-- Total Employees = COUNTROWS('attrition')
--
-- SQL:
-- WHERE Attrition = 'Yes'
-- DAX:
-- Employees Left =
-- CALCULATE(
--     COUNTROWS('attrition'),
--     'attrition'[Attrition] = "Yes"
-- )
--
-- SQL:
-- Attrition rate =
-- SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
-- / COUNT(*) * 100
--
-- DAX:
-- Attrition Rate =
-- DIVIDE(
--     [Employees Left],
--     [Total Employees],
--     0
-- )
--
-- SQL:
-- GROUP BY Department
-- DAX:
-- Put Department on the visual axis/category and the measure
-- evaluates in the department filter context.
--
-- ============================================================
-- END OF SQL WORK
-- ============================================================
