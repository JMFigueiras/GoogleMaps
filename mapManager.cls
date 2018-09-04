public with sharing class mapManager {

    public String user {get; set;}

    public Account account {get; set;}

    public static final String urlAPI = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=';

    public Account accountToUpdate {get; set;}

    public mapManager(ApexPages.StandardController controller) {
            account = (Account)controller.getRecord();
    }
}