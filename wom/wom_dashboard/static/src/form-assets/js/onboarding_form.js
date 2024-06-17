//==================Constants==================
// localStorage.clear();
// document.addEventListener("DOMContentLoaded", function () {
const baseUrl = window.location.protocol + "//" + window.location.host;
step = localStorage.getItem("step");

var fprice = 250000;

// [ current-Slider ]
var slider = null;
if (getElementReference("ex6")) {
  slider = new Slider("#ex6", {
    min: 0,
    max: 10000,
    step: 2,
    value: 0,
  });
}

// Function to set the value of the slider
function setSliderValue(value) {
  slider.setValue(value);
  let price = getPriceForTransaction(parseInt(value));

  console.log("************price", price, fprice);
  let amount = Math.round(price * parseInt(value));

  let setup = fprice - amount;

  if (setup < 0) {
    setup = 0;
  }
  setValue("setup_cost", numberWithCommas(setup));
  setInputValue("setup_input", setup);
  setValue("computed-txns", `${value} Transaction(s)`);

  setValue("amountTotal", numberWithCommas(parseInt(amount + setup)));
  setInputValue("inputTransactions", amount + setup);
  setValue("price_estimated", numberWithCommas(amount));
}

// Example usage: Set the slider value to 500
async function getPrice() {
  let apiUrll = `${baseUrl}/get/price/`;

  await fetch(apiUrll, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((data) => {
      console.log("************data", data);
      fprice = data.price;
      setValue("info-sec-1", `Minimum Accepted amount is UGX ${numberWithCommas(fprice)}`)
      if (slider) {
        setSliderValue(50);
      }
    })
    .catch((error) => {
      console.error("Fetch error:", error);
    });
}

getPrice();

//==================Main Functions ===========
function displayStepsLogic(step) {
  if (step === "2") {
    displayNone("ob_step1");
    displayBlock("ob_step2");
    setValue("currentEmail", maskEmail(localStorage.getItem("email")));
  } else {
    console.log();
  }
}

displayStepsLogic(step);

//handles
document.addEventListener(
  "bouncerFormValid",

  async function () {
    if (!localStorage.getItem("step")) {
      if (getValue("email")) {
        let userEmail = getValue("email");
        localStorage.setItem("email", userEmail.toString());
        captchaResponse = checkCaptcha();
        let response;
        if (!captchaResponse) {
          displayBlock("captchaErrorText");
        } else {
          displayNone("verify_email_btn");
          displayBlock("verify_email_loader_btn");
          const apiUrl = `${baseUrl}/user`;
          const data = {
            email: userEmail,
            recaptchaResponse: captchaResponse,
            resend: false,
          };

          await fetch(apiUrl, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
          })
            .then((response) => {
              if (!response.ok) {
                throw new Error("Network response was not ok");
              }
              return response.json();
            })
            .then((data) => {
              response = data;
            })
            .catch((error) => {
              console.error("Fetch error:", error);
            });
        }
        const currentDate = new Date();
        let currentMinutes = currentDate.getMinutes();
        localStorage.setItem("last_minutes", currentMinutes.toString());
        // Sleep for 10 seconds

        //
        if (response.success === false) {
          window.location.href = `${baseUrl}/web/login`;

          return;
        } else {
          localStorage.setItem("step", "2");
          localStorage.setItem("email", userEmail);
          displayNone("verifyError");
          displayNone("verify_email_loader_btn");
          displayNone("ob_step1");
          displayBlock("ob_step2");
          setValue("currentEmail", maskEmail(userEmail));
        }
      } else {
        return;
      }
    } else if (localStorage.getItem("step") === "2") {
      let code = "";
      for (let i = 1; i <= 6; i++) {
        code += getValue("code" + i).toString();
      }

      console.log(`Here...`, code.toString().length);

      if (code.toString().length !== 6) {
        return;
      }

      response = await verifyCode(code);

      if (!response.result) {
        displayNone("step2Success");
        displayBlock("step2Error");
        setValue("step2Error_content", "Invalid Code!");
      } else {
        displayNone("step2Success");
        displayNone("step2Error");
        displayFlex("password_div");
      }
    } else if (localStorage.getItem("step") === "3") {
      displayNone("submit-btn");
      displayBlock("submit_loader_btn");
      let submitForm = getElementReference("form-step3");
      submitForm.submit();
    } else {
      console.log("*************rese***");
    }
  },
  false
);

function getResetForm(event) {
  console.log(event.target.id);

  event.preventDefault(); // Prevents the form from actually submitting
  var form = getElementReference("resetPassword");

  var currentPath = window.location.pathname;
  if (
    currentPath === "/web/reset_password" &&
    window.location.search === "" &&
    getValue("login") !== ""
  ) {
    form.submit();
  }

  let password = getValue("password");
  let confirm_password = getValue("confirm_password");

  // Check if passwords match
  if (password !== confirm_password) {
    console.log("Passwords do not match.");
    return;
  }

  // Check if passwords match the specified pattern
  let pattern = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*/;
  if (!pattern.test(password)) {
    console.log("Password should match the specified pattern.");
    return;
  }

  form.submit();
}

const verificationCode = getElementReference("code1");
if (verificationCode) {
  verificationCode.addEventListener("input", async () => {
    const codeValueArray = verificationCode.value;
    let codeDone = false;
    if (codeValueArray.length == 6) {
      codeDone = true;
    }

    if (codeValueArray.length > 6) {
      setInputValue('code1', codeValueArray.slice(0, 6));
    }

    if (codeDone) {
      const form = getElementReference("validate-me");
      if (form) {
        let code = codeValueArray;

        if (code.toString().length !== 6) {
          return;
        }

        response = await verifyCode(code);

        if (!response.result) {
          displayNone("step2Success");
          displayBlock("step2Error");
          setValue("step2Error_content", "Invalid Code!");
        } else {
          displayNone("step2Success");
          displayNone("step2Error");
          displayFlex("password_div");
        }
      }
    }
  });
}


async function resendCode() {
  let _email = localStorage.getItem("email");

  const apiUrl = `${baseUrl}/user`;
  displayNone("step2Success");
  displayNone("step2Error");
  displayNone("confirm_code_btn");
  displayBlock("confirm_code_loader_btn");
  const currentDate = new Date();
  let currentMinutes = currentDate.getMinutes();
  let prevMin = localStorage.getItem("last_minutes")
    ? localStorage.getItem("last_minutes")
    : currentMinutes;
  prevMin = parseInt(prevMin) > currentMinutes ? 0 : parseInt(prevMin);

  captchaResponse = checkCaptcha();

  const data = {
    email: _email,
    recaptchaResponse: captchaResponse,
    resend: true,
  };

  if (parseInt(currentMinutes) - prevMin < 3) {
    displayNone("step2Success");
    displayBlock("step2Error");
    setValue(
      "step2Error_content",
      "Wait for 3 minutes before requesting for another code!"
    );
  } else {
    fetch(apiUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.json();
      })
      .then((data) => {
        localStorage.setItem("last_minutes", currentMinutes.toString());
        console.log(data);
      })
      .catch((error) => {
        console.error("Fetch error:", error);
      });
    displayBlock("step2Success");
    displayNone("step2Error");
  }

  // Sleep for 10 seconds
  await sleep(2000);
  displayNone("confirm_code_loader_btn");
  displayBlock("confirm_code_btn");
}
async function verifyCode(code) {
  let email = localStorage.getItem("email");
  let apiUrl = `${baseUrl}/code/${code}/${email}`;
  let response;
  await fetch(apiUrl)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((data) => {
      console.log(data);

      response = data;
    })
    .catch((error) => {
      console.error("Fetch error:", error);
    });
  return response;
}

const proceedToRegister = async function () {
  //==============Validate the Verificatiuon Code============

  let code = getValue("code1").toString();

  if (code.length != 6) {
    displayNone("step2Success");
    displayBlock("step2Error");
    setValue("step2Error_content", "Please Fill in the verification Code!");
    return;
  } else if (
    getValue("password") === "" ||
    getValue("confirm_password") === ""
  ) {
    response = await verifyCode(code);
    if (!response.result) {
      setValue("step2Error_content", "Invalid Code!");
      return;
    }
    displayNone("step2Success");
    displayBlock("step2Error");
    setValue("step2Error_content", "Please Enter your password!");
    return;
  } else if (getValue("password") !== getValue("confirm_password")) {
    displayNone("step2Success");
    displayBlock("step2Error");
    setValue("step2Error_content", "Passwords dont match!");
  } else {
    let pass1 = getValue("password");
    displayNone("confirm_code_btn");
    displayBlock("confirm_code_loader_btn");
    await sleep(1200);
    displayBlock("confirm_code_btn");
    displayNone("ob_step2");
    displayBlock("ob_step3");

    setInputValue("password2", pass1);
    setInputValue("confirm_password2", pass1);
    setInputValue("email1", localStorage.getItem("email"));
    localStorage.setItem("step", "3");
  }
};
const continueBtn = getElementReference("confirm_code_btn");
if (continueBtn) {
  continueBtn.addEventListener("click", proceedToRegister);
}

//=============================PAYMENT LOGIC ==========================

const proceedBtn = getElementReference("process_to_checkout");

if (proceedBtn) {
  proceedBtn.addEventListener("click", async function (event) {
    if (!getElementReference('transactions').value) {
      return
    }
    if (parseFloat(inputTransactions.value) < fprice && !(isNaN(getElementReference('transactions').value))) {
      return;
    } else {
      displayNone("process_to_checkout");
      displayBlock("process_loader_btn");

      await sleep(2000);
      var form = getElementReference("package_information");
      localStorage.setItem("previousTransactions", getElementReference('transactions').value)
      form.submit();
    }
  });
}

function movePrev(step) {
  if (step === 1) {
    displayNone("step3");
    displayBlock("step2");
    displayBlock("code-input");
    displayFlex("code-input");
    displayBlock("button-div");
    displayFlex("password_div");
    getElementReference("button-div").style.marginTop = "20px";

    getElementReference("confirm_code_btn").classList.add("w-100");
  }
}

const transactionsInput = getElementReference("transactions");

const calculateAmounts = function () {
  const transactions = parseInt(transactionsInput.value);
  if (isNaN(transactions)) {
    console.log(transactionsInput.value)
    const testPrice = numberWithCommas(getPriceForTransaction(transactionsInput.value))
    setValue("amountTotal", parseInt(testPrice));
    setInputValue("inputTransactions", testPrice);
    setValue("price_estimated", testPrice);
  } else {
    const transactionPrice = getPriceForTransaction(transactions);
    const amount = transactions * transactionPrice;
  
    if (!isNaN(amount)) {
      setValue("price_estimated", numberWithCommas(parseInt(amount)));
    } else {
      setValue("price_estimated", numberWithCommas(0));
    }
  
    setValue("amountTotal", numberWithCommas(parseInt(amount)));
    setInputValue("inputTransactions", parseInt(amount));
    if (amount < fprice) {
      setValue("minimum-amount-error-text", `Minimum amount is ${numberWithCommas(fprice)}`);
      displayBlock("minimum-amount-error-div");
    } else {
      displayNone("minimum-amount-error-div");
    }
  }

}

transactionsInput?.addEventListener('input', calculateAmounts);

// transactionsInput?.addEventListener('input', function () {
//   const transactions = parseInt(transactionsInput.value);
//   const transactionPrice = getPriceForTransaction(transactions);
//   const amount = transactions * transactionPrice;

//   if (!isNaN(amount)) {
//     setValue("price_estimated", numberWithCommas(parseInt(amount)));
//   } else {
//     setValue("price_estimated", numberWithCommas(0));
//   }

//   if (amount < fprice) {
//     setValue("setup_cost", numberWithCommas(parseInt(fprice - amount)));
//     setValue("amountTotal", numberWithCommas(fprice));
//     setInputValue("inputTransactions", parseInt(amount));
//     setInputValue("setup_input", parseInt(fprice - amount));
//   } else {
//     setValue("setup_cost", numberWithCommas(0));
//     setValue("amountTotal", numberWithCommas(parseInt(amount)));
//     setInputValue("inputTransactions", parseInt(amount));
//     setInputValue("setup_input", numberWithCommas(0));
//   }
// });

async function increaseQty() {
  const apiUrl = `${baseUrl}/shop/cart/increase/`;

  spinnerShow();
  await fetch(apiUrl, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((response) => {
      if (response.success === 1) {
        window.location.href = `${baseUrl}/shop/cart`;
      }
    })
    .catch((error) => {
      console.error("Fetch error:", error);
    });
}

async function decreaseQty() {
  const apiUrl = `${baseUrl}/shop/cart/decrease/`;
  spinnerShow();

  await fetch(apiUrl, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((response) => {
      if (response.success === 1) {
        window.location.href = `${baseUrl}/shop/cart`;
      }
    })
    .catch((error) => {
      console.error("Fetch error:", error);
    });
}
// });

async function deleteQty() {
  const apiUrl = `${baseUrl}/shop/cart/delete`;
  spinnerShow();

  await fetch(apiUrl, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((response) => {
      if (response.success === 1) {
        window.location.href = `${baseUrl}/shop/cart`;
      }
    })
    .catch((error) => {
      console.error("Fetch error:", error);
    });
}
// });

function spinnerShow() {
  var elements = document.getElementsByClassName("qty_i");
  var elements_2 = document.getElementsByClassName("qty_spinner");

  for (var i = 0; i < elements.length; i++) {
    elements[i].style.display = "none";
  }
  for (var i = 0; i < elements_2.length; i++) {
    elements_2[i].style.display = "block";
  }
}

function addToCart1() {
  document.getElementById("hidden-product-input").value = "basic";

  document.getElementById("cart-form").submit();
}

function addToCart2() {
  document.getElementById("hidden-product-input").value = "standard_saas";
  document.getElementById("cart-form").submit();
}

function addToCart3() {
  document.getElementById("hidden-product-input").value = "premium_saas";
  document.getElementById("cart-form").submit();
}

const submitContact = getElementReference("contactus_btn");

if (submitContact) {
  submitContact.addEventListener("click", async function (event) {
    console.log("&*************************this contact us form");

    if (
      getValue("contact1") === "" ||
      getValue("contact2") === "" ||
      getValue("contact3") === "" ||
      getValue("contact4") === "" ||
      getValue("contact5") === "" ||
      getValue("contact6") === "" 
    ) {
      displayBlock("contact-error");
      setValue("contact-error-text", "Please Fill in all required fields!");


    } else {

      captchaResponse = checkCaptcha();
      if (!captchaResponse) {
        displayBlock("contact-error");
        setValue("contact-error-text", "Please verify you are not a robot!");
        return;
      } else {
        
        displayNone("contactus_btn");
        displayBlock("contact_loader_btn")

        displayNone("contact-error");
        setValue("contact-error-text", "");
        console.log("through this");
        let submitForm = getElementReference("contactus_form");
        submitForm.submit();
      }
    }
  });
}

const togglePassword = getElementReference("toggle-password");
const togglePasswordConfirm = getElementReference("toggle-password-confirm");

if (togglePassword) {
  togglePassword.addEventListener("click", function () {
    const passwordInput = getElementReference("password");
    let inputType =
      passwordInput.getAttribute("type") === "password" ? "text" : "password";
    passwordInput.setAttribute("type", inputType);
    getElementReference("toggleIcon").classList.toggle("fa-eye-slash");
  });
}

if (togglePasswordConfirm) {
  togglePasswordConfirm.addEventListener("click", function () {
    const passwordInput = getElementReference("confirm_password");
    let inputType =
      passwordInput.getAttribute("type") === "password" ? "text" : "password";
    passwordInput.setAttribute("type", inputType);
    getElementReference("toggleConfirmIcon").classList.toggle("fa-eye-slash");
  });
}

function startTimer() {
  var seconds = 60;

  setValue("payment_timer", seconds);

  if (getElementReference("payment_timer")) {
    function countdown() {
      seconds--;
      setValue("payment_timer", seconds);
      if (seconds <= 1) {
        clearInterval(timerInterval); // Stop the timer
        setValue("payment_timer", seconds);
        displayNone("timer_div");
        displayBlock("timer_2_div");

        startSecondTimer();
      }
    }
    var timerInterval = setInterval(countdown, 1000);
  }
}

function startSecondTimer() {
  var seconds = 5;

  setValue("payment_2_timer", seconds);

  function countdown() {
    seconds--;
    setValue("payment_2_timer", seconds);
    if (seconds <= 1) {
      clearInterval(timerInterval); // Stop the timer
    }
  }
  var timerInterval = setInterval(countdown, 1000);
}

startTimer();

function getResetForm() {
  var form = getElementReference("resetPassword");

  var currentPath = window.location.pathname;

  if (currentPath === "/web/reset_password" && getValue("login") === "") {
    return;
  }
  if (
    currentPath === "/web/reset_password" &&
    window.location.search === "" &&
    getValue("login") !== ""
  ) {
    displayNone("submitReset");
    displayBlock("reset_loader_btn");
    form.submit();
  }

  let password = getValue("password");
  let confirm_password = getValue("confirm_password");

  // Check if passwords match
  if (password !== confirm_password) {
    return;
  }

  // Check if passwords match the specified pattern
  let pattern = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*/;
  if (!pattern.test(password)) {
    return;
  }

  displayNone("submitReset");
  displayBlock("reset_loader_btn");

  form.submit();
}

let resetForm = getElementReference("resetPassword");
if (resetForm) {
  resetForm.addEventListener("submit", function (event) {
    event.preventDefault();
    getResetForm();
  });
}

