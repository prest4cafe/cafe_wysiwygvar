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
                <div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    {block name='login_form'}
                        <div id="login-form-wishlist">

                            <div class="mb-2 text-center no-account">
                                <span>Déjà client ? <br />Merci de vous
                                    connecter à votre compte...</span>
                            </div>

                            <div class="form-group row ">
                                <label class="col-md-3 form-control-label required" for="field-email">
                                    E-mail <sup>*</sup>
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
                                    Mot de passe <sup>*</sup>
                                </label>
                                <div class="col-md-6">
                                    <div class="input-group js-parent-focus">
                                        <input class="form-control js-child-focus js-visible-password" name="password-wishlist"
                                            title="Au moins 5 caractères"
                                            aria-label="Saisie d'un mot de passe d'au moins 5 caractères" type="password"
                                            autocomplete="current-password" value="" required="">
                                        <span class="input-group-btn">
                                        <button class="btn" type="button"  data-action="show-password">
                                        <i class='material-icons'>visibility</i> </button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <!-- end _partials/form-fields.tpl -->
                            <div class="mt-2 mb-2 text-center forgot-password">
                                <div class="mt-2 mb-2 text-center">
                                    <small>
                                        <a href="{$urls.pages.password}" rel="nofollow">
                                            {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
                                        </a>
                                    </small>
                                </div>
                                <input type="hidden" name="submitLogin" value="1">
                                {block name='form_buttons'}
                                    <div id="wishMessageModalSignIn"></div>

                                    <button id="wish-login" name="submit-cafelogin" class="boutonstyle" data-action="sign-in"
                                        type="submit" class="form-control-submit">
                                        {l s='Sign in' d='Shop.Theme.Actions'}
                                    </button>
                                {/block}
                            </div>
                        </div>

                        {block name='login_form_footer'}
                            <footer class="form-footer text-sm-center clearfix text-right">

                                <div class="mt-2 no-account">
                                    <span style="cursor:pointer;" id="showRegisterForm" data-link-action="display-register-form">Pas
                                        encore inscrit ? Rejoindre notre communauté</span>
                                </div>
                                <!-- The register form content, set initially as display: none -->
                                <div class="mt-2" id="registerFormContent" style="display: none;">
                                    <!-- Your register form HTML content goes here -->
                                    <!-- Replace the following placeholder content with your actual register form -->

                                    <div class="form-group row "> <label class="col-md-3 form-control-label required"
                                            for="field-lastname"> Votre nom <sup>*</sup></label>
                                        <div class="col-md-8">
                                            <input class="form-control" id="field-lastname" name="register-lastname-wishlist"
                                                type="text" value="" required="">
                                        </div>
                                    </div>

                                    <div class="form-group row "> <label class="col-md-3 form-control-label required"
                                            for="field-firstname"> Votre prénom <sup>*</sup></label>
                                        <div class="col-md-8">
                                            <input class="form-control" id="field-firstname" name="register-firstname-wishlist"
                                                type="text" value="" required="">
                                        </div>
                                    </div>

                                    <div class="form-group row "> <label class="col-md-3 form-control-label required"
                                            for="field-email"> Votre e-mail <sup>*</sup></label>
                                        <div class="col-md-8">
                                            <input class="form-control" name="register-email-wishlist" type="email" value=""
                                                required="">
                                        </div>
                                        <input type="hidden" name="modalProductId" value="">
                                    </div>
                                    <div class="form-group row "> <label class="col-md-3 form-control-label required"
                                            for="field-password"> Choisir un mot de passe <sup>*</sup></label>
                                        <div class="col-md-6">
                                            <div class="input-group js-parent-focus"> <input
                                                    class="form-control js-child-focus js-visible-password"
                                                    name="register-password-wishlist" title="Au moins 5 caractères"
                                                    aria-label="Saisie d'un mot de passe d'au moins 5 caractères" type="password"
                                                    autocomplete="current-password" value="" required=""> <span
                                                    class="input-group-btn"> <button class="btn" type="button"  data-action="show-password">
                                                    <i class='material-icons'>visibility</i> </button>
                                                </span></div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <div id="wishMessageModal"></div>
                                        <button id="wish-register" name="submit-register-whislist" class="boutonstyle"
                                            data-action="register-wishlist" type="submit" class="form-control-submit">
                                            {l s='S\'inscrire' d='Shop.Theme.Actions'}
                                        </button>
                                    </div>
                                </div>
                            </footer>
                        {/block}


                    {/block}
                </div>
            </div>
        </div>
    </div>



    <script>
        $(document).ready(function() {

            $('#showRegisterForm').on('click', function(event) {
                event.preventDefault(); // Prevent the default link behavior
                //$('#login-form-wishlist').hide();
                // Toggle the display of the register form content
                $('#registerFormContent').toggle();
                // Show the modal
                $('#loginModalWish').modal('show');
            });

            $('#wish-register').on('click', function() {
                // Get the values of email and password input fields

                var lastname = $('input[name="register-lastname-wishlist"]').val();
                var firstname = $('input[name="register-firstname-wishlist"]').val();

                var email = $('input[name="register-email-wishlist"]').val();
                var password = $('input[name="register-password-wishlist"]').val();
                var productId = $('input[name="modalProductId"]').val();


                // AJAX request to handle the login action
                $.ajax({
                    type: 'POST',
                    url: "/modules/cafe_wishlist/ajax/register.php",
                    data: {
                        lastname: lastname,
                        firstname: firstname,
                        email: email,
                        password: password,
                        id_product: productId,
                    },
                    dataType: 'json',
                    success: function(response) {
                        // Handle the response here
                        console.log(
                        response); // Check the response object in the browser console

                        var alertMessage = $('#wishMessage-' + response.id_product);
                        var alertMessageModal = $('#wishMessageModal');

                        if (response.status === 'success3') {
                            console.log('success-3 modal-lit');

                            alertMessage.html(
                                '<span>Ajouté à wishlist !</span>'
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

                            var url = "/module/cafe_wishlist/display?id_customer=" + response
                                .id_customer;

                            // Create the anchor element with the icon and set its href attribute to the desired URL
                            var anchor = $('<a></a>', {
                                href: url,
                                class: 'btn',
                                style: 'background: transparent; padding: 0;'
                            }).html(icon);
                            // Replace the button with the newly created anchor element
                            button.replaceWith(anchor);


                        } else if (response.status === 'success4') {

                            alertMessage.html(
                                '<span class="alert" role="alert">Retiré de wishlist !</span>'
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
                            var url = "/module/cafe_wishlist/display?id_customer=" + response
                                .id_customer;
                            // Create the anchor element with the icon and set its href attribute to the desired URL
                            var anchor = $('<a></a>', {
                                href: url,
                                class: 'btn',
                                style: 'background: transparent; padding: 0;'
                            }).html(icon);
                            // Replace the button with the newly created anchor element
                            button.replaceWith(anchor);

                        } else if (response.status === 'error') {
                            alertMessageModal.html(
                                '<div class="mt-1 mb-2 alert alert-danger" role="alert"> ' +
                                response.error + '</div>'
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

            $('#wish-login').on('click', function() {

                var email = $('input[name="email-wishlist"]').val();
                var password = $('input[name="password-wishlist"]').val();
                var productId = $('input[name="modalProductId"]').val();
                var action = $(this).data('action');

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

                        var alertMessage = $('#wishMessage-' + response.id_product);
                        var alertMessageModalSignIn = $('#wishMessageModalSignIn');

                        if (response.status === 'success3') {

                            alertMessage.html('<span class="alert">Ajouté à wishlist !</span>');
                            $('#wish-' + response.id_product + ' i').removeClass(
                                'material-icons-outlined').addClass('material-icons').html(
                                'favorite');
                            $('#wish-' + response.id_product).data('action', 'removeWishlist');
                            $('#loginModalWishProduct').modal('hide');
                            $('#loginModalWishProduct').hide();
                            $('.modal-backdrop').hide();
                            $('#loginModalWishProduct').remove();
                            $('body').removeClass('modal-open');

                            var button = $('#wishlistBtn');
                            var icon = button.html();
                            var url = "/module/cafe_wishlist/display?id_customer=" + response
                                .id_customer;
                            var anchor = $('<a></a>', { href: url, class: 'btn',
                                style: 'background: transparent; padding: 0;' }).html(icon);
                            button.replaceWith(anchor);


                        } else if (response.status === 'success4') {
                            alertMessage.html(
                                '<span class="alert" role="alert">Retiré de wishlist !</span>'
                            );
                            $('#wish-' + response.id_product + ' i').removeClass(
                                'material-icons-outlined').addClass('material-icons').html(
                                'favorite');
                            $('#wish-' + response.id_product).data('action', 'removeWishlist');
                            $('#loginModalWishProduct').modal('hide');
                            $('#loginModalWishProduct').hide();
                            $('.modal-backdrop').hide();
                            $('body').removeClass('modal-open');

                        } else if (response.status === 'error') {

                            alertMessageModalSignIn.html(
                                '<div class="mb-2 mt-1 alert alert-danger" role="alert">' +
                                response.error + '</div>'
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


        $(document).ready(function() {
            $('.btn').click(function() {
                const button = $(this);
                const action = button.data('action');
                const icon = button.find('i');

                if (action === 'show-password') {
                    // Toggle visibility icon
                    const currentIcon = icon.text();
                    const showIcon = 'visibility_off';
                    const hideIcon = 'visibility';

                    if (currentIcon === showIcon) {
                        icon.text(hideIcon);
                    } else {
                        icon.text(showIcon);
                    }

                    // Toggle password visibility (Implement your logic here)
                    togglePasswordVisibility();
                }
            });
        });

        function togglePasswordVisibility() {
            // Implement your logic to toggle password visibility
            // For example, you can use jQuery to add/remove "password" attribute on input fields.
            const passwordInput = $('#password-input');
            if (passwordInput.attr('type') === 'password') {
                passwordInput.attr('type', 'text');
            } else {
                passwordInput.attr('type', 'password');
            }
        }
    </script>


{/if}