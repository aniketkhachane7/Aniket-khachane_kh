create database BankManagementSystem;
use BankManagementSystem;

-- --------------------------------------------------------------------------------------------------------------------------------------

-- table structure for branchtable
create table branchtable
(  
   id int primary key,  
   branch_name varchar(150),
   branch_code varchar(20),
   branch_address varchar(180)
);
desc branchtable;

-- ---------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------------------------

-- data insertion in branchtable
insert into branchtable (id, branch_name, branch_code, branch_address) values
(0001,'Mumbai', 'SBI123451','Kharghar'),
(0002,'Pune', 'SBI123452', 'Viman Nagar'),
(0003,'Nashik', 'SBI123453', 'College Road'),
(0004,'Jalgaon', 'SBI123454', 'Market Yard'),
(0005,'Latur', 'SBI123455', 'Ganes Nagar'),
(0006,'Nagar', 'SBI123456', 'Shanti Nagar'),
(0007,'Dhule', 'SBI123457', 'jalgaon Road'),
(0008,'Bhurhanpur', 'SBI123459', 'Laxmisagar'),
(0009,'Sangli', 'SBI123460', 'Sri Krishna Complex'),
(0010,'Satara', 'SBI123461', 'Shahibaug');

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- drop table branchtable;
select * from branchtable;

insert into branchtable (id, branch_name, branch_code, branch_address) values(0002,'Goa', 'SBI123458', 'Main City'); -- Dublicate Not Allow (PK)

update branchtable set branch_address= "Juhu" where id= 0001;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- table structure for accountholder
create table accountholder
( 
    customer_id int primary key, 
    account_no varchar(20) unique not null,
    account_type varchar(20),
    branch_code varchar(20) not null,
    Name varchar(30),
    gender varchar(10),
    DOB date,
    mobile_no varchar(20) unique,
    aadhar_no varchar(20),
    balance float,
     FOREIGN KEY (customer_id) REFERENCES branchtable(id)
);  
desc accountholder;

-- ---------------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------------------------------
 
-- data insertion in accountholder
 insert into accountholder (customer_id, account_no, account_type, branch_code, Name, gender, DOB, mobile_no, aadhar_no, balance) values
 (0001,"1404100114001", "Savings", 'SBI123453', "Aniket Khachane", "M", "1997-04-13","9853718910", "123456789032", 28000),
 (0002,"1404100114002", "Current", 'SBI123452', "Akshay Patil", "M","1995-05-29", "9763017892","123456789065", 35000),
 (0003,"1404100114003", "Savings", 'SBI123451', "Ankit Chopde", "M", "1997-06-16", "9421168911","123456789056", 30000),
 (0004,"1404100114004", "Current", 'SBI123454', "Akash Sharma", "M", "1998-06-21", "9267568912","123456789012", 32000),
 (0005,"1404100114005", "Current", 'SBI123451', "Akash Barhate", "M", "1997-01-17","9861892110","123456789078", 56000);
drop table accountholder;
select * from accountholder where Name like 'A%';
select * from accountholder where Name like '%ha%';
select Name from accountholder where Name like '__a%';
select * from accountholder;
-- ------------------------------------------------------Using Cursor----------------------------------------------------------------------------------------
select name, balance" Second Max Balance" from accountholder   
where balance = (select max(balance) from accountholder
where balance  <
(select max(balance) from accountholder));

create table tempp (
    a int primary key, 
    b varchar(20),
    c varchar(20),
    d varchar(20),
    e varchar(30),
    f varchar(10),
    g date,
    h varchar(20) unique,
    i varchar(20),
    j float);


 delimiter //
 create procedure wxyz()
 begin
     
    declare a int; 
    declare b varchar(20);
    declare c varchar(20);
    declare d varchar(20);
	declare e varchar(30);
    declare f varchar(10);
    declare g date;
    declare h varchar(20);
    declare i varchar(20);
    declare j float;
     
     declare x int default 1;
     declare c1 cursor for select * from accountholder;
     open c1; 
     while x<6 do
        fetch c1 into a,b,c,d,e,f,g,h,i,j;
        insert into tempp values (a,b,c,d,e,f,g,h,i,j);
        set x=x+1;
     end while;
     close c1;
 end; //
 delimiter ;
 call wxyz();
 drop procedure wxyz;
 select * from tempp;
 
 -- drop table tempp;
 select * from accountholder;
 
 -- -----------------------------------------------------------------------------------------------------------------------------------------
 
 savepoint abc;
 update accountholder set mobile_no= "8999667199" where name= "Aniket Khachane";  -- UPDATE 
 update accountholder set mobile_no= "9766582330" where name= "Akash Barhate";    -- UPDATE
 rollback to abc;
 -- ------------------------------------------------------------------------------------------------------------------------------------------
savepoint xyz;
delete from accountholder  where account_no= "1404100114004";    -- Delete (id = 4)
rollback to xyz;
select * from accountholder;
-- ------------------------------------------------------------------------- ------------------------------------------------------------------
 select Name, balance from accountholder order by balance;   -- By Asc Order
 select Name, balance from accountholder order by balance desc;  -- By Desc Order
 
 select name ,account_type, max(balance) from accountholder 
 group by account_type;  
 
 select count(customer_id) as "Number of accountholder" from accountholder;
 
 select name ,balance from accountholder 
 where balance=
 (select max(balance)  as "Maximum balance" from accountholder);
 
 select name, balance from accountholder 
 where balance=
 (select min(balance)  as "Minimum Balance" from accountholder);
 
 select Name , balance from accountholder where balance > 30000; 
 select Name,account_type, sum(balance) from accountholder group by account_type;


-- ---------------------------------------------Using View---------------------------------------------------------------------------

CREATE VIEW view1 AS
select * from accountholder;
select * from view1;

-- ---------------------------------------------------------------------------------------------------------------------------------
-- Table structure for table servicetable

create table servicetable (
  Date date not null,
  Account_Num varchar(15) unique null,
  ServiceName varchar(100) default null,
  Status varchar(200) default null,
  FOREIGN KEY (Account_Num) REFERENCES branchtable(id)   
);
insert into servicetable (Date, Account_Num, ServiceName, Status) values
('2022-01-06', '1404100114001', 'Online Banking', 'done'),
('2022-02-26', '1404100114002', 'Loan', 'Pending'),
('2022-07-16', '1404100114004', 'Open Account', 'done');
-- drop table servicetable;
select * from servicetable;

 -- -----------------------------------------------------Stored Procedures---------------------------------------------------------------------------

delimiter //
create procedure proc()
begin
     select * from accountholder;
end //
delimiter ;
call proc();     

-- -------------------------------------------------------------------------------------------------------------------------------------

-- structure for tansaction table   
create table transaction
(  
    Date date,
    account_num varchar(20), 
	credit_amt float,
    debit_amt float,
    transactionid int,
     FOREIGN KEY (account_num) REFERENCES servicetable(Account_Num)
);
desc transaction;
drop table transaction;
-- --------------------------------------------------------------------------------------------------------------------------------------

-- data insertion in transaction 
insert into transaction (Date, account_no, credit_amt, debit_amt, transactionid) values 
  ("2021-07-01","1404100114001", 20000, 1000, 0001),
  ("2021-06-29","1404100114002", 30000, 3000, 0002),
  ("2021-06-27","1404100114003", 40000, 6000, 0003),
  ("2021-06-21","1404100114002", 10000, 3000, 0004);

-- --------------------------------------------------------------------------------------------------------------------------------------- 
select * from transaction;
 
select accountholder.Name, (credit_amt-debit_amt+accountholder.balance) as balance from accountholder
inner join 
transaction on accountholder.customer_id= transaction.transactionid;
  
select account_no, credit_amt from transaction where credit_amt between 20000 and 40000 ;
  
select account_no, debit_amt from transaction where debit_amt between 3000 and 6000 ;

alter table transaction modify account_no varchar(30);  

   desc transaction;

-- ---------------------------------------------------Using Triggers--------------------------------------------------------------------------
create table temperory
(
	a date,
    b varchar(20), 
	c float,
    d float,
    e int
);

delimiter //
create trigger trans
before insert
on transaction for each row
begin 
     insert into temperory values (new.Date, new.account_no, new.credit_amt, new.debit_amt, new.transactionid );
  
end; //
delimiter ;
  
insert into transaction values("2021-07-01","1404100114001", 20000, 1000, 0001);
  
select * from temperory;

-- ---------------------------------------------Using View---------------------------------------------------------------------------

CREATE VIEW view1 AS
    SELECT 
        *
    FROM
        accountholder;
select * from view1;







  

  
   
   