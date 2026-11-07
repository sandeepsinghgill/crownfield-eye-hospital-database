-- Crownfield Eye Hospital | CPU4:103
-- Part D: role-based access control and AES encryption demonstration
-- MariaDB 10.4.32
USE crownfield_eye_hospital;

-- Create the four database roles used in the assessment.
CREATE ROLE IF NOT EXISTS hospital_admin;
CREATE ROLE IF NOT EXISTS clinician_role;
CREATE ROLE IF NOT EXISTS receptionist_role;
CREATE ROLE IF NOT EXISTS pharmacist_role;

-- Hospital administrator: full privileges on this assessment database.
GRANT ALL PRIVILEGES ON crownfield_eye_hospital.* TO hospital_admin;

-- Clinician: read database records and maintain clinical records.
GRANT SELECT ON crownfield_eye_hospital.* TO clinician_role;
GRANT INSERT, UPDATE ON crownfield_eye_hospital.appointment_diagnosis TO clinician_role;
GRANT INSERT, UPDATE ON crownfield_eye_hospital.prescription TO clinician_role;
GRANT INSERT, UPDATE ON crownfield_eye_hospital.prescription_item TO clinician_role;
GRANT INSERT, UPDATE ON crownfield_eye_hospital.follow_up_plan TO clinician_role;
GRANT INSERT, UPDATE ON crownfield_eye_hospital.appointment_treatment TO clinician_role;

-- Receptionist: maintain patient and appointment administration records.
GRANT SELECT ON crownfield_eye_hospital.clinician TO receptionist_role;
GRANT SELECT ON crownfield_eye_hospital.specialty TO receptionist_role;
GRANT SELECT ON crownfield_eye_hospital.clinic TO receptionist_role;
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.patient TO receptionist_role;
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.appointment TO receptionist_role;

-- Pharmacist: view relevant records and maintain prescription details.
GRANT SELECT ON crownfield_eye_hospital.medicine TO pharmacist_role;
GRANT SELECT ON crownfield_eye_hospital.patient TO pharmacist_role;
GRANT SELECT ON crownfield_eye_hospital.appointment TO pharmacist_role;
GRANT SELECT, UPDATE ON crownfield_eye_hospital.prescription TO pharmacist_role;
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.prescription_item TO pharmacist_role;

-- Review role permissions. Run each statement to inspect the grants.
SHOW GRANTS FOR hospital_admin;
SHOW GRANTS FOR clinician_role;
SHOW GRANTS FOR receptionist_role;
SHOW GRANTS FOR pharmacist_role;

-- AES encryption/decryption demonstration using a demonstration-only key.
-- Do NOT use this example key for real patient data or commit real secrets.
SET @demo_key = 'REPLACE_WITH_A_PRIVATE_TEST_KEY';
SET @demo_note = 'Demonstration clinical note';
SELECT
    HEX(AES_ENCRYPT(@demo_note, @demo_key)) AS encrypted_value,
    CAST(AES_DECRYPT(AES_ENCRYPT(@demo_note, @demo_key), @demo_key) AS CHAR(255)) AS decrypted_value;

-- Roles are privilege sets. User accounts must be created and assigned roles
-- separately in a controlled environment; do not add real passwords to GitHub.
