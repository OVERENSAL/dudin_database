ALTER TABLE student ADD FOREIGN KEY (id_group) REFERENCES [group] (id_group)
ALTER TABLE lesson ADD FOREIGN KEY (id_group) REFERENCES [group] (id_group)
ALTER TABLE lesson ADD FOREIGN KEY (id_subject) REFERENCES [subject] (id_subject)
ALTER TABLE lesson ADD FOREIGN KEY (id_teacher) REFERENCES teacher (id_teacher)
ALTER TABLE mark ADD FOREIGN KEY (id_lesson) REFERENCES lesson (id_lesson)
ALTER TABLE mark ADD FOREIGN KEY (id_student) REFERENCES student (id_student)


CREATE VIEW inf_mark AS SELECT student.name, mark.mark FROM mark
	LEFT JOIN student ON student.id_student = mark.id_student
	LEFT JOIN lesson ON lesson.id_lesson = mark.id_lesson
	LEFT JOIN [subject] ON [subject].id_subject = lesson.id_subject
	WHERE [subject].name = 'Информатика'
GO
SELECT * FROM inf_mark GROUP BY name, mark

CREATE PROCEDURE debtors @id_group AS INT AS
SELECT student.name AS [student.name], subject.name AS [subject] FROM student
	INNER JOIN [group] ON [group].id_group = student.id_group
	INNER JOIN lesson ON lesson.id_group = [group].id_group
	LEFT JOIN mark ON mark.id_student = student.id_student AND mark.id_lesson = lesson.id_lesson
	INNER JOIN subject ON subject.id_subject = lesson.id_subject
	WHERE [group].id_group = @id_group
GROUP BY student.name, subject.name
HAVING COUNT(mark.mark) = 0
ORDER BY student.name
GO

DROP PROCEDURE debtors

EXECUTE debtors @id_group = 1
EXECUTE debtors @id_group = 2
EXECUTE debtors @id_group = 3
EXECUTE debtors @id_group = 4

SELECT [subject].name, AVG(mark.mark) AS average_mark FROM mark
	LEFT JOIN lesson ON lesson.id_lesson = mark.id_lesson
	LEFT JOIN student ON student.id_student = mark.id_student
	LEFT JOIN [subject] ON [subject].id_subject = lesson.id_subject
GROUP BY [subject].name
HAVING COUNT(student.id_student) >= 35

SELECT student.name, mark.mark, [subject].name, lesson.date FROM student
	LEFT JOIN [group] ON [group].id_group = student.id_group
	LEFT JOIN lesson ON lesson.id_group = [group].id_group
	LEFT JOIN [subject] ON [subject].id_subject = lesson.id_subject
	LEFT JOIN mark ON (mark.id_lesson = lesson.id_lesson AND mark.id_student = student.id_student)
	WHERE [group].name = 'ВМ'
ORDER BY student.name 

UPDATE mark 
SET mark = mark + 1 FROM mark
	LEFT JOIN lesson ON lesson.id_lesson = mark.id_lesson
	LEFT JOIN student ON student.id_student = mark.id_student
	LEFT JOIN [group] ON [group].id_group = student.id_group
	LEFT JOIN [subject] ON [subject].id_subject = lesson.id_subject
	WHERE [group].name = 'ПС' AND mark.mark < 5 AND [subject].name = 'БД' AND lesson.date < '2019-05-12'

CREATE NONCLUSTERED INDEX [IX_group_name] ON [group] (name)
CREATE NONCLUSTERED INDEX [IX_lesson_id_subject] ON lesson (id_subject)
CREATE NONCLUSTERED INDEX [IX_lesson_id_group] ON lesson (id_group)
CREATE NONCLUSTERED INDEX [IX_lesson_date] ON lesson (date)
CREATE NONCLUSTERED INDEX [IX_mark_id_lesson] ON mark (id_lesson)
CREATE NONCLUSTERED INDEX [IX_mark_id_student] ON mark (id_student)
CREATE NONCLUSTERED INDEX [IX_student_id_group] ON student (id_group)
CREATE NONCLUSTERED INDEX [IX_subject_name] ON [subject] (name)