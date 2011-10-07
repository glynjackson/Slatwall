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
<cfcomponent extends="BaseDAO">
	
	<cffunction name="getOrderReport" returntype="Query" access="public">
		<cfset var orderReport = "" />
		
		<cfif application.configBean.getDBType() eq "mysql">
			<cfquery name="orderReport">
				SELECT
					EXTRACT(DAY FROM SlatwallOrder.orderCloseDateTime) as 'Day',
					EXTRACT(MONTH FROM SlatwallOrder.orderCloseDateTime) as 'Month',
					EXTRACT(YEAR FROM SlatwallOrder.orderCloseDateTime) as 'Year',
					SUM(SlatwallOrderItem.price * SlatwallOrderItem.quantity) as 'SubtotalBeforeDiscounts',
					SUM(SlatwallTaxApplied.taxAmount) as 'TotalTax'
				FROM
					SlatwallOrder
				  INNER JOIN
				  	SlatwallOrderItem on SlatwallOrder.orderID = SlatwallOrderItem.orderID
				  LEFT JOIN
				  	SlatwallTaxApplied on SlatwallOrderItem.orderItemID = SlatwallTaxApplied.orderItemID
				WHERE
					SlatwallOrder.orderCloseDateTime is not null
				GROUP BY
					EXTRACT(DAY FROM SlatwallOrder.orderCloseDateTime),
					EXTRACT(MONTH FROM SlatwallOrder.orderCloseDateTime),
					EXTRACT(YEAR FROM SlatwallOrder.orderCloseDateTime)
				ORDER BY
					EXTRACT(YEAR FROM SlatwallOrder.orderCloseDateTime) asc,
					EXTRACT(MONTH FROM SlatwallOrder.orderCloseDateTime) asc,
					EXTRACT(DAY FROM SlatwallOrder.orderCloseDateTime) asc
			</cfquery>
		<cfelse>
			<cfquery name="orderReport">
				SELECT
					DATEPART(DD, SlatwallOrder.orderCloseDateTime) as 'Day',
					DATEPART(MM, SlatwallOrder.orderCloseDateTime) as 'Month',
					DATEPART(YY, SlatwallOrder.orderCloseDateTime) as 'Year',
					SUM(SlatwallOrderItem.price * SlatwallOrderItem.quantity) as 'SubtotalBeforeDiscounts',
					SUM(SlatwallTaxApplied.taxAmount) as 'TotalTax'
				FROM
					SlatwallOrder
				  INNER JOIN
				  	SlatwallOrderItem on SlatwallOrder.orderID = SlatwallOrderItem.orderID
				  LEFT JOIN
				  	SlatwallTaxApplied on SlatwallOrderItem.orderItemID = SlatwallTaxApplied.orderItemID
				WHERE
					SlatwallOrder.orderCloseDateTime is not null
				GROUP BY
					DATEPART(DD, SlatwallOrder.orderCloseDateTime),
					DATEPART(MM, SlatwallOrder.orderCloseDateTime),
					DATEPART(YY, SlatwallOrder.orderCloseDateTime)
				ORDER BY
					DATEPART(YY, SlatwallOrder.orderCloseDateTime) asc,
					DATEPART(MM, SlatwallOrder.orderCloseDateTime) asc,
					DATEPART(DD, SlatwallOrder.orderCloseDateTime) asc
			</cfquery>
		</cfif>
		
		<cfreturn orderReport />
	</cffunction>
		
</cfcomponent>
