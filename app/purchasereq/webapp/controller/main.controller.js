sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator",
  "sap/ui/model/Sorter",
  "sap/ui/core/format/DateFormat",
  "sap/m/MessageToast",
  "sap/m/MessageBox",
  "sap/ui/core/Fragment",
  "sap/ui/export/Spreadsheet",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator"

], function (Controller, Filter, FilterOperator, Sorter, DateFormat, MessageToast, MessageBox, Fragment, Spreadsheet) {
  "use strict";
  var pageThis;

  return Controller.extend("ns.purchasereq.controller.main", {

    onInit: function () {


      this.getView().addEventDelegate({
        onAfterRendering: () => {
          const oTable = this.byId("prTable");
          const oBinding = oTable.getBinding("rows");
          if (oBinding) {
            oBinding.sort(new Sorter("PurchaseRequisition", /*descending*/ true));
          }

        }
      });

      pageThis = this;

      var oModel = new sap.ui.model.json.JSONModel({
        PRItiem: [],
        PR: []
      });
      this.getOwnerComponent().setModel(oModel, "PRItemModel");

    },


    onSearchLiveChange: function (oEvent) {
      const sQuery = oEvent.getParameter("newValue") || "";
      this._applyFilters({ search: sQuery });
    },


    onFilterChange: function () {
      this._applyFilters({});
    },


    onResetFilters: function () {
      this.byId("sfSearch").setValue("");
      this.byId("cbPlant").setSelectedKey("");
      this.byId("cbStatus").setSelectedKey("");
      this._applyFilters({ reset: true });
    },


    _applyFilters: function ({ search = null, reset = false }) {
      const oTable = this.byId("prTable");
      const oBinding = oTable.getBinding("rows");
      if (!oBinding) return;

      const sSearch = search !== null ? search : this.byId("sfSearch").getValue();
      const sPlant = this.byId("cbPlant").getSelectedKey();
      const sStatus = this.byId("cbStatus").getSelectedKey();

      const aFilters = [];


      if (sSearch) {
        const aSearchFilters = [];

        // Text-based contains on typical string columns
        aSearchFilters.push(
          new Filter("PurchaseRequisition", FilterOperator.Contains, sSearch),
          new Filter("PurchaseRequisitionItemText", FilterOperator.Contains, sSearch),
          new Filter("Plant", FilterOperator.Contains, sSearch),
          new Filter("CreatedByUser", FilterOperator.Contains, sSearch)
        );

        // If user typed a number, try quantity equality as well
        const nSearch = Number(sSearch);
        if (!Number.isNaN(nSearch)) {
          aSearchFilters.push(new Filter("RequestedQuantity", FilterOperator.EQ, nSearch));
        }

        // If user typed a short status code (e.g., "N" or "R"), try status equality
        if (typeof sSearch === "string" && sSearch.length === 1) {
          aSearchFilters.push(new Filter("ProcessingStatus", FilterOperator.EQ, sSearch));
        } else {
          // Also allow contains for status if user typed a longer text (defensive)
          aSearchFilters.push(new Filter("ProcessingStatus", FilterOperator.Contains, sSearch));
        }

        // OR across all search filters
        aFilters.push(new Filter({ filters: aSearchFilters, and: false }));
      }


      // Plant filter
      if (sPlant) {
        aFilters.push(new Filter("Plant", FilterOperator.EQ, sPlant));
      }

      // Status filter
      if (sStatus) {
        aFilters.push(new Filter("ProcessingStatus", FilterOperator.EQ, sStatus));
      }

      // Apply filters
      oBinding.filter(aFilters /*, "Application"*/);
    },







    formatQuantity: function (requestedQuantity, baseUnit) {
      if (requestedQuantity == null) return "";
      const qty = Number(requestedQuantity);
      if (!Number.isFinite(qty)) return `${requestedQuantity} ${baseUnit || ""}`.trim();
      const display = qty % 1 === 0 ? qty.toString() : qty.toFixed(3);
      return `${display} ${baseUnit || ""}`.trim();
    },


    formatDate: function (dateVal) {
      if (!dateVal) return "";
      const d = (typeof dateVal === "string") ? new Date(dateVal) : dateVal;
      const oFmt = DateFormat.getDateInstance({ style: "medium" });
      return oFmt.format(d);
    },


    onFileChange: function (oEvent) {
      const aFiles = oEvent.getParameter("files") || [];
      if (!aFiles.length) return;

      const file = aFiles[0];
      const reader = new FileReader();
      reader.onload = (e) => {
        const content = e.target.result;

        MessageToast.show(`Loaded file: ${file.name} (${file.size} bytes)`);
      };
      reader.readAsText(file);
    },


    onUploadComplete: function () {
      MessageToast.show("Upload complete");

    },

    onFileSelected: function (oEvent) {

      try {
        var oFile = oEvent.getParameter("files")[0];
        if (oFile) {
          var reader = new FileReader();

          reader.onload = function (e) {
            pageThis.fullBase64 = e.target.result;
            var base64String = e.target.result.split(",")[1];
            var mimeType = oFile.type;
            pageThis.FileType = oFile.type;

            if (pageThis.fullBase64 != '') {
              // pageThis.getView().byId("submit_button").setEnabled(true);
              pageThis.onSubmit();
            }

          };

          reader.readAsDataURL(oFile);
        }

      } catch (error) {

        this.getView().byId("fileUploader").setValue();
      }


    },

    onSubmit: async function (oEvent) {

      sap.ui.core.BusyIndicator.show(0);

      try {


        let href = window.location.href.split('sap')[0];
        let url = href + "sap/odata/v4/catalog/ExtractPdfText";

        let payload = {
          "fileType": pageThis.FileType,
          "base64pdf": this.fullBase64

        };

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
        sap.ui.core.BusyIndicator.hide();
        let extracted_data = oData.value;


        var obj = this.parseMaybeFencedJSON(extracted_data);
        if (!obj) {
          // Handle failure gracefully
          // e.g., show message to user, log, or retry upstream
          console.error("Could not parse JSON from extracted_data.");
        } else {
          console.log("Parsed object:", obj);
        }
        pageThis.extracted_data = obj;

        let oModel = new sap.ui.model.json.JSONModel({
          PRItem: pageThis.extracted_data.Items || pageThis.extracted_data.items,
          PR: [pageThis.extracted_data],
          edit: [true]
        });
        this.getOwnerComponent().setModel(oModel, "PRItemModel");
        this.getOwnerComponent().getModel("PRItemModel").refresh();

        this.openFragment();



      } catch (err) {
        this.getView().byId("fileUploader").setValue();
        sap.ui.core.BusyIndicator.hide();
        MessageBox.information("Please try again.")
        console.error("Error: " + err.message);

        throw err; // rethrow to handle in onCallGPT
      }


    },

    parseMaybeFencedJSON: function (input, { returnNullOnError = true } = {}) {
      // If it's already an object, return it
      if (input && typeof input === "object") return input;

      if (typeof input !== "string") {
        if (returnNullOnError) return null;
        throw new TypeError("Input must be a string or object.");
      }

      // Normalize whitespace
      let s = input.trim().replace(/\r\n/g, "\n");

      // 1) Strip Markdown code fences: ```json ... ``` OR ``` ... ```
      // Start fence
      s = s.replace(/^```(?:json|javascript|js|txt)?\n?/i, "");
      // End fence
      s = s.replace(/\n?```$/i, "");

      // Also handle cases like: "```json\n{...}\n```" embedded in text
      // Remove any remaining fenced blocks by capturing the inner content
      const fencedBlock = s.match(/```(?:json|javascript|js|txt)?\s*\n([\s\S]*?)\n```/i);
      if (fencedBlock && fencedBlock[1]) {
        s = fencedBlock[1].trim();
      }

      // 2) Try direct JSON.parse first
      try {
        return JSON.parse(s);
      } catch (_) {
        // 3) If not pure JSON, try to extract the first JSON object/array substring
        // Find first '{...}' or '[...]' by balancing braces/brackets
        const extractBalanced = (text) => {
          const openers = ['{', '['];
          const closers = { '{': '}', '[': ']' };

          let startIdx = -1, stack = [];
          for (let i = 0; i < text.length; i++) {
            const ch = text[i];

            // if not started yet, look for the first opener
            if (startIdx < 0 && (ch === '{' || ch === '[')) {
              startIdx = i;
              stack = [ch];
              continue;
            } else if (startIdx >= 0) {
              // inside a candidate
              if (ch === '{' || ch === '[') {
                stack.push(ch);
              } else if (ch === '}' || ch === ']') {
                if (stack.length === 0) break; // malformed, bail
                const top = stack[stack.length - 1];
                if (closers[top] === ch) {
                  stack.pop();
                  // if fully balanced, we got a JSON block
                  if (stack.length === 0) {
                    return text.slice(startIdx, i + 1);
                  }
                } else {
                  // mismatched closer; keep scanning
                }
              }
            }
          }
          return null;
        };

        const jsonSubstr = extractBalanced(s);
        if (jsonSubstr) {
          try {
            return JSON.parse(jsonSubstr);
          } catch (err2) {
            if (returnNullOnError) {
              console.warn("Failed to parse extracted JSON substring:", err2);
              return null;
            }
            throw new SyntaxError(`Invalid JSON after extracting substring: ${err2.message}`);
          }
        }

        // 4) If we reach here, parsing failed
        if (returnNullOnError) {
          console.warn("Input did not contain valid JSON.");
          return null;
        }
        throw new SyntaxError("Input did not contain valid JSON.");
      }
    },

    openFragment: async function () {

      var oView = this.getView();

      if (!this.oDialog) {
        this.oDialog = await this.loadFragment({
          name: "ns.purchasereq.fragment.Extracted_data"
        });
      }
      this.oDialog.open();

    },

    _closeDialog: function () {
      this.oDialog.close();

      let oModel = new sap.ui.model.json.JSONModel({
        PRItem: [],
        PR: []
      });
      this.getOwnerComponent().setModel(oModel, "PRItemModel");
      this.getOwnerComponent().getModel("PRItemModel").refresh();
      this.getView().byId("fileUploader").setValue();
    },

    onEditButton: function (oEvent) {

      this.getOwnerComponent().getModel("PRItemModel").getData().edit[0] = false;
      this.getOwnerComponent().getModel("PRItemModel").refresh();

      this.getView().byId("editBtn").setVisible(false);
      this.getView().byId("acceptBtn").setVisible(true);

    },

    onAccept: function (oEvent) {

      this.getOwnerComponent().getModel("PRItemModel").getData().edit[0] = true;
      this.getOwnerComponent().getModel("PRItemModel").refresh();


      this.getView().byId("editBtn").setVisible(true);
      this.getView().byId("acceptBtn").setVisible(false);
    },


    onconfirm: async function (oEvent) {

      let oModel = this.getOwnerComponent().getModel("PRItemModel");
      let PR = oModel.getProperty("/PR");
      // Logic to confirm the invoice submission, e.g., sending it to a server or updating the UI
      console.log("PR confirmed:", PR);

      sap.ui.core.BusyIndicator.show(0);

      let items = PR[0].Items || PR[0].items


      try {

        //////////////////////////////////////////////////////////////////////////////////////////////


        let href = window.location.href.split('sap')[0];
        let url = href + "sap/odata/v4/catalog/CreatePurchaseReq";

        const oPayload = {
          "PurchaseRequisition": "",
          "PurchaseRequisitionType": "NB", // keep it hard coded
          "PurReqnDescription": "Sample Purchase Requistion",
          "to_PurchaseReqnItem": []
        };


        for (let i = 0; i < items.length; i++) {

          oPayload.to_PurchaseReqnItem.push({
            "PurchaseRequisitionItemText": items[i].Description,
            "Material": "100006155",                                // keep it hard coded
            "PurchasingGroup": "001",                               // keep it hard coded
            "PurchaseRequisitionItem": "00010",                     // keep it hard coded
            "AccountAssignmentCategory": "U",                       // keep it hard coded
            "RequestedQuantity": items[i].Quantity.toString(),      // Get from Invoice
            "BaseUnit": "EA",                                       // Keep it hard coded
            "PurchaseRequisitionPrice": items[i].Price.toString(), // Get from Invoice
            "PurReqnItemCurrency": "USD",                           // Keep it hard coded
            "Plant": "3240"                                         // Keep it hard coded.
          })

        }



        sap.ui.core.BusyIndicator.hide();


        let StringPayload = { "payload": JSON.stringify(oPayload) };

        const response = await fetch(url, {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(StringPayload)
        });

        if (!response.ok) {
          throw new Error("Network response was not ok");
        }

        const oData = await response.json();

        if (oData) {

          this.oDialog.close();

          let oModel = new sap.ui.model.json.JSONModel({
            PRItem: [],
            PR: []
          });
          this.getOwnerComponent().setModel(oModel, "PRItemModel");
          this.getOwnerComponent().getModel("PRItemModel").refresh();
          this.getView().byId("fileUploader").setValue();

          this.getOwnerComponent().getModel().refresh();





        }

        sap.ui.core.BusyIndicator.hide();

        MessageBox.information("Purchase Requisition is created with \nPurchase Requisition No. " + oData.PurchaseRequisition);

        //////////////////////////////////////////////////////////////////////////////////////////////


      } catch (err) {
        sap.ui.core.BusyIndicator.hide();
        console.error("Error: " + err.message);

        throw err; // rethrow to handle in onCallGPT
      }
    },

    onCellLinkPress: function (oEvent) {

      let PR_No = oEvent.getSource().getText();
      let Desc = oEvent.getSource().getBindingContext().getObject().PurchaseRequisitionItemText;

      var oRouter = this.getOwnerComponent().getRouter();
      oRouter.navTo("objectPage", {
        PRDetail: JSON.stringify({
          PR_No: PR_No,
          Desc: Desc
        })
      });
    },



    onExportExcel: function () {
      const oTable = this.byId("prTable");
      const oBinding = oTable.getBinding("rows");
      if (!oBinding) return;

      // 1) Collect the contexts (respects current filters/sorters on the binding)
      const aContexts = oBinding.getCurrentContexts ? oBinding.getCurrentContexts() : oBinding.getContexts(0, oBinding.getLength());
      if (!aContexts || !aContexts.length) {
        sap.m.MessageToast.show("No data to export.");
        return;
      }

      // 2) Transform contexts into plain row objects
      const aRows = aContexts.map(ctx => {
        const o = ctx.getObject();
        return {
          PurchaseRequisition: o.PurchaseRequisition,
          PurchaseRequisitionItemText: o.PurchaseRequisitionItemText,
          RequestedQuantity: toNumber(o.RequestedQuantity),     // number for Excel
          BaseUnit: o.BaseUnit,
          Plant: o.Plant,
          DeliveryDate: this.formatDate(o.DeliveryDate),        // export as formatted string
          CreatedByUser: o.CreatedByUser,
          ProcessingStatus: o.ProcessingStatus
        };
      });

      // 3) Define columns (labels, property, type, width)
      const aColumns = [
        { label: "Purchase Requisition", property: "PurchaseRequisition", width: 20 },
        { label: "Description", property: "PurchaseRequisitionItemText", width: 30 },
        { label: "Quantity", property: "RequestedQuantity", width: 12, type: "number" },
        { label: "UoM", property: "BaseUnit", width: 8 },
        { label: "Plant", property: "Plant", width: 10 },
        { label: "Delivery Date", property: "DeliveryDate", width: 16 }, // string; could be type "date" if you pass Date objects
        { label: "Created By", property: "CreatedByUser", width: 16 },
        { label: "Status", property: "ProcessingStatus", width: 10 }
      ];

      // 4) Build the spreadsheet settings
      const oSettings = {
        workbook: {
          columns: aColumns
        },
        dataSource: aRows,
        fileName: "Purchase_Requisition_Items.xlsx",
        worker: true // use web worker for large data
      };

      // 5) Create and export
      const oSheet = new Spreadsheet(oSettings);
      oSheet.build()
        .then(() => sap.m.MessageToast.show("Excel exported"))
        .finally(() => oSheet.destroy());
    },


  });


  function toNumber(v) {
    if (v === null || v === undefined || v === "") return null;
    const n = Number(v);
    return Number.isNaN(n) ? null : n;
  }



});
