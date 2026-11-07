-- Crownfield Eye Hospital Database
-- CPU4:103 Introduction to Database
-- Schema extracted from the supplied MariaDB 10.4.32 backup.
-- Re-running this script DROPS and recreates the assessment tables.
-- Use only for this assessment database; do not run against production data.

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `appointment_treatment`;
DROP TABLE IF EXISTS `follow_up_plan`;
DROP TABLE IF EXISTS `prescription_item`;
DROP TABLE IF EXISTS `prescription`;
DROP TABLE IF EXISTS `appointment_diagnosis`;
DROP TABLE IF EXISTS `appointment`;
DROP TABLE IF EXISTS `clinician`;
DROP TABLE IF EXISTS `treatment`;
DROP TABLE IF EXISTS `medicine`;
DROP TABLE IF EXISTS `diagnosis`;
DROP TABLE IF EXISTS `clinic`;
DROP TABLE IF EXISTS `specialty`;
DROP TABLE IF EXISTS `patient`;

CREATE TABLE `patient` (
  `patient_id` varchar(10) NOT NULL,
  `patient_name` varchar(150) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `specialty` (
  `specialty_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `specialty_name` varchar(100) NOT NULL,
  PRIMARY KEY (`specialty_id`),
  UNIQUE KEY `specialty_name` (`specialty_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `clinic` (
  `clinic_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clinic_name` varchar(100) NOT NULL,
  PRIMARY KEY (`clinic_id`),
  UNIQUE KEY `clinic_name` (`clinic_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `diagnosis` (
  `diagnosis_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `diagnosis_name` varchar(150) NOT NULL,
  PRIMARY KEY (`diagnosis_id`),
  UNIQUE KEY `diagnosis_name` (`diagnosis_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `medicine` (
  `medicine_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(150) NOT NULL,
  PRIMARY KEY (`medicine_id`),
  UNIQUE KEY `medicine_name` (`medicine_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `treatment` (
  `treatment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `treatment_name` varchar(150) NOT NULL,
  PRIMARY KEY (`treatment_id`),
  UNIQUE KEY `treatment_name` (`treatment_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `clinician` (
  `clinician_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clinician_name` varchar(150) NOT NULL,
  `specialty_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`clinician_id`),
  KEY `fk_clinician_specialty` (`specialty_id`),
  CONSTRAINT `fk_clinician_specialty` FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`specialty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `appointment` (
  `appointment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(10) NOT NULL,
  `clinician_id` int(10) unsigned NOT NULL,
  `clinic_id` int(10) unsigned NOT NULL,
  `appointment_at` datetime NOT NULL,
  `appointment_status` varchar(20) NOT NULL DEFAULT 'Scheduled',
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `fk_appointment_patient` (`patient_id`),
  KEY `fk_appointment_clinician` (`clinician_id`),
  KEY `fk_appointment_clinic` (`clinic_id`),
  CONSTRAINT `fk_appointment_clinic` FOREIGN KEY (`clinic_id`) REFERENCES `clinic` (`clinic_id`),
  CONSTRAINT `fk_appointment_clinician` FOREIGN KEY (`clinician_id`) REFERENCES `clinician` (`clinician_id`),
  CONSTRAINT `fk_appointment_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `chk_appointment_status` CHECK (`appointment_status` in ('Scheduled','Completed','Cancelled','DidNotAttend','Unknown'))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `appointment_diagnosis` (
  `appointment_id` int(10) unsigned NOT NULL,
  `diagnosis_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`appointment_id`,`diagnosis_id`),
  KEY `fk_apptdiagnosis_diagnosis` (`diagnosis_id`),
  CONSTRAINT `fk_apptdiagnosis_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `fk_apptdiagnosis_diagnosis` FOREIGN KEY (`diagnosis_id`) REFERENCES `diagnosis` (`diagnosis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `prescription` (
  `prescription_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appointment_id` int(10) unsigned NOT NULL,
  `prescription_status` varchar(12) NOT NULL DEFAULT 'Draft',
  PRIMARY KEY (`prescription_id`),
  KEY `fk_prescription_appointment` (`appointment_id`),
  CONSTRAINT `fk_prescription_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `chk_prescription_status` CHECK (`prescription_status` in ('Draft','Issued','Cancelled'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `prescription_item` (
  `prescription_id` int(10) unsigned NOT NULL,
  `line_no` smallint(5) unsigned NOT NULL,
  `medicine_id` int(10) unsigned NOT NULL,
  `dose` varchar(100) DEFAULT NULL,
  `route` varchar(50) DEFAULT NULL,
  `frequency` varchar(100) DEFAULT NULL,
  `duration_days` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`prescription_id`,`line_no`),
  KEY `fk_item_medicine` (`medicine_id`),
  CONSTRAINT `fk_item_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicine` (`medicine_id`),
  CONSTRAINT `fk_item_prescription` FOREIGN KEY (`prescription_id`) REFERENCES `prescription` (`prescription_id`),
  CONSTRAINT `chk_prescription_line` CHECK (`line_no` > 0),
  CONSTRAINT `chk_duration_days` CHECK (`duration_days` is null or `duration_days` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `follow_up_plan` (
  `follow_up_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appointment_id` int(10) unsigned NOT NULL,
  `due_date` date NOT NULL,
  `priority` varchar(10) NOT NULL,
  `follow_up_status` varchar(12) NOT NULL DEFAULT 'Planned',
  PRIMARY KEY (`follow_up_id`),
  UNIQUE KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `fk_followup_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `chk_followup_priority` CHECK (`priority` in ('Routine','High','Urgent')),
  CONSTRAINT `chk_followup_status` CHECK (`follow_up_status` in ('Planned','Completed','Cancelled','Unknown'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `appointment_treatment` (
  `appointment_treatment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appointment_id` int(10) unsigned NOT NULL,
  `treatment_id` int(10) unsigned NOT NULL,
  `treatment_status` varchar(12) NOT NULL DEFAULT 'Planned',
  `treatment_notes` text DEFAULT NULL,
  PRIMARY KEY (`appointment_treatment_id`),
  KEY `fk_appttreatment_appointment` (`appointment_id`),
  KEY `fk_appttreatment_treatment` (`treatment_id`),
  CONSTRAINT `fk_appttreatment_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `fk_appttreatment_treatment` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`treatment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
