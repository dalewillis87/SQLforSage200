SELECT 
	at.DateTimeCreated as 'DateLogged',
	at.AccountNumber,
      	at.AccountName,
      	SYSAuditTrailEntryTypeID = CASE
        	when at.[SYSAuditTrailEntryTypeID]  = 9 THEN 'Purchase Invoice'
      	ELSE 'Wrong'
      	END,
       	at.TransactionDate,
      	plt.DueDate,
      	at.Reference,
      	at.SecondReference,
      	at.BatchReference,
      	at.NetValue,
      	at.TaxValue,
      	at.GrossValue,
      	AUTHORISER = ' '
      	PAYMENT GROUP = ' '
      	at.UniqueReferenceNumber
      	at.UserName
     
FROM 
	{ServerName}.dbo.SYSAuditTrail as at inner join 
	{ServerName}.dbo.PLPostedSupplierTran as plt on plt.UniqueReferenceNumber = at.UniqueReferenceNumber
/*Insert name of Sage 200 Server*/  
WHERE 

	SYSAuditTrailEntryTypeID IN ('9','10')  and at.datetimecreated > 'YYYY-MM-DD 00:00:00.000'
/*Insert date that Sage started being used/*
