CREATE DATABASE IF NOT EXISTS BOOK_Hive_DB;
USE BOOK_Hive_DB;
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash CHAR(60) NOT NULL, -- For secure storage (e.g., BCrypt hash)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Book (
    book_isbn CHAR(13) PRIMARY KEY, -- ISBN-13 as the unique identifier
    title VARCHAR(255) NOT NULL,
    author VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    publication_year INT
);