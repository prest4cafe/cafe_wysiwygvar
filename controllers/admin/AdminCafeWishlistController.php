<?php

require_once(_PS_MODULE_DIR_ . 'cafe_wishlist/classes/CafeWishList.php');

class AdminCafeWishlistController extends ModuleAdminController
{
    public function __construct()
    {
        $this->bootstrap = true;
        $this->table = 'cafe_wishlist';
        $this->className = 'CafeWishList';
        $this->deleted = false;
        $this->list_no_link = true;
        $this->addRowAction('edit');
        $this->addRowAction('delete');

        $this->context = Context::getContext();

        $langId = $this->context->language->getId(); // Retrieve language ID from the context

        $this->required_database = false;
        $this->allow_export = true;
        $this->_use_found_rows = true;
        $this->_orderBy = 'id_cafe_wishlist';
        $this->_orderWay = 'DESC';
        $this->_select = ''; // Initialisez _select avant de l'utiliser
        // Jointure avec la table product_lang
        // Jointure avec la table manufacturer pour la marque
        $this->_join .= '
        LEFT JOIN `'._DB_PREFIX_.'product_lang` pl ON (a.`id_product` = pl.`id_product` AND pl.id_lang= '.$langId.') 
        LEFT JOIN `'._DB_PREFIX_.'customer` c ON (a.`id_customer` = c.`id_customer`)';
        $this->_select .= 'pl.`name` AS product_name,c.`firstname` AS firstname, c.`lastname` AS lastname,c.`email` AS email ';

        $this->fields_list = array(
            'id_customer' => array('title' => 'id_customer', 'search' => true,'class' => 'fixed-width-md'),
            'lastname' => array('title' => 'Nom', 'search' => true),
            //'telephone' => array('title' => 'Tel', 'search' => true,'class' => 'fixed-width-md'),
            'email' => array('title' => 'email', 'search' => true),
            'id_product' => array('title' => 'id_product', 'search' => true,'class' => 'fixed-width-md'),
            'product_name' => array('title' => 'Nom produit', 'search' => true,'class' => 'fixed-width-md'),
            'date_add' => array('title' => 'Date', 'search' => true,'class'=>'fixed-width-xxl'),

        );

        parent::__construct();
    }

    public function initContent()
    {
        parent::initContent();
    }

    public function renderForm()
    {
        if (!($obj = $this->loadObject(true))) {
            return;
        }

        $this->fields_form = array('legend' => array('title' => 'Product Wishlist', 'icon' => 'icon-user'),
                    'input' => array(
                            array(
                                'type' => 'text',
                                'label' => 'ID Customer:',
                                'name' => 'id_customer',
                                'required' => true,
                                'col' => '4'
                            ),
                            array(
                                'type' => 'text',
                                'label' => 'ID Product:',
                                'name' => 'id_product',
                                'required' => true,
                                'col' => '4'
                            ),
                           
                    ));

        $this->fields_form['submit'] = array('title' => $this->l('Save'),);



        return parent::renderForm();
    }

    public function initToolbarTitle()
    {
        parent::initToolbarTitle();
        switch ($this->display) {
            case '':
            case 'list':

                array_pop($this->toolbar_title);
                $this->toolbar_title[] = 'Gestion de la wishlist client';
                break;
            case 'view':

                if (($wishlist = $this->loadObject(true)) && Validate::isLoadedObject($wishlist)) {
                    $this->toolbar_title[] = sprintf('Editer wishlist');
                }
                break;
            case 'add':
            case 'edit':
                array_pop($this->toolbar_title);

                if (($wishlist = $this->loadObject(true)) && Validate::isLoadedObject($wishlist)) {
                    $this->toolbar_title[] = sprintf('Editer wishlist produits:');
                    $this->page_header_toolbar_btn['new_cafe_wishlist'] = array('href' => self::$currentIndex . '&addcafe_wishlist&token=' . $this->token,'desc' => $this->l('Ajouter wishlist produit', null, null, false),'icon' => 'process-icon-new');
                } else {
                    $this->toolbar_title[] = 'Editer une wishlist produit';
                }
                break;
        }
        array_pop($this->meta_title);
        if (count($this->toolbar_title) > 0) {
            $this->addMetaTitle($this->toolbar_title[count($this->toolbar_title) - 1]);
        }
    }

    public function initPageHeaderToolbar()
    {
        parent::initPageHeaderToolbar();

        if (empty($this->display)) {
            $this->page_header_toolbar_btn['new_cafe_wishlist'] = array('href' => self::$currentIndex . '&addcafe_wishlist&token=' . $this->token, 'desc' => $this->l('Ajouter une wishlist produit', null, null, false), 'icon' => 'process-icon-new');
        }
    }


   
}
