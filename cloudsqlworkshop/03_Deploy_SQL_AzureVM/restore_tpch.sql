USE MASTER;
GO
DROP DATABASE IF EXISTS tpch;
GO
RESTORE FILELISTONLY FROM DISK = 'F:\data\tpch.bak';
GO
RESTORE DATABASE tpch FROM DISK = 'F:\data\tpch.bak'
WITH MOVE 'tpch' TO 'F:\data\tpch.mdf',
MOVE 'tpch_log' TO 'G:\log\tpch_log.ldf';
GO