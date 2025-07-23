# Covid_Vaccinnation_Appointment_Analysis

# 🏥 NHS COVID Vaccination Appointment Analysis Dashboard

This project focuses on analysing and visualising the NHS COVID vaccination appointment dataset, specifically **Table 6** from the **GP_Appointment_Publication_Summary_May_2025** obtained from NHS dataset repository. The goal is to explore appointment patterns across regions and months and present them using a dynamic Excel dashboard.

---

## 📌 Project Description

The dataset was obtained from the NHS Digital portal and processed through SQL Server for data transformation, and exploration. The original Excel file was converted from **wide** to **long format** to enable time-based analysis, and an interactive dashboard was built in Excel to visualise key metrics.

---

## 📁 Data Source
- Dataset Name: GP_Appointment_Publication_Summary_May_2025  [Download Data Set here](https://github.com/Dibya-Shrestha/Client-Data-Cleaning-Project/raw/main/Client%20Data%20Cleaning%20Project.xlsx)
- URL: 
---

## 🛠 Tools & Technologies Used

- **SQL Server**: Data import, transformation (wide to long), and exploratory queries  
- **Microsoft Excel**: Data visualisation, PivotTables, slicers, and KPI dashboard creation  

---

## 🧪 Data Processing Steps

1. **Download & Import**
   - Downloaded the Excel dataset `GP_Appointment_Publication_Summary_May_2025  `.
   - Imported **Table 6** into SQL Server for data wrangling.

2. **Wide to Long Format Conversion**
   - Transformed monthly columns (e.g. Jan–Dec) into row-based entries using SQL's `UNPIVOT`.

3. **SQL Queries for Exploration**
   - Total appointments per month across all regions (aggregated)
   - Total appointments per ICB overall (all months combined)
   - Top 5 ICBs with the highest total appointments (all months)
   - ICBs with zero appointments in any month (possible data gaps)
   - Average appointments per month per ICB
   - Total appointments per ICB in 2023
   - Share of Each ICB Within Its Region
   - Region with the highest appointment count in Dec 2024
   - Regions with a Drop in Appointments in 2024 vs 2023

4. **Export to Excel**
   - Exported the cleaned and transformed dataset from SQL Server.
   - Converted `Month` column to `Date` format in Excel for sorting and filtering.

  ## Excel Dashboard Metrics
  - Trend Over Years
  - Percentage By Region
  - Top 10 ICB
  - Value by Years
  - Total Appointments
  - Total 0 Appointments
  - Slicer by Year and Month
  - Download the Excel Dashboard with exported sheet from SQL, Converted sheet, individual pivot chart sheet and Dashboard
