{extends file='customer/page.tpl'}


{$page.body_classes['page-customer-account'] = true}

{block name="page_title"}
    {l s="Ma wishlist" d="Modules.cafe_wishlist.list"}
{/block}
{block name="page_content"}

    {include file='module:cafe_wishlist/views/templates/hook/jquery.tpl'}

    <section class="my-wishlist">

        <div class="clearfix"></div>

        <h1>{l s="Ma wishlist" d="Modules.cafe_wishlist.list"}</h1>


        {if $wishlist_products}
            <div class="products row">
                {foreach from=$wishlist_products item=product}
                        {include file='module:cafe_wishlist/views/templates/front/product.tpl' product=$product}
                        
                {/foreach}
                </div>
            {if $pagination.total_pages > 1}
                <div class="pagination">
                    {for $i=1 to $pagination.total_pages}
                        <a href="?page={$i}"{if $pagination.current_page == $i} class="current"{/if}>{$i}</a>
                    {/for}
                </div>
            {/if}
        
        {else}
            <p>No products in your wishlist.</p>
        {/if}
        
       
{/block}
