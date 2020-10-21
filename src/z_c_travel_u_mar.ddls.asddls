@EndUserText.label: 'Travel Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true

@Search.searchable: true
define root view entity Z_C_Travel_U_MAR
  as projection on Z_I_TRAVEL_U_MARtin
{   
  key TravelID,

      @Consumption.valueHelpDefinition: [{ entity: { name:    '/DMO/I_Agency',
                                                     element: 'AgencyID' } }]
      @ObjectModel.text.element: ['AgencyName']
      @Search.defaultSearchElement: true
      AgencyID,
      _Agency.Name       as AgencyName,

      @Consumption.valueHelpDefinition: [{ entity: { name:    '/DMO/I_Customer',
                                                     element: 'CustomerID'  } }]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      CustomerID,
      _Customer.LastName as CustomerName,

      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,

      @Consumption.valueHelpDefinition: [{entity: { name:    'I_Currency',
                                                    element: 'Currency' } }]
      CurrencyCode,

      Memo,
      Status,
      LastChangedAt,
      
      /* public associations */
      _Booking : redirected to composition child Z_C_Booking_U_Mar,
      _Agency,
      _Currency,
      _Customer
}
