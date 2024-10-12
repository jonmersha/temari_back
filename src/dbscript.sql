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
