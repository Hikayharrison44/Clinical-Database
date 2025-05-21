-- ================================================
-- 🚀 Clinic Booking System Database Schema
-- Author: [Your Name]
-- Description: This SQL script creates the schema 
-- for a clinic appointment and record management system.
-- ================================================

-- Drop tables if they exist to avoid errors on re-run
DROP TABLE IF EXISTS Prescriptions, Diagnoses, Appointments, Patients, Doctors, Specialties, Users;

-- ================================================
-- 👤 Users Table (for login and role-based access)
-- ================================================
CREATE TABLE Users (
    userID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'doctor', 'receptionist') NOT NULL
);

-- ================================================
-- 🩺 Specialties Table
-- ================================================
CREATE TABLE Specialties (
    specialtyID INT PRIMARY KEY AUTO_INCREMENT,
    specialtyName VARCHAR(100) NOT NULL UNIQUE
);

-- ================================================
-- 👨‍⚕️ Doctors Table
-- ================================================
CREATE TABLE Doctors (
    doctorID INT PRIMARY KEY AUTO_INCREMENT,
    fullName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    specialtyID INT,
    FOREIGN KEY (specialtyID) REFERENCES Specialties(specialtyID)
);

-- ================================================
-- 🧑‍🦽 Patients Table
-- ================================================
CREATE TABLE Patients (
    patientID INT PRIMARY KEY AUTO_INCREMENT,
    fullName VARCHAR(100) NOT NULL,
    dateOfBirth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

-- ================================================
-- 📅 Appointments Table
-- ================================================
CREATE TABLE Appointments (
    appointmentID INT PRIMARY KEY AUTO_INCREMENT,
    patientID INT NOT NULL,
    doctorID INT NOT NULL,
    appointmentDate DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID)
);

-- ================================================
-- 🩻 Diagnoses Table
-- ================================================
CREATE TABLE Diagnoses (
    diagnosisID INT PRIMARY KEY AUTO_INCREMENT,
    appointmentID INT NOT NULL,
    diagnosis TEXT NOT NULL,
    notes TEXT,
    FOREIGN KEY (appointmentID) REFERENCES Appointments(appointmentID)
);

-- ================================================
-- 💊 Prescriptions Table
-- ================================================
CREATE TABLE Prescriptions (
    prescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    diagnosisID INT NOT NULL,
    medication VARCHAR(100) NOT NULL,
    dosage VARCHAR(100),
    frequency VARCHAR(100),
    FOREIGN KEY (diagnosisID) REFERENCES Diagnoses(diagnosisID)
);