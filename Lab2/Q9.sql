/* ------------------------------------------------------------------------------------- Question 9---------------------------------------------------------*/
/* the total amount of each movie by rental year*/

SELECT title, movieID, total_amount = sum((DATEDIFF(day, Rentals.rentalDate, Receipts.returnDate)+ 1)* rentalPrice), year(rentalDate) as [year]
FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
	 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
	 JOIN Movies ON DVDs.movieID = Movies.ID
	 JOIN Receipts ON RentalDetails.receiptNumber = Receipts.receiptNumber
GROUP BY  year(rentalDate), movieID, title