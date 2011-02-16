<cfparam name="rc.productTypes" default="#rc.Product.getProductTypeTree()#" />
<cfset local.skus = rc.Product.getSkus() />

<cfoutput>
<form name="CreateProduct" action="?action=admin:product.createproduct" method="post">

	<!--- <div class="ItemDetailImage"><img src="http://www.nytro.com/prodimages/#rc.Product.getDefaultImageID()#-DEFAULT-s.jpg"></div> --->
	<div class="ItemDetailMain">
	<dl class="twoColumn">
		<cf_PropertyDisplay object="#rc.Product#" property="active" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="productName" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="productCode" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="productYear" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="brand" edit="true">
	<!---<cf_PropertyDisplay object="#rc.Product#" property="productType" edit="true">--->
        <dt>
            <label for="productType_productTypeID">Product Type:</label></dt>
        <dd>
            <select name="productType_productTypeID" id="productType_productTypeID">
                <option value="">None</option>
            <cfloop query="rc.productTypes">
                <cfset ThisDepth = rc.productTypes.TreeDepth />
                <cfif ThisDepth><cfset bullet="-"><cfelse><cfset bullet=""></cfif>
                <option value="#rc.productTypes.productTypeID#"<cfif !isNull(rc.product.getProductType()) AND rc.product.getProductType().getProductTypeID() EQ rc.productTypes.productTypeID> selected="selected"</cfif>>
                    #RepeatString("&nbsp;&nbsp;&nbsp;",ThisDepth)##bullet##rc.productTypes.productType#
                </option>
            </cfloop>
            </select>
        </dd>
		<cf_PropertyDisplay object="#rc.Product#" property="filename" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="shippingWeight" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="publishedWeight" edit="true">
	</dl>
	</div>
	
	<div class="ItemDetailBar">
	<dl class="twoColumn">
		<cf_PropertyDisplay object="#rc.Product#" property="showonWebRetail" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="showonWebWholesale" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="manufactureDiscontinued" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="allowPreorder" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="allowBackorder" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="allowDropship" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="nonInventoryItem" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="callToOrder" edit="true">
		<cf_PropertyDisplay object="#rc.Product#" property="allowShipping" edit="true">
	</dl>
	</div>
	
<div class="tabs initActiveTab ui-tabs ui-widget ui-widget-content ui-corner-all">
	<ul>
	<li><a href="##tabSkus" onclick="return false;"><span>SKUs</span></a></li>	
	<li><a href="##tabDescription" onclick="return false;"><span>Web Description</span></a></li>
	<li><a href="##tabCategories" onclick="return false;"><span>Categories</span></a></li>
	<li><a href="##tabDiscounts" onclick="return false;"><span>Discounts</span></a></li>
	<li><a href="##tabReviews" onclick="return false;"><span>Reviews</span></a></li>
	<li><a href="##tabExtendedAttributes" onclick="return false;"><span>Extended Attributes</span></a></li>
	<li><a href="##tabAltImages" onclick="return false;"><span>Alternate Images</span></a></li>
	</ul>

	<div id="tabSkus">
		
        <input type="button" class="button" id="addSKU" value="Add SKU" />

<!---		<cfif arrayLen(local.skus)>--->
			<table id="skuTable">
				<thead>
				<tr>
					<th>Company SKU</th>
					<th>Original Price</th>
					<th>List Price</th>
					<th>QOH</th>
					<th>QOO</th>
					<th>QC</th>
					<th>QIA</th>
					<th>QEA</th>
					<th>Image Path</th>
					<th>Admin</th>
				</tr>
				</thead>
				<tbody>
			<cfset local.arrayIndex = 1 />
				<cfloop array="#local.skus#" index="local.thisItem">
				<tr<cfif local.rowcounter mod 2 eq 1> class="alt"</cfif>>			
					<td><input type="text" name="SKU#local.arrayIndex#_SKUID" id="SKU#local.arrayIndex#_SKUID" value="#local.thisItem.getSkuID()#" /></td>
					<td><input type="text" name="SKU#local.arrayIndex#_originalPrice" id="SKU#local.arrayIndex#_originalPrice" value="#local.thisItem.getOriginalPrice()#" /></td>
					<td><input type="text" name="SKU#local.arrayIndex#_listPrice" id="SKU#local.arrayIndex#_listPrice" value="#local.thisItem.getListPrice()#" /></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<cfset local.arrayIndex++ />
				</cfloop>
			</tbody>
			</table>
<!---		<cfelse>
			<p>There are no SKU's for this product.</p>
		</cfif>--->
	</div>
	
	<div id="tabDescription">
		<cf_PropertyDisplay object="#rc.Product#" property="ProductDescription" edit="true" editType="wysiwyg">
	</div>
	<div id="tabCategories">
	   
	</div>
	<div id="tabDiscounts">
	
	</div>
	<div id="tabReviews">
	
	</div>
	<div id="tabExtendedAttributes">
	
	</div>
	<div id="tabAltImages">
	
	</div>

</div>

<button type="submit">Save</button>
</form>

</cfoutput>
<table id="tableTemplate" class="hideElement">
<tbody>
<tr>
	<td><input type="text" name="" id="" value="" /></td>
	<td><input type="text" name="" id="" value="" /></td>
	<td><input type="text" name="" id="" value="" /></td>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
</tr>
</tbody>
</table>