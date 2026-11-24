CREATE INDEX idx_train_no 
ON Railway_Booking(Train_No);

CREATE INDEX idx_passenger_name 
ON Railway_Booking(Passenger_Name);

CREATE INDEX idx_booking_status 
ON Railway_Booking(Booking_Status);

CREATE INDEX idx_source_station 
ON Railway_Booking(Source_Station);

CREATE INDEX idx_journey_date 
ON Railway_Booking(Journey_Date);

CREATE INDEX idx_fare 
ON Railway_Booking(Fare);

CREATE INDEX idx_train_date 
ON Railway_Booking(Train_No, Journey_Date);
