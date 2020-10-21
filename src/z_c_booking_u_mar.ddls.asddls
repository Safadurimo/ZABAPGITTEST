@EndUserText.label: 'Booking Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true

@Search.searchable: true
define view entity Z_C_Booking_U_MAR
  as projection on Z_I_BOOKING_U_martin

{     
      @Search.defaultSearchElement: true
  key TravelID,
 
      @Search.defaultSearchElement: true
  key BookingID,

      BookingDate,

      @Consumption.valueHelpDefinition: [ { entity: { name:    '/DMO/I_Customer', 
                                                     element: 'CustomerID' } } ]
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['CustomerName']
      CustomerID,
      _Customer.LastName    as CustomerName,

      @Consumption.valueHelpDefinition: [ { entity: { name:    '/DMO/I_Carrier', 
                                                      element: 'AirlineID' } } ]
      @ObjectModel.text.element: ['AirlineName']
      AirlineID,
      _Carrier.Name     as AirlineName,

      @Consumption.valueHelpDefinition: [ { entity: { name:    '/DMO/I_Flight', 
                                                      element: 'ConnectionID' },
                                            additionalBinding: [ { localElement: 'FlightDate',   element: 'FlightDate' },
                                                                 { localElement: 'AirlineID',    element: 'AirlineID' },
                                                                 { localElement: 'FlightPrice',  element: 'Price'  },
                                                                 { localElement: 'CurrencyCode', element: 'CurrencyCode' } ] } ]
      ConnectionID,
      
      @Consumption.valueHelpDefinition: [ { entity: { name:    '/DMO/I_Flight', 
                                                      element: 'FlightDate' },
                                            additionalBinding: [ { localElement: 'ConnectionID', element: 'ConnectionID' },
                                                                 { localElement: 'AirlineID',    element: 'AirlineID' },
                                                                 { localElement: 'FlightPrice',  element: 'Price' },
                                                                 { localElement: 'CurrencyCode', element: 'CurrencyCode' } ] } ]
      FlightDate,
      
      FlightPrice,
      
      @Consumption.valueHelpDefinition: [ {entity: { name:    'I_Currency', 
                                                     element: 'Currency' } } ]
      CurrencyCode,
      
//      LastChangedAt,
      
      /* public associations */
      _Travel: redirected to parent Z_C_Travel_U_MAR,
_BookSupplement: redirected to composition child Z_C_BookingSupplement_U_MAR,
      _Carrier,
      _Connection,
      _Customer
}
