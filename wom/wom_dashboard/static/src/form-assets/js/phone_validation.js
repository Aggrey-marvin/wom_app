try {
    input = document.querySelector("#phone");
} catch (error) {
    let input = document.querySelector("#phone");
}

if (!input) {
    input = document.querySelector("#airtel_phone_number");
}
let input_mtn = document.querySelector("#phn_number");
// if (!input) {
//     input = document.querySelector("#phn_number");
// }
const address_button = document.querySelector("#address_btn");
// const errorMsg = document.querySelector("#error-msg");
const validMsg = document.querySelector("#valid-msg");
// let phone_label = document.querySelector("#phone-label");

let phone_label = document.querySelector("#airtel_number_label");

let phone_label_mtn = document.querySelector("#mtn_number_label");
// console.log("that ting");
// console.log(document.querySelector("#airtel_phone_number"));
// console.log(document.querySelector("#phn_number"));
// console.log(document.querySelector(input));
const iti = window.intlTelInput(input, {
    utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
    initialCountry: "ug",
    autoPlaceholder: "e.g 757346777",
    customPlaceholder: "e.g 757346777",
    placeholderNumberType: "FIXED_NUMBER",
    separateDialCode: true,
    onlyCountries: ['ug']
});

const iti_mtn = window.intlTelInput(input_mtn, {
    utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
    initialCountry: "ug",
    autoPlaceholder: "e.g 775346777",
    customPlaceholder: "e.g 787346777",
    placeholderNumberType: "FIXED_NUMBER",
    separateDialCode: true,
    onlyCountries: ['ug']
});
function checkProvider(number) {
    number = number.slice(4);
    if (document.querySelector("#airtel_phone_number")) {
        if (!(['75', '70', '74'].includes(number.slice(0, 2)))) {
            getElementReference('airtel_phone_number').style.borderColor = 'red';
            getElementReference('airtel_phone_number').value = '';
            displayBlock('airtel-phone-error');
            console.log('invalid number')
        } else {
            getElementReference('airtel_phone_number').style.borderColor = '#bec8d0';
            displayNone('airtel-phone-error');
        }
    }   
}
function checkProvider_mtn(number) {
    number = number.slice(4);
    if (document.querySelector("#mtn_phone_number")) {
        if (!(['77', '78', '76'].includes(number.slice(0, 2)))) {
            getElementReference('mtn_phone_number').style.borderColor = 'red';
            getElementReference('mtn_phone_number').value = '';
            displayBlock('mtn-phone-error');
            console.log('invalid number')
        } else {
            getElementReference('mtn_phone_number').style.borderColor = '#bec8d0';
            displayNone('mtn-phone-error');
        }
    }
}
input.addEventListener('focus', function () {
    // console.log(phone_label_mtn)
    console.log("is focused........");
    // console.log(phone_label);
    
    phone_label.classList.add('move-up')
    phone_label_mtn.classList.add('move-up')
});

input.addEventListener('blur', function () {
    console.log("is not focused........");
    if (input.value.trim() === '') {
        phone_label.classList.remove('move-up')
        phone_label_mtn.classList.remove('move-up')
    }

});

if (input.value.trim() !== '') {
    phone_label.classList.add('move-up')
    phone_label_mtn.classList.add('move-up')
}

input.addEventListener('input', function () {

    if (input.value.trim() !== '') {
        phone_label.classList.add('move-up')
        phone_label_mtn.classList.add('move-up')
    } else {
        phone_label.classList.remove('move-up')
        phone_label_mtn.classList.remove('move-up')
    }
});



const handleChange = () => {
    let text;
    // console.log("handling change.....")
    console.log(input_mtn.value)
    console.log(input.value)
    if (input.value) {
        // console.log("handlpoining change.....")
        if (iti.isValidNumber()) {
            // errorMsg.innerHTML = "Valid number! Full international format: " + iti.getNumber();
            number = iti.getNumber();
            const isAirtelNumber = checkProvider(number)
            console.log(number)
        } else {
            displayBlock('airtel-phone-error');
            // console.log(input.value)
        }
    } 
    else if (input_mtn.value) {
        // console.log("haneeeedling change.....")
        if (iti_mtn.isValidNumber()) {
            // errorMsg.innerHTML = "Valid number! Full international format: " + iti.getNumber();
            number = iti_mtn.getNumber();
            const isMTNNumber = checkProvider_mtn(number)
            console.log(number)
        } else {
            displayBlock('mtn-phone-error');
            // console.log(input.value)
        }
    }
    else {
        // console.log("handlie3333ng change.....")
        // displayBlock('airtel-phone-error');
        //displayBlock('mtn-phone-error');
    }

};

function replacePrefixWithZero(inputString) {

    if (inputString.startsWith('+256')) {
        return '0' + inputString.slice(4);
    } else {
        return inputString;
    }
}

input.addEventListener('change', handleChange);

if (address_button) {
    address_button.addEventListener('click', (event) => {
        handleChange();
        if (number != '') {
            number = replacePrefixWithZero(number)
            input.value = number;
            address_button.disabled = false;
        } else {
            address_button.disabled = true;
            errorMsg.innerHTML = "Please enter a valid number";
            errorMsg.classList.remove("hide");
            errorMsg.style.color = 'red';
        }

    });
}