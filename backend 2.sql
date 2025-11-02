-- Database Management System Mini Project Report: Student Management System
-- Sample Data Insertion (DML) and Dashboard Queries (ENHANCED DETAIL)

-- Ensure we are using the correct database
USE student_management_db;

-- =======================================================================
-- PART 1: Data Insertion (DML) - Increased Volume for Better Reporting
-- =======================================================================

-- 1. Insert Sample FACULTY Records
INSERT INTO FACULTY (faculty_id, name, email, department) VALUES
(501, 'Dr. Sarah Connor', 's.connor@uni.edu', 'Computer Science'),
(502, 'Prof. T. Baker', 't.baker@uni.edu', 'Mathematics'),
(503, 'Dr. Alice Sharma', 'a.sharma@uni.edu', 'Physics'),
(504, 'Dr. B. Singh', 'b.singh@uni.edu', 'Economics'); -- Added New Faculty

-- 2. Insert Sample COURSE Records
INSERT INTO COURSE (course_id, course_name, credits, department) VALUES
('CS101', 'Intro to Databases', 3, 'Computer Science'),
('MA203', 'Applied Calculus', 4, 'Mathematics'),
('PH102', 'Modern Physics', 3, 'Physics'),
('EC301', 'Microeconomics', 3, 'Economics'); -- Added New Course

-- 3. Link Courses to Faculty (COURSE_FACULTY)
INSERT INTO COURSE_FACULTY (course_id, faculty_id) VALUES
('CS101', 501),
('MA203', 502),
('PH102', 503),
('EC301', 504);

-- 4. Insert Sample STUDENT Records (Increased dataset size)
INSERT INTO STUDENT (student_id, name, email, phone_number, date_of_birth) VALUES
(101, 'Alice Johnson', 'alice@uni.edu', '555-0101', '2004-08-15'),
(105, 'Maximus Demos', 'max@uni.edu', '555-0105', '2003-11-20'),
(110, 'Ethan Hunt', 'e.hunt@uni.edu', '555-0110', '2005-01-01'),
(115, 'Jane Doe', 'jane.d@uni.edu', '555-0115', '2004-03-25'),      -- New Student
(120, 'Robert Smith', 'r.smith@uni.edu', '555-0120', '2003-05-10'); -- New Student

-- 5. Insert Sample GRADE Records (More comprehensive assessment data)
INSERT INTO GRADE (student_id, course_id, assessment_type, marks, max_marks) VALUES
-- Alice Johnson (ID 101) - High Performer
(101, 'CS101', 'Midterm', 85, 100),
(101, 'CS101', 'Final', 92, 100),
(101, 'MA203', 'Midterm', 90, 100),
(101, 'PH102', 'Final Exam', 78, 100),

-- Maximus Demos (ID 105) - Average Performer
(105, 'CS101', 'Midterm', 72, 100),
(105, 'CS101', 'Final', 80, 100),
(105, 'MA203', 'Midterm', 80, 100),
(105, 'PH102', 'Midterm', 70, 100),

-- Ethan Hunt (ID 110) - High Performer
(110, 'CS101', 'Midterm', 95, 100),
(110, 'MA203', 'Final', 88, 100),
(110, 'EC301', 'Midterm', 92, 100),

-- Jane Doe (ID 115) - New Enrollment
(115, 'MA203', 'Midterm', 75, 100),
(115, 'EC301', 'Midterm', 80, 100),

-- Robert Smith (ID 120) - Under Performer (Low Grade Example)
(120, 'CS101', 'Midterm', 55, 100),
(120, 'PH102', 'Final Exam', 60, 100);

-- 6. Insert Sample ATTENDANCE Records (Simulating 10 sessions for CS101 and 8 for MA203)
-- This allows for more realistic percentage calculation.
INSERT INTO ATTENDANCE (student_id, course_id, date, status) VALUES
-- CS101 Sessions (10 total sessions)
(101, 'CS101', '2025-11-01', 'Present'), (101, 'CS101', '2025-11-02', 'Present'), (101, 'CS101', '2025-11-03', 'Present'), (101, 'CS101', '2025-11-04', 'Present'),
(101, 'CS101', '2025-11-05', 'Present'), (101, 'CS101', '2025-11-06', 'Present'), (101, 'CS101', '2025-11-07', 'Present'), (101, 'CS101', '2025-11-08', 'Absent'),
(101, 'CS101', '2025-11-09', 'Present'), (101, 'CS101', '2025-11-10', 'Present'), -- Alice: 9/10 = 90%

(105, 'CS101', '2025-11-01', 'Absent'), (105, 'CS101', '2025-11-02', 'Present'), (105, 'CS101', '2025-11-03', 'Absent'), (105, 'CS101', '2025-11-04', 'Present'),
(105, 'CS101', '2025-11-05', 'Present'), (105, 'CS101', '2025-11-06', 'Absent'), (105, 'CS101', '2025-11-07', 'Present'), (105, 'CS101', '2025-11-08', 'Present'),
(105, 'CS101', '2025-11-09', 'Present'), (105, 'CS101', '2025-11-10', 'Present'), -- Maximus: 7/10 = 70% (Low Attendance Example)

-- MA203 Sessions (8 total sessions)
(101, 'MA203', '2025-11-01', 'Present'), (101, 'MA203', '2025-11-02', 'Present'), (101, 'MA203', '2025-11-03', 'Present'), (101, 'MA203', '2025-11-04', 'Present'),
(101, 'MA203', '2025-11-05', 'Present'), (101, 'MA203', '2025-11-06', 'Present'), (101, 'MA203', '2025-11-07', 'Present'), (101, 'MA203', '2025-11-08', 'Present'); -- Alice: 8/8 = 100%


-- =======================================================================
-- PART 2: Dashboard and Reporting Queries (SELECT & Views) - Enhanced
-- =======================================================================

-- Query 1: Create the Student_Performance_View (for simplified dashboard data access)
-- This view consolidates student name, course name, and marks. (Kept for consistency)
CREATE OR REPLACE VIEW Student_Performance_View AS
SELECT 
    S.student_id, 
    S.name AS student_name, 
    C.course_name, 
    G.marks, 
    G.assessment_type
FROM 
    STUDENT S
JOIN 
    GRADE G ON S.student_id = G.student_id
JOIN 
    COURSE C ON G.course_id = C.course_id;

-- Query 2: Display Consolidated Results for Alice Johnson (Student_ID 101)
-- Used by the student dashboard to show all grades.
SELECT *
FROM Student_Performance_View
WHERE student_id = 101;

-- Query 3: Display Average Grade Across All Courses for a Student (Dashboard Metric)
SELECT
    S.name,
    TRUNCATE(AVG(G.marks), 2) AS overall_average_marks
FROM
    STUDENT S
JOIN
    GRADE G ON S.student_id = G.student_id
WHERE
    S.student_id = 105 -- Maximus Demos
GROUP BY
    S.name;

-- Query 4: Display Attendance Summary for all students in CS101 (Admin Report/Detailed View)
SELECT
    S.student_id,
    S.name,
    COUNT(A.atten_id) AS classes_held,
    SUM(CASE WHEN A.status = 'Present' THEN 1 ELSE 0 END) AS classes_attended,
    TRUNCATE((SUM(CASE WHEN A.status = 'Present' THEN 1 ELSE 0 END) / COUNT(A.atten_id)) * 100, 2) AS attendance_percentage
FROM
    STUDENT S
JOIN
    ATTENDANCE A ON S.student_id = A.student_id
WHERE
    A.course_id = 'CS101'
GROUP BY
    S.student_id, S.name;

-- Query 5 (NEW): Top-Performing Student (Highest Overall Average Mark)
-- Useful for generating academic honor rolls (Admin Report).
SELECT
    S.student_id,
    S.name,
    TRUNCATE(AVG(G.marks), 2) AS overall_average
FROM
    STUDENT S
JOIN
    GRADE G ON S.student_id = G.student_id
GROUP BY
    S.student_id, S.name
ORDER BY
    overall_average DESC
LIMIT 1;

-- Query 6 (NEW): Identify Students for Administrative Intervention (Low Attendance)
-- Finds students whose attendance in ANY course is below 80%.
SELECT
    S.student_id,
    S.name,
    C.course_name,
    TRUNCATE((SUM(CASE WHEN A.status = 'Present' THEN 1 ELSE 0 END) / COUNT(A.atten_id)) * 100, 2) AS attendance_percentage
FROM
    STUDENT S
JOIN
    ATTENDANCE A ON S.student_id = A.student_id
JOIN
    COURSE C ON A.course_id = C.course_id
GROUP BY
    S.student_id, S.name, C.course_name
HAVING
    attendance_percentage < 80;

-- Query 7 (NEW): Course Performance Summary (Academic Report)
-- Calculates the average mark and student count for the 'Intro to Databases' course (CS101).
SELECT
    C.course_name,
    COUNT(DISTINCT G.student_id) AS total_students_graded,
    TRUNCATE(AVG(G.marks), 2) AS course_average_mark
FROM
    COURSE C
JOIN
    GRADE G ON C.course_id = G.course_id
WHERE
    C.course_id = 'CS101'
GROUP BY
    C.course_name;
