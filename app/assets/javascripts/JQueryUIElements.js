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
            title: '<h4>Settings</h4>',
			autoOpen: false,
			height: 'auto',
			width: 'auto',
			modal: true,
            show: 'drop',
            hide: 'drop'
		});

		$( "#btSettings" )
			.button()
			.click(function() {
				$( "#Settings" ).dialog("open");
			});

        $( "#AddNewAppointment" ).dialog({
            title: '<h4>Add Appointment</h4>',
			autoOpen: false,
            height: 'auto',
			width: 'auto',
			modal: true,
            show: 'drop',
            hide: 'drop'
		});


		$( "#btAddNewAppointment" )
			.button()
			.click(function() {
				$( "#AddNewAppointment" ).dialog("open");
		});


		$( "#tabs" ).tabs({
         selected: 1,
         fx: { opacity: 'toggle' },
         ajaxOptions: {
                async: false,
				error: function( xhr, status, index, anchor ) {
					$( anchor.hash ).html(
						"Couldn't load this tab. We'll try to fix this as soon as possible. " +
						"If this wouldn't be a demo." );
				}
			}
        });

        });
        $(function(){

        });