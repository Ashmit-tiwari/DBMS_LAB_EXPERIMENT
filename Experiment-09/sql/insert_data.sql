SET SESSION cte_max_recursion_depth = 5000;

INSERT INTO Railway_Booking 
(Booking_ID, Passenger_Name, Age, Gender, Train_No, 
 Train_Name, Source_Station, Destination_Station, 
 Journey_Date, Seat_No, Coach, Booking_Status, Fare) 
WITH RECURSIVE Numbers AS ( 
    SELECT 1 AS n 
    UNION ALL 
    SELECT n + 1 
    FROM Numbers 
    WHERE n < 5000 
) 
SELECT 
    n, 
    CONCAT('Passenger_', n), 
    18 + (n % 50), 
    CASE 
        WHEN n % 2 = 0 THEN 'Male' 
        ELSE 'Female' 
    END, 
    12000 + (n % 20), 
    CONCAT('Express_', n % 20), 
    CASE 
        WHEN n % 3 = 0 THEN 'Lucknow' 
        WHEN n % 3 = 1 THEN 'Delhi' 
        ELSE 'Kanpur' 
    END, 
    CASE 
        WHEN n % 3 = 0 THEN 'Mumbai' 
        WHEN n % 3 = 1 THEN 'Jaipur' 
        ELSE 'Varanasi' 
    END, 
    DATE_ADD('2026-01-01', INTERVAL (n % 365) DAY), 
    (n % 72) + 1, 
    CASE 
        WHEN n % 3 = 0 THEN 'A1' 
        WHEN n % 3 = 1 THEN 'B1' 
        ELSE 'S1' 
    END, 
    CASE 
        WHEN n % 4 = 0 THEN 'Confirmed' 
        WHEN n % 4 = 1 THEN 'Waiting' 
        WHEN n % 4 = 2 THEN 'Cancelled' 
        ELSE 'RAC' 
    END, 
    300 + (n % 1000) 
FROM Numbers;
