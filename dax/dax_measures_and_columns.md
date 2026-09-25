# HR Employee Attrition Analysis — DAX

## Source
Power BI file: `hr_ibm_analysis.pbix`

> **Important:** The PBIX file was inspected for the model/report metadata. The report contains these model measures:
> `Total Employee`, `Total Active Employee`, `Attrition Count`, `Attrition Rate`, `Attrition Rate1`, `Avg Income`, `Avg Tenure`, `Job Satisfaction`, and `Highest Attrition Job Role`.
>
> Power BI stores the semantic model in a proprietary/compressed PBIX format, so the exact original DAX expression text cannot be recovered reliably from the PBIX package available here. The formulas below reconstruct the project measures from the measure names, dashboard usage, and the SQL/DAX work we documented. **Verify them in Power BI before presenting them as the exact original formula.**

---

# 1. Core KPI Measures

## Total Employee

```DAX
Total Employee =
COUNTROWS('hr_ibm attrition')
```

Counts all employee records.

---

## Total Active Employee

```DAX
Total Active Employee =
CALCULATE(
    COUNTROWS('hr_ibm attrition'),
    'hr_ibm attrition'[Attrition] = "No"
)
```

Counts employees who did not leave.

---

## Attrition Count

```DAX
Attrition Count =
CALCULATE(
    COUNTROWS('hr_ibm attrition'),
    'hr_ibm attrition'[Attrition] = "Yes"
)
```

Counts employees who left.

---

## Attrition Rate

```DAX
Attrition Rate =
DIVIDE(
    [Attrition Count],
    [Total Employee],
    0
)
```

**Format:** Percentage, 1 decimal place.

This measure is preferable to manually multiplying by 100 because Power BI percentage formatting handles the display.

---

## Attrition Rate1

The PBIX contains a second measure named `Attrition Rate1`.

The project-level equivalent is:

```DAX
Attrition Rate1 =
DIVIDE(
    [Attrition Count],
    [Total Employee],
    0
)
```

If the original `Attrition Rate1` was created as a testing/alternate measure, keep it only if it is still used by a visual. Otherwise it can be removed after verifying the report.

---

# 2. Salary / Income

## Avg Income

```DAX
Avg Income =
AVERAGE('hr_ibm attrition'[MonthlyIncome])
```

Average monthly income.

**Format:** Currency / decimal according to the dashboard requirement.

---

# 3. Tenure

## Avg Tenure

```DAX
Avg Tenure =
AVERAGE('hr_ibm attrition'[YearsAtCompany])
```

Average number of years employees have spent at the company.

---

# 4. Job Satisfaction

## Job Satisfaction

```DAX
Job Satisfaction =
AVERAGE('hr_ibm attrition'[JobSatisfaction])
```

Average job-satisfaction score.

---

# 5. Highest Attrition Job Role

A dynamic version of the KPI can be created with:

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

This returns the job role with the highest attrition rate in the current filter context.

---

# 6. Useful Calculated Columns

These are the project banding columns used for dashboard analysis.

## Age Group

```DAX
Age Group =
SWITCH(
    TRUE(),
    'hr_ibm attrition'[Age] < 25, "Under 25",
    'hr_ibm attrition'[Age] <= 34, "25-34",
    'hr_ibm attrition'[Age] <= 44, "35-44",
    'hr_ibm attrition'[Age] <= 54, "45-54",
    "55+"
)
```

### Age Group Sort

```DAX
Age Group Sort =
SWITCH(
    'hr_ibm attrition'[Age Group],
    "Under 25", 1,
    "25-34", 2,
    "35-44", 3,
    "45-54", 4,
    "55+", 5
)
```

In Power BI:

**Age Group → Sort by column → Age Group Sort**

---

# 7. Tenure Band

```DAX
Tenure Band =
SWITCH(
    TRUE(),
    'hr_ibm attrition'[YearsAtCompany] <= 1, "0-1 Years",
    'hr_ibm attrition'[YearsAtCompany] <= 5, "2-5 Years",
    'hr_ibm attrition'[YearsAtCompany] <= 10, "6-10 Years",
    "11+ Years"
)
```

### Tenure Band Sort

```DAX
Tenure Band Sort =
SWITCH(
    'hr_ibm attrition'[Tenure Band],
    "0-1 Years", 1,
    "2-5 Years", 2,
    "6-10 Years", 3,
    "11+ Years", 4
)
```

---

# 8. Promotion Band

The project used the following promotion-band logic:

```DAX
Promotion Band new =
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
    'hr_ibm attrition'[Promotion Band new],
    "0-1 Years", 1,
    "2-4 Years", 2,
    "5-7 Years", 3,
    "8-10 Years", 4,
    "10+ Years", 5
)
```

Then:

**Promotion Band new → Sort by column → Promotion Band Sort**

---

# 9. Income Band

```DAX
Income Band =
SWITCH(
    TRUE(),
    'hr_ibm attrition'[MonthlyIncome] < 3000, "$0-$3K",
    'hr_ibm attrition'[MonthlyIncome] < 5000, "$3K-$5K",
    'hr_ibm attrition'[MonthlyIncome] < 7000, "$5K-$7K",
    'hr_ibm attrition'[MonthlyIncome] < 10000, "$7K-$10K",
    'hr_ibm attrition'[MonthlyIncome] < 15000, "$10K-$15K",
    "$15K+"
)
```

### Income Band Sort

```DAX
Income Band Sort =
SWITCH(
    'hr_ibm attrition'[Income Band],
    "$0-$3K", 1,
    "$3K-$5K", 2,
    "$5K-$7K", 3,
    "$7K-$10K", 4,
    "$10K-$15K", 5,
    "$15K+", 6
)
```

---

# 10. Common Analysis Measures

These are useful measures for the visuals in the HR dashboard.

## Attrition Employees

```DAX
Employees Left =
CALCULATE(
    COUNTROWS('hr_ibm attrition'),
    'hr_ibm attrition'[Attrition] = "Yes"
)
```

This is equivalent to `Attrition Count`.

---

## Active Employees

```DAX
Active Employees =
CALCULATE(
    COUNTROWS('hr_ibm attrition'),
    'hr_ibm attrition'[Attrition] = "No"
)
```

Equivalent to `Total Active Employee`.

---

## Average Age

```DAX
Average Age =
AVERAGE('hr_ibm attrition'[Age])
```

---

## Average Monthly Income

```DAX
Average Monthly Income =
AVERAGE('hr_ibm attrition'[MonthlyIncome])
```

---

## Average Years at Company

```DAX
Average Years at Company =
AVERAGE('hr_ibm attrition'[YearsAtCompany])
```

---

# 11. Conditional Attrition Measures

## Overtime Attrition Rate

```DAX
Overtime Attrition Rate =
CALCULATE(
    [Attrition Rate],
    'hr_ibm attrition'[OverTime] = "Yes"
)
```

---

## Non-Overtime Attrition Rate

```DAX
Non-Overtime Attrition Rate =
CALCULATE(
    [Attrition Rate],
    'hr_ibm attrition'[OverTime] = "No"
)
```

---

# 12. Important DAX Functions Used

| Function | Project use |
|---|---|
| `COUNTROWS()` | Total employee records |
| `CALCULATE()` | Apply Attrition / Overtime filters |
| `DIVIDE()` | Attrition-rate calculation |
| `AVERAGE()` | Age, income, tenure, satisfaction |
| `SWITCH()` | Band creation |
| `TRUE()` | Multiple conditional band rules |
| `VALUES()` | Get unique job roles |
| `ADDCOLUMNS()` | Create temporary ranking table |
| `TOPN()` | Find highest-attrition role |
| `CONCATENATEX()` | Return the top role as text |

---

# 13. SQL → DAX Equivalents Used in the Project

### SQL

```SQL
SELECT COUNT(*)
FROM attrition
WHERE Attrition = 'Yes';
```

### DAX

```DAX
Attrition Count =
CALCULATE(
    COUNTROWS('hr_ibm attrition'),
    'hr_ibm attrition'[Attrition] = "Yes"
)
```

---

### SQL

```SQL
SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    )
FROM attrition;
```

### DAX

```DAX
Attrition Rate =
DIVIDE(
    [Attrition Count],
    [Total Employee],
    0
)
```

Format the measure as **Percentage**.

---

# 14. Measure vs Calculated Column

### Measures

These respond dynamically to filters/slicers:

```text
Total Employee
Total Active Employee
Attrition Count
Attrition Rate
Avg Income
Avg Tenure
Job Satisfaction
Highest Attrition Job Role
```

### Calculated Columns

These are row-level classifications:

```text
Age Group
Age Group Sort
Tenure Band
Tenure Band Sort
Promotion Band new
Promotion Band Sort
Income Band
Income Band Sort
```

---

# 15. Recommended GitHub location

Save this document as:

```text
dax/dax_measures_and_columns.md
```

Repository:

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
└── powerbi/
    └── HR_Employee_Attrition_Analysis.pbix
```
