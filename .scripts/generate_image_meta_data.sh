#!/usr/bin/env bash
(set -o igncr) 2>/dev/null && set -o igncr; # This comment is required.
### The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL.

######
### Generates lua file to get meta data from .png
######


main() {

### Check if identify command exists
local has_errors=false
if ! command -v identify &> /dev/null; then
	echo "identify: command not found"
	has_errors=true
fi
if [ $has_errors = true ] ; then
	exit 1
fi


### Find info.json
local SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
local infojson_exists=false
local script_file=`basename "$0"`
if [[ -s "$SCRIPT_DIR/info.json" ]]; then
    local infojson_exists=true
else
	cd ..
	if [[ -s "$PWD/info.json" ]]; then
		local infojson_exists=true
	else
		cd $SCRIPT_DIR
	fi
fi
local mod_folder=$PWD

local SPRITE_LIST_FILE=zk_sprite_list.lua


### Get mod name and version from info.json
### https://stedolan.github.io/jq/
if [ $infojson_exists = true ] ; then
	local MOD_NAME=$(jq -r '.name' info.json)
	if ! command -v jq &> /dev/null; then
		echo "Please install jq https://stedolan.github.io/jq/"
	fi
fi

generate_lua_files () {
	local path_to_folder="$mod_folder/$1"
	local format=*.[Pp][Nn][Gg]
	local files=($(find $path_to_folder/ -name "$format" -type f))

	local list_file="$path_to_folder/image_data_paths.lua"
	rm -f $list_file
	echo -e "return {" >> $list_file

	for path in "${files[@]}"; do
		local file_name="$(basename -- $path)"
		local file_name=${file_name%.*}
		local lua_file="$path_to_folder/$file_name.lua"
		rm -f $lua_file
		echo -e "return {$(identify -format 'width=%w, height=%h' $path)}" >> $lua_file
		echo -e "\"__unused-renders-m__/$1/$file_name\"," >> $list_file
	done
	echo -e "}\n" >> $list_file
}

generate_lua_files "fluid/mipped"
generate_lua_files "item/mipped"
generate_lua_files "tech-icon"

}
main
