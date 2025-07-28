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
