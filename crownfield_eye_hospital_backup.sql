-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: crownfield_eye_hospital
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,'P001',2,8,'2026-11-10 09:00:00','Scheduled','Routine sight test'),(2,'P002',1,1,'2026-11-10 10:00:00','Scheduled','Comprehensive eye examination'),(3,'P003',3,2,'2026-11-11 09:30:00','Scheduled','Retinal assessment'),(4,'P004',4,3,'2026-11-11 11:00:00','Scheduled','Glaucoma monitoring'),(5,'P005',5,4,'2026-11-12 10:30:00','Scheduled','Paediatric eye examination'),(6,'P006',6,6,'2026-11-12 13:00:00','Scheduled','Corneal assessment'),(7,'P007',7,5,'2026-11-13 09:00:00','Scheduled','Cataract consultation'),(8,'P008',8,7,'2026-11-13 11:30:00','Scheduled','Neuro-ophthalmology review'),(9,'P009',9,9,'2026-11-14 14:00:00','Cancelled','Oculoplastics consultation'),(10,'P010',10,10,'2026-11-14 15:00:00','Scheduled','Orthoptic assessment'),(11,'P001',2,8,'2026-11-17 09:00:00','Scheduled','Follow-up sight test'),(12,'P003',3,2,'2026-11-18 10:00:00','Scheduled','Retinal review');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_diagnosis`
--

DROP TABLE IF EXISTS `appointment_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_diagnosis` (
  `appointment_id` int(10) unsigned NOT NULL,
  `diagnosis_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`appointment_id`,`diagnosis_id`),
  KEY `fk_apptdiagnosis_diagnosis` (`diagnosis_id`),
  CONSTRAINT `fk_apptdiagnosis_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `fk_apptdiagnosis_diagnosis` FOREIGN KEY (`diagnosis_id`) REFERENCES `diagnosis` (`diagnosis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_diagnosis`
--

LOCK TABLES `appointment_diagnosis` WRITE;
/*!40000 ALTER TABLE `appointment_diagnosis` DISABLE KEYS */;
INSERT INTO `appointment_diagnosis` VALUES (1,1),(2,2),(3,8),(4,4),(5,3),(6,7),(7,5),(8,9),(9,6),(10,3);
/*!40000 ALTER TABLE `appointment_diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_treatment`
--

DROP TABLE IF EXISTS `appointment_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_treatment`
--

LOCK TABLES `appointment_treatment` WRITE;
/*!40000 ALTER TABLE `appointment_treatment` DISABLE KEYS */;
INSERT INTO `appointment_treatment` VALUES (1,1,1,'Planned','Routine eye examination'),(2,2,2,'Planned','Visual acuity assessment'),(3,3,3,'Planned','OCT retinal imaging'),(4,4,4,'Planned','Visual field monitoring'),(5,5,8,'Planned','Contact lens assessment'),(6,6,10,'Planned','Dry eye management'),(7,7,6,'Planned','Cataract surgery consultation'),(8,8,7,'Planned','Retinal assessment'),(9,9,1,'Planned','Eye examination');
/*!40000 ALTER TABLE `appointment_treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic`
--

DROP TABLE IF EXISTS `clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic` (
  `clinic_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clinic_name` varchar(100) NOT NULL,
  PRIMARY KEY (`clinic_id`),
  UNIQUE KEY `clinic_name` (`clinic_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic`
--

LOCK TABLES `clinic` WRITE;
/*!40000 ALTER TABLE `clinic` DISABLE KEYS */;
INSERT INTO `clinic` VALUES (5,'Cataract Clinic'),(6,'Corneal Clinic'),(7,'Emergency Eye Clinic'),(10,'Follow-up Clinic'),(3,'Glaucoma Clinic'),(9,'Laser Treatment Clinic'),(1,'Main Eye Clinic'),(8,'Optometry Clinic'),(4,'Paediatric Eye Clinic'),(2,'Retinal Clinic');
/*!40000 ALTER TABLE `clinic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinician`
--

DROP TABLE IF EXISTS `clinician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinician` (
  `clinician_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clinician_name` varchar(150) NOT NULL,
  `specialty_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`clinician_id`),
  KEY `fk_clinician_specialty` (`specialty_id`),
  CONSTRAINT `fk_clinician_specialty` FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`specialty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinician`
--

LOCK TABLES `clinician` WRITE;
/*!40000 ALTER TABLE `clinician` DISABLE KEYS */;
INSERT INTO `clinician` VALUES (1,'Dr Sarah Mitchell',1),(2,'Dr James Carter',2),(3,'Dr Priya Sharma',3),(4,'Dr Robert Lewis',4),(5,'Dr Emily Foster',5),(6,'Dr Ahmed Khan',6),(7,'Dr Helen Brooks',7),(8,'Dr David Wilson',8),(9,'Dr Rachel Green',9),(10,'Dr Mark Evans',10);
/*!40000 ALTER TABLE `clinician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnosis` (
  `diagnosis_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `diagnosis_name` varchar(150) NOT NULL,
  PRIMARY KEY (`diagnosis_id`),
  UNIQUE KEY `diagnosis_name` (`diagnosis_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosis`
--

LOCK TABLES `diagnosis` WRITE;
/*!40000 ALTER TABLE `diagnosis` DISABLE KEYS */;
INSERT INTO `diagnosis` VALUES (3,'Astigmatism'),(5,'Cataracts'),(6,'Conjunctivitis'),(8,'Diabetic Retinopathy'),(7,'Dry Eye Syndrome'),(4,'Glaucoma'),(2,'Hyperopia'),(9,'Macular Degeneration'),(1,'Myopia'),(10,'Retinal Detachment');
/*!40000 ALTER TABLE `diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow_up_plan`
--

DROP TABLE IF EXISTS `follow_up_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow_up_plan`
--

LOCK TABLES `follow_up_plan` WRITE;
/*!40000 ALTER TABLE `follow_up_plan` DISABLE KEYS */;
INSERT INTO `follow_up_plan` VALUES (1,1,'2027-05-10','Routine','Planned'),(2,2,'2026-12-10','Routine','Planned'),(3,3,'2026-11-25','High','Planned'),(4,4,'2026-12-01','High','Planned'),(5,5,'2027-01-12','Routine','Planned'),(6,6,'2026-12-12','Routine','Planned'),(7,7,'2026-12-13','High','Planned'),(8,8,'2026-12-14','Urgent','Planned'),(9,9,'2026-11-21','Routine','Planned'),(10,10,'2027-02-14','Routine','Planned');
/*!40000 ALTER TABLE `follow_up_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine` (
  `medicine_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(150) NOT NULL,
  PRIMARY KEY (`medicine_id`),
  UNIQUE KEY `medicine_name` (`medicine_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine`
--

LOCK TABLES `medicine` WRITE;
/*!40000 ALTER TABLE `medicine` DISABLE KEYS */;
INSERT INTO `medicine` VALUES (9,'Carbomer Gel'),(3,'Chloramphenicol'),(6,'Cyclopentolate'),(5,'Dexamethasone'),(1,'Latanoprost'),(4,'Lubricating Eye Drops'),(8,'Prednisolone Eye Drops'),(10,'Sodium Hyaluronate'),(2,'Timolol'),(7,'Tropicamide');
/*!40000 ALTER TABLE `medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` varchar(10) NOT NULL,
  `patient_name` varchar(150) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES ('P001','Amina Yusuf','UB3 3XY'),('P002','Daniel Reed','TW4 6CD'),('P003','Sofia Bennett','UB2 4EF'),('P004','Michael Okoro','TW5 0GH'),('P005','Emma Wilson','UB3 2JK'),('P006','James Patel','TW3 1LM'),('P007','Olivia Brown','UB4 8NP'),('P008','Noah Clarke','TW4 7QR'),('P009','Isabella Khan','UB2 9ST'),('P010','Thomas Green','TW5 3UV');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `prescription_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appointment_id` int(10) unsigned NOT NULL,
  `prescription_status` varchar(12) NOT NULL DEFAULT 'Draft',
  PRIMARY KEY (`prescription_id`),
  KEY `fk_prescription_appointment` (`appointment_id`),
  CONSTRAINT `fk_prescription_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `chk_prescription_status` CHECK (`prescription_status` in ('Draft','Issued','Cancelled'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
INSERT INTO `prescription` VALUES (1,1,'Issued'),(2,2,'Issued'),(3,3,'Draft'),(4,4,'Issued'),(5,5,'Draft'),(6,6,'Issued'),(7,7,'Draft'),(8,8,'Issued'),(9,9,'Cancelled'),(10,10,'Issued');
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription_item`
--

DROP TABLE IF EXISTS `prescription_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription_item`
--

LOCK TABLES `prescription_item` WRITE;
/*!40000 ALTER TABLE `prescription_item` DISABLE KEYS */;
INSERT INTO `prescription_item` VALUES (1,1,1,'1 drop','Ophthalmic','Once daily',30),(2,1,4,'1 drop','Ophthalmic','Four times daily',14),(3,1,2,'1 drop','Ophthalmic','Twice daily',30),(4,1,1,'1 drop','Ophthalmic','Once daily',60),(5,1,4,'1 drop','Ophthalmic','As required',7),(6,1,9,'1 application','Ophthalmic','At bedtime',14),(7,1,8,'1 drop','Ophthalmic','Three times daily',14),(8,1,10,'1 drop','Ophthalmic','Three times daily',30),(9,1,3,'1 drop','Ophthalmic','Four times daily',7),(10,1,6,'1 drop','Ophthalmic','As directed',1);
/*!40000 ALTER TABLE `prescription_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialty`
--

DROP TABLE IF EXISTS `specialty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialty` (
  `specialty_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `specialty_name` varchar(100) NOT NULL,
  PRIMARY KEY (`specialty_id`),
  UNIQUE KEY `specialty_name` (`specialty_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialty`
--

LOCK TABLES `specialty` WRITE;
/*!40000 ALTER TABLE `specialty` DISABLE KEYS */;
INSERT INTO `specialty` VALUES (7,'Cataract Surgery'),(6,'Corneal Surgery'),(4,'Glaucoma'),(8,'Neuro-Ophthalmology'),(9,'Oculoplastics'),(1,'Ophthalmology'),(2,'Optometry'),(10,'Orthoptics'),(5,'Paediatric Eye Care'),(3,'Retinal Surgery');
/*!40000 ALTER TABLE `specialty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatment` (
  `treatment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `treatment_name` varchar(150) NOT NULL,
  PRIMARY KEY (`treatment_id`),
  UNIQUE KEY `treatment_name` (`treatment_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
INSERT INTO `treatment` VALUES (6,'Cataract Surgery'),(8,'Contact Lens Fitting'),(10,'Dry Eye Therapy'),(1,'Eye Examination'),(5,'Laser Treatment'),(3,'OCT Scan'),(7,'Retinal Assessment'),(2,'Visual Acuity Test'),(4,'Visual Field Test'),(9,'眼 Pressure Measurement');
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-07 22:14:53
