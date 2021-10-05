public class AddEditDeleteAccountController{
    
    Account act = new Account();
    public list<Account> accountList{ get;set; }
    public list<Account> userAccounts;
    public id editAccount{ get;set; }   
    public string accountId{ get;set; }
    public account acc{ get;set; }
    
    public AddEditDeleteAccountController(){
        accountList=new list<Account>();
        accountList.add(act);
    }
    
    Public void addAccount(){
        Account a = new Account();
        accountList.add(a);                        
    }
    
    public pageReference saveAccount(){
        if(accountList.size() > 0)
            insert accountList;     
        pageReference pg = new pageReference(System.currentPageReference().getURL());
        pg.setRedirect(true);
        return pg;  
    }  
    
    public List<Account> getUserAccounts(){
        userAccounts = [select Id, name, BillingStreet, BillingState, BillingCity, BillingPostalCode, BillingCountry, 
                        ShippingStreet, ShippingState, ShippingCity, ShippingPostalCode, ShippingCountry, phone 
                        from Account WHERE Account.owner.id =: userinfo.getuserid() ORDER by createddate desc];            
        return userAccounts;           
    }  
    
    public void saveRecord(){
        Account updateAcc;
        for(Account temp:userAccounts){
            if(temp.id==editAccount){
                updateAcc = temp;   
                break;
            }
        }
        update updateAcc;
        editAccount = null;
    }
    
    public void deleteAccount(){
        acc = [select id from account where id =: accountId];
        if (acc != null) {
            delete acc;
        }
    }
}