#!/bin/bash

function PrintStatus() {
    local name="$1"
    local status="$2"

    local color="$3"
    local color_code=""

    local offset_arg="%-15s"

    case "$color" in
        "yellow")
            color_code="\e[33m"
            ;;
        "green")
            color_code="\e[32m"
            ;;
        "red")
            color_code="\e[31m"
            ;;
        *)
            color_code="\e[0m" # Defaults to no color
            ;;
    esac

    local reset_color="\e[0m"
    printf "| ${offset_arg} > %b%s%b\n" "${name}" "${color_code}${status}${reset_color}"
}

function DoLink() {
    local name="$1"
    local custom_path="$2"

    if [ -z "$custom_path" ]; then
        # Linking directly to the home directory (~)
        if [ -e "$HOME/$name" ] && [ -z "$force" ]; then
            PrintStatus "${name}" "skipped" "yellow"
            return
        else
            if [ -n "$force" ]; then
                PrintStatus "${name}" "forced" "red"
            else
                PrintStatus "${name}" "added" "green"
            fi
            ln -sf "$HOME/Dev/dotfiles/$name" "$HOME/$name"
        fi
    else
        # Linking to the custom path
        if [ -e "$HOME/$custom_path/$name" ] && [ -z "$force" ]; then
            PrintStatus "${name}" "skipped" "yellow"
        else
            if [ -n "$force" ]; then
                PrintStatus "${name}" "forced" "red"
            else
                PrintStatus "${name}" "added" "green"
            fi
            ln -sf "$HOME/Dev/dotfiles/$custom_path/$name" "$HOME/$custom_path/$name"
        fi
    fi
}

# Parse command-line arguments
force=""
if [ "$#" -gt 0 ]; then
    if [ "$1" == "-force" ] || [ "$1" == "-f" ]; then
        force="true"
    else
        echo -e "\e[1m\e[31mError:\e[0m Unsupported option. Use '-force' or '-f' to force link files."
        exit 1
    fi
fi

# Main program
echo "Linking dotfiles to their respective places."

echo -e "\nLinking \"~/\" (home) dir"
DoLink ".xinitrc"
DoLink ".zprofile"
DoLink ".screenlayout"
DoLink ".zshrc"
DoLink ".sanyok"

config_dir=".config"
echo -e "\nLinking \"~/$config_dir\" dir"
DoLink "user-dirs.dirs" "$config_dir"
DoLink "fontconfig" "$config_dir"
DoLink "picom" "$config_dir"
DoLink "bspwm" "$config_dir"
DoLink "sxhkd" "$config_dir"
DoLink "polybar" "$config_dir"
DoLink "rofi" "$config_dir"
DoLink "nitrogen" "$config_dir"
DoLink "dunst" "$config_dir"
DoLink "kitty" "$config_dir"
DoLink "neofetch" "$config_dir"
DoLink "nvim" "$config_dir"
DoLink "mpv" "$config_dir"
DoLink "btop" "$config_dir"

echo -e "\nComplete!"
