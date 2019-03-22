(function() {
    function deleteAddress() {
        $(this).closest(".input-group").remove();
    }

    document.addEventListener("turbolinks:load", function () {
        var addButton = document.getElementById("add-forward-address-button");
        if (addButton === null) {
            return;
        }
        addButton.addEventListener('click', function () {
            var address = document.querySelector(".forward-address");
            var newAddress = $(address).clone();
            newAddress.children("input").val("");
            var button = newAddress.find(".delete-forward-address-button");
            button.removeAttr("disabled");
            button.click(deleteAddress);
            newAddress.children(".input-group-append").removeClass("d-none");
            newAddress.insertBefore(addButton);
        });

        document.querySelectorAll(".delete-forward-address-button").forEach(function (button){
            button.addEventListener('click', deleteAddress);
        });
    });
}).call(this);