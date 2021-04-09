// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_last_of_path(input_string) {
	var last = "";
	
	for(var i=1; i<string_length(input_string)+1; i++) {
		var char = string_char_at(input_string, i);
		last += char;
		
		if(char == "\\") {
			last = "";
		}
	}
	
	return last;
}

function increment_show_text(rect_w) {
	current_index += 1;
	var char = string_char_at(top_text, current_index)
	show_text += char;

	if(string_width(show_text) > rect_w) {
		show_text = string_insert("\n", show_text, char_nl_index+1);
	}
	
	if(char == " ") {
		char_nl_index = current_index;
	}
}

function init_story() {
	var manager = instance_create_layer(x,y,layer,obj_game_manager);
	var file = file_text_open_read(story_path + "startChapter.json");
	var str = read_file(file);
	manager.ds_map = json_decode(str);
	file_text_close(file);
	
	manager.story_path = story_path;
	manager.player_info = player_info;
	manager.current_state = ds_map_find_value(manager.ds_map, "start");
}

function read_file(file_name){
	var total_str = "";
	while(!file_text_eof(file_name)){
		total_str += file_text_read_string(file_name);
		file_text_readln(file_name);
	}
	total_str = string_replace_all(total_str,"(player_name)", ds_map_find_value(player_info, "name"));
	total_str = string_replace_all(total_str,"(gender_he_she)", ds_map_find_value(player_info, "gender_he_she"));
	total_str = string_replace_all(total_str,"(gender_him_her)", ds_map_find_value(player_info, "gender_him_her"));
	total_str = string_replace_all(total_str,"(gender_sir_mam)", ds_map_find_value(player_info, "gender_sir_mam"));
	return total_str;
}

function select_option(option_index) {
	var all_options = ds_map_find_value(current_map, "options");
	var selected_option = ds_map_find_value(all_options, string(option_index));
	top_text = ds_map_find_value(selected_option, "text");
	if(top_text == "") global.update = true;
	show_text = "";
	current_index = 0;
	
	current_state = ds_map_find_value(selected_option, "goTo");
	if(current_state == undefined) {
		goto_next_chapter(ds_map_find_value(selected_option, "chapterGoTo"));
	}
	
	options = [];
}

function get_options() {
	var options_map = ds_map_find_value(current_map, "options");
	var current_options = [];
	for(var i=0; i<ds_map_size(options_map); i++) {
		var option = ds_map_find_value(options_map, string(i+1));
		array_push(current_options, ds_map_find_value(option, "action"));
	}
	return current_options;
}

function goto_next_chapter(chapter_name) {
	
	var file = file_text_open_read(story_path + chapter_name + ".json");
	//var file = file_text_open_read(story_path + "startChapter.json");
	var str = read_file(file);
	ds_map = json_decode(str);
	file_text_close(file);

	current_state = ds_map_find_value(ds_map, "start");
}