Create database UniDB;
USE UniDB;

CREATE TABLE classroom_types (
    id CHAR(5) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO classroom_types (id, name) 
VALUES ('ct01', 'Classroom'),
       ('ct02', 'Seminar Hall'),
       ('ct03', 'Lab'),
       ('ct04', 'Auditorium');

CREATE TABLE classroom (
    id CHAR(4) PRIMARY KEY,
    room_type_id CHAR(5),
    room_name VARCHAR(50),
    capacity INT,
    FOREIGN KEY (room_type_id) REFERENCES classroom_types(id)
);

INSERT INTO classroom (id, room_type_id, room_name, capacity) 
VALUES ('r001', 'ct01', 'Classroom A101', 40),
       ('r002', 'ct02', 'Seminar Hall B202', 100),
       ('r003', 'ct03', 'Lab C303', 30),
       ('r004', 'ct04', 'Auditorium D404', 250);

CREATE TABLE department (
    id CHAR(4) PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO department (id, department_name) 
VALUES ('d001', 'Computer Science'),
       ('d002', 'Electrical and Communication'),
       ('d003', 'Electrial and Electronics'),
       ('d004', 'Mechanical'),
       ('d005', 'Bio Technology');

CREATE TABLE subject (
    id CHAR(4) PRIMARY KEY,
    department_id CHAR(4),
    subject_name VARCHAR(50), 
    FOREIGN KEY (department_id) REFERENCES department(id)
);

INSERT INTO subject (id, department_id, subject_name) 
VALUES ('s001', 'd001', 'Data Structures'),
       ('s002', 'd001', 'Algorithms'),
       ('s003', 'd002', 'Digital Communication'),
       ('s004', 'd002', 'Signal Processing'),
       ('s005', 'd003', 'Power Systems'),
       ('s006', 'd003', 'Control Systems'),
       ('s007', 'd004', 'Thermodynamics'),
       ('s008', 'd004', 'Fluid Mechanics'),
       ('s009', 'd005', 'Genetic Engineering'),
       ('s010', 'd005', 'Bioprocess Technology');

CREATE TABLE guardian (
    id CHAR(4) PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    email VARCHAR(255),
    phone_number VARCHAR(10)
);

INSERT INTO guardian (id, first_name, last_name, email, phone_number) 
VALUES ('g001', 'Rajesh', 'Kumar', 'rajesh.kumar@example.com', 9876543210),
       ('g002', 'Anjali', 'Sharma', 'anjali.sharma@example.com', 8765432109),
       ('g003', 'Suresh', 'Patel', 'suresh.patel@example.com', 9988776655),
       ('g004', 'Priya', 'Singh', 'priya.singh@example.com', 1234567890),
       ('g005', 'Amit', 'Verma', 'amit.verma@example.com', 8899776655);

CREATE TABLE guardian_type (
    id CHAR(5) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO guardian_type (id, name) 
VALUES ('gt001', 'Parent'),
       ('gt002', 'Guardian'),
       ('gt003', 'Relative'),
       ('gt004', 'Family Friend');

CREATE TABLE student (
    id CHAR(4) PRIMARY KEY,
    given_name VARCHAR(15),
    middle_name VARCHAR(15),
    last_name VARCHAR(15),
    date_of_birth DATE,
    gender CHAR(6),
    enrollment_date DATE
);

INSERT INTO student (id, given_name, middle_name, last_name, date_of_birth, gender, enrollment_date) 
VALUES ('s001', 'Aarav', 'Raj', 'Sharma', '2005-05-10', 'Male', '2021-06-15'),
       ('s002', 'Vivaan', 'Anil', 'Patel', '2006-08-20', 'Male', '2021-06-15'),
       ('s003', 'Anaya', 'Meera', 'Singh', '2005-12-30', 'Female', '2021-06-15'),
       ('s004', 'Diya', 'Kiran', 'Verma', '2007-03-25', 'Female', '2021-06-15'),
       ('s005', 'Kabir', 'Rahul', 'Joshi', '2006-07-14', 'Male', '2021-06-15');
       
CREATE TABLE student_guardian (
    student_id CHAR(4),
    guardian_type_id CHAR(5),
    guardian_id CHAR(4),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (guardian_type_id) REFERENCES guardian_type(id),
    FOREIGN KEY (guardian_id) REFERENCES guardian(id)
);

INSERT INTO student_guardian (student_id, guardian_type_id, guardian_id) 
VALUES ('s001', 'gt001', 'g001'),  -- Aarav with Parent Rajesh
       ('s002', 'gt002', 'g002'),  -- Vivaan with Guardian Anjali
       ('s003', 'gt003', 'g003'),  -- Anaya with Relative Suresh
       ('s004', 'gt004', 'g004'),  -- Diya with Family Friend Priya
       ('s005', 'gt001', 'g005');  -- Kabir with Parent Amit

CREATE TABLE teacher (
    id CHAR(4) PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    gender CHAR(6),
    email VARCHAR(255),
    phone_number VARCHAR(10)
);

INSERT INTO teacher (id, first_name, last_name, gender, email, phone_number) 
VALUES ('t001', 'Amit', 'Verma', 'Male', 'amit.verma@example.com', '9876543210'),
       ('t002', 'Priya', 'Sharma', 'Female', 'priya.sharma@example.com', '8765432109'),
       ('t003', 'Suresh', 'Kumar', 'Male', 'suresh.kumar@example.com', '9988776655'),
       ('t004', 'Anjali', 'Singh', 'Female', 'anjali.singh@example.com', '1234567890'),
       ('t005', 'Raj', 'Patel', 'Male', 'raj.patel@example.com', '8899776655');

CREATE TABLE school_year (
    id CHAR(4) PRIMARY KEY,
    year_name VARCHAR(50),
    start_year DATE,
    end_year DATE
);

INSERT INTO school_year (id, year_name, start_year, end_year) 
VALUES ('sy01', '2024-2025', '2024-08-01', '2025-05-31'),
       ('sy02', '2023-2024', '2023-08-01', '2024-05-31'),
       ('sy03', '2022-2023', '2022-08-01', '2023-05-31');

CREATE TABLE year_level (
    id CHAR(4) PRIMARY KEY,
    level_name VARCHAR(50),
    level_order INT
);

INSERT INTO year_level (id, level_name, level_order) 
VALUES ('yl01', 'First Year', 1),
       ('yl02', 'Second Year', 2),
       ('yl03', 'Third Year', 3),
       ('yl04', 'Fourth Year', 4),
       ('yl05', 'Fifth Year', 5);
       
CREATE TABLE student_year_level (
    student_id CHAR(4),
    level_id CHAR(4),
    school_year_id CHAR(4),
    score INT,
    PRIMARY KEY (student_id, level_id, school_year_id),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (level_id) REFERENCES year_level(id),
    FOREIGN KEY (school_year_id) REFERENCES school_year(id)
);

INSERT INTO student_year_level (student_id, level_id, school_year_id, score) 
VALUES ('s001', 'yl01', 'sy01', 85),  -- Aarav in First Year for 2024-2025 with score 85
       ('s002', 'yl01', 'sy01', 90),  -- Vivaan in First Year for 2024-2025 with score 90
       ('s003', 'yl02', 'sy01', 78),  -- Anaya in Second Year for 2024-2025 with score 78
       ('s004', 'yl02', 'sy01', 82),  -- Diya in Second Year for 2024-2025 with score 82
       ('s005', 'yl03', 'sy01', 88);  -- Kabir in Third Year for 2024-2025 with score 88

CREATE TABLE term (
    id CHAR(4) PRIMARY KEY,
    year_id CHAR(4),
    term_name VARCHAR(50),
    term_number INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (year_id) REFERENCES school_year(id)
);

INSERT INTO term (id, year_id, term_name, term_number, start_date, end_date) 
VALUES ('t001', 'sy01', 'Term 1', 1, '2024-08-01', '2024-11-30'),
       ('t002', 'sy01', 'Term 2', 2, '2025-01-01', '2025-04-30'),
       ('t003', 'sy02', 'Term 1', 1, '2023-08-01', '2023-11-30'),
       ('t004', 'sy02', 'Term 2', 2, '2024-01-01', '2024-04-30');
       
CREATE TABLE period (
    id CHAR(4) PRIMARY KEY,
    year_id CHAR(4),
    name VARCHAR(50),
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (year_id) REFERENCES school_year(id)
);

INSERT INTO period (id, year_id, name, start_time, end_time) 
VALUES ('p001', 'sy01', 'Morning Session', '08:00:00', '12:00:00'),
       ('p002', 'sy01', 'Afternoon Session', '13:00:00', '17:00:00'),
       ('p003', 'sy02', 'Morning Session', '08:30:00', '12:30:00'),
       ('p004', 'sy02', 'Afternoon Session', '13:30:00', '17:30:00');
       
CREATE TABLE class (
    id CHAR(4) PRIMARY KEY,
    subject_id CHAR(4),
    teacher_id CHAR(4),
    term_id CHAR(4),
    start_period_id CHAR(4),
    end_period_id CHAR(4),
    classroom_id CHAR(4),
    name VARCHAR(15),
    FOREIGN KEY (subject_id) REFERENCES subject(id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(id),
    FOREIGN KEY (term_id) REFERENCES term(id),
    FOREIGN KEY (start_period_id) REFERENCES period(id),
    FOREIGN KEY (end_period_id) REFERENCES period(id),
    FOREIGN KEY (classroom_id) REFERENCES classroom(id)
);

INSERT INTO class (id, subject_id, teacher_id, term_id, start_period_id, end_period_id, classroom_id, name) 
VALUES 
    ('c001', 's001', 't001', 't001', 'p001', 'p002', 'r001', 'CS101'),  -- Computer Science Class
    ('c002', 's002', 't002', 't001', 'p001', 'p002', 'r002', 'EE101'),  -- Electrical Engineering Class
    ('c003', 's003', 't003', 't001', 'p001', 'p002', 'r003', 'ME101'),  -- Mechanical Engineering Class
    ('c004', 's004', 't004', 't002', 'p001', 'p002', 'r004', 'BT101'),  -- Biotechnology Class
    ('c005', 's005', 't005', 't002', 'p001', 'p002', 'r001', 'PHY101'); -- Physics Class

CREATE TABLE student_class (
    student_id CHAR(4),
    class_id CHAR(4),
    score CHAR(4),
    PRIMARY KEY (student_id, class_id),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (class_id) REFERENCES class(id)
);

INSERT INTO student_class (student_id, class_id, score) 
VALUES 
    ('s001', 'c001', '85'),
    ('s002', 'c002', '90'),
    ('s003', 'c003', '88'),
    ('s004', 'c004', '92'),
    ('s005', 'c005', '80');