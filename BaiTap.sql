CREATE DATABASE IF NOT EXISTS Homework;
USE Homework;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NULL, 
    total_amount DECIMAL(15, 2),
    status VARCHAR(50),
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Users (full_name, phone) VALUES 
('Nguyễn Văn A', '0901111111'),
('Trần Thị B', '0902222222'),
('Lê Hoàng C', '0903333333');
INSERT INTO Orders (user_id, total_amount, status, note) VALUES
(1, 2500000, 'SUCCESS', 'Giao gấp trong sáng nay nhé'),
(2, 3500000, 'SHIPPING', 'Hàng dễ vỡ, đi gấp'),
(NULL, 2100000, 'PENDING', 'Hệ thống tự tạo'),
(NULL, 4500000, 'SUCCESS', 'Đơn ảo kiểm thử nguy hiểm'), 
(3, 3000000, 'CANCELLED', 'Giao gấp nhưng khách hủy'),
(NULL, 2800000, 'CANCELLED', 'Đơn ảo bị hủy'),
(1, 1500000, 'SUCCESS', 'Giao gấp nhưng giá quá rẻ'),
(NULL, 6000000, 'SUCCESS', 'Đơn ảo nhưng giá quá cao'),
(2, 3000000, 'SUCCESS', 'Giao bình thường, không vội');

SELECT order_id,user_id,
    (SELECT full_name FROM Users WHERE Users.user_id = Orders.user_id) AS customer_name,
    total_amount,
    status,
    note,
    CASE 
        WHEN total_amount > 4000000 THEN 'Nguy hiểm'
        ELSE 'Bình thường'
    END AS Alert_Level
FROM Orders
WHERE 
    (total_amount BETWEEN 2000000 AND 5000000)
    AND (status <> 'CANCELLED')
    AND (note LIKE '%gấp%' OR user_id IS NULL)

ORDER BY total_amount DESC

LIMIT 20 OFFSET 40;