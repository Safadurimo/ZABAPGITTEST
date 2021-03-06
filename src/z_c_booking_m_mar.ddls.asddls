@EndUserText.label: 'Booking Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true

@Search.searchable: true

define view entity Z_C_Booking_M_MAR
  as projection on Z_I_Booking_M_MAR
{

      @Search.defaultSearchElement: true
  key travel_id          as TravelID,

      @Search.defaultSearchElement: true
  key booking_id         as BookingID,

      booking_date       as BookingDate,


      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Customer', element: 'CustomerID' }}]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      customer_id        as CustomerID,
      _Customer.LastName as CustomerName,


      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Carrier', element: 'AirlineID' }}]
      @ObjectModel.text.element: ['CarrierName']
      carrier_id         as CarrierID,
      _Carrier.Name      as CarrierName,


      @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_Flight', element: 'ConnectionID'},
                                           additionalBinding: [ { localElement: 'FlightDate',   element: 'FlightDate'},
                                                                { localElement: 'CarrierID',    element: 'AirlineID'},
                                                                { localElement: 'FlightPrice',  element: 'Price'},
                                                                { localElement: 'CurrencyCode', element: 'CurrencyCode' } ] } ]
      connection_id      as ConnectionID,


      @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_Flight', element: 'FlightDate' },
                                           additionalBinding: [ { localElement: 'ConnectionID', element: 'ConnectionID'},
                                                                { localElement: 'CarrierID',    element: 'AirlineID'},
                                                                { localElement: 'FlightPrice',  element: 'Price' },
                                                                { localElement: 'CurrencyCode', element: 'CurrencyCode' }]}]
      flight_date        as FlightDate,


      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price       as FlightPrice,

      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      currency_code      as CurrencyCode,

      booking_status     as BookingStatus,

      @UI.hidden: true
      last_changed_at    as LastChangedAt, -- Take over from parent

      /* Associations */
      _Travel         : redirected to parent Z_C_TRAVEL_M_MAR,
      _BookSupplement : redirected to composition child Z_C_BookSuppl_M_MAR,
      _Customer,
      _Carrier

}
