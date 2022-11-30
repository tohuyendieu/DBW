/* ------------------------------------------------------------------------------- Question 7---------------------------------------------------------*/
/*Question7: create a function for calculating the total amount of a movie rented in a period where
   MovieID, fromTime and toTime are three input parameters of the function */

MERGE RentalDetails as r
USING (SELECT DVDbarcode, rentalDate, Rentals.rentalNumber, RentalDetails.receiptNumber,				
			(DATEDIFF(day, Rentals.rentalDate, Receipts.returnDate)+ 1)* rentalPrice AS Amount
		FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
			 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
			 JOIN Receipts ON RentalDetails.receiptNumber = Receipts.receiptNumber) AS T
ON r.rentalNumber = t.rentalNumber AND r.DVDbarcode = T.DVDbarcode
WHEN MATCHED THEN UPDATE SET r.amount = T.amount;

create function Question7(@MovieID INT, @fromTime DATE, @toTime DATE)
returns FLOAT
as
begin
	declare @totalAmount float

	Select @totalAmount = sum(RentalDetails.amount)
	From Rentals join RentalDetails on Rentals.rentalNumber = RentalDetails.rentalNumber
		 join DVDs on RentalDetails.DVDbarcode = DVDs.barcode
	Where Rentals.rentalDate between @fromTime and @toTime 
		And DVDs.movieID = @MovieID
	Group by DVDs.movieID

	return @totalAmount
end

--SELECT dbo.Question7(2, '2019-01-01', '2022-01-01')