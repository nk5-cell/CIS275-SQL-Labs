# Lab 6: Database Design, DDL Operations, and Multi-Table Views

**Target Environment:** T-SQL / Microsoft SQL Server (`CIS275Sandboxx`)

---

## Overview

This lab demonstrates core Data Definition Language (DDL) and Data Manipulation Language (DML) operations in Microsoft SQL Server. It models a simplified hospital patient registration, billing, and referral database system using relational tables with defined primary/foreign key constraints.

---

## Database Architecture

All tables use the custom prefix **`NK_`** to ensure unique naming within the shared database environment.

### Entity Relationship & Structure

* **`NK_Patients`** (Primary Patient Records)
* `PK_PatientsMRN` (INT, Primary Key, Identity)
* `FirstName`, `LastName`, `DateOfBirth`, `Address`, `ContactInformation`, `DoctorsID`, `PatientSex`
* `FK_RegistrationNumber` (INT, Foreign Key referencing `NK_PatientRegistration`)
* `DoctorSpecializedUnit`, `ReasonForHospitalVisit`


* **`NK_PatientRegistration`** (Encounter Details)
* `PK_RegistrationNumber` (INT, Primary Key, Identity)
* `RegistrationDateTIME`, `HealthInsuranceIDNumber`, `DoctorAssigned`, `HealthInsuranceName`
* `FK_PatientsMRN` (INT, Foreign Key referencing `NK_Patients`)


* **`NK_PatientInvoice`** (Billing Information)
* `PK_PatientInvoiceID` (INT, Primary Key, Identity)
* `InvoiceDate`, `BillingDate`, `InsuranceCoverageAmount`, `PaymentAmountDue`
* `FK_PatientsMRN` (INT, Foreign Key referencing `NK_Patients`)


* **`NK_MedicalStaff`** (Hospital Staff Directory)
* `PK_StaffID` (INT, Primary Key, Identity)
* `StaffRole`, `StaffFirstName`, `StaffLastName`


* **`NK_Referrals`** (Linking/Junction Entity for Staff and Patients)
* `PK_ReferralID` (INT, Primary Key, Identity)
* `FK_StaffID` (INT, Foreign Key referencing `NK_MedicalStaff`)
* `FK_PatientsMRN` (INT, Foreign Key referencing `NK_Patients`)



---

## Questions & Implementation Summary

### Question 1: Initial Schema Creation

* Created core relational tables (`NK_Patients`, `NK_PatientRegistration`, and `NK_PatientInvoice`).
* Configured identity-based primary keys and set up initial foreign key references.

### Question 2: Schema Modifications (`ALTER TABLE`)

* Extended existing tables with additional columns (`DoctorSpecializedUnit`, `ReasonForHospitalVisit`, `HealthInsuranceName`, `VisitTimeDuration`).
* Added `FK_RegistrationNumber` to `NK_Patients` as a foreign key linking to `NK_PatientRegistration`.

### Question 3: Data Insertion & FK Resolution

* Handled standard circular foreign key dependencies using `SET IDENTITY_INSERT ON/OFF` and non-null column adjustments (`ALTER COLUMN FK_RegistrationNumber INT NULL`).
* **Technical Note:** Inserted primary records prior to establishing foreign key relations, then executed an `UPDATE` command to resolve dependent key constraints.

### Question 4: Column Removal

* Dropped `VisitTimeDuration` from `NK_PatientRegistration` using `ALTER TABLE ... DROP COLUMN`.

### Question 5: Additional Relational Entities

* Added `NK_MedicalStaff` and `NK_Referrals` to handle staff assignments and patient referral relationships.

### Question 6: Data Updates (`UPDATE`)

* Updated multiple record fields across `NK_Patients`, `NK_PatientRegistration`, and `NK_PatientInvoice` using `DATEADD()` and targeted `WHERE` clauses based on key identifiers.

### Question 7: Comprehensive Multi-Table View (`NK_HospitalData`)

* Created a consolidated view (`NK_HospitalData`) utilizing `LEFT JOIN` operations across all four main entities (`NK_Patients`, `NK_PatientRegistration`, `NK_PatientInvoice`, `NK_Referrals`, and `NK_MedicalStaff`).
* Applied field aliases to render user-friendly, descriptive column headers.
