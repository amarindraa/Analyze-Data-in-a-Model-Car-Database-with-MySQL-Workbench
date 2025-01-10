-- warehouse & product distinct count

select count(*)
from warehouses w
join products p on p.warehouseCode = w.warehouseCode
;


-- warehouse & product distinct
select *
from warehouses w
join products p on p.warehouseCode = w.warehouseCode
;



-- 1) Where are items stored and if they were rearranged, could a warehouse be eliminated?
--    quantityInStock, warehouseName, warehousePctCap

SELECT
    w.warehouseCode,
    w.warehouseName,
    SUM(p.quantityInStock) AS total_quantity_warehouse,
    w.warehousePctCap,
    ROUND(SUM(p.quantityInStock) / (w.warehousePctCap / 100), 0) AS totalCap,
    ROUND(
        (SUM(p.quantityInStock) / (w.warehousePctCap / 100)) - SUM(p.quantityInStock), 
        0
    ) AS remainingCap
FROM
    warehouses w
JOIN
    products p ON w.warehouseCode = p.warehouseCode
GROUP BY
    w.warehouseCode,
    w.warehouseName,
    w.warehousePctCap
order by remainingCap Desc    
;

-- here we can see, South warehouse have 79380 items also  as the highest
-- capacity compare to other warehouses. Therefore it can be closed and items
-- move to wast or east as the lowest capacity



-- 2) How are inventory numbers related to sales figures? 
--    Do the inventory counts seem appropriate for each item?
SELECT 
    p.productCode,
    p.productName,
    p.productLine,
    p.productVendor,
    p.quantityInStock,
    SUM(od.quantityOrdered) AS totalSales,
    ROUND(SUM(od.quantityOrdered) * 100 / p.quantityInStock, 2) AS salesratio,
    p.MSRP
FROM
    products p
JOIN
    orderdetails od ON p.productCode = od.productCode
GROUP BY
    p.productCode, p.productName, p.quantityInStock
ORDER BY
    salesratio DESC;

-- the results shown 1960 BSA Gold Star is the most favorite
-- and 1995 Honda Civic is the lowest selling among all

SELECT *
FROM products
WHERE productName = '1985 Toyota Supra';
-- productCode = 'S18_3233' for '1985 Toyota Supra'

-- Analysis of not moving products

SELECT *
FROM products
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
INNER JOIN orders ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN customers ON customers.customerNumber = orders.customerNumber
INNER JOIN payments ON payments.customerNumber = customers.customerNumber
INNER JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
INNER JOIN offices ON offices.officeCode = employees.officeCode
INNER JOIN productLines ON productLines.productLine = products.productLine
INNER JOIN warehouses ON products.warehouseCode = warehouses.warehouseCode
WHERE products.productName = '1985 Toyota Supra';

-- in this case, '1985 Toyota Supra' is not a moving items, it's productCode
-- isnot registered in orderdetails. Now we need to look where is 1985 Toyota Supra'
-- is kept. Therefore we need to only include products, warehouse and productlines

SELECT 
    warehouses.*,
    products.*,
    productLines.*,
    ROUND(products.quantityInStock * products.buyPrice, 0) AS TotalPurchase,
    ROUND(products.quantityInStock * products.MSRP, 0) AS PossibleIncome,
    ROUND((products.quantityInStock * products.MSRP) - (products.quantityInStock * products.buyPrice), 0) AS PossibleIncome
FROM warehouses
INNER JOIN products ON products.warehouseCode = warehouses.warehouseCode
INNER JOIN productLines ON productLines.productLine = products.productLine
WHERE products.productName = '1985 Toyota Supra';


-- now we know '1985 Toyota Supra' is kept in warehouseName 'East'
-- with total quantity 7733 unit unsold, the company total expense purchasing
-- this item USD 440,000, while it's possible income is USD 831,839.
-- Possible profit from this product is USD 390,980.


-- 3) Are we storing items that are not moving? Are any items 
--    candidates for being dropped from the product line?

SELECT 
    p.productCode,
    p.productName,
    p.productLine,
    p.productVendor,
    p.quantityInStock,
    SUM(od.quantityOrdered) AS totalSales,
    ROUND(SUM(od.quantityOrdered) * 100 / p.quantityInStock, 2) AS salesratio,
    p.buyPrice,
    p.MSRP,
    ROUND(p.quantityInStock + SUM(od.quantityOrdered), 0) AS originStock,
    ROUND((p.quantityInStock + SUM(od.quantityOrdered)) * p.buyPrice, 0) AS TotalCost,
    ROUND((p.quantityInStock + SUM(od.quantityOrdered)) * p.MSRP, 0) AS TotalSalesValue,
    ROUND(SUM(od.quantityOrdered * p.MSRP), 0) AS TotalRevenue,
    ROUND(
        SUM(od.quantityOrdered * p.MSRP) - ((p.quantityInStock + SUM(od.quantityOrdered)) * p.buyPrice), 
        0
    ) AS TotalLostProfit

FROM
    products p
JOIN
    orderdetails od ON p.productCode = od.productCode
GROUP BY
    p.productCode, 
    p.productName, 
    p.productLine, 
    p.productVendor, 
    p.quantityInStock, 
    p.buyPrice, 
    p.MSRP
ORDER BY
    TotalLostProfit DESC;

-- data is telling lots of items are not creating profit. The company
-- needs focusing on marketing strategy and selling price to create profit.
-- We need to understand what warehouse create & employees with the most selling.


SELECT 
    w.warehouseName,
    p.productName,
    p.productLine,
    p.productVendor,
    p.quantityInStock,
    od.priceEach,
    o.orderDate,
    o.status,
    c.salesRepEmployeeNumber,
    e.lastName,
    e.firstName,
    e.officeCode
FROM
    warehouses w
JOIN 
    products p ON w.warehouseCode = p.warehouseCode
JOIN 
    orderdetails od ON p.productCode = od.productCode
JOIN 
    orders o ON od.orderNumber = o.orderNumber
JOIN 
    customers c ON o.customerNumber = c.customerNumber
JOIN 
    employees e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY 
    w.warehouseName,
    p.productName,
    p.productLine,
    p.productVendor,
    p.quantityInStock,
    od.priceEach,
    o.orderDate,
    o.status,
    c.salesRepEmployeeNumber,
    e.lastName,
    e.firstName,
    e.officeCode;