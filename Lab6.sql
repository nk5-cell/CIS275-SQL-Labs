
PRINT 'Question 1:
Create tables
-------------
Review your assignment 7. If you never finished it, email your instructor.

Pick three related tables you identified for your system.
Create those tables within the CIS275Sandboxx database. Here are things you need to follow:
1- All table names must start with your initials, such as GSF_Nurses. If they exist (another
   student has the same initials), add a number to the end of your initials to make it unique.
2- If any tables are many-to-many don''t forget to add the linking table.
3- Add all your columns. The columns must be identical to the columns you proposed
   in your lab 7, with any corrections based on the feedback.
4- All your primary and foreign keys must be identified.

You have the permissions required to create tables in the CIS275Sandboxx database.
You cannot create Databases.
' + CHAR(10)

GO


--
--
USE CIS275Sandboxx
CREATE TABLE NK_Patients (
PK_PatientsMRN      INT IDENTITY PRIMARY KEY,
FirstName           VARCHAR(40) NULL,
LastName            VARCHAR(40) NULL,
DateOfBirth         DATE NULL,
Address             VARCHAR(50) NOT NULL,
ContactInformation  VARCHAR(20) NULL,
DoctorsID           VARCHAR(50) NOT NULL,
PatientSex          VARCHAR(6) NOT NULL,
);
CREATE TABLE NK_PatientRegistration (
PK_RegistrationNumber   INT IDENTITY PRIMARY KEY,
RegistrationDateTIME    DATETIME NULL,
HealthInsuranceIDNumber INT NOT NULL,
DoctorAssigned          VARCHAR(40) NULL,
FK_PatientsMRN          INT REFERENCES NK_Patients (PK_PatientsMRN)
);
CREATE TABLE NK_PatientInvoice (
PK_PatientInvoiceID     INT IDENTITY PRIMARY KEY,
InvoiceDate             DATE NULL,
BillingDate             DATE NULL,
InsuranceCoverageAmount     MONEY NULL,
PaymentAmountDue        MONEY NULL,
FK_PatientsMRN          INT REFERENCES NK_Patients (PK_PatientsMRN)
);


--

GO
PRINT 'Question 2:
Adding columns
-----------
Add two more columns to each of two of the tables you created.

' + CHAR(10)

GO

--
--
USE CIS275Sandboxx

ALTER TABLE NK_Patients
ADD FK_RegistrationNumber   INT NOT NULL,
    CONSTRAINT FK_RegistrationNumber
    FOREIGN KEY (FK_RegistrationNumber) REFERENCES NK_PatientRegistration (PK_RegistrationNumber);
ALTER TABLE NK_Patients
ADD DoctorSpecializedUnit   VARCHAR(40) NULL,
    ReasonForHospitalVisit  VARCHAR(50) NOT NULL;
ALTER TABLE NK_PatientRegistration
ADD HealthInsuranceName VARCHAR(40) NULL,
    VisitTimeDuration TIME NULL;
--

GO
PRINT 'Question 3:
Adding data
-----------
Use INSERT INTO to add four records to each of the tables you created in Question 1.
You need meaningful data (not things like MMMMM!).

' + CHAR(10)

GO

--

ALTER TABLE NK_Patients
ALTER COLUMN FK_RegistrationNumber INT NULL;

SET IDENTITY_INSERT NK_Patients ON;
INSERT INTO NK_Patients (PK_PatientsMRN, FirstName, LastName, DateOfBirth, Address, ContactInformation, DoctorsID, PatientSex, DoctorSpecializedUnit, ReasonForHospitalVisit)
VALUES (7492011, 'Jared', 'Halstvedt', '1996-03-17', '13205 SE Foster Rd, Portland, OR 97236', '(971)889-0654', 'MR19905', 'Male', 'Spine Surgeon', 'Spine Fusion Surgery Follow-up');
SET IDENTITY_INSERT NK_Patients OFF;

SET IDENTITY_INSERT NK_PatientRegistration ON;
INSERT INTO NK_PatientRegistration (PK_RegistrationNumber, RegistrationDateTIME, HealthInsuranceIDNumber, DoctorAssigned, FK_PatientsMRN, HealthInsuranceName, VisitTimeDuration)
VALUES (1937763276, '2026-03-01 08:00:00', 923783, 'Robert Tatsumi', 7492011, 'CareOregon', '00:40:00');
SET IDENTITY_INSERT NK_PatientRegistration OFF;

UPDATE NK_Patients
SET FK_RegistrationNumber = 1937763276
WHERE PK_PatientsMRN = 7492011;

INSERT INTO NK_PatientInvoice (InvoiceDate, BillingDate, InsuranceCoverageAmount, PaymentAmountDue, FK_PatientsMRN)
VALUES ('2026-03-02', '2026-03-02', 125.85, 0.00, 7492011);

--This is the code I had first, but this code was causing errors, so I asked Gemini:
-- "Explain to me what's wrong with this code". And Gemini told me that "If your
-- database has a standard Foreign Key constraint enabled, the first INSERT will fail
-- because the "parent" record in the registration table doesn't exist yet." So, I
-- deleted that Foreign key and then updated it after two tables in that patients
-- table. Gemini also told me that I should SET INSERT_IDENTITY, so I did that for
-- the first two tables, and alterted the patients table and the column forgein key
-- so it doesn't cause errors in the system.
-- CODE:
-- INSERT INTO NK_Patients (PK_PatientsMRN, FirstName, LastName, DateOfBirth, Address, ContactInformation, DoctorsID, PatientSex, FK_RegistrationNumber, DoctorSpecializedUnit, ReasonForHospitalVisit)
-- VALUES (7492011, 'Jared', 'Halstvedt', '1996-03-17', '13205 SE Foster Rd, Portland, OR 97236', '(971)889-0654', 'MR19905', 'Male', 1937763276, 'Spine Surgeon', 'Spine Fusion Surgery Follow-up');
-- INSERT INTO NK_PatientRegistration (PK_RegistrationNumber, RegistrationDateTIME, HealthInsuranceIDNumber, DoctorAssigned, FK_PatientsMRN, HealthInsuranceName, VisitTimeDuration)
-- VALUES (1937763276, '2026-03-01 08:00:00', 923783, 'Robert Tatsumi', 7492011, 'CareOregon', '00:40:00');
-- INSERT INTO NK_PatientInvoice (PK_PatientInvoiceID, InvoiceDate, BillingDate, InsuranceCoverageAmount, PaymentAmountDue, FK_PatientsMRN)
-- VALUES (21424374, '2026-03-02', '2026-03-02', 125.85, 0.00, 7492011);

--

GO
PRINT 'Question 4:
Drop a column
---------------------
Drop one column from one of the tables.
' + CHAR(10)

GO

--
ALTER TABLE NK_PatientRegistration
DROP COLUMN VisitTimeDuration;

--

GO
PRINT 'Question 5:
Add a new table
-------------
Pick another table from your last assignment and add it to the database with all its columns.
    Don''t forget to take care of any relationships it might be in.
Once again, all tables must start with your initials.
Add three records to this table.
' + CHAR(10)

GO

--
USE CIS275Sandboxx
CREATE TABLE NK_MedicalStaff (
PK_StaffID          INT IDENTITY PRIMARY KEY,
StaffRole           VARCHAR(50) NOT NULL,
StaffFirstName      VARCHAR(40) NULL,
StaffLastName       VARCHAR(40) NULL
);
CREATE TABLE NK_Referrals (
PK_ReferralID       INT IDENTITY PRIMARY KEY,
FK_StaffID          INT REFERENCES NK_MedicalStaff (PK_StaffID),
FK_PatientsMRN      INT REFERENCES NK_Patients (PK_PatientsMRN)
);

--

GO
PRINT 'Question 6:
Changing values
---------------
Use UPDATE commands to change the values of three columns of each table
' + CHAR(10)

GO

--
--

UPDATE NK_Patients
SET Address = '20898 SW Foster Rd, Hillsboro, OR 97236',
    ContactInformation = '(503)992-0072',
    DoctorsID = 'NY26505'
WHERE PK_PatientsMRN = 7492011;

UPDATE NK_PatientRegistration
SET RegistrationDateTIME = '2026-03-01 09:30:00',
    DoctorAssigned = 'Alex Ching',
    HealthInsuranceIDNumber = 923784
WHERE PK_RegistrationNumber = 1937763276;

UPDATE NK_PatientInvoice
SET InvoiceDate = DATEADD(DAY, 30, InvoiceDate),
    BillingDate = DATEADD(DAY, 30, InvoiceDate),
    PaymentAmountDue = 50.00
WHERE PK_PatientInvoiceID = 6;


--In order to update values for Table NK_MedicalStaff and
-- Table NK_Referrals, we need to insert values first for
-- their columns, and then I think we'll be able to update,
-- since there are no values inserted, I am leaving these
-- tables as it is
--

GO
PRINT 'Question 7:
Creating views
--------------
Create a VIEW that uses a JOIN query to display the content of your four related tables.
Include all the columns and rows from all four tables in your query.
Do not forget to add your initials at the beginning of the name.

Then display all rows and columns from your view.
' + CHAR(10)

GO

--
--
CREATE VIEW NK_HospitalData
AS
SELECT  p.PK_PatientsMRN AS "Patient MRN",
        p.FirstName AS "First Name",
        p.LastName AS "Last Name",
        p.DateOfBirth AS "DOB",
        p.Address AS "Address",
        p.ContactInformation AS "Contact Information",
        p.DoctorsID AS "Doctors ID",
        p.PatientSex AS "Patient Sex",
        p.DoctorSpecializedUnit AS "Doctor Specialized Unit",
        p.ReasonForHospitalVisit AS "Reason For Hospital Visit",
        r.PK_RegistrationNumber AS "Registration Number",
        r.RegistrationDateTIME AS "Registration Date and Time",
        r.HealthInsuranceIDNumber AS "Health Insurance ID Number",
        r.DoctorAssigned AS "Doctor Assigned",
        r.HealthInsuranceName AS "Health Insurance Name",
        i.InvoiceDate AS "Invoice Date",
        i.BillingDate AS "Billing Date",
        i.InsuranceCoverageAmount AS "Insurance Coverage Amount",
        i.PaymentAmountDue AS "Payment Amount Due",
        s.PK_ReferralID AS "Referral ID",
        m.PK_StaffID AS "Staff ID",
        m.StaffRole AS "Staff Role",
        m.StaffFirstName AS "Staff First Name",
        m.StaffLastName AS "Staff Last Name"
FROM NK_Patients p
LEFT JOIN NK_PatientRegistration r ON r.FK_PatientsMRN = p.PK_PatientsMRN
LEFT JOIN NK_PatientInvoice i ON i.FK_PatientsMRN = p.PK_PatientsMRN
LEFT JOIN NK_Referrals s ON s.FK_PatientsMRN = p.PK_PatientsMRN
LEFT JOIN NK_MedicalStaff m ON m.PK_StaffID = s.FK_StaffID;

--
USE NAMES;
SELECT Year, Name, Gender, NameCount
FROM year_gender_totals y
JOIN name_counts n ON n.FK_YearGenderTotalID = y.YearGenderTotalID
JOIN names s ON s.NameID = n.FK_NameID
WHERE Name = 'Anna';

USE NAMES;
SELECT *
FROM names
