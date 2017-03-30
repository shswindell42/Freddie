﻿CREATE TABLE [stage].[LoanOrigination] (
    [CreditScore]                 SMALLINT     NULL,
    [FirstPaymentMonth]           INT          NULL,
    [FirstTimeHomeBuyerFlag]      VARCHAR (1)  NULL,
    [MaturityMonth]               INT          NULL,
    [MSACode]                     INT          NULL,
    [MortgageInsurancePercentage] VARCHAR (3)  NULL,
    [Units]                       SMALLINT     NULL,
    [OccupancyStatus]             VARCHAR (1)  NULL,
    [OriginalCLTV]                SMALLINT     NULL,
    [OriginalDTIRatio]            SMALLINT     NULL,
    [OriginalUPB]                 INT          NULL,
    [OriginalLTV]                 SMALLINT     NULL,
    [InterestRate]                REAL         NULL,
    [Channel]                     VARCHAR (1)  NULL,
    [PPMFlag]                     VARCHAR (1)  NULL,
    [ProductType]                 VARCHAR (3)  NULL,
    [PropertyState]               VARCHAR (2)  NULL,
    [PropertyType]                VARCHAR (2)  NULL,
    [PostalCode]                  VARCHAR (5)  NULL,
    [LoanSequenceNumber]          VARCHAR (12) NULL,
    [LoanPurpose]                 VARCHAR (1)  NULL,
    [OriginalLoanTerm]            SMALLINT     NULL,
    [NumberOfBorrowers]           SMALLINT     NULL,
    [SellerName]                  VARCHAR (20) NULL,
    [ServicerName]                VARCHAR (20) NULL,
    [SuperConformingFlag]         VARCHAR (1)  NULL,
	[FileName]					  VARCHAR(100) NULL,
);

