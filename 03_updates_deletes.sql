-- Crownfield Eye Hospital Database
-- CPU4:103 Introduction to Database
-- Part C: UPDATE and DELETE demonstration
-- These statements reflect the tests performed during implementation.
--
-- IMPORTANT:
-- The supplied backup already contains the updated postcode for P001
-- and already reflects the deletion of appointment_treatment_id = 10.
-- Therefore, when run against the supplied backup, the UPDATE will set
-- the same postcode value again and the DELETE may affect 0 rows.
-- This file documents the tested operations; it is not a reset script.

USE crownfield_eye_hospital;

-- UPDATE test:
-- P001 (Amina Yusuf) was updated to postcode UB3 3XY.
UPDATE patient
SET postcode = 'UB3 3XY'
WHERE patient_id = 'P001';

-- Verification for the UPDATE test:
SELECT patient_id, patient_name, postcode
FROM patient
WHERE patient_id = 'P001';

-- DELETE test:
-- The test removed appointment-treatment record 10.
-- In the supplied backup this row is already absent, as the backup
-- was exported after the test. Running this statement again is safe.
DELETE FROM appointment_treatment
WHERE appointment_treatment_id = 10;

-- Verification for the DELETE test:
SELECT COUNT(*) AS remaining_appointment_treatment_records
FROM appointment_treatment;

SELECT *
FROM appointment_treatment
WHERE appointment_treatment_id = 10;
