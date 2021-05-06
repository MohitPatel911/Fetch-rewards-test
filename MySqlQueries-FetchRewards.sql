/* top 5 brands by receipts scanned for most recent month?*/

select c.brand_Name, count(b.brandCode) as brandCount, DATE_FORMAT(a.dateScanned,'%Y-%m') AS dateScanned
from receipts.receipt as a
inner join receipts.rewardsreceiptitemlist as b
on a.Receipt_id = b.Receipt_id
inner join brand.brands as c
on b.brandCode = c.brandCode
where DATE_FORMAT(a.dateScanned, '%Y-%m') = date_format(DATE_SUB(curdate(), INTERVAL 1 month),'%Y-%m')
group by c.brand_Name
order by brandCount desc
limit 5;


/* When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater? */
/* 1 = Accept / 0 = Reject*/

select receipts.receipt.rewardsReceiptStatus as receiptStatus, AVG(receipts.receipt.totalSpent) as AverageSpent
from receipts.receipt
group by receiptStatus
order by AverageSpent desc;

/*When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’,
which is greater?*/
/* 1 = Accept / 0 = Reject*/

select receipts.receipt.rewardsReceiptStatus as receiptStatus, count(receipts.receipt.purchasedItemCount) as totalItemCount
from receipts.receipt
group by receiptStatus
order by totalItemCount desc;



/*Which brand has the most spend among users who were created within the past 6 months?*/

select d.brand_Name, c.finalPrice, DATE_FORMAT(a.createLoginDate,'%Y-%m') AS 'date'
from users.userdata as a
inner join receipts.receipt as b
on a.userId = b.userId 
inner join receipts.rewardsreceiptitemlist as c
on b.Receipt_id = c.Receipt_id
inner join brand.brands as d
on c.brandCode = d.brandCode
where a.createLoginDate > DATE_SUB(now(), INTERVAL 6 MONTH)
group by a.userId 
order by c.finalPrice desc;
