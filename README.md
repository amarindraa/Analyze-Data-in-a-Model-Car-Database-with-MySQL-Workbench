# Analyze-Data-in-a-Model-Car-Database-with-MySQL-Workbench
Overview  In this Coursera project, you will step into the shoes of an entry-level data analyst at the fictional Mint Classics Company, helping to analyze data in a relational database with the goal of supporting inventory-related business decisions that lead to the closure of a storage facility.

## Project Objectives

1. Explore products currently in inventory.
2. Determine important factors that may influence inventory reorganization/reduction.
3. Provide analytic insights and data-driven recommendations.

## Findings
1. here we can see, South warehouse have 79380 items also  as the highest capacity compare to other warehouses. Therefore it can be closed and items move to wast or east as the lowest capacity
2. the results shown '1960 BSA Gold Star' is the most favorite and '1995 Honda Civic' is the lowest selling among all
3. in this case, '1985 Toyota Supra' is not a moving items, it's productCode is not registered in orderdetails. Now we need to look where is '1985 Toyota Supra' is kept. Therefore we need to only include products, warehouse and productlines.
4. now we know '1985 Toyota Supra' is kept in warehouseName 'East' with total quantity 7733 unit unsold, the company total expense purchasing this item USD 440,000, while it's possible income is USD 831,839. Possible profit from this product is USD 390,980.
5. data is telling lots of items are not creating profit. The company needs focusing on marketing strategy and selling price to create profit.
