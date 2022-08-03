-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,> GetBySearch 'Voice Remote'
-- =============================================
CREATE PROCEDURE GetBySearch
@search nvarchar(max)=null
AS
BEGIN
	SELECT*from[dbo].[Tbl_Product] P
	left join [dbo].[Tbl_Category] C on P.CategoryId=C.CategoryId
	where
	P.ProductName Like CASE WHEN @search is not null then '%'+@search+'%' else P.ProductName end
	OR
	C.CategoryName LIKE CASE WHEN @search is not null then '%'+@search+'%' else C.CategoryName end
END
GO
