CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    name_department VARCHAR(30)
);

CREATE TABLE subject (
    subject_id SERIAL PRIMARY KEY,
    name_subject VARCHAR(30)
);

CREATE TABLE programs (
    program_id SERIAL PRIMARY KEY,
    name_program VARCHAR(50),
    department_id INT,
    plan INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE CASCADE
);

CREATE TABLE enrollee (
    enrollee_id SERIAL PRIMARY KEY,
    name_enrollee VARCHAR(50)
);

CREATE TABLE achievement (
    achievement_id SERIAL PRIMARY KEY,
    name_achievement VARCHAR(30),
    bonus INT
);

CREATE TABLE enrollee_achievement (
    enrollee_achievement_id SERIAL PRIMARY KEY,
    enrollee_id INT,
    achievement_id INT,
    FOREIGN KEY (enrollee_id) REFERENCES enrollee(enrollee_id) ON DELETE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES achievement(achievement_id) ON DELETE CASCADE
);

CREATE TABLE programs_subject (
    program_subject_id SERIAL PRIMARY KEY,
    program_id INT,
    subject_id INT,
    min_score INT,
    FOREIGN KEY (program_id) REFERENCES program(program_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id) ON DELETE CASCADE
);

CREATE TABLE programs_enrollee (
    program_enrollee_id SERIAL PRIMARY KEY,
    program_id INT,
    enrollee_id INT,
    FOREIGN KEY (program_id) REFERENCES program(program_id) ON DELETE CASCADE,
    FOREIGN KEY (enrollee_id) REFERENCES enrollee(enrollee_id) ON DELETE CASCADE
);

CREATE TABLE enrollee_subject (
    enrollee_subject_id SERIAL PRIMARY,
    enrollee_id INT,
    subject_id INT,
    score INT,
    FOREIGN KEY (enrollee_id) REFERENCES enrollee(enrollee_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id) ON DELETE CASCADE
);

