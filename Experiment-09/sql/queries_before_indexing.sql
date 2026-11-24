SELECT * FROM Railway_Booking;

SELECT COUNT(*) AS Total_Bookings 
FROM Railway_Booking;

SELECT * 
FROM Railway_Booking 
WHERE Train_No = 12005;

SELECT * 
FROM Railway_Booking 
WHERE Passenger_Name = 'Passenger_100';

SELECT * 
FROM Railway_Booking 
WHERE Booking_Status = 'Confirmed';

SELECT * 
FROM Railway_Booking 
WHERE Source_Station = 'Lucknow';

SELECT Train_No, COUNT(*) AS Total_Passengers 
FROM Railway_Booking 
GROUP BY Train_No;

SELECT Booking_Status, COUNT(*) AS Total 
FROM Railway_Booking 
GROUP BY Booking_Status;

SELECT * 
FROM Railway_Booking 
WHERE Fare BETWEEN 500 AND 1000;

SELECT * 
FROM Railway_Booking 
ORDER BY Journey_Date;

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
