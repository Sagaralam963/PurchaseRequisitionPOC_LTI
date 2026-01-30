sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (BaseController) => {
    "use strict";

    return BaseController.extend("ns.purchasereq.controller.objectPage", {
        onInit() {


            const oRouter = sap.ui.core.UIComponent.getRouterFor(this);
            oRouter.getRoute("objectPage").attachPatternMatched(this._onRouteMatched, this);

        },


        _onRouteMatched: async function (oEvent) {
            const { PR_No } = JSON.parse(oEvent.getParameter("arguments").PRDetail);
             const { Desc } = JSON.parse(oEvent.getParameter("arguments").PRDetail);
            console.log(PR_No,Desc);


            try {

                let href = window.location.href.split('sap')[0];
                let url = href + "sap/odata/v4/catalog/getPurchReqDetail";

                let payload = {
                    "PurchaseRequisition": PR_No,
                    "Desc": Desc
                }

                const response = await fetch(url, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(payload)
                });

                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }

                const oData = await response.json();

                if (oData) {

                    console.log(oData);

                    let oModel = new sap.ui.model.json.JSONModel({
                        PR_Detail : oData.value
                    });
                    this.getOwnerComponent().setModel(oModel, "PR_DetailModel");
                    this.getOwnerComponent().getModel("PR_DetailModel").refresh();
                }

            } catch (error) {

            }
        },



    });
});