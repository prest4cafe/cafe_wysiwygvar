<?php

require_once(_PS_MODULE_DIR_ . 'cafe_wishlist/classes/CafeWishList.php');

class Cafe_WishlistSubmitAjaxCafeWishListModuleFrontController extends ModuleFrontController
{
    public $ajax = true;

    public function initContent()
    {
        parent::initContent();

        $response = array();

        // Check if the form was submitted
        $logged = $this->context->customer->isLogged();

        if ($logged === true) {
            // Retrieve the values of the "id_customer" and "id_product" parameters from the POST data
            $id_customer = (int) Tools::getValue('id_customer');
            $id_product = (int) Tools::getValue('id_product');
            // avant l'insert on veux savoir s'il n'y a pas une entrée similaire
            // Check if there is already an existing alert with the same parameters
            $existingWishlist = CafeWishList::exists(
                $id_customer,
                $id_product
            );

            $action = Tools::getValue('action');

            if (!$existingWishlist && $action == "addWishlist") {
                // Create a new alert if no similar alert exists
                $newWishlist = new CafeWishList();
                $newWishlist->id_customer = $id_customer;
                $newWishlist->id_product = $id_product;
                $newWishlist->add();
                // Set success response
                $response['status'] = 'success1';
                $response['id_product'] = $id_product;
            } elseif ($existingWishlist && $action == "removeWishlist") {
                $id_cafe_wishlist = CafeWishList::getIdWishList($id_customer, $id_product);
                $newWishlist = new CafeWishList((int) $id_cafe_wishlist);
                $newWishlist->delete();
                // Set error response
                $response['status'] = 'success2';
                $response['id_product'] = $id_product;
            }
        } else {
            // Set error response for not logged in users
            $response['status'] = 'error';
        }

        // Return JSON response
        header('Content-Type: application/json');
        die(json_encode($response));
    }
}
