CREATE TABLE
    Customer (
        id SERIAL PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL
    );

CREATE TABLE
    Customer_profile (
        id SERIAL PRIMARY KEY,
        isLoggedIn BOOLEAN DEFAULT false,
        customer_id INTEGER REFERENCES Customer(id)
    );

    
INSERT INTO
    Customer (first_name, last_name)
VALUES ('John', 'Doe'), ('Jerome', 'Lalu'), ('Lea', 'Rive');

INSERT INTO
    Customer_profile (isLoggedIn, customer_id)
VALUES (
        true, (
            SELECT id
            FROM Customer
            WHERE
                first_name = 'John'
        )
    ), (
        false, (
            SELECT id
            FROM Customer
            WHERE first_name = 'Jerome'
        )
    );



SELECT c.first_name
FROM Customer c
    JOIN Customer_profile cp ON c.id = cp.customer_id
WHERE cp.isLoggedIn = true;

SELECT
    c.first_name,
    cp.isLoggedIn
FROM Customer c
    LEFT JOIN Customer_profile cp ON c.id = cp.customer_id;

SELECT COUNT(*)
FROM Customer c
    LEFT JOIN Customer_profile cp ON c.id = cp.customer_id
WHERE
    cp.id IS NULL
    OR cp.isLoggedIn = false;

CREATE TABLE
    Book (
        book_id SERIAL PRIMARY KEY,
        title TEXT NOT NULL,
        author TEXT NOT NULL
    );

INSERT INTO
    Book (title, author)
VALUES (
        'Alice In Wonderland',
        'Lewis Carroll'
    ), ('Harry Potter', 'J.K Rowling'), (
        'To kill a mockingbird',
        'Harper Lee'
    );

CREATE TABLE
    Student (
        student_id SERIAL PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        age INTEGER CHECK (age <= 15)
    );

    INSERT INTO Student (name, age)
VALUES ('John', 12), ('Lera', 11), ('Patrick', 10), ('Bob', 14);


CREATE TABLE
    Library (
        book_fk_id INTEGER REFERENCES Book(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
        student_fk_id INTEGER REFERENCES Student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
        borrowed_date DATE,
        PRIMARY KEY (book_fk_id, student_fk_id)
    );

    INSERT INTO
    Library (
        book_fk_id,
        student_fk_id,
        borrowed_date
    )
VALUES ( (
            SELECT book_id
            FROM Book
            WHERE
                title = 'Alice In Wonderland'
        ), (
            SELECT student_id
            FROM Student
            WHERE
                name = 'John'
        ),
        '2022-02-15'
    ), ( (
            SELECT book_id
            FROM Book
            WHERE
                title = 'To kill a mockingbird'
        ), (
            SELECT student_id
            FROM Student
            WHERE
                name = 'Bob'
        ),
        '2021-03-03'
    ), ( (
            SELECT book_id
            FROM Book
            WHERE
                title = 'Alice In Wonderland'
        ), (
            SELECT student_id
            FROM Student
            WHERE
                name = 'Lera'
        ),
        '2021-05-23'
    ), ( (
            SELECT book_id
            FROM Book
            WHERE
                title = 'Harry Potter'
        ), (
            SELECT student_id
            FROM Student
            WHERE
                name = 'Bob'
        ),
        '2021-08-12'
    );

SELECT * FROM Library;

SELECT s.name, b.title FROM Student;