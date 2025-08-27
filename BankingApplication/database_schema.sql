-- Banking Application Database Schema
-- MySQL Database

-- Create database
CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('CUSTOMER', 'ADMIN') NOT NULL DEFAULT 'CUSTOMER',
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE', 'PENDING', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    rejection_reason TEXT NULL, -- Reason for rejection if status is REJECTED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Accounts table
CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    account_number VARCHAR(20) NOT NULL UNIQUE,
    account_type ENUM('SAVINGS', 'CHECKING', 'FIXED_DEPOSIT') NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0.00,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Transactions table
CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    from_account_id INT NOT NULL,
    to_account_id INT NOT NULL,
    transaction_type ENUM('TRANSFER', 'DEPOSIT', 'WITHDRAWAL', 'LOAN_DISBURSEMENT') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    description TEXT,
    status ENUM('PENDING', 'COMPLETED', 'FAILED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_account_id) REFERENCES accounts(id) ON DELETE CASCADE,
    FOREIGN KEY (to_account_id) REFERENCES accounts(id) ON DELETE CASCADE
);

-- Loans table
CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    loan_type ENUM('PERSONAL', 'HOME', 'BUSINESS', 'EDUCATION', 'VEHICLE') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    term_months INT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED', 'DISBURSED', 'CLOSED') NOT NULL DEFAULT 'PENDING',
    purpose TEXT NOT NULL,
    application_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approval_date TIMESTAMP NULL,
    approved_by VARCHAR(50) NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert default admin user
INSERT INTO users (username, password, role, full_name, email, phone, address, status, rejection_reason) VALUES
('admin', 'admin123', 'ADMIN', 'System Administrator', 'admin@banking.com', '1234567890', '123 Admin Street, Admin City, AC 12345', 'ACTIVE', NULL);

-- Insert sample customer users
INSERT INTO users (username, password, role, full_name, email, phone, address, status, rejection_reason) VALUES
('john_doe', 'password123', 'CUSTOMER', 'John Doe', 'john.doe@email.com', '5551234567', '456 Main Street, Anytown, AT 12345', 'ACTIVE', NULL),
('jane_smith', 'password123', 'CUSTOMER', 'Jane Smith', 'jane.smith@email.com', '5559876543', '789 Oak Avenue, Somewhere, SW 54321', 'ACTIVE', NULL),
('bob_wilson', 'password123', 'CUSTOMER', 'Bob Wilson', 'bob.wilson@email.com', '5554567890', '321 Pine Road, Elsewhere, EW 67890', 'ACTIVE', NULL);

-- Insert sample accounts
INSERT INTO accounts (user_id, account_number, account_type, balance, status) VALUES
(2, 'ACC000001', 'SAVINGS', 5000.00, 'ACTIVE'),
(2, 'ACC000002', 'CHECKING', 2500.00, 'ACTIVE'),
(3, 'ACC000003', 'SAVINGS', 7500.00, 'ACTIVE'),
(3, 'ACC000004', 'FIXED_DEPOSIT', 10000.00, 'ACTIVE'),
(4, 'ACC000005', 'SAVINGS', 3000.00, 'ACTIVE');

-- Insert sample transactions
INSERT INTO transactions (from_account_id, to_account_id, transaction_type, amount, description, status) VALUES
(1, 2, 'TRANSFER', 500.00, 'Monthly transfer to checking', 'COMPLETED'),
(3, 4, 'TRANSFER', 1000.00, 'Investment transfer', 'COMPLETED'),
(5, 1, 'TRANSFER', 200.00, 'Payment to John', 'COMPLETED');

-- Insert sample loans
INSERT INTO loans (user_id, loan_type, amount, interest_rate, term_months, status, purpose) VALUES
(2, 'PERSONAL', 15000.00, 8.50, 60, 'APPROVED', 'Home renovation project'),
(3, 'HOME', 250000.00, 6.75, 360, 'PENDING', 'Purchase of new home'),
(4, 'BUSINESS', 50000.00, 9.25, 84, 'PENDING', 'Business expansion and equipment purchase');

-- Create indexes for better performance
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_accounts_user_id ON accounts(user_id);
CREATE INDEX idx_accounts_account_number ON accounts(account_number);
CREATE INDEX idx_transactions_from_account ON transactions(from_account_id);
CREATE INDEX idx_transactions_to_account ON transactions(to_account_id);
CREATE INDEX idx_transactions_date ON transactions(transaction_date);
CREATE INDEX idx_loans_user_id ON loans(user_id);
CREATE INDEX idx_loans_status ON loans(status);

-- Create views for common queries
CREATE VIEW active_accounts AS
SELECT a.*, u.full_name, u.email
FROM accounts a
JOIN users u ON a.user_id = u.id
WHERE a.status = 'ACTIVE';

CREATE VIEW pending_loans AS
SELECT l.*, u.full_name, u.email, u.phone
FROM loans l
JOIN users u ON l.user_id = u.id
WHERE l.status = 'PENDING';

CREATE VIEW transaction_summary AS
SELECT 
    t.id,
    t.transaction_type,
    t.amount,
    t.status,
    t.transaction_date,
    fa.account_number as from_account,
    ta.account_number as to_account,
    u1.full_name as from_user,
    u2.full_name as to_user
FROM transactions t
JOIN accounts fa ON t.from_account_id = fa.id
JOIN accounts ta ON t.to_account_id = ta.id
JOIN users u1 ON fa.user_id = u1.id
JOIN users u2 ON ta.user_id = u2.id
ORDER BY t.transaction_date DESC;
