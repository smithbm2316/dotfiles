#! /usr/bin/env -S deno run -A --ext=ts

import $ from 'https://deno.land/x/dax/mod.ts';
// import { parse } from 'https://deno.land/std/flags/mod.ts';
// const flags = parse(Deno.args);

// exit early if `darkman` command can't be found
if ((await $.commandExists('darkman')) === false) Deno.exit();

// get current theme
const [currentTheme] = (await $`darkman get`.lines()) as ('light' | 'dark')[];
let newTheme = '';
let newKittyTheme = '';
let gnomeTheme = '';

if (currentTheme === 'light') {
  newTheme = 'dark';
  newKittyTheme = 'Catppuccin-Mocha';
  gnomeTheme = 'prefer-dark';
} else {
  newTheme = 'light';
  newKittyTheme = 'Rosé Pine Dawn';
  gnomeTheme = 'prefer-light';
}

await $`darkman set ${newTheme}`;
if (await $.commandExists('kitty')) {
  await $`kitty +kitten themes --reload-in=all ${newKittyTheme}`;
}

if (await $.commandExists('gsettings')) {
  await $`gsettings set org.gnome.desktop.interface color-scheme ${gnomeTheme}`;
}
