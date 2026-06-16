-- Selecting the database

USE sample_sql_project;

-- Viewing raw table

SELECT *
FROM Nashville_Housing;

-- Viweing the table schema

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'NASHVILLE_HOUSING'



-- Standardize Date Format

SELECT
	SaleDate
FROM Nashville_Housing;

ALTER TABLE Nashville_Housing
ALTER COLUMN SaleDate DATE;




-- Populate Property Address data

SELECT
	PropertyAddress
FROM Nashville_Housing;

SELECT *
FROM Nashville_Housing
WHERE PropertyAddress IS NULL;

SELECT *
FROM Nashville_Housing
WHERE PropertyAddress IS NULL
ORDER BY ParcelID;

SELECT
	a.ParcelID,
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress,
	COALESCE(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing AS a
INNER JOIN Nashville_Housing AS b
ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


-- Updating the table with the changes

UPDATE a
SET PropertyAddress = COALESCE(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing AS a
INNER JOIN Nashville_Housing AS b
ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL




-- Breaking out Address into individual columns (Address, City, State)


-- Breaking out the Property Address

SELECT
	PropertyAddress
FROM Nashville_Housing;

SELECT
	PropertyAddress,
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS City
FROM Nashville_Housing

-- Adding new columns

ALTER TABLE Nashville_Housing
ADD PropertySplitAddress NVARCHAR(255),
	PropertySplitCity NVARCHAR(255);

-- Updating the table with the changes

UPDATE Nashville_Housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1),
	PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress));



-- Breaking out the Owner Address

SELECT
	OwnerAddress
FROM Nashville_Housing;

SELECT
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM Nashville_Housing;

-- Adding new columns

ALTER TABLE Nashville_Housing
ADD OwnerSplitAddress NVARCHAR(255),
	OwnerSplitCity NVARCHAR(255),
	OwnerSplitState NVARCHAR(10);

-- Updating the table with the changes

UPDATE Nashville_Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);





-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT SoldAsVacant,
	COUNT(SoldAsVacant)
FROM Nashville_Housing
GROUP BY SoldAsVacant
ORDER BY COUNT(SoldAsVacant);


SELECT
	SoldAsVacant,
	CASE
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END AS status
FROM Nashville_Housing;

-- Updating the table with the changes

UPDATE Nashville_Housing
SET SoldAsVacant = CASE
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END





-- Remove Duplicates

WITH row_num_cte AS (
SELECT
	ROW_NUMBER() OVER (
		PARTITION BY
			ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
		ORDER BY
			UniqueID
	) AS row_num,
	*
FROM Nashville_Housing
)
DELETE
FROM row_num_cte
WHERE row_num >1





-- Delete Unused Columns

ALTER TABLE Nashville_Housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress
