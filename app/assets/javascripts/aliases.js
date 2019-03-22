(function() {
    function deleteAddress() {
        this.parentNode.parentNode.remove();
    }

    document.addEventListener("turbolinks:load", function () {
        var addButton = document.getElementById("add-forward-address-button");
        if (addButton === null) {
            return;
        }
        addButton.addEventListener('click', function () {
            var address = document.querySelector(".forward-address");
            var newAddress = address.cloneNode(true);
            newAddress.querySelector("input").value = "";
            var button = newAddress.querySelector(".delete-forward-address-button");
            button.removeAttribute("disabled");
            button.addEventListener('click', deleteAddress);
            newAddress.querySelector(".input-group-append").classList.remove("d-none");
            addButton.parentNode.insertBefore(newAddress, addButton);
        });

        document.querySelectorAll(".delete-forward-address-button").forEach(function (button){
            button.addEventListener('click', deleteAddress);
        });
    });
}).call(this);