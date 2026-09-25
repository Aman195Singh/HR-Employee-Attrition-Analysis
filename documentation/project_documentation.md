# HR Employee Attrition Analysis

## 1. Project Overview

The **HR Employee Attrition Analysis** project is an end-to-end data analytics and business intelligence project built to understand employee attrition and identify workforce segments associated with higher observed employee turnover.

The project uses the IBM HR Employee Attrition dataset and combines:

- Data preparation and transformation
- SQL-based exploratory data analysis
- Power BI data modeling
- DAX measures and calculated columns
- Interactive dashboard development
- Business-focused insight generation

The central business question is:

> **Which employee, job, compensation, tenure, and work-condition factors are associated with higher observed attrition?**

The analysis is designed to help HR and management identify areas that may require deeper investigation, rather than treating correlation as proof of causation.

---

## 2. Business Problem

Employee turnover can create recruitment costs, productivity disruption, knowledge loss, and additional workload for existing employees.

An HR team needs to understand:

- How many employees are leaving?
- What is the overall observed attrition rate?
- Which departments have higher attrition?
- Which job roles show higher attrition?
- Is overtime associated with higher attrition?
- Does attrition vary by age?
- Does attrition vary by income?
- Does tenure appear related to attrition?
- Does time since the last promotion show different attrition patterns?
- Which employee segments should HR investigate further?

The project converts employee-level data into an interactive analytical view so that these questions can be explored using consistent KPIs and filters.

---

## 3. Project Objectives

### Primary Objectives

1. Calculate the overall employee attrition rate.
2. Quantify the number of employees who left and remained.
3. Analyze attrition across departments and job roles.
4. Analyze attrition by overtime status.
5. Analyze attrition across age groups.
6. Analyze attrition across income bands.
7. Analyze attrition across tenure bands.
8. Analyze promotion timing and career progression patterns.
9. Identify job roles and employee segments with comparatively higher observed attrition.
10. Build an interactive Power BI dashboard for HR analysis.
11. Create reusable DAX measures and calculated columns.
12. Organize the complete analytical workflow for portfolio and interview presentation.

---

## 4. Dataset

### Dataset Used

The project uses the **IBM HR Employee Attrition** dataset.

The dataset contains employee-level information covering demographics, compensation, job characteristics, satisfaction, work conditions, career progression, and attrition status.

### Dataset Size

- **Rows:** 1,470 employees
- **Columns:** 36

### Key Fields

| Category | Important Columns |
|---|---|
| Employee | EmployeeNumber, EmployeeCount, EmployeeID |
| Demographics | Age, Gender, MaritalStatus, Education |
| Job | Department, JobRole, JobLevel, BusinessTravel |
| Compensation | MonthlyIncome, DailyRate, HourlyRate, MonthlyRate |
| Work Conditions | OverTime, DistanceFromHome, StandardHours |
| Satisfaction | JobSatisfaction, EnvironmentSatisfaction, RelationshipSatisfaction |
| Career | YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, YearsWithCurrManager, TotalWorkingYears |
| Attrition | Attrition |

### Primary Target Variable

`Attrition`

Values:

- `Yes` — employee left
- `No` — employee remained

---

## 5. Data Preparation

Data preparation was performed before the final Power BI analysis to make the dataset suitable for reporting and segmentation.

### Preparation Activities

- Reviewed the dataset structure and column meanings.
- Checked employee-level records.
- Identified the `Attrition` field as the primary business outcome.
- Reviewed categorical and numerical fields.
- Prepared analytical bands for easier dashboard interpretation.
- Created sorting columns for categorical bands.
- Prepared fields required for Power BI visuals.
- Verified that calculated fields produced logical ordering in charts and slicers.

### Analytical Banding

The project uses business-friendly groups such as:

#### Age Group

- Under 25
- 25–34
- 35–44
- 45–54
- 55+

#### Tenure Band

- 0–1 Years
- 2–5 Years
- 6–10 Years
- 11+ Years

#### Promotion Band

- 0–1 Years
- 2–4 Years
- 5–7 Years
- 8–10 Years
- 10+ Years

#### Income Band

- $0–$3K
- $3K–$5K
- $5K–$7K
- $7K–$10K
- $10K–$15K
- $15K+

Sort columns were created to maintain logical order instead of alphabetical order.

---

## 6. SQL Analysis

SQL was used as the analytical foundation before dashboard development.

The SQL work covered both technical SQL skills and project-specific business analysis.

### SQL Areas Covered

- `SELECT`
- `WHERE`
- `DISTINCT`
- `ORDER BY`
- `LIMIT`
- `COUNT`
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `GROUP BY`
- `HAVING`
- `CASE WHEN`
- Conditional aggregation
- `INNER JOIN`
- Subqueries
- Correlated subqueries
- Common Table Expressions (CTEs)
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- Window functions
- `AVG() OVER(PARTITION BY...)`
- `LAG()`
- `LEAD()`
- Top-N analysis

### Project-Specific SQL Analysis

The analysis includes queries for:

- Total employees
- Attrition count
- Attrition rate
- Department-level attrition
- Job-role attrition
- Overtime attrition
- Salary analysis
- Average income
- Age analysis
- Tenure analysis
- Promotion analysis
- Job satisfaction
- Employees earning above department average
- Top employees by department
- Ranking employees within departments
- Attrition KPIs
- Segment-level comparisons

### Example: Attrition Count

```sql
SELECT COUNT(*)
FROM attrition
WHERE Attrition = 'Yes';
```

### Example: Attrition Rate

```sql
SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition;
```

The SQL analysis was used to validate the analytical logic before implementing the interactive Power BI layer.

---

## 7. Power BI Development

Power BI was used to transform the prepared employee data into an interactive HR analytics dashboard.

### Power BI Workflow

```text
Raw HR Dataset
      ↓
Data Preparation
      ↓
Power Query Transformation
      ↓
Data Model
      ↓
DAX Measures & Columns
      ↓
Visualizations
      ↓
Interactive Dashboard
      ↓
Business Insights
```

### Dashboard Design Principles

The dashboard was designed around:

- KPI-driven analysis
- Clear visual hierarchy
- Consistent IBM-inspired blue theme
- Interactive slicers
- Logical page navigation
- Business-focused visualizations
- Minimal visual clutter
- Consistent band ordering
- Executive-friendly presentation

### Navigation

Page navigation was designed so users can move between major analytical pages from the dashboard using navigation buttons/icons.

---

## 8. DAX Measures

DAX was used to create reusable measures and calculated columns.

### Core Measures

```DAX
Total Employee =
COUNTROWS('hr_ibm attrition')
```

```DAX
Total Active Employee =
CALCULATE(
    COUNTROWS('hr_ibm attrition'),
    'hr_ibm attrition'[Attrition] = "No"
)
```

```DAX
Attrition Count =
CALCULATE(
    COUNTROWS('hr_ibm attrition'),
    'hr_ibm attrition'[Attrition] = "Yes"
)
```

```DAX
Attrition Rate =
DIVIDE(
    [Attrition Count],
    [Total Employee],
    0
)
```

### Average Income

```DAX
Avg Income =
AVERAGE('hr_ibm attrition'[MonthlyIncome])
```

### Average Tenure

```DAX
Avg Tenure =
AVERAGE('hr_ibm attrition'[YearsAtCompany])
```

### Job Satisfaction

```DAX
Job Satisfaction =
AVERAGE('hr_ibm attrition'[JobSatisfaction])
```

### Highest Attrition Job Role

```DAX
Highest Attrition Job Role =
VAR RoleTable =
    ADDCOLUMNS(
        VALUES('hr_ibm attrition'[JobRole]),
        "@AttritionRate", [Attrition Rate]
    )
VAR TopRole =
    TOPN(
        1,
        RoleTable,
        [@AttritionRate],
        DESC
    )
RETURN
    CONCATENATEX(
        TopRole,
        'hr_ibm attrition'[JobRole],
        ", "
    )
```

### Example: Promotion Band

```DAX
Promotion Band =
SWITCH(
    TRUE(),
    'hr_ibm attrition'[YearsSinceLastPromotion] <= 1, "0-1 Years",
    'hr_ibm attrition'[YearsSinceLastPromotion] <= 4, "2-4 Years",
    'hr_ibm attrition'[YearsSinceLastPromotion] <= 7, "5-7 Years",
    'hr_ibm attrition'[YearsSinceLastPromotion] <= 10, "8-10 Years",
    "10+ Years"
)
```

### Promotion Band Sort

```DAX
Promotion Band Sort =
SWITCH(
    'hr_ibm attrition'[Promotion Band],
    "0-1 Years", 1,
    "2-4 Years", 2,
    "5-7 Years", 3,
    "8-10 Years", 4,
    "10+ Years", 5
)
```

Additional DAX documentation is available in:

`dax/dax_measures_and_columns.md`

---

## 9. Dashboard Pages

The Power BI report is structured as a multi-page analytical story.

### Page 1 — Executive Overview

**Objective:** Provide a high-level view of workforce size and overall attrition.

Key elements include:

- Total Employees
- Attrition Count
- Attrition Rate
- Active Employees
- Overall attrition trends/patterns
- Overtime comparison
- Age-group analysis
- Income-band analysis
- Tenure analysis
- Job-role analysis
- Department analysis
- Key Insights text box

### Page 2 — Attrition Analysis

**Objective:** Investigate where and among which employee groups attrition is concentrated.

Analysis areas include:

- Department
- Job Role
- Overtime
- Age
- Income
- Tenure
- Other employee characteristics

The page moves from the overall KPI view toward segment-level investigation.

### Page 3 — Career Progression

**Objective:** Analyze whether career progression characteristics show different observed attrition patterns.

Key analytical fields include:

- Years at Company
- Years in Current Role
- Years Since Last Promotion
- Years With Current Manager
- Total Working Years
- Promotion Band
- Tenure Band

This page helps investigate whether career progression and internal mobility patterns warrant further HR investigation.

---

## 10. Key Insights

The current dashboard analysis identifies the following observed patterns.

### Overall Attrition

**16.1% overall attrition rate**, representing **237 employees who left**.

### Overtime

Observed attrition is higher among employees working overtime:

**30.5% vs 10.4%**

for overtime and non-overtime employees respectively.

### Early Tenure

Employees in the **0–1 year tenure band** show the highest observed attrition rate among the displayed tenure groups.

### Age

Employees **under 25** show the highest observed attrition rate among the displayed age groups.

### Income

The **lowest income band** shows substantially higher observed attrition than the highest income band.

### Job Role

**Sales Representatives** show the highest observed job-role attrition rate in the Page 1 analysis:

**39.8%**

### Department

**Sales** shows the highest department-level attrition rate among the three departments analyzed:

**20.6%**

> These are descriptive observations from the dataset. They should not be interpreted as proof that any individual factor directly causes employee attrition.

---

## 11. Business Questions

The project is designed to answer the following business questions:

### Workforce Overview

1. How large is the employee population?
2. How many employees have left?
3. What is the overall observed attrition rate?
4. How many employees remain active?

### Department & Role

5. Which department has the highest observed attrition rate?
6. Which job roles show higher observed attrition?
7. Are specific roles concentrated in higher-attrition departments?

### Work Conditions

8. Is observed attrition different between overtime and non-overtime employees?
9. Does business travel show different attrition patterns?
10. Does distance from home vary across attrition groups?

### Demographics

11. Does attrition vary by age group?
12. Does attrition vary by gender?
13. Does marital status show different attrition patterns?

### Compensation

14. Does observed attrition vary by income band?
15. How does average income compare across employee groups?

### Tenure & Career Progression

16. Does attrition vary by years at company?
17. Does attrition vary by years in current role?
18. Does attrition vary by time since last promotion?
19. Does attrition vary by years with current manager?
20. Which career-progression segments should HR investigate further?

### Satisfaction

21. How does job satisfaction vary across attrition groups?
22. Do employee satisfaction measures show different patterns among employees who left?

---

## 12. Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **Python** | Data exploration / supporting analysis where required |
| **SQL / MySQL** | EDA, aggregation, segmentation and business analysis |
| **Power BI** | Dashboard development and interactive reporting |
| **Power Query** | Data transformation and preparation |
| **DAX** | Measures, calculated columns and analytical logic |
| **GitHub** | Version control and project portfolio |
| **Markdown** | Project documentation |

---

## 13. Project Workflow

The complete project workflow is:

```text
                    HR Employee Dataset
                            │
                            ▼
                  Data Understanding
                            │
                            ▼
                  Data Preparation
                            │
                            ▼
                  SQL-Based EDA
                            │
             ┌──────────────┴──────────────┐
             ▼                             ▼
       Business Queries             KPI Validation
             │                             │
             └──────────────┬──────────────┘
                            ▼
                    Power Query
                            │
                            ▼
                     Data Model
                            │
                            ▼
                       DAX Layer
                            │
                            ▼
                 Power BI Visualizations
                            │
                            ▼
                  Dashboard Navigation
                            │
                            ▼
                   Business Insights
                            │
                            ▼
                  GitHub Documentation
```

### Development Approach

1. Understand the dataset.
2. Identify the business outcome.
3. Perform SQL-based EDA.
4. Validate important KPIs.
5. Transform and prepare data.
6. Build DAX measures.
7. Create analytical bands.
8. Design dashboard pages.
9. Add navigation.
10. Validate insights.
11. Document the project.
12. Publish the project to GitHub.

---

## 14. Limitations

### Dataset Limitations

The dataset represents a fixed employee population and does not provide a live HR environment.

### Causality

The analysis identifies **associations and observed differences**, not causal relationships.

For example, a higher attrition rate among overtime employees does not by itself prove that overtime causes employees to leave.

### Historical Data

The dataset represents a historical snapshot rather than continuously updated workforce data.

### External Factors

The dataset does not capture every factor that can influence employee attrition, such as:

- External job opportunities
- Economic conditions
- Managerial changes over time
- Organizational restructuring
- Employee career goals
- Personal circumstances
- Market salary benchmarks

### Generalization

The findings should not automatically be generalized to every organization because workforce characteristics and HR policies differ between companies.

---

## 15. Future Improvements

The project can be extended in several directions.

### Predictive Attrition Modeling

Build a machine-learning model to estimate employee attrition probability using appropriate validation techniques.

Potential models:

- Logistic Regression
- Random Forest
- XGBoost

### Explainable AI

Use explainability techniques such as SHAP to identify the variables contributing most to model predictions.

### Automated Data Refresh

Connect Power BI to a regularly updated HR database or data warehouse.

### Advanced HR Analytics

Add:

- Employee retention analysis
- Workforce segmentation
- Promotion velocity
- Compensation benchmarking
- Department-level workforce planning
- Employee satisfaction analysis
- Manager-level analysis where appropriate

### What-If Analysis

Create Power BI parameters to simulate potential HR scenarios such as:

- Overtime reduction
- Compensation changes
- Promotion timing
- Workforce retention scenarios

### Time-Series Analysis

With a dated HR dataset, add:

- Monthly attrition trends
- Quarterly attrition
- Hiring vs attrition
- Workforce growth
- Retention trends

---

# Project Summary

This project demonstrates an end-to-end analytics workflow:

```text
Data
  ↓
SQL
  ↓
Data Preparation
  ↓
DAX
  ↓
Power BI
  ↓
Business Insights
  ↓
Documentation
```

The final dashboard transforms employee-level HR data into an interactive analytical tool focused on **attrition, workforce segmentation, compensation, work conditions, tenure, and career progression**.

The project is intended to demonstrate practical skills in:

- SQL
- Data Analysis
- Data Cleaning
- Power BI
- Power Query
- DAX
- Data Visualization
- Business Intelligence
- Business Problem Solving
- Analytical Storytelling
