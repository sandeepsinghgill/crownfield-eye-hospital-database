-- Crownfield Eye Hospital | CPU4:103
-- Part C: Stored procedure and business-rule trigger
-- MariaDB 10.4.32
USE crownfield_eye_hospital;

-- Stored procedure: return appointments for one patient, including clinician and clinic.
DROP PROCEDURE IF EXISTS GetPatientAppointments;
DELIMITER //
CREATE PROCEDURE GetPatientAppointments(IN p_patient_id VARCHAR(10))
BEGIN
    SELECT
        p.patient_id,
        p.patient_name,
        a.appointment_id,
        a.appointment_at,
        a.appointment_status,
        c.clinician_name,
        cl.clinic_name
    FROM patient AS p
    INNER JOIN appointment AS a ON a.patient_id = p.patient_id
    INNER JOIN clinician AS c ON c.clinician_id = a.clinician_id
    INNER JOIN clinic AS cl ON cl.clinic_id = a.clinic_id
    WHERE p.patient_id = p_patient_id
    ORDER BY a.appointment_at;
END //
DELIMITER ;

-- Example procedure call (P001 should return the patient's two appointments).
CALL GetPatientAppointments('P001');

-- Trigger: prevent issuing a prescription if its linked appointment is cancelled.
DROP TRIGGER IF EXISTS prevent_issued_cancelled_prescription;
DELIMITER //
CREATE TRIGGER prevent_issued_cancelled_prescription
BEFORE UPDATE ON prescription
FOR EACH ROW
BEGIN
    DECLARE linked_status VARCHAR(20);
    IF NEW.prescription_status = 'Issued'
       AND OLD.prescription_status <> 'Issued' THEN
        SELECT appointment_status
          INTO linked_status
          FROM appointment
         WHERE appointment_id = NEW.appointment_id;
        IF linked_status = 'Cancelled' THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Cannot issue a prescription for a cancelled appointment';
        END IF;
    END IF;
END //
DELIMITER ;

-- The trigger was tested by temporarily attempting to issue a prescription
-- linked to a cancelled appointment. MariaDB rejected the update with error 1644.
-- The trigger test evidence is supplied separately in the assessment screenshots.
