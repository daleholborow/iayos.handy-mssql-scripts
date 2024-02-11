
-- see https://stackoverflow.com/questions/1007697/how-to-strip-all-non-alphabetic-characters-from-string-in-sql-server


CREATE FUNCTION [dbo].[fn_StripCharacters]
(
    @String NVARCHAR(MAX), 
    @MatchExpression VARCHAR(255)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    SET @MatchExpression =  '%['+@MatchExpression+']%'
    
    WHILE PatIndex(@MatchExpression, @String) > 0
        SET @String = Stuff(@String, PatIndex(@MatchExpression, @String), 1, '')
    
    RETURN @String
    
END


Alphabetic only:
SELECT dbo.fn_StripCharacters('a1!s2@d3#f4$', '^a-z')

Numeric only:
SELECT dbo.fn_StripCharacters('a1!s2@d3#f4$', '^0-9')

Alphanumeric only:
SELECT dbo.fn_StripCharacters('a1!s2@d3#f4$', '^a-z0-9')

Non-alphanumeric:
SELECT dbo.fn_StripCharacters('a1!s2@d3#f4$', 'a-z0-9')



-----------------------------

Create Function [dbo].[RemoveNonAlphaCharacters](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @KeepValues as varchar(50)
    Set @KeepValues = '%[^a-z]%'
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')

    Return @Temp
End
Call it like this:

Select dbo.RemoveNonAlphaCharacters('abc1234def5678ghi90jkl')



