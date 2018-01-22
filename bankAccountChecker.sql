/* This script is to identify whether a particular account number is present on your Sage 200 database and the current status of the account*/

SELECT 
	SupplierAccountNumber,
      	SupplierAccountName,
      	TaxRegistrationNumber,
	DefaultNominalAccountNumber,
      	DefaultNominalCostCentre,
      	DefaultNominalDepartment,
      	PLPaymentGroupID = CASE
      		when [PLPaymentGroupID]= 1 then 'Account 1'
      		when [PLPaymentGroupID]= 2 then 'Account 1 - DD'
      		when [PLPaymentGroupID]= 3 then 'Account 1 - CHQ'
/*repeat per payment group as decided by finance director*/
	ELSE 'Wrong'
	END,     
      	PaymentTermsInDays,
       	AccountIsOnHold	= CASE
      		when [AccountIsOnHold] = 0 then 'No'
      		when [AccountIsOnHold] = 1 then 'Yes'
       	ELSE 'Wrong'
	END, 
      	plbd.SortCode,
      	plbd.AccountNumber,
      	AccountOpened,
      	DateAccountDetailsLastChanged,
      	DateOfLastTransaction    
FROM 
	{serverName}.dbo.PLSupplierAccount as plsa INNER JOIN
	{serverName}.dbo.PLSupplierBank as plbd on plbd.PLSupplierAccountID = plsa.PLSupplierAccountID
/* Input the name of your Sage 200 server in the {}*/ 
WHERE 
	plbd.AccountNumber = '********'
/*replace the asteriks with the account number you are looking for*/ 

ORDER BY 
	DateAccountDetailsLastChanged desc
