# Challenge 4- financial analysis

# **Relationship Diagram**
![image](https://github.com/user-attachments/assets/8cc976ac-4211-4511-91f7-93797f65cb2c)
# **Data preview**
Customers table:
\
![image](https://github.com/user-attachments/assets/a0d0a5e9-eff6-44db-a5c9-3d837871cf25)
\
Branches table:
\
![image](https://github.com/user-attachments/assets/26b58984-4fea-4e00-ac72-06f77ec0f327)
\
Accounts table:
\
![image](https://github.com/user-attachments/assets/0e8f3f0a-f49b-4c5e-9dd7-87252662dc08)
\
Transactions table:
\
![image](https://github.com/user-attachments/assets/6ed9b0e8-199b-4ce6-8c55-3bac6f164e74)
# **Solutions**

**1. What are the names of all the customers who live in New York?**

```sql
select FirstName + ' ' + LastName as Name, city 
from Customers
where city = 'New York';
```
Output:
\
![image](https://github.com/user-attachments/assets/0fecbdf1-8dcf-4dc4-ac9d-4b36c16035f0)

**2. What is the total number of accounts in the Accounts table?**

```sql
select count(distinct AccountID) amount 
from Accounts;
```
Output:
\
![image](https://github.com/user-attachments/assets/8dd69c7d-bc24-4f14-ab15-d74bb23da77c)

**3. What is the total balance of all checking accounts?**

```sql
select AccountType, sum(Balance) total 
from Accounts
where AccountType = 'Checking'
group by AccountType;
```
Output:
\
![image](https://github.com/user-attachments/assets/b821c416-aef9-4fa0-b7ff-77c4de032ffb)

**4. What is the total balance of all accounts associated with customers who live in Los Angeles?**

```sql
select city, sum(Balance) as "total balance"
from customers c
join accounts a on c.CustomerID = a.CustomerID
where City = 'Los Angeles'
group by City;
```
Output:
\
![image](https://github.com/user-attachments/assets/c787f605-7cec-419e-81ec-37f0870016bc)

**5. Which branch has the highest average account balance?**

```sql
SELECT top 1 Branches.BranchName, 
       ROUND(AVG(Accounts.Balance), 2) AS AvgBalance
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
GROUP BY Branches.BranchName
ORDER BY AvgBalance DESC;
```
Output:
\
![image](https://github.com/user-attachments/assets/ff56993a-a274-4a02-b9a6-b110cbb90d1b)

**6. Which customer has the highest current balance in their accounts?**

```sql
SELECT top 1 Customers.FirstName,
      Customers.LastName, 
      MAX(Accounts.Balance) AS MaxBalance
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY MaxBalance DESC;
```
Output:
\
![image](https://github.com/user-attachments/assets/759b0b8d-f295-41c0-8843-5d4cc076ea37)

**7. Which customer has made the most transactions in the Transactions table?**

```sql
SELECT top 1 Customers.FirstName, 
       Customers.LastName,
       COUNT(Transactions.TransactionID) AS TotalTransactions
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
JOIN Transactions ON Accounts.AccountID = Transactions.AccountID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY TotalTransactions DESC;
```
Output:
\
![image](https://github.com/user-attachments/assets/30a5de91-5c4c-4a51-8f96-8b06955a0fee)

**8. Which branch has the highest total balance across all of its accounts?**

```sql
SELECT top 1 Branches.BranchName,
      SUM(Accounts.Balance) AS TotalBranchBalance
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
GROUP BY Branches.BranchName
ORDER BY TotalBranchBalance DESC;
```
Output:
\
![image](https://github.com/user-attachments/assets/540ea834-1ca8-483b-8d21-1caca38653f0)

**9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?**

```sql
SELECT top 1 Customers.FirstName,
       Customers.LastName,
       SUM(Accounts.Balance) AS TotalBalance
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY TotalBalance DESC;
```
Output:
\
![image](https://github.com/user-attachments/assets/3a84616b-e3ea-48f8-abbd-ab890663a977)

**10. Which branch has the highest number of transactions in the Transactions table?**

```sql
SELECT top 1 Branches.BranchName,
      COUNT(Transactions.TransactionID) AS TotalTransactions
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
JOIN Transactions ON Accounts.AccountID = Transactions.AccountID
GROUP BY Branches.BranchName
ORDER BY TotalTransactions DESC;
```
Output:
\
![image](https://github.com/user-attachments/assets/ac1ca873-8642-41f2-8ee8-e2d9ef98a991)




