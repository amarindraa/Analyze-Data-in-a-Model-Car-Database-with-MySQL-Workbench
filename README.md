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
5. data is telling company still lost money from years of operation due to the lack of reorder from customers. Customers cheque are mostly higher than their invoice. Only 268 customers where cheques are lower than their invoice, company lost is around USD -524646.73. From 21 coutries with 12015 transactions, 11 (268 transactions) of them have problem with outstanding.
6. Customers from Spain alredy paid USD 191,923,032.08, but they expense is only USD 11,407,323.68, there is still USD 180,515,708.40 for them to purchase items. Likewise USA. But this also telling us if market of these countries can't absorb the products, therefore repeat order is going slow. It is not good for company financial status.
7. This also indicate that the company needs to expand to a new country  or partnesthip with more partners to fasten the selling of remaining items, including '1985 Toyota Supra' 
