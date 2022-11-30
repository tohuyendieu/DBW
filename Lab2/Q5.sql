/* ------------------------------------------------------------------------------------- Question 5-----------------------------------------*/
/* trigger for automatically update the current machine of the corresponding DVD
to null when inserting a DVD into a rental */

create trigger Question5
on RentalDetails
for INSERT
as
begin
    UPDATE DVDs
	SET machineID = null
	WHERE barcode in (
		SELECT inserted.DVDbarcode
		FROM inserted
	)
end

--INSERT INTO RentalDetails(rentalNumber, DVDbarcode, rentalPrice, receiptNumber)
--VALUES (10, 24, 3, null)