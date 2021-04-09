var text_x = room_width/2;
var text_y = room_height/4;
var rect_w = 500;
var rect_h = 200;

if(current_index < string_length(show_text)+1){
	increment_show_text(rect_w);
}
draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_text(text_x,text_y,show_text);

draw_rectangle(text_x-rect_w/2, text_y-rect_h/2, text_x+rect_w/2, text_y+rect_h/2, 1);

var button_clicked = false;

var start_x = room_width/3;
var current_x = start_x;
var current_y = room_height/2;
var increment_x = room_width/3;
var increment_y = room_height/4;

for(var i=0; i<array_length(options); i++) {
	var button_w = string_width(options[i])+50;
	var button_h = string_height(options[i])+50;
	
	draw_text(current_x,current_y,options[i]);
	draw_rectangle(current_x-button_w/2, current_y-button_h/2, current_x+button_w/2, current_y+button_h/2, 1);
	
	if(mouse_check_button_pressed(mb_left)){
		if(abs(mouse_x - current_x) < button_w/2 && abs(mouse_y - current_y) < button_h/2) {
			select_option(i+1);
			button_clicked = true;
		}
	}
	current_x += increment_x;
	
	if(current_x > room_width/1.1) {
		current_y += increment_y;
		current_x = start_x;
	}
	
}

if(mouse_check_button_pressed(mb_left) && !button_clicked){
	if(string_length(show_text) < string_length(top_text)) {
		for(var i=0; i<string_length(top_text); i++) {
			increment_show_text(rect_w);
		}
	} else if(array_length(options) == 0) {
		global.update = true;
	}
}