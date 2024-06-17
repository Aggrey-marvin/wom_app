function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function displayNone(id) {
  if (document.getElementById(id)) {
    document.getElementById(id).style.display = "none";
  }
}
function displayBlock(id) {
  if (document.getElementById(id)) {
    document.getElementById(id).style.display = "block";
  }
}

function displayFlex(id) {
  if (document.getElementById(id)) {
    document.getElementById(id).style.display = "flex";
  }
}
function getValue(id) {
  if (document.getElementById(id)) {
    return document.getElementById(id).value;
  } else {
    return false;
  }
}

function setValue(id, value) {
  if (document.getElementById(id)) {
    document.getElementById(id).textContent = value;
  }
}

function setInputValue(id, value) {
  if (document.getElementById) {
    document.getElementById(id).value = value;
  }
}

function getElementReference(id) {
  return document.getElementById(id);
}
function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function clearClassList(id) {
  const element = document.getElementById(id);
  if (element) {
    element.classList.remove(...element.classList);
  }
}

function maskEmail(email) {
  if (email) {
    const [localPart, domain] = email.split("@");
    const localPartLength = localPart.length;
    const maskedLocalPart =
      localPart.charAt(0) +
      "*".repeat(localPartLength - 2) +
      localPart.charAt(localPartLength - 1);
    const maskedEmail = maskedLocalPart + "@" + domain;
    return maskedEmail;
  } else {
    return false;
  }
}

function checkCaptcha() {
  return grecaptcha.getResponse();
}

function isNumberKey(evt) {
  var charCode = evt.which ? evt.which : evt.keyCode;
  if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
  return true;
}

function addCommasToNumber(number) {
  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}






function getPriceForTransaction(transactions) {
  if (transactions == 'b1t@n0only@efrIs') {
    return 500
  }
  if (transactions === 0) {
    return 0;
  }
  return 500
  // if (transactions <= 20) {
  //     return 5000;
  //     // return 500;
  // } else if (transactions <= 50) {
  //     return 2030;
  // } else if (transactions <= 100) {
  //     return 1040;
  // } else if (transactions <= 200) {
  //     return 545;
  // } else if (transactions <= 500) {
  //     return 248;
  // } else if (transactions <= 1000) {
  //     return 149;
  // } else if (transactions <= 2000) {
  //     return 99.5;
  // } else if (transactions > 2000) {
  //     return 69.8;
  // } else {
  //     return 0; // Return null if no price range available
  // }
}