namespace PurchaseRequisitionPOC;


entity PurchaseRequisitionHeader {
  key PurchaseRequisition     : String(10);
      PurReqnDescription      : String(255);
      SourceDetermination     : Boolean;
      PurReqnDoOnlyValidation : Boolean;

      to_PurchaseReqnItem     : Composition of many PurchaseRequisitionItem
                                  on to_PurchaseReqnItem.PurchaseRequisition = $self.PurchaseRequisition;
}


entity PurchaseRequisitionItem {


  key PurchaseRequisition            : String(10);
  key PurchaseRequisitionItemText    : String(40);

      PurchaseRequisitionItem        : String(5);
      PurchasingDocument             : String(10);
      PurchasingDocumentItem         : String(5);
      PurReqnReleaseStatus           : String(2);
      PurchaseRequisitionType        : String(4);
      PurchasingDocumentSubtype      : String(1);
      PurchasingDocumentItemCategory : String(1);

      AccountAssignmentCategory      : String(1);
      Material                       : String(40);
      MaterialGroup                  : String(9);
      PurchasingDocumentCategory     : String(1);

      RequestedQuantity              : Decimal(13, 3);
      BaseUnit                       : String(3);
      PurchaseRequisitionPrice       : Decimal(12, 3);
      PurReqnPriceQuantity           : Decimal(5, 0);
      MaterialGoodsReceiptDuration   : Decimal(3, 0);

      ReleaseCode                    : String(1);
      PurchaseRequisitionReleaseDate : Date;
      PurchasingOrganization         : String(4);
      PurchasingGroup                : String(3);
      Plant                          : String(4);
      CompanyCode                    : String(4);
      SourceOfSupplyIsAssigned       : Boolean;
      SupplyingPlant                 : String(4);
      OrderedQuantity                : Decimal(13, 3);
      DeliveryDate                   : Date;
      CreationDate                   : Date;
      ProcessingStatus               : String(1);
      ExternalApprovalStatus         : String(1);
      PurchasingInfoRecord           : String(10);
      Supplier                       : String(10);
      IsDeleted                      : String(1);
      FixedSupplier                  : String(10);
      RequisitionerName              : String(12);
      CreatedByUser                  : String(12);
      PurReqCreationDate             : Date;
      DeliveryAddressID              : String(10);
      ManualDeliveryAddressID        : String(10);
      PurReqnItemCurrency            : String(5);
      MaterialPlannedDeliveryDurn    : Decimal(3, 0);
      DelivDateCategory              : String(1);
      MultipleAcctAssgmtDistribution : String(1);
      StorageLocation                : String(4);
      PurReqnSSPRequestor            : String(60);
      PurReqnSSPAuthor               : String(12);
      PurchaseContract               : String(10);
      PurReqnSourceOfSupplyType      : String(1);
      PurchaseContractItem           : String(5);
      ConsumptionPosting             : String(1);
      PurReqnOrigin                  : String(1);
      PurReqnSSPCatalog              : String(20);
      PurReqnSSPCatalogItem          : String(40);
      PurReqnSSPCrossCatalogItem     : Integer;
      IsPurReqnBlocked               : String(1);
      ItemDeliveryAddressID          : String(10);
      Language                       : String(2);
      IsClosed                       : Boolean;
      ReleaseIsNotCompleted          : Boolean;
      ServicePerformer               : String(10);
      ProductType                    : String(2);
      PurchaseRequisitionStatus      : String(8);
      ReleaseStrategy                : String(2);
      PerformancePeriodStartDate     : Date;
      PerformancePeriodEndDate       : Date;
      PurchaseOrderPriceType         : String(1);
      SupplierMaterialNumber         : String(35);
      Batch                          : String(10);
      MaterialRevisionLevel          : String(2);
      MinRemainingShelfLife          : Decimal(4, 0);
      ItemNetAmount                  : Decimal(16, 3);
      GoodsReceiptIsExpected         : Boolean;
      InvoiceIsExpected              : Boolean;
      GoodsReceiptIsNonValuated      : Boolean;
      RequirementTracking            : String(10);
      MRPController                  : String(3);
      TaxCode                        : String(2);
      PurchaseRequisitionIsFixed     : Boolean;
      AddressID                      : String(10);
      LastChangeDateTime             : Timestamp;
      Reservation                    : String(10);
      ExpectedOverallLimitAmount     : Decimal(14, 3);
      OverallLimitAmount             : Decimal(14, 3);
      PurContractForOverallLimit     : String(10);
      PurReqnExternalReference       : String(35);
      PurReqnItemExternalReference   : String(10);
      PurReqnExternalSystemId        : String(60);
      PurReqnExternalSystemType      : String(1);
      PurReqnTypeExternalReference   : String(4);
      PurReqnProcessingType          : String(1);
      PurReqnProcessingDateTime      : String(14);
      ProcmtHubBackendBusSyst        : String(60);
      SSPAuthorExternalBPIdnNumber   : String(60);
      SSPReqrUserId                  : String(12);
      StockSegment                   : String(40);
      RequirementSegment             : String(40);
}
