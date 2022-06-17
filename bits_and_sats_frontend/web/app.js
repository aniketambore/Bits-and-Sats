function checkWebln() {
    if (typeof window.webln !== 'undefined') {
        window.state = {
            isWebln: true
        };
            enableWebln();
      } else{
          window.state = {
              isWebln: false
          }
      }
}

async function enableWebln(){
    await window.webln.enable();
}