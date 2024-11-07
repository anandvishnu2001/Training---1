<cfheader name="Content-Disposition" value="attachment; filename=Order_Invoice_#url.order#.pdf">

    <cfheader name="Content-Type" value="application/pdf">

    <cfcontent type="application/pdf" reset="true">

    <cfset control = CreateObject("component", "components.control")>
    <cfset variables.orders = control.getOrder(order=url.order)>
    
    <cfdocument format="PDF" orientation="portrait">
    
    <cfoutput>
        <h1 style="text-align: center;">Invoice</h1>
        <h4>Order Number:</h4>
        <span>#variables.orders[1].id#</span>
        <h4>Order Date:</h4>
        <span>#dateFormat(variables.orders[1].date, "mm/dd/yyyy")#</span>
        <h4>Shipping Address:</h4>
        <span>
            #variables.orders[1].shipping.name#
            #variables.orders[1].shipping.phone#<br>
            #variables.orders[1].shipping.house#,
            #variables.orders[1].shipping.street#,
            #variables.orders[1].shipping.city#,
            #variables.orders[1].shipping.state#,
            #variables.orders[1].shipping.country#
            PIN - #variables.orders[1].shipping.pincode#
        </span>

        <br><hr>

        <cfset variables.total = 0>

        <table style="border: 1px solid black" cellpadding="5" cellspacing="5">
            <thead>
                <tr>
                    <th style="border: 1px solid black">Item</th>
                    <th style="border: 1px solid black">Quantity</th>
                    <th style="border: 1px solid black">Price</th>
                    <th style="border: 1px solid black">Total</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput>
                    <cfloop array="#variables.orders[1].items#" index="item">
                        <tr>
                            <td style="border: 1px solid black">#item.name#</td>
                            <td style="border: 1px solid black">#item.quantity#</td>
                            <td style="border: 1px solid black">#chr(8377)##numberFormat(item.price,'__.00')#</td>
                            <cfset variables.total += item.quantity*item.price>
                            <td style="border: 1px solid black">#chr(8377)##numberFormat(item.quantity * item.price,'__.00')#</td>
                        </tr>
                    </cfloop>
                </cfoutput>
            </tbody>
        </table>

        <p><strong>Total:</strong>#chr(8377)##numberFormat(variables.total,'__.00')#</p>
    </cfoutput>
</cfdocument>
