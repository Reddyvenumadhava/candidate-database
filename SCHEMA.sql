-- =====================================================
-- CREATE DATABASE
-- =====================================================
CREATE DATABASE IF NOT EXISTS candidate;
USE candidate;

-- =====================================================
-- MASTER TABLES
-- =====================================================

CREATE TABLE IF NOT EXISTS tbl_cd_msalutation (
  salutation_id INT AUTO_INCREMENT PRIMARY KEY,
  value VARCHAR(50) NOT NULL UNIQUE,
  description VARCHAR(255),
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE IF NOT EXISTS tbl_cd_mskills (
  skill_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255),
  language_code VARCHAR(20) NOT NULL,
  language_name VARCHAR(100) NOT NULL,
  version VARCHAR(50),
  complexity VARCHAR(50),
  status VARCHAR(30),
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE IF NOT EXISTS tbl_cd_mlanguages (
  language_id INT AUTO_INCREMENT PRIMARY KEY,
  language_code VARCHAR(20) NOT NULL UNIQUE,
  language_name VARCHAR(100) NOT NULL UNIQUE,
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE IF NOT EXISTS tbl_cd_minterests (
  interest_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE,
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE IF NOT EXISTS tbl_cd_mcourses (
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  course_name VARCHAR(150) NOT NULL,
  course_code VARCHAR(50) NOT NULL,
  specialization_name VARCHAR(150) NOT NULL,
  specialization_code VARCHAR(50) NOT NULL,
  created_at DATETIME,
  updated_at DATETIME,
  UNIQUE (course_code, specialization_code),
  UNIQUE (course_name, specialization_name)
);

CREATE TABLE IF NOT EXISTS tbl_cd_mcolleges (
  college_id INT AUTO_INCREMENT PRIMARY KEY,
  college_name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE IF NOT EXISTS tbl_cd_mcertifications (
  certification_id INT AUTO_INCREMENT PRIMARY KEY,
  certification_name VARCHAR(255) NOT NULL,
  certification_code VARCHAR(100) NOT NULL UNIQUE,
  issuing_organization VARCHAR(255) NOT NULL,
  created_at DATETIME,
  updated_at DATETIME
);

-- =====================================================
-- GEOGRAPHY
-- =====================================================

CREATE TABLE IF NOT EXISTS tbl_cd_mcountries (
  country_id INT AUTO_INCREMENT PRIMARY KEY,
  country_name VARCHAR(100) NOT NULL UNIQUE,
  country_code VARCHAR(5) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS tbl_cd_mstates (
  state_id INT AUTO_INCREMENT PRIMARY KEY,
  state_name VARCHAR(100) NOT NULL,
  country_id INT NOT NULL,
  UNIQUE (state_name, country_id),
  FOREIGN KEY (country_id) REFERENCES tbl_cd_mcountries(country_id)
);

CREATE TABLE IF NOT EXISTS tbl_cd_mcities (
  city_id INT AUTO_INCREMENT PRIMARY KEY,
  city_name VARCHAR(100) NOT NULL,
  state_id INT NOT NULL,
  UNIQUE (city_name, state_id),
  FOREIGN KEY (state_id) REFERENCES tbl_cd_mstates(state_id)
);

-- =====================================================
-- STUDENT CORE
-- =====================================================

CREATE TABLE IF NOT EXISTS tb_cd_student (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  salutation_id INT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100),
  email VARCHAR(255) NOT NULL UNIQUE,
  contact_number VARCHAR(20),
  status VARCHAR(30) NOT NULL,
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (salutation_id)
    REFERENCES tbl_cd_msalutation(salutation_id)
);

-- =====================================================
-- EDUCATION
-- =====================================================

CREATE TABLE IF NOT EXISTS tb_cd_student_education (
  edu_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  college_id INT NOT NULL,
  course_id INT NOT NULL,
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (student_id) REFERENCES tb_cd_student(student_id),
  FOREIGN KEY (college_id) REFERENCES tbl_cd_mcolleges(college_id),
  FOREIGN KEY (course_id) REFERENCES tbl_cd_mcourses(course_id)
);

-- =====================================================
-- MANY TO MANY
-- =====================================================

CREATE TABLE IF NOT EXISTS tb_cd_m2m_std_skill (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  skill_id INT NOT NULL,
  UNIQUE (student_id, skill_id),
  FOREIGN KEY (student_id) REFERENCES tb_cd_student(student_id),
  FOREIGN KEY (skill_id) REFERENCES tbl_cd_mskills(skill_id)
);