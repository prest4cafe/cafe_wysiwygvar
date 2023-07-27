{if !$isCustomerLoggedIn}
    <script>
        $(document).ready(function() {


            $('button[name="submitWishlist"]').on('click', function(event) {
                event.preventDefault(); // Empêche la soumission normale du formulaire

                var productId = $(this).data('id-product');
                $('input[name="modalProductId"]').val(productId); // Set the productId value in the modal

                $('#loginModalWishProduct').modal('show');



            });

            $('button[name="urlWishlist"]').on('click', function(event) {
                event.preventDefault(); // Empêche la soumission normale du formulaire

                $('#loginModalWishProduct').modal('show');
            });
        });
    </script>
{else}

{/if}

{if !$isCustomerLoggedIn}
    <!-- Modal -->
    <div class="modal fade" id="loginModalWishProduct" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title" id="loginModalLabel">Vous devez vous connecter !</span>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    {block name='login_form'}


                        <div>

                            <div class="form-group row ">
                                <label class="col-md-3 form-control-label required" for="field-email">
                                    E-mail
                                </label>
                                <div class="col-md-8">
                                    <input class="form-control" name="email-wishlist" type="email" value="" required="">
                                </div>

                                <input type="hidden" name="modalProductId" value="">


                            </div>
                            <!-- end _partials/form-fields.tpl -->
                            <!-- begin _partials/form-fields.tpl -->
                            <div class="form-group row ">
                                <label class="col-md-3 form-control-label required" for="field-password">
                                    Mot de passe
                                </label>
                                <div class="col-md-6">
                                    <div class="input-group js-parent-focus">
                                        <input class="form-control js-child-focus js-visible-password" name="password-wishlist"
                                            title="Au moins 5 caractères"
                                            aria-label="Saisie d'un mot de passe d'au moins 5 caractères" type="password"
                                            autocomplete="current-password" value="" required="">
                                        <span class="input-group-btn">
                                            <button class="btn" type="button" data-action="show-password"
                                                data-text-show="Montrer" data-text-hide="Cacher">
                                                Montrer
                                            </button>
                                        </span>
                                    </div>
                                </div>
                            </div>


                            <!-- end _partials/form-fields.tpl -->


                            <div class="mt-2 mb-2  text-center forgot-password">
                                <small>
                                    <a href="{$urls.pages.password}" rel="nofollow">
                                        {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
                                    </a>
                                </small>
                            </div>
                        </div>

                        {block name='login_form_footer'}
                            <footer class="form-footer text-sm-center clearfix text-right">
                                <input type="hidden" name="submitLogin" value="1">
                                {block name='form_buttons'}
                                    <button id="wish-login" name="submit-cafelogin" class="boutonstyle" data-action="sign-in"
                                        type="submit" class="form-control-submit">
                                        {l s='Sign in' d='Shop.Theme.Actions'}
                                    </button>
                                {/block}

                                <div class="mt-2 no-account"> <a href="/connexion?create_account=1"
                                        data-link-action="display-register-form"> Pas encore inscrit ? <span>Créez votre
                                            compte</span> </a></div>
                            </footer>
                        {/block}

                        <input type="hidden" name="submitLogin" value="1">
                        {* On se passe en planqué l'URL de retour après connexion *}
                        <input type="hidden" class="hidden" name="back" value="{$urls.current_url|escape:'htmlall':'UTF-8'}" />

                    {/block}
                </div>
            </div>
        </div>
    </div>



    <script>
        $(document).ready(function() {

            $('#wish-login').on('click', function() {
                // Get the values of email and password input fields
                var email = $('input[name="email-wishlist"]').val();
                var password = $('input[name="password-wishlist"]').val();
                var productId = $('input[name="modalProductId"]').val();
                var action = $(this).data('action');

                // AJAX request to handle the login action
                $.ajax({
                    type: 'POST',
                    url: "/modules/cafe_wishlist/ajax/login.php",
                    data: {
                        email: email,
                        password: password,
                        id_product: productId,
                        action: action
                    },
                    dataType: 'json',
                    success: function(response) {
                        // Handle the response here
                        console.log(
                        response); // Check the response object in the browser console
                        
                        console.log('success-3 modal');

                        var alertMessage = $('#wishMessage-' + response.id_product);

                        if (response.status === 'success3') {

                        alertMessage.html(
                            '<span  style="top: -15px;left: -45px;position: relative;" class="alert">Ajouté à wishlist !</span>'
                            );

                            // Perform actions for a successful login, e.g., refresh the page
                            $('#wish-' + response.id_product + ' i').removeClass(
                                'material-icons-outlined').addClass('material-icons').html(
                                'favorite');
                            $('#wish-' + response.id_product).data('action',
                            'removeWishlist'); // Update the data-action attribute
                            $('#loginModalWishProduct').modal('hide');
                            $('#loginModalWishProduct').hide();
                            $('.modal-backdrop').hide();

                            $('#loginModalWishProduct').remove();
                            $('body').removeClass('modal-open');


                            var button = $('#wishlistBtn');
                            // Get the content (i.e., the icon) of the button
                            var icon = button.html();

                            var url = "/module/cafe_wishlist/display?id_customer="+ response.id_customer;

                            // Create the anchor element with the icon and set its href attribute to the desired URL
                            var anchor = $('<a></a>', { href: url, class: 'btn', style: 'background: transparent; padding: 0;' }).html(icon);
                            // Replace the button with the newly created anchor element
                            button.replaceWith(anchor);

                           

                        } else if (response.status === 'success4') {
                            console.log('success-4 modal');

                        alertMessage.html(
                        '<span  style="top: -15px;left: -45px;position: relative;"  class="alert" role="alert">Retiré de wishlist !</span>'
                        );
                            // Perform actions for a successful login, e.g., refresh the page
                            $('#wish-' + response.id_product + ' i').removeClass(
                                'material-icons-outlined').addClass('material-icons').html(
                                'favorite');
                            $('#wish-' + response.id_product).data('action','removeWishlist'); // Update the data-action attribute
                            $('#loginModalWishProduct').modal('hide');
                            $('#loginModalWishProduct').hide();
                            $('.modal-backdrop').hide();
                            $('body').removeClass('modal-open');


                            


                        } else if (response.status === 'error') {
                            alertMessage.html(
                                '<span class="alert alert-danger" role="alert">Error</span>'
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


{/if}