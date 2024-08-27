/*

Cleaning Data in SQL Queries

*/


SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- 1. Standardize Date Format

SELECT SaleDate
FROM PortfolioProject.dbo.NashvilleHousing


UPDATE NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)


--------------------------------------------------------------------------------------------------------------------------

-- 2. Populate Property Address data

-- as we can see from this query if we know the ParcelID, then the appropriate adddress of that ParcelID will always be the same

WITH AddressData AS (
    SELECT 
        ParcelID, 
        COUNT(*) AS AddressCount
    FROM 
        PortfolioProject.dbo.NashvilleHousing
    GROUP BY 
        ParcelID
    HAVING 
        COUNT(DISTINCT PropertyAddress) > 1
)

SELECT 
    t.ParcelID, 
    t.PropertyAddress
FROM 
    dbo.NashvilleHousing t
JOIN 
    AddressData a
    ON t.ParcelID = a.ParcelID
ORDER BY 
    t.ParcelID, 
    t.PropertyAddress;

-- so let's populate the PropertyAddress using ParcelID

-- first let's write the query and then update
SELECT o.ParcelID, o.PropertyAddress, j.ParcelID, j.PropertyAddress, ISNULL(o.PropertyAddress, j.PropertyAddress) 
FROM NashvilleHousing o
JOIN NashvilleHousing j
    ON j.ParcelID = o.ParcelID 
	AND o.UniqueID <> j.UniqueID
WHERE o.PropertyAddress IS NULL

--update
UPDATE o
SET PropertyAddress = ISNULL(o.PropertyAddress, j.PropertyAddress) 
FROM NashvilleHousing o
JOIN NashvilleHousing j
    ON j.ParcelID = o.ParcelID 
	AND o.UniqueID <> j.UniqueID
WHERE o.PropertyAddress IS NULL

-- now if we check for null values, there are none 
SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
where PropertyAddress is null

--------------------------------------------------------------------------------------------------------------------------

-- 3. Breaking out Addresses into Individual Columns (Address, City)

SELECT
	PropertyAddress, 
	substring(PropertyAddress, 0, CHARINDEX(',', PropertyAddress) - 1) as Address,
	substring(PropertyAddress, CHARINDEX(',', PropertyAddress) + 2, LEN(PropertyAddress)) as City
FROM PortfolioProject.dbo.NashvilleHousing

--update

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(225)

UPDATE NashvilleHousing
SET PropertySplitAddress = substring(PropertyAddress, 0, CHARINDEX(',', PropertyAddress) - 1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(225)

UPDATE NashvilleHousing
SET PropertySplitCity = substring(PropertyAddress, CHARINDEX(',', PropertyAddress) + 2, LEN(PropertyAddress)) 

--using PARSENAME

SELECT 
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) as AdressOwner,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) as CityOwner,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) as StateOwner
FROM PortfolioProject.dbo.NashvilleHousing

--update

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(225)

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(225)

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)



ALTER TABLE NashvilleHousing
ADD OwnerSplitState NVARCHAR(225)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Remove Duplicates

WITH RowNumCTE AS
(
	SELECT 
		*,
		ROW_NUMBER() OVER(
		PARTITION BY ParcelID,
					 PropertyAddress,
					 SalePrice,
					 SaleDate,
					 LegalReference,
					 LandUse
					 ORDER BY UniqueID) row_num	
	FROM PortfolioProject.dbo.NashvilleHousing
	--ORDER BY ParcelID
)
DELETE
FROM RowNumCTE
WHERE row_num > 1;


---------------------------------------------------------------------------------------------------------

-- 5. Delete Unused Columns


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, PropertyAddress, TaxDIstrict;
