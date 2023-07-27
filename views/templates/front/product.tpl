{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
 {block name='product_miniature_item'}
 <div id="id-{$product.id_product}" class="product col-xs-6 col-xl-4">
   <article class="product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
     <div class="thumbnail-container">
       <div class="thumbnail-top">
         {block name='product_thumbnail'}
           {if $product.cover}
             <a href="{$product.url}" class="thumbnail product-thumbnail">
               <img
                 src="{$product.cover}"
                 alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                 loading="lazy"
                 data-full-size-image-url="{$product.cover}"
                
               />
             </a>
           {else}
           
           {/if}
         {/block}
 
       
       </div>
 
       <div class="product-description">
         {block name='product_name'}
          <div class="wishlist-product-brand">{Manufacturer::getnamebyid($product.id_manufacturer)}</div>

          <h2 class="pdt_hasbrand h3 product-title"><a href="{$product.url}" content="{$product.url}">{$product.name}</a></h2>
         {/block}
 
         {block name='product_price_and_shipping'}
           {if $product.show_price}
             <div class="product-price-and-shipping">
               {if $product.has_discount}
                 {hook h='displayProductPriceBlock' product=$product type="old_price"}
 
                 <span class="regular-price" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
                 {if $product.discount_type === 'percentage'}
                   <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
                 {elseif $product.discount_type === 'amount'}
                   <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
                 {/if}
               {/if}
 
               {hook h='displayProductPriceBlock' product=$product type="before_price"}
 
               <span class="price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                 {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='products_list'}{/capture}
                 {if '' !== $smarty.capture.custom_price}
                   {$smarty.capture.custom_price nofilter}
                 {else}
                  {Product::convertandformatPrice($product.regular_price)}

                 {/if}
               </span>
 
             </div>
           {/if}
         {/block}
 
        
       </div>
       {block name='product_reviews'}
        {hook h='displayProductListReviews' product=$product}
      {/block}
     </div>
   </article>
 </div>
 {/block}
 