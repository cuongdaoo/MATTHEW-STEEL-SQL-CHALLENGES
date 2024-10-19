select * from [dbo].[Customers];
select * from [dbo].[Branches];
select * from [dbo].[Accounts];
select * from [dbo].[Transactions];


-- 1. What are the names of all the customers who live in New York?
select FirstName+' '+LastName as Name, city from Customers
where city ='New York';

-- 2. What is the total number of accounts in the Accounts table?
select count(distinct AccountID) amount from Accounts;

-- 3. What is the total balance of all checking accounts?
select AccountType ,sum(Balance) total from Accounts
where AccountType='Checking'
group by AccountType;

-- 4. What is the total balance of all accounts associated with customers who live in Los Angeles?
select city, sum(Balance) as "total balance"
from customers c
join accounts a on c.CustomerID=a.CustomerID
where City='Los Angeles'
group by City;

--5. Which branch has the highest average account balance?
SELECT top 1 Branches.BranchName, 
       ROUND(AVG(Accounts.Balance),2) AS AvgBalance
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
GROUP BY Branches.BranchName
ORDER BY AvgBalance DESC;
 
-- 6. Which customer has the highest current balance in their accounts?
SELECT top 1 Customers.FirstName,
      Customers.LastName, 
      MAX(Accounts.Balance) AS MaxBalance
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY MaxBalance DESC;
-- 7. Which customer has made the most transactions in the Transactions table?
SELECT  top 1 Customers.FirstName, 
       Customers.LastName,
       COUNT(Transactions.TransactionID) AS TotalTransactions
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
JOIN Transactions ON Accounts.AccountID = Transactions.AccountID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY TotalTransactions DESC;
-- 8. Which branch has the highest total balance across all of its accounts?
SELECT top 1 Branches.BranchName,
      SUM(Accounts.Balance) AS TotalBranchBalance
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
GROUP BY Branches.BranchName
ORDER BY TotalBranchBalance DESC;
-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
SELECT  top 1 Customers.FirstName,
       Customers.LastName,
       SUM(Accounts.Balance) AS TotalBalance
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY TotalBalance DESC;
-- 10. Which branch has the highest number of transactions in the Transactions table?
SELECT  top 1 Branches.BranchName,
      COUNT(Transactions.TransactionID) AS TotalTransactions
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
JOIN Transactions ON Accounts.AccountID = Transactions.AccountID
GROUP BY Branches.BranchName
ORDER BY TotalTransactions DESC;