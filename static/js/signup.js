/**
 * Created by Steve on 7/7/2015.
 */
function checkPass1() {
    $("#pass2").val("");
};
function checkPass2() {
    var pass1 = $("#pass1").val();
    var pass2 = $("#pass2").val();
    if (pass1 != pass2) {
        $("#pass2").css("border-top", "1px solid red");
        $("#pass2").css("border-right", "2px solid red");
        $("#pass2").css("border-bottom", "2px solid red");
        $("#pass2").css("border-left", "2px solid red");
        $("#pass1").css("border-bottom", "1px solid red");
    } else {
        $("#pass2").css("border-top", "1px solid #2c90c6");
        $("#pass2").css("border-right", "2px solid #2c90c6");
        $("#pass2").css("border-bottom", "2px solid #2c90c6");
        $("#pass2").css("border-left", "2px solid #2c90c6");
        $("#pass1").css("border-bottom", "1px solid #2c90c6");
    }

};

$("#pass1").bind("input", checkPass1);
$("#pass2").bind("input", checkPass2);
$("#signup_form").submit(function (event) {
    var pass1 = $("#pass1").val();
    var pass2 = $("#pass2").val();
    if (pass1 != pass2) {
        alert("password not match");
        event.preventDefault();
    }
});