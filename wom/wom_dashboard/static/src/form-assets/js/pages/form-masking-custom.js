'use strict';
(function () {
    const date1 = document.querySelector('.date');
    if (date1) {
        var regExpMask = IMask(document.querySelector('.date'), { mask: '00/00/0000' });
    }

    const date2 = document.querySelector('.date2')
    if (date2) {
        var regExpMask = IMask(date2, { mask: '00-00-0000' });
    }

    const hour = document.querySelector('.hour');
    if (hour) {
        var regExpMask = IMask(hour, { mask: '00:00:00' });
    }

    const dateHour = document.querySelector('.dateHour');
    if (dateHour) {
        var regExpMask = IMask(dateHour, { mask: '00/00/0000 00:00:00' });
    }

    const mob_no = document.querySelector('.mob_no');
    if (mob_no) {
        var regExpMask = IMask(mob_no, { mask: '0000-000-000' });
    }

    const phone = document.querySelector('.phone');
    if (phone) {
        var regExpMask = IMask(phone, { mask: '0000-0000' });
    }

    const telphone_with_code = document.querySelector('.telphone_with_code');
    if (telphone_with_code) {
        var regExpMask = IMask(telphone_with_code, { mask: '(00) 0000-0000' });
    }

    const us_telephone = document.querySelector('.us_telephone');
    if (us_telephone) {
        var regExpMask = IMask(us_telephone, { mask: '(000) 000-0000' });
    }

    const ug_telephone = document.querySelector('.ug_telephone');
    if (ug_telephone) {
        var regExpMask = IMask(ug_telephone, { mask: '(000) 000-0000' });
    }

    const ip = document.querySelector('.ip');
    if (ip) {
        var regExpMask = IMask(ip, { mask: '000.000.000.000' });
    }

    const ipv4 = document.querySelector('.ipv4');
    if (ipv4) {
        var regExpMask = IMask(ipv4, { mask: '000.000.000.0000' });
    }

    const ipv6 = document.querySelector('.ipv6');
    if (ipv6) {
        var regExpMask = IMask(ipv6, { mask: '0000:0000:0000:0:000:0000:0000:0000' });
    }

})();