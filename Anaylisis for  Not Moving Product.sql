SELECT *
FROM products
WHERE productName = '1985 Toyota Supra';
-- productCode = 'S18_3233' for '1985 Toyota Supra'

-- Analysis of not moving products

SELECT 
    products.*, 
    warehouses.*,
    productLines.*
FROM 
    products
JOIN 
    warehouses ON products.warehouseCode = warehouses.warehouseCode
JOIN 
    productLines ON products.productLine = productLines.productLine
WHERE 
    products.productName = '1985 Toyota Supra';
    
-- in this case, '1985 Toyota Supra' is not a moving items, it's productCode
-- isnot registered in orderdetails
