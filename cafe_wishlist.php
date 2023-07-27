<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

require_once __DIR__ . '/classes/CafeWishList.php';

class cafe_wishlist extends Module
{
    public function __construct()
    {
        $this->name = 'cafe_wishlist';
        $this->tab = 'others';
        $this->version = '1.0.0';
        $this->author = 'Alexandre Carette';
        $this->need_instance = 0;
        $this->bootstrap = true;
        parent::__construct();
        $this->displayName = $this->l('cafe_wishlist');
        $this->description = $this->l('Allow to add a wishlist functionnality');
        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);
    }

    public function install()
    {
        $tab = new Tab();
        foreach (Language::getLanguages() as $language) {
            $tab->name[$language['id_lang']] = 'Wishlist Produit';
        }
        $tab->class_name = 'AdminCafeWishlist';
        $tab->module = $this->name;
        $idParent = (int)Tab::getIdFromClassName('AdminCatalog');
        $tab->id_parent = $idParent;
        $tab->position = Tab::getNbTabs($idParent);

        if (!$tab->save()) {
            return false;
        }

        if (!parent::install()
        || !$this->registerHook([
            'moduleRoutes',
            'displayCafeWishlist',
            'displayBeforeBodyClosingTag',
            'displayCustomerAccount',
            'displayProductListReviews',
            'displayHeader',
            'displayNav2'
        ])
        || !CafeWishList::installSql()
        ) {
            return false;
        }
        return true;
    }

    public function uninstall()
    {
        if (
            !parent::uninstall()
            || !CafeWishList::uninstallSql()
        ) {
            return false;
        }
        return true;
    }


    public function hookModuleRoutes()
    {
        return [
            'module-cafe-wishlist-display' => [
                'controller' => 'display',
                'rule' => 'wishlist/{id_customer}',
                'keywords' => [
                    'id_customer' => [
                        'regexp' => '[0-9]+',
                        'param' => 'id_customer',
                    ],
                ],
                'params' => [
                    'fc' => 'module',
                    'module' => 'cafe_wishlist',
                ],
            ],
        ];
    }

    /**
    * Display additional information inside the "my account" block
    *
    * @param array $params
    *
    * @return string
    */
    public function hookDisplayCustomerAccount(array $params)
    {
        // Récupérez l'ID du client connecté
        $id_customer = $this->context->customer->id;

        // Créez l'URL en ajoutant le paramètre id_customer
        $url = $this->context->link->getModuleLink('cafe_wishlist', 'display', array('id_customer' => $id_customer));

        $this->smarty->assign([
            'url' => $url,
        ]);

        return $this->fetch('module:cafe_wishlist/views/templates/hook/myaccount-block.tpl');
    }

    public function hookDisplayNav2(array $params)
    {
        // Récupérez l'ID du client connecté
        $id_customer = $this->context->customer->id;
        // Créez l'URL en ajoutant le paramètre id_customer
        $url = $this->context->link->getModuleLink('cafe_wishlist', 'display', array('id_customer' => $id_customer));
        $isCustomerLoggedIn = $this->context->customer->isLogged();
        $this->smarty->assign([
            'isCustomerLoggedIn' => $isCustomerLoggedIn,
            'url' => $url,
            'id_customer' => $id_customer,
        ]);

        return $this->fetch('module:cafe_wishlist/views/templates/hook/nav-block.tpl');
    }

    public function hookDisplayBeforeBodyClosingTag(array $params)
    {

        $_controller = $this->context->controller;


        if (isset($_controller->php_self) && $_controller->php_self == "product") {

            $isCustomerLoggedIn = $this->context->customer->isLogged();

            $id_product = Tools::getValue('id_product');

            $id_customer = $this->context->customer->id;

            $ifExist = CafeWishList::exists($id_customer, $id_product);

            $this->context->smarty->assign(
                array(
                    'isCustomerLoggedIn' => $isCustomerLoggedIn,
                    'id_product' => $id_product,
                    'id_customer' => $id_customer,
                )
            );

            if (!$ifExist) {
                
                return $this->context->smarty->fetch('module:cafe_wishlist/views/templates/hook/modal-product.tpl');
            }
        }

        if (isset($_controller->php_self) && $_controller->php_self == "category") {

            $isCustomerLoggedIn = $this->context->customer->isLogged();

            $id_customer = $this->context->customer->id;

            $this->context->smarty->assign(
                array(
                    'isCustomerLoggedIn' => $isCustomerLoggedIn,
                    'id_customer' => $id_customer,
                )
            );

            return $this->context->smarty->fetch('module:cafe_wishlist/views/templates/hook/modal-list.tpl');

        }


        $isCustomerLoggedIn = $this->context->customer->isLogged();

        $this->context->smarty->assign(
            array(
                'isCustomerLoggedIn' => $isCustomerLoggedIn,
            )
        );

        

        return $this->context->smarty->fetch('module:cafe_wishlist/views/templates/hook/modal-list.tpl');
    }


    // Fiche Produit
    public function hookDisplayCafeWishlist()
    {

        $ifExist = CafeWishList::exists($this->context->customer->id, Tools::getValue('id_product'));

        $this->context->smarty->assign(
            array(
                'id_product' => Tools::getValue('id_product'),
                'id_customer' => $this->context->customer->id,
                'ifExist' => $ifExist,
            )
        );
        // Render the template and assign it to a variable
        $output = $this->context->smarty->fetch('module:cafe_wishlist/views/templates/hook/wishlist_button.tpl');
        // Return the output to be displayed
        return $output;
    }

    // Listing Produits
    public function hookDisplayProductListReviews(array $params)
    {

        $productId = $params['product']['id_product'];

        $ifExist = CafeWishList::exists($this->context->customer->id, $productId);

        $this->context->smarty->assign(
            array(
                'id_product' => $productId,
                'id_customer' => $this->context->customer->id,
                'ifExist' => $ifExist,
            )
        );
        // Clear the cache for the template
        $cacheId = $this->context->smarty->getTemplateVars('list_wishlist_button.tpl');

        $this->context->smarty->clearCompiledTemplate('module:cafe_wishlist/views/templates/hook/list_wishlist_button.tpl');


        if ($cacheId !== null) {
            $this->context->smarty->clearCache('module:cafe_wishlist/views/templates/hook/list_wishlist_button.tpl', $cacheId);
        }



        // Render the template and assign it to a variable
        $output = $this->context->smarty->fetch('module:cafe_wishlist/views/templates/hook/list_wishlist_button.tpl');

        // Return the output to be displayed
        return $output;
    }

    public function hookDisplayHeader($params)
    {
        $_controller = $this->context->controller;

        

        if ($_controller->php_self == 'category' || $_controller->php_self == 'index' || $_controller->page_name == 'module-cafe_wishlist-display') {
            

            $this->context->controller->addCSS(__DIR__.'/views/assets/css/cafe_wishlist-category.css?v=1', 'all');

            $output = $this->context->smarty->fetch('module:cafe_wishlist/views/templates/hook/jquery.tpl');

            // Render the template and assign it to a variable
            // Return the output to be displayed

            return $output;
            
        } elseif ($_controller->php_self == 'product') {
            
            $this->context->controller->addCSS(__DIR__.'/views/assets/css/cafe_wishlist-product.css?v=1', 'all');

             // Render the template and assign it to a variable
             $output = $this->context->smarty->fetch('module:cafe_wishlist/views/templates/hook/jquery.tpl');
             // Return the output to be displayed
             return $output;
        }

        $this->context->controller->addCSS(__DIR__.'/views/assets/css/cafe_wishlist-header.css?v=1', 'all');



    }

}
