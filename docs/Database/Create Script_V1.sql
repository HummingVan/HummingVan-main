CREATE TABLE Users
(
	'ID' INT NOT NULL,
	'PhoneNumber' VARCHAR(10) NOT NULL,
	'Name_First' VARCHAR(250) NOT NULL,
	'Name_Last' VARCHAR(250) NOT NULL,
	'Password_Hash' VARCHAR(5000) NOT NULL,
	'Password_Salt' VARCHAR(250) NOT NULL,
	'Email' VARCHAR(250) NOT NULL,
	'APIKey' VARCHAR(250) NOT NULL,
	'IsDriver' BIT NOT NULL DEFAULT 0,
	'IsLockedOut' BIT NOT NULL DEFAULT 0,
	'IsArchived' BIT NOT NULL DEFAULT 0,
	CONSTRAINT PK_Users PRIMARY KEY (ID),
	CONSTRAINT UC_Users_PhoneNumber UNIQUE (PhoneNumber),
	CONSTRAINT UC_Users_Email UNIQUE (Email),
	CONSTRAINT UC_Users_APIKey UNIQUE (APIKey)
);
CREATE TABLE Packages
(
	'ID' INT NOT NULL,
	'User' INT NOT NULL,
	'Driver' INT NOT NULL,
	'GPS_Longitude' VARCHAR(250) NULL,
	'GPS_Latitude' VARCHAR(250) NULL,
	'Dimension_Length_Inch' INT NULL,
	'Dimension_Width_Inch' INT NULL,
	'Dimension_Height_Inch' INT NULL,
	'Weight_Pounds' DECIMAL(5, 3) NULL,
	CONSTRAINT PK_PackageHistory PRIMARY KEY (ID)
);
CREATE TABLE Packages_Archive
(
	'ID' INT NOT NULL,
	'User' INT NOT NULL,
	'Driver' INT NOT NULL,
	'GPS_Longitude' VARCHAR(250) NULL,
	'GPS_Latitude' VARCHAR(250) NULL,
	'Dimension_Length_Inch' INT NULL,
	'Dimension_Width_Inch' INT NULL,
	'Dimension_Height_Inch' INT NULL,
	'Weight_Pounds' DECIMAL(5, 3) NULL,
	'DateArchived' DATETIME NOT NULL,
	CONSTRAINT PK_Packages_Archived PRIMARY KEY (ID)
);
CREATE TABLE PackageHistory
(
	'ID' INT NOT NULL,
	'Package' INT NOT NULL,
	'State' INT NOT NULL,
	'TimeStamp' DATETIME NOT NULL,
	'User' INT NOT NULL,
	CONSTRAINT PK_PackageHistory PRIMARY KEY (ID, State)
);
CREATE TABLE PackageHistory_Archive
(
	'ID' INT NOT NULL,
	'Package' INT NOT NULL,
	'State' INT NOT NULL,
	'TimeStamp' DATETIME NOT NULL,
	'User' INT NOT NULL,
	'DateArchived' DATETIME NOT NULL,
	CONSTRAINT PK_PackageHistory PRIMARY KEY (ID, State)
);
CREATE TABLE PackageState
(
	'ID' INT NOT NULL,
	'DisplayName' VARCHAR(250) NOT NULL,
	'RequiresNotification' BIT NOT NULL DEFAULT 0,
	CONSTRAINT PK_PackageState PRIMARY KEY (ID)
);
ALTER TABLE Packages ADD FOREIGN KEY (User) REFERENCES Users(ID);
ALTER TABLE Packages ADD FOREIGN KEY (Driver) REFERENCES Users(ID);
ALTER TABLE Packages_Archived ADD FOREIGN KEY (User) REFERENCES Users(ID);
ALTER TABLE Packages_Archived ADD FOREIGN KEY (Driver) REFERENCES Users(ID);
ALTER TABLE PackageHistory ADD FOREIGN KEY (Package) REFERENCES Packages(ID);
ALTER TABLE PackageHistory ADD FOREIGN KEY (State) REFERENCES PackageState(ID);
ALTER TABLE PackageHistory ADD FOREIGN KEY (User) REFERENCES Users(ID);
ALTER TABLE PackageHistory_Archive ADD FOREIGN KEY (Package) REFERENCES Packages(ID);
ALTER TABLE PackageHistory_Archive ADD FOREIGN KEY (State) REFERENCES PackageState(ID);
ALTER TABLE PackageHistory_Archive ADD FOREIGN KEY (User) REFERENCES Users(ID);