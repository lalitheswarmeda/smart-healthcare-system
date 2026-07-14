-- Insert Dummy Hospitals
INSERT INTO hospital (name, location_lat, location_lng, total_icu_beds, available_icu_beds, total_ward_beds, available_ward_beds) 
VALUES ('City Central Hospital', 40.7128, -74.0060, 50, 12, 200, 45);

INSERT INTO hospital (name, location_lat, location_lng, total_icu_beds, available_icu_beds, total_ward_beds, available_ward_beds) 
VALUES ('County General', 40.7580, -73.9855, 30, 2, 100, 10);

-- Insert Dummy Ambulances
INSERT INTO ambulance (plate_number, status, current_lat, current_lng) 
VALUES ('AMB-001', 'AVAILABLE', 40.7306, -73.9352);

INSERT INTO ambulance (plate_number, status, current_lat, current_lng) 
VALUES ('AMB-002', 'AVAILABLE', 40.7589, -73.9851);
