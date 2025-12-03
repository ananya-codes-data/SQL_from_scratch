/* SQL Number Functions

Contents:
     1. Rounding Functions
        - ROUND
     2. Absolute Value Function
        - ABS */

-- ROUND() - Rounding Numbers

-- Demonstrate rounding a number to different decimal places
SELECT
	3.516 AS static_value,
    ROUND(3.516, 2) AS round_2,
    ROUND(3.516, 1) AS round_1,
    ROUND(3.516, 0) AS round_0;


-- ABS() - Absolute Value

-- Demonstrate absolute value function
SELECT
	-10 AS static_value,
    ABS(-10) AS absolute_value_1,
    ABS(10) AS absolute_value_2;