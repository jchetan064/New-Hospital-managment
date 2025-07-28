🏥 Hospital Management System – SQL Project
📌 Overview
This project is a Hospital Management System developed using SQL, focusing on efficient database design and query implementation. It manages core hospital operations like patient registration, doctor details, admissions tracking, and province-wise classification.

The project demonstrates relational database design through four main modules:
patients
doctors
admissions
province_name

🗂️ Modules Description:

🧍 Patients:
Stores personal and contact information
Linked to admissions and province data
Includes details like gender, age, and health concerns

👨‍⚕️ Doctors:
Contains data on hospital doctors
Specialization, experience, and availability tracking
Can be linked to admissions for assigned patient care

🏥 Admissions:
Manages hospital admission and discharge information
Tracks patient ID, doctor ID, date of admission, and room/ward info

🌐 Province Name:
Maps each patient’s province/region for demographic analysis
Useful for location-based statistics or disease trends

📄 Files Included:
database.sql – SQL script to create all tables with keys and constraints
practice problem.sql – Useful SQL queries such as:
Number of patients per province
Doctors treating the most patients
Active vs discharged patients
Admissions by date range or doctor

🧠 Concepts Demonstrated:
Primary/Foreign Keys
Joins across multiple tables
Aggregations (COUNT, SUM, etc.)
Filtering using WHERE, LIKE, and BETWEEN
Sorting and grouping (ORDER BY, GROUP BY)

🚀 How to Use:
Import database.sql into your SQL tool (MySQL, PostgreSQL, etc.)
Execute queries from practice problem.sql to explore insights

🔧 Tools Used:
SQL (MySQL recommended)
DB Tool: MySQL Workbench / DBeaver / phpMyAdmin

🛠 Future Scope:
Add appointment scheduling table
Introduce billing module
Visualize data via dashboards (e.g., Tableau, Power BI)
Web integration using PHP or Python (Flask)

🙌 Contributions:
Contributions are welcome! You can:
Add more sample data
Write advanced SQL queries (e.g., views, procedures)
Extend schema with more hospital functionalities

