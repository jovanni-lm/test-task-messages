$( document ).ready(function() {
    var key = aesjs.util.convertStringToBytes($('#message-password').text());

    var aesCtr = new aesjs.ModeOfOperation.ctr(key, new aesjs.Counter(5));
    var decryptedBytes = aesCtr.decrypt($('#message-body').text().split(',').map(Number));

    var decryptedText = aesjs.util.convertBytesToString(decryptedBytes);
    $('#show-msg').html(decryptedText);
});
