#! /usr/bin/env -S deno run -A --ext=ts
import $ from "https://deno.land/x/dax@0.33.0/mod.ts";

// exit early if `darkman` command can't be found
if (!$.commandExistsSync("darkman")) {
  Deno.exit();
}

// get current theme
const [currentTheme] = (await $`darkman get`.lines()) as ("light" | "dark")[];
let newTheme = "";
let newKittyTheme = "";
let gnomeTheme = "";
let gnomeGtkTheme = "";

if (currentTheme === "light") {
  newTheme = "dark";
  newKittyTheme = "Catppuccin-Mocha";
  gnomeTheme = "prefer-dark";
  gnomeGtkTheme = "Adwaita-Dark";
} else {
  newTheme = "light";
  newKittyTheme = "Rosé Pine Dawn";
  // newKittyTheme = "Catppuccin-Latte";
  gnomeTheme = "prefer-light";
  gnomeGtkTheme = "Adwaita";
}

await $`darkman set ${newTheme}`;
if ($.commandExistsSync("kitty")) {
  await $`kitty +kitten themes --reload-in=all ${newKittyTheme}`;
}

if ($.commandExistsSync("gsettings")) {
  await $`gsettings set org.gnome.desktop.interface color-scheme ${gnomeTheme}`;
  // await $`gsettings set org.gnome.desktop.interface gtk-theme ${gnomeGtkTheme}`;
}

/*
 * References
 * https://blogs.gnome.org/alicem/2021/10/04/dark-style-preference/
 * https://wiki.archlinux.org/title/Dark_mode_switching#gsettings
 */
