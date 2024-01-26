USE master
GO
CREATE DATABASE ByteScholarFinal
GO
USE ByteScholarFinal
GO

-----------------------------------------standalone tables-----------------------------------------
CREATE TABLE [Role]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL unique,
);
ALTER TABLE [Role] ADD PRIMARY KEY (id);
-----------------------------------------

-----------------------------------------
CREATE TABLE [Major]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL unique,
	[image] [nvarchar](max) NULL,
);
ALTER TABLE [Major] ADD PRIMARY KEY (id);
-----------------------------------------
CREATE TABLE [Level]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL unique,
);
ALTER TABLE [Level] ADD PRIMARY KEY (id);
-----------------------------------------
CREATE TABLE [Tag]
(
	[id] [int] identity(1,1),
	[name] [nvarchar](150)
)
ALTER TABLE [Tag] ADD PRIMARY KEY (id);
-----------------------------------------
CREATE TABLE [Account]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL UNIQUE,
	[password] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL,
	[gender] [bit] NULL,
	[dob] [date] NULL,
	[phone_number] [nchar](20) NULL,
	[avatar] [nvarchar](max) NULL,
	[country] [nvarchar](50) NULL,
	[wallet] [money] NULL,
	[is_available] [bit] NULL,
	[created_date] [date] NULL,
);
ALTER TABLE [Account] ADD PRIMARY KEY (id);
-----------------------------------------
CREATE TABLE [AccountPremium]
(
	[account_id] [int] NOT NULL UNIQUE,
	[expired_date] [date] NOT NULL,
);
ALTER TABLE [AccountPremium] ADD PRIMARY KEY (account_id);
ALTER TABLE [AccountPremium] ADD FOREIGN KEY (account_id) REFERENCES [Account](id);
-----------------------------------------
CREATE TABLE [Course]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](500) NOT NULL UNIQUE,
	[price] [money] NULL,
	[discount] [money] NULL,
	[image] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[created_date] [date] NULL,
	[updated_date] [date] NULL,
	[major_id] [int] NULL,
	[level_id] [int] NULL,
	[creator_id] [int] NULL,
);
ALTER TABLE [Course] ADD PRIMARY KEY (id);
ALTER TABLE [Course] ADD FOREIGN KEY (major_id) REFERENCES [Major](id) ON DELETE SET NULL;
ALTER TABLE [Course] ADD FOREIGN KEY (level_id) REFERENCES [Level](id) ON DELETE SET NULL;
ALTER TABLE [Course] ADD FOREIGN KEY (creator_id) REFERENCES [Account](id) ;
-----------------------------------------
CREATE TABLE [Transaction]
(
	[id] [int] IDENTITY(1,1) NOT NULL UNIQUE,
	[account_id] [int] NOT NULL,
	[created_time] [datetime] NOT NULL,
	[value] [money] NOT NULL,
	[note] [nvarchar](max) NULL,
);
ALTER TABLE [Transaction] ADD PRIMARY KEY (id);
ALTER TABLE [Transaction] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
-----------------------------------------
CREATE TABLE [Blog]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[creator_id] [int] NOT NULL,
	[thumbnail] nvarchar(max) NOT NULL,
	[title] nvarchar(500) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[created_date] [date] NOT NULL,
);
ALTER TABLE [Blog] ADD PRIMARY KEY (id);
ALTER TABLE [Blog] ADD FOREIGN KEY (creator_id) REFERENCES [Account](id) ;
-----------------------------------------
CREATE TABLE [Chapter]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NULL,
	[order] [int] NOT NULL,
	[name] [nvarchar](500) NULL,
);
ALTER TABLE [Chapter] ADD PRIMARY KEY (id);
ALTER TABLE [Chapter] ADD FOREIGN KEY (course_id) REFERENCES [Course](id) ;
-----------------------------------------
CREATE TABLE [Test]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](500) NOT NULL,
	[minutes] [int] NULL,
	[threshold] [DECIMAL](10, 2) NULL,
);
ALTER TABLE [Test] ADD PRIMARY KEY (id);
-----------------------------------------
CREATE TABLE [Lesson]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[chapter_id] [int] NULL,
	[order] [int] NOT NULL,
	[name] [nvarchar](500) NULL,
	[video_url] [varchar](max) NULL,
	[content] [nvarchar](max) NULL,
	[test_id] [int] NULL,
);
ALTER TABLE [Lesson] ADD PRIMARY KEY (id);
ALTER TABLE [Lesson] ADD FOREIGN KEY (test_id) REFERENCES [Test](id) ;
ALTER TABLE [Lesson] ADD FOREIGN KEY (chapter_id) REFERENCES [Chapter](id) ;
-----------------------------------------
CREATE TABLE [Quiz]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[test_id] [int] NOT NULL,
	[order] [int] NOT NULL,
	[question] [nvarchar](max) NOT NULL,
	[answer_a] [nvarchar](max) NULL,
	[answer_b] [nvarchar](max) NULL,
	[answer_c] [nvarchar](max) NULL,
	[answer_d] [nvarchar](max) NULL,
	[answer] [int] NOT NULL,
);
ALTER TABLE [Quiz] ADD PRIMARY KEY (id);
ALTER TABLE [Quiz] ADD FOREIGN KEY (test_id) REFERENCES [Test](id) ;
-----------------------------------------
CREATE TABLE [Event]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[creator_id] [int] NOT NULL,
	[content] [nvarchar](max) NULL,
	[discount] [money] NULL,
	[created_date] [date] NOT NULL,
	[expired_date] [date] NOT NULL,
);
ALTER TABLE [Event] ADD PRIMARY KEY (id);
ALTER TABLE [Event] ADD FOREIGN KEY (creator_id) REFERENCES [Account](id);
-----------------------------------------
CREATE TABLE [Alert]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NOT NULL,
	[created_date] [date] NULL,
	[content] [nvarchar](max) NULL
);
ALTER TABLE [Alert] ADD PRIMARY KEY (id);
ALTER TABLE [Alert] ADD FOREIGN KEY (account_id) REFERENCES [Account](id);
-----------------------------------------
CREATE TABLE [dbo].[PremiumPack](
    [id] [int] IDENTITY(1,1) NOT NULL,
    [name] [nvarchar](50) NOT NULL,
    [price] [money] NOT NULL,
    [value] [int] NOT NULL,
);
ALTER TABLE [PremiumPack] ADD PRIMARY KEY (id);

-----------------------------------------many-to-many tables-----------------------------------------
CREATE TABLE [AccountRole]
(
	[account_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
);
ALTER TABLE [AccountRole] ADD PRIMARY KEY (account_id, role_id);
ALTER TABLE [AccountRole] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
ALTER TABLE [AccountRole] ADD FOREIGN KEY (role_id) REFERENCES [Role](id) ;
-----------------------------------------

-----------------------------------------
CREATE TABLE [JoinCourse]
(
	[account_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
	[joined_date] [date] NULL,
	[passed_date] [date] NULL,
	[is_passed] [bit] NULL,
	[rating] [int] NULL,
);
ALTER TABLE [JoinCourse] ADD PRIMARY KEY (account_id, course_id);
ALTER TABLE [JoinCourse] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
ALTER TABLE [JoinCourse] ADD FOREIGN KEY (course_id) REFERENCES [Course](id) ;
-----------------------------------------
CREATE TABLE [CourseComment]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
	[comment] [nvarchar](max) NULL,
	[created_date] [date] NULL,
);
ALTER TABLE [CourseComment] ADD PRIMARY KEY (id);
ALTER TABLE [CourseComment] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
ALTER TABLE [CourseComment] ADD FOREIGN KEY (course_id) REFERENCES [Course](id) ;
-----------------------------------------
CREATE TABLE [LessonComment]
(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NULL,
	[account_id] [int] NOT NULL,
	[lesson_id] [int] NOT NULL,
	[comment] [nvarchar](max) NULL,
	[created_date] [date] NULL,
);
ALTER TABLE [LessonComment] ADD PRIMARY KEY (id);
ALTER TABLE [LessonComment] ADD FOREIGN KEY (parent_id) REFERENCES [LessonComment](id);
ALTER TABLE [LessonComment] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
ALTER TABLE [LessonComment] ADD FOREIGN KEY (lesson_id) REFERENCES [Lesson](id) ;
-----------------------------------------
CREATE TABLE [JoinChapter]
(
	[account_id] [int] NOT NULL,
	[chapter_id] [int] NOT NULL,
	[is_passed] [bit] NULL,
);
ALTER TABLE [JoinChapter] ADD PRIMARY KEY (account_id, chapter_id);
ALTER TABLE [JoinChapter] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
ALTER TABLE [JoinChapter] ADD FOREIGN KEY (chapter_id) REFERENCES [Chapter](id) ;
-----------------------------------------
CREATE TABLE [JoinLesson]
(
	[account_id] [int] NOT NULL,
	[lesson_id] [int] NOT NULL,
	[is_passed] [bit] NULL,
);
ALTER TABLE [JoinLesson] ADD PRIMARY KEY (account_id, lesson_id);
ALTER TABLE [JoinLesson] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
ALTER TABLE [JoinLesson] ADD FOREIGN KEY (lesson_id) REFERENCES [Lesson](id) ;
-----------------------------------------
CREATE TABLE [Grade]
(
	[account_id] [int] NOT NULL,
	[test_id] [int] NOT NULL,
	[score] [DECIMAL](10, 2) NULL,
	[submitted_time] [datetime] NULL,
	[is_passed] [bit] NULL,
);
ALTER TABLE [Grade] ADD PRIMARY KEY (account_id, test_id);
ALTER TABLE [Grade] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
ALTER TABLE [Grade] ADD FOREIGN KEY (test_id) REFERENCES [Test](id) ;
-----------------------------------------
CREATE TABLE [CommentBlog]
(
	[id] int identity(1,1),
	[parent_id] int NULL,
	[blog_id] int,
	[account_id] int,
	[content] nvarchar(4000),
	[created_date] date NOT NULL,
);
ALTER TABLE [CommentBlog] ADD PRIMARY KEY (id);
ALTER TABLE [CommentBlog] ADD FOREIGN KEY (parent_id) REFERENCES [CommentBlog](id);
ALTER TABLE [CommentBlog] ADD FOREIGN KEY (blog_id) REFERENCES [Blog](id) ;
ALTER TABLE [CommentBlog] ADD FOREIGN KEY (account_id) REFERENCES [Account](id) ;
-----------------------------------------
CREATE TABLE [TagBlog]
(
	[id] int identity(1,1),
	[blog_id] int,
	[tag_id] int,
);
ALTER TABLE [TagBlog] ADD PRIMARY KEY (id);
ALTER TABLE [TagBlog] ADD FOREIGN KEY (blog_id) REFERENCES [Blog](id) ;
ALTER TABLE [TagBlog] ADD FOREIGN KEY (tag_id) REFERENCES [Tag](id) ;
-----------------------------------------
CREATE TABLE [EventCourse]
(
	[event_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
);
ALTER TABLE [EventCourse] ADD PRIMARY KEY (event_id, course_id);
ALTER TABLE [EventCourse] ADD FOREIGN KEY (event_id) REFERENCES [Event](id);
ALTER TABLE [EventCourse] ADD FOREIGN KEY (course_id) REFERENCES [Course](id);

-----------------------------------------insert data-----------------------------------------
-----------------------------------------
INSERT INTO [PremiumPack] Values
('30 days pack', 200, 30),
('90 days pack', 600, 90),
('360 days pack', 2400, 360);
-----------------------------------------
INSERT INTO [Role] VALUES
('Admin'),
('Moderator'),
('CourseManager'),
('User'),
('Guest');
-----------------------------------------
INSERT INTO [Tag] VALUES
('History'),
('Book'),
('Life'),
('Sharing'),
('Technology'),
('Science'),
('Art'),
('Other');
-----------------------------------------
INSERT INTO [Major] VALUES
('Information Technology', 'https://i.ibb.co/1mM7ctH/it.jpg'),
('Chemical Engineering', 'https://i.ytimg.com/vi/RJeWKvQD90Y/maxresdefault.jpg'),
('Graphic Design','https://i.ibb.co/mCGKNsr/design.jpg'),
('Economic', 'https://i.ibb.co/Rc47zM6/eco.webp'),
('Literature', 'https://i.ibb.co/bBXTvsY/literature.jpg');
-----------------------------------------
INSERT INTO [Level] VALUES
('Beginner'),
('Common'),
('Intermediate'),
('Advanced'),
('Expert');
----------------------------------------- all accounts password are '123456'
INSERT INTO [Account] VALUES
('toan','e10adc3949ba59abbe56e057f20f883e', 'toanlkhe176133@gmail.com','Le', 'Toan', 1, CAST(N'2006-12-12' AS Date),'0999999999',
'https://t4.ftcdn.net/jpg/04/08/24/43/360_F_408244382_Ex6k7k8XYzTbiXLNJgIL8gssebpLLBZQ.jpg', 'Vietnam', 10000, 1, '2022-03-12'),
('nhucdaukhau','e10adc3949ba59abbe56e057f20f883e', 'hieulmhe171617@fpt.edu.vn','Le', 'Hieu', 1, CAST(N'2003-09-06' AS Date),'0888888888',
'https://i.ibb.co/m8sX0hJ/h-m-bird.jpg', 'Vietnam', 0, 1, '2023-09-30'),
('user','e10adc3949ba59abbe56e057f20f883e', 'user@gmail.com','Normal', 'User', 1, CAST(N'2000-01-01' AS Date),'01236545456',
'https://t4.ftcdn.net/jpg/04/08/24/43/360_F_408244382_Ex6k7k8XYzTbiXLNJgIL8gssebpLLBZQ.jpg', 'Vietnam', 10000, 1, '2022-03-12'),
('admin','e10adc3949ba59abbe56e057f20f883e', 'admin@gmail.com','Admin', ' ', 1, CAST(N'2000-01-01' AS Date),'0999999999',
'https://t4.ftcdn.net/jpg/04/08/24/43/360_F_408244382_Ex6k7k8XYzTbiXLNJgIL8gssebpLLBZQ.jpg', 'Vietnam', 10000, 1, '2022-03-12'),
('coursemanager','e10adc3949ba59abbe56e057f20f883e', 'coursemanager@gmail.com','Course', 'Manager', 1, CAST(N'2000-01-01' AS Date),'0888888888',
'https://t4.ftcdn.net/jpg/04/08/24/43/360_F_408244382_Ex6k7k8XYzTbiXLNJgIL8gssebpLLBZQ.jpg', 'Vietnam', 10000, 1, '2022-03-12'),
('moderator','e10adc3949ba59abbe56e057f20f883e', 'moderator@gmail.com','Moderator', ' ', 1, CAST(N'2000-01-01' AS Date),'0777777777',
'https://t4.ftcdn.net/jpg/04/08/24/43/360_F_408244382_Ex6k7k8XYzTbiXLNJgIL8gssebpLLBZQ.jpg', 'Vietnam', 10000, 1, '2022-03-12');
-----------------------------------------
INSERT INTO [AccountRole] VALUES
(1, 4), 
(2, 4),
(3, 4),
(4, 1),
(4, 2),
(4, 3),
(5, 3),
(6, 2);
-----------------------------------------
INSERT INTO [AccountPremium] VALUES
('2', '2024-12-12');
-----------------------------------------
INSERT INTO [Blog] VALUES
(2,
'https://e0.pxfuel.com/wallpapers/15/759/desktop-wallpaper-anime-traditional-japanese-house-anime-mansion.jpg',
'The best paragraph I like in The Wind-Up Bird Chronicle of Murakami',
'<p><span style="font-family:Comic Sans MS,cursive">Then, suddenly, he thought of the ocean&mdash;the ocean he saw from the deck of the ship that had brought him from Japan to Manchuria eight years ago. Until then he had never seen the ocean, and had not seen it since. He still clearly remembered the salty air. The ocean was one of the most wondrous things he had ever seen in his life - bigger and deeper than anything he had ever imagined. It changes color, shape and shade according to the time, place and weather. It aroused a deep sadness in his heart, and at the same time brought him peace of mind. Will he ever see the sea again? He loosened his grip and dropped the baseball bat to the ground. The stick hit the ground with a dry sound. After the stick left his hand, he felt a little more nauseous.</span></p><p><span style="color:#f1c40f"><span style="font-family:Comic Sans MS,cursive">The wind-up bird continued to chirp, but no one else heard it.</span></span><img alt="" src="https://cdna.artstation.com/p/assets/images/images/045/158/182/large/gurkirat-singh-jan13-1.jpg?1642050147" style="height:300px; width:600px" /></p><p>&nbsp;</p>',
CAST(N'2022-06-08' AS Date)),
(1,
'https://images2.thanhnien.vn/zoom/700_438/Uploaded/congson/2021_05_29/neumotdemdong_BWNQ.jpg',
'If on a winter''s night a traveler',
'<p>The book is a genius in a way that how it approaches the story- narrative of the book is in second person -the protagonist is a young male reader known simply as The Reader. There is a second character, a female reader, referred to by the author as the Other Reader. The relationship between the two characters is one of the two plot drivers of the book. Calvino borrows plot and style from authors of each of different genres, inserting them in his novel, making it inter-textual, or based off of many texts. The author has a lot to stay with the ongoing story.</p>',
CAST(N'2021-10-10' AS Date)),
(2,
'https://file.hstatic.net/200000287623/file/13.67_-_chan_ho_kei_tieu_thuyet_trinh_tham_kinh_di_2_efdffe06c80f4fc0acb2378c11e81ff5.jpg',
'13.67 - Further a novel - is realistic of HongKong',
'<p>Covering six cases that span Kwan Chun-dok’s impressive fifty-year career, The Borrowed takes readers on a tour of Hong Kong history from the Leftist Riot in 1967; the conflict between the HK Police and ICAC (Independent Commission Against Corruption) in 1977; the Tiananmen Square Massacre in 1989; the Handover in 1997; to the present day of 2013, when Kwan is called on to solve his final case, the murder of a local billionaire, while Hong Kong increasingly resembles a police state.</p>',
CAST(N'2018-10-10' AS Date)),
(1,
'https://c.files.bbci.co.uk/25A9/production/_118514690_gettyimages-500641471.jpg',
'The Quiet Don - Sholokhow',
'<p>And Quiet Flows the Don or Quietly Flows the Don (Тихий Дон, lit. "The Quiet Don") is 4-volume epic novel by Russian writer Mikhail Aleksandrovich Sholokhov. The 1st three volumes were written from 1925 to ''32 & published in the Soviet magazine October in 1928–32. The 4th volume was finished in 1940. The English translation of the 1st three volumes appeared under this title in 1934. </p>',
CAST(N'2015-03-07' AS Date)),
(2,
'https://www.lifewire.com/thmb/TXVRTtkHvRpTjnRObQ3xm2VlsD0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/WirelessNetwork-5994852003f4020011db5333.jpg',
'The best course for Beginner with Networking',
'<p>This course provides all the necessary basic knowledge, thereby helping you even more in the future. </p>',
CAST(N'2015-03-07' AS Date));
-----------------------------------------
INSERT INTO [TagBlog] VALUES 
(1,2),
(1,1),
(2,2),
(5,5),
(3,2),
(3,1),
(4,3),
(4,1);
-----------------------------------------
INSERT INTO [Course] VALUES
('The Modern and the Postmodern',90,0.2,
'https://i.ibb.co/PZBLCNv/tram.png', 
N'Murakami''s acceptance and encounter with the problems that Kafka raised are also things that progressive humanity is still wondering about and looking for answers to. In this article, we compare some similarities and differences in the artistic world of two writers Franz Kafka and Haruki Murakami, in order to demonstrate the transformation of Franz Kafka in Murakami''s work.',
'2023-10-05','2023-10-05',
5,4,2),
('Inorganic chemistry under real conditions',100,0.1,
'https://d1whtlypfis84e.cloudfront.net/guides/wp-content/uploads/2021/03/31173413/Inorganic-Chemistry.png', 
N'Inorganic chemistry deals with the synthesis and behavior of inorganic and organometallic compounds. This field includes all chemical compounds except the numerous organic compounds, which are the subjects of organic chemistry. The differences between the two disciplines are not absolute, as there is much overlap within the subdiscipline of organometallic chemistry.',
'2021-04-02','2021-04-02',
2,4,2),
('In-depth analysis of modern literary works',120,0.2,
'https://i.ibb.co/z4J5yNY/346622446-1297413511205064-7652724992259281760-n.jpg', 
N'Modern literature refers to the modernist period in the late nineteenth and early twentieth centuries. It is the period where literature was written, explained, and spoken. It was parted to give to the essence of both prose and verse.',
'2023-10-05','2023-10-05',
5,5,2),
('Computer hardware',80,0,
'https://codelearnstorage.s3.amazonaws.com/CodeCamp/CodeCamp/Upload/Course/3f924049f9af4f95b0fd406b8baebe52.png', 
N'General informatics is the fundamental subject of information technology. Currently, the achievements of informatics are applied in almost all areas of the society and bring great results. The goal of informatics is to exploit information most effectively for all aspects of human activities. Therefore, in any field of activity that needs information processing, information technology can be effective. Therefore, General Informatics plays an important role for not only students but also for everyone who uses computers.',
'2022-09-09','2022-09-09',
1,3,1),
('Computer software',50,0,
'https://codelearnstorage.s3.amazonaws.com/CodeCamp/CodeCamp/Upload/Course/ec5c9eda632842eb9ad3146b4521e11a.png', 
N'General information technology is the fundamental subject of information technology. Currently, the achievements of informatics are applied in almost all areas of operation of the society and bring great results. The goal of informatics is to exploit information most effectively for all aspects of human activities. Therefore, in any field of activity that needs information processing, information technology can be effective. Therefore, General Information Technology plays an important role for not only students but also for everyone who uses computers.',
'2021-12-04','2022-03-29',
1,1,1),
('Computer Communication & Network',100,0,
'https://codelearnstorage.s3.amazonaws.com/CodeCamp/CodeCamp/Upload/Course/c6b8d5cfe9ff4b56887e8751d37a1c61.png', 
N'The course provides basic and understanded knowledge about computer networks and data communications to programmers.',
'2021-12-04','2022-03-29',
1,2,1),
('C++ for Beginners',20,0,
'https://codelearnstorage.s3.amazonaws.com/CodeCamp/CodeCamp/Upload/Course/bf4dca390c5742bda4dbf6344e859eb9.jpg', 
N'The course provides basic and understanded knowledge about computer networks and data communications to programmers.',
'2020-04-02','2021-11-01',
1,1,1);
-----------------------------------------

INSERT INTO [Chapter] VALUES
-----------------------------------------The Modern and The Postmodern-----------------------------------------
(1,1,N'Introduction to Theory'),
(1,2,N'Ways In and Out of the Hermeneutic Circle'),
(1,3,N'Configurative Reading and The Idea of the Autonomous Artwork'),
(1,4,N'Formalisms'),
(1,5,N'Semiotics, Structuralism, Linguistics, Literature'),
(1,6,N'Deconstruction'),
(1,7,N'Freud and Fiction'),
(1,8,N'Jacques Lacan in Theory'),
(1,9,N'Influence'),
(1,10,N'The Postmodern Psyche'),
(1,11,N'The Social Permeability'),
-----------------------------------------Inorganic chemistry under real conditions-----------------------------------------
(2,1,N'Underlying of Inorganic?'),
(2,2,N'Reaction');
-----------------------------------------

INSERT INTO [Test] VALUES
-----------------------------------------The Modern and The Postmodern-----------------------------------------
('Objective Test for Introduction', 15, 7.5),
('Test about Formalism', 6.00, 12),
-----------------------------------------Inorganic chemistry under real conditions-----------------------------------------
('Test atomic Stucture', 15, 5.00);
-----------------------------------------

INSERT INTO [Quiz] VALUES
-----------------------------------------The Modern and The Postmodern-----------------------------------------
(1,1,'What course talk about?', 'Math', 'Chemical', 'IT', 'Literature Theory',4),
(1,2,'The Lecturer refer what?', 'Author', 'Engineer', 'None', 'Researcher',1),
(1,3,'How many theory?', '1', '2', '3', '4',2),
(1,4,'Postmorder refer what Centrery?', '15', '17', '20', 'All',3),
(1,5,'How many part in this lesson?', '1', '2', '3', 'Not given',3),
(1,6,'Who is Murakami', 'Author', 'Teacher', 'ITer', 'FPT Student',1),

(2,1, 'How many Formalism in this lesson talk about?', '1','2','3','4', 3),
(2,2, 'Which of the following is not another title by the author of Fahrenheit 451?', 'Something Wicked This Way Comes','The Martian Chronicles','Stranger in a Strange Land','The Illustrated Man', 2),
(2,3,'Which of the following was not an associate of Mina Loy?', 'Conrad Aiken', 'Marcel Duchamp', 'Arthur Cravan', 'Ezra Pound', 1),
(2,4,'In what decade was The Whitsun Weddings written?', '1980s', '1970s', '1990s', '1960s', 4),
(2,5,'Which of the following is not another work by the author of Birthday Letters?', 'Candles in Babylon', 'Winter Pollen', 'The Iron Man', 'Crow', 1),

-----------------------------------------Inorganic chemistry under real conditions-----------------------------------------
(3,1,'Fe + H2SO4 -> ? + H2O', 'FeO', 'Fe3O4', 'Fe(SO3)2', 'FeSO4', 4),
(3,2,'NaOH is ?', 'Acid', 'Bazo', 'None', 'Both', 2),
(3,3,'What is metan?', 'C2H6', 'CH3COOH', 'CH4', 'N2', 3),
(3,4,'What color of CuSO4.5H2O?', 'Blue', 'Red', 'Green', 'None', 1),
(3,5,'What color of CuSO4?', 'Brown', 'Green', 'Yellow', 'Red', 1);
-----------------------------------------

INSERT INTO [Lesson] VALUES
-----------------------------------------The Modern and The Postmodern-----------------------------------------
(1,1,N'Introduction(1)', 'https://www.youtube.com/embed/4YY4CTSQ8nY?si=ZoMA8WeRMEQFnxSB', N'In this first lecture, Professor Paul Fry explores the course''s title in three parts. The relationship between theory and philosophy, the question of what literature is and does, and what constitutes an introduction are interrogated. The professor then situates the emergence of literary theory in the history of modern criticism and, through an analysis of major thinkers such as Marx, Nietzsche, and Freud, provides antecedents for twentieth-century theoretical developments', NULL),
(1,2,N'Introduction(2)', 'https://www.youtube.com/embed/zS22f07a2MY?si=FsgXQw0mVhojR0ZB', N'In this second introductory lecture, Professor Paul Fry explores the interrelation of skepticism and determinism. The nature of discourse and the related issue of discursivity is read through two modern works, Anton Chekov''s Cherry Orchard and Henry James'' The Ambassadors. Exemplary critical focus on literary authority is located in Michel Foucault''s "What Is an Author" and [Roland] Barthes'' "The Death of the Author," both of which are read with an emphasis on their historical contexts. Objections to the approach and conclusions of the two theorists are examined, particularly in light of the rise of cultural studies.', 1),
(2,1,N'Ways In and Out ', 'https://www.youtube.com/embed/iWnA7nZO4EY?si=xQW8EajbZZ1qvDMI', N'In this lecture, Professor Paul Fry examines acts of reading and interpretation by way of the theory of hermeneutics. The origins of hermeneutic thought are traced through Western literature. The mechanics of hermeneutics, including the idea of a hermeneutic circle, are explored in detail with reference to the works of Hans-George Gadamer, Martin Heidegger, and E. D. Hirsch. Particular attention is paid to the emergence of concepts of "historicism" and "historicality" and their relation to hermeneutic theory.', NULL),
(3,1,N'Configurative Reading', 'https://www.youtube.com/embed/cbJW5nGnoGU?si=OVGxsvnrguqU4f7o', N'The discussion of Gadamer and Hirsch continues in this lecture, which further examines the relationship between reading and interpretation. Through a comparative analysis of these theorists, Professor Paul Fry explores the difference between meaning and significance, the relationship between understanding and paraphrasing, and the nature of the gap between the reader and the text. ', NULL),
(3,2,N'The Idea of the Autonomous Artwork', 'https://www.youtube.com/embed/mT7roDHocuc?si=_L6TAlAzUZh9uJol', N'In this lecture, Professor Paul Fry explores the origins of formalist literary criticism. Considerable attention is paid to the rise and subsequent popularity of the New Critics and their preferred site of literary exploration, the "poem." The idea of autonomous art is explored in the writings of, among others, Kant, Coleridge, and Wilde. ', NULL),
(4,1,N'The New Criticism and Other Western Formalisms', 'https://www.youtube.com/embed/47YyqXdrIhU?si=Sqlz0fULK1cEesmF', N'In this second lecture on formalism, Professor Paul Fry begins by exploring the implications of Wimsatt and Beardsley''s theory of literary interpretation by applying them to Yeats''s "Lapis Lazuli." He then maps the development of Anglo-American formalism from Modernist literature to the American and British academies.', 2),
(4,2,N'Russian Formalism', 'https://www.youtube.com/embed/11_oVlwfv2M?si=d_XrKhZu2EhfqWYb', N'In this lecture, Professor Paul Fry explores the works of major Russian formalists reviewed in an essay by Boris Eikhenbaum. He begins by distinguishing Russian formalism from hermeneutics.', NULL),
(5,1,N'Semiotics and Structuralism','https://www.youtube.com/embed/VsMfaIOsT3M?si=BOXKofcK_pXjmh3u',N'In this lecture, Professor Paul Fry explores the semiotics movement through the work of its founding theorist, Ferdinand de Saussure. The relationship of semiotics to hermeneutics, New Criticism, and Russian formalism is considered. Key semiotic binaries--such as langue and parole, signifier and signified, and synchrony and diachrony--are explored', NULL),
(5,2,N'Linguistics and Literature', 'https://www.youtube.com/embed/TxnqHukr-Oc?si=-Ynkih4d56jYItp4', N'In this lecture on the work of Roman Jakobson, Professor Paul Fry continues his discussion of synchrony and diachrony. The relationships among formalism, semiotics, and linguistics are explored. Claude Levi-Strauss''s structural interpretation of the Oedipus myth is discussed in some detail.', NULL),
(6,1,N'Deconstruction I','https://www.youtube.com/embed/Np72VPguqeI?si=yh33M2Ti_g4wQPdA', N'In this lecture on Derrida and the origins of deconstruction, Professor Paul Fry explores two central Derridian works: "Structure, Sign, and Play in the Discourse of Human Sciences" and "Différance." ', NULL),
(6,2,N'Deconstruction II', 'https://www.youtube.com/embed/51s-J_Jwr40?si=BjRJJC1ZBrAk8v38', N'In this second lecture on deconstruction, Professor Paul Fry concludes his consideration of Derrida and begins to explore the work of Paul de Man. Derrida''s affinity for and departure from Levi-Strauss''s distinction between nature and culture are outlined. De Man''s relationship with Derrida', NULL),
(7,1,N'Freud - Fiction','https://www.youtube.com/embed/GnnWbVvnYIs?si=_6orq7YaKl7jywEW','In this lecture, Professor Paul Fry turns his attention to the relationship between authorship and the psyche. Freud''s meditations on the fundamental drives governing human behavior are read through the lens of literary critic Peter Brooks.', NULL),
(8,1,N'Jacques Lacan in Theory','https://www.youtube.com/embed/lkAXsR5WINc?si=v7PYn0sZDRkAWsqd','In this lecture on psychoanalytic criticism, Professor Paul Fry explores the work of Jacques Lacan. Lacan''s interest in Freud and distaste for post-Freudian "ego psychologists" are briefly mentioned, and his clinical work on "the mirror stage" is discussed in depth.', NULL),
(9,1,N'Influence', 'https://www.youtube.com/embed/vui_MuI0HU0?si=OqB_o7PigrzqDKRp', N'In this lecture on the psyche in literary theory, Professor Paul Fry explores the work of T. S. Eliot and Harold Bloom, specifically their studies of tradition and individualism. Related and divergent perspectives on tradition, innovation, conservatism, and self-effacement are traced throughout Eliot''s "Tradition and the Individual Talent" and Bloom''s "Meditation upon Priority."', NULL),
(10,1,N'The Postmodern Psyche', 'https://www.youtube.com/embed/P1M9-xk-BVg?si=dGN7mmqvhSJhPFiW', N'In this lecture on the postmodern psyche, Professor Paul Fry explores the work of Gilles Deleuze, and Felix Guattari. and Slavoj Žižek. The notion of the "postmodern" is defined through the use of examples in the visual arts and architecture', NULL),
(11,1,N'The Social Permeability', 'https://www.youtube.com/embed/YtK18ImMkp8?si=JJk0P9yjFExxse32', N'In this first lecture on the theory of literature in social contexts, Professor Paul Fry examines the work of Mikhail Bakhtin and Hans Robert Jauss.', NULL),
-----------------------------------------Inorganic chemistry under real conditions-----------------------------------------
(12, 1, 'Introduction to Inorganic', 'https://www.youtube.com/embed/YkYeYhXUeEE?si=TE4Rpk4wmxMK7dRv', N'Professor Cathy Drennan introduces this series of lectures about basic chemical principles. She describes her path to becoming a chemist and reveals her first impression of the discipline of chemistry. Goals for students of this material are presented as well as some examples about how real world problems can be solved through the applications of chemical principles.', null),
(12, 2, 'Atomic Structure', 'https://www.youtube.com/embed/ustfXi-mpkI?si=7iDyJPdHREi9eNID', N'The backscattering experiment of Rutherford is recreated in the classroom setting. Ping pong balls are used to represent alpha particles and Styrofoam balls connected to a series of strings represent nuclei in a piece of gold foil.', 3),
(13, 2, 'Find why reaction?', 'https://www.youtube.com/embed/ustfXi-mpkI?si=7iDyJPdHREi9eNID', N'The backscattering experiment of Rutherford is recreated in the classroom setting. Ping pong balls are used to represent alpha particles and Styrofoam balls connected to a series of strings represent nuclei in a piece of gold foil.', null);

-----------------------------------------
insert into [Transaction] values (4, cast('2023-10-10' as date), 200, N'')
insert into [Transaction] values (4, cast('2023-10-10' as date), 500, N'')
insert into [Transaction] values (4, cast('2023-09-10' as date), 100, N'')
insert into [Transaction] values (4, cast('2023-09-10' as date), 300, N'')
insert into [Transaction] values (4, cast('2023-08-10' as date), 1000, N'')
insert into [Transaction] values (4, cast('2023-07-10' as date), 200, N'')
insert into [Transaction] values (4, cast('2023-06-10' as date), 400, N'')
insert into [Transaction] values (4, cast('2023-10-10' as date), 200, N'')
insert into [Transaction] values (4, cast('2023-10-10' as date), 200, N'')
insert into [Transaction] values (4, cast('2023-09-10' as date), 200, N'')
insert into [Transaction] values (4, cast('2023-08-10' as date), 200, N'')
insert into [Transaction] values (4, cast('2023-09-10' as date), 200, N'')
insert into [Transaction] values (4, cast('2023-10-10' as date), 200, N'')
--
insert into [Transaction] values (5, cast('2023-08-10' as date), 1000, N'')
insert into [Transaction] values (5, cast('2023-07-10' as date), 200, N'')
insert into [Transaction] values (6, cast('2023-06-10' as date), 400, N'')
insert into [Transaction] values (5, cast('2023-10-10' as date), 200, N'')
insert into [Transaction] values (6, cast('2023-10-10' as date), 200, N'')
insert into [Transaction] values (5, cast('2023-09-10' as date), 200, N'')
insert into [Transaction] values (6, cast('2023-08-10' as date), 200, N'')
insert into [Transaction] values (6, cast('2023-09-10' as date), 200, N'')
insert into [Transaction] values (5, cast('2023-10-10' as date), 200, N'')
--2022
insert into [Transaction] values (5, cast('2022-08-10' as date), 1000, N'')
insert into [Transaction] values (5, cast('2022-07-10' as date), 200, N'')
insert into [Transaction] values (6, cast('2022-06-10' as date), 400, N'')
insert into [Transaction] values (5, cast('2022-10-10' as date), 200, N'')
insert into [Transaction] values (6, cast('2022-10-10' as date), 200, N'')
insert into [Transaction] values (5, cast('2022-09-10' as date), 200, N'')
insert into [Transaction] values (6, cast('2022-08-10' as date), 200, N'')
insert into [Transaction] values (6, cast('2022-09-10' as date), 200, N'')
insert into [Transaction] values (5, cast('2023-10-10' as date), 200, N'')