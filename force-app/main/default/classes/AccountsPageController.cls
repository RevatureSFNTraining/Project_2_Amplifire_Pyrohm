public with sharing class AccountsPageController {
    @AuraEnabled
    public static List<Account> getAccounts(){
        List<Account> accounts = [SELECT Id, Name, BillingStreet, BillingState, BillingCity, BillingPostalCode, BillingCountry, 
                        ShippingStreet, ShippingState, ShippingCity, ShippingPostalCode, ShippingCountry, Phone 
                        FROM Account];            
        return accounts;           
    }  
    
    @AuraEnabled
    public static List<Account> deleteAccount(String accountId){
        List<Account> acc = [SELECT Id FROM account WHERE Id =: accountId];
        if (acc != null) {
            delete acc;
        }
        
        List<Account> accounts = [SELECT Id, Name, BillingStreet, BillingState, BillingCity, BillingPostalCode, BillingCountry, 
                        ShippingStreet, ShippingState, ShippingCity, ShippingPostalCode, ShippingCountry, Phone 
                        FROM Account];            
        return accounts;
    } 
    
}