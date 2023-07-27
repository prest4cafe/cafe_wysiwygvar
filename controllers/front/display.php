<?php



if (!defined('_PS_VERSION_')) {
    exit;
}


require_once(_PS_MODULE_DIR_ . 'cafe_wishlist/classes/CafeWishList.php');

use PrestaShop\PrestaShop\Core\Product\Search\ProductSearchContext;
use PrestaShop\PrestaShop\Core\Product\Search\ProductSearchQuery;
use PrestaShop\PrestaShop\Core\Product\Search\SortOrder;

class cafe_wishlistDisplayModuleFrontController extends ModuleFrontController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function initContent()
    {
        parent::initContent();


        // on veux toutes les produit en wishlist par id_customer
        $id_customer = $this->context->customer->id;

        $wishlist_products = CafeWishList::getAllProductsWishListByIdCustomer($id_customer);




        // Assuming you have an array of product IDs in $wishlistProductIds
        $wishlistProductIds = array_column($wishlist_products, 'id_product');

        $productsPerPage = 24; // Replace with the desired number of products per page
        $pageNumber = 1; // Replace with the current page number

        $wishlistResult = $this->getProducts($wishlistProductIds, $pageNumber, $productsPerPage);

        // Now you have an array $wishlistResult containing 'products' and 'pagination' information

        // Pass the products and pagination information to your template
        $this->context->smarty->assign('wishlist_products', $wishlistResult['products']);
        $this->context->smarty->assign('pagination', $wishlistResult['pagination']);

        // Pass the products and pagination information to your template if the template exists
        $templatePath = 'module:cafe_wishlist/views/templates/front/list.tpl';
        
        $this->context->smarty->assign('wishlist_products', $wishlistResult['products']);
        $this->context->smarty->assign('pagination', $wishlistResult['pagination']);
        
        $this->setTemplate($templatePath);
        
    }

    protected function getProducts(array $productIds, $pageNumber, $productsPerPage)
    {
        $totalProducts = count($productIds);
        $totalPages = ceil($totalProducts / $productsPerPage);

        $startIndex = ($pageNumber - 1) * $productsPerPage;
        $productIdsSlice = array_slice($productIds, $startIndex, $productsPerPage);

        $products_for_template = [];

        foreach ($productIdsSlice as $productId) {
            $product = new Product($productId, false, $this->context->language->id);
            if (Validate::isLoadedObject($product)) {
                $defaultAttributeId = $product->getDefaultIdProductAttribute();
                $specificPrice = is_array($product->specificPrice) ? $product->specificPrice : array();
                $coverImage = $this->getCoverImage($product, null);
                $hasDiscount = $product->getPriceWithoutReduct() < $product->getPrice();

                $url = $product->getLink();

                $products_for_template[] = array(
                    'id_manufacturer' => $product->id_manufacturer,
                    'id_product' => $product->id,
                    'id_product_attribute' => $defaultAttributeId,
                    'name' => $product->name,
                    'url' => $url,
                    'cover' => $coverImage,
                    'price' => $product->getPrice(true, $defaultAttributeId, 2),
                    'regular_price' => $product->getPrice(false, $defaultAttributeId, 2),
                    'has_discount' => $hasDiscount,
                    'discount_type' => isset($specificPrice['reduction_type']) ? $specificPrice['reduction_type'] : null,
                    'discount_percentage' => isset($specificPrice['reduction']) ? $specificPrice['reduction'] * 100 : null,
                    'discount_amount_to_display' => isset($specificPrice['reduction_type']) ? $product->getDiscountAmount($specificPrice['reduction_type'] === 'amount') : null,
                    'show_price' => true, // You can set this to your condition for showing/hiding prices
                );
            }
        }

        // Create an array with the 'products' and 'pagination' indexes
        $resultArray = array(
            'products' => $products_for_template,
            'pagination' => array(
                'total_products' => $totalProducts,
                'total_pages' => $totalPages,
                'current_page' => $pageNumber,
            ),
        );

        return $resultArray;
    }

    protected function getCoverImage(Product $product, $defaultAttributeId)
    {
        $cover = $product->getCover($product->id);
        $imageSize = 'home_default'; // Customize this image size as needed

        if (isset($cover['id_image']) && $cover['id_image'] > 0) {
            $image = new Image($cover['id_image']);
            return $this->context->link->getImageLink(
                $product->link_rewrite,
                $cover['id_image'],
                $imageSize
            );
        } else {
            // Use the default no-picture image URL with the chosen image size
            return '';
        }
    }


    protected function templateExists($templatePath)
    {
        return file_exists(_PS_THEME_DIR_ . 'modules/' . $templatePath);
    }

  

}
