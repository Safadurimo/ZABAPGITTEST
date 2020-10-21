CLASS zcl_martin_hello_world DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_martin_hello_world IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA(lt_params) = request->get_form_fields(  ).
    READ TABLE lt_params REFERENCE INTO DATA(lr_params) WITH KEY name = 'cmd'.
    IF sy-subrc <> 0.
      response->set_status( i_code = 400
                       i_reason = 'Bad request').
      RETURN.
    ENDIF.
    CASE lr_params->value.
      WHEN `hello`.
        response->set_text( |Hello World! | ).
      WHEN `timestamp`.
        response->set_text( |Hello World! application executed by {
                             cl_abap_context_info=>get_user_technical_name( ) } | &&
                              | on { cl_abap_context_info=>get_system_date( ) DATE = ENVIRONMENT } | &&
                              | at { cl_abap_context_info=>get_system_time( ) TIME = ENVIRONMENT } | ).
      WHEN `bankdetails`.
        response->set_text( NEW zcl_api_hub_manager_martin(  )->get_bank_details( ) ).
      WHEN OTHERS.
        response->set_status( i_code = 400 i_reason = 'Bad request').
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
