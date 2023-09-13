SELECT SUM(standard_amt_usd) / SUM(standard_qty) standard_price_per_unit
FROM orders;
-- Exact match, we even chose the same alias.