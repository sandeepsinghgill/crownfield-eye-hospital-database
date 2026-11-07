-- Crownfield Eye Hospital Database
-- CPU4:103 Introduction to Database
-- Part C: Individual SQL queries demonstrated and tested in MariaDB 10.4.32

USE crownfield_eye_hospital;

-- C1. Aggregate query: count appointments for each clinician.
-- GROUP BY groups the appointments by clinician; HAVING filters to clinicians
-- with more than one appointment.
SELECT
    c.clinician_id,
    c.clinician_name,
    COUNT(a.appointment_id) AS appointment_count
FROM clinician AS c
INNER JOIN appointment AS a
    ON a.clinician_id = c.clinician_id
GROUP BY c.clinician_id, c.clinician_name
HAVING COUNT(a.appointment_id) > 1
ORDER BY appointment_count DESC, c.clinician_name;

-- C2. Multi-table INNER JOIN: show patient, appointment, clinician and diagnosis.
SELECT
    p.patient_id,
    p.patient_name,
    a.appointment_id,
    a.appointment_at,
    c.clinician_name,
    d.diagnosis_name
FROM patient AS p
INNER JOIN appointment AS a
    ON a.patient_id = p.patient_id
INNER JOIN clinician AS c
    ON c.clinician_id = a.clinician_id
INNER JOIN appointment_diagnosis AS ad
    ON ad.appointment_id = a.appointment_id
INNER JOIN diagnosis AS d
    ON d.diagnosis_id = ad.diagnosis_id
ORDER BY a.appointment_id;

-- C3. LEFT JOIN: include all appointments, including those without a follow-up plan.
SELECT
    a.appointment_id,
    p.patient_name,
    a.appointment_status,
    f.follow_up_id,
    f.due_date,
    f.follow_up_status
FROM appointment AS a
INNER JOIN patient AS p
    ON p.patient_id = a.patient_id
LEFT JOIN follow_up_plan AS f
    ON f.appointment_id = a.appointment_id
ORDER BY a.appointment_id;

-- C4. Subquery: find patients whose clinician has more than one appointment.
SELECT DISTINCT
    p.patient_id,
    p.patient_name
FROM patient AS p
INNER JOIN appointment AS a
    ON a.patient_id = p.patient_id
WHERE a.clinician_id IN (
    SELECT clinician_id
    FROM appointment
    GROUP BY clinician_id
    HAVING COUNT(*) > 1
)
ORDER BY p.patient_id;
