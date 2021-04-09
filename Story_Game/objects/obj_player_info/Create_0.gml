player_info = ds_map_create();
story_path = "";

enum states {
	prompt,
	story_path,
	player_name,
	player_gender,
	init_game
}
state = states.prompt;