DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    info JSON
);

-- Insert sample JSON data
INSERT INTO users (info) VALUES
    ('{"name": "Alice", "age": 25, "skills": ["Python", "SQL"]}'),
    ('{"name": "Bob", "age": 30, "skills": ["Django", "Flask"]}'),
    ('{"name": "Charlie", "age": 28, "skills": ["JavaScript", "React"]}'),
    ('{"name": "David", "age": 35, "skills": ["Java", "Spring"]}'),
    ('{"name": "Emma", "age": 27, "skills": ["Python", "Data Science"]}'),
    ('{"name": "Frank", "age": 40, "skills": ["C++", "Embedded Systems"]}'),
    ('{"name": "Grace", "age": 22, "skills": ["HTML", "CSS", "JavaScript"]}'),
    ('{"name": "Henry", "age": 29, "skills": ["SQL", "PostgreSQL"]}'),
    ('{"name": "Ivy", "age": 31, "skills": ["R", "Statistics"]}'),
    ('{"name": "Jack", "age": 26, "skills": ["Go", "Microservices"]}'),
    ('{"name": "Karen", "age": 34, "skills": ["Rust", "System Programming"]}'),
    ('{"name": "Leo", "age": 24, "skills": ["TypeScript", "Angular"]}'),
    ('{"name": "Mia", "age": 32, "skills": ["Kotlin", "Android Development"]}'),
    ('{"name": "Nathan", "age": 23, "skills": ["Swift", "iOS Development"]}'),
    ('{"name": "Olivia", "age": 36, "skills": ["Perl", "Scripting"]}'),
    ('{"name": "Paul", "age": 33, "skills": ["Machine Learning", "TensorFlow"]}'),
    ('{"name": "Quinn", "age": 27, "skills": ["Shell Scripting", "Linux"]}'),
    ('{"name": "Rachel", "age": 29, "skills": ["Vue.js", "Frontend Development"]}'),
    ('{"name": "Sam", "age": 38, "skills": ["PHP", "Laravel"]}'),
    ('{"name": "Tina", "age": 21, "skills": ["C#", ".NET"]}');

SELECT * FROM users;