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

    //
    //// The counter mode of operation maintains internal state, so to
    //// decrypt a new instance must be instantiated.
    //var aesCtr = new aesjs.ModeOfOperation.ctr(key, new aesjs.Counter(5));
    //var decryptedBytes = aesCtr.decrypt(encryptedBytes);
    //
    //// Convert our bytes back into text
    //var decryptedText = aesjs.util.convertBytesToString(decryptedBytes);
    //console.log(decryptedText);
});
