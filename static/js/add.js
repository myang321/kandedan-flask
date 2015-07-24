/**
 * Created by Steve on 7/4/2015.
 */
function checkCheckBox() {
    if ($("input[name=who]:checked").map(
            function () {
                return this.value;
            }).get().length == 0) {
        alert("please check at least one person");
        return false;
    }
    else
        return true;
};
$("#add_button").click(checkCheckBox);
