-- Top 100 highest transactions during early morning hours (7-9am)

SELECT * FROM transactions
WHERE TIME(transaction_date) BETWEEN '07:00:00' AND '09:00:00'
ORDER BY amount DESC
LIMIT 100
;

-- Number of transactions less than $2 per card holder to check for hacked cards

SELECT
     card_holder.id,
     card_holder.username,
     count(*)
FROM card_holder 
JOIN credit_card 
    ON credit_card.card_holder_id = card_holder.id
JOIN transactions 
    ON transactions.card = credit_card.card
WHERE amount < 2.00
GROUP BY card_holder.id 
ORDER BY COUNT(*) DESC
;

-- Total transactions under $2

SELECT COUNT(*) FROM transactions
WHERE amount < 2.00
;

-- Top 5 merchants prone to being hacked by small transactions

SELECT 
      merchant.id,
      merchant.username,
      count(*)
FROM merchant
JOIN transactions
     ON transactions.merchant_id = merchant.id
WHERE amount < 2.00 
GROUP BY merchant.id
ORDER BY COUNT(*) DESC
LIMIT 5
;

-- Creating a view to join all the tables

CREATE VIEW transaction_details AS
SELECT 
      transactions.transaction_date,
      card_holder.id,
      card_holder.username,
      credit_card.card,
      transactions.amount,
      merchant_category.category
FROM card_holder
JOIN credit_card
     ON credit_card.card_holder_id = card_holder.id
JOIN transactions
     ON transactions.card = credit_card.card
JOIN merchant
     ON merchant.id = transactions.merchant_id
JOIN merchant_category
     ON merchant_category.id = merchant.merchant_category_id
;