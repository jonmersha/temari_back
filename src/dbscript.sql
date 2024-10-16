-- 1. Create the 'providers' table
CREATE TABLE providers (
    id SERIAL PRIMARY KEY,             -- Auto-incrementing primary key
    name VARCHAR(255) NOT NULL,        -- Name of the provider (e.g., publisher)
    address TEXT,                      -- Address of the provider
    email VARCHAR(255),                -- Provider's email address
    phone VARCHAR(50),                 -- Provider's phone number
    website VARCHAR(255),              -- Optional website URL
    created_at TIMESTAMP DEFAULT NOW(),-- Timestamp of record creation
    updated_at TIMESTAMP DEFAULT NOW() -- Timestamp of the last update
);

-- 2. Create the 'regions' table
CREATE TABLE regions (
    id SERIAL PRIMARY KEY,             -- Auto-incrementing primary key
    name VARCHAR(255) NOT NULL,        -- Name of the region (e.g., Oromia, Amhara)
    created_at TIMESTAMP DEFAULT NOW(),-- Timestamp of record creation
    updated_at TIMESTAMP DEFAULT NOW() -- Timestamp of the last update
);

-- 3. Create the 'textbooks' table with a direct reference to 'regions'
CREATE TABLE textbooks (
    id SERIAL PRIMARY KEY,             -- Auto-incrementing primary key
    title VARCHAR(255) NOT NULL,       -- Title of the textbook
    subject VARCHAR(255) NOT NULL,     -- Subject of the textbook (e.g., Math, Science)
    grade INT NOT NULL,                -- Grade level (e.g., 1, 2, 3)
    description TEXT,                  -- Optional description of the textbook
    isbn VARCHAR(20),                  -- Optional ISBN number
    image_url TEXT,                    -- URL for the textbook's cover image
    provider_id INT REFERENCES providers(id) ON DELETE SET NULL, -- Foreign key to the 'providers' table
    region_id INT REFERENCES regions(id) ON DELETE SET NULL,     -- Foreign key to the 'regions' table
    created_at TIMESTAMP DEFAULT NOW(),-- Timestamp of record creation
    updated_at TIMESTAMP DEFAULT NOW() -- Timestamp of the last update
);

create view  book_list as
SELECT 
    t.id AS textbook_id,
    t.title AS textbook_title,
    t.subject AS textbook_subject,
    t.grade AS textbook_grade,
    t.description AS textbook_description,
    t.isbn AS textbook_isbn,
    t.image_url AS textbook_image_url,
    p.id AS provider_id,
    p.name AS provider_name,
    r.id AS region_id,
    r.name AS region_name,
    t.created_at AS textbook_created_at,
    t.updated_at AS textbook_updated_at
FROM 
    textbooks t
JOIN 
    providers p ON t.provider_id = p.id
JOIN 
    regions r ON t.region_id = r.id;



INSERT INTO providers (name)
VALUES 
('Addis Ababa Education Office'),
('Ministry Of Education');


INSERT INTO regions (name, created_at, updated_at)
VALUES 
('Addis Ababa'),
('Oromia'),
('Amhara'),
('Afar'),
('Somali');






INSERT INTO textbooks (title, subject, grade, description, isbn, image_url, provider_id, region_id, created_at, updated_at)
VALUES
-- Grade 5 Mathematics
('የሂሳብ ትምህርት 5ኛ ክፍል', 'MathematicsGrade5', 5, 'Textbook for Grade 5', '978-5555555001', 'text_book/math5', 1, 1, NOW(), NOW()),

-- Grade 5 Science
('የአካባቢ ሳይንስ 5ኛ ክፍል', 'ScienceGrade5', 5, 'Textbook for Grade 5', '978-5555555002', 'text_book/es5', 1, 1, NOW(), NOW()),
-- Grade 5 Science
('የአማርኛ ክፍል 5ኛ ክፍል', 'amharic5', 5, 'Textbook for Grade 5', '978-5555555002', 'text_book/am5', 1, 1, NOW(), NOW()),

-- Grade 5 Science
('የክወናና-የዕይታ-ጥበባት 5', 'Performing-visual-artsgrade5', 5, 'Textbook for Grade 5', '978-5555555002', 'text_book/pva5', 1, 1, NOW(), NOW()),

-- Grade 5 English Language
('English Language Grade 5', 'EnglishLanguageGrade5', 5, 'Textbook for Grade 5', '978-5555555003', 'text_book/en5', 1,1, NOW(), NOW());

CREATE TABLE `users` (
  `user_id` int(11) int primary key AUTO_INCREMENT NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) unique NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
)

CREATE TABLE promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE news (
    news_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    publish_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



INSERT INTO `textbooks`(
    `id`,
    `title`,
    `subject`,
    `grade`,
    `description`,
    `isbn`,
    `image_url`,
    `book_url`,
    `provider_id`,
    `region_id`,
    `created_at`,
    `updated_at`
)
VALUES(
    NULL,
    '5ኛ ክፍል ሥነ ጠጥበብ',
    'visual_art_oromia_grade5',
    '5',
    'Og Arti',
    '911',
    'text_book/pdf/oromia/grade5/5ኛ_ክፍል_ሥነ_ጠጥበብ_አድስ_merged_compressed.pdf',
    'text_book/pdf/oromia/grade5/5ኛ_ክፍል_ሥነ_ጠጥበብ_አድስ_merged_compressed.pdf',
    '3',
    '2',
    CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());



    CREATE TABLE news (
    news_id INT PRIMARY KEY AUTO_INCREMENT,           -- Unique identifier for each news entry
    title VARCHAR(255) NOT NULL,          -- Title of the news
    content TEXT NOT NULL,                -- Full content of the news
    author VARCHAR(100),                  -- Name of the author
    publication_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date the news was published
    image_url VARCHAR(255),               -- URL of an image related to the news
    category VARCHAR(100),                -- Category or section of the news (e.g., sports, politics)
    is_published BOOLEAN DEFAULT FALSE,   -- Whether the news is published or not
    views INT DEFAULT 0                   -- Number of views
);

INSERT INTO `edu_news` (`news_id`, `title`, `content`, `author`, `publication_date`, `image_url`, `category`, `is_published`, `views`) VALUES (NULL, 'Test Missage', 'Message body', 'Edu Office', current_timestamp(), 'asset/addi.png', 'Edu', '1', '0');





CREATE TABLE book_read_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    last_page_read INT,
    read_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES textbooks(id) ON DELETE CASCADE
);

CREATE TABLE `users` (
  `user_id` int(11) int primary key AUTO_INCREMENT NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) unique NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
);

CREATE TABLE textbooks (
    id INT PRIMARY KEY AUTO_INCREMENT,             
    title VARCHAR(255) NOT NULL,       
    subject VARCHAR(255) NOT NULL,     
    grade INT NOT NULL,                
    description TEXT,                  -- Optional description of the textbook
    isbn VARCHAR(20),                  -- Optional ISBN number
    image_url TEXT,                    -- URL for the textbook's cover image
    provider_id INT REFERENCES providers(id) ON DELETE SET NULL, -- Foreign key to the 'providers' table
    region_id INT REFERENCES regions(id) ON DELETE SET NULL,     -- Foreign key to the 'regions' table
    created_at TIMESTAMP DEFAULT NOW(),-- Timestamp of record creation
    updated_at TIMESTAMP DEFAULT NOW() -- Timestamp of the last update
);


CREATE VIEW reading_history_view AS SELECT brh.history_id, -- Reading history ID brh.user_id, -- User ID u.username, -- User's username u.first_name, -- User's first name u.last_name, -- User's last name brh.book_id, -- Book ID tb.title AS book_title, -- Book title tb.subject AS book_subject, -- Book subject tb.grade AS book_grade, -- Book grade level tb.image_url AS book_image, -- Book cover image URL brh.last_page_read, -- The last page read by the user brh.read_date -- The date when the user read the book FROM book_read_history brh JOIN users u ON brh.user_id = u.user_id JOIN textbooks tb ON brh.book_id = tb.id ORDER BY brh.read_date DESC;


insert into subject(subject_name) values
('Amharic'),
('English'),
('General science'),
('Mathematics'),
('Career and Technical Education'),
('Social Study'),
('Citizenship Eduction'),
('Information Technology'),
('Visual and Performing Art'),
('Health and Physical Education'),
('Biology'),
('Chemistry'),
('Civics'),
('Geography'),
('Physics'),
('Basic Technical Drawing'),
('Economics'),
('General Business');