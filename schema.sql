CREATE TABLE courses (
  id serial PRIMARY KEY,
  course_number text UNIQUE NOT NULL,
  name text NOT NULL,
  ruby boolean NOT NULL,
  javascript boolean NOT NULL,
  phase text NOT NULL
);

INSERT INTO courses (course_number, name, ruby, javascript, phase) VALUES
  ('LS95', 'Orientation', true, true, 'preparatory'),
  ('RB100', 'Programming and Back-end Prep', true, false, 'preparatory'),
  ('JS100', 'Programming and Back-end Prep with Javascript', false, true, 'preparatory'),
  ('RB101', 'Programming Foundations', true, false, 'back-end'),
  ('RB109', 'Assessment: Ruby and General Programming', true, false, 'back-end'),
  ('JS101', 'Programming Foundations with JavaScript', false, true, 'back-end'),
  ('JS109', 'Assessment: Programming Foundations with JavaScript', false, true, 'back-end'),
  ('RB120', 'Object Oriented Programming', true, false, 'back-end'),
  ('RB129', 'Assessment: Object Oriented Programming', true, false, 'back-end'),
  ('JS120', 'Object Oriented Programming with JavaScript', false, true, 'back-end'),
  ('JS129', 'Assessment: Object Oriented Programming with JavaScript', false, true, 'back-end'),
  ('RB130', 'Ruby Foundations: More Topics', true, false, 'back-end'),
  ('RB139', 'Assessment: Ruby Foundations More Topics', true, false, 'back-end'),
  ('JS130', 'More JavaScript Foundations', false, true, 'back-end'),
  ('JS139', 'Assessment: More JavaScript Foundations', false, true, 'back-end'),
  ('LS170', 'Networking Foundations', true, true, 'back-end'),
  ('LS171', 'Assessment: Networking Foundations', true, true, 'back-end'),
  ('RB175', 'Networked Applications', true, false, 'back-end'),
  ('JS175', 'Networked Applications with JavaScript', false, true, 'back-end'),
  ('LS180', 'Database Foundations', true, true, 'back-end'),
  ('LS181', 'Assessment: Database Foundations', true, true, 'back-end'),
  ('RB185', 'Database Applications', true, false, 'back-end'),
  ('JS185', 'Database Applications with JavaScript', false, true, 'back-end'),
  ('RB189', 'Assessment: Networked and Database Applications with Ruby', true, false, 'back-end'),
  ('JS189', 'Assessment: Networked and Database Applications with JavaScript', false, true, 'back-end'),
  ('LS202', 'HTML and CSS', true, true, 'front-end'),
  ('JS210', 'Fundamentals of JavaScript for Programmers', true, false, 'front-end'),
  ('JS211', 'Assessment: Fundamentals of JavaScript for Programmers', true, false, 'front-end'),
  ('LS215', 'Computational Thinking and Problem Solving', true, true, 'front-end'),
  ('LS216', 'Assessment: Computational Thinking and Problem Solving', true, true, 'front-end'),
  ('JS225', 'Object Oriented JavaScript', true, false, 'front-end'),
  ('JS229', 'Assessment: Object Oriented JavaScript', true, false, 'front-end'),
  ('JS230', 'DOM and Asynchronous Programming with JavaScript', true, true, 'front-end'),
  ('JS239', 'Assessment: DOM and Asynchronous Programming with JavaScript', true, true, 'front-end'),
  ('RB299', 'Core Curriculum Diagnostic Test for Ruby', true, false, 'front-end');
  
CREATE TABLE timelog (
  id serial PRIMARY KEY,
  "date" date NOT NULL DEFAULT CURRENT_DATE,
  course text,
  lesson text,
  hours decimal(5,2),
  notes text
);

CREATE TABLE benchmarks (
  id serial PRIMARY KEY,
  course_id int NOT NULL REFERENCES courses (id),
  fast int NOT NULL,
  moderate int NOT NULL,
  slow int NOT NULL
);

INSERT INTO benchmarks (course_id, fast, moderate, slow) VALUES
  (1, ),
  (2, ),
  (3, ),
  (4, ),
  (5, ),
  (6, ),
  (7, ),
  (8, ),
  (9, ),
  (10, ),
  (11, ),
  (12, ),
  (13, ),
  (14, ),
  (15, ),
  (16, ),
  (17, ),
  (18, ),
  (19, ),
  (20, ),
  (21, ),
  (22, ),
  (23, ),
  (24, ),
  (25, ),
  (26, ),
  (27, ),
  (28, ),
  (29, ),
  (30, ),
  (31, ),
  (32, ),
  (33, ),
  (34, ),
  (35, );
  
  
Prep
LS95 11, 23, 39
JS100	9	42	72
Back-end							
JS101	200	233	265
JS120	84	107	142
JS130	73	80	100
LS170	12	31	58
JS175	22	31	42
LS180	32	51	111
JS185	16	20	25
Project	28	42	57
JS189	15	22	35
Front-end
LS202	7	48	96
LS215	32	62	84
JS230	89	141	186

Prep										
LS95	14	30	52
RB100	30	50	75
Back-end										
RB101	134	200	289
RB120	85	117	163
RB130	55	88	155
LS170	16	41	76
RB175	40	74	123
LS180	42	67	146
RB185	8	20	46
Project 36	55	75
RB189	20	50	80
Front-end										
LS202	15	63	127
JS210	41	102	167
LS215	42	82	111
JS225	13	82	145
JS230	116	186	244

