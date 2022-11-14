<?php
/**
* 2007-2022 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2022 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class cafe_wysiwygvar extends Module
{
    public function __construct()
    {
        $this->name = 'cafe_wysiwygvar';
        $this->tab = 'administration';
        $this->version = '1.0.0';
        $this->author = 'presta.cafe';
        $this->need_instance = 0;
        $this->bootstrap = true;
        parent::__construct();
        $this->displayName = $this->l('cafe_wysiwygvar');
        $this->description = $this->l('Allow you to manage and put variables on wysiwyg content');
        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);
    }

    public function install()
    {
        return parent::install() &&
        $this->registerHook('filterProductContent');
    }

    public function uninstall()
    {
        return parent::uninstall();
    }

    public function getContent()
    {
        $this->context->smarty->assign('module_dir', $this->_path);
        $output = $this->context->smarty->fetch($this->local_path.'views/templates/admin/configure.tpl');
        return $output;
    }

    public function hookFilterProductContent(array $params)
    {
        $params['object']['description'] = $this->_updateContentVars($params['object']['description'], $params);
        $params['object']['description_short'] = $this->_updateContentVars($params['object']['description_short'], $params);

        return [
            'object' => $params['object']
        ];
    }

    protected function _updateContentVars($content, $params)
    {
        $page = Dispatcher::getInstance()->getController();

        if ($page == 'product') {
            foreach ($params['object']['features'] as $feat) {
                $content = urldecode($content);

                preg_match_all('#{{var feature='.$feat['name'].'}}#i', $content, $vars);
                if (isset($vars) && sizeof($vars)) {
                    foreach ($vars as $key => $var) {
                        if (isset($var) && sizeof($var)) {
                            $feature='{{var feature='.$feat['name'].'}}';
                            if ($feature == $var[0]) {
                                $value = $feat['value'];
                                $content = preg_replace('#{{var feature=' . $feat['name'] . '}}#', $value, $content);
                            }
                        }
                    }
                }
            }

            return $content;
        }
    }
}
