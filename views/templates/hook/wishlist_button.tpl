

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

{if !$ifExist}
    <button style="background: transparent;" name="submitWishlist" type="button" id="wish-{$id_product}" data-id-product="{$id_product}" class="whishlist btn" data-action="addWishlist">
        <i class="material-icons">favorite_border</i>
    </button>
{else}
    <button style="background: transparent;" name="submitWishlist" type="button" id="wish-{$id_product}" data-id-product="{$id_product}" class="whishlist btn" data-action="removeWishlist">
        <i class="material-icons">favorite</i>
    </button>
{/if}
<div class="mb-2" id="wishMessage-{$id_product}"></div>

<script>
    $(document).ready(function() {
    $('#wish-{$id_product}').on('click', function() {
    var id_customer = "{$id_customer}";
    var id_product = "{$id_product}";
    var action = $(this).data('action');

    // AJAX request to handle the add/remove action
    $.ajax({
        type: 'POST',
        url: "/modules/cafe_wishlist/ajax/submit.php",
        data: {
            id_customer: id_customer,
            id_product: id_product,
            action: action
        },
        dataType: 'json',
        success: function(response) {
            // Handle the response here
            console.log(response); // Check the response object in the browser console

            var alertMessage = $('#wishMessage-'+ response.id_product);

            if (response.status === 'success1') {
               alertMessage.html(
                    '<span  style="top: 10px;left: -25px;position: relative;"  class="alert">Ajouté à wishlist !</span>'
                    );
                    $('#wish-{$id_product} i').removeClass('material-icons').addClass('material-icons').html('favorite');
                    $('#wish-' + response.id_product).data('action', 'removeWishlist'); // Update the data-action attribute

                
            } else if (response.status === 'success2') {
               alertMessage.html(
                    '<span  style="top: 10px;left: -25px;position: relative;"  class="alert" role="alert">Retiré de wishlist !</span>'
                    );
                    $('#wish-{$id_product} i').removeClass('material-icons-outlined').addClass('material-icons').html('favorite_border');
                    $('#wish-' + response.id_product).data('action', 'addWishlist'); // Update the data-action attribute


            } else if (response.status === 'error') {
                alertMessage.html(
                    '<span style="top: 10px;left: -25px;position: relative;"  class="alert" role="alert">Veuillez vous connecter pour ajouter ce produit à votre wishlist !</span>'
                    );
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            // Handle errors here
            console.log('AJAX Error: ' + textStatus);
            console.log('Error Thrown: ' + errorThrown);
        }
    });
    });
    });
</script>




