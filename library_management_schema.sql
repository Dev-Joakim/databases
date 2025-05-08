
-- Library Management System Database Schema

-- 1. Create the database
CREATE DATABASE IF NOT EXISTS libraryDB;
USE libraryDB;

-- 2. Authors table (one author can write many books)
CREATE TABLE Authors (
    authorID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    UNIQUE (firstName, lastName)
) ENGINE=InnoDB;

-- 3. Books table (book can have multiple authors via BookAuthors)
CREATE TABLE Books (
    bookID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    publishedYear YEAR NOT NULL,
    copiesAvailable INT NOT NULL DEFAULT 1
) ENGINE=InnoDB;

-- 4. Junction table for many-to-many between Books and Authors
CREATE TABLE BookAuthors (
    bookID INT NOT NULL,
    authorID INT NOT NULL,
    PRIMARY KEY (bookID, authorID),
    FOREIGN KEY (bookID) REFERENCES Books(bookID),
    FOREIGN KEY (authorID) REFERENCES Authors(authorID)
) ENGINE=InnoDB;

-- 5. Members table (library members)
CREATE TABLE Members (
    memberID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    membershipDate DATE NOT NULL
) ENGINE=InnoDB;

-- 6. MembershipCards table (one-to-one with Members)
CREATE TABLE MembershipCards (
    memberID INT PRIMARY KEY,
    cardNumber VARCHAR(20) NOT NULL UNIQUE,
    issueDate DATE NOT NULL,
    expiryDate DATE NOT NULL,
    FOREIGN KEY (memberID) REFERENCES Members(memberID)
) ENGINE=InnoDB;

-- 7. Loans table (tracks which member has borrowed which book)
CREATE TABLE Loans (
    loanID INT AUTO_INCREMENT PRIMARY KEY,
    memberID INT NOT NULL,
    bookID INT NOT NULL,
    loanDate DATE NOT NULL,
    dueDate DATE NOT NULL,
    returnDate DATE,
    FOREIGN KEY (memberID) REFERENCES Members(memberID),
    FOREIGN KEY (bookID) REFERENCES Books(bookID),
    CHECK (dueDate >= loanDate)
) ENGINE=InnoDB;
