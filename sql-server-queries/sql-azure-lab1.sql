
-- SQL Server, Azure Data Studio. Database Everyloop 
-- Select columns and display successful missions
SELECT 
    Spacecraft, 
    [Launch date], 
    [Carrier rocket], 
    Operator, 
    [Mission type]
INTO 
    SuccessfulMissions
FROM 
    MoonMissions
WHERE 
    Outcome = 'Successful';
    
GO 

-- Delete blank spaces in Operator column
UPDATE
    SuccessfulMissions
SET
    Operator = LTRIM(Operator)

GO 

-- Delete parenthesis with values
UPDATE 
    SuccessfulMissions
SET 
    Spacecraft = LEFT(Spacecraft, charindex('(', Spacecraft) -1)
WHERE 
    Spacecraft 
LIKE '%(%';

GO 

-- Group and sort columns to display number of assignments by each operator and type, with more than 1 assignment
SELECT 
    Operator, [Mission type] , COUNT(*) 
AS 
    'Mission Count'
FROM  
    SuccessfulMissions
GROUP BY
    Operator, [Mission type]
HAVING 
    COUNT(*) > 1;

GO

-- Add column "Firstname" and "Lastname", create new column with gender specified by personal digits
SELECT
      ID,
      UserName,
       concat(FirstName,' ',LastName) as Name,
       iif(substring(ID,10,1) % 2 =0,'Female', 'Male') as Gender,
      Password,
      Email,
     Phone
INTO 
    NewUsers
FROM  
    Users

GO 

-- Query returning all usernames in "NewUsers" that are not unique, and number of duplicates
SELECT 
    UserName,
COUNT 
    (UserName) UserName_count
FROM 
    NewUsers
GROUP BY 
    UserName
HAVING COUNT 
    (UserName)> 1;

GO 

-- Sequence of queries that updates users with duplicate usernames
UPDATE NewUsers SET UserName='fellan' where ID = '880706-3713' 
UPDATE NewUsers SET UserName='fellis' where ID = '890701-1480' 
UPDATE NewUsers SET UserName='sigepe' where ID = '580802-4175'
UPDATE NewUsers SET UserName='sigfri' where ID = '630303-4894'
UPDATE NewUsers SET UserName='siglip' where ID = '811008-5301'

GO

-- Query deleting all existing female users born before 1970 
DELETE FROM 
    NewUsers 
WHERE 
    SUBSTRING(id,1,2) < 70
AND 
    GENDER = 'female'

GO

-- Add user 
INSERT INTO 
    NewUsers (ID, UserName, Name, Gender, Password, Email, Phone)
VALUES 
    ('510720-7675',
    'alvris', 
    'Alva Risblom',
    'Female',
    '2194506fc6ef7a2048f03a0f4ee7c644',
    'alva.risblom@gmail.com',
    '0701-6100063' );

GO

-- Query returning columns with gender and average age  
SELECT DISTINCT 
    Gender, avg (CONVERT(int, DATEDIFF(YY, LEFT(ID, 6), getdate()))) as AverageAge 
FROM 
    NewUsers 
GROUP BY 
    Gender;