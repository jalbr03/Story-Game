draw_set_halign(fa_center);
draw_set_valign(fa_center);

switch(state) {
	case states.prompt:
		draw_text(room_width/2, room_height/3, "Press new game to input the path to the start of your story.");
		
		text = ["new game", "continue"];
		var start_x = room_width/2
		var current_x = start_x;
		var current_y = room_height/2;
		var increment_x = room_width*3;
		var increment_y = room_height/6;
		
		for(var i=0; i<array_length(text); i++) {
			var button_w = string_width(text[i])+50;
			var button_h = string_height(text[i])+50;
	
			draw_text(current_x,current_y,text[i]);
			draw_rectangle(current_x-button_w/2, current_y-button_h/2, current_x+button_w/2, current_y+button_h/2, 1);
	
			if(mouse_check_button_pressed(mb_left)) {
				if(abs(mouse_x - current_x) < button_w/2 && abs(mouse_y - current_y) < button_h/2) {
					switch(i) {
						case 0:
							state = states.story_path;
						break;
						case 1:
							if(!file_exists(working_directory+"save_state.txt")) {
								state = states.prompt;
								show_message("No game saved");
								break;
							}
							var file = file_text_open_read(working_directory+"save_state.txt");
							story_path = file_text_read_string(file);
							file_text_readln(file);
							start_file = file_text_read_string(file);
							file_text_readln(file);
							ds_map_add(player_info, "name", file_text_read_string(file));
							file_text_readln(file);
							ds_map_add(player_info, "gender_he_she", file_text_read_string(file));
							file_text_readln(file);
							ds_map_add(player_info, "gender_him_her", file_text_read_string(file));
							file_text_readln(file);
							ds_map_add(player_info, "gender_sir_mam", file_text_read_string(file));
							file_text_close(file);
							state = states.init_game;
						break;
					}
				}
			}
			current_x += increment_x;
	
			if(current_x > room_width/1.1) {
				current_y += increment_y;
				current_x = start_x;
			}
		}
		//var text = "new game";
		//var text2 = "continue";
		//var current_x = room_width/2;
		//var current_y = room_height/2;
		//var button_w = string_width(text)+50;
		//var button_h = string_height(text)+50;
		
		//draw_text(current_x, current_y, text);
		//draw_rectangle(current_x-button_w/2, current_y-button_h/2, current_x+button_w/2, current_y+button_h/2, 1);
		//draw_text(current_x, current_y, text2);
		//draw_rectangle(current_x-button_w/2, current_y-button_h/2, current_x+button_w/2, current_y+button_h/2, 1);
	
		
		//if(mouse_check_button_pressed(mb_left)) {
		//	if(abs(mouse_x - current_x) < button_w/2 && abs(mouse_y - current_y) < button_h/2) {
		//		state = states.story_path;
		//	}
		//}
		
		break;
	
	case states.story_path:
		//story_path = get_open_filename_ext("startChapter|*.json", "", "", "Get story path");
		story_path = get_open_filename_ext("|*.json", "", "", "Select story");
		var last_of_path = get_last_of_path(story_path);
		story_path = string_replace_all(story_path, last_of_path, "");
		start_file = last_of_path;
		state = states.player_name;
		break;
	
	case states.player_name:
		var rect_w = 500;
		var rect_h = 50;
		draw_rectangle(room_width/2-rect_w/2, room_height/2-rect_h/2, room_width/2+rect_w/2, room_height/2+rect_h/2, 1);

		draw_text(room_width/2, room_height/3, "Player Name");
		draw_text(room_width/2, room_height/2, keyboard_string);
		if(keyboard_check(ord("V")) && keyboard_check(vk_control)) {
			keyboard_string = clipboard_get_text();
		}
		
		if(keyboard_check_pressed(vk_enter)) {
			ds_map_add(player_info, "name", keyboard_string);
			keyboard_string = "";
			state = states.player_gender;
		}
		break;
	
	case states.player_gender:
		genders = ["Male", "Female"];
		var start_x = room_width/3
		var current_x = start_x;
		var current_y = room_height/2;
		var increment_x = room_width/3;
		var increment_y = room_height/3;
		
		for(var i=0; i<array_length(genders); i++) {
			var button_w = string_width(genders[i])+50;
			var button_h = string_height(genders[i])+50;
	
			draw_text(current_x,current_y,genders[i]);
			draw_rectangle(current_x-button_w/2, current_y-button_h/2, current_x+button_w/2, current_y+button_h/2, 1);
	
			if(mouse_check_button_pressed(mb_left)) {
				if(abs(mouse_x - current_x) < button_w/2 && abs(mouse_y - current_y) < button_h/2) {
					switch(i) {
						case 0:
							ds_map_add(player_info, "gender_he_she", "he");
							ds_map_add(player_info, "gender_him_her", "him");
							ds_map_add(player_info, "gender_sir_mam", "sir");
						break;
						case 1:
							ds_map_add(player_info, "gender_he_she", "she");
							ds_map_add(player_info, "gender_him_her", "her");
							ds_map_add(player_info, "gender_sir_mam", "mam");
						break;
					}
					state = states.init_game;
				}
			}
			current_x += increment_x;
	
			if(current_x > room_width/1.1) {
				current_y += increment_y;
				current_x = start_x;
			}
		}
		break;
		
	case states.init_game:
		init_story();
		instance_destroy(self);
		break;
}