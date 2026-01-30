const cds = require('@sap/cds');

module.exports = async (srv) => 
{        
    // Using CDS API      
    const ZAPI_PURCHASEREQ_PROCESS_SRV = await cds.connect.to("ZAPI_PURCHASEREQ_PROCESS_SRV"); 
      srv.on('READ', 'A_PurchaseRequisitionItem', req => ZAPI_PURCHASEREQ_PROCESS_SRV.run(req.query)); 
}