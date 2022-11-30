/* ------------------------------------------------------------------------------------- Question 10---------------------------------------------------------*/
/*the total quantity of rented DVDs in each machine*/

SELECT Rentals.machineID, count(Rentals.machineID) AS Quantity
FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
	 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
GROUP BY Rentals.machineID