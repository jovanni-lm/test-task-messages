$( document ).ready(function() {
    $('#new-message').submit(function(e){
        e.preventDefault();

        var body = $('#msg-text').val();
        var password = md5($('#pass').val()).substring(0,16);

        var key = aesjs.util.convertStringToBytes(password);
        var textBytes = aesjs.util.convertStringToBytes(body);

        var aesCtr = new aesjs.ModeOfOperation.ctr(key, new aesjs.Counter(5));
        var encryptedBytes = aesCtr.encrypt(textBytes);

        $('#msg-body').val(encryptedBytes);
        $('#encrypted-password').val(password);

        this.submit();
    });
});
