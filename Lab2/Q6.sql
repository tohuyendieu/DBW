/* -------------------------------------------------------------------------------- Question 6---------------------------------------------------------*/
/* a trigger for automatically calculate the Amount when returning a movie to a machine
                 updates also the current machine of the corresponding DVD to the current machine*/
		
create trigger Question6
on RentalDetails
after UPDATE, INSERT 
NOT FOR REPLICATION
as 
begin
-- begin Transaction
	UPDATE DVDs
	SET machineID = (Select machineID
					 From inserted join Receipts on inserted.receiptNumber = Receipts.receiptNumber)
	WHERE DVDs.barcode in (select inserted.DVDbarcode From inserted);	

	UPDATE RentalDetails
	SET Amount = (Select (DATEDIFF(day, Rentals.rentalDate, Receipts.returnDate)+1)*inserted.rentalPrice
				  From inserted join Rentals on  inserted.rentalNumber = Rentals.rentalNumber
					   join Receipts on inserted.receiptNumber = Receipts.receiptNumber
				  )
	WHERE RentalDetails.DVDbarcode in (select inserted.DVDbarcode From inserted)
		AND RentalDetails.rentalNumber in (select inserted.rentalNumber From inserted);
 --COMMIT;
end


/*UPDATE RentalDetails
SET receiptNumber = 4
WHERE rentalNumber = 10 and DVDbarcode = 22 */
