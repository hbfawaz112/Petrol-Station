-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2021 at 11:36 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `petrol_station`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getContainerCurrentVolume` (IN `containerId` INT, OUT `Volume` DECIMAL(11,2))  BEGIN
	   DECLARE volume0 decimal(11,2);
       DECLARE totalRecordes decimal(11,2);
       DECLARE totalShipmentsVolume decimal(11,2);
	   
	   
       SELECT container.Volume0 into volume0 FROM container where container.CONTAINER_ID=containerId;
	   
	  SELECT IFNULL(Sum(r.records),0) into totalRecordes from 
		((SELECT (Max(pumprecords.RECORD)-Min(pumprecords.RECORD)) as records FROM
		pumprecords where pumprecords.CONTAINER_ID=containerId GROUP BY xid) as r);
	  
	   SELECT IFNULL(SUM(shipment.SHIPMENTVOLUME),0) into totalShipmentsVolume from shipment WHERE shipment.CONTAINER_ID=containerId; 
        
		
	   SET Volume=totalShipmentsVolume+volume0-totalRecordes;
       
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCurrentPumpPrices` (IN `pumpId` INT, OUT `OfficalPrice` INT, OUT `Profit` INT)  BEGIN
	   
	select prices.OFFICALPRICE into OfficalPrice from container join fuel_types f
	on container.FUELTYPEID=f.FUELTYPEID join prices
		on prices.FUELTYPEID=f.FUELTYPEID join pump on
		pump.CONTAINER_ID=container.CONTAINER_ID 
			where pump.PUMPID=pumpId ORDER BY prices.PRICEDATE DESC LIMIT 1;

	
    select profits.PROFITVALUE into Profit from container join fuel_types f
	
		on container.FUELTYPEID=f.FUELTYPEID join profits 
			on profits.FUELTYPEID=f.FUELTYPEID join pump on
		pump.CONTAINER_ID=container.CONTAINER_ID 
			where pump.PUMPID=pumpId ORDER BY profits.PROFITDATE DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFuelPrices` (IN `fuelId` INT, IN `Indate` DATETIME, OUT `OfficalPrice` INT, OUT `Profit` INT)  BEGIN
	   

	select prices.OFFICALPRICE into OfficalPrice from prices
		
			where prices.FUELTYPEID=fuelId and prices.PRICEDATE<Indate ORDER BY prices.PRICEDATE DESC LIMIT 1;

	
    select profits.PROFITVALUE into Profit from  profits 
			
			where profits.FUELTYPEID=fuelId and profits.PROFITDATE<Indate ORDER BY profits.PROFITDATE DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastPumpRecordBill` (IN `pump_Id` INT, OUT `Bill` INT, OUT `Profit` INT)  begin
	DECLARE currentRecord decimal(11,2);
	DECLARE prevousRecord decimal(11,2);
	DECLARE fuelId INTEGER DEFAULT 0;
	DECLARE recordDate datetime;
    DECLARE oPrice INTEGER DEFAULT 0;
    DECLARE pPrice INTEGER DEFAULT 0;
	DECLARE totalBill INTEGER DEFAULT 0;
	DECLARE totalProfit INTEGER DEFAULT 0;
  
  
	select  pumprecords.RECORDDATE, pumprecords.RECORD, f.FUELTYPEID into recordDate, currentRecord, fuelId	
	from container
	join pumprecords on pumprecords.CONTAINER_ID=container.CONTAINER_ID 
	join fuel_types f on container.FUELTYPEID=f.FUELTYPEID
	where pumprecords.RECORDDATE = (SELECT Max(p.RECORDDATE)  from pumprecords p 
	where   p.PUMPID=pump_Id ) and pumprecords.PUMPID=pump_Id;
	
	
    /*get the Fuel officalPrice and profit in the recordDate*/
	CALL getFuelPrices(fuelId,recordDate,@o1, @o2);
    SELECT @o1 into oPrice;
    SELECT @o2  into pPrice;
			
	/*get Prevous Counter*/
	select Max(pumprecords.RECORD) into prevousRecord 
	from pumprecords 
	where pumprecords.PUMPID=pump_Id and pumprecords.RECORDDATE<recordDate; 
	set Bill = (oPrice*(currentRecord-prevousRecord));
	set Profit = (pPrice*(currentRecord-prevousRecord));

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPumpBillByDateandfuel_type` (IN `pump_Id` INT, IN `fuelId` INT, IN `mindate` DATE, IN `maxdate` DATE, OUT `Bill` INT, OUT `Profit` INT, OUT `litters` INT)  begin
	DECLARE currentRecord decimal(11,2);
	DECLARE prevousRecord decimal(11,2);
	
	
    DECLARE recordDate datetime;
    DECLARE oPrice INTEGER DEFAULT 0;
    DECLARE pPrice INTEGER DEFAULT 0;
	
	DECLARE totalLitters INTEGER DEFAULT 0;
	DECLARE totalBill INTEGER DEFAULT 0;
	DECLARE totalProfit INTEGER DEFAULT 0;
	DECLARE finished INTEGER DEFAULT 0;
  
	/*cursor to fetch the pumprecordsValue and pumprecordsDate of the given pump
    where this records where recorded on a container of fuel_type fuelId*/
	DECLARE c cursor for
		select  pumprecords.RECORD,pumprecords.RECORDDATE 
			from container
			join pumprecords on pumprecords.CONTAINER_ID=container.CONTAINER_ID 
			join fuel_types f on container.FUELTYPEID=f.FUELTYPEID
			where pumprecords.PUMPID=pump_Id and f.FUELTYPEID=fuelId and date(pumprecords.RECORDDATE) between mindate and maxdate
			order by pumprecords.RECORDDATE asc;
        
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
  	
	
	
	open c;
	
		recordsLoop: LOOP
		
			fetch c into currentRecord, recordDate;
			IF finished = 1 THEN 
				LEAVE recordsLoop;
			END IF;
			
			/*get the Fuel officalPrice and profit in the recordDate*/
			CALL getFuelPrices(fuelId,recordDate,@o1, @o2);
            SELECT @o1 into oPrice;
            SELECT @o2  into pPrice;
			
			/*get Prevous Counter*/
			select Max(pumprecords.RECORD) into prevousRecord 
			from pumprecords 
			where pumprecords.PUMPID=pump_Id and pumprecords.RECORDDATE<recordDate; 
			
			set totalBill=totalBill+(oPrice*(currentRecord-prevousRecord));
			set totalProfit=totalProfit+(pPrice*(currentRecord-prevousRecord));
			set totalLitters=totalLitters+currentRecord-prevousRecord;
			
            
   			
		END LOOP recordsLoop;
        set litters=totalLitters;
        SET Bill=totalBill;
        SET Profit=totalProfit;
		close c;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPumpLittersByDate` (IN `pump_Id` INT, IN `mindate` DATE, IN `maxdate` DATE, OUT `litters` INT)  begin

	DECLARE MaxRecord decimal(11,2);
	DECLARE minRecord decimal(11,2);
	DECLARE minRecord2 decimal(11,2);
	
  
	select ifNull(Max(pumprecords.RECORD),-1) into MaxRecord from pumprecords where pumprecords.PUMPID=pump_Id and date(pumprecords.RECORDDATE) between mindate and maxdate;
  
	if MaxRecord = -1.00
	then 
		set litters = 0;
	else
		select min(RECORD) into minRecord from pumprecords where pumprecords.PUMPID=pump_Id;
		
		select ifNull(Max(pumprecords.RECORD),minRecord) into minRecord2 from pumprecords where pumprecords.PUMPID=pump_Id and 
		pumprecords.RECORDDATE < mindate;
		
		set litters = MaxRecord - minRecord2;
	end if;	
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTotalDebt` (OUT `totalDebt` INT)  begin
	DECLARE vouchers INTEGER DEFAULT 0;
	DECLARE transactions INTEGER DEFAULT 0;
	SELECT ifNull(Sum(transaction.TRANSACTIONVALUE),0) into transactions FROM `transaction`;
	
	SELECT ifNull(sum(`VOUCHERVALUE`),0) into vouchers FROM `voucher`;
    set totalDebt = vouchers - transactions;
		

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPumpRecord` (IN `pumpId` INT, IN `newRecord` DECIMAL(11,2), IN `recordDate` DATETIME)  BEGIN
	   DECLARE cid int;
       Declare xid timestamp;
	   
	   select pump.xid into xid from pump where pump.PUMPID=pumpId;
	   select pump.CONTAINER_ID into cid from pump where pump.PUMPID=pumpId;
	   INSERT INTO `pumprecords` (`PUMPRECORDID`, `PUMPID`, `RECORD`, `RECORDDATE`, `CONTAINER_ID`, `xid`) 
	   VALUES (NULL, pumpId, newRecord, `recordDate`, cid, xid);
	 
     
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePump` (IN `pumpId` INT, IN `containerId` INT, IN `name` VARCHAR(200))  BEGIN

	   Declare current_name varchar(200);
       Declare current_containerId INT;
	   DECLARE prevousCounter decimal(11,2);
       Declare Newxid timestamp;
	   SELECT pump.PUMPNAME into current_name from pump where pump.PUMPID=pumpId;

	
	   SELECT pump.CONTAINER_ID into current_containerId from pump where pump.PUMPID=pumpId;
	   

	if containerId != current_containerId
	then
		set Newxid=CURRENT_TIMESTAMP;
		update pump set pump.xid=Newxid,pump.CONTAINER_ID=containerId,pump.PUMPNAME=name where pump.PUMPID=pumpId;
		SELECT MAX(pumprecords.RECORD) into prevousCounter from pumprecords where pumprecords.PUMPID=pumpId;
		INSERT INTO `pumprecords` (`PUMPRECORDID`, `PUMPID`, `RECORD`, `RECORDDATE`, `CONTAINER_ID`, `xid`) 
		VALUES (NULL, pumpId, prevousCounter, CURRENT_TIMESTAMP, containerId, Newxid);
	else
		update pump set pump.PUMPNAME=name where pump.PUMPID=pumpId;

	end if;   

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `container`
--

CREATE TABLE `container` (
  `CONTAINER_ID` int(11) NOT NULL,
  `FUELTYPEID` int(11) DEFAULT NULL,
  `CONTAINERNAME` varchar(200) DEFAULT NULL,
  `CAPACITY` decimal(11,2) DEFAULT NULL,
  `Volume0` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `container`
--

INSERT INTO `container` (`CONTAINER_ID`, `FUELTYPEID`, `CONTAINERNAME`, `CAPACITY`, `Volume0`) VALUES
(6, 29, 'Container 95', '25000.00', '5000.00'),
(7, 30, 'Container 98', '25000.00', '3554.00'),
(8, 31, 'Container Diesel', '25000.00', '747.00');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CUSTOMERID` int(11) NOT NULL,
  `CUSTOMERNAME` varchar(200) DEFAULT NULL,
  `CUSTOMERPHONE` char(8) DEFAULT NULL,
  `CUSTOMEREMAIL` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CUSTOMERID`, `CUSTOMERNAME`, `CUSTOMERPHONE`, `CUSTOMEREMAIL`) VALUES
(47, 'AAAAA', '01111111', ''),
(48, 'BBBBB', '03333333', '');

-- --------------------------------------------------------

--
-- Table structure for table `dispenser`
--

CREATE TABLE `dispenser` (
  `DISPENSERID` int(11) NOT NULL,
  `DISPENSERNAME` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dispenser`
--

INSERT INTO `dispenser` (`DISPENSERID`, `DISPENSERNAME`) VALUES
(2, 'Dispenser 1');

-- --------------------------------------------------------

--
-- Table structure for table `fuel_types`
--

CREATE TABLE `fuel_types` (
  `FUELTYPEID` int(11) NOT NULL,
  `TYPENAME` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fuel_types`
--

INSERT INTO `fuel_types` (`FUELTYPEID`, `TYPENAME`) VALUES
(29, '95'),
(30, '98'),
(31, 'Diesel');

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

CREATE TABLE `prices` (
  `PRICEID` int(11) NOT NULL,
  `FUELTYPEID` int(11) DEFAULT NULL,
  `OFFICALPRICE` int(11) DEFAULT NULL,
  `PRICEDATE` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prices`
--

INSERT INTO `prices` (`PRICEID`, `FUELTYPEID`, `OFFICALPRICE`, `PRICEDATE`) VALUES
(185, 29, 1300, '2021-03-12 12:06:07'),
(186, 29, 1350, '2021-03-12 12:06:29'),
(187, 30, 1200, '2021-03-12 12:09:03'),
(188, 31, 600, '2021-03-12 12:09:10');

-- --------------------------------------------------------

--
-- Table structure for table `profits`
--

CREATE TABLE `profits` (
  `PROFITID` int(11) NOT NULL,
  `FUELTYPEID` int(11) DEFAULT NULL,
  `PROFITVALUE` int(11) DEFAULT NULL,
  `PROFITDATE` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profits`
--

INSERT INTO `profits` (`PROFITID`, `FUELTYPEID`, `PROFITVALUE`, `PROFITDATE`) VALUES
(182, 29, 200, '2021-03-12 12:06:07'),
(183, 29, 250, '2021-03-12 12:06:29'),
(184, 30, 200, '2021-03-12 12:09:03'),
(185, 31, 100, '2021-03-12 12:09:10');

-- --------------------------------------------------------

--
-- Table structure for table `provider`
--

CREATE TABLE `provider` (
  `PROVIDERID` int(11) NOT NULL,
  `PROVIDERNAME` varchar(200) DEFAULT NULL,
  `phone` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `provider`
--

INSERT INTO `provider` (`PROVIDERID`, `PROVIDERNAME`, `phone`) VALUES
(8, 'IPT', '71624111');

-- --------------------------------------------------------

--
-- Table structure for table `pump`
--

CREATE TABLE `pump` (
  `PUMPID` int(11) NOT NULL,
  `DISPENSERID` int(11) NOT NULL,
  `CONTAINER_ID` int(11) DEFAULT NULL,
  `PUMPNAME` varchar(200) DEFAULT NULL,
  `xid` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pump`
--

INSERT INTO `pump` (`PUMPID`, `DISPENSERID`, `CONTAINER_ID`, `PUMPNAME`, `xid`) VALUES
(46, 2, 6, 'Pump 1', '2020-04-24 17:36:31'),
(47, 2, 6, 'Pump 2', '2020-04-24 17:36:47'),
(48, 2, 7, 'Pump 3', '2020-04-24 17:37:04'),
(49, 2, 7, 'Pump 4', '2020-04-24 17:37:18'),
(50, 2, 8, 'Pump 5', '2020-04-24 17:37:39');

-- --------------------------------------------------------

--
-- Table structure for table `pumprecords`
--

CREATE TABLE `pumprecords` (
  `PUMPRECORDID` int(11) NOT NULL,
  `PUMPID` int(11) DEFAULT NULL,
  `RECORD` decimal(11,2) DEFAULT NULL,
  `RECORDDATE` datetime DEFAULT NULL,
  `CONTAINER_ID` int(11) NOT NULL,
  `xid` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pumprecords`
--

INSERT INTO `pumprecords` (`PUMPRECORDID`, `PUMPID`, `RECORD`, `RECORDDATE`, `CONTAINER_ID`, `xid`) VALUES
(1280, 46, '1000.00', '2021-03-12 11:58:30', 6, '2020-04-24 17:36:31'),
(1281, 46, '2000.00', '2021-03-12 11:59:26', 6, '2020-04-24 17:36:31'),
(1282, 47, '3000.00', '2021-03-12 12:00:00', 6, '2020-04-24 17:36:47'),
(1283, 47, '4000.00', '2021-03-12 12:00:13', 6, '2020-04-24 17:36:47'),
(1284, 47, '4500.00', '2021-03-12 12:00:52', 6, '2020-04-24 17:36:47'),
(1285, 47, '5000.00', '2021-03-12 12:02:06', 6, '2020-04-24 17:36:47'),
(1286, 46, '2001.00', '2021-03-12 12:06:55', 6, '2020-04-24 17:36:31'),
(1287, 48, '1000.00', '2021-03-12 12:08:33', 7, '2020-04-24 17:37:04'),
(1288, 49, '200.00', '2021-03-12 12:08:39', 7, '2020-04-24 17:37:18'),
(1289, 50, '200.00', '2021-03-12 12:08:48', 8, '2020-04-24 17:37:39'),
(1290, 50, '300.00', '2021-03-12 12:10:12', 8, '2020-04-24 17:37:39');

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

CREATE TABLE `shipment` (
  `SHIPMENTID` int(11) NOT NULL,
  `PROVIDERID` int(11) DEFAULT NULL,
  `CONTAINER_ID` int(11) DEFAULT NULL,
  `SHIPMENTVOLUME` decimal(11,2) DEFAULT NULL,
  `SHIPMENTVALUE` int(11) NOT NULL,
  `ISPAID` tinyint(4) NOT NULL,
  `PAIDDATE` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SHIPMENTDATE` timestamp NULL DEFAULT NULL,
  `COMMENTS` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shipment`
--

INSERT INTO `shipment` (`SHIPMENTID`, `PROVIDERID`, `CONTAINER_ID`, `SHIPMENTVOLUME`, `SHIPMENTVALUE`, `ISPAID`, `PAIDDATE`, `SHIPMENTDATE`, `COMMENTS`) VALUES
(181, 8, 6, '15000.00', 30000000, 1, '2021-03-12 09:55:34', '2021-03-12 09:54:52', '');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `TRANSACTIONID` int(11) NOT NULL,
  `CUSTOMERID` int(11) DEFAULT NULL,
  `TRANSACTIONVALUE` int(11) DEFAULT NULL,
  `TRANSACTIONDATE` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`TRANSACTIONID`, `CUSTOMERID`, `TRANSACTIONVALUE`, `TRANSACTIONDATE`) VALUES
(147, 47, 2000, '2021-03-12 10:15:47');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `USERID` int(11) NOT NULL,
  `USERNAME` varchar(100) DEFAULT NULL,
  `PASSWORD` char(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`USERID`, `USERNAME`, `PASSWORD`) VALUES
(2, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997');

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE `voucher` (
  `VOUCHERID` int(11) NOT NULL,
  `CUSTOMERID` int(11) DEFAULT NULL,
  `FUELTYPEID` int(11) DEFAULT NULL,
  `VOUCHERVALUE` int(11) DEFAULT NULL,
  `VOUCHERDATE` timestamp NULL DEFAULT NULL,
  `NOTE` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`VOUCHERID`, `CUSTOMERID`, `FUELTYPEID`, `VOUCHERVALUE`, `VOUCHERDATE`, `NOTE`) VALUES
(283, 47, 29, 32000, '2021-03-12 10:15:08', 'sdkfhgsoigjf'),
(284, 47, 29, 60000, '2021-03-12 10:15:25', ''),
(285, 48, 30, 300000, '2021-03-12 10:16:51', ''),
(286, 48, 31, 60000, '2021-03-12 10:16:57', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `container`
--
ALTER TABLE `container`
  ADD PRIMARY KEY (`CONTAINER_ID`),
  ADD UNIQUE KEY `CONTAINER_PK` (`CONTAINER_ID`),
  ADD KEY `R4_FK` (`FUELTYPEID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CUSTOMERID`),
  ADD UNIQUE KEY `CUSTOMER_PK` (`CUSTOMERID`);

--
-- Indexes for table `dispenser`
--
ALTER TABLE `dispenser`
  ADD PRIMARY KEY (`DISPENSERID`),
  ADD UNIQUE KEY `DISPENSER_PK` (`DISPENSERID`);

--
-- Indexes for table `fuel_types`
--
ALTER TABLE `fuel_types`
  ADD PRIMARY KEY (`FUELTYPEID`),
  ADD UNIQUE KEY `FUEL_TYPES_PK` (`FUELTYPEID`);

--
-- Indexes for table `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`PRICEID`),
  ADD UNIQUE KEY `PRICES_PK` (`PRICEID`),
  ADD KEY `R5_FK` (`FUELTYPEID`);

--
-- Indexes for table `profits`
--
ALTER TABLE `profits`
  ADD PRIMARY KEY (`PROFITID`),
  ADD UNIQUE KEY `PROFITS_PK` (`PROFITID`),
  ADD KEY `R10_FK` (`FUELTYPEID`);

--
-- Indexes for table `provider`
--
ALTER TABLE `provider`
  ADD PRIMARY KEY (`PROVIDERID`),
  ADD UNIQUE KEY `PROVIDER_PK` (`PROVIDERID`);

--
-- Indexes for table `pump`
--
ALTER TABLE `pump`
  ADD PRIMARY KEY (`PUMPID`),
  ADD UNIQUE KEY `PUMP_PK` (`PUMPID`),
  ADD KEY `R2_FK` (`DISPENSERID`),
  ADD KEY `R8_FK` (`CONTAINER_ID`);

--
-- Indexes for table `pumprecords`
--
ALTER TABLE `pumprecords`
  ADD PRIMARY KEY (`PUMPRECORDID`),
  ADD UNIQUE KEY `PUMPRECORDS_PK` (`PUMPRECORDID`),
  ADD KEY `R3_FK` (`PUMPID`);

--
-- Indexes for table `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`SHIPMENTID`),
  ADD UNIQUE KEY `SHIPMENT_PK` (`SHIPMENTID`),
  ADD KEY `R11_FK` (`PROVIDERID`),
  ADD KEY `R_0_FK` (`CONTAINER_ID`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`TRANSACTIONID`),
  ADD UNIQUE KEY `TRANSACTION_PK` (`TRANSACTIONID`),
  ADD KEY `R7_FK` (`CUSTOMERID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`USERID`),
  ADD UNIQUE KEY `USER_PK` (`USERID`);

--
-- Indexes for table `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`VOUCHERID`),
  ADD UNIQUE KEY `VOUCHER_PK` (`VOUCHERID`),
  ADD KEY `R6_FK` (`CUSTOMERID`),
  ADD KEY `R9_FK` (`FUELTYPEID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `container`
--
ALTER TABLE `container`
  MODIFY `CONTAINER_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CUSTOMERID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `dispenser`
--
ALTER TABLE `dispenser`
  MODIFY `DISPENSERID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `fuel_types`
--
ALTER TABLE `fuel_types`
  MODIFY `FUELTYPEID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `prices`
--
ALTER TABLE `prices`
  MODIFY `PRICEID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `profits`
--
ALTER TABLE `profits`
  MODIFY `PROFITID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `provider`
--
ALTER TABLE `provider`
  MODIFY `PROVIDERID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pump`
--
ALTER TABLE `pump`
  MODIFY `PUMPID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `pumprecords`
--
ALTER TABLE `pumprecords`
  MODIFY `PUMPRECORDID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1291;

--
-- AUTO_INCREMENT for table `shipment`
--
ALTER TABLE `shipment`
  MODIFY `SHIPMENTID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `TRANSACTIONID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `USERID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `voucher`
--
ALTER TABLE `voucher`
  MODIFY `VOUCHERID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=287;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `container`
--
ALTER TABLE `container`
  ADD CONSTRAINT `FK_CONTAINE_R4_FUEL_TYP` FOREIGN KEY (`FUELTYPEID`) REFERENCES `fuel_types` (`FUELTYPEID`);

--
-- Constraints for table `prices`
--
ALTER TABLE `prices`
  ADD CONSTRAINT `FK_PRICES_R5_FUEL_TYP` FOREIGN KEY (`FUELTYPEID`) REFERENCES `fuel_types` (`FUELTYPEID`);

--
-- Constraints for table `profits`
--
ALTER TABLE `profits`
  ADD CONSTRAINT `FK_PROFITS_R10_FUEL_TYP` FOREIGN KEY (`FUELTYPEID`) REFERENCES `fuel_types` (`FUELTYPEID`);

--
-- Constraints for table `pump`
--
ALTER TABLE `pump`
  ADD CONSTRAINT `FK_PUMP_R2_DISPENSE` FOREIGN KEY (`DISPENSERID`) REFERENCES `dispenser` (`DISPENSERID`),
  ADD CONSTRAINT `FK_PUMP_R8_CONTAINE` FOREIGN KEY (`CONTAINER_ID`) REFERENCES `container` (`CONTAINER_ID`);

--
-- Constraints for table `pumprecords`
--
ALTER TABLE `pumprecords`
  ADD CONSTRAINT `FK_PUMPRECO_R3_PUMP` FOREIGN KEY (`PUMPID`) REFERENCES `pump` (`PUMPID`);

--
-- Constraints for table `shipment`
--
ALTER TABLE `shipment`
  ADD CONSTRAINT `FK_SHIPMENT_R11_PROVIDER` FOREIGN KEY (`PROVIDERID`) REFERENCES `provider` (`PROVIDERID`),
  ADD CONSTRAINT `FK_SHIPMENT_R_0_CONTAINE` FOREIGN KEY (`CONTAINER_ID`) REFERENCES `container` (`CONTAINER_ID`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `FK_TRANSACT_R7_CUSTOMER` FOREIGN KEY (`CUSTOMERID`) REFERENCES `customer` (`CUSTOMERID`);

--
-- Constraints for table `voucher`
--
ALTER TABLE `voucher`
  ADD CONSTRAINT `FK_VOUCHER_R6_CUSTOMER` FOREIGN KEY (`CUSTOMERID`) REFERENCES `customer` (`CUSTOMERID`),
  ADD CONSTRAINT `FK_VOUCHER_R9_FUEL_TYP` FOREIGN KEY (`FUELTYPEID`) REFERENCES `fuel_types` (`FUELTYPEID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
