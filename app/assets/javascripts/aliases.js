(function() {
    function deleteAddress() {
        $(this).closest(".input-group").remove();
    }

    $(document).on("turbolinks:load", function () {
        addButton = $("#add-forward-address-button");
        addButton.click(function () {
            input = $(".forward-address").first();
            newInput = $(input).clone();
            newInput.children("input").val("");
            button = newInput.find(".delete-forward-address-button");
            button.removeAttr("disabled");
            button.click(deleteAddress);
            newInput.children(".input-group-append").removeClass("d-none");
            newInput.insertBefore(addButton);
        });

        $(".delete-forward-address-button").click(deleteAddress);
    });
}).call(this);