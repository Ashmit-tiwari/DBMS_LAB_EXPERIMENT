EXPLAIN 
SELECT * 
FROM Railway_Booking 
WHERE Train_No = 12005;

EXPLAIN 
SELECT * 
FROM Railway_Booking 
WHERE Passenger_Name = 'Passenger_100';

EXPLAIN 
SELECT * 
FROM Railway_Booking 
WHERE Booking_Status = 'Confirmed';

EXPLAIN 
SELECT * 
FROM Railway_Booking 
WHERE Train_No = 12005 
AND Journey_Date BETWEEN '2026-02-01' AND '2026-06-30';

SELECT * 
FROM Railway_Booking 
WHERE Train_No = 12005 
AND Journey_Date BETWEEN '2026-02-01' AND '2026-06-30';

SHOW INDEX FROM Railway_Booking;

SELECT 
    Train_No, 
    COUNT(*) AS Total_Bookings, 
    AVG(Fare) AS Average_Fare 
FROM Railway_Booking 
GROUP BY Train_No;

SELECT 
    Source_Station, 
    Destination_Station, 
    COUNT(*) AS Total_Passengers 
FROM Railway_Booking 
GROUP BY Source_Station, Destination_Station;

SELECT 
    Train_No, 
    SUM(Fare) AS Total_Revenue 
FROM Railway_Booking 
GROUP BY Train_No 
ORDER BY Total_Revenue DESC;

SELECT * 
FROM Railway_Booking 
WHERE Booking_Status = 'Confirmed' 
AND Source_Station = 'Lucknow';

SELECT * 
FROM Railway_Booking 
WHERE Journey_Date >= '2026-05-01' 
ORDER BY Journey_Date;

ANALYZE TABLE Railway_Booking;

SHOW INDEX FROM Railway_Booking;
