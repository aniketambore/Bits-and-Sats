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

async function pay(walletAddress, comment, tokens){
    const { invoice, params, successAction, validatePreimage } =
    await LnurlPay.requestInvoice({
      lnUrlOrAddress: walletAddress,
      tokens: tokens,
      comment: comment,
    });

    let http = new XMLHttpRequest();
    const _apiKey = "";
    const url = "https://legend.lnbits.com/api/v1/payments";
    let data = {
        "out": true,
        "bolt11": invoice
    };
    http.open("POST", url, true);
    http.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
    http.setRequestHeader("X-Api-Key", _apiKey);
    http.onreadystatechange = function() {
        if(http.readyState == 4 && http.status == 200) {
            alert(http.responseText);
        }
    }
    http.send(JSON.stringify(data));
}