CREATE DATABASE IF NOT EXISTS hospital
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;
  
  Use Hospital;
  
  -- -----------------------------------------------------
-- Table: province_names
-- -----------------------------------------------------
CREATE TABLE province_names (
  province_id   CHAR(2)     NOT NULL,
  province_name VARCHAR(30) NOT NULL,
  PRIMARY KEY (province_id)
) ENGINE=InnoDB;



-- -----------------------------------------------------
-- Table: patients
-- -----------------------------------------------------
CREATE TABLE patients (
  patient_id   INT          NOT NULL AUTO_INCREMENT,
  first_name   VARCHAR(30)  NOT NULL,
  last_name    VARCHAR(30)  NOT NULL,
  gender       CHAR(1)      NULL,
  birth_date   DATE         NULL,
  city         VARCHAR(30)  NULL,
  province_id  CHAR(2)      NULL,
  allergies    VARCHAR(80)  NULL,
  height       DECIMAL(3,0) NULL,
  weight       DECIMAL(4,0) NULL,
  PRIMARY KEY (patient_id),
  CONSTRAINT fk_patients_province
    FOREIGN KEY (province_id)
    REFERENCES province_names (province_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;


-- Helpful index if you often filter by province
CREATE INDEX idx_patients_province ON patients (province_id);


-- -----------------------------------------------------
-- Table: doctors
-- -----------------------------------------------------
CREATE TABLE doctors (
  doctor_id   INT          NOT NULL AUTO_INCREMENT,
  first_name  VARCHAR(30)  NOT NULL,
  last_name   VARCHAR(30)  NOT NULL,
  specialty   VARCHAR(25)  NULL,
  PRIMARY KEY (doctor_id)
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table: admissions
-- -----------------------------------------------------
CREATE TABLE admissions (
  patient_id          INT         NOT NULL,
  admission_date      DATE        NOT NULL,
  discharge_date      DATE        NULL,
  diagnosis           VARCHAR(50) NULL,
  attending_doctor_id INT         NULL,
  PRIMARY KEY (patient_id, admission_date),
  CONSTRAINT fk_admissions_patient
    FOREIGN KEY (patient_id)
    REFERENCES patients (patient_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_admissions_doctor
    FOREIGN KEY (attending_doctor_id)
    REFERENCES doctors (doctor_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- Helpful indexes
CREATE INDEX idx_admissions_doctor ON admissions (attending_doctor_id);
CREATE INDEX idx_admissions_discharge ON admissions (discharge_date);




-- 1. Province Names
INSERT INTO province_names (province_id, province_name) VALUES
('MH', 'Maharashtra'),
('DL', 'Delhi'),
('KA', 'Karnataka'),
('TN', 'Tamil Nadu'),
('GJ', 'Gujarat'),
('RJ', 'Rajasthan'),
('UP', 'Uttar Pradesh'),
('PB', 'Punjab'),
('WB', 'West Bengal'),
('KL', 'Kerala');



-- 2. Doctors (10 doctors)
INSERT INTO doctors (first_name, last_name, specialty) VALUES
('Amit', 'Sharma', 'Cardiology'),
('Priya', 'Verma', 'Neurology'),
('Rahul', 'Kapoor', 'Orthopedics'),
('Sneha', 'Patel', 'Dermatology'),
('Vikas', 'Mehta', 'Pediatrics'),
('Anita', 'Rao', 'Oncology'),
('Arjun', 'Nair', 'ENT'),
('Ritika', 'Singh', 'Gynecology'),
('Deepak', 'Yadav', 'General Medicine'),
('Kiran', 'Das', 'Psychiatry');

-- 3. Patients (30 patients)
INSERT INTO patients (first_name, last_name, gender, birth_date, city, province_id, allergies, height, weight) VALUES
('Rohan', 'Joshi', 'M', '1990-05-12', 'Mumbai', 'MH', 'Peanuts', 170, 65),
('Anjali', 'Reddy', 'F', '1988-11-25', 'Bengaluru', 'KA', 'Dust', 160, 55),
('Amit', 'Singh', 'M', '1995-07-10', 'Delhi', 'DL', NULL, 175, 70),
('Priya', 'Mishra', 'F', '2000-03-14', 'Lucknow', 'UP', 'Pollen', 162, 52),
('Suresh', 'Patil', 'M', '1985-12-20', 'Pune', 'MH', NULL, 168, 68),
('Neha', 'Iyer', 'F', '1998-06-08', 'Chennai', 'TN', 'Seafood', 158, 50),
('Arjun', 'Yadav', 'M', '1992-09-05', 'Jaipur', 'RJ', NULL, 180, 78),
('Kavita', 'Shah', 'F', '1993-02-28', 'Ahmedabad', 'GJ', 'Dust', 155, 48),
('Rakesh', 'Kumar', 'M', '1987-01-10', 'Kolkata', 'WB', NULL, 172, 73),
('Sunita', 'Pillai', 'F', '1996-10-19', 'Thiruvananthapuram', 'KL', 'Nuts', 159, 49),
('Mohit', 'Goyal', 'M', '1991-04-22', 'Varanasi', 'UP', 'Penicillin', 165, 66),
('Asha', 'Rani', 'F', '1994-05-16', 'Amritsar', 'PB', NULL, 163, 54),
('Deepak', 'Shetty', 'M', '1989-07-07', 'Bengaluru', 'KA', NULL, 176, 75),
('Komal', 'Gupta', 'F', '2001-11-11', 'Delhi', 'DL', 'Pollen', 157, 47),
('Anand', 'Mehra', 'M', '1984-06-23', 'Mumbai', 'MH', NULL, 170, 68),
('Pooja', 'Kaur', 'F', '1999-09-17', 'Chandigarh', 'PB', 'Latex', 161, 50),
('Vivek', 'Bose', 'M', '1993-08-02', 'Kolkata', 'WB', NULL, 174, 72),
('Shalini', 'Nair', 'F', '1986-12-05', 'Kochi', 'KL', NULL, 160, 53),
('Rajesh', 'Chopra', 'M', '1983-04-18', 'Jaipur', 'RJ', 'Dust', 178, 76),
('Meena', 'Joshi', 'F', '1997-02-12', 'Pune', 'MH', 'Seafood', 156, 48),
('Manoj', 'Das', 'M', '1988-09-09', 'Ahmedabad', 'GJ', NULL, 171, 70),
('Lata', 'Bansal', 'F', '1992-07-30', 'Bhopal', 'UP', 'Peanuts', 158, 52),
('Ravi', 'Khanna', 'M', '1995-11-21', 'Delhi', 'DL', NULL, 169, 67),
('Nisha', 'Varma', 'F', '1989-10-03', 'Lucknow', 'UP', NULL, 162, 51),
('Sanjay', 'Tiwari', 'M', '1990-12-25', 'Kanpur', 'UP', 'Dust', 177, 74),
('Bhavna', 'Garg', 'F', '1991-01-14', 'Amritsar', 'PB', 'Latex', 159, 50),
('Alok', 'Rana', 'M', '1987-08-15', 'Chennai', 'TN', NULL, 172, 71),
('Rekha', 'Saxena', 'F', '1993-04-19', 'Bengaluru', 'KA', 'Penicillin', 160, 54),
('Ishaan', 'Kapoor', 'M', '1996-03-28', 'Pune', 'MH', NULL, 168, 66),
('Tanvi', 'Madaan', 'F', '1998-06-12', 'Kolkata', 'WB', NULL, 157, 49);

-- 4. Admissions (10 records)
INSERT INTO admissions (patient_id, admission_date, discharge_date, diagnosis, attending_doctor_id) VALUES
(1, '2025-01-05', '2025-01-10', 'Fever', 9),
(2, '2025-02-01', '2025-02-07', 'Fracture', 3),
(3, '2025-02-05', '2025-02-09', 'Asthma', 9),
(4, '2025-02-15', '2025-02-20', 'Skin Allergy', 4),
(5, '2025-03-01', '2025-03-06', 'Viral Infection', 9),
(6, '2025-03-10', '2025-03-15', 'Food Poisoning', 5),
(7, '2025-03-20', '2025-03-27', 'Back Pain', 3),
(8, '2025-03-25', '2025-03-30', 'Migraine', 2),
(9, '2025-04-02', '2025-04-07', 'Anemia', 1),
(10, '2025-04-05', '2025-04-10', 'Pneumonia', 9);

-- Q1. Show first name , last name and gender of patients whose gender is 'M';
Select first_name , last_name , gender from patients where gender = 'M';

-- Q2. show first name , last_name of patients who does not have allergies (Null).
Select first_name , last_name from patients where allergies is null;

-- Q3. Show first name of patients that start with the letter 'A'.
Select * from patients where first_name like 'A%';

-- Q4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive).
select first_name , last_name from patients where weight between 60 and 70;

-- Q5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
Update patients set allergies = 'NKA' where allergies is null;
select * from patients;

-- Q6. Show first name and last name concatinated into one column to show their full name.
select concat( first_name , ' ' , last_name ) as full_name from patients;

-- Q7. Show first name, last name, and the full province name of each patient.  Example: 'Ontario' instead of 'ON'
select
  pat.first_name,
  pat.last_name,
  pn.province_name
from patients as pat
  join province_names as pn
on pat.province_id = pn.province_id;


-- Q8. Show how many patients have a birth_date with 1990 as the birth year.
Select count(*) Total_Patients from patients where year(birth_date) = 1990;


-- Q9. Show the first_name, last_name, and height of the patient with the greatest height.
Select first_name , last_name , height from patients order by height desc limit 1;

-- Q10. Show all columns for patients who have one of the following patient_ids: 1,5,14,20,30
select * from patients where patient_id in ( 1,5,14,20,30 );


-- Q11. Show the total number of admissions
Select count(*) Total_Admissions from admissions;


-- Q12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions;
update admissions
set discharge_date = '2025-02-01'
where patient_id = 2;
Select * from admissions where admission_date = discharge_date;


-- Q13. Show the patient id and the total number of admissions for patient_id 7.
Select patient_id , count(*) from admissions where patient_id = 7;


-- Q14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.
select distinct(city) Unique_City from patients where province_id = 'RJ';
-- select province_id , province_name from province_names; 
 select * from patients;


-- Q15. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70.
select first_name , last_name , birth_date from patients where height > 160 and weight > 70;


-- Q16. Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
update patients
set allergies = 'Null'
where allergies = 'NKA';
SELECT first_name , last_name , allergies FROM patients WHERE city = 'Jaipur' and allergies is not null;


-- Q17. Show unique birth years from patients and order them by ascending.
select distinct(year(birth_date)) as birth_year from patients order by year(birth_date) asc;

-- Q18. Show unique first names from the patients table which only occurs once in the list.

Select first_name from patients group by first_name having count(first_name)  = 1;

select first_name
from (
    select
      first_name,
      count(first_name) as occurrencies
    from patients
    group by first_name ) as table1 where occurrencies = 1;
    
    
-- Q19. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.    
SELECT
  patient_id,
  first_name
FROM patients
WHERE first_name LIKE 's____%s';
SELECT
  patient_id,
  first_name
FROM patients
WHERE
  first_name LIKE 's%s'
  AND len(first_name) >= 6;
  SELECT
  patient_id,
  first_name
FROM patients
where
  first_name like 's%'
  and first_name like '%s'
  and len(first_name) >= 6;
  
-- Q20. Show patient_id, first_name, last_name from patients whos diagnosis is 'Fever'.
select patients.patient_id , patients.first_name , patients.last_name from patients join admissions on patients.patient_id = admissions.patient_id where admissions.diagnosis = 'Fever';
select * from admissions;


-- Q21. Display every patient's first_name.Order the list by the length of each name and then by alphabetically.
Select first_name from patients order by length(first_name) , first_name ;


-- Q22. Show the total amount of male patients and the total amount of female patients in the patients table.Display the two results in the same row.
select 
(select count(*) from patients where gender = 'M') as Male_Count,
(select count(*) from patients where gender = 'F') as Female_Count;

SELECT 
  SUM(Gender = 'M') as male_count, 
  SUM(Gender = 'F') AS female_count
FROM patients;


-- Q23. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
Select first_name , last_name , allergies from patients where allergies in ( 'Penicillin' , 'Morphine') order by allergies,first_name,last_name;

SELECT
  first_name,
  last_name,
  allergies
FROM
  patients
WHERE
  allergies = 'Penicillin'
  OR allergies = 'Morphine'
ORDER BY
  allergies ASC,
  first_name ASC,
  last_name ASC;
  

-- Q24. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id , diagnosis from admissions group by patient_id , diagnosis having count(*)> 1;


-- Q25. Show the city and the total number of patients in the city.Order from most to least patients and then by city name ascending.
select city , count(patient_id) as Total_Patients from patients group by city order by Total_patients desc , city;


-- Q26. Show first name, last name and role of every person that is either patient or doctor.The roles are either "Patient" or "Doctor".
select first_name , last_name ,'Patient' as role from patients
union all
select first_name , last_name , 'Doctor' as role from doctors;


-- Q27. Show all allergies ordered by popularity. Remove NULL values from query.
select allergies , count(*) as Total_Diagnosis from patients where allergies is not null group by allergies order by Total_Diagnosis DESC;


-- Q28. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name, last_name, birth_date from patients where year(birth_date) between 1970 and 1979;

SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;

SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE year(birth_date) LIKE '197%'
ORDER BY birth_date ASC;


-- Q29. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
-- EX: SMITH,jane
select concat(upper(last_name) , ',' , lower(first_name)) as new_name_format from patients order by first_name desc;


-- Q30. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 700.
select province_id , sum(height) as sum_height from patients group by province_id having sum_height >= 700;


-- Q31. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'.
select max(weight) - min(wight) from patients where last_name = 'Morani';


-- Q32. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date) as Day_Number , count(*) as Number_Of_Admission from admissions group by Day_number order by Number_Of_Admission desc;


-- Q33. Show all columns for patient_id 2's most recent admission_date.
select * from admissions where patient_id = 2 order by admission_date desc limit 1;


-- Q34. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
SELECT patient_id , attending_doctor_id , diagnosis FROM admissions 
WHERE 
( attending_doctor_id IN (1, 5, 19) AND patient_id % 2 != 0 )
  OR 
( attending_doctor_id LIKE '%2%' AND length(patient_id) = 3 );


-- Q35. Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.
SELECT
  first_name,
  last_name,
  count(*) as admissions_total
from admissions a
  join doctors ph on ph.doctor_id = a.attending_doctor_id
group by attending_doctor_id;

SELECT
  first_name,
  last_name,
  count(*) as admissions_total
from admissions a
  join doctors ph on ph.doctor_id = a.attending_doctor_id
group by attending_doctor_id;


-- Q36. For each doctor, display their id, full name, and the first and last admission date they attended.
select d.doctor_id , 
concat(d.first_name , ' ' , d.last_name) Full_Name ,
min(a.admission_date) first_admission_date ,
max(a.admission_date) last_admission_date
from  doctors d join admissions a
on d.doctor_id = a.attending_doctor_id
group by doctor_id;


-- Q37. Display the total amount of patients for each province. Order by descending.
select pn.province_name , count(p.patient_id) patient_count from patients as p join province_names pn on p.province_id = pn.province_id group by province_name order by patient_count desc;
use hospital;


-- Q38. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select
  concat(p.first_name, ' ' , p.last_name) Patient_Name,
  a.diagnosis,
  concat(d.first_name, ' ' ,d.last_name) Doctor_Name
from patients p
join admissions a on p.patient_id = a.patient_id
join doctors d on a.attending_doctor_id = d.doctor_id;


-- Q39. display the first name, last name and number of duplicate patients based on their first name and last name.
-- Ex: A patient with an identical name can be considered a duplicate.
select
  first_name,
  last_name,
  count(*) num_of_duplicate
  from patients
  group by first_name , last_name 
  having count(*) > 1;
  
  
-- Q40. Display patient's full name,height in the units feet rounded to 1 decimal,weight in the unit pounds rounded to 0 decimals,birth_date,gender non abbreviated.
-- Convert CM to feet by dividing by 30.48.Convert KG to pounds by multiplying by 2.205. 
select concat(first_name , ' ' , last_name) Patinet_Name , round(height/30.48 , 1) Height , round(weight*2.205 , 1) Weight , birth_date , if(gender = 'm' , 'Male','Female') Gender from patients;


-- Q41. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
-- (Their patient_id does not exist in any admissions.patient_id rows.)

select
  patients.patient_id,
  patients.first_name,
  patients.last_name
from patients
where patients.patient_id not in ( 
	select admissions.patient_id from admissions
);

SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
  left join admissions on patients.patient_id = admissions.patient_id
where admissions.patient_id is NULL;