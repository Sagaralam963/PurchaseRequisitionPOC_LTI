const cds = require('@sap/cds');
const { PDFParse } = require('pdf-parse');

module.exports = async (srv) => {
  // Using CDS API
  const { PurchaseRequisitionHeaders, PurchaseRequisitionItems, A_PurchaseRequisitionHeader, A_PurchaseRequisitionItem } = srv.entities;
  const ZAPI_PURCHASEREQ_PROCESS_SRV = await cds.connect.to("ZAPI_PURCHASEREQ_PROCESS_SRV");

  const GenAI = await cds.connect.to('Gen_AI');

  srv.on('READ', 'A_PurchaseRequisitionHeader', req => ZAPI_PURCHASEREQ_PROCESS_SRV.run(req.query));

  srv.on('READ', 'A_PurchaseRequisitionItem', req => ZAPI_PURCHASEREQ_PROCESS_SRV.run(req.query));


  srv.on('CreatePurchaseReq', async (req) => {
    try {

      const { payload } = req.data || {};

      console.log("oPayload : ", payload);

      let opayload2 = JSON.parse(payload);
      // return payload;
      console.log("oPayload2 : ", opayload2);
      const resp = await ZAPI_PURCHASEREQ_PROCESS_SRV.send({
        method: 'POST',
        path: 'A_PurchaseRequisitionHeader',
        data: JSON.stringify(opayload2),
        headers: {
          'Content-Type': 'application/json'
        }
      });

      console.log("CreatePurchaseReq resp : ", resp);

      let oPayload3 = {
        "PurchaseRequisition": resp.PurchaseRequisition,
        "PurReqnDescription": resp.PurReqnDescription,
        "SourceDetermination": false,
        "PurReqnDoOnlyValidation": false,
        "to_PurchaseReqnItem": []
      }

      let items = resp.to_PurchaseReqnItem;
      for (let i = 0; i < items.length; i++) {
        oPayload3.to_PurchaseReqnItem.push({
          "PurchaseRequisitionItem": items[i].PurchaseRequisitionItem,
          "PurReqnReleaseStatus": items[i].PurReqnReleaseStatus,
          "PurchaseRequisitionType": items[i].PurchaseRequisitionType,
          "PurchaseRequisitionItemText": items[i].PurchaseRequisitionItemText,
          "AccountAssignmentCategory": items[i].AccountAssignmentCategory,
          "Material": items[i].Material,
          "MaterialGroup": items[i].MaterialGroup,
          "PurchasingDocumentCategory": items[i].PurchasingDocumentCategory,
          "RequestedQuantity": items[i].RequestedQuantity,
          "BaseUnit": items[i].BaseUnit,
          "PurchaseRequisitionPrice": items[i].PurchaseRequisitionPrice,
          "PurReqnPriceQuantity": items[i].PurReqnPriceQuantity,
          "MaterialGoodsReceiptDuration": items[i].MaterialGoodsReceiptDuration,
          "ReleaseCode": items[i].ReleaseCode,
          "PurchasingGroup": items[i].PurchasingGroup,
          "Plant": items[i].Plant,
          "DeliveryDate": items[i].DeliveryDate,
          "CreationDate": items[i].CreationDate,
          "ProcessingStatus": items[i].ProcessingStatus,
          "CreatedByUser": items[i].CreatedByUser,
          "PurReqCreationDate": items[i].PurReqCreationDate,
          "PurReqnItemCurrency": items[i].PurReqnItemCurrency,
          "MaterialPlannedDeliveryDurn": items[i].MaterialPlannedDeliveryDurn,
          "DelivDateCategory": items[i].DelivDateCategory,
          "ConsumptionPosting": items[i].ConsumptionPosting,
          "PurReqnOrigin": items[i].PurReqnOrigin,
          "Language": items[i].Language,
          "IsClosed": false,
          "ReleaseIsNotCompleted": true,
          "ProductType": items[i].ProductType,
          "GoodsReceiptIsExpected": true,
          "InvoiceIsExpected": true,
          "GoodsReceiptIsNonValuated": false,
          "MRPController": items[i].MRPController,
          "PurchaseRequisitionIsFixed": false,
          "Reservation": "0",
          "ExpectedOverallLimitAmount": 0.00,
          "OverallLimitAmount": 0.00,
          "PurReqnSSPCrossCatalogItem": 0
        })
      }

      const tx = cds.transaction(req);
      await tx.run(
        INSERT.into(PurchaseRequisitionHeaders).entries(oPayload3)
      );

      // Return created resource (optional: read back with expand)
      const created = await tx.run(
        SELECT.one.from(PurchaseRequisitionHeaders)
          .where({ PurchaseRequisition: resp.PurchaseRequisition })
          .columns('*', { to_PurchaseReqnItem: ['*'] })
      );




      return resp;


    } catch (error) {
      console.error("Error fetching invoices:", error);
      return req.error(500, "Failed to create Purchase Requisition. : " + error);
    }
  });


  srv.on('getPurchReqDetail', async (req) => {
    const { PurchaseRequisition, Desc } = req.data || {};

    if (!PurchaseRequisition) return req.error(400, 'PurchaseRequisition is required');

    // Most S/4 APIs use Edm.String for IDs; adjust if yours is numeric.
    const prVal = String(PurchaseRequisition);
    const descVal = typeof Desc === 'string' ? Desc.trim() : '';

    // Build base WHERE: PurchaseRequisition = <prVal>
    const where = [
      { ref: ['PurchaseRequisition'] }, '=', { val: prVal }
    ];

    // Optional Description filter (AND contains(PurchaseRequisitionItemText, Desc))
    if (descVal) {
      where.push('and');
      where.push({
        func: 'contains',
        args: [
          { ref: ['PurchaseRequisitionItemText'] },
          { val: descVal }
        ]
      });
    }

    // Explicit CQN to avoid key-read
    const q = {
      SELECT: {
        from: { ref: ['A_PurchaseRequisitionItem'] },
        columns: ['*'],
        where
      }
    };

    const rows = await ZAPI_PURCHASEREQ_PROCESS_SRV.run(q);
    return Array.isArray(rows) ? rows : (rows ? [rows] : []);
  });




  srv.on('ExtractPdfText', async (req) => {
    try {
      var tx = cds.transaction(req);

      const { base64pdf, fileType } = req.data || {};
      if (!base64pdf || typeof base64pdf !== 'string') {
        return req.error(400, 'Please pass a valid Base64 string in base64pdf.');
      }

      const cleanBase64 = stripDataUrl(base64pdf);
      const buf = Buffer.from(cleanBase64, 'base64');
      if (!buf.length) return req.error(400, 'Invalid Base64: empty after decode.');

      if (fileType === 'application/pdf') {



        const parser = new PDFParse({ data: new Uint8Array(buf) });
        const result = await parser.getText();
        console.log("PDF parse result : ", result.pages[0].text);

        let extract_text = result.pages[0].text;

        const payload = {
          "messages": [
            {
              "role": "user",
              "content": extract_text + "\n\nstart with '{' and end with '}' and give us structured json key value format data form above text for following fields InvoiceNumber : String, Vendor : String, Total_Amount : Decimal(15,2), InvoiceDate : Date,  items : array, in items filds are ItemNumber : String, Description : String, Quantity : Integer and Price : Decimal(15,2) remove unwanted text that lead to invalide json structure."
            }
          ],
          "max_tokens": 500,
          "temperature": 0.0,
          "frequency_penalty": 0,
          "presence_penalty": 0,
          "stop": "null"
        }
        const mHeader = {
          "Content-Type": "application/json",
          "AI-Resource-Group": "default"
        }
        const url = '/v2/inference/deployments/d72e19aea6b2b634/chat/completions?api-version=2023-05-15';
        const response = await GenAI.send('POST', url, payload, mHeader);
        console.log("GenAi Response : ", response.choices[0].message.content);
        return response.choices[0].message.content
      }   // If End


    } catch (err) {
      console.error('extractPdfRuntime error:', err);
      return req.error(500, 'Failed to extract PDF text: ' + (err.message || err));
    }
  });


  function stripDataUrl(s) {
    const m = /^data:.*;base64,(.*)$/i.exec(s);
    return m ? m[1] : s;
  }


  srv.on('READ', 'PurchaseRequisitionHeaders', async (req) => {


    try {

      console.log("PurchaseRequisitionHeaders data : ", req.data);

    } catch (error) {

      return req.error(500, "Failed to get PurchaseRequisitionHeaders. : " + error);
    }
  });


  // READ handler for external projection — also syncs to local
  srv.after('READ', 'A_PurchaseRequisitionHeader', async (req) => {



    // Build the external query by forwarding incoming $filter/$select/$top etc.
    let extQuery
    if (req.query?.SELECT) {
      // Re-use the caller's query, only retarget the FROM to the external entity
      extQuery = { ...req.query, SELECT: { ...req.query.SELECT, from: { ref: ['A_PurchaseRequisitionHeader'] } } }
    } else {
      // Fallback: get all
      extQuery = cds.ql.SELECT.from('A_PurchaseRequisitionHeader')
    }

    // 1) Read from external service
    const extRows = await ZAPI_PURCHASEREQ_PROCESS_SRV.run(extQuery)
    if (!extRows || extRows.length === 0) {

      console.log("extRows 1 : ", extRows)
      return extRows

    }

    const toLocal = (h) => ({
      PurchaseRequisition: h.PurchaseRequisition,
      PurReqnDescription: h.PurReqnDescription ?? h.PurchaseRequisitionDescription ?? null,
      SourceDetermination: h.SourceDetermination ?? false,
      PurReqnDoOnlyValidation: h.PurReqnDoOnlyValidation ?? false
    })

    const localRows = extRows.map(toLocal)

    // 3) Upsert into local DB (no duplicates — key PurchaseRequisition drives uniqueness)
    const tx = cds.tx(req)
    const CHUNK_SIZE = 1000 // Safe chunk size for large loads
    for (let i = 0; i < localRows.length; i += CHUNK_SIZE) {
      const chunk = localRows.slice(i, i + CHUNK_SIZE)
      await tx.run(cds.ql.UPSERT.into(PurchaseRequisitionHeaders).entries(chunk))
    }

    // 4) Return the external payload (or switch to local read if you prefer)

    console.log("extRows 2 : ", extRows);
    return extRows
  })




}