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

