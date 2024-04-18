# GravityBook_DWH_Project

Welcome to the GravityBook_DWH_Project repository! This project showcases the development of a cutting-edge data warehouse tailored for Gravity Bookstore, a fictional bookstore capturing information about books, customers, and sales.

## Overview

The primary goal of this project is to design and implement a sophisticated data warehouse solution that enables Gravity Bookstore to efficiently manage and analyze its vast repository of transactional data. Leveraging advanced techniques such as Slowly Changing Dimensions (SCD) and SQL Server Integration Services (SSIS), this repository presents a comprehensive approach to data warehousing.

## Galaxy Schema Implementation

The galaxy schema serves as the foundation of our data warehouse, providing a robust framework for organizing data into fact and dimension tables. SQL scripts are utilized to create the necessary tables and establish relationships, ensuring seamless data modeling.

## SSIS ETL Processes

SSIS packages are employed to facilitate the Extract, Transform, Load (ETL) processes, enabling the seamless transfer of data from the OLTP Gravity Bookstore database to the data warehouse. Both full and incremental loads are implemented to optimize data migration and ensure data consistency.

### Fact Orders full and increment load
![ordersfull](https://github.com/IsraTawfiq/GravityBook_Warehouse/assets/101242591/7a6ecbe2-a991-4637-9db2-b326942e86da)
![ordersfact](https://github.com/IsraTawfiq/GravityBook_Warehouse/assets/101242591/b550b8da-14e5-41fc-b1ac-3ce05ed01fb5)


### ACCumulative Status Fact
![accf_statusfact](https://github.com/IsraTawfiq/GravityBook_Warehouse/assets/101242591/a7a51320-0714-4aef-96b9-3c56213cd887)
![metactrlaccfact](https://github.com/IsraTawfiq/GravityBook_Warehouse/assets/101242591/4be0cdc3-7092-4fd5-8dc1-c54750bf4904)

