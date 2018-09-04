<apex:page standardController="Account" extensions="mapManager" tabStyle="Account" id="page">

    <head>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=APIKEY&callback=initMap"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
        <script type="text/javascript">

            $( document ).ready(function() {
                setAddress("{!account.BillingStreet} {!account.BillingCity} {!account.BillingState} {!account.BillingPostalCode}");
            });

                var myOptions = {
                    zoom: 15,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    mapTypeControl: false
                };
                
                var map;
                var marker;
                var geocoder = new google.maps.Geocoder();

                function setAddress(option){
                    address = option;

                    geocoder.geocode({
                    address: address
                }, function(results, status) {
                    if (status == google.maps.GeocoderStatus.OK && results.length) {
                        if (status != google.maps.GeocoderStatus.ZERO_RESULTS) {

                            //Creo el mapa.
                            map = new google.maps.Map(document.getElementById("map"), myOptions);

                            //Centro el mapa.
                            map.setCenter(results[0].geometry.location);

                            //Marco la localización.
                            marker = new google.maps.Marker({
                                position: results[0].geometry.location,
                                map: map,
                                title: "{!account.Name}"
                            });
                        }
                    } else {
                        $('#map').css({
                            'height': '15px'
                        });
                        $('#map').html("Error! la dirección de la cuenta {!account.Name} no ha podido ser encontrada!");
                        //Después de mostrar el error hago que el mapa vuelva a sus dimensiones.
                        resizeIframe();
                    }
                });                    
                }
                
                function resizeIframe() {
                    $('#map').height("400px");
                    $('#map').width("1000px");
                }
        </script>
        <style>
            #map {
                font-family: Arial;
                font-size: 12px;
                line-height: normal !important;
                height: 400px;
                width: 1000px;
                background: transparent;
            }
            
            .ct {
                text-align:center;
            }
        </style>
    </head>

    <apex:sectionHeader title="GoogleMaps" subtitle="Ejercicio Desarrollador Salesforce" />
    <apex:pageMessages />
    <apex:pageBlock >
        <apex:form id="form">
            <apex:pageBlockSection >
                <apex:pageBlockTable value="{!account}" var="a" id="account" styleClass="ct">
                    <apex:column headerValue="{!$ObjectType.Account.fields.Name.label}" styleClass="ct">
                        <apex:outputLink value="../{!account.AccountNumber}" styleClass="ct">{!account.Name}</apex:outputLink>
                    </apex:column>
                    <apex:column headerValue="Dirección de facturación" styleClass="ct">
                        <br></br>
                        {!account.BillingStreet} {!account.BillingCity} {!account.BillingState} {!account.BillingPostalCode}<br></br><br></br>
                        <apex:commandButton value="Marcar en mapa" onclick="setAddress('{!account.BillingStreet} {!account.BillingCity} {!account.BillingState} {!account.BillingPostalCode}');return false;" styleClass="ct"/>
                    </apex:column>
                    <apex:column headerValue="Dirección fiscal" styleClass="ct">
                        <br></br>
                        {!account.FiscalAddress__c}<br></br><br></br>
                        <apex:commandButton value="Marcar en mapa" onclick="setAddress('{!account.FiscalAddress__c}');return false;" styleClass="ct"/>             
                    </apex:column>
                    <apex:column headerValue="Dirección de envío" styleClass="ct">
                        <br></br>
                        {!account.ShippingStreet} {!account.ShippingState} {!account.ShippingCity} {!account.ShippingPostalCode}<br></br><br></br>
                        <apex:commandButton value="Marcar en mapa" onclick="setAddress('{!account.ShippingStreet} {!account.ShippingState} {!account.ShippingCity} {!account.ShippingPostalCode}');return false;" styleClass="ct"/>
                    </apex:column>
                </apex:pageBlockTable>
            </apex:pageBlockSection>
        </apex:form>
       
        <div id="map" styleClass="ct"></div>
    </apex:pageBlock> 

</apex:page>
