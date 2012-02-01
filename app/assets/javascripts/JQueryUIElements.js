$(function(){

				// Datetimepicker


                $('#appointment_start_at').datetimepicker(
                {firstDay: 1,
                dateFormat: 'dd.mm.yy',
	            timeFormat: 'hh:mm',
	            stepMinute: 15});

                $('#appointment_end_at').datetimepicker(
                {firstDay: 1,
                dateFormat: 'dd.mm.yy',
	            timeFormat: 'hh:mm',
	            stepMinute: 15});


                <!--$('#appointment_start_at').datetimepicker( "setDate" , +7 );-->

                //slider
                $( "#priority_number_slider" ).slider(
                {
                    max: 5,
                    min: 1,
                    animate: true,
                    value: 3,
                    slide: function( event, ui ) {
                    $( "#priority_number" ).val( ui.value );}
                });

                $( "#priority_number" ).val( $( "#priority_number_slider" ).slider( "value" ) );

                //autocomplete
                var availableTags = [
                ];
                $( "#search_field" ).autocomplete({
                    source: availableTags
                });


         //dialog
		$( "#Settings" ).dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true
		});

		$( "#btSettings" )
			.button()
			.click(function() {
				$( "#Settings" ).dialog( "open" );
			});

		$( "#tabs" ).tabs();

        });
        $(function(){
            $('#appointment_start_at').datetimepicker( "setDate" , +1 );
            $('#appointment_end_at').datetimepicker( "setDate" , +1 );
        });