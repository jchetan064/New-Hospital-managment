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

-- Q42. Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. Average is rounded to 2 decimal places.
select
  max(number_of_visits) as max_visits,
  min(number_of_visits) as min_visits,
  round(avg(number_of_visits), 2) as average_visits
  from (
    select admission_date , count(*) as number_of_visits
      from admissions
      group by admission_date
  );

-- Q43. Show all of the patients grouped into weight groups.Show the total amount of patients in each weight group.Order the list by the weight group decending.
-- For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select count(*) as patients_in_group,
floor(weight / 10) * 10 as weight_group
from patients
group by weight_group
order by weight_group DESC;

-- Q44. Show patient_id, weight, height, isObese from the patients table.Display isObese as a boolean 0 or 1.Obese is defined as weight(kg)/(height(m)2) >= 30.weight is in units kg.height is in units cm.
use hospital;
SELECT
  patient_id,  weight, height, weight / power(CAST(height AS float) / 100, 2) >= 30 AS obese
FROM patients;
SELECT patient_id, weight, height, 
  (CASE 
      WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
          1
      ELSE
          0
      END) AS isObese
FROM patients;

-- Q45. Show patient_id, first_name, last_name, and attending doctor's specialty.Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'Check patients, admissions, and doctors tables for required information.
select
  p.patient_id,
  p.first_name,
  p.last_name,
  d.specialty
from patients p
  join admissions a on p.patient_id = a.patient_id
  join doctors d on d.doctor_id = a.attending_doctor_id
where a.diagnosis = 'Epilepsy' and d.first_name = 'Lisa';

SELECT
  a.patient_id,
  a.first_name,
  a.last_name,
  b.specialty
FROM
  patients a,
  doctors b,
  admissions c
WHERE
  a.patient_id = c.patient_id
  AND c.attending_doctor_id = b.doctor_id
  AND c.diagnosis = 'Epilepsy'
  AND b.first_name = 'Lisa';
