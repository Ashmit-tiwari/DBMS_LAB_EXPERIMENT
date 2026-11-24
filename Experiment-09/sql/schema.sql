DROP TABLE IF EXISTS Railway_Booking;

CREATE TABLE Railway_Booking (
    Booking_ID INT PRIMARY KEY,
    Passenger_Name VARCHAR(50) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Train_No INT,
    Train_Name VARCHAR(50),
    Source_Station VARCHAR(50),
    Destination_Station VARCHAR(50),
    Journey_Date DATE,
    Seat_No INT,
    Coach VARCHAR(10),
    Booking_Status VARCHAR(20),
    Fare DECIMAL(8,2)
);
