CREATE TABLE [dbo].[Products](
	[ProductID] [int] NULL,
	[ProductName] [varchar](1000) NULL,
	[Quantity] [int] NULL,
	[ProductImage] [varchar](1000) NULL
) ON [PRIMARY]

INSERT INTO Products(ProductID,ProductName,Quantity,ProductImage) VALUES (1,'Cotton',100,'https://${storage-account-name}.blob.core.windows.net/${app-container-name}/cotton.jpg')

INSERT INTO Products(ProductID,ProductName,Quantity,ProductImage) VALUES (2,'Dark',200,'https://${storage-account-name}.blob.core.windows.net/${app-container-name}/dark.jpg')

INSERT INTO Products(ProductID,ProductName,Quantity,ProductImage) VALUES (3,'Rock',300,'https://${storage-account-name}.blob.core.windows.net/${app-container-name}/rock.jpg')

INSERT INTO Products(ProductID,ProductName,Quantity,ProductImage) VALUES (4,'Fortune',400,'https://${storage-account-name}.blob.core.windows.net/${app-container-name}/fortune.jpg')

     	