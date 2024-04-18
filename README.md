# GravityBook_DWH_Project

Welcome to the GravityBook_DWH_Project repository! This project showcases the development of a cutting-edge data warehouse tailored for Gravity Bookstore, a fictional bookstore capturing information about books, customers, and sales.

## Overview

The primary goal of this project is to design and implement a sophisticated data warehouse solution that enables Gravity Bookstore to efficiently manage and analyze its vast repository of transactional data. Leveraging advanced techniques such as Slowly Changing Dimensions (SCD) and SQL Server Integration Services (SSIS), this repository presents a comprehensive approach to data warehousing.

## Galaxy Schema Implementation

The galaxy schema serves as the foundation of our data warehouse, providing a robust framework for organizing data into fact and dimension tables. SQL scripts are utilized to create the necessary tables and establish relationships, ensuring seamless data modeling.

## SSIS ETL Processes

SSIS packages are employed to facilitate the Extract, Transform, Load (ETL) processes, enabling the seamless transfer of data from the OLTP Gravity Bookstore database to the data warehouse. Both full and incremental loads are implemented to optimize data migration and ensure data consistency.

## Screenshots

### ACCumulative Status Fact
![ACCumulative Status Fact](https://github.com/IsraTawfiq/GravityBook_Warehouse/assets/101242591/e97cc0ce-23d1-449b-8815-de74ce725c0f.png)

### ACCumulative Status Fact Orders Fact
![ACCumulative Status Fact Orders Fact](https://github.com/IsraTawfiq/GravityBook_Warehouse/assets/101242591/fc997301-c793-40d8-879b-bf78259bf8c7.png)

### Increment Load Snippets
![Increment Load Snippet 1](https://github.com/IsraTawfiq/GravityBook_Warehouse/assets/101242591/45d04b68-92f8-420c-ac46-369f69519f1d.png)
![Increment Load Snippet 2](https://github.com/IsraTawfiq/GravityBook_Warehouse/assets/101242591/b2daccf4-9519-4385-8946-0fc109a49de6.png)
