--Subconsultas

-- Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos
SELECT product_id, product_name, unit_price FROM products WHERE unit_price > (SELECT AVG(unit_price) FROM products);

-- Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.
SELECT product_id, product_name, units_in_stock FROM products WHERE units_in_stock < (SELECT AVG(units_in_stock) FROM products);

-- Obtener los productos cuya cantidad en Inventario (UnitsInStock) sea menor a la cantidad mínima del detalle de ordenes (Order Details)
SELECT product_id, product_name, units_in_stock FROM products WHERE units_in_stock < (SELECT MIN(quantity) FROM order_details);

--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.
SELECT product_id, product_name, category_id FROM products WHERE category_id IN (SELECT category_id FROM products WHERE supplier_id = 1);

-- Subconsultas correlacionadas 

--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.
SELECT ord.employee_id, emp.last_name, COUNT(order_id) AS Cantidad_Pedidos FROM orders ord INNER JOIN employees emp ON emp.employee_id = ord.employee_id GROUP BY ord.employee_id, emp.last_name HAVING COUNT(order_id) < 100;
SELECT employee_id, last_name FROM employees WHERE employee_id IN (SELECT employee_id FROM orders GROUP BY employee_id HAVING COUNT(order_id) < 100);
-- Esto está bien
SELECT employee_id, last_name FROM Employees emp WHERE 100 > (SELECT COUNT(order_id) FROM orders WHERE employee_id = emp.employee_id );

--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes
SELECT customer_id, company_name FROM customers cust WHERE 20 < (SELECT COUNT(order_id) FROM orders WHERE customer_id = cust.customer_id );

--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos que se hayan vendido menos de 100 unidades (Consultarlo en la tabla de Orders details).
SELECT product_id, product_name, supplier_id FROM products WHERE product_id IN (SELECT product_id FROM order_details GROUP BY product_id HAVING COUNT(order_id) < 100);
SELECT product_id, product_name, supplier_id FROM products prod WHERE 100 > (SELECT COUNT(order_id) FROM order_details WHERE product_id = prod.product_id );

--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes
SELECT employee_id, CONCAT(first_name,' ',last_name) FROM employees WHERE employee_id IN (SELECT employee_id FROM orders GROUP BY employee_id HAVING COUNT(order_id) > 100 );
SELECT employee_id, CONCAT(first_name,' ',last_name) AS Nombre_Completo FROM employees emp WHERE 100 < (SELECT COUNT(order_id) FROM orders WHERE employee_id = emp.employee_id );

--Obtener los datos de Producto ProductId, ProductName, UnitsinStock, UnitPrice (Tabla Products) de los productos que la sumatoria de la cantidad (Quantity) de orders details sea mayor a 450
SELECT product_id, product_name, units_in_stock, unit_price FROM products WHERE product_id IN (SELECT product_id FROM order_details GROUP BY product_id HAVING SUM(quantity) > 450);
SELECT product_id, product_name, units_in_stock, unit_price FROM products prod WHERE 450 < (SELECT SUM(quantity) FROM order_details WHERE product_id = prod.product_id);

--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes.
SELECT customer_id, company_name FROM customers WHERE customer_id IN (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(order_id) > 20);
SELECT customer_id, company_name FROM customers cust WHERE 20 < (SELECT COUNT(order_id) FROM orders WHERE customer_id = cust.customer_id );

--insert

--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar la información del CategoryName y la descripción los Papelería y papelería escolar
SELECT * FROM categories;
INSERT INTO categories(category_id,category_name,description) VALUES (9,'Papelería','Papelería escolar')

--Dar de alta un producto con Productname, SupplierId, CategoryId, UnitPrice, UnitsInStock 
--Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
INSERT INTO products(product_id,product_name,supplier_id,category_id,unit_price,units_in_stock,discontinued) VALUES (78,'Patatas Fritas',1,1,2,400,0);

--Dar de alta un empleado con LastName, FistName, Title, BrithDate
SELECT * FROM employees;
INSERT INTO employees(employee_id,last_name,first_name,title,birth_date) VALUES (10,'Alonso','Fernando','El 33','15-04-1983');

--Dar de alta una orden, CustomerId, Employeeid, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta
SELECT * FROM orders;
INSERT INTO orders(order_id,customer_id,employee_id,order_date,ship_via) VALUES (20000,'VINET',4,'09-05-2023',4);

--Dar de alta un Order details, con todos los datos
SELECT * FROM order_details;
INSERT INTO order_details VALUES (20000,42,9.8,30,0);

--update

-- Cambiar el CategoryName a Verduras de la categoria 10 (No hay, lo hago de la 9)
SELECT * FROM categories;
UPDATE categories SET category_name = 'Verduras' WHERE category_id = 9;

-- Actualizar los precios de la tabla de Productos para incrementarlos un 10%
UPDATE products SET unit_price = (unit_price + unit_price * 0.1);
UPDATE products SET unit_price = unit_price * 1.1;
SELECT * FROM products;

--ACTUALIZAR EL PRODUCTNAME DEL PRODUCTO 80 (78 porque 80 no hay) A ZANAHORIA ECOLOGICA
UPDATE products SET product_name = 'Zanahoria Ecológica' WHERE product_id = 78;
SELECT * FROM products;

--ACTUALIZAR EL FIRSTNAME DEL EMPLOYEE 10 A ROSARIO 
SELECT * FROM employees;
UPDATE employees SET first_name = 'Rosario' WHERE employee_id = 10;

--ACTUALIZAR EL ORDERS DETAILS DE LA 11079 (No hay 11079, así que de la 11077) PARA QUE SU CANTIDAD SEA 10
SELECT * FROM order_details;
UPDATE order_details SET quantity = 10 WHERE order_id = 11077;
-- Esto actualiza de TODOS los productos de ese pedido, habría que seleccionar también los productos que se quieran

--Delete

--diferencia entre delete y truncate
-- El DELETE suele utilizarse para eliminar DETERMINADAS tuplas, y el truncate es para
-- limpiar la tabla completa. Delete sin where elimina todo pero es menos eficiente.

--BORRAR EL EMPLEADO 10
DELETE FROM employees WHERE employee_id = 10;
SELECT * FROM employees;


