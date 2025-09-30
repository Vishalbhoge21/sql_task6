USE ELEVATE ;
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT 
    CustomerName,
    (SELECT SUM(Amount)
     FROM Orders
     WHERE Orders.CustomerID = Customers.CustomerID) AS TotalSpent
FROM Customers;

SELECT CustomerName, City
FROM Customers
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
);

SELECT CustomerName, City
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Orders
);

SELECT OrderID, CustomerID, Amount
FROM Orders o
WHERE Amount > (
    SELECT AVG(Amount)
    FROM Orders
    WHERE CustomerID = o.CustomerID
);

SELECT c.CustomerName, stats.TotalAmount, stats.AvgAmount
FROM Customers c
JOIN (
    SELECT CustomerID, 
           SUM(Amount) AS TotalAmount,
           ROUND(AVG(Amount), 2) AS AvgAmount
    FROM Orders
    GROUP BY CustomerID
) AS stats
ON c.CustomerID = stats.CustomerID;

SELECT CustomerName
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);

SELECT CustomerName
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);
