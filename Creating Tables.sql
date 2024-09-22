DROP DATABASE IF EXISTS credit_card_details;
CREATE DATABASE credit_card_details;
USE credit_card_details;

-- Creating Tables

-- Card Holder

CREATE TABLE card_holder(
       id INT PRIMARY KEY NOT NULL,
       username VARCHAR(50) NOT NULL
);

-- Credit Card

DROP TABLE IF EXISTS credit_card;
CREATE TABLE credit_card(
       card VARCHAR(20) PRIMARY KEY NOT NULL,
       card_holder_id INT NOT NULL,
       FOREIGN KEY(card_holder_id) REFERENCES card_holder(id)
);

-- Merchant Category

CREATE TABLE merchant_category(
       id INT PRIMARY KEY NOT NULL,
       category VARCHAR(50) NOT NULL
);

-- Merchant

DROP TABLE IF EXISTS merchant;
CREATE TABLE merchant (
       id INT PRIMARY KEY NOT NULL,
       username VARCHAR(250) NOT NULL,
       merchant_category_id INT NOT NULL,
       FOREIGN KEY(merchant_category_id) REFERENCES merchant_category(id)
);

-- Transactions

CREATE TABLE transactions(
       id INT PRIMARY KEY NOT NULL,
       transaction_date TIMESTAMP NOT NULL,
       amount FLOAT NOT NULL,
       card VARCHAR(20) NOT NULL,
       merchant_id INT NOT NULL,
       FOREIGN KEY(card) REFERENCES credit_card(card),
       FOREIGN KEY(merchant_id) REFERENCES merchant (id)
);