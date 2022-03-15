/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [PortfolioProjects].[dbo].[NashvilleHousing]

  -- Standardize SaleDate

  --Select SaleDate, CONVERT(Date, SaleDate)
  --From PortfolioProjects.dbo.NashvilleHousing

  --UPDATE PortfolioProjects.dbo.NashvilleHousing
  --SET SaleDate=CONVERT(Date, SaleDate)

 ALTER TABLE PortfolioProjects.dbo.NashvilleHousing
 Add SaleDateConv Date

 UPDATE PortfolioProjects.dbo.NashvilleHousing
  SET SaleDateConv=CONVERT(Date, SaleDate)

   Select SaleDateConv
  From PortfolioProjects.dbo.NashvilleHousing

  --Populate Property Address
  Select *
  From PortfolioProjects.dbo.NashvilleHousing
  WHERE PropertyAddress is null

  Select *
  From PortfolioProjects.dbo.NashvilleHousing
  order by ParcelID

  Select T1.ParcelID,T1.PropertyAddress,T2.ParcelID,T2.PropertyAddress
  From PortfolioProjects.dbo.NashvilleHousing T1
  JOIN PortfolioProjects.dbo.NashvilleHousing T2
  on T1.ParcelID=T2.ParcelID
  and T1.[UniqueID ]<>T2.[UniqueID ]
  Where T1.PropertyAddress is null

  UPDATE T1
  SET PropertyAddress=ISNULL(T1.PropertyAddress,T2.PropertyAddress)
  From PortfolioProjects.dbo.NashvilleHousing T1
  JOIN PortfolioProjects.dbo.NashvilleHousing T2
  on T1.ParcelID=T2.ParcelID
  and T1.[UniqueID ]<>T2.[UniqueID ]
  Where T1.PropertyAddress is null

  Select *
  From PortfolioProjects.dbo.NashvilleHousing
  where PropertyAddress is null

  --



