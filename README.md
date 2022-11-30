# DBW
Information Package

Progress test 1 
Data warehouse – DBW301
Class :                                 RollNumber:                                               FullName:
An international bank has branches in Vietnam and in other countries. The operational database of this bank contains the following tables (note that attributes which are written with underline belong to the primary key of each table):
Branches(Branch_ID, Name, Address, ZIPCode, District, City, State, Country)
Departments(DeptID, Name, Role)
Employees(EmployeeID, FirstName, LastName, Gender, MaritalStatus, Superior_Employee_ID)
Employee_Department_Branch(EmployeeID, DeptID, AssignBranchID, StartDate, EndDate, Title, Salary)
Customers(CustomerID, Address, District, City, State, Country, ZIPCode, Phone, CustomerType)
IndividualCustomers(CustomerID, FirstName, LastName, DateOfBirth, Gender, MaritalStatus, IncomeRange, OwnCar?, RentOrOwnHouse?)
BusinessCustomers(CustomerID, Name, IncorporationDate, Capital, ContactFirstName, ContactLastName, ContactTitle)
Accounts(Number, CustomerID, Open_Branch_ID, Open_Emp_ID, OpenDate, CloseDate, InitialBalance, CurrentBalance, Status, ProductID, InterestRate)
Products(ProductID, Name, DateOffered, DateRetired, ProductType)
Transaction(TransactionID, Time, Amount, TransactionType, AccountID, Execution_Branch_ID, EmployeeID)

-	A customer could have different accounts in a same country or in different countries. 
-	For simplicity, we assume that an account belongs to only one customer. 
-	The bank proposes three types of product (ProductType = Account, Insurance or Loan), and for each product type, there are some different products such as checking account, saving account (for Account product type); home mortgage, small business loan (for Loan product type); … 
-	There are two kinds of customers: individual customer and business customer. 
-	Each employee is assigned to only one department in one branch, when the employee changes his/her branch, a new row corresponding to the employee and his/her new branch will be inserted in the table Employee_Department_Branch.
Business requirements:
The executive managers of the bank want to improve the activities of their branches. To achieve this objective, they ask you to create a data mart allowing them to analyze the effective of different branches as well as the behaviors of their individual customers. Note that the executive manager does not want to analyze the behaviors of each customer, but he/she want to analyze the behavior of their customers according to their gender, marital status, age, and income range.
The effective of different branches is analyzed based on the number of accounts as well as the number of transactions per day, month, year. The decision makers might want to know if their customers prefer to do their transaction in the morning or in the afternoon, in a particular day of a week or not.
The executive managers want to also know the performance of each employee by analyzing the number of transactions that he/she make each day. They want to know if the salary as well as the marital status influence on the performance of their employees.
According to customers, the executive managers of the bank may want to know if their marital status and income range influence on the number and the average amount of their transactions.
Question:
1.	Create the information package corresponding to your data warehouse.
2.	Distinguish the hierarchies and categories of each dimension.
3.	Which level of details of data your data warehouse must be hold?
