
/* SQL Date & Time Functions
Contents:
	1. All EXTRACT formats
	2. All DATE_PART formats
	3. All TO_CHAR formats
	4. All DATE_TRUNC formats
	5. All Date format specifiers
	6. All Number format Specifiers */

-- All EXTRACT formats

SELECT
	'century' AS EXTRACT,
	EXTRACT('century' FROM NOW())
UNION ALL
SELECT
	'decade',
	EXTRACT('decade' FROM NOW())
UNION ALL
SELECT
	'year',
	EXTRACT('year' FROM NOW())
UNION ALL
SELECT
	'ISO 8601 year',
	EXTRACT('isoyear' FROM NOW())
UNION ALL
SELECT
	'quarter(1-4)',
	EXTRACT('quarter' FROM NOW())
UNION ALL
SELECT
	'month(1-12)',
	EXTRACT('month' FROM NOW())
UNION ALL
SELECT
	'week(1-52)',
	EXTRACT('week' FROM NOW())
UNION ALL
SELECT
	'day of month',
	EXTRACT('day' FROM NOW())
UNION ALL
SELECT
	'day of year(1-366)',
	EXTRACT('doy' FROM NOW())
UNION ALL
SELECT
	'day of week (0=sunday)',
	EXTRACT('dow' FROM NOW())
UNION ALL
SELECT
	'hour',
	EXTRACT('hour' FROM NOW())
UNION ALL
SELECT
	'minute',
	EXTRACT('minute' FROM NOW())
UNION ALL
SELECT
	'seconds',
	EXTRACT('second' FROM NOW())
UNION ALL
SELECT
	'milliseconds',
	EXTRACT('millisecond' FROM NOW())
UNION ALL
SELECT
	'microseconds',
	EXTRACT('microsecond' FROM NOW())
UNION ALL
SELECT
	'timezone offset(seconds)',
	EXTRACT('timezone' FROM NOW())
UNION ALL
SELECT
	'timezone hour',
	EXTRACT('timezone_hour' FROM NOW())
UNION ALL
SELECT
	'timezone minute',
	EXTRACT('timezone_minute' FROM NOW());


-- All DATE_PART formats

SELECT
	'century' AS DATE_PART,
	DATE_PART('century', NOW())
UNION ALL
SELECT
	'decade',
	DATE_PART('decade', NOW())
UNION ALL
SELECT
	'year',
	DATE_PART('year', NOW())
UNION ALL
SELECT
	'ISO 8601 year',
	DATE_PART('isoyear', NOW())
UNION ALL
SELECT
	'quarter(1-4)',
	DATE_PART('quarter', NOW())
UNION ALL
SELECT
	'month(1-12)',
	DATE_PART('month', NOW())
UNION ALL
SELECT
	'week(1-52)',
	DATE_PART('week', NOW())
UNION ALL
SELECT
	'day of month',
	DATE_PART('day', NOW())
UNION ALL
SELECT
	'day of year(1-366)',
	DATE_PART('doy', NOW())
UNION ALL
SELECT
	'day of week (0=sunday)',
	DATE_PART('dow', NOW())
UNION ALL
SELECT
	'hour',
	DATE_PART('hour', NOW())
UNION ALL
SELECT
	'minute',
	DATE_PART('minute', NOW())
UNION ALL
SELECT
	'seconds',
	DATE_PART('second', NOW())
UNION ALL
SELECT
	'milliseconds',
	DATE_PART('millisecond', NOW())
UNION ALL
SELECT
	'microseconds',
	DATE_PART('microsecond', NOW())
UNION ALL
SELECT
	'timezone offset(seconds)',
	DATE_PART('timezone', NOW())
UNION ALL
SELECT
	'timezone hour',
	DATE_PART('timezone_hour', NOW())
UNION ALL
SELECT
	'timezone minute',
	DATE_PART('timezone_minute', NOW());


-- All TO_CHAR formats

SELECT 
    'Year' AS TO_CHAR, 
    TO_CHAR(NOW(), 'yyyy') AS To_Char_Output
UNION ALL
SELECT
	'yy',
	TO_CHAR(NOW(), 'yy')
UNION ALL
SELECT
	'mm',
	TO_CHAR(NOW(), 'mm')
UNION ALL
SELECT
	'mon',
	TO_CHAR(NOW(), 'mon')
UNION ALL
SELECT
	'month',
	TO_CHAR(NOW(), 'month')
UNION ALL
SELECT
	'Roman_numeral_month',
	TO_CHAR(NOW(), 'RM')
UNION ALL
SELECT
	'Day_of_month',
	TO_CHAR(NOW(), 'DD')
UNION ALL
SELECT
	'Day_of_year',
	TO_CHAR(NOW(), 'DDD')
UNION ALL
SELECT
	'short_day_name',
	TO_CHAR(NOW(), 'Dy')
UNION ALL
SELECT
	'fullday_name',
	TO_CHAR(NOW(), 'Day')
UNION ALL
SELECT
	'Day_of_week(sun=1)',
	TO_CHAR(NOW(), 'D')
UNION ALL
SELECT
	'week_of_year',
	TO_CHAR(NOW(), 'WW')
UNION ALL
SELECT
	'week_of_month',
	TO_CHAR(NOW(), 'W')
UNION ALL
SELECT
	'quarter',
	TO_CHAR(NOW(), 'Q')
UNION ALL
SELECT
	'hour(1-12)',
	TO_CHAR(NOW(), 'hh')
UNION ALL
SELECT
	'hour(1-12)',
	TO_CHAR(NOW(), 'hh12')
UNION ALL
SELECT
	'hour(0-23)',
	TO_CHAR(NOW(), 'hh24')
UNION ALL
SELECT
	'minute',
	TO_CHAR(NOW(), 'mi')
UNION ALL
SELECT
	'second',
	TO_CHAR(NOW(), 'ss')
UNION ALL
SELECT
	'seconds_since_midnight',
	TO_CHAR(NOW(), 'ssss')
UNION ALL
SELECT
	'milliseconds',
	TO_CHAR(NOW(), 'ms')
UNION ALL
SELECT
	'microseconds',
	TO_CHAR(NOW(), 'us')
UNION ALL
SELECT
	'am/pm',
	TO_CHAR(NOW(), 'am')
UNION ALL
SELECT
	'AM/PM',
	TO_CHAR(NOW(), 'PM')
UNION ALL
SELECT
	'timezone',
	TO_CHAR(NOW(), 'TZ')
UNION ALL
SELECT
	'timezone_offset',
	TO_CHAR(NOW(), 'OF');

-- All DATE_TRUNC formats

SELECT
	'microseconds',
	DATE_TRUNC('microseconds', NOW())
UNION ALL
SELECT
	'milliseconds',
	DATE_TRUNC('milliseconds', NOW())
UNION ALL
SELECT
	'seconds',
	DATE_TRUNC('second', NOW())
UNION ALL
SELECT
	'minute',
	DATE_TRUNC('minute', NOW())
UNION ALL
SELECT
	'hour',
	DATE_TRUNC('hour', NOW())
UNION ALL
SELECT
	'day',
	DATE_TRUNC('day', NOW())
UNION ALL
SELECT
	'month',
	DATE_TRUNC('month', NOW())
UNION ALL
SELECT
	'quarter',
	DATE_TRUNC('quarter', NOW())
UNION ALL
SELECT
	'year',
	DATE_TRUNC('year', NOW())
UNION ALL
SELECT
	'decade',
	DATE_TRUNC('decade', NOW())
UNION ALL
SELECT
	'century',
	DATE_TRUNC('century', NOW())
UNION ALL
SELECT
	'millennium',
	DATE_TRUNC('millennium', NOW());

-- All DATE formatting specifiers : TO_CHAR

SELECT 
    'd' AS format_Type, 
    TO_CHAR(NOW(), 'd') AS TO_CHAR_Value,
    'day_of_week(sunday=1)' AS Description
UNION ALL
SELECT 
    'dd', 
    TO_CHAR(NOW(), 'dd'), 
    'Day of month'
UNION ALL
SELECT 
    'dy', 
    TO_CHAR(NOW(), 'dy'), 
    'Abb. day name'
UNION ALL
SELECT 
    'ddd', 
    TO_CHAR(NOW(), 'ddd'), 
    'Day of year'
UNION ALL
SELECT 
    'day', 
    TO_CHAR(NOW(), 'day'), 
    'Full name of day'
UNION ALL
SELECT 
    'mm', 
    TO_CHAR(NOW(), 'mm'), 
    'Month number'
UNION ALL
SELECT 
    'mon', 
    TO_CHAR(NOW(), 'mon'), 
    'Abb. month name'
UNION ALL
SELECT 
    'Month', 
    TO_CHAR(NOW(), 'Month'), 
    'Full name of month'
UNION ALL
SELECT 
    'yy', 
    TO_CHAR(NOW(), 'yy'), 
    'Two-digit year'
UNION ALL
SELECT 
    'yyyy', 
    TO_CHAR(NOW(), 'yyyy'), 
    'Four-digit year'
UNION ALL
SELECT 
    'hh', 
    TO_CHAR(NOW(), 'hh'), 
    'Hour in 12-hour clock with leading zero'
UNION ALL
SELECT 
    'hh12', 
    TO_CHAR(NOW(), 'hh12'), 
    'Hour in 12-hour clock with leading zero'
UNION ALL
SELECT 
    'hh24', 
    TO_CHAR(NOW(), 'hh24'), 
    'Hour in 24-hour clock with leading zero'
UNION ALL
SELECT 
    'mi', 
    TO_CHAR(NOW(), 'mi'), 
    'Minutes'
UNION ALL
SELECT 
    'ss', 
    TO_CHAR(NOW(), 'ss'), 
    'Seconds'
UNION ALL
SELECT 
    'w', 
    TO_CHAR(NOW(), 'w'), 
    'week number of month'
UNION ALL
SELECT 
    'ww', 
    TO_CHAR(NOW(), 'ww'), 
    'week number of year'
UNION ALL
SELECT 
    'ms', 
    TO_CHAR(NOW(), 'ms'), 
    'Milliseconds'
UNION ALL
SELECT 
    'us', 
    TO_CHAR(NOW(), 'us'), 
    'microseconds'
UNION ALL
SELECT 
    'ssss', 
    TO_CHAR(NOW(), 'ssss'), 
    'seconds since midnight'
UNION ALL
SELECT 
    'q', 
    TO_CHAR(NOW(), 'q'), 
    'quarter'
UNION ALL
SELECT
	'RM',
	TO_CHAR(NOW(), 'RM'),
	'Roman numeral month'
UNION ALL
SELECT
	'am/pm, AM/PM',
	TO_CHAR(NOW(), 'PM'),
	'am/pm, AM/PM designator';

-- All numeric format specifiers

SELECT
	'FM999,999,999.00' AS format_type,
	TO_CHAR(12345.678, 'FM999,999,999.00') AS formatted_value
UNION ALL
SELECT
	'FM999,999,999',
	TO_CHAR(1234.567, 'FM999,999,999')
UNION ALL
SELECT
	'FM999,999,999.0',
	TO_CHAR(12345.678, 'FM999,999,999.0')
UNION ALL
SELECT
	'FM$999,999,999.00',
	TO_CHAR(12345.678, 'FM$999,999,999.00')
UNION ALL
SELECT
	'number_with_decimal * 100, FM999,999,999.00 || %',
	TO_CHAR(0.98 * 100, 'FM999,999,999.00') || '%'
UNION ALL
SELECT
	'science notation',
	TO_CHAR(12345.6, '9.9999EEEE');