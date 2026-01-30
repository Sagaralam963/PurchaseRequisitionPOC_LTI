/* checksum : e4b3b3377dc5f358403d1470fa2c8b1c */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx pdf'
service ZAPI_PURCHASEREQ_PROCESS_SRV {
  @cds.external : true
  @cds.persistence.skip : true
  @sap.content.version : '1'
  @sap.label : 'Item Notes'
  entity A_PurchaseReqnItemText {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchase Requisition'
    @sap.quickinfo : 'Purchase Requisition Number'
    key PurchaseRequisition : String(10) not null;
    @sap.display.format : 'NonNegative'
    @sap.label : 'Item of requisition'
    @sap.quickinfo : 'Item number of purchase requisition'
    key PurchaseRequisitionItem : String(5) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Text ID'
    key DocumentText : String(4) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Text object'
    @sap.quickinfo : 'Texts: application object'
    key TechnicalObjectType : String(10) not null;
    @sap.label : 'Language Key'
    key Language : String(2) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Text Name'
    @sap.quickinfo : 'Name'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    ArchObjectNumber : String(70);
    @sap.label : 'Long Text'
    NoteDescription : String;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Fixing'
    @sap.quickinfo : '&quot;Fixed&quot; Indicator for Texts'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    FixedIndicator : String(1);
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'Purchase Requisition'
  entity A_PurchaseRequisitionHeader {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchase Requisition'
    @sap.quickinfo : 'Purchase Requisition Number'
    key PurchaseRequisition : String(10) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Document Type'
    @sap.quickinfo : 'Purchase Requisition Document Type'
    PurchaseRequisitionType : String(4);
    @sap.label : 'PurReqn Description'
    @sap.quickinfo : 'Purchase Requisition Description'
    PurReqnDescription : String(40);
    @sap.label : 'Checkbox'
    @sap.heading : ''
    SourceDetermination : Boolean;
    @sap.label : 'Boolean Variable (X = True, - = False, Space = Unknown)'
    @sap.heading : ''
    PurReqnDoOnlyValidation : Boolean;
    to_PurchaseReqnItem : Composition of many A_PurchaseRequisitionItem {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'Item'
  entity A_PurchaseRequisitionItem {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchase Requisition'
    @sap.quickinfo : 'Purchase Requisition Number'
    key PurchaseRequisition : String(10) not null;
    @sap.display.format : 'NonNegative'
    @sap.label : 'Requisn. item'
    @sap.quickinfo : 'Item number of purchase requisition'
    key PurchaseRequisitionItem : String(5) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchase order'
    @sap.quickinfo : 'Purchase order number'
    PurchasingDocument : String(10);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Purchase Order Item'
    @sap.quickinfo : 'Purchase order item number'
    PurchasingDocumentItem : String(5);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Proc.state'
    @sap.quickinfo : 'Requisition Processing State'
    PurReqnReleaseStatus : String(2);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Document Type'
    @sap.quickinfo : 'Purchase Requisition Document Type'
    PurchaseRequisitionType : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Control indicator'
    @sap.quickinfo : 'Control indicator for purchasing document type'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    PurchasingDocumentSubtype : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Item Category'
    @sap.quickinfo : 'Item category in purchasing document'
    PurchasingDocumentItemCategory : String(1);
    @sap.label : 'Short Text'
    PurchaseRequisitionItemText : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Acct Assignment Cat.'
    @sap.quickinfo : 'Account Assignment Category'
    AccountAssignmentCategory : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Material'
    @sap.quickinfo : 'Material Number'
    Material : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Material Group'
    MaterialGroup : String(9);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purch. Doc. Category'
    @sap.quickinfo : 'Purchasing Document Category'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    PurchasingDocumentCategory : String(1);
    @sap.unit : 'BaseUnit'
    @sap.label : 'Quantity requested'
    @sap.quickinfo : 'Purchase requisition quantity'
    RequestedQuantity : Decimal(13, 3);
    @sap.label : 'Unit of Measure'
    @sap.quickinfo : 'Purchase requisition unit of measure'
    @sap.semantics : 'unit-of-measure'
    BaseUnit : String(3);
    @sap.unit : 'PurReqnItemCurrency'
    @sap.label : 'Valuation Price'
    @sap.quickinfo : 'Price in Purchase Requisition'
    PurchaseRequisitionPrice : Decimal(12, 3);
    @sap.unit : 'BaseUnit'
    @sap.label : 'Price Unit'
    PurReqnPriceQuantity : Decimal(5, 0);
    @sap.label : 'GR processing time'
    @sap.quickinfo : 'Goods receipt processing time in days'
    MaterialGoodsReceiptDuration : Decimal(3, 0);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Release indicator'
    @sap.quickinfo : 'Release Indicator'
    ReleaseCode : String(1);
    @sap.display.format : 'Date'
    @sap.label : 'Release Date'
    @sap.quickinfo : 'Purchase Requisition Release Date'
    PurchaseRequisitionReleaseDate : Date;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purch. Organization'
    @sap.quickinfo : 'Purchasing Organization'
    PurchasingOrganization : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchasing Group'
    PurchasingGroup : String(3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Plant'
    Plant : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Company Code'
    @sap.quickinfo : 'Company Code of External System'
    CompanyCode : String(4);
    @sap.label : 'Assigned'
    @sap.quickinfo : 'Assigned Source of Supply'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    SourceOfSupplyIsAssigned : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Supplying Plant'
    @sap.quickinfo : 'Supplying (issuing) plant in case of stock transport order'
    SupplyingPlant : String(4);
    @sap.unit : 'BaseUnit'
    @sap.label : 'Quantity ordered'
    @sap.quickinfo : 'Quantity ordered against this purchase requisition'
    OrderedQuantity : Decimal(13, 3);
    @sap.display.format : 'Date'
    @sap.label : 'Delivery Date'
    @sap.quickinfo : 'Item Delivery Date'
    DeliveryDate : Date;
    @sap.display.format : 'Date'
    @sap.label : 'Requisition date'
    @sap.quickinfo : 'Requisition (request) date'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    CreationDate : Date;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Processing status'
    @sap.quickinfo : 'Processing status of purchase requisition'
    ProcessingStatus : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Ext Prcsng. Status'
    @sap.quickinfo : 'External Processing Status'
    ExternalApprovalStatus : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchasing Info Rec.'
    @sap.quickinfo : 'Purchasing Info Record Number'
    PurchasingInfoRecord : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Desired Vendor'
    Supplier : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Deletion Indicator'
    @sap.quickinfo : 'Deletion Indicator in Purchasing Document'
    IsDeleted : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Fixed Vendor'
    FixedSupplier : String(10);
    @sap.label : 'Requisitioner'
    @sap.quickinfo : 'Name of requisitioner/requester'
    RequisitionerName : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Created By'
    @sap.quickinfo : 'Name of Person Responsible for Creating the Object'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    CreatedByUser : String(12);
    @sap.display.format : 'Date'
    @sap.label : 'Requisition date'
    @sap.quickinfo : 'Requisition (request) date'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    PurReqCreationDate : Date;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    DeliveryAddressID : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address'
    @sap.quickinfo : 'Manual address number in purchasing document item'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    ManualDeliveryAddressID : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Currency'
    @sap.quickinfo : 'Currency Key'
    @sap.semantics : 'currency-code'
    PurReqnItemCurrency : String(5);
    @sap.label : 'Planned Deliv. Time'
    @sap.quickinfo : 'Planned Delivery Time in Days'
    MaterialPlannedDeliveryDurn : Decimal(3, 0);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Deliv. date category'
    @sap.quickinfo : 'Category of delivery date'
    DelivDateCategory : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Distrib. Indicator'
    @sap.quickinfo : 'Distribution Indicator for Multiple Account Assignment'
    MultipleAcctAssgmtDistribution : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Storage Location'
    StorageLocation : String(4);
    @sap.label : 'Requestor'
    PurReqnSSPRequestor : String(60);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Author'
    @sap.quickinfo : 'Author of Requisition'
    PurReqnSSPAuthor : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Outline agreement'
    @sap.quickinfo : 'Number of principal purchase agreement'
    PurchaseContract : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purch. Doc. Category'
    @sap.quickinfo : 'Purchasing Document Category'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    PurReqnSourceOfSupplyType : String(1);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Agreement Item'
    @sap.quickinfo : 'Item Number of Principal Purchase Agreement'
    PurchaseContractItem : String(5);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Consumption'
    @sap.quickinfo : 'Consumption posting'
    ConsumptionPosting : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Creation indicator'
    @sap.quickinfo : 'Creation indicator (purchase requisition/schedule lines)'
    PurReqnOrigin : String(1);
    @sap.label : 'Web Service ID'
    @sap.quickinfo : 'Technical Key of a Web Service (for Example - a Catalog)'
    PurReqnSSPCatalog : String(20);
    @sap.label : 'Catalog Item'
    @sap.quickinfo : 'Catalog Item Id'
    PurReqnSSPCatalogItem : String(40);
    @sap.label : 'Catalog Item Key'
    PurReqnSSPCrossCatalogItem : Integer;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Blocking Indicator'
    @sap.quickinfo : 'Purchase Requisition Blocked'
    IsPurReqnBlocked : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address'
    @sap.quickinfo : 'Number of delivery address'
    ItemDeliveryAddressID : String(10);
    @sap.label : 'Language Key'
    Language : String(2);
    @sap.label : 'Closed'
    @sap.quickinfo : 'Purchase requisition closed'
    IsClosed : Boolean;
    @sap.label : 'Subject to Release'
    @sap.quickinfo : 'Release Not Yet Completely Effected'
    ReleaseIsNotCompleted : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Service Performer'
    ServicePerformer : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Product Type Group'
    ProductType : String(2);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Release State'
    PurchaseRequisitionStatus : String(8);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Release strategy'
    @sap.quickinfo : 'Release strategy in the purchase requisition'
    ReleaseStrategy : String(2);
    @sap.display.format : 'Date'
    @sap.label : 'Start Date'
    @sap.quickinfo : 'Start Date for Period of Performance'
    PerformancePeriodStartDate : Date;
    @sap.display.format : 'Date'
    @sap.label : 'End Date'
    @sap.quickinfo : 'End Date for Period of Performance'
    PerformancePeriodEndDate : Date;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchase order price'
    @sap.quickinfo : 'Use Requisition Price in Purchase Order'
    PurchaseOrderPriceType : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Supplier Mat. No.'
    @sap.quickinfo : 'Material Number Used by Supplier'
    SupplierMaterialNumber : String(35);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Batch'
    @sap.quickinfo : 'Batch Number'
    Batch : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Revision Level'
    MaterialRevisionLevel : String(2);
    @sap.label : 'Min. Rem. Shelf Life'
    @sap.quickinfo : 'Minimum Remaining Shelf Life'
    MinRemainingShelfLife : Decimal(4, 0);
    @sap.unit : 'PurReqnItemCurrency'
    ItemNetAmount : Decimal(16, 3);
    @sap.label : 'Goods Receipt'
    @sap.quickinfo : 'Goods Receipt Indicator'
    GoodsReceiptIsExpected : Boolean;
    @sap.label : 'Invoice Receipt'
    @sap.quickinfo : 'Invoice Receipt Indicator'
    InvoiceIsExpected : Boolean;
    @sap.label : 'GR Non-Valuated'
    @sap.quickinfo : 'Goods Receipt, Non-Valuated'
    GoodsReceiptIsNonValuated : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Req. Tracking Number'
    @sap.quickinfo : 'Requirement Tracking Number'
    RequirementTracking : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'MRP Controller'
    MRPController : String(3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Tax Code'
    @sap.quickinfo : 'Tax on sales/purchases code'
    TaxCode : String(2);
    @sap.label : '&quot;Fixed&quot; indicator'
    @sap.quickinfo : 'Purchase requisition is fixed'
    PurchaseRequisitionIsFixed : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address'
    @sap.quickinfo : 'Manual address number in purchasing document item'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    AddressID : String(10);
    @odata.Type : 'Edm.DateTimeOffset'
    @odata.Precision : 7
    @sap.label : 'Time Stamp'
    @sap.quickinfo : 'UTC Time Stamp in Long Form (YYYYMMDDhhmmssmmmuuun)'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    LastChangeDateTime : Timestamp;
    @sap.display.format : 'NonNegative'
    @sap.label : 'Reservation'
    @sap.quickinfo : 'Number of reservation/dependent requirements'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    Reservation : String(10);
    @sap.unit : 'PurReqnItemCurrency'
    @sap.label : 'Expected Value'
    @sap.quickinfo : 'Expected Value of Overall Limit'
    ExpectedOverallLimitAmount : Decimal(14, 3);
    @sap.unit : 'PurReqnItemCurrency'
    @sap.label : 'Overall Limit'
    OverallLimitAmount : Decimal(14, 3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Contract For Limit'
    @sap.quickinfo : 'Purchase Contract for Enhanced Limit'
    PurContractForOverallLimit : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'External Document'
    @sap.quickinfo : 'Document Number of External Document'
    PurReqnExternalReference : String(35);
    @sap.display.format : 'UpperCase'
    @sap.label : 'External Item'
    @sap.quickinfo : 'Item Number of External Document'
    PurReqnItemExternalReference : String(10);
    @sap.label : 'External System ID'
    PurReqnExternalSystemId : String(60);
    @sap.display.format : 'UpperCase'
    @sap.label : 'External System Type'
    @sap.quickinfo : 'Type of External System'
    PurReqnExternalSystemType : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Ext. Document Type'
    @sap.quickinfo : 'External Document Type'
    PurReqnTypeExternalReference : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Processing State'
    PurReqnProcessingType : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Timestamp'
    @sap.heading : ''
    PurReqnProcessingDateTime : String(14);
    @sap.label : 'Connected System'
    ProcmtHubBackendBusSyst : String(60);
    @sap.display.format : 'UpperCase'
    @sap.label : 'BP ID of Author'
    SSPAuthorExternalBPIdnNumber : String(60);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Requestor UserID'
    @sap.quickinfo : 'Requestor User ID'
    SSPReqrUserId : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Stock Segment'
    StockSegment : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Requirement Segment'
    RequirementSegment : String(40);
    to_PurchaseReqn : Association to A_PurchaseRequisitionHeader {  };
    to_PurchaseReqnAcctAssgmt : Composition of many A_PurReqnAcctAssgmt {  };
    to_PurchaseReqnDeliveryAddress : Composition of A_PurReqAddDelivery {  };
    to_PurchaseReqnItemText : Composition of many A_PurchaseReqnItemText {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'Delivery Address'
  entity A_PurReqAddDelivery {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchase Requisition'
    @sap.quickinfo : 'Purchase Requisition Number'
    key PurchaseRequisition : String(10) not null;
    @sap.display.format : 'NonNegative'
    @sap.label : 'Requisn. item'
    @sap.quickinfo : 'Item number of purchase requisition'
    key PurchaseRequisitionItem : String(5) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    AddressID : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Plant'
    Plant : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address Type'
    @sap.quickinfo : 'Purchase Requisition Address Type'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    AddressType : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address'
    @sap.quickinfo : 'Manual address number in purchasing document item'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    ManualDeliveryAddressID : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address'
    @sap.quickinfo : 'Number of delivery address'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    ItemDeliveryAddressID : String(10);
    @sap.label : 'c/o'
    @sap.quickinfo : 'c/o name'
    CareOfName : String(40);
    @sap.label : 'Street 5'
    AdditionalStreetSuffixName : String(40);
    @sap.label : 'Language Key'
    CorrespondenceLanguage : String(2);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Comm. Method'
    @sap.quickinfo : 'Communication Method (Key) (Business Address Services)'
    PrfrdCommMediumType : String(3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'PO Box'
    POBox : String(10);
    @sap.label : 'PO Box w/o No.'
    @sap.quickinfo : 'Flag: PO Box Without Number'
    POBoxIsWithoutNumber : Boolean;
    @sap.display.format : 'UpperCase'
    @sap.label : 'PO Box Postal Code'
    POBoxPostalCode : String(10);
    @sap.label : 'PO Box Lobby'
    POBoxLobbyName : String(40);
    @sap.label : 'PO Box City'
    @sap.quickinfo : 'PO Box city'
    POBoxDeviatingCityName : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'PO Box Region'
    @sap.quickinfo : 'Region for PO Box (Country/Region, State, Province, ...)'
    POBoxDeviatingRegion : String(3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'PO Box Ctry/Region'
    @sap.quickinfo : 'PO Box of Country/Region'
    POBoxDeviatingCountry : String(3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Delvry Serv Type'
    @sap.quickinfo : 'Type of Delivery Service'
    DeliveryServiceTypeCode : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Delivery Service No.'
    @sap.quickinfo : 'Number of Delivery Service'
    DeliveryServiceNumber : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Time Zone'
    @sap.quickinfo : 'Address Time Zone'
    AddressTimeZone : String(6);
    @sap.label : 'Full Name'
    @sap.quickinfo : 'Full name of a party (Bus. Partner, Org. Unit, Doc. address)'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    FullName : String(80);
    @sap.label : 'City'
    CityName : String(40);
    @sap.label : 'District'
    District : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'City Code'
    @sap.quickinfo : 'City code for city/street file'
    CityCode : String(12);
    @sap.label : 'Different City'
    @sap.quickinfo : 'City (different from postal city)'
    HomeCityName : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Postal Code'
    @sap.quickinfo : 'City postal code'
    PostalCode : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Company Postal Code'
    @sap.quickinfo : 'Company Postal Code (for Large Customers)'
    CompanyPostalCode : String(10);
    @sap.label : 'Street'
    StreetName : String(60);
    @sap.label : 'Street 2'
    StreetPrefixName : String(40);
    @sap.label : 'Street 3'
    AdditionalStreetPrefixName : String(40);
    @sap.label : 'Street 4'
    StreetSuffixName : String(40);
    @sap.label : 'House Number'
    HouseNumber : String(10);
    @sap.label : 'Supplement'
    @sap.quickinfo : 'House number supplement'
    HouseNumberSupplementText : String(10);
    @sap.label : 'Building Code'
    @sap.quickinfo : 'Building (Number or Code)'
    Building : String(20);
    @sap.label : 'Floor'
    @sap.quickinfo : 'Floor in building'
    Floor : String(10);
    @sap.label : 'Room Number'
    @sap.quickinfo : 'Room or Apartment Number'
    RoomNumber : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Country/Region Key'
    Country : String(3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Region'
    @sap.quickinfo : 'Region (State, Province, County)'
    Region : String(3);
    @sap.label : 'County'
    County : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Title Key'
    @sap.quickinfo : 'Form-of-Address Key'
    FormOfAddress : String(4);
    @sap.label : 'Name'
    @sap.quickinfo : 'Name 1'
    BusinessPartnerName1 : String(40);
    @sap.label : 'Name 2'
    BusinessPartnerName2 : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Address Version'
    @sap.quickinfo : 'Version ID for International Addresses'
    Nation : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Telephone'
    @sap.quickinfo : 'First Telephone No.: Dialing Code + Number'
    PhoneNumber : String(30);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Fax'
    @sap.quickinfo : 'First Fax No.: Area Code + Number'
    FaxNumber : String(30);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Search Term 1'
    SearchTerm1 : String(20);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Street'
    @sap.quickinfo : 'Street Name in Uppercase for Search Help'
    StreetSearch : String(25);
    @sap.display.format : 'UpperCase'
    @sap.label : 'City'
    @sap.quickinfo : 'City name in Uppercase for Search Help'
    CitySearch : String(25);
    @sap.label : 'Name 3'
    BusinessPartnerName3 : String(40);
    @sap.label : 'Name 4'
    BusinessPartnerName4 : String(40);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Tax Jurisdiction'
    TaxJurisdiction : String(15);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Transportation Zone'
    @sap.quickinfo : 'Transportation zone to or from which the goods are delivered'
    TransportZone : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Person Number'
    Person : String(10);
    @sap.label : 'Full Name'
    @sap.quickinfo : 'Full Name of Person'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    AddresseeFullName : String(80);
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.deletable : 'false'
  @sap.content.version : '1'
  @sap.label : 'Account Assignment'
  entity A_PurReqnAcctAssgmt {
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchase Requisition'
    @sap.quickinfo : 'Purchase Requisition Number'
    key PurchaseRequisition : String(10) not null;
    @sap.display.format : 'NonNegative'
    @sap.label : 'Item of requisition'
    @sap.quickinfo : 'Item number of purchase requisition'
    key PurchaseRequisitionItem : String(5) not null;
    @sap.display.format : 'NonNegative'
    @sap.label : 'Serial no.acct.assgt'
    @sap.quickinfo : 'Serial number for PReq account assignment segment'
    key PurchaseReqnAcctAssgmtNumber : String(2) not null;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Cost Center'
    CostCenter : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Asset'
    @sap.quickinfo : 'Main Asset Number'
    MasterFixedAsset : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Network'
    @sap.quickinfo : 'Network Number for Account Assignment'
    ProjectNetwork : String(12);
    @sap.label : 'Unit of Measure'
    @sap.quickinfo : 'Purchase requisition unit of measure'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.semantics : 'unit-of-measure'
    BaseUnit : String(3);
    @sap.unit : 'BaseUnit'
    @sap.label : 'Quantity requested'
    @sap.quickinfo : 'Purchase requisition quantity'
    Quantity : Decimal(13, 3);
    @sap.label : 'Distribution (%)'
    @sap.quickinfo : 'Distribution percentage in the case of multiple acct assgt'
    MultipleAcctAssgmtDistrPercent : Decimal(3, 1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Currency'
    @sap.quickinfo : 'Currency Key'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.semantics : 'currency-code'
    PurReqnItemCurrency : String(5);
    @sap.unit : 'PurReqnItemCurrency'
    @sap.label : 'Net Order Value'
    @sap.quickinfo : 'Net Order Value in PO Currency'
    PurReqnNetAmount : Decimal(14, 3);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Deletion Indicator'
    @sap.quickinfo : 'Deletion Indicator in Purchasing Document'
    IsDeleted : String(1);
    @sap.display.format : 'UpperCase'
    @sap.label : 'G/L Account'
    @sap.quickinfo : 'G/L Account Number'
    CostElement : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'G/L Account'
    @sap.quickinfo : 'G/L Account Number'
    GLAccount : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Business Area'
    BusinessArea : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'SD Document'
    @sap.quickinfo : 'Sales and Distribution Document Number'
    SDDocument : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'SD Document'
    @sap.quickinfo : 'Sales and Distribution Document Number'
    SalesOrder : String(10);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Sales Document Item'
    SalesDocumentItem : String(6);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Sales Document Item'
    SalesOrderItem : String(6);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Schedule Line Number'
    ScheduleLine : String(4);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Schedule Line Number'
    SalesOrderScheduleLine : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Sub-number'
    @sap.quickinfo : 'Asset Subnumber'
    FixedAsset : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Order'
    @sap.quickinfo : 'Order Number'
    ProcessOrder : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Order'
    @sap.quickinfo : 'Order Number'
    OrderID : String(12);
    @sap.label : 'Unloading Point'
    UnloadingPointName : String(25);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Controlling Area'
    ControllingArea : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Cost Object'
    CostObject : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Profitab. Segmt No.'
    @sap.quickinfo : 'Profitability Segment Number (CO-PA)'
    ProfitabilitySegment : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Profit Center'
    ProfitCenter : String(10);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Opertn task list no.'
    @sap.quickinfo : 'Routing number of operations in the order'
    ProjectNetworkInternalID : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Commitment item'
    @sap.quickinfo : 'Commitment Item'
    CommitmentItem : String(24);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Funds Center'
    FundsCenter : String(16);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Fund'
    Fund : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Functional Area'
    FunctionalArea : String(16);
    @sap.display.format : 'Date'
    @sap.label : 'Created On'
    @sap.quickinfo : 'Record Creation Date'
    CreationDate : Date;
    @sap.label : 'Goods Recipient'
    GoodsRecipientName : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Real Estate Key'
    @sap.quickinfo : 'Internal Key for Real Estate Object'
    RealEstateObject : String(40);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Counter'
    @sap.quickinfo : 'Internal counter'
    NetworkActivityInternalID : String(8);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Partner'
    @sap.quickinfo : 'Partner account number'
    PartnerAccountNumber : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Recovery Indicator'
    JointVentureRecoveryCode : String(2);
    @sap.display.format : 'Date'
    @sap.label : 'Reference date'
    @sap.quickinfo : 'Reference date for settlement'
    SettlementReferenceDate : Date;
    @sap.display.format : 'NonNegative'
    @sap.label : 'Opertn task list no.'
    @sap.quickinfo : 'Routing number of operations in the order'
    OrderInternalID : String(10);
    @sap.display.format : 'NonNegative'
    @sap.label : 'Counter'
    @sap.quickinfo : 'General counter for order'
    OrderIntBillOfOperationsItem : String(8);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Earmarked Funds'
    @sap.quickinfo : 'Document Number for Earmarked Funds'
    EarmarkedFundsDocument : String(10);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Activity Type'
    CostCtrActivityType : String(6);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Business Process'
    BusinessProcess : String(12);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Grant'
    GrantID : String(20);
    @sap.display.format : 'Date'
    ValidityDate : Date;
    @sap.display.format : 'UpperCase'
    @sap.label : 'Chart of Accounts'
    ChartOfAccounts : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'WBS Element'
    @sap.quickinfo : 'Work Breakdown Structure Element (WBS Element)'
    WBSElement : String(24);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Oper./Act.'
    @sap.quickinfo : 'Operation/Activity Number'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    NetworkActivity : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Document Type'
    @sap.quickinfo : 'Purchase Requisition Document Type'
    PurchaseRequisitionType : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Plant'
    Plant : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purch. Organization'
    @sap.quickinfo : 'Purchasing Organization'
    PurchasingOrganization : String(4);
    @sap.display.format : 'UpperCase'
    @sap.label : 'Purchasing Group'
    PurchasingGroup : String(3);
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.content.version : '1'
  entity SAP__Currencies {
    @sap.label : 'Currency'
    @sap.semantics : 'currency-code'
    key CurrencyCode : String(5) not null;
    @sap.label : 'ISO code'
    ISOCode : String(3) not null;
    @sap.label : 'Short text'
    Text : String(15) not null;
    @odata.Type : 'Edm.Byte'
    @sap.label : 'Decimals'
    DecimalPlaces : Integer not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.content.version : '1'
  entity SAP__UnitsOfMeasure {
    @sap.label : 'Internal UoM'
    @sap.semantics : 'unit-of-measure'
    key UnitCode : String(3) not null;
    @sap.label : 'ISO Code'
    ISOCode : String(3) not null;
    @sap.label : 'Commercial'
    ExternalCode : String(3) not null;
    @sap.label : 'Meas. Unit Text'
    Text : String(30) not null;
    @sap.label : 'Decimal Places'
    DecimalPlaces : Integer;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.content.version : '1'
  entity SAP__MyDocumentDescriptions {
    @sap.label : 'UUID'
    key Id : UUID not null;
    CreatedBy : String(12) not null;
    @odata.Type : 'Edm.DateTime'
    @sap.label : 'Time Stamp'
    CreatedAt : DateTime not null;
    FileName : String(256) not null;
    Title : String(256) not null;
    Format : Association to SAP__FormatSet {  };
    TableColumns : Association to many SAP__TableColumnsSet {  };
    CoverPage : Association to many SAP__CoverPageSet {  };
    Signature : Association to SAP__SignatureSet {  };
    PDFStandard : Association to SAP__PDFStandardSet {  };
    Hierarchy : Association to SAP__HierarchySet {  };
    Header : Association to SAP__PDFHeaderSet {  };
    Footer : Association to SAP__PDFFooterSet {  };
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.pageable : 'false'
  @sap.addressable : 'false'
  @sap.content.version : '1'
  entity SAP__FormatSet {
    @sap.label : 'UUID'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Id : UUID not null;
    FitToPage : SAP__FitToPage not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    FontSize : Integer not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Orientation : String(10) not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    PaperSize : String(10) not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    BorderSize : Integer not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MarginSize : Integer not null;
    @sap.label : 'Font Name'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    FontName : String(255) not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Padding : Integer not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.pageable : 'false'
  @sap.addressable : 'false'
  @sap.content.version : '1'
  entity SAP__PDFStandardSet {
    @sap.label : 'UUID'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Id : UUID not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    UsePDFAConformance : Boolean not null;
    @sap.label : 'Indicator'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    DoEnableAccessibility : Boolean not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.pageable : 'false'
  @sap.addressable : 'false'
  @sap.content.version : '1'
  entity SAP__TableColumnsSet {
    @sap.label : 'UUID'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Id : UUID not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Name : String(256) not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Header : String(256) not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    HorizontalAlignment : String(10) not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.pageable : 'false'
  @sap.addressable : 'false'
  @sap.content.version : '1'
  entity SAP__CoverPageSet {
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Title : String(256) not null;
    @sap.label : 'UUID'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Id : UUID not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Name : String(256) not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Value : String(256) not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.pageable : 'false'
  @sap.addressable : 'false'
  @sap.content.version : '1'
  entity SAP__SignatureSet {
    @sap.label : 'UUID'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Id : UUID not null;
    @sap.label : 'Indicator'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    DoSign : Boolean not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Reason : String(256) not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.pageable : 'false'
  @sap.addressable : 'false'
  @sap.content.version : '1'
  entity SAP__HierarchySet {
    @sap.label : 'UUID'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Id : UUID not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    DistanceFromRootElement : String(256) not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    DrillStateElement : String(256) not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.pageable : 'false'
  @sap.addressable : 'false'
  @sap.content.version : '1'
  entity SAP__PDFHeaderSet {
    @sap.label : 'UUID'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Id : UUID not null;
    Right : SAP__HeaderFooterField not null;
    Left : SAP__HeaderFooterField not null;
    Center : SAP__HeaderFooterField not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.deletable : 'false'
  @sap.pageable : 'false'
  @sap.addressable : 'false'
  @sap.content.version : '1'
  entity SAP__PDFFooterSet {
    @sap.label : 'UUID'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    key Id : UUID not null;
    Right : SAP__HeaderFooterField not null;
    Left : SAP__HeaderFooterField not null;
    Center : SAP__HeaderFooterField not null;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @sap.content.version : '1'
  entity SAP__ValueHelpSet {
    key VALUEHELP : String not null;
    FIELD_VALUE : String(10) not null;
    DESCRIPTION : String;
  };

  @cds.external : true
  type ValidationMessages {
    @sap.label : 'Message type'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Type : String(1) not null;
    @sap.label : 'Message Class'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Id : String(20) not null;
    @sap.label : 'Message Number'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Number : String(3) not null;
    @sap.label : 'Message Text'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Message : String(220) not null;
    @sap.label : 'Log number'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    LogNo : String(20) not null;
    @sap.label : 'Message no.'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    LogMsgNo : String(6) not null;
    @sap.label : 'Message Variable'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MessageV1 : String(50) not null;
    @sap.label : 'Message Variable'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MessageV2 : String(50) not null;
    @sap.label : 'Message Variable'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MessageV3 : String(50) not null;
    @sap.label : 'Message Variable'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MessageV4 : String(50) not null;
    @sap.label : 'Parameter Name'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Parameter : String(32) not null;
    @sap.label : 'Parameter line'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Row : Integer not null;
    @sap.label : 'Field name'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Field : String(30) not null;
    @sap.label : 'Logical system'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    System : String(10) not null;
  };

  @cds.external : true
  type Messages {
    @sap.label : 'Message type'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Type : String(1) not null;
    @sap.label : 'Message Class'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Id : String(20) not null;
    @sap.label : 'Message Number'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Number : String(3) not null;
    @sap.label : 'Message Text'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Message : String(220) not null;
    @sap.label : 'Log number'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    LogNo : String(20) not null;
    @sap.label : 'Message no.'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    LogMsgNo : String(6) not null;
    @sap.label : 'Message Variable'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MessageV1 : String(50) not null;
    @sap.label : 'Message Variable'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MessageV2 : String(50) not null;
    @sap.label : 'Message Variable'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MessageV3 : String(50) not null;
    @sap.label : 'Message Variable'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MessageV4 : String(50) not null;
    @sap.label : 'Parameter Name'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Parameter : String(32) not null;
    @sap.label : 'Parameter line'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Row : Integer not null;
    @sap.label : 'Field name'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Field : String(30) not null;
    @sap.label : 'Logical system'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    System : String(10) not null;
  };

  @cds.external : true
  type SAP__FitToPage {
    @sap.label : 'Error behavior'
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    ErrorRecoveryBehavior : String(8) not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    IsEnabled : Boolean not null;
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    MinimumFontSize : Integer not null;
  };

  @cds.external : true
  type SAP__HeaderFooterField {
    @sap.creatable : 'false'
    @sap.updatable : 'false'
    @sap.sortable : 'false'
    @sap.filterable : 'false'
    Type : String(256) not null;
  };

  @cds.external : true
  function Validate(
    PurchaseRequisition : String
  ) returns many ValidationMessages;

  @cds.external : true
  action DiscardFromPurchasing(
    PurchaseRequisitionItem : String,
    PurchaseRequisition : String
  ) returns many Messages;

  @cds.external : true
  action EnableForPurchasing(
    PurchaseRequisitionItem : String,
    PurchaseRequisition : String
  ) returns many Messages;
};

