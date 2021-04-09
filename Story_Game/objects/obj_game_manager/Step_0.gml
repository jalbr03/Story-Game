if(!global.update) exit;
current_map = ds_map_find_value(ds_map, current_state);

top_text = ds_map_find_value(current_map, "startText");
show_text = "";
current_index = 0;
options = get_options();

global.update = false;