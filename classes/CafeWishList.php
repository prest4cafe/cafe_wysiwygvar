<?php

use Symfony\Component\Filesystem\Exception\IOException;
use Symfony\Component\Filesystem\Filesystem;

if (!defined('_PS_VERSION_')) {
    exit;
}

class CafeWishList extends ObjectModel
{
    public $id_cafe_wishlist;
    public $id_customer;
    public $id_product;
    public $date_add;
    public $date_upd;

    public static $definition = [
        'table' => 'cafe_wishlist',
        'primary' => 'id_cafe_wishlist',
        'fields' => [
            'id_cafe_wishlist' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'length' => 10],
            'id_customer' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'length' => 10],
            'id_product' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'length' => 10],
            'date_add' => ['type' => self::TYPE_DATE, 'validate' => 'isDate'],
            'date_upd' => ['type' => self::TYPE_DATE,'validate' => 'isDate'],
        ]
    ];

    public function __construct($id = null, $id_lang = null, $id_shop = null)
    {
        parent::__construct($id, $id_lang, $id_shop);
    }

    public function add($autodate = true, $null_values = true)
    {
        $success = parent::add($autodate, $null_values);
        return $success;
    }

    public function update($nullValues = false)
    {
        return parent::update(true);
    }

    public function delete()
    {
        return parent::delete();
    }

    public static function installSql(): bool
    {
        try {
            $createTable = Db::getInstance()->execute(
                "CREATE TABLE IF NOT EXISTS `"._DB_PREFIX_."cafe_wishlist`(
                `id_cafe_wishlist` int(10)  NOT NULL AUTO_INCREMENT,
                `id_customer` int(10)  NOT NULL,
                `id_product` int(10)  NOT NULL,
                `date_add` datetime NOT NULL,
                `date_upd` datetime NOT NULL,
                PRIMARY KEY (`id_cafe_wishlist`)
                ) ENGINE=InnoDB DEFAULT CHARSET=UTF8;"
            );
        } catch (PrestaShopException $e) {
            return false;
        }

        return $createTable;
    }

    public static function uninstallSql()
    {
        return Db::getInstance()->execute("DROP TABLE IF EXISTS "._DB_PREFIX_."cafe_wishlist");
    }

    public static function getAllProductsWishListByIdCustomer($id_customer)
    {

        // Define the SQL query to get all product alerts for the given customer ID
        $sql = "SELECT id_product 
                FROM "._DB_PREFIX_."cafe_wishlist
                WHERE id_customer = ".(int)$id_customer. '
                AND id_customer > 0' ;

        // Execute the SQL query and return the result
        return Db::getInstance()->executeS($sql);
    }


    public static function exists($id_customer, $id_product)
    {
        $sql = 'SELECT COUNT(*) FROM ' . _DB_PREFIX_ . 'cafe_wishlist
                WHERE id_customer = ' . (int) $id_customer . '
                AND id_product = ' . (int) $id_product . '
                AND id_customer > 0' ;

        $count = (int) Db::getInstance()->getValue($sql);

        return ($count > 0);
    }

    public static function getIdWishList($id_customer, $id_product)
    {
        $sql = "SELECT id_cafe_wishlist
        FROM "._DB_PREFIX_."cafe_wishlist
        WHERE id_customer = ".(int)$id_customer."
        AND id_product = ".(int)$id_product."
        ";

        // Execute the SQL query and return the result
        return Db::getInstance()->getValue($sql);

    }



}
