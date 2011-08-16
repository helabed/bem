jQuery(document).ready(function() {
  updateQuantityFields();
});


var updateQuantityFields = function() {

  jQuery( ".plus_one_item, .minus_one_item" ).click(function() {
    var the_id = jQuery(this).attr('id');
    var the_prod_id = the_id.replace(/(minus_one_id_for_prod_|plus_one_id_for_prod_)/g,'');

    var the_input_field = jQuery('#ordered_item_quantity_field_id_'+the_prod_id);
    var the_value = the_input_field.val();
    var the_numeric_value = 1.0 * the_value;
    if ( the_id.search(/plus_one/) !== -1 ) {
      the_input_field.val(the_numeric_value+1);
    } else {
      the_input_field.val(the_numeric_value-1);
    }
  });
}
