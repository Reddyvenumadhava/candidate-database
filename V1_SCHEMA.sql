-- =====================================================
-- AZURE SQL COMPATIBLE SCHEMA
-- =====================================================

-- ========================
-- MASTER TABLES
-- ========================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_msalutation')
CREATE TABLE tbl_cd_msalutation (
  salutation_id INT IDENTITY(1,1) PRIMARY KEY,
  value VARCHAR(50) NOT NULL UNIQUE,
  description VARCHAR(255),
  created_at DATETIME2,
  updated_at DATETIME2
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_mskills')
CREATE TABLE tbl_cd_mskills (
  skill_id INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255),
  language_code VARCHAR(20) NOT NULL,
  language_name VARCHAR(100) NOT NULL,
  version VARCHAR(50),
  complexity VARCHAR(50),
  status VARCHAR(30),
  created_at DATETIME2,
  updated_at DATETIME2
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_mlanguages')
CREATE TABLE tbl_cd_mlanguages (
  language_id INT IDENTITY(1,1) PRIMARY KEY,
  language_code VARCHAR(20) NOT NULL UNIQUE,
  language_name VARCHAR(100) NOT NULL UNIQUE,
  created_at DATETIME2,
  updated_at DATETIME2
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_minterests')
CREATE TABLE tbl_cd_minterests (
  interest_id INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE,
  created_at DATETIME2,
  updated_at DATETIME2
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_mcourses')
CREATE TABLE tbl_cd_mcourses (
  course_id INT IDENTITY(1,1) PRIMARY KEY,
  course_name VARCHAR(150) NOT NULL,
  course_code VARCHAR(50) NOT NULL,
  specialization_name VARCHAR(150) NOT NULL,
  specialization_code VARCHAR(50) NOT NULL,
  created_at DATETIME2,
  updated_at DATETIME2,
  CONSTRAINT uq_course UNIQUE (course_code, specialization_code),
  CONSTRAINT uq_course_name UNIQUE (course_name, specialization_name)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_mcolleges')
CREATE TABLE tbl_cd_mcolleges (
  college_id INT IDENTITY(1,1) PRIMARY KEY,
  college_name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME2,
  updated_at DATETIME2
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_mcertifications')
CREATE TABLE tbl_cd_mcertifications (
  certification_id INT IDENTITY(1,1) PRIMARY KEY,
  certification_name VARCHAR(255) NOT NULL,
  certification_code VARCHAR(100) NOT NULL UNIQUE,
  issuing_organization VARCHAR(255) NOT NULL,
  created_at DATETIME2,
  updated_at DATETIME2
);

-- ========================
-- GEOGRAPHY
-- ========================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_mcountries')
CREATE TABLE tbl_cd_mcountries (
  country_id INT IDENTITY(1,1) PRIMARY KEY,
  country_name VARCHAR(100) NOT NULL UNIQUE,
  country_code VARCHAR(5) NOT NULL UNIQUE
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_mstates')
CREATE TABLE tbl_cd_mstates (
  state_id INT IDENTITY(1,1) PRIMARY KEY,
  state_name VARCHAR(100) NOT NULL,
  country_id INT NOT NULL,
  CONSTRAINT uq_state UNIQUE (state_name, country_id),
  FOREIGN KEY (country_id) REFERENCES tbl_cd_mcountries(country_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_cd_mcities')
CREATE TABLE tbl_cd_mcities (
  city_id INT IDENTITY(1,1) PRIMARY KEY,
  city_name VARCHAR(100) NOT NULL,
  state_id INT NOT NULL,
  CONSTRAINT uq_city UNIQUE (city_name, state_id),
  FOREIGN KEY (state_id) REFERENCES tbl_cd_mstates(state_id)
);

-- ========================
-- STUDENT CORE
-- ========================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tb_cd_student')
CREATE TABLE tb_cd_student (
  student_id INT IDENTITY(1,1) PRIMARY KEY,
  salutation_id INT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100),
  email VARCHAR(255) NOT NULL UNIQUE,
  contact_number VARCHAR(20),
  status VARCHAR(30) NOT NULL,
  created_at DATETIME2,
  updated_at DATETIME2,
  FOREIGN KEY (salutation_id)
    REFERENCES tbl_cd_msalutation(salutation_id)
);

-- ========================
-- EDUCATION
-- ========================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tb_cd_student_education')
CREATE TABLE tb_cd_student_education (
  edu_id INT IDENTITY(1,1) PRIMARY KEY,
  student_id INT NOT NULL,
  college_id INT NOT NULL,
  course_id INT NOT NULL,
  created_at DATETIME2,
  updated_at DATETIME2,
  FOREIGN KEY (student_id) REFERENCES tb_cd_student(student_id),
  FOREIGN KEY (college_id) REFERENCES tbl_cd_mcolleges(college_id),
  FOREIGN KEY (course_id) REFERENCES tbl_cd_mcourses(course_id)
);

-- ========================
-- MANY TO MANY
-- ========================

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tb_cd_m2m_std_skill')
CREATE TABLE tb_cd_m2m_std_skill (
  id INT IDENTITY(1,1) PRIMARY KEY,
  student_id INT NOT NULL,
  skill_id INT NOT NULL,
  CONSTRAINT uq_student_skill UNIQUE (student_id, skill_id),
  FOREIGN KEY (student_id) REFERENCES tb_cd_student(student_id),
  FOREIGN KEY (skill_id) REFERENCES tbl_cd_mskills(skill_id)
);
