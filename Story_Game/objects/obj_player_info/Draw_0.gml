draw_set_halign(fa_center);
draw_set_valign(fa_center);

switch(state) {
	case states.prompt:
		draw_text(room_width/2, room_height/3, "IMPORTANT: Press OK to input the path to you story. \nSelect each chapter.json file then select startChapter last!\nAnd that will start the story.");
		
		var text = "OK"
		var current_x = room_width/2;
		var current_y = room_height/2;
		var button_w = string_width(text)+50;
		var button_h = string_height(text)+50;
		
		draw_text(current_x, current_y, text);
		draw_rectangle(current_x-button_w/2, current_y-button_h/2, current_x+button_w/2, current_y+button_h/2, 1);
	
		
		if(mouse_check_button_pressed(mb_left)) {
			if(abs(mouse_x - current_x) < button_w/2 && abs(mouse_y - current_y) < button_h/2) {
				state = states.story_path;
			}
		}
		
		break;
	
	case states.story_path:
		//story_path = get_open_filename_ext("startChapter|*.json", "", "", "Get story path");
		var done = false;
		while(!done) {
			story_path = get_open_filename("|*.json", "");
			var last_of_path = get_last_of_path(story_path);
			
			if(last_of_path == "startChapter.json") {
				story_path = string_replace_all(story_path, "startChapter.json", "");
				done = true;
			}
		}
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