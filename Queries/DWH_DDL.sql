CREATE DATABASE GravityBooksDWH

USE GravityBooksDWH

                                         --DIM shipping_method
CREATE TABLE DIMshippingmethod
(
    shipping_method_id_SK INT IDENTITY(1, 1) NOT NULL, -- SK
	method_id_NK INT NOT NULL, --Nature key	
	method_name	varchar(100),
	cost decimal (6 ,2),
	--meta data
	Source_sys_code	TINYINT not null, 
	--SCD
	[Start_Date]  datetime not null default getdate(),	
	End_Date	datetime NULL,
	Is_Current 	TINYINT not null default (1),
	--pk
	constraint pk_shipping_method
	primary key clustered (shipping_method_id_SK)

	)	
                                              --BOOK_DIM
CREATE TABLE DIMBOOK(
	book_id_SK	INT  identity (1,1) not null, --SK	
	book_id_NK	INT NOT NULL, --Nature key	
	isbn13	VARCHAR(13),
	title	VARCHAR(400),
	num_pages INT ,
	publication_date DATE ,
	--BOOKLANG
	lang_id_NK	INT NOT NULL,	
	lang_code	VARCHAR(8),	
	lang_name	VARCHAR(50),	

	--publisher
	publisher_name	VARCHAR(400),
	publisher_id_NK	INT NOT NULL,

	Source_sys_code	tinyint not null, 
	[Start_Date]  datetime not null default getdate(),	
	End_Date	datetime NULL,
	Is_Current 	TINYINT not null default (1),
	constraint pk_DIMBOOK
	primary key clustered (book_id_SK))
                                             --DimAuthor
CREATE TABLE DIMAuthor(
	author_id_SK INT  identity (1,1) not null, --SK
	author_id_NK INT NOT NULL, --Nature key	
	author_name varchar(400),

	Source_sys_code	tinyint not null, 

	[Start_Date]  datetime not null default getdate(),	
	End_Date	datetime NULL,
	Is_Current 	TINYINT not null default (1),
	constraint pk_DIMAuthor primary key clustered (author_id_SK)
	)
	                                         --statuDIM

CREATE TABLE DIMstatus
(
    status_order_id_SK INT IDENTITY(1, 1) NOT NULL, -- SK
	status_id_NK INT NOT NULL, --Nature key	
	[status_value]	varchar(20),
	--meta data
	Source_sys_code	TINYINT not null, 
	--SCD
	[Start_Date]  datetime not null default getdate(),	
	End_Date	datetime NULL,
	Is_Current 	TINYINT not null default (1),
	--pk
	constraint pk_status
	primary key clustered (status_order_id_SK)

	)	

                                             --DIM_AUTHOR_BOOK
CREATE TABLE DIM_AUTHOR_BOOK(
	Author_book_id_SK int  identity (1,1) not null, --SK	
	book_SK_FK int NOT NULL, --book
	Author_SK_FK int NOT NULL, --author
	Source_sys_code	tinyint not null, 
	[Start_Date]  datetime not null default getdate(),	
	End_Date	datetime NULL,
	Is_Current 	TINYINT not null default (1),

	constraint PK_DIM_AUTHOR_BOOK
	primary key clustered (Author_book_id_SK),
--FK
	CONSTRAINT book_id_FK FOREIGN KEY (book_SK_FK) REFERENCES DIMBOOK (book_id_SK),
    CONSTRAINT Author_id_FK FOREIGN KEY (Author_SK_FK) REFERENCES DimAuthor (author_id_SK))

                                              --DimCustomer
CREATE TABLE DimCustomer(
	customer_id_SK INT  identity (1,1) not null, --SK
	customer_id_NK INT NOT NULL, --Nature key	
	first_name varchar(200),
	last_name varchar(200),
	email varchar(350),
	Source_sys_code	tinyint not null, 
	[Start_Date]  datetime not null default getdate(),	
	End_Date	datetime NULL,
	Is_Current 	TINYINT not null default (1),
	constraint PK_DIM_Customer
	primary key clustered (customer_id_SK))
	                                        --Dim_address_Customer
										
CREATE TABLE Dim_address_Customer(
	address_customer_id_SK  INT  identity (1,1) not null, --SK
	customer_SK_FK INT NOT NULL,
	address_id_NK INT NOT NULL,
	street_number VARCHAR(10),
	street_name VARCHAR(200),
	city VARCHAR(100),
	--COUNTRY
	country_id_NK INT NOT NULL,
	country_name VARCHAR(200),
	--ADD_STATUS
	status_id_Nk INT NOT NULL,
	address_status VARCHAR(30),

	Source_sys_code	tinyint not null, 
	[Start_Date]  datetime not null default getdate(),	
	End_Date	datetime NULL,
	Is_Current 	TINYINT not null default (1),

	constraint PK_Dim_address_Customer primary key clustered (address_customer_id_SK),
	CONSTRAINT customer_id_FK FOREIGN KEY (customer_SK_FK) REFERENCES DimCustomer (customer_id_SK)
	)



                          ---Accumulative_Order_Processing
use [GravityBooksDWH]
CREATE TABLE Accumulative_Order_Processing(
	cumulative_order_PK_SK INT  identity (1,1) PRIMARY KEY, --SK
    status_id_fk int not null,
	order_id_NK INT  ,
	[Order Received_FK]  INT  null,
	[Pending Delivery_FK] INT null,
	[Delivery In Progress_FK] INT null ,
	[Delivered_FK] INT  null,
	[Cancelled_FK] INT  null,
	[Returned_FK] INT  null,
	source_sys_code tinyint not null, 
	created_at DATETIME DEFAULT GETDATE(),
	CONSTRAINT [status_FK] FOREIGN KEY(status_id_fk)REFERENCES DIMstatus (status_order_id_SK),
	CONSTRAINT [Order Received_FK] FOREIGN KEY([Order Received_FK])REFERENCES DIMDATE ([DateSK]),
	CONSTRAINT [Pending Delivery_FK] FOREIGN KEY([Pending Delivery_FK])REFERENCES DIMDATE ([DateSK]),
	CONSTRAINT [Delivery In Progress_FK] FOREIGN KEY([Delivery In Progress_FK])REFERENCES DIMDATE ([DateSK]),
	CONSTRAINT [Delivered_FK] FOREIGN KEY([Delivered_FK])REFERENCES DIMDATE ([DateSK]),
	CONSTRAINT [Cancelled_FK] FOREIGN KEY([Cancelled_FK])REFERENCES DIMDATE ([DateSK]),
	CONSTRAINT [Returned_FK] FOREIGN KEY([Returned_FK])REFERENCES DIMDATE ([DateSK]))
	

	

                                    --Fact_Book_orders
CREATE TABLE Fact_book_order (
	book_orders_PK_SK INT  identity (1,1) PRIMARY KEY, --SK
	book_FK INT NOT NULL,
	line_id_NK INT NOT NULL,  --orderline
	
	date_nk INT NOT NULL,
	time_nk INT NOT NULL,
	order_id_NK INT NOT NULL,
	dest_address_NK INT NOT NULL,
	method_FK INT NOT NULL, 
	customer_FK INT NOT NULL, --cust
	price DECIMAL (5, 2),  --orderline
	source_sys_code tinyint not null, 
	created_at DATETIME default GETDATE(),
	CONSTRAINT cu_FK FOREIGN KEY (customer_FK) REFERENCES DimCustomer (customer_id_SK),
	CONSTRAINT bo_FK FOREIGN KEY (book_FK) REFERENCES DIMBOOK (book_id_SK),
	CONSTRAINT met_FK FOREIGN KEY (method_FK) REFERENCES DIMshippingmethod (shipping_method_id_SK),
	CONSTRAINT [Date_fk] FOREIGN KEY([date_nk])REFERENCES DIMDATE ([DateSK]),
	CONSTRAINT [time_fk] FOREIGN KEY([time_nk])REFERENCES DIMTIME([TimeSK])
	)


                                    --META CTRL_ORDERS_FACT
CREATE TABLE Meta_CTRL_load (
 ID INT identity (1,1),
 Source_table nvarchar(50) not null,
 LAST_LOAD_DATE DATETIME,
 LAST_LOAD_lineId_NK INT NOT NULL,
 
)
INSERT INTO Meta_CTRL_load
VALUES ('Book_Orders','1900-1-1',0), 
                                       ---ctrl_acc_fact_load
	CREATE TABLE ctrl_status(
	ID INT identity (1,1),
	Source_table nvarchar(50) not null,
    LAST_LOAD_DATE DATETIME,
	last_load_order_id_NK [int] not NULL)

INSERT INTO ctrl_status
VALUES ('Order_Processing','1900-1-1',0)




