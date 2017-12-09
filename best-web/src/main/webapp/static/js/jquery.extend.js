;(function ($) {
    $.fn.extend({
        "hl": function () {
            this.addClass("hl");
        },
        "unhl": function () {
            this.removeClass('hl')
        },
        "disableInput": function (val) {
            this.prop('disabled', true)
            if (val) {
                this.data('oval', this.val())
                this.val(val)
            }
        },
        "enableInput": function () {
            this.prop('disabled', false)
            this.val(this.data('oval'))
        },
        "yuan": function () {
            this.keyup(function () {
                var money = this.value;
                if (!money) {
                    return;
                }
                var moneyArr = money.split("");
                var targetArr = []
                for (var i = 0; i < moneyArr.length; i++) {
                    var numChar = moneyArr[i];
                    if (isNaN(numChar)) {
                        break;
                    }
                    targetArr.push(numChar)
                }
                this.value = targetArr.join('')
            })
        }
    })
})(jQuery)
;
(function ($) {
    $.extend({
        price2show: function (val) {
            val = $.trim(val)
            if (!val || val == 0) return '';
            return isNaN(val) ? val : (val / 100);
        },
        price2save: function (val) {
            val = $.trim(val)
            if (!val || val == 0) return '';
            return isNaN(val) ? val : (val * 100);
        }
    })
})(jQuery)