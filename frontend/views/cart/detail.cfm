<!---

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

--->
<cfoutput>
	<div class="svocartdetail">
		<form name="updateCart" method="post">
			<input type="hidden" name="slatAction" value="frontend:cart.update" />
		<cfif not arrayLen($.slatwall.cart().getOrderItems())>
			<p class="noitems">#$.slatwall.rbKey('frontend.cart.detail.noitems')#</p>
		<cfelse>
			<div class="orderItems">
				<cfloop array="#$.slatwall.cart().getOrderItems()#" index="local.orderItem">
					<dl class="orderItem">
						<dt class="image">#local.orderItem.getSku().getImage(size="small")#</dt>
						<dt class="title"><a href="#local.orderItem.getSku().getProduct().getProductURL()#" title="#local.orderItem.getSku().getProduct().getTitle()#">#local.orderItem.getSku().getProduct().getTitle()#</a></dt>
						<dd class="options">#local.orderItem.getSku().displayOptions()#</dd>
						<dd class="customizations">#local.orderItem.displayCustomizations()#</dd>
						<dd class="price">#DollarFormat(local.orderItem.getPrice())#</dd>
						<dd class="quantity"><input name="orderItem.#local.orderItem.getOrderItemID()#.quantity" value="#NumberFormat(local.orderItem.getQuantity(),"0")#" size="3" /></dd>
						<cfif local.orderItem.getDiscountAmount()>
							<dd class="extended">#DollarFormat(local.orderItem.getExtendedPrice())#</dd>
							<dd class="discount">- #DollarFormat(local.orderItem.getDiscountAmount())#</dd>
							<dd class="extendedAfterDiscount">#DollarFormat(local.orderItem.getExtendedPriceAfterDiscount())#</dd>
						<cfelse>
							<dd class="extendedAfterDiscount">#DollarFormat(local.orderItem.getExtendedPriceAfterDiscount())#</dd>
						</cfif>
					</dl>
				</cfloop>
				<dl class="totals">
					<dt class="subtotal">Subtotal</dt>
					<dd class="subtotal">#DollarFormat($.slatwall.cart().getSubtotal())#</dd>
					<dt class="shipping">Delivery</dt>
					<dd class="shipping">#DollarFormat($.slatwall.cart().getFulfillmentTotal())#</dd>
					<dt class="tax">Tax</dt>
					<dd class="tax">#DollarFormat($.slatwall.cart().getTaxTotal())#</dd>
					<cfif $.slatwall.cart().getDiscountTotal() gt 0>
						<dt class="discount">Discount</dt>
						<dd class="discount">- #DollarFormat($.slatwall.cart().getDiscountTotal())#</dd>
					</cfif>
					<dt class="total">Total</dt>
					<dd class="total">#DollarFormat($.slatwall.cart().getTotal())#</dd>
				</dl>
			</div>
			<div class="actionButtons">
				<a href="#$.createHREF(filename='shopping-cart', querystring='slatAction=frontend:cart.clearCart')#" title="Clear Cart" class="frontendcartdetail clearCart button">Clear Cart</a>
				<a href="#$.createHREF(filename='shopping-cart')#" title="Update Cart" class="frontendcartdetail updateCart button">Update Cart</a>
				<a href="#$.createHREF(filename='checkout')#" title="Checkout" class="frontendcheckoutdetail checkout button">Checkout</a>
			</div>
		</cfif>
		</form>
		<script type="text/javascript">
			jQuery(document).ready(function(){
				jQuery('div.actionButtons a.updateCart').click(function(e){
					e.preventDefault();
					jQuery('form[name="updateCart"]').submit();
				});
			});
		</script>
		#view("frontend:cart/promotioncode")#
	</div>
</cfoutput>
