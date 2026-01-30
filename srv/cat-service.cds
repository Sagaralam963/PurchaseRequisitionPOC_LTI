using my.bookshop as my from '../db/schema';

using ZAPI_PURCHASEREQ_PROCESS_SRV from './external/ZAPI_PURCHASEREQ_PROCESS_SRV.cds';

using PurchaseRequisitionPOC as POC from '../db/schema2';


service CatalogService {


    entity A_PurchaseRequisitionHeader as
        projection on ZAPI_PURCHASEREQ_PROCESS_SRV.A_PurchaseRequisitionHeader {
            key PurchaseRequisition,
                PurchaseRequisitionType,
                PurReqnDescription,
                SourceDetermination,
                PurReqnDoOnlyValidation
        };


    entity A_PurchaseRequisitionItem   as
        projection on ZAPI_PURCHASEREQ_PROCESS_SRV.A_PurchaseRequisitionItem {
            key PurchaseRequisition,
            key PurchaseRequisitionItem,
                PurchasingDocument,
                PurchasingDocumentItem,
                PurReqnReleaseStatus,
                PurchaseRequisitionType,
                PurchasingDocumentSubtype,
                PurchasingDocumentItemCategory,
                PurchaseRequisitionItemText,
                AccountAssignmentCategory,
                Material,
                MaterialGroup,
                PurchasingDocumentCategory,
                RequestedQuantity,
                BaseUnit,
                PurchaseRequisitionPrice,
                PurReqnPriceQuantity,
                MaterialGoodsReceiptDuration,
                ReleaseCode,
                PurchaseRequisitionReleaseDate,
                PurchasingOrganization,
                PurchasingGroup,
                Plant,
                CompanyCode,
                SourceOfSupplyIsAssigned,
                SupplyingPlant,
                OrderedQuantity,
                DeliveryDate,
                CreationDate,
                ProcessingStatus,
                ExternalApprovalStatus,
                PurchasingInfoRecord,
                Supplier,
                IsDeleted,
                FixedSupplier,
                RequisitionerName,
                CreatedByUser,
                PurReqCreationDate,
                DeliveryAddressID,
                ManualDeliveryAddressID,
                PurReqnItemCurrency,
                MaterialPlannedDeliveryDurn,
                DelivDateCategory,
                MultipleAcctAssgmtDistribution,
                StorageLocation,
                PurReqnSSPRequestor,
                PurReqnSSPAuthor,
                PurchaseContract,
                PurReqnSourceOfSupplyType,
                PurchaseContractItem,
                ConsumptionPosting,
                PurReqnOrigin,
                PurReqnSSPCatalog,
                PurReqnSSPCatalogItem,
                PurReqnSSPCrossCatalogItem,
                IsPurReqnBlocked,
                ItemDeliveryAddressID,
                Language,
                IsClosed,
                ReleaseIsNotCompleted,
                ServicePerformer,
                ProductType,
                PurchaseRequisitionStatus,
                ReleaseStrategy,
                PerformancePeriodStartDate,
                PerformancePeriodEndDate,
                PurchaseOrderPriceType,
                SupplierMaterialNumber,
                Batch,
                MaterialRevisionLevel,
                MinRemainingShelfLife,
                ItemNetAmount,
                GoodsReceiptIsExpected,
                InvoiceIsExpected,
                GoodsReceiptIsNonValuated,
                RequirementTracking,
                MRPController,
                TaxCode,
                PurchaseRequisitionIsFixed,
                AddressID,
                LastChangeDateTime,
                Reservation,
                ExpectedOverallLimitAmount,
                OverallLimitAmount,
                PurContractForOverallLimit,
                PurReqnExternalReference,
                PurReqnItemExternalReference,
                PurReqnExternalSystemId,
                PurReqnExternalSystemType,
                PurReqnTypeExternalReference,
                PurReqnProcessingType,
                PurReqnProcessingDateTime,
                ProcmtHubBackendBusSyst,
                SSPAuthorExternalBPIdnNumber,
                SSPReqrUserId,
                StockSegment,
                RequirementSegment
        };


    action CreatePurchaseReq(payload: String)                           returns String;

    // function getPurchReqDetail(PurchaseRequisition: String) returns String;

    action getPurchReqDetail(PurchaseRequisition: String, Desc: String) returns many A_PurchaseRequisitionItem;


    action ExtractPdfText(fileType: String, base64pdf: LargeString)     returns LargeString;


    entity PurchaseRequisitionHeaders  as projection on POC.PurchaseRequisitionHeader;
    entity PurchaseRequisitionItems    as projection on POC.PurchaseRequisitionItem;

}
