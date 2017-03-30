﻿CREATE TABLE [stage].[LoanService] (
    [LoanSequenceNumber]        VARCHAR (12) NULL,
    [ReportingMonth]            INT          NULL,
    [ActualUPB]                 REAL         NULL,
    [DelinquencyStatus]         VARCHAR (3)  NULL,
    [LoanAge]                   SMALLINT     NULL,
    [MonthsToMaturity]          SMALLINT     NULL,
    [RepurchaseFlag]            VARCHAR (1)  NULL,
    [ModificationFlag]          VARCHAR (1)  NULL,
    [ZeroBalanceCode]           VARCHAR (2)  NULL,
    [ZeroBalanceEffectiveMonth] INT          NULL,
    [InterestRate]              REAL         NULL,
    [DeferredUPB]               MONEY        NULL,
    [DDLPI]                     INT          NULL,
    [MIRecoveries]              MONEY        NULL,
    [NetSalesProceeds]          MONEY        NULL,
    [NonMIRecoveries]           MONEY        NULL,
    [Expenses]                  MONEY        NULL,
    [LegalCosts]                MONEY        NULL,
    [MaintenanceCosts]          MONEY        NULL,
    [TaxesInsurance]            MONEY        NULL,
    [MiscExpenses]              MONEY        NULL,
    [ModificationCost]          MONEY        NULL
);

