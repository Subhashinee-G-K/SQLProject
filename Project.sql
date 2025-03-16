create database besant;
use besant;
-- 1. Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255),
    user_type ENUM('JobSeeker', 'Employer') -- Differentiates between job seekers and employers
);

-- 2. Job Seekers Profile Table
CREATE TABLE job_seekers (
    seeker_id INT PRIMARY KEY auto_increment,
    user_id INT,
    resume TEXT,
    skills VARCHAR(255),
    experience INT, -- years of experience
    education VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 3. Employers Profile Table
CREATE TABLE employers (
    employer_id INT PRIMARY KEY auto_increment,
    user_id INT,
    company_name VARCHAR(255),
    company_address TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 4. Jobs Table

CREATE TABLE jobs (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    employer_id INT,
    job_title VARCHAR(255),
    job_description TEXT,
    job_type ENUM('Full-time', 'Part-time', 'Contract'),
    location VARCHAR(255),
    salary_range VARCHAR(100),
    post_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employer_id) REFERENCES employers(employer_id)
);

-- 5. Job Applications Table

CREATE TABLE job_applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    seeker_id INT,
    application_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Shortlisted', 'Rejected', 'Hired') DEFAULT 'Pending',
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (seeker_id) REFERENCES job_seekers(seeker_id)
);

-- 6. Job Seeker Skills Table

CREATE TABLE seeker_skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    seeker_id INT,
    skill_name VARCHAR(100),
    FOREIGN KEY (seeker_id) REFERENCES job_seekers(seeker_id)
);

-- 7. Admin Table

CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 1. Register a Job Seeker
INSERT INTO users (first_name, last_name, email, phone, password, user_type) 
VALUES ('John', 'Doe', 'john.doe@example.com', '555-1234', 'password123', 'JobSeeker');
INSERT INTO users (first_name, last_name, email, phone, password, user_type) 
VALUES 
('Alice', 'Johnson', 'alice.johnson@example.com', '555-5670', 'securepass1', 'JobSeeker'),
('Robert', 'Brown', 'robert.brown@example.com', '555-6789', 'strongpass2', 'JobSeeker'),
('Emily', 'Davis', 'emily.davis@example.com', '555-7890', 'password456', 'JobSeeker'),
('Michael', 'Wilson', 'michael.wilson@example.com', '555-8901', 'hashedpass3', 'JobSeeker'),
('Sophia', 'Anderson', 'sophia.anderson@example.com', '555-9012', 'mypassword', 'JobSeeker'),
('David', 'Martinez', 'david.martinez@techfirm.com', '555-1235', 'employerpass1', 'Employer'),
('Olivia', 'Garcia', 'olivia.garcia@startup.com', '555-2346', 'employerpass2', 'Employer'),
('James', 'Miller', 'james.miller@corporate.com', '555-3457', 'employerpass3', 'Employer');


-- Getting the user_id of the newly registered job seeker
SET @user_id = LAST_INSERT_ID();

INSERT INTO job_seekers (user_id, resume, skills, experience, education) 
VALUES (@user_id, 'Link to resume.pdf', 'Java, Python', 5, 'Bachelors in Computer Science');
INSERT INTO job_seekers (user_id, resume, skills, experience, education) 
VALUES (@user_id, 'Link to resume.pdf', 'C, Python', 3, 'Bachelors in Electrical and Electronics'),
(@user_id, 'Link to resume.pdf', 'C, Python', 4, 'Bachelors in Computer Science'),
(@user_id, 'Link to resume.pdf', 'Java, C, Python', 2, 'Bachelors in Computer Science'),
(@user_id, 'Link to resume.pdf', 'Java, C, SQL', 3, 'Bachelors in Information Technology'),
(@user_id, 'Link to resume.pdf', 'Java, Python, HTML', 5, 'Bachelors in Computer Science'),
(@user_id, 'Link to resume.pdf', 'Python', 1, 'Bachelors in Computer Science'),
(@user_id, 'Link to resume.pdf', 'Java, Python', 6, 'Bachelors in Artificial Intelligence and Data Science'),
(@user_id, 'Link to resume.pdf', 'Java, Python', 2, 'Bachelors in Artificial Intelligence and Data Science');

-- 2. Register an Employer

INSERT INTO users (first_name, last_name, email, phone, password, user_type) 
VALUES ('Jane', 'Smith', 'jane.smith@company.com', '555-5678', 'employerpass', 'Employer');
INSERT INTO users (first_name, last_name, email, phone, password, user_type)  
VALUES  
    ('Liam', 'Walker', 'liam.walker@example.com', '555-1111', 'securePass4', 'JobSeeker'),  
    ('Charlotte', 'Harris', 'charlotte.harris@example.com', '555-2222', 'charliePass', 'JobSeeker'),  
    ('Benjamin', 'Clark', 'benjamin.clark@example.com', '555-3333', 'benPass99', 'JobSeeker'),  
    ('Ava', 'Lewis', 'ava.lewis@example.com', '555-4444', 'avaSecure', 'JobSeeker'),  
    ('Ethan', 'Young', 'ethan.young@example.com', '555-5555', 'ethanPass321', 'JobSeeker'),  
    ('William', 'Hall', 'william.hall@business.com', '555-6666', 'employerSecure1', 'Employer'),  
    ('Isabella', 'Allen', 'isabella.allen@startup.com', '555-7777', 'employerSecure2', 'Employer'),  
    ('Henry', 'Scott', 'henry.scott@enterprise.com', '555-8888', 'enterprisePass', 'Employer');  


-- Getting the user_id of the newly registered employer
SET @user_id = LAST_INSERT_ID();

INSERT INTO employers (user_id, company_name, company_address) 
VALUES (@user_id, 'TechCorp', '123 Tech Street, Silicon Valley');
INSERT INTO employers (user_id, company_name, company_address) 
VALUES (@user_id, 'TCS', 'Perungudi'),
(@user_id, 'ZOHO', 'Gopalapuram'),
(@user_id, 'Wipro', 'Ahmedabad'),
(@user_id, 'ZEMOSO', '453 Tech Street,Hyderabad'),
(@user_id, 'CTS', 'DLF, Chennai'),
(@user_id, 'TCS', 'SIPCOT Tech Park, Siruseri'),
(@user_id, 'SONCOM', 'Gandhi Street, Kazhipattur'),
(@user_id, 'ACCENTURE', 'Laxmi Nagar, Shollinganallur');

-- 3. Post a Job by Employer
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (1, 'Software Developer', 'Develop and maintain web applications', 'Full-time', 'Remote', '$60,000 - $80,000');
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (2, 'Full Stack Developer', 'responsible for working on both front-end and back-end development processes.', 'Full-time', 'Remote', '$50,000 - $90,000');
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (3, 'SQL Developer', 'develop and manage SQL databases ', 'Part-time', 'Remote', '$30,000 - $60,000');
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (4, 'Software Tester', 'responsible for designing and running tests on software usability.', 'Part-time', 'Remote', '$40,000 - $80,000');
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (5, 'Software Developer', 'Develop and maintain web applications', 'Full-time', 'Remote', '$60,000 - $80,000');
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (6, 'Software Tester', 'responsible for designing and running tests on software usability.', 'Part-time', 'Remote', '$40,000 - $60,000');
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (7, 'Full Stack Developer', 'responsible for working on both front-end and back-end development processes.', 'Full-time', 'Remote', '$60,000 - $90,000');
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (8, 'UI/UX Designer', 'gathering user requirements, designing graphic elements, and developing navigation components.', 'Contract', 'Remote', '$40,000 - $70,000');
INSERT INTO jobs (employer_id, job_title, job_description, job_type, location, salary_range)
VALUES (9, 'UI/UX Designer', 'gathering user requirements, designing graphic elements, and developing navigation components.', 'Contract', 'Remote', '$40,000 - $70,000');


select * from jobs;
select * from job_seekers;
select * from users;

-- 4. Job Seeker Applying for a Job
INSERT INTO job_applications (job_id, seeker_id)
VALUES (1, 1);
INSERT INTO job_applications (job_id, seeker_id)
VALUES (1, 2);
INSERT INTO job_applications (job_id, seeker_id)
VALUES 
    (17, 1),
    (18, 2),
    (19, 3),
    (20, 4),
    (21, 5),
    (22, 6),
    (23, 7),
    (24, 8),
    (1, 9);

-- 5. Get Jobs for Job Seekers Based on Location
SELECT job_title, job_description, location, salary_range 
FROM jobs 
WHERE location = 'Remote';

-- 6. Get Applications for a Specific Job (Employer)
SELECT u.first_name, u.last_name, a.status
FROM job_applications a
JOIN job_seekers js ON a.seeker_id = js.seeker_id
JOIN users u ON js.user_id = u.user_id
WHERE a.job_id = 1;

-- 7. Admin View All Job Postings
SELECT * FROM jobs WHERE job_title LIKE '%Developer' AND location ="remote" AND 
salary_range between '$40000' and '$80000' and job_type = 'Full-time';

-- Search Functionality:
-- 1.Job Seekers: Implement a job search based on keywords, location, salary, job type, etc.
SELECT 
    jobs.job_title, 
    jobs.job_description, 
    jobs.job_type, 
    jobs.location, 
    jobs.salary_range, 
    employers.company_name
FROM jobs
JOIN employers 
    ON jobs.employer_id = employers.employer_id
WHERE 
    (jobs.salary_range LIKE '%60,000%' OR jobs.salary_range LIKE '%80,000%') 
    AND jobs.job_type = 'Full-time';

-- 2.Employers: Ability to search and filter job seekers based on skills, experience, and education.
SELECT 
    users.first_name, 
    users.last_name, 
    job_seekers.skills, 
    job_seekers.experience, 
    job_seekers.education
FROM users 
JOIN job_seekers 
    ON users.user_id = job_seekers.user_id where (job_seekers.skills like '%Python%' or job_seekers.skills like '%Java%' ) 
    and (job_seekers.experience > 1) and (job_seekers.education like '%Computer%');

-- Application Status Updates:
-- 3.Employers can update the status of job applications (e.g., Shortlisted, Rejected, Hired).
UPDATE job_applications 
SET status = 'Hired' 
WHERE job_id = 17 AND seeker_id IN (1, 2);  
UPDATE job_applications 
SET status = 'Shortlisted' 
WHERE job_id = 20 AND seeker_id IN (4, 5);  
UPDATE job_applications 
SET status = 'Rejected' 
WHERE application_id IN (8, 9);  

-- Admin Dashboard:
-- 4.Admin can manage job seekers, employers, and job postings (approve/reject job posts, block/unblock users).
ALTER TABLE jobs ADD COLUMN post_status ENUM('Approved', 'Rejected') DEFAULT 'Approved';
UPDATE jobs 
SET post_status = 'Rejected' 
WHERE employer_id IN (8, 9);
ALTER TABLE jobs ADD COLUMN account_status ENUM('Accepted', 'Blocked') DEFAULT 'Accepted';
UPDATE jobs 
SET account_status = 'Blocked' 
WHERE employer_id IN (8, 9);

-- Notifications:
-- 5.Email or system notifications for job seekers when their application status changes or when a new job is posted.
-- Create notifications table
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT,
    status ENUM('unread', 'read') DEFAULT 'unread',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO notifications (user_id, message) 
SELECT job_seekers.user_id, CONCAT('Your application status is now ', job_applications.status)
FROM job_applications 
JOIN job_seekers ON job_applications.seeker_id = job_seekers.seeker_id
WHERE application_id = 2;

UPDATE notifications SET status = 'read' WHERE user_id = 2;

SELECT * FROM notifications WHERE user_id = 2 AND status = 'read';

-- User Authentication and Authorization:
-- 6.Job seekers and employers can log in using their credentials, and each will have different views and permissions.
-- Modify the column type to store file paths as TEXT instead of BLOB
SELECT 
    first_name, 
    user_type, 
    CASE 
        WHEN password = 'john123' THEN 'user exist' 
        ELSE 'no user' 
    END AS users
FROM users
WHERE first_name = 'John';

SELECT 
    first_name, 
    user_type, 
    CASE 
        WHEN first_name = 'David' THEN 'user exist' 
        ELSE 'no user' 
    END AS users
FROM users
WHERE first_name = 'David' AND user_type = 'Employer';

-- Resume Upload:
-- 7.Allow job seekers to upload their resumes (PDF, DOCX formats).
ALTER TABLE job_seekers MODIFY COLUMN resume TEXT;

UPDATE job_seekers SET resume = 'E:\Subha_RESUME.pdf' WHERE user_id = 1;
UPDATE job_seekers SET resume = 'E:\Resume.docx' WHERE user_id = 3;
UPDATE job_seekers SET resume = 'E:\Besant_Resume.docx' WHERE user_id = 5;
UPDATE job_seekers SET resume = 'E:\Subha_RESUME_TCS.pdf' WHERE user_id = 7;

SELECT * FROM job_seekers;

-- Ratings and Reviews:
-- 8.Employers can rate job seekers after hiring, and job seekers can review employers.
CREATE TABLE employer_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    employer_id INT,  -- Who is reviewing?
    seeker_id INT,  -- Who is being reviewed?
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employer_id) REFERENCES employers(employer_id),
    FOREIGN KEY (seeker_id) REFERENCES job_seekers(seeker_id)
);
CREATE TABLE job_seeker_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    seeker_id INT,  -- Who is reviewing?
    employer_id INT,  -- Who is being reviewed?
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (seeker_id) REFERENCES job_seekers(seeker_id),
    FOREIGN KEY (employer_id) REFERENCES employers(employer_id)
);

INSERT INTO employer_reviews (employer_id, seeker_id, rating, review)
VALUES (1, 3, 5, 'Great worker, very professional!');

INSERT INTO employer_reviews (employer_id, seeker_id, rating, review) 
VALUES (2, 5, 4, 'Good communication and technical skills.');

INSERT INTO employer_reviews (employer_id, seeker_id, rating, review) 
VALUES (3, 7, 3, 'Decent performance, but needs improvement in deadlines.');

INSERT INTO employer_reviews (employer_id, seeker_id, rating, review) 
VALUES (4, 2, 5, 'Excellent work, very professional and skilled.');

INSERT INTO employer_reviews (employer_id, seeker_id, rating, review) 
VALUES (5, 6, 2, 'Lacks consistency and needs better time management.');

INSERT INTO employer_reviews (employer_id, seeker_id, rating, review) 
VALUES (1, 8, 4, 'Strong technical skills, but can improve soft skills.');

-- job seeker's review on employers
INSERT INTO job_seeker_reviews (seeker_id, employer_id, rating, review)
VALUES (3, 1, 4, 'Good company but could improve communication.');

INSERT INTO job_seeker_reviews (seeker_id, employer_id, rating, review)
VALUES (5, 2, 5, 'Great work environment and supportive team.');

INSERT INTO job_seeker_reviews (seeker_id, employer_id, rating, review)
VALUES (7, 3, 3, 'Decent company but needs better project management.');

INSERT INTO job_seeker_reviews (seeker_id, employer_id, rating, review)
VALUES (2, 4, 4, 'Good pay and benefits, but work-life balance can be improved.');

INSERT INTO job_seeker_reviews (seeker_id, employer_id, rating, review)
VALUES (6, 5, 2, 'Poor management and long working hours.');

INSERT INTO job_seeker_reviews (seeker_id, employer_id, rating, review)
VALUES (8, 1, 5, 'Amazing company with a lot of growth opportunities.');

select * from job_seeker_reviews;
select * from employer_reviews;


