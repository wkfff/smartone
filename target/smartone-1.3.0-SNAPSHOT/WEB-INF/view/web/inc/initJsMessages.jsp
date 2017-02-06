<script type="text/javascript">
    jQuery.extend(jQuery.validator.messages, {
        required : '<spring:message code="input.required"/>',
        emial : '<spring:message code="input.emial"/>',
        date : '<spring:message code="input.date"/>',
        number : '<spring:message code="input.number"/>',
        digits : '<spring:message code="input.digits"/>',
        creditcard : '<spring:message code="input.creditcard"/>',
        equalTo : '<spring:message code="input.equalTo"/>',
        accept : '<spring:message code="input.accept"/>',
        maxlength : jQuery.validator.format('<spring:message code="input.maxlength"/>'),
        minlength : jQuery.validator.format('<spring:message code="input.minlength"/>'),
        rangelength : jQuery.validator.format('<spring:message code="input.rangelength"/>'),
        range : jQuery.validator.format('<spring:message code="input.range"/>'),
        max : jQuery.validator.format('<spring:message code="input.max"/>'),
        min : jQuery.validator.format('<spring:message code="input.min"/>')
    });

    function getMessage(a) {
        var temp = new Array();
        temp[0] = '<spring:message code="tab.close"/>';
        temp[1] = '<spring:message code="tab.closeOther"/>';
        temp[2] = '<spring:message code="tab.closeAll"/>';
        temp[3] = '<spring:message code="tab.reload"/>';
        return temp[a];
    }
</script>