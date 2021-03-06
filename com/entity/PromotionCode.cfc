/*

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

*/
component displayname="Promotion Code" entityname="SlatwallPromotionCode" table="SlatwallPromotionCode" persistent="true" extends="BaseEntity" {
	
	// Persistent Properties
	property name="promotionCodeID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="promotionCode" validateRequired="true" ormtype="string";
	property name="startDateTime" validateDate="true" ormtype="timestamp";
	property name="endDateTime" validateDate="true" ormtype="timestamp";
	
	// Related Entities
	property name="promotion" cfc="Promotion" fieldtype="many-to-one" fkcolumn="promotionID";
	
	// Audit properties
	property name="createdDateTime" ormtype="timestamp";
	property name="createdByAccount" cfc="Account" fieldtype="many-to-one" fkcolumn="createdByAccountID" constrained="false";
	property name="modifiedDateTime" ormtype="timestamp";
	property name="modifiedByAccount" cfc="Account" fieldtype="many-to-one" fkcolumn="modifiedByAccountID" constrained="false";
	

	/******* Association management methods for bidirectional relationships **************/
    // Promotion (many-to-one)
	
	public void function setPromotion(required Promotion Promotion) {
	   variables.Promotion = arguments.Promotion;
	   if(isNew() or !arguments.Promotion.hasPromotionCode(this)) {
	       arrayAppend(arguments.Promotion.getPromotionCodes(),this);
	   }
	}
	
	public void function removePromotion(required Promotion Promotion) {
       var index = arrayFind(arguments.Promotion.getPromotionCodes(),this);
       if(index > 0) {
           arrayDeleteAt(arguments.Promotion.getPromotionCodes(),index);
       }    
       structDelete(variables,"Promotion");
    }
	
    /************   END Association Management Methods   *******************/
	
	public boolean function isAssigned() {
		var params = {promotionCodeID = getPromotionCodeID()};
		var promotionCodeApplied = ormExecuteQuery("select distinct so from SlatwallOrder so join so.promotionCodes pc where pc.promotionCodeID =:promotionCodeID",params);
		if(arrayLen(promotionCodeApplied)) {
			return true;
		} else {
			return false;
		}
	}
}