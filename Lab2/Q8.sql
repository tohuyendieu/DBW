/* ------------------------------------------------------------------------------------- Question 8---------------------------------------------------------*/
/* query :the total quantity of each category by customer gender*/

SELECT Customers.gender, Categories.[name], count(Categories.ID)
FROM Rentals JOIN Customers ON Rentals.customerID = Customers.ID
	 JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
	 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
	 JOIN Movies ON DVDs.movieID = Movies.ID
	 JOIN Categories ON Movies.categoryID = Categories.ID
GROUP BY Customers.gender, Categories.[name], Categories.ID
