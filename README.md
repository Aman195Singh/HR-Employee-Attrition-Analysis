# HR Employee Attrition Analysis

An end-to-end **HR Data Analytics & Business Intelligence project** using SQL, Power BI, Power Query, and DAX to analyze employee attrition and identify workforce segments with higher observed attrition.

---

## 📊 Project Overview

Employee attrition is an important HR challenge because employee turnover can result in recruitment costs, productivity disruption, knowledge loss, and additional workload for existing employees.

This project analyzes employee-level HR data to understand:

- Overall employee attrition
- Department-level attrition
- Job-role attrition
- Overtime and attrition
- Age-group patterns
- Income-level patterns
- Tenure patterns
- Career progression
- Promotion timing
- Employee satisfaction

The project follows an end-to-end analytics workflow:

```text
HR Dataset
    ↓
Data Preparation
    ↓
SQL EDA & Business Analysis
    ↓
Power Query Transformation
    ↓
Power BI Data Model
    ↓
DAX Measures & Calculated Columns
    ↓
Interactive Dashboard
    ↓
Business Insights
````

---

# 🎯 Business Problem

The HR team needs to understand which employee segments show higher observed attrition so that these areas can be investigated further.

The analysis focuses on questions such as:

- What is the overall attrition rate?
- Which departments have higher attrition?
- Which job roles show higher attrition?
- Is attrition different for employees working overtime?
- Does attrition vary by age?
- Does income level relate to different observed attrition rates?
- Does tenure show different attrition patterns?
- Does time since the last promotion show different patterns?
- Which employee segments require deeper HR investigation?

> The analysis identifies observed associations in the dataset. It does not establish that any individual factor directly causes employee attrition.

---

# 📌 Project Objectives

1. Calculate overall employee attrition.
2. Calculate the attrition rate.
3. Analyze active vs departed employees.
4. Compare attrition across departments.
5. Compare attrition across job roles.
6. Analyze overtime and attrition.
7. Analyze age-group attrition.
8. Analyze income-band attrition.
9. Analyze tenure-band attrition.
10. Analyze career progression and promotion patterns.
11. Create interactive Power BI dashboards.
12. Build reusable DAX measures and calculated columns.
13. Convert analytical findings into business-focused insights.

---

# 📂 Dataset

### Dataset

**IBM HR Employee Attrition Dataset**

### Size

- **1,470 employees**
- **36 columns**

### Important Variables

| CategoryColumns |                                                                                                      |
| --------------- | ---------------------------------------------------------------------------------------------------- |
| Employee        | EmployeeNumber, EmployeeCount, EmployeeID                                                            |
| Demographics    | Age, Gender, MaritalStatus, Education                                                                |
| Job             | Department, JobRole, JobLevel                                                                        |
| Compensation    | MonthlyIncome, DailyRate, HourlyRate, MonthlyRate                                                    |
| Work Conditions | OverTime, BusinessTravel, DistanceFromHome                                                           |
| Satisfaction    | JobSatisfaction, EnvironmentSatisfaction, RelationshipSatisfaction                                   |
| Career          | YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, YearsWithCurrManager, TotalWorkingYears |
| Outcome         | Attrition                                                                                            |

### Target Variable

`Attrition`

```text
Yes = Employee left
No  = Employee remained
```

---

# 🧹 Data Preparation

The dataset was prepared before dashboard development.

### Preparation activities

- Reviewed dataset structure
- Checked column meanings
- Identified the primary business outcome
- Reviewed numerical and categorical fields
- Prepared analytical categories
- Created sorting columns
- Prepared fields for Power BI visualizations
- Validated category ordering

### Analytical Bands

#### Age Group

```text
Under 25
25-34
35-44
45-54
55+
```

#### Tenure Band

```text
0-1 Years
2-5 Years
6-10 Years
11+ Years
```

#### Promotion Band

```text
0-1 Years
2-4 Years
5-7 Years
8-10 Years
10+ Years
```

#### Income Band

```text
$0-$3K
$3K-$5K
$5K-$7K
$7K-$10K
$10K-$15K
$15K+
```

Sorting columns were created to ensure analytical categories appear in logical business order.

---

# 🗄️ SQL Analysis

SQL was used for exploratory data analysis, KPI validation, segmentation, and business analysis.

### SQL concepts used

- SELECT
- WHERE
- DISTINCT
- ORDER BY
- LIMIT
- COUNT
- SUM
- AVG
- MIN
- MAX
- GROUP BY
- HAVING
- CASE WHEN
- Conditional aggregation
- JOIN
- Subqueries
- Correlated subqueries
- CTEs
- ROW_NUMBER
- RANK
- DENSE_RANK
- Window functions
- LAG
- LEAD
- Top-N analysis

### Example — Attrition Count

```sql
SELECT COUNT(*)
FROM attrition
WHERE Attrition = 'Yes';
```

### Example — Attrition Rate

```sql
SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS attrition_rate
FROM attrition;
```

The complete SQL analysis is available in:

```text
sql/hr_attrition_analysis.sql
```

---

# 📊 Power BI Dashboard

Power BI was used to build the interactive analytical dashboard.

### Dashboard capabilities

- KPI cards
- Interactive slicers
- Department analysis
- Job-role analysis
- Overtime analysis
- Age analysis
- Income analysis
- Tenure analysis
- Career progression analysis
- Promotion analysis
- Interactive page navigation
- Business insights

---

# 📈 Dashboard Pages

## Page 1 — Executive Overview

Provides a high-level summary of the workforce and attrition situation.

### Key areas

- Total Employees
- Attrition Count
- Attrition Rate
- Active Employees
- Overtime
- Age
- Income
- Tenure
- Job Role
- Department
- Key Insights

---

## Page 2 — Attrition Analysis

Focuses on understanding where observed attrition is concentrated.

### Analysis areas

- Department
- Job Role
- Overtime
- Age
- Income
- Tenure
- Employee segments

---

## Page 3 — Career Progression

Focuses on career development and progression-related employee characteristics.

### Analysis areas

- Years at Company
- Years in Current Role
- Years Since Last Promotion
- Years With Current Manager
- Total Working Years
- Promotion Band
- Tenure Band

---

# 📷 Dashboard Preview

## Executive Overview

[Executive Overview](https://chatgpt.com/g/g-p-6a9c0a0ec14c8191b3793a6bd314d059/c/screenshots/page_1_executive_overview.png)

## Attrition Analysis

[Attrition Analysis](https://chatgpt.com/g/g-p-6a9c0a0ec14c8191b3793a6bd314d059/c/screenshots/page_2_attrition_analysis.png)

## Career Progression

[Career Progression](https://chatgpt.com/g/g-p-6a9c0a0ec14c8191b3793a6bd314d059/c/screenshots/page_3_career_progression.png)

> Screenshot filenames should match the actual files uploaded to the `screenshots/` folder.

---

# 🔢 Key KPIs

| KPIResult                    |                              |
| ---------------------------- | ---------------------------- |
| Total Employees              | 1,470                        |
| Employees Left               | 237                          |
| Overall Attrition Rate       | 16.1%                        |
| Overtime Attrition           | 30.5%                        |
| Non-Overtime Attrition       | 10.4%                        |
| Highest Job-Role Attrition   | Sales Representative — 39.8% |
| Highest Department Attrition | Sales — 20.6%                |

---

# 🔎 Key Insights

### 1. Overall Attrition

**16.1% overall attrition rate**, with **237 employees leaving**.

### 2. Overtime

Observed attrition is higher among employees working overtime:

**30.5% vs 10.4%**

### 3. Early Tenure

Employees in the **0–1 year tenure band** show the highest observed tenure-band attrition rate.

### 4. Age

Employees **under 25** show the highest observed attrition rate among the displayed age groups.

### 5. Income

The **lowest income band** shows substantially higher observed attrition than the highest income band.

### 6. Job Role

**Sales Representatives** show the highest observed job-role attrition rate:

**39.8%**

### 7. Department

**Sales** shows the highest department-level attrition rate:

**20.6%**

> These findings describe patterns observed in the dataset and should not be interpreted as proof of causation.

---

# 🧮 DAX

DAX was used to create reusable measures and calculated columns.

## Total Employees

```DAX
Total Employee =
COUNTROWS('hr_ibm attrition')
```

## Attrition Count

```DAX
Attrition Count =
CALCULATE(
    COUNTROWS('hr_ibm attrition'),
    'hr_ibm attrition'[Attrition] = "Yes"
)
```

## Attrition Rate

```DAX
Attrition Rate =
DIVIDE(
    [Attrition Count],
    [Total Employee],
    0
)
```

## Average Income

```DAX
Avg Income =
AVERAGE('hr_ibm attrition'[MonthlyIncome])
```

## Average Tenure

```DAX
Avg Tenure =
AVERAGE('hr_ibm attrition'[YearsAtCompany])
```

## Promotion Band

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

## Promotion Band Sort

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

Complete DAX documentation:

```text
dax/dax_measures_and_columns.md
```

---

# 💡 Business Questions

The dashboard addresses questions including:

### Workforce

- How many employees are in the organization?
- How many employees left?
- What is the overall attrition rate?

### Department & Job Role

- Which department has the highest observed attrition?
- Which job roles show higher attrition?
- Are particular roles concentrated in higher-attrition departments?

### Work Conditions

- Is observed attrition different for overtime employees?
- Does business travel show different attrition patterns?
- Does distance from home vary across attrition groups?

### Demographics

- Does attrition vary by age?
- Does attrition vary by gender?
- Does marital status show different patterns?

### Compensation

- Does observed attrition vary by income band?
- How does average income differ across employee groups?

### Career Progression

- Does attrition vary by tenure?
- Does attrition vary by years in current role?
- Does time since last promotion show different attrition patterns?
- Does time with the current manager show different patterns?

### Satisfaction

- How does job satisfaction vary across attrition groups?
- Are satisfaction levels different between employees who left and remained?

---

# 🛠️ Tools & Technologies

| TechnologyPurpose |                                 |
| ----------------- | ------------------------------- |
| **SQL / MySQL**   | EDA and business analysis       |
| **Power BI**      | Interactive dashboard           |
| **Power Query**   | Data transformation             |
| **DAX**           | Measures and calculated columns |
| **Python**        | Supporting data analysis        |
| **GitHub**        | Version control and portfolio   |
| **Markdown**      | Documentation                   |

---

# 🔄 Project Workflow

```text
IBM HR Dataset
      ↓
Data Understanding
      ↓
Data Preparation
      ↓
SQL EDA
      ↓
Business Analysis
      ↓
Power Query
      ↓
Power BI Data Model
      ↓
DAX
      ↓
Dashboard Development
      ↓
Business Insights
      ↓
Documentation
      ↓
GitHub
```

---

# 📁 Repository Structure

```text
HR-Employee-Attrition-Analysis/
│
├── README.md
│
├── data/
│   └── hr_attrition_cleaned.csv
│
├── sql/
│   └── hr_attrition_analysis.sql
│
├── dax/
│   └── dax_measures_and_columns.md
│
├── powerbi/
│   └── HR_Employee_Attrition_Analysis.pbix
│
├── screenshots/
│   ├── page_1_executive_overview.png
│   ├── page_2_attrition_analysis.png
│   └── page_3_career_progression.png
│
└── documentation/
    └── project_documentation.md
```

---

# 📚 Project Documentation

Detailed project documentation is available here:

```text
documentation/project_documentation.md
```

It covers:

- Project overview
- Business problem
- Objectives
- Dataset
- Data preparation
- SQL analysis
- Power BI development
- DAX
- Dashboard pages
- Key insights
- Business questions
- Tools
- Workflow
- Limitations
- Future improvements

---

# ⚠️ Limitations

- The dataset represents a historical/static employee population.
- It is not a live HR system.
- The analysis identifies associations rather than causation.
- External labor-market factors are not included.
- Employee personal circumstances are not represented.
- Findings should not automatically be generalized to other organizations.

---

# 🚀 Future Improvements

Potential extensions include:

### Predictive Analytics

Develop an employee attrition prediction model using:

- Logistic Regression
- Random Forest
- XGBoost

### Explainable AI

Use SHAP to explain model predictions and identify important drivers.

### Automated Refresh

Connect Power BI to a regularly updated HR database or data warehouse.

### Advanced HR Analytics

Add:

- Retention analysis
- Workforce segmentation
- Compensation benchmarking
- Promotion velocity
- Workforce planning
- Satisfaction analysis

### What-If Analysis

Build Power BI parameters for scenario analysis involving:

- Overtime
- Compensation
- Promotion timing
- Retention scenarios

---

# 🎓 Skills Demonstrated

This project demonstrates practical experience in:

- Data Cleaning
- Exploratory Data Analysis
- SQL
- Data Aggregation
- Window Functions
- CTEs
- Subqueries
- Business Analysis
- Power Query
- Power BI
- DAX
- Data Visualization
- KPI Development
- Dashboard Design
- Interactive Reporting
- Business Storytelling
- GitHub Documentation

---

# 📌 Conclusion

The **HR Employee Attrition Analysis** project transforms employee-level HR data into an interactive business intelligence solution.

The project combines:

```text
SQL
+
Data Preparation
+
DAX
+
Power BI
+
Business Analysis
+
Data Visualization
```

to provide a structured view of employee attrition and highlight segments that may require further HR investigation.

The analysis is designed to support **data-informed HR decision-making**, while recognizing that observed relationships in the dataset do not establish causation.

---

## Author

**Aman Singh**

**Data Analyst | SQL | Power BI | DAX | Python**

---
