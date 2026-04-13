USE ors;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mobile VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO users (full_name, email, mobile, password)
VALUES
('Priya M', 'priya@example.com', '+91 9876543210', 'password123'),
('Arun Kumar', 'arun@example.com', '+91 9123456789', 'arun123'),
('Meena R', 'meena@example.com', '+91 9012345678', 'meena456'),
('Rahul S', 'rahul@example.com', '+91 9988776655', 'rahul789');
select * from users

ALTER TABLE users ADD COLUMN last_login DATETIME;

CREATE TABLE site_stats (
    id INT PRIMARY KEY,
    total_visits INT
);

INSERT INTO site_stats VALUES (1, 0);

select * from site_stats

USE ors;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    plan_id INT NOT NULL,
    mobile_number VARCHAR(15) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status ENUM('SUCCESS','FAILED','PENDING') DEFAULT 'PENDING',
    transaction_ref VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (plan_id) REFERENCES recharge_plans(plan_id)
);

select * from transactions