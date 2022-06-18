async function sendPaymentFunction(invoice){
    try {
        const res = await window.webln.sendPayment(invoice);
        window.paymentState = {
            preimage: res["preimage"],
            paymentHash: res["paymentHash"]
        }
    }
    catch(e) {
        showError(e);
    }
}