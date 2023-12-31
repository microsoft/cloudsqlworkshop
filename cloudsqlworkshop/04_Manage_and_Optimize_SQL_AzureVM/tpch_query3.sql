DBCC DROPCLEANBUFFERS;
GO
SELECT 
TOP (1000001) [t0].[N_NAME],SUM([t0].[REVENUE])
 AS [a0]
FROM 
(
(SELECT	TOP 10
	L_ORDERKEY,
	SUM(L_EXTENDEDPRICE*(1-L_DISCOUNT))	AS REVENUE,
	O_ORDERDATE,
	O_SHIPPRIORITY,
	N.N_NAME
FROM	CUSTOMER C,
	ORDERS,
	LINEITEM,
	NATION N
WHERE	C_MKTSEGMENT	= 'BUILDING' AND
	C_CUSTKEY	= O_CUSTKEY AND
	L_ORDERKEY	= O_ORDERKEY AND
	O_ORDERDATE	< '1995-03-15' AND
	L_SHIPDATE	> '1995-03-15'
	AND C.C_NATIONKEY = N.N_NATIONKEY
GROUP	BY	L_ORDERKEY,
		O_ORDERDATE,
		O_SHIPPRIORITY,
		N.N_NAME
ORDER	BY	REVENUE DESC,
		O_ORDERDATE)
)
 AS [t0]
GROUP BY [t0].[N_NAME];
GO