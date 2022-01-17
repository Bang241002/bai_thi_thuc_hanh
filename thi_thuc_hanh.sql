--ý1: Create database AZBank
CREATE DATABASE AZBank
GO

USE AZBank 
GO

--ý2: Create tables with constraints as design above. 3. Insert into each table at least 3 records
CREATE TABLE Customer(
	CustomerId INT NOT NULL PRIMARY KEY,
	Name NVARCHAR(50),
	City NVARCHAR(50),
	Country NVARCHAR(50),
	Phone NVARCHAR(15),
	Email NVARCHAR(50)
)
GO

CREATE TABLE CustomerAccount(
	AccountNumber CHAR(9) NOT NULL PRIMARY KEY,
	CustomerId INT NOT NULL references Customer(CustomerId),
	Balance MONEY NOT NULL,
	MinAccount MONEY
)
GO

CREATE TABLE CustomerTransaction(
	TransactionId INT NOT NULL PRIMARY KEY,
	AccountNumber CHAR(9) references CustomerAccount(AccountNumber),
	TransactionDate SMALLDATETIME,
	Amount MONEY,
	DepositorWithdraw BIT NOT NULL
)
GO

--ý3: Insert into each table at least 3 records. 
insert into Customer values 
	(123, N'ĐInh Công bang', N'Nam Định', N'Việt Nam', N'bang@gmail.com' ,N'0123456789' ),
	(124, N'Nguyễn Danh Hưng', N'Nghệ An', N'Việt Nam', N'hung@gmail.com',N'0123456798'  ),
	(125, N'Bùi Văn Dũng', N'hà nội', N'Việt Nam', N'dung@gmail.com', N'0123456879'  ),
	(126, N'Lê Tuấn Minh', N'Hà Nội', N'Việt Nam', N'minh@gmail.com', N'0123457689' )

insert into CustomerAccount values
	('19024124', 13, 100000, 2000),
	('19326734', 14, 200000, 2000),
	('19368295', 15, 150000, 2000),
	('19042847', 16, 500000, 2000)

insert into CustomerTransaction values
	(999, '190234124', '20211209', 20000, 1),
	(997, '193256734', '20220115', 100000, 1),
	(956, '190462847', '20220116', 200000, 0)

--ý4: Write a query to get all customers from Customer table who live in ‘Hanoi’
select Name from Customer where Customer.City = N'Nam Định'


--ý5: Write a query to get account information of the customers (Name, Phone, Email, AccountNumber, Balance)
	select Customer.Name, Customer.Phone, Customer.Email, CustomerAccount.AccountNumber, CustomerAccount.Balance from Customer 
	join CustomerAccount 
	on Customer.CustomerId = CustomerAccount.CustomerId

-- ý6: A-Z bank has a business rule that each transaction (withdrawal or deposit) won’t be over $1000000 (One million USDs). Create a CHECK constraint on Amount column of CustomerTransaction table to check that each transaction amount is greater than 0 and less than or equal $1000000. 
	alter table CustomerTransaction 
	add check (Amount < 1000000)

-- ý7: Create a view named vCustomerTransactions that display Name, AccountNumber, TransactionDate, Amount, and DepositorWithdraw from Customer, CustomerAccount and CustomerTransaction tables. 
create view vCustomerTransactions as
select Customer.Name, CustomerAccount.AccountNumber, CustomerTransaction.TransactionDate, CustomerTransaction.Amount, CustomerTransaction.DepositorWithdraw from Customer
join CustomerAccount 
on Customer.CustomerId = CustomerAccount.CustomerId
join CustomerTransaction
on CustomerAccount.AccountNumber = CustomerTransaction.AccountNumber

select * from vCustomerTransactions
7