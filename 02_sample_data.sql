-- Crownfield Eye Hospital Database
-- CPU4:103 Introduction to Database
-- Sample records extracted from the supplied MariaDB 10.4.32 backup.
-- Run 01_schema.sql first. This script inserts the supplied sample data.

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO `patient` VALUES ('P001','Amina Yusuf','UB3 3XY'),('P002','Daniel Reed','TW4 6CD'),('P003','Sofia Bennett','UB2 4EF'),('P004','Michael Okoro','TW5 0GH'),('P005','Emma Wilson','UB3 2JK'),('P006','James Patel','TW3 1LM'),('P007','Olivia Brown','UB4 8NP'),('P008','Noah Clarke','TW4 7QR'),('P009','Isabella Khan','UB2 9ST'),('P010','Thomas Green','TW5 3UV');

INSERT INTO `specialty` VALUES (7,'Cataract Surgery'),(6,'Corneal Surgery'),(4,'Glaucoma'),(8,'Neuro-Ophthalmology'),(9,'Oculoplastics'),(1,'Ophthalmology'),(2,'Optometry'),(10,'Orthoptics'),(5,'Paediatric Eye Care'),(3,'Retinal Surgery');

INSERT INTO `clinic` VALUES (5,'Cataract Clinic'),(6,'Corneal Clinic'),(7,'Emergency Eye Clinic'),(10,'Follow-up Clinic'),(3,'Glaucoma Clinic'),(9,'Laser Treatment Clinic'),(1,'Main Eye Clinic'),(8,'Optometry Clinic'),(4,'Paediatric Eye Clinic'),(2,'Retinal Clinic');

INSERT INTO `diagnosis` VALUES (3,'Astigmatism'),(5,'Cataracts'),(6,'Conjunctivitis'),(8,'Diabetic Retinopathy'),(7,'Dry Eye Syndrome'),(4,'Glaucoma'),(2,'Hyperopia'),(9,'Macular Degeneration'),(1,'Myopia'),(10,'Retinal Detachment');

INSERT INTO `medicine` VALUES (9,'Carbomer Gel'),(3,'Chloramphenicol'),(6,'Cyclopentolate'),(5,'Dexamethasone'),(1,'Latanoprost'),(4,'Lubricating Eye Drops'),(8,'Prednisolone Eye Drops'),(10,'Sodium Hyaluronate'),(2,'Timolol'),(7,'Tropicamide');

INSERT INTO `treatment` VALUES (6,'Cataract Surgery'),(8,'Contact Lens Fitting'),(10,'Dry Eye Therapy'),(1,'Eye Examination'),(5,'Laser Treatment'),(3,'OCT Scan'),(7,'Retinal Assessment'),(2,'Visual Acuity Test'),(4,'Visual Field Test'),(9,'眼 Pressure Measurement');

INSERT INTO `clinician` VALUES (1,'Dr Sarah Mitchell',1),(2,'Dr James Carter',2),(3,'Dr Priya Sharma',3),(4,'Dr Robert Lewis',4),(5,'Dr Emily Foster',5),(6,'Dr Ahmed Khan',6),(7,'Dr Helen Brooks',7),(8,'Dr David Wilson',8),(9,'Dr Rachel Green',9),(10,'Dr Mark Evans',10);

INSERT INTO `appointment` VALUES (1,'P001',2,8,'2026-11-10 09:00:00','Scheduled','Routine sight test'),(2,'P002',1,1,'2026-11-10 10:00:00','Scheduled','Comprehensive eye examination'),(3,'P003',3,2,'2026-11-11 09:30:00','Scheduled','Retinal assessment'),(4,'P004',4,3,'2026-11-11 11:00:00','Scheduled','Glaucoma monitoring'),(5,'P005',5,4,'2026-11-12 10:30:00','Scheduled','Paediatric eye examination'),(6,'P006',6,6,'2026-11-12 13:00:00','Scheduled','Corneal assessment'),(7,'P007',7,5,'2026-11-13 09:00:00','Scheduled','Cataract consultation'),(8,'P008',8,7,'2026-11-13 11:30:00','Scheduled','Neuro-ophthalmology review'),(9,'P009',9,9,'2026-11-14 14:00:00','Cancelled','Oculoplastics consultation'),(10,'P010',10,10,'2026-11-14 15:00:00','Scheduled','Orthoptic assessment'),(11,'P001',2,8,'2026-11-17 09:00:00','Scheduled','Follow-up sight test'),(12,'P003',3,2,'2026-11-18 10:00:00','Scheduled','Retinal review');

INSERT INTO `appointment_diagnosis` VALUES (1,1),(2,2),(3,8),(4,4),(5,3),(6,7),(7,5),(8,9),(9,6),(10,3);

INSERT INTO `prescription` VALUES (1,1,'Issued'),(2,2,'Issued'),(3,3,'Draft'),(4,4,'Issued'),(5,5,'Draft'),(6,6,'Issued'),(7,7,'Draft'),(8,8,'Issued'),(9,9,'Cancelled'),(10,10,'Issued');

INSERT INTO `prescription_item` VALUES (1,1,1,'1 drop','Ophthalmic','Once daily',30),(2,1,4,'1 drop','Ophthalmic','Four times daily',14),(3,1,2,'1 drop','Ophthalmic','Twice daily',30),(4,1,1,'1 drop','Ophthalmic','Once daily',60),(5,1,4,'1 drop','Ophthalmic','As required',7),(6,1,9,'1 application','Ophthalmic','At bedtime',14),(7,1,8,'1 drop','Ophthalmic','Three times daily',14),(8,1,10,'1 drop','Ophthalmic','Three times daily',30),(9,1,3,'1 drop','Ophthalmic','Four times daily',7),(10,1,6,'1 drop','Ophthalmic','As directed',1);

INSERT INTO `follow_up_plan` VALUES (1,1,'2027-05-10','Routine','Planned'),(2,2,'2026-12-10','Routine','Planned'),(3,3,'2026-11-25','High','Planned'),(4,4,'2026-12-01','High','Planned'),(5,5,'2027-01-12','Routine','Planned'),(6,6,'2026-12-12','Routine','Planned'),(7,7,'2026-12-13','High','Planned'),(8,8,'2026-12-14','Urgent','Planned'),(9,9,'2026-11-21','Routine','Planned'),(10,10,'2027-02-14','Routine','Planned');

INSERT INTO `appointment_treatment` VALUES (1,1,1,'Planned','Routine eye examination'),(2,2,2,'Planned','Visual acuity assessment'),(3,3,3,'Planned','OCT retinal imaging'),(4,4,4,'Planned','Visual field monitoring'),(5,5,8,'Planned','Contact lens assessment'),(6,6,10,'Planned','Dry eye management'),(7,7,6,'Planned','Cataract surgery consultation'),(8,8,7,'Planned','Retinal assessment'),(9,9,1,'Planned','Eye examination');

SET FOREIGN_KEY_CHECKS = 1;
