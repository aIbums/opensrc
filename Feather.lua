-- Feather UI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")
local ContentProvider = game:GetService("ContentProvider")

local LocalPlayer = Players.LocalPlayer

local ICONS = {
	["activity"] = {"M22 12h-2.48a2 2 0 0 0-1.93 1.46l-2.35 8.36a.25.25 0 0 1-.48 0L9.24 2.18a.25.25 0 0 0-.48 0l-2.35 8.36A2 2 0 0 1 4.49 12H2"},
	["axe"] = {"m14 12-8.5 8.5a2.12 2.12 0 1 1-3-3L11 9", "M15 13 9 7l4-4 6 6h3a8 8 0 0 1-7 7z"},
	["bell"] = {"M10.268 21a2 2 0 0 0 3.464 0", "M3.262 15.326A1 1 0 0 0 4 17h16a1 1 0 0 0 .74-1.673C19.41 13.956 18 12.499 18 8A6 6 0 0 0 6 8c0 4.499-1.411 5.956-2.738 7.326"},
	["blend"] = {"M 8.0 9.0 a 7.0 7.0 0 1 0 14.0 0 a 7.0 7.0 0 1 0 -14.0 0", "M 2.0 15.0 a 7.0 7.0 0 1 0 14.0 0 a 7.0 7.0 0 1 0 -14.0 0"},
	["bolt"] = {"M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z", "M 8.0 12.0 a 4.0 4.0 0 1 0 8.0 0 a 4.0 4.0 0 1 0 -8.0 0"},
	["bookmark"] = {"m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16z"},
	["bot"] = {"M12 8V4H8", "M 6.0 8.0 h 12.0 a 2.0 2.0 0 0 1 2.0 2.0 v 8.0 a 2.0 2.0 0 0 1 -2.0 2.0 h -12.0 a 2.0 2.0 0 0 1 -2.0 -2.0 v -8.0 a 2.0 2.0 0 0 1 2.0 -2.0 z", "M2 14h2", "M20 14h2", "M15 13v2", "M9 13v2"},
	["box"] = {"M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z", "m3.3 7 8.7 5 8.7-5", "M12 22V12"},
	["bug"] = {"m8 2 1.88 1.88", "M14.12 3.88 16 2", "M9 7.13v-1a3.003 3.003 0 1 1 6 0v1", "M12 20c-3.3 0-6-2.7-6-6v-3a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v3c0 3.3-2.7 6-6 6", "M12 20v-9", "M6.53 9C4.6 8.8 3 7.1 3 5", "M6 13H2", "M3 21c0-2.1 1.7-3.9 3.8-4", "M20.97 5c0 2.1-1.6 3.8-3.5 4", "M22 13h-4", "M17.2 17c2.1.1 3.8 1.9 3.8 4"},
	["check"] = {"M20 6 9 17l-5-5"},
	["check-check"] = {"M18 6 7 17l-5-5", "m22 10-7.5 7.5L13 16"},
	["chevron-down"] = {"m6 9 6 6 6-6"},
	["chevron-right"] = {"m9 18 6-6-6-6"},
	["circle"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0"},
	["circle-alert"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M 12 8 L 12 12", "M 12 16 L 12.01 16"},
	["circle-check"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "m9 12 2 2 4-4"},
	["circle-user"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M 9.0 10.0 a 3.0 3.0 0 1 0 6.0 0 a 3.0 3.0 0 1 0 -6.0 0", "M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662"},
	["circle-x"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "m15 9-6 6", "m9 9 6 6"},
	["clock"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M 12 6 L 12 12 L 16 14"},
	["cloud"] = {"M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"},
	["code"] = {"M 16 18 L 22 12 L 16 6", "M 8 6 L 2 12 L 8 18"},
	["cog"] = {"M11 10.27 7 3.34", "m11 13.73-4 6.93", "M12 22v-2", "M12 2v2", "M14 12h8", "m17 20.66-1-1.73", "m17 3.34-1 1.73", "M2 12h2", "m20.66 17-1.73-1", "m20.66 7-1.73 1", "m3.34 17 1.73-1", "m3.34 7 1.73 1", "M 10.0 12.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "M 4.0 12.0 a 8.0 8.0 0 1 0 16.0 0 a 8.0 8.0 0 1 0 -16.0 0"},
	["compass"] = {"m16.24 7.76-1.804 5.411a2 2 0 0 1-1.265 1.265L7.76 16.24l1.804-5.411a2 2 0 0 1 1.265-1.265z", "M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0"},
	["copy"] = {"M 10.0 8.0 h 10.0 a 2.0 2.0 0 0 1 2.0 2.0 v 10.0 a 2.0 2.0 0 0 1 -2.0 2.0 h -10.0 a 2.0 2.0 0 0 1 -2.0 -2.0 v -10.0 a 2.0 2.0 0 0 1 2.0 -2.0 z", "M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"},
	["crosshair"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M 22 12 L 18 12", "M 6 12 L 2 12", "M 12 6 L 12 2", "M 12 22 L 12 18"},
	["door-open"] = {"M13 4h3a2 2 0 0 1 2 2v14", "M2 20h3", "M13 20h9", "M10 12v.01", "M13 4.562v16.157a1 1 0 0 1-1.242.97L5 20V5.562a2 2 0 0 1 1.515-1.94l4-1A2 2 0 0 1 13 4.561Z"},
	["download"] = {"M12 15V3", "M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4", "m7 10 5 5 5-5"},
	["eye"] = {"M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0", "M 9.0 12.0 a 3.0 3.0 0 1 0 6.0 0 a 3.0 3.0 0 1 0 -6.0 0"},
	["eye-off"] = {"M10.733 5.076a10.744 10.744 0 0 1 11.205 6.575 1 1 0 0 1 0 .696 10.747 10.747 0 0 1-1.444 2.49", "M14.084 14.158a3 3 0 0 1-4.242-4.242", "M17.479 17.499a10.75 10.75 0 0 1-15.417-5.151 1 1 0 0 1 0-.696 10.75 10.75 0 0 1 4.446-5.143", "m2 2 20 20"},
	["feather"] = {"M14.086 18.412A2 2 0 0112.67 19H5v-7.672a2 2 0 01.586-1.414L11.75 3.75a6 6 0 118.49 8.49z", "M16 8 2 22", "M17.488 15H9"},
	["file"] = {"M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7Z", "M14 2v4a2 2 0 0 0 2 2h4"},
	["flag"] = {"M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z", "M 4 22 L 4 15"},
	["flame"] = {"M8.5 14.5A2.5 2.5 0 0 0 11 12c0-1.38-.5-2-1-3-1.072-2.143-.224-4.054 2-6 .5 2.5 2 4.9 4 6.5 2 1.6 3 3.5 3 5.5a7 7 0 1 1-14 0c0-1.153.433-2.294 1-3a2.5 2.5 0 0 0 2.5 2.5z"},
	["flashlight"] = {"M18 6c0 2-2 2-2 4v10a2 2 0 0 1-2 2h-4a2 2 0 0 1-2-2V10c0-2-2-2-2-4V2h12z", "M 6 6 L 18 6", "M 12 12 L 12 12"},
	["folder"] = {"M20 20a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2h-7.9a2 2 0 0 1-1.69-.9L9.6 3.9A2 2 0 0 0 7.93 3H4a2 2 0 0 0-2 2v13a2 2 0 0 0 2 2Z"},
	["footprints"] = {"M4 16v-2.38C4 11.5 2.97 10.5 3 8c.03-2.72 1.49-6 4.5-6C9.37 2 10 3.8 10 5.5c0 3.11-2 5.66-2 8.68V16a2 2 0 1 1-4 0Z", "M20 20v-2.38c0-2.12 1.03-3.12 1-5.62-.03-2.72-1.49-6-4.5-6C14.63 6 14 7.8 14 9.5c0 3.11 2 5.66 2 8.68V20a2 2 0 1 0 4 0Z", "M16 17h4", "M4 13h4"},
	["gamepad-2"] = {"M 6 11 L 10 11", "M 8 9 L 8 13", "M 15 12 L 15.01 12", "M 18 10 L 18.01 10", "M17.32 5H6.68a4 4 0 0 0-3.978 3.59c-.006.052-.01.101-.017.152C2.604 9.416 2 14.456 2 16a3 3 0 0 0 3 3c1 0 1.5-.5 2-1l1.414-1.414A2 2 0 0 1 9.828 16h4.344a2 2 0 0 1 1.414.586L17 18c.5.5 1 1 2 1a3 3 0 0 0 3-3c0-1.545-.604-6.584-.685-7.258-.007-.05-.011-.1-.017-.151A4 4 0 0 0 17.32 5z"},
	["gauge"] = {"m12 14 4-4", "M3.34 19a10 10 0 1 1 17.32 0"},
	["ghost"] = {"M9 10h.01", "M15 10h.01", "M12 2a8 8 0 0 0-8 8v12l3-3 2.5 2.5L12 19l2.5 2.5L17 19l3 3V10a8 8 0 0 0-8-8z"},
	["globe"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M12 2a14.5 14.5 0 0 0 0 20 14.5 14.5 0 0 0 0-20", "M2 12h20"},
	["hammer"] = {"m15 12-8.373 8.373a1 1 0 1 1-3-3L12 9", "m18 15 4-4", "m21.5 11.5-1.914-1.914A2 2 0 0 1 19 8.172V7l-2.26-2.26a6 6 0 0 0-4.202-1.756L9 2.96l.92.82A6.18 6.18 0 0 1 12 8.4V10l2 2h1.172a2 2 0 0 1 1.414.586L18.5 14.5"},
	["hand"] = {"M18 11V6a2 2 0 0 0-2-2a2 2 0 0 0-2 2", "M14 10V4a2 2 0 0 0-2-2a2 2 0 0 0-2 2v2", "M10 10.5V6a2 2 0 0 0-2-2a2 2 0 0 0-2 2v8", "M18 8a2 2 0 1 1 4 0v6a8 8 0 0 1-8 8h-2c-2.8 0-4.5-.86-5.99-2.34l-3.6-3.6a2 2 0 0 1 2.83-2.82L7 15"},
	["heart"] = {"M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5"},
	["heart-pulse"] = {"M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z", "M3.22 12H9.5l.5-1 2 4.5 2-7 1.5 3.5h5.27"},
	["house"] = {"M15 21v-8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v8", "M3 10a2 2 0 0 1 .709-1.528l7-6a2 2 0 0 1 2.582 0l7 6A2 2 0 0 1 21 10v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"},
	["image"] = {"M 5.0 3.0 h 14.0 a 2.0 2.0 0 0 1 2.0 2.0 v 14.0 a 2.0 2.0 0 0 1 -2.0 2.0 h -14.0 a 2.0 2.0 0 0 1 -2.0 -2.0 v -14.0 a 2.0 2.0 0 0 1 2.0 -2.0 z", "M 7.0 9.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "m21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21"},
	["infinity"] = {"M6 16c5 0 7-8 12-8a4 4 0 0 1 0 8c-5 0-7-8-12-8a4 4 0 1 0 0 8"},
	["info"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M12 16v-4", "M12 8h.01"},
	["key"] = {"m15.5 7.5 2.3 2.3a1 1 0 0 0 1.4 0l2.1-2.1a1 1 0 0 0 0-1.4L19 4", "m21 2-9.6 9.6", "M 2.0 15.5 a 5.5 5.5 0 1 0 11.0 0 a 5.5 5.5 0 1 0 -11.0 0"},
	["keyboard"] = {"M10 8h.01", "M12 12h.01", "M14 8h.01", "M16 12h.01", "M18 8h.01", "M6 8h.01", "M7 16h10", "M8 12h.01", "M 4.0 4.0 h 16.0 a 2.0 2.0 0 0 1 2.0 2.0 v 12.0 a 2.0 2.0 0 0 1 -2.0 2.0 h -16.0 a 2.0 2.0 0 0 1 -2.0 -2.0 v -12.0 a 2.0 2.0 0 0 1 2.0 -2.0 z"},
	["layers"] = {"M12.83 2.18a2 2 0 0 0-1.66 0L2.6 6.08a1 1 0 0 0 0 1.83l8.58 3.91a2 2 0 0 0 1.66 0l8.58-3.9a1 1 0 0 0 0-1.83z", "M2 12a1 1 0 0 0 .58.91l8.6 3.91a2 2 0 0 0 1.65 0l8.58-3.9A1 1 0 0 0 22 12", "M2 17a1 1 0 0 0 .58.91l8.6 3.91a2 2 0 0 0 1.65 0l8.58-3.9A1 1 0 0 0 22 17"},
	["lightbulb"] = {"M15 14c.2-1 .7-1.7 1.5-2.5 1-.9 1.5-2.2 1.5-3.5A6 6 0 0 0 6 8c0 1 .2 2.2 1.5 3.5.7.7 1.3 1.5 1.5 2.5", "M9 18h6", "M10 22h4"},
	["link"] = {"M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71", "M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"},
	["list"] = {"M3 12h.01", "M3 18h.01", "M3 6h.01", "M8 12h13", "M8 18h13", "M8 6h13"},
	["lock"] = {"M 5.0 11.0 h 14.0 a 2.0 2.0 0 0 1 2.0 2.0 v 7.0 a 2.0 2.0 0 0 1 -2.0 2.0 h -14.0 a 2.0 2.0 0 0 1 -2.0 -2.0 v -7.0 a 2.0 2.0 0 0 1 2.0 -2.0 z", "M7 11V7a5 5 0 0 1 10 0v4"},
	["magnet"] = {"m6 15-4-4 6.75-6.77a7.79 7.79 0 0 1 11 11L13 22l-4-4 6.39-6.36a2.14 2.14 0 0 0-3-3L6 15", "m5 8 4 4", "m12 15 4 4"},
	["map-pin"] = {"M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0", "M 9.0 10.0 a 3.0 3.0 0 1 0 6.0 0 a 3.0 3.0 0 1 0 -6.0 0"},
	["maximize"] = {"M8 3H5a2 2 0 0 0-2 2v3", "M21 8V5a2 2 0 0 0-2-2h-3", "M3 16v3a2 2 0 0 0 2 2h3", "M16 21h3a2 2 0 0 0 2-2v-3"},
	["maximize-2"] = {"M 15 3 L 21 3 L 21 9", "M 9 21 L 3 21 L 3 15", "M 21 3 L 14 10", "M 3 21 L 10 14"},
	["minus"] = {"M5 12h14"},
	["moon"] = {"M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"},
	["mouse-pointer-2"] = {"M4.037 4.688a.495.495 0 0 1 .651-.651l16 6.5a.5.5 0 0 1-.063.947l-6.124 1.58a2 2 0 0 0-1.438 1.435l-1.579 6.126a.5.5 0 0 1-.947.063z"},
	["move"] = {"M12 2v20", "m15 19-3 3-3-3", "m19 9 3 3-3 3", "M2 12h20", "m5 9-3 3 3 3", "m9 5 3-3 3 3"},
	["navigation"] = {"M 3 11 L 22 2 L 13 21 L 11 13 L 3 11 z"},
	["package"] = {"M11 21.73a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73z", "M12 22V12", "m3.3 7 7.703 4.734a2 2 0 0 0 1.994 0L20.7 7", "m7.5 4.27 9 5.15"},
	["palette"] = {"M12 22a1 1 0 0 1 0-20 10 9 0 0 1 10 9 5 5 0 0 1-5 5h-2.25a1.75 1.75 0 0 0-1.4 2.8l.3.4a1.75 1.75 0 0 1-1.4 2.8z", "M 13.0 6.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0", "M 17.0 10.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0", "M 6.0 12.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0", "M 8.0 7.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0"},
	["person-standing"] = {"M 11.0 5.0 a 1.0 1.0 0 1 0 2.0 0 a 1.0 1.0 0 1 0 -2.0 0", "m9 20 3-6 3 6", "m6 8 6 2 6-2", "M12 10v4"},
	["plane"] = {"M17.8 19.2 16 11l3.5-3.5C21 6 21.5 4 21 3c-1-.5-3 0-4.5 1.5L13 8 4.8 6.2c-.5-.1-.9.1-1.1.5l-.3.5c-.2.5-.1 1 .3 1.3L9 12l-2 3H4l-1 1 3 2 2 3 1-1v-3l3-2 3.5 5.3c.3.4.8.5 1.3.3l.5-.2c.4-.3.6-.7.5-1.2z"},
	["play"] = {"M 6 3 L 20 12 L 6 21 L 6 3 z"},
	["plus"] = {"M5 12h14", "M12 5v14"},
	["power"] = {"M12 2v10", "M18.4 6.6a9 9 0 1 1-12.77.04"},
	["puzzle"] = {"M15.39 4.39a1 1 0 0 0 1.68-.474 2.5 2.5 0 1 1 3.014 3.015 1 1 0 0 0-.474 1.68l1.683 1.682a2.414 2.414 0 0 1 0 3.414L19.61 15.39a1 1 0 0 1-1.68-.474 2.5 2.5 0 1 0-3.014 3.015 1 1 0 0 1 .474 1.68l-1.683 1.682a2.414 2.414 0 0 1-3.414 0L8.61 19.61a1 1 0 0 0-1.68.474 2.5 2.5 0 1 1-3.014-3.015 1 1 0 0 0 .474-1.68l-1.683-1.682a2.414 2.414 0 0 1 0-3.414L4.39 8.61a1 1 0 0 1 1.68.474 2.5 2.5 0 1 0 3.014-3.015 1 1 0 0 1-.474-1.68l1.683-1.682a2.414 2.414 0 0 1 3.414 0z"},
	["radar"] = {"M19.07 4.93A10 10 0 0 0 6.99 3.34", "M4 6h.01", "M2.29 9.62A10 10 0 1 0 21.31 8.35", "M16.24 7.76A6 6 0 1 0 8.23 16.67", "M12 18h.01", "M17.99 11.66A6 6 0 0 1 15.77 16.67", "M 10.0 12.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "m13.41 10.59 5.66-5.66"},
	["refresh-cw"] = {"M3 12a9 9 0 0 1 9-9 9.75 9.75 0 0 1 6.74 2.74L21 8", "M21 3v5h-5", "M21 12a9 9 0 0 1-9 9 9.75 9.75 0 0 1-6.74-2.74L3 16", "M8 16H3v5"},
	["rocket"] = {"M4.5 16.5c-1.5 1.26-2 5-2 5s3.74-.5 5-2c.71-.84.7-2.13-.09-2.91a2.18 2.18 0 0 0-2.91-.09z", "m12 15-3-3a22 22 0 0 1 2-3.95A12.88 12.88 0 0 1 22 2c0 2.72-.78 7.5-6 11a22.35 22.35 0 0 1-4 2z", "M9 12H4s.55-3.03 2-4c1.62-1.08 5 0 5 0", "M12 15v5s3.03-.55 4-2c1.08-1.62 0-5 0-5"},
	["rotate-cw"] = {"M21 12a9 9 0 1 1-9-9c2.52 0 4.93 1 6.74 2.74L21 8", "M21 3v5h-5"},
	["ruler"] = {"M21.3 15.3a2.4 2.4 0 0 1 0 3.4l-2.6 2.6a2.4 2.4 0 0 1-3.4 0L2.7 8.7a2.41 2.41 0 0 1 0-3.4l2.6-2.6a2.41 2.41 0 0 1 3.4 0Z", "m14.5 12.5 2-2", "m11.5 9.5 2-2", "m8.5 6.5 2-2", "m17.5 15.5 2-2"},
	["save"] = {"M15.2 3a2 2 0 0 1 1.4.6l3.8 3.8a2 2 0 0 1 .6 1.4V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z", "M17 21v-7a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v7", "M7 3v4a1 1 0 0 0 1 1h7"},
	["scan-eye"] = {"M3 7V5a2 2 0 0 1 2-2h2", "M17 3h2a2 2 0 0 1 2 2v2", "M21 17v2a2 2 0 0 1-2 2h-2", "M7 21H5a2 2 0 0 1-2-2v-2", "M 11.0 12.0 a 1.0 1.0 0 1 0 2.0 0 a 1.0 1.0 0 1 0 -2.0 0", "M18.944 12.33a1 1 0 0 0 0-.66 7.5 7.5 0 0 0-13.888 0 1 1 0 0 0 0 .66 7.5 7.5 0 0 0 13.888 0"},
	["scan-line"] = {"M3 7V5a2 2 0 0 1 2-2h2", "M17 3h2a2 2 0 0 1 2 2v2", "M21 17v2a2 2 0 0 1-2 2h-2", "M7 21H5a2 2 0 0 1-2-2v-2", "M7 12h10"},
	["search"] = {"M 3.0 11.0 a 8.0 8.0 0 1 0 16.0 0 a 8.0 8.0 0 1 0 -16.0 0", "m21 21-4.3-4.3"},
	["send"] = {"M14.536 21.686a.5.5 0 0 0 .937-.024l6.5-19a.496.496 0 0 0-.635-.635l-19 6.5a.5.5 0 0 0-.024.937l7.93 3.18a2 2 0 0 1 1.112 1.11z", "m21.854 2.147-10.94 10.939"},
	["settings"] = {"M9.671 4.136a2.34 2.34 0 0 1 4.659 0 2.34 2.34 0 0 0 3.319 1.915 2.34 2.34 0 0 1 2.33 4.033 2.34 2.34 0 0 0 0 3.831 2.34 2.34 0 0 1-2.33 4.033 2.34 2.34 0 0 0-3.319 1.915 2.34 2.34 0 0 1-4.659 0 2.34 2.34 0 0 0-3.32-1.915 2.34 2.34 0 0 1-2.33-4.033 2.34 2.34 0 0 0 0-3.831A2.34 2.34 0 0 1 6.35 6.051a2.34 2.34 0 0 0 3.319-1.915", "M 9.0 12.0 a 3.0 3.0 0 1 0 6.0 0 a 3.0 3.0 0 1 0 -6.0 0"},
	["shuffle"] = {"M2 18h1.4c1.3 0 2.5-.6 3.3-1.7l6.1-8.6c.7-1.1 2-1.7 3.3-1.7H22", "m18 2 4 4-4 4", "M2 6h1.9c1.5 0 2.9.9 3.6 2.2", "M22 18h-5.9c-1.3 0-2.6-.7-3.3-1.8l-.5-.8", "m18 14 4 4-4 4"},
	["skull"] = {"m12.5 17-.5-1-.5 1h1z", "M15 22a1 1 0 0 0 1-1v-1a2 2 0 0 0 1.56-3.25 8 8 0 1 0-11.12 0A2 2 0 0 0 8 20v1a1 1 0 0 0 1 1z", "M 14.0 12.0 a 1.0 1.0 0 1 0 2.0 0 a 1.0 1.0 0 1 0 -2.0 0", "M 8.0 12.0 a 1.0 1.0 0 1 0 2.0 0 a 1.0 1.0 0 1 0 -2.0 0"},
	["sliders-horizontal"] = {"M10 5H3", "M12 19H3", "M14 3v4", "M16 17v4", "M21 12h-9", "M21 19h-5", "M21 5h-7", "M8 10v4", "M8 12H3"},
	["sparkles"] = {"M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .963 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.963 0z", "M20 3v4", "M22 5h-4", "M4 17v2", "M5 18H3"},
	["spline"] = {"M 17.0 5.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "M 3.0 19.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "M5 17A12 12 0 0 1 17 5"},
	["square"] = {"M 5.0 3.0 h 14.0 a 2.0 2.0 0 0 1 2.0 2.0 v 14.0 a 2.0 2.0 0 0 1 -2.0 2.0 h -14.0 a 2.0 2.0 0 0 1 -2.0 -2.0 v -14.0 a 2.0 2.0 0 0 1 2.0 -2.0 z"},
	["square-dashed"] = {"M5 3a2 2 0 0 0-2 2", "M19 3a2 2 0 0 1 2 2", "M21 19a2 2 0 0 1-2 2", "M5 21a2 2 0 0 1-2-2", "M9 3h1", "M9 21h1", "M14 3h1", "M14 21h1", "M3 9v1", "M21 9v1", "M3 14v1", "M21 14v1"},
	["star"] = {"M11.525 2.295a.53.53 0 0 1 .95 0l2.31 4.679a2.123 2.123 0 0 0 1.595 1.16l5.166.756a.53.53 0 0 1 .294.904l-3.736 3.638a2.123 2.123 0 0 0-.611 1.878l.882 5.14a.53.53 0 0 1-.771.56l-4.618-2.428a2.122 2.122 0 0 0-1.973 0L6.396 21.01a.53.53 0 0 1-.77-.56l.881-5.139a2.122 2.122 0 0 0-.611-1.879L2.16 9.795a.53.53 0 0 1 .294-.906l5.165-.755a2.122 2.122 0 0 0 1.597-1.16z"},
	["sun"] = {"M 8.0 12.0 a 4.0 4.0 0 1 0 8.0 0 a 4.0 4.0 0 1 0 -8.0 0", "M12 2v2", "M12 20v2", "m4.93 4.93 1.41 1.41", "m17.66 17.66 1.41 1.41", "M2 12h2", "M20 12h2", "m6.34 17.66-1.41 1.41", "m19.07 4.93-1.41 1.41"},
	["sword"] = {"M 14.5 17.5 L 3 6 L 3 3 L 6 3 L 17.5 14.5", "M 13 19 L 19 13", "M 16 16 L 20 20", "M 19 21 L 21 19"},
	["swords"] = {"m13 19 6-6", "M14.5 17.5 3.586 6.586A2 2 0 013 5.172V3h2.172a2 2 0 011.414.586L17.5 14.5", "m14.828 6.172 2.586-2.586A2 2 0 0118.828 3H21v2.172a2 2 0 01-.586 1.414l-2.586 2.586", "m16 16 4 4", "m19 21 2-2", "m5 14 4 4", "m5 21-2-2", "M7.5 16.5 4 20"},
	["tag"] = {"M12.586 2.586A2 2 0 0 0 11.172 2H4a2 2 0 0 0-2 2v7.172a2 2 0 0 0 .586 1.414l8.704 8.704a2.426 2.426 0 0 0 3.42 0l6.58-6.58a2.426 2.426 0 0 0 0-3.42z", "M 7.0 7.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0"},
	["target"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M 6.0 12.0 a 6.0 6.0 0 1 0 12.0 0 a 6.0 6.0 0 1 0 -12.0 0", "M 10.0 12.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0"},
	["terminal"] = {"M 4 17 L 10 11 L 4 5", "M 12 19 L 20 19"},
	["timer"] = {"M 10 2 L 14 2", "M 12 14 L 15 11", "M 4.0 14.0 a 8.0 8.0 0 1 0 16.0 0 a 8.0 8.0 0 1 0 -16.0 0"},
	["trash-2"] = {"M3 6h18", "M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6", "M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2", "M 10 11 L 10 17", "M 14 11 L 14 17"},
	["triangle-alert"] = {"m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3", "M12 9v4", "M12 17h.01"},
	["type"] = {"M 4 7 L 4 4 L 20 4 L 20 7", "M 9 20 L 15 20", "M 12 4 L 12 20"},
	["upload"] = {"M12 3v12", "m17 8-5-5-5 5", "M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"},
	["user"] = {"M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2", "M 8.0 7.0 a 4.0 4.0 0 1 0 8.0 0 a 4.0 4.0 0 1 0 -8.0 0"},
	["user-check"] = {"M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2", "M 5.0 7.0 a 4.0 4.0 0 1 0 8.0 0 a 4.0 4.0 0 1 0 -8.0 0", "M 16 11 L 18 13 L 22 9"},
	["users"] = {"M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2", "M16 3.128a4 4 0 0 1 0 7.744", "M22 21v-2a4 4 0 0 0-3-3.87", "M 5.0 7.0 a 4.0 4.0 0 1 0 8.0 0 a 4.0 4.0 0 1 0 -8.0 0"},
	["volume-x"] = {"M11 4.702a.705.705 0 0 0-1.203-.498L6.413 7.587A1.4 1.4 0 0 1 5.416 8H3a1 1 0 0 0-1 1v6a1 1 0 0 0 1 1h2.416a1.4 1.4 0 0 1 .997.413l3.383 3.384A.705.705 0 0 0 11 19.298z", "M 22 9 L 16 15", "M 16 9 L 22 15"},
	["wind"] = {"M12.8 19.6A2 2 0 1 0 14 16H2", "M17.5 8a2.5 2.5 0 1 1 2 4H2", "M9.8 4.4A2 2 0 1 1 11 8H2"},
	["wrench"] = {"M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.106-3.105c.32-.322.863-.22.983.218a6 6 0 0 1-8.259 7.057l-7.91 7.91a1 1 0 0 1-2.999-3l7.91-7.91a6 6 0 0 1 7.057-8.259c.438.12.54.662.219.984z"},
	["x"] = {"M18 6 6 18", "m6 6 12 12"},
}

-- names lucide renamed, so older scripts still get an icon
local ICON_ALIAS = {
	["box-select"] = "square-dashed", ["alert-triangle"] = "triangle-alert", ["alert-circle"] = "circle-alert",
	["check-circle"] = "circle-check", ["x-circle"] = "circle-x", ["user-circle"] = "circle-user",
	["home"] = "house", ["sliders"] = "sliders-horizontal", ["zap"] = "sparkles", ["shield"] = "heart-pulse", ["shield-alert"] = "triangle-alert",
}

-- / base64 \ --
local B64 = {}
do
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local lookup = {}
	for i = 1, #chars do lookup[string.byte(chars, i)] = i - 1 end
	function B64.decode(data)
		local out = {}
		local acc, nbits = 0, 0
		for i = 1, #data do
			local v = lookup[string.byte(data, i)]
			if v then
				acc = acc * 64 + v
				nbits += 6
				if nbits >= 8 then
					nbits -= 8
					local scale = 2 ^ nbits
					out[#out + 1] = string.char(math.floor(acc / scale) % 256)
					acc = acc % scale
				end
			end
		end
		return table.concat(out)
	end
end

-- / PNG encode (white image, per-pixel alpha) \ --
local PNG = {}
do
	local CRC = {}
	for i = 0, 255 do
		local c = i
		for _ = 1, 8 do c = bit32.band(c, 1) == 1 and bit32.bxor(0xEDB88320, bit32.rshift(c, 1)) or bit32.rshift(c, 1) end
		CRC[i] = c
	end
	local function crc32(str)
		local c = 0xFFFFFFFF
		for i = 1, #str do c = bit32.bxor(CRC[bit32.band(bit32.bxor(c, string.byte(str, i)), 0xFF)], bit32.rshift(c, 8)) end
		return bit32.bxor(c, 0xFFFFFFFF)
	end
	local function u32(n) return string.char(bit32.band(bit32.rshift(n, 24), 255), bit32.band(bit32.rshift(n, 16), 255), bit32.band(bit32.rshift(n, 8), 255), bit32.band(n, 255)) end
	local function chunk(k, d) return u32(#d) .. k .. d .. u32(crc32(k .. d)) end
	function PNG.encode(w, h, alpha)
		local rows = {}
		for y = 0, h - 1 do
			local row = {"\0"}
			for x = 0, w - 1 do row[#row + 1] = string.char(255, 255, 255, math.floor(math.clamp(alpha(x, y), 0, 1) * 255 + 0.5)) end
			rows[#rows + 1] = table.concat(row)
		end
		local raw = table.concat(rows)
		local s1, s2 = 1, 0
		for i = 1, #raw do s1 = (s1 + string.byte(raw, i)) % 65521 s2 = (s2 + s1) % 65521 end
		local parts = {"\120\1"}
		local pos = 1
		while pos <= #raw do
			local len = math.min(65535, #raw - pos + 1)
			local final = (pos + len > #raw) and 1 or 0
			local nlen = 65535 - len
			parts[#parts + 1] = string.char(final, len % 256, math.floor(len / 256), nlen % 256, math.floor(nlen / 256))
			parts[#parts + 1] = string.sub(raw, pos, pos + len - 1)
			pos += len
		end
		parts[#parts + 1] = u32(s2 * 65536 + s1)
		return "\137PNG\r\n\26\n" .. chunk("IHDR", u32(w) .. u32(h) .. "\8\6\0\0\0") .. chunk("IDAT", table.concat(parts)) .. chunk("IEND", "")
	end
end

-- / SVG path tessellator \ --
local function tessPath(d, out)
	local i, n = 1, #d
	local function skipSep()
		while i <= n do
			local c = string.sub(d, i, i)
			if c == " " or c == "," or c == "\t" or c == "\n" or c == "\r" then i += 1 else break end
		end
	end
	local function readNum()
		skipSep()
		local j = i
		local c = string.sub(d, i, i)
		if c == "+" or c == "-" then i += 1 end
		local dot = false
		while i <= n do
			c = string.sub(d, i, i)
			if c >= "0" and c <= "9" then i += 1
			elseif c == "." and not dot then dot = true i += 1
			elseif c == "e" or c == "E" then i += 1 local s = string.sub(d, i, i) if s == "+" or s == "-" then i += 1 end
			else break end
		end
		return tonumber(string.sub(d, j, i - 1)) or 0
	end
	local function readFlag()
		skipSep()
		local c = string.sub(d, i, i)
		i += 1
		return c == "1" and 1 or 0
	end
	local cx, cy, sx, sy = 0, 0, 0, 0
	local pcx, pcy = 0, 0
	local cmd
	local function emit(x, y) out[#out + 1] = {cx, cy, x, y} cx, cy = x, y end
	local function cubic(x1, y1, x2, y2, x, y)
		local ax, ay = cx, cy
		for s = 1, 16 do
			local t = s / 16 local mt = 1 - t
			emit(mt * mt * mt * ax + 3 * mt * mt * t * x1 + 3 * mt * t * t * x2 + t * t * t * x,
				mt * mt * mt * ay + 3 * mt * mt * t * y1 + 3 * mt * t * t * y2 + t * t * t * y)
		end
		pcx, pcy = x2, y2
	end
	local function quad(x1, y1, x, y)
		local ax, ay = cx, cy
		for s = 1, 14 do
			local t = s / 14 local mt = 1 - t
			emit(mt * mt * ax + 2 * mt * t * x1 + t * t * x, mt * mt * ay + 2 * mt * t * y1 + t * t * y)
		end
		pcx, pcy = x1, y1
	end
	local function arcTo(rx, ry, phiDeg, large, sweep, x, y)
		if rx == 0 or ry == 0 then emit(x, y) return end
		rx, ry = math.abs(rx), math.abs(ry)
		local phi = math.rad(phiDeg)
		local cosP, sinP = math.cos(phi), math.sin(phi)
		local dx, dy = (cx - x) / 2, (cy - y) / 2
		local x1p = cosP * dx + sinP * dy
		local y1p = -sinP * dx + cosP * dy
		local lam = (x1p * x1p) / (rx * rx) + (y1p * y1p) / (ry * ry)
		if lam > 1 then local s = math.sqrt(lam) rx, ry = rx * s, ry * s end
		local sign = (large ~= sweep) and 1 or -1
		local num = rx * rx * ry * ry - rx * rx * y1p * y1p - ry * ry * x1p * x1p
		local den = rx * rx * y1p * y1p + ry * ry * x1p * x1p
		local co = sign * math.sqrt(math.max(0, num / den))
		local cxp = co * rx * y1p / ry
		local cyp = -co * ry * x1p / rx
		local centerX = cosP * cxp - sinP * cyp + (cx + x) / 2
		local centerY = sinP * cxp + cosP * cyp + (cy + y) / 2
		local function ang(ux, uy, vx, vy)
			local dot = ux * vx + uy * vy
			local len = math.sqrt((ux * ux + uy * uy) * (vx * vx + vy * vy))
			local a = math.acos(math.clamp(dot / len, -1, 1))
			if ux * vy - uy * vx < 0 then a = -a end
			return a
		end
		local theta1 = ang(1, 0, (x1p - cxp) / rx, (y1p - cyp) / ry)
		local dtheta = ang((x1p - cxp) / rx, (y1p - cyp) / ry, (-x1p - cxp) / rx, (-y1p - cyp) / ry)
		if sweep == 0 and dtheta > 0 then dtheta -= 2 * math.pi end
		if sweep == 1 and dtheta < 0 then dtheta += 2 * math.pi end
		local steps = math.max(2, math.ceil(math.abs(dtheta) / (math.pi / 16)))
		for s = 1, steps do
			local t = theta1 + dtheta * s / steps
			emit(cosP * rx * math.cos(t) - sinP * ry * math.sin(t) + centerX,
				sinP * rx * math.cos(t) + cosP * ry * math.sin(t) + centerY)
		end
	end
	while true do
		skipSep()
		if i > n then break end
		local c = string.sub(d, i, i)
		if string.match(c, "%a") then cmd = c i += 1 else if cmd == "M" then cmd = "L" elseif cmd == "m" then cmd = "l" end end
		local rel = string.lower(cmd) == cmd
		local C = string.upper(cmd)
		local ox, oy = cx, cy
		if C == "M" then local x, y = readNum(), readNum() if rel then x += ox y += oy end cx, cy, sx, sy = x, y, x, y
		elseif C == "L" then local x, y = readNum(), readNum() if rel then x += ox y += oy end emit(x, y)
		elseif C == "H" then local x = readNum() if rel then x += ox end emit(x, cy)
		elseif C == "V" then local y = readNum() if rel then y += oy end emit(cx, y)
		elseif C == "C" then local x1, y1, x2, y2, x, y = readNum(), readNum(), readNum(), readNum(), readNum(), readNum() if rel then x1 += ox y1 += oy x2 += ox y2 += oy x += ox y += oy end cubic(x1, y1, x2, y2, x, y)
		elseif C == "S" then local x2, y2, x, y = readNum(), readNum(), readNum(), readNum() if rel then x2 += ox y2 += oy x += ox y += oy end cubic(2 * cx - pcx, 2 * cy - pcy, x2, y2, x, y)
		elseif C == "Q" then local x1, y1, x, y = readNum(), readNum(), readNum(), readNum() if rel then x1 += ox y1 += oy x += ox y += oy end quad(x1, y1, x, y)
		elseif C == "T" then local x, y = readNum(), readNum() if rel then x += ox y += oy end quad(2 * cx - pcx, 2 * cy - pcy, x, y)
		elseif C == "A" then local rx, ry, rot = readNum(), readNum(), readNum() local la, sw = readFlag(), readFlag() local x, y = readNum(), readNum() if rel then x += ox y += oy end arcTo(rx, ry, rot, la, sw, x, y)
		elseif C == "Z" then emit(sx, sy)
		end
	end
end

local function distSeg(px, py, s)
	local vx, vy = s[3] - s[1], s[4] - s[2]
	local wx, wy = px - s[1], py - s[2]
	local len2 = vx * vx + vy * vy
	local t = len2 > 0 and math.clamp((wx * vx + wy * vy) / len2, 0, 1) or 0
	local dx, dy = px - (s[1] + vx * t), py - (s[2] + vy * t)
	return math.sqrt(dx * dx + dy * dy)
end

-- / icon assets (drawn once, saved, tinted in UI) \ --
local Icon = {cache = {}, pending = {}, queue = {}, busy = false}
local hasAssets = (writefile ~= nil) and ((getcustomasset ~= nil) or (getsynasset ~= nil))
local loadAsset = getcustomasset or getsynasset

local function ensureFolder()
	if makefolder and isfolder then
		pcall(function() if not isfolder("Feather") then makefolder("Feather") end end)
		pcall(function() if not isfolder("Feather/icons") then makefolder("Feather/icons") end end)
	end
end

-- each segment only touches the pixels around it, so a whole icon is a couple of ms
local function drawIcon(name, size)
	local segs = {}
	for _, d in ipairs(ICONS[name]) do tessPath(d, segs) end
	local scale = size / 24
	local half, aa = 1.0, 0.9 / scale
	local reach = half + aa
	local best = table.create(size * size, 1e9)
	for _, s in ipairs(segs) do
		local x0 = math.max(0, math.floor((math.min(s[1], s[3]) - reach) * scale))
		local x1 = math.min(size - 1, math.ceil((math.max(s[1], s[3]) + reach) * scale))
		local y0 = math.max(0, math.floor((math.min(s[2], s[4]) - reach) * scale))
		local y1 = math.min(size - 1, math.ceil((math.max(s[2], s[4]) + reach) * scale))
		for y = y0, y1 do
			local py = (y + 0.5) / scale
			local row = y * size + 1
			for x = x0, x1 do
				local dd = distSeg((x + 0.5) / scale, py, s)
				if dd < best[row + x] then best[row + x] = dd end
			end
		end
	end
	return PNG.encode(size, size, function(x, y) return (half - best[y * size + x + 1]) / aa + 0.5 end)
end

local function iconDone(key, id)
	Icon.cache[key] = id or false
	local list = Icon.pending[key]
	Icon.pending[key] = nil
	if id and list then
		for _, img in ipairs(list) do img.Image = id end
	end
end

-- one icon per frame the first time, so a fresh install never hitches the intro
local function iconWorker()
	while #Icon.queue > 0 do
		local job = table.remove(Icon.queue, 1)
		local key = job.name .. "_" .. job.size
		local path = "Feather/icons/" .. key .. "_b.png"
		local drew = false
		local ok, id = pcall(function()
			if not (isfile and isfile(path)) then
				ensureFolder()
				writefile(path, drawIcon(job.name, job.size))
				drew = true
			end
			return loadAsset(path)
		end)
		iconDone(key, ok and id or nil)
		if drew then RunService.Heartbeat:Wait() end
	end
	Icon.busy = false
end

function Icon.request(img, name, size)
	name = ICON_ALIAS[name] or name
	if not (hasAssets and ICONS[name]) then return end
	local key = name .. "_" .. size
	local hit = Icon.cache[key]
	if hit then img.Image = hit return end
	if hit == false then return end
	local list = Icon.pending[key]
	if list then table.insert(list, img) return end
	Icon.pending[key] = {img}
	table.insert(Icon.queue, {name = name, size = size})
	if not Icon.busy then
		Icon.busy = true
		task.defer(iconWorker)
	end
end

-- / theme \ --
local Theme = {
	Accent = Color3.fromRGB(240, 240, 242),
	bg = Color3.fromRGB(11, 11, 13),
	panel = Color3.fromRGB(17, 17, 20),
	raised = Color3.fromRGB(23, 23, 27),
	hover = Color3.fromRGB(32, 32, 37),
	line = Color3.fromRGB(38, 38, 44),
	text = Color3.fromRGB(238, 238, 242),
	sub = Color3.fromRGB(140, 140, 150),
	dim = Color3.fromRGB(90, 90, 98),
	onAccent = Color3.fromRGB(14, 14, 16),
	good = Color3.fromRGB(90, 200, 130),
	bad = Color3.fromRGB(235, 90, 90),
	warn = Color3.fromRGB(235, 180, 70),
}
local FONT = Enum.Font.GothamMedium
local REG = Enum.Font.Gotham
local BOLD = Enum.Font.GothamBold

-- / util \ --
local function new(class, props, children)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do if k ~= "Parent" then inst[k] = v end end
	for _, c in ipairs(children or {}) do c.Parent = inst end
	if props and props.Parent then inst.Parent = props.Parent end
	return inst
end
local function corner(r) return new("UICorner", {CornerRadius = UDim.new(0, r)}) end
local function pad(all) return new("UIPadding", {PaddingTop = UDim.new(0, all), PaddingBottom = UDim.new(0, all), PaddingLeft = UDim.new(0, all), PaddingRight = UDim.new(0, all)}) end
local function stroke(color, trans, thick) return new("UIStroke", {Color = color or Theme.line, Transparency = trans or 0, Thickness = thick or 1}) end
local function tween(inst, t, goal, style) return TweenService:Create(inst, TweenInfo.new(t, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out), goal) end
local function go(inst, t, goal, style) local tw = tween(inst, t, goal, style) tw:Play() return tw end

local function label(props)
	props.BackgroundTransparency = 1
	props.Font = props.Font or FONT
	props.TextColor3 = props.TextColor3 or Theme.text
	props.TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left
	props.TextYAlignment = props.TextYAlignment or Enum.TextYAlignment.Center
	return new("TextLabel", props)
end

local function makeIcon(parent, name, size, color)
	local holder = new("ImageLabel", {
		BackgroundTransparency = 1, Size = UDim2.fromOffset(size, size), ScaleType = Enum.ScaleType.Fit,
		ImageColor3 = color or Theme.text, Parent = parent,
	})
	Icon.request(holder, name, math.max(24, size * 2))
	return holder
end

-- a canvas group cuts off a stroke put straight on it, so its outline sits on a frame just inside the edge
local function outline(parent, radius, color, trans)
	local holder = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), ZIndex = 50, Parent = parent}, {corner(math.max(radius - 1, 0))})
	local st = stroke(color, trans)
	st.Parent = holder
	return st
end

local function textSize(text, size, font, width)
	local ok, v = pcall(function() return TextService:GetTextSize(text, size, font, Vector2.new(width or 2000, 2000)) end)
	if ok and v then return v end
	return Vector2.new(math.min(#text * size * 0.55, width or 2000), size + 3)
end

local function round(n, decimals)
	local m = 10 ^ (decimals or 0)
	return math.floor(n * m + 0.5) / m
end

-- / library \ --
local Feather = {Theme = Theme, ToggleKey = Enum.KeyCode.RightShift, Flags = {}, _windows = {}, _notifs = nil, OnUnload = false, Unload = function(_self) end, __icons = ICONS}

local function hudParent(gui)
	local ok = pcall(function() gui.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
	if not ok or not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end

if getgenv then
	if getgenv().__FeatherUnload then pcall(getgenv().__FeatherUnload) end
end

-- / notifications \ --
local NOTE_W = 304
local NOTE_ICON = {success = "circle-check", error = "circle-x", warning = "triangle-alert", info = "info"}

local function notifRoot()
	if Feather._notifs and Feather._notifs.Parent then return Feather._notifs end
	local gui = new("ScreenGui", {Name = HttpService:GenerateGUID(false), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 1000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
	hudParent(gui)
	local holder = new("Frame", {
		AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -18, 1, -18), Size = UDim2.new(0, NOTE_W, 1, -36),
		BackgroundTransparency = 1, Parent = gui,
	}, {new("UIListLayout", {Padding = UDim.new(0, 0), VerticalAlignment = Enum.VerticalAlignment.Bottom, HorizontalAlignment = Enum.HorizontalAlignment.Right, SortOrder = Enum.SortOrder.LayoutOrder})})
	Feather._notifs = holder
	return holder
end

function Feather:Notify(opts)
	opts = opts or {}
	local holder = notifRoot()
	local kind = NOTE_ICON[opts.Type] and opts.Type or "info"
	local tint = ({success = Theme.good, error = Theme.bad, warning = Theme.warn})[kind] or Theme.text
	local life = tonumber(opts.Duration) or 4
	local title, content = tostring(opts.Title or "Notice"), tostring(opts.Content or "")
	local textW = NOTE_W - 42 - 14
	local contentH = content ~= "" and math.ceil(textSize(content, 12, FONT, textW).Y) or 0
	local height = 12 + 16 + (contentH > 0 and contentH + 3 or 0) + 13
	Feather._noteCount = (Feather._noteCount or 0) + 1

	-- the slot holds the space in the stack, the card slides and fades inside it
	local slot = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = Feather._noteCount, Parent = holder})
	local card = new("CanvasGroup", {BackgroundColor3 = Theme.panel, GroupTransparency = 1, Position = UDim2.fromOffset(28, 0), Size = UDim2.new(1, 0, 0, height), Parent = slot}, {corner(13)})
	outline(card, 13, Theme.line, 0)
	local ic = makeIcon(card, NOTE_ICON[kind], 16, tint)
	ic.Position = UDim2.fromOffset(14, 12)
	label({Text = title, Font = BOLD, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(42, 12), Size = UDim2.fromOffset(textW, 16), Parent = card})
	if contentH > 0 then
		label({Text = content, TextSize = 12, TextColor3 = Theme.sub, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Position = UDim2.fromOffset(42, 31), Size = UDim2.fromOffset(textW, contentH), Parent = card})
	end
	local timer = new("Frame", {BackgroundColor3 = tint, BackgroundTransparency = 0.45, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 2), Parent = card})
	local hit = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5, Parent = card})

	go(slot, 0.3, {Size = UDim2.new(1, 0, 0, height + 8)})
	go(card, 0.4, {GroupTransparency = 0, Position = UDim2.fromOffset(0, 0)})
	TweenService:Create(timer, TweenInfo.new(life, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 2)}):Play()

	local gone = false
	local function dismiss()
		if gone then return end
		gone = true
		go(card, 0.3, {GroupTransparency = 1, Position = UDim2.fromOffset(28, 0)})
		task.delay(0.18, function() go(slot, 0.3, {Size = UDim2.new(1, 0, 0, 0)}) end)
		task.delay(0.5, function() slot:Destroy() end)
	end
	hit.MouseButton1Click:Connect(dismiss)
	task.delay(life, dismiss)
end

-- / config \ --
local function configFolder() return "Feather/configs" end
function Feather:ListConfigs()
	local out = {}
	if listfiles and isfolder and isfolder(configFolder()) then
		pcall(function()
			for _, f in ipairs(listfiles(configFolder())) do
				local name = f:match("([^/\\]+)%.json$")
				if name then table.insert(out, name) end
			end
		end)
	end
	return out
end
function Feather:SaveConfig(name)
	if not writefile then return false, "no writefile" end
	ensureFolder()
	pcall(function() if isfolder and not isfolder(configFolder()) then makefolder(configFolder()) end end)
	local data = {}
	for flag, entry in pairs(Feather.Flags) do data[flag] = entry.get and entry.get() or entry.value end
	local ok = pcall(writefile, configFolder() .. "/" .. (name or "default") .. ".json", HttpService:JSONEncode(data))
	return ok
end
function Feather:LoadConfig(name)
	if not (readfile and isfile) then return false, "no readfile" end
	local path = configFolder() .. "/" .. (name or "default") .. ".json"
	if not isfile(path) then return false, "not found" end
	local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
	if not ok then return false, "bad file" end
	for flag, value in pairs(data) do
		local entry = Feather.Flags[flag]
		if entry and entry.set then pcall(entry.set, value) end
	end
	return true
end

function Feather:SetAccent(c)
	Theme.Accent = c
	for _, fn in ipairs(Feather._accentHooks or {}) do pcall(fn, c) end
end
Feather._accentHooks = {}

-- / window \ --
local ATLAS_B64 = "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"
local WORD_B64 = "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"
local GLOW_B64 = "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"
local BLOB_B64 = "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"
local LOGO_B64 = "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"
local QUILL_TIP = Vector2.new(0.9388, 0.0045)
local LOGO_ASPECT = 420 / 229
local WORD_W, WORD_H = 420, 150
local GLOW_PAD = 54
local WRITE_BINS = 210
-- every 7 numbers is one piece of ink: where it sits in the sheet, where it goes in the word, when it lands
local WRITE_TILES = {124, 85, 21, 16, 106, 9, 0, 463, 85, 19, 15, 96, 9, 1, 483, 85, 25, 15, 85, 11, 2, 146, 85, 24, 16, 74, 12, 3, 171, 85, 26, 16, 66, 15, 4, 75, 64, 19, 19, 59, 17, 5, 159, 40, 17, 21, 58, 21, 6, 77, 1, 17, 29, 53, 23, 7, 181, 1, 21, 26, 46, 34, 8, 177, 40, 20, 21, 42, 48, 9, 486, 1, 17, 23, 38, 53, 10, 95, 64, 19, 19, 34, 64, 11, 149, 1, 17, 27, 29, 66, 12, 55, 40, 19, 22, 24, 79, 13, 57, 1, 19, 30, 19, 84, 14, 237, 1, 18, 25, 15, 98, 15, 198, 40, 16, 21, 12, 112, 16, 215, 40, 16, 21, 9, 120, 17, 215, 103, 16, 14, 45, 64, 26, 1, 103, 21, 15, 50, 61, 27, 23, 103, 21, 15, 61, 59, 28, 45, 103, 19, 15, 70, 59, 29, 232, 103, 17, 14, 74, 59, 30, 359, 119, 12, 8, 81, 106, 36, 254, 119, 13, 12, 86, 106, 37, 323, 119, 13, 11, 91, 105, 38, 250, 103, 18, 14, 94, 100, 39, 198, 85, 13, 16, 105, 93, 40, 350, 40, 17, 20, 106, 86, 41, 115, 64, 14, 19, 112, 78, 42, 212, 85, 18, 16, 107, 74, 43, 269, 103, 21, 14, 101, 76, 44, 231, 85, 20, 16, 94, 80, 45, 368, 40, 18, 20, 87, 83, 46, 75, 40, 16, 22, 82, 89, 47, 232, 40, 16, 21, 79, 100, 48, 387, 40, 14, 20, 78, 107, 49, 240, 64, 16, 18, 80, 116, 50, 257, 64, 17, 18, 86, 119, 51, 291, 103, 19, 14, 92, 122, 52, 311, 103, 22, 14, 96, 119, 53, 394, 64, 20, 17, 104, 113, 54, 415, 64, 21, 17, 111, 108, 55, 334, 103, 12, 14, 124, 101, 56, 268, 119, 13, 12, 172, 79, 63, 282, 119, 12, 12, 173, 76, 64, 437, 64, 18, 17, 166, 71, 65, 347, 103, 20, 14, 161, 72, 66, 368, 103, 16, 14, 155, 75, 67, 456, 64, 17, 17, 148, 79, 68, 282, 1, 16, 24, 142, 81, 69, 299, 1, 16, 24, 137, 89, 70, 402, 40, 14, 20, 135, 104, 71, 249, 40, 14, 21, 134, 110, 72, 130, 64, 18, 19, 135, 119, 73, 385, 103, 14, 14, 144, 122, 74, 400, 103, 14, 14, 148, 118, 75, 474, 64, 17, 17, 151, 113, 76, 65, 103, 15, 15, 159, 106, 77, 275, 64, 17, 18, 161, 99, 78, 149, 64, 16, 19, 166, 88, 79, 166, 64, 17, 19, 168, 84, 80, 492, 64, 12, 17, 171, 86, 81, 112, 1, 15, 28, 164, 93, 82, 252, 85, 13, 16, 161, 114, 83, 293, 64, 13, 18, 162, 118, 84, 1, 85, 14, 17, 164, 122, 85, 415, 103, 16, 14, 166, 127, 86, 295, 119, 12, 12, 229, 39, 96, 432, 103, 14, 14, 225, 43, 97, 307, 64, 17, 18, 220, 47, 98, 266, 85, 16, 16, 216, 53, 99, 16, 85, 19, 17, 211, 60, 100, 417, 40, 15, 20, 207, 63, 101, 433, 40, 15, 20, 203, 70, 102, 449, 40, 17, 20, 199, 79, 103, 316, 1, 18, 24, 194, 86, 104, 264, 40, 15, 21, 191, 99, 105, 1, 40, 14, 23, 190, 106, 106, 283, 85, 15, 16, 191, 118, 107, 299, 85, 19, 16, 194, 121, 108, 447, 103, 21, 14, 197, 120, 109, 319, 85, 15, 16, 209, 113, 110, 81, 103, 15, 15, 215, 106, 111, 467, 40, 14, 20, 220, 99, 112, 469, 103, 15, 14, 196, 67, 119, 348, 119, 10, 10, 205, 68, 120, 116, 119, 25, 13, 208, 61, 121, 97, 103, 22, 15, 220, 58, 122, 485, 103, 19, 14, 232, 57, 123, 335, 85, 15, 16, 280, 20, 131, 184, 64, 15, 19, 276, 25, 132, 482, 40, 17, 20, 270, 33, 133, 128, 1, 20, 28, 264, 36, 134, 335, 1, 19, 24, 259, 50, 135, 355, 1, 19, 24, 253, 60, 136, 375, 1, 18, 24, 249, 70, 137, 394, 1, 17, 24, 244, 77, 138, 412, 1, 17, 24, 242, 86, 139, 430, 1, 18, 24, 237, 97, 140, 16, 40, 19, 23, 233, 107, 141, 92, 40, 14, 22, 230, 115, 142, 167, 1, 13, 27, 231, 112, 143, 1, 1, 16, 38, 236, 96, 144, 200, 64, 23, 19, 242, 91, 145, 325, 64, 17, 18, 255, 85, 146, 36, 85, 15, 17, 262, 81, 147, 280, 40, 22, 21, 268, 75, 148, 351, 85, 14, 16, 269, 84, 149, 343, 64, 15, 18, 264, 92, 150, 203, 1, 17, 26, 259, 94, 151, 1, 64, 15, 20, 256, 109, 152, 36, 40, 18, 23, 256, 112, 153, 120, 103, 15, 15, 264, 118, 154, 142, 119, 15, 13, 269, 116, 155, 17, 64, 19, 20, 271, 107, 156, 303, 40, 14, 21, 281, 101, 157, 1, 119, 13, 14, 283, 97, 158, 158, 119, 16, 13, 291, 105, 163, 308, 119, 14, 12, 299, 105, 164, 175, 119, 19, 13, 301, 101, 165, 136, 103, 20, 15, 307, 95, 166, 366, 85, 14, 16, 318, 88, 167, 52, 85, 14, 17, 321, 82, 168, 67, 85, 18, 17, 318, 74, 169, 157, 103, 18, 15, 313, 75, 170, 176, 103, 17, 15, 306, 79, 171, 37, 64, 18, 20, 299, 82, 172, 56, 64, 18, 20, 295, 90, 173, 318, 40, 17, 21, 290, 98, 174, 221, 1, 15, 26, 288, 101, 175, 107, 40, 16, 22, 289, 111, 176, 86, 85, 19, 17, 292, 120, 177, 15, 119, 23, 14, 295, 122, 178, 39, 119, 17, 14, 309, 120, 179, 381, 85, 23, 16, 311, 115, 180, 405, 85, 21, 16, 319, 108, 181, 57, 119, 13, 14, 331, 103, 182, 337, 119, 10, 11, 336, 101, 183, 18, 1, 38, 34, 341, 76, 189, 427, 85, 15, 16, 360, 80, 190, 359, 64, 17, 18, 356, 83, 191, 449, 1, 17, 24, 352, 89, 192, 467, 1, 18, 24, 348, 96, 193, 124, 40, 18, 22, 344, 107, 194, 143, 40, 15, 22, 341, 114, 195, 71, 119, 13, 14, 339, 127, 196, 95, 1, 16, 29, 343, 104, 197, 256, 1, 25, 25, 345, 101, 198, 195, 119, 21, 13, 354, 97, 199, 85, 119, 13, 14, 369, 89, 200, 99, 119, 16, 14, 373, 86, 201, 106, 85, 17, 17, 376, 81, 202, 224, 64, 15, 19, 384, 77, 203, 194, 103, 20, 15, 383, 74, 204, 336, 40, 13, 21, 376, 83, 205, 377, 64, 16, 18, 375, 92, 206, 217, 119, 18, 13, 379, 96, 207, 236, 119, 17, 13, 387, 94, 208, 443, 85, 19, 16, 392, 88, 209}
-- nib position over time: x, y, how far it is lifted off the page
local WRITE_PATH = {0.2762, 0.1128, 0, 0.2718, 0.1116, 0, 0.2646, 0.1108, 0, 0.2547, 0.1118, 0, 0.2427, 0.1146, 0, 0.2296, 0.1192, 0, 0.2163, 0.1253, 0, 0.2032, 0.1327, 0, 0.1911, 0.1408, 0, 0.1807, 0.1497, 0, 0.1724, 0.1605, 0, 0.1661, 0.1748, 0, 0.1613, 0.1935, 0, 0.1571, 0.2167, 0, 0.152, 0.2436, 0, 0.1458, 0.2736, 0, 0.1388, 0.3056, 0, 0.1317, 0.3379, 0, 0.1253, 0.3689, 0, 0.1199, 0.3977, 0, 0.1158, 0.4239, 0, 0.1119, 0.4475, 0, 0.1071, 0.4688, 0, 0.1013, 0.4901, 0, 0.0952, 0.5144, 0, 0.0891, 0.5427, 0, 0.0831, 0.5741, 0, 0.0772, 0.6072, 0, 0.0715, 0.6415, 0, 0.0659, 0.6767, 0, 0.0605, 0.7123, 0, 0.0553, 0.7476, 0, 0.0506, 0.7817, 0, 0.0466, 0.8124, 0, 0.0435, 0.8377, 0, 0.0416, 0.8562, 0, 0.0407, 0.8668, 0, 0.0409, 0.8688, 0.27, 0.0421, 0.8629, 0.46, 0.0446, 0.8492, 0.62, 0.0486, 0.8274, 0.75, 0.054, 0.7978, 0.86, 0.0606, 0.7612, 0.93, 0.0682, 0.7193, 0.98, 0.0763, 0.6746, 1, 0.0845, 0.6295, 0.99, 0.0923, 0.5868, 0.95, 0.0992, 0.5489, 0.88, 0.1049, 0.5176, 0.78, 0.1091, 0.494, 0.65, 0.112, 0.4785, 0.5, 0.1142, 0.4697, 0.31, 0.1169, 0.4653, 0.08, 0.1222, 0.4626, 0, 0.1307, 0.4596, 0, 0.1416, 0.4554, 0, 0.1538, 0.4503, 0, 0.1661, 0.4456, 0, 0.1773, 0.4421, 0, 0.1864, 0.4399, 0, 0.1923, 0.4391, 0, 0.1954, 0.4407, 0.21, 0.1966, 0.447, 0.45, 0.1975, 0.4602, 0.64, 0.1986, 0.4815, 0.79, 0.2001, 0.5109, 0.9, 0.2018, 0.5465, 0.97, 0.2038, 0.5857, 1, 0.2058, 0.6253, 0.98, 0.2076, 0.6619, 0.92, 0.2092, 0.6926, 0.82, 0.2103, 0.7155, 0.67, 0.2112, 0.7303, 0.49, 0.2121, 0.738, 0.26, 0.2139, 0.741, 0, 0.2176, 0.7412, 0, 0.2231, 0.7388, 0, 0.23, 0.7332, 0, 0.2379, 0.7237, 0, 0.2463, 0.7097, 0, 0.2546, 0.6917, 0, 0.2624, 0.6707, 0, 0.2691, 0.6482, 0, 0.2744, 0.6252, 0, 0.2778, 0.6025, 0, 0.2793, 0.5814, 0, 0.2783, 0.5643, 0, 0.2742, 0.5542, 0, 0.2678, 0.5525, 0, 0.2602, 0.558, 0, 0.2522, 0.5694, 0, 0.2442, 0.5858, 0, 0.2364, 0.6066, 0, 0.229, 0.6307, 0, 0.2224, 0.6568, 0, 0.2168, 0.6835, 0, 0.2124, 0.7107, 0, 0.209, 0.7377, 0, 0.2066, 0.7636, 0, 0.2056, 0.7878, 0, 0.2066, 0.8098, 0, 0.2097, 0.8285, 0, 0.2148, 0.843, 0, 0.2217, 0.8519, 0, 0.2301, 0.8548, 0, 0.2396, 0.8524, 0, 0.2496, 0.8455, 0, 0.2595, 0.8345, 0, 0.2692, 0.8196, 0, 0.2785, 0.8015, 0, 0.2871, 0.7814, 0, 0.2947, 0.7613, 0, 0.3009, 0.7428, 0, 0.3055, 0.7283, 0, 0.3087, 0.7191, 0.1, 0.3114, 0.7135, 0.36, 0.3151, 0.7082, 0.55, 0.3211, 0.7002, 0.72, 0.3299, 0.6887, 0.84, 0.3412, 0.6739, 0.93, 0.3543, 0.6567, 0.99, 0.3683, 0.6383, 1, 0.3822, 0.6201, 0.97, 0.3948, 0.6035, 0.91, 0.4054, 0.5896, 0.81, 0.4134, 0.5791, 0.67, 0.4186, 0.5722, 0.5, 0.4213, 0.5675, 0.29, 0.4222, 0.5623, 0, 0.4217, 0.5544, 0, 0.4198, 0.5446, 0, 0.4161, 0.5358, 0, 0.4107, 0.5309, 0, 0.4037, 0.5311, 0, 0.3959, 0.5365, 0, 0.3879, 0.5468, 0, 0.3801, 0.5621, 0, 0.3725, 0.5821, 0, 0.3652, 0.6064, 0, 0.3583, 0.6337, 0, 0.352, 0.6629, 0, 0.3465, 0.693, 0, 0.342, 0.7232, 0, 0.3387, 0.7532, 0, 0.3369, 0.7818, 0, 0.3366, 0.8074, 0, 0.3383, 0.8284, 0, 0.3423, 0.8434, 0, 0.3482, 0.8505, 0, 0.3552, 0.8495, 0, 0.3624, 0.8415, 0, 0.3692, 0.828, 0, 0.3757, 0.8107, 0, 0.3819, 0.7929, 0, 0.3881, 0.7764, 0, 0.3938, 0.7595, 0, 0.3987, 0.7383, 0, 0.4033, 0.7115, 0, 0.4081, 0.6813, 0, 0.413, 0.6517, 0, 0.4174, 0.6262, 0, 0.4202, 0.6086, 0, 0.4202, 0.6073, 0, 0.4165, 0.6308, 0, 0.4099, 0.6752, 0, 0.4032, 0.7255, 0, 0.3993, 0.7688, 0, 0.3983, 0.8027, 0, 0.3989, 0.8293, 0, 0.4007, 0.8497, 0, 0.4033, 0.8646, 0, 0.4066, 0.8753, 0, 0.4097, 0.8826, 0, 0.4122, 0.8863, 0, 0.4138, 0.8861, 0.21, 0.4154, 0.8814, 0.37, 0.418, 0.8712, 0.51, 0.4221, 0.8545, 0.63, 0.4279, 0.8306, 0.74, 0.4356, 0.7995, 0.82, 0.4448, 0.7617, 0.89, 0.4555, 0.7182, 0.95, 0.4671, 0.6705, 0.98, 0.4795, 0.6202, 1, 0.492, 0.569, 1, 0.5043, 0.5188, 0.98, 0.5159, 0.4715, 0.94, 0.5264, 0.4286, 0.89, 0.5355, 0.3915, 0.81, 0.5429, 0.3611, 0.73, 0.5486, 0.338, 0.62, 0.5525, 0.322, 0.5, 0.5548, 0.3127, 0.36, 0.5555, 0.3098, 0.2, 0.5543, 0.3144, 0, 0.5511, 0.3273, 0, 0.5464, 0.3466, 0, 0.5413, 0.3693, 0, 0.5366, 0.3932, 0, 0.5323, 0.4164, 0, 0.5276, 0.4372, 0, 0.5217, 0.4553, 0, 0.5151, 0.472, 0, 0.5092, 0.4893, 0, 0.5046, 0.5093, 0, 0.5008, 0.5334, 0, 0.4967, 0.5614, 0, 0.4919, 0.5923, 0, 0.4866, 0.625, 0, 0.4816, 0.6586, 0, 0.4772, 0.6924, 0, 0.4736, 0.7256, 0, 0.4711, 0.7573, 0, 0.4699, 0.7863, 0, 0.4704, 0.8113, 0, 0.473, 0.831, 0, 0.4778, 0.844, 0, 0.4845, 0.8494, 0, 0.4919, 0.8475, 0, 0.4996, 0.8394, 0, 0.507, 0.8255, 0, 0.5143, 0.8062, 0, 0.5214, 0.783, 0, 0.528, 0.7587, 0, 0.5336, 0.7366, 0, 0.5377, 0.719, 0, 0.54, 0.7073, 0.03, 0.5403, 0.6995, 0.34, 0.5385, 0.6908, 0.57, 0.5349, 0.6773, 0.74, 0.5296, 0.6576, 0.88, 0.5228, 0.6326, 0.96, 0.5152, 0.6044, 1, 0.5074, 0.5755, 0.99, 0.5001, 0.5486, 0.92, 0.494, 0.5262, 0.81, 0.4895, 0.5097, 0.66, 0.487, 0.4993, 0.46, 0.4866, 0.4939, 0.2, 0.4888, 0.4909, 0, 0.4939, 0.4881, 0, 0.502, 0.4825, 0, 0.513, 0.4713, 0, 0.5257, 0.4562, 0, 0.5384, 0.4436, 0, 0.5501, 0.4359, 0, 0.5602, 0.4307, 0, 0.5678, 0.4268, 0, 0.5727, 0.4236, 0.09, 0.5758, 0.42, 0.33, 0.5792, 0.4135, 0.53, 0.5843, 0.4024, 0.69, 0.5918, 0.3859, 0.82, 0.6017, 0.3644, 0.91, 0.6134, 0.3388, 0.97, 0.6262, 0.3108, 1, 0.6393, 0.2823, 0.99, 0.6517, 0.2553, 0.95, 0.6626, 0.2314, 0.87, 0.6714, 0.2122, 0.76, 0.6777, 0.1984, 0.61, 0.6816, 0.1902, 0.44, 0.683, 0.188, 0.23, 0.6821, 0.193, 0, 0.6791, 0.2064, 0, 0.6744, 0.2274, 0, 0.6686, 0.2545, 0, 0.662, 0.2857, 0, 0.6552, 0.3192, 0, 0.6484, 0.3535, 0, 0.6417, 0.3881, 0, 0.6351, 0.4226, 0, 0.6286, 0.4568, 0, 0.6223, 0.4906, 0, 0.6163, 0.524, 0, 0.6107, 0.5568, 0, 0.6059, 0.588, 0, 0.602, 0.6175, 0, 0.5988, 0.6455, 0, 0.5952, 0.6727, 0, 0.5904, 0.7011, 0, 0.5848, 0.7319, 0, 0.579, 0.7643, 0, 0.5736, 0.7956, 0, 0.5693, 0.8226, 0, 0.5666, 0.8402, 0, 0.5667, 0.8396, 0, 0.5711, 0.8131, 0, 0.5793, 0.7661, 0, 0.5895, 0.7163, 0, 0.5998, 0.6784, 0, 0.6094, 0.6544, 0, 0.6185, 0.6367, 0, 0.6271, 0.6199, 0, 0.6354, 0.6043, 0, 0.6434, 0.5925, 0, 0.6503, 0.5861, 0, 0.6548, 0.587, 0, 0.6561, 0.5975, 0, 0.6543, 0.6168, 0, 0.6505, 0.642, 0, 0.6454, 0.6705, 0, 0.6399, 0.7005, 0, 0.6348, 0.7305, 0, 0.631, 0.7587, 0, 0.6288, 0.7844, 0, 0.6286, 0.8062, 0, 0.631, 0.8221, 0, 0.636, 0.8296, 0, 0.6427, 0.8289, 0, 0.6501, 0.8217, 0, 0.6574, 0.8089, 0, 0.6645, 0.7903, 0, 0.6716, 0.7674, 0, 0.6783, 0.7429, 0, 0.684, 0.7202, 0, 0.6883, 0.7022, 0, 0.6911, 0.691, 0, 0.6929, 0.6873, 0.38, 0.6945, 0.6896, 0.66, 0.6966, 0.696, 0.86, 0.6995, 0.7052, 0.98, 0.7028, 0.7155, 1, 0.7059, 0.7254, 0.92, 0.7084, 0.7333, 0.76, 0.7102, 0.7384, 0.51, 0.7121, 0.7409, 0.16, 0.715, 0.7416, 0, 0.7197, 0.7404, 0, 0.726, 0.7364, 0, 0.7334, 0.7289, 0, 0.7416, 0.7171, 0, 0.75, 0.701, 0, 0.7581, 0.6815, 0, 0.7654, 0.6598, 0, 0.7713, 0.6371, 0, 0.7757, 0.6141, 0, 0.7783, 0.5918, 0, 0.7786, 0.5722, 0, 0.776, 0.5583, 0, 0.7707, 0.5524, 0, 0.7636, 0.5544, 0, 0.7558, 0.5629, 0, 0.7478, 0.5769, 0, 0.7398, 0.5956, 0, 0.7321, 0.6183, 0, 0.725, 0.6435, 0, 0.7189, 0.6698, 0, 0.7139, 0.6966, 0, 0.7101, 0.7236, 0, 0.7071, 0.7502, 0, 0.7053, 0.7753, 0, 0.7053, 0.7985, 0, 0.7073, 0.8192, 0, 0.7114, 0.8362, 0, 0.7174, 0.8481, 0, 0.7251, 0.8541, 0, 0.7341, 0.8543, 0, 0.744, 0.8496, 0, 0.754, 0.8406, 0, 0.7638, 0.8276, 0, 0.7733, 0.8109, 0, 0.7823, 0.7917, 0, 0.7904, 0.7715, 0, 0.7973, 0.752, 0, 0.8028, 0.7351, 0, 0.8067, 0.723, 0, 0.8093, 0.7153, 0.26, 0.812, 0.7089, 0.5, 0.8162, 0.6998, 0.69, 0.8226, 0.6862, 0.84, 0.831, 0.6683, 0.94, 0.8408, 0.6472, 0.99, 0.8512, 0.625, 1, 0.8611, 0.6037, 0.95, 0.8698, 0.5852, 0.86, 0.8764, 0.5709, 0.72, 0.8808, 0.5617, 0.53, 0.8827, 0.558, 0.3, 0.8821, 0.5604, 0, 0.8793, 0.5696, 0, 0.8748, 0.5848, 0, 0.8696, 0.6045, 0, 0.8645, 0.6273, 0, 0.8602, 0.6518, 0, 0.8569, 0.6766, 0, 0.8538, 0.7012, 0, 0.8499, 0.7267, 0, 0.8447, 0.7549, 0, 0.8391, 0.7856, 0, 0.8337, 0.8164, 0, 0.8292, 0.8433, 0, 0.8264, 0.861, 0, 0.8264, 0.861, 0, 0.8306, 0.8363, 0, 0.8386, 0.7926, 0, 0.8483, 0.7474, 0, 0.8579, 0.7144, 0, 0.8668, 0.6938, 0, 0.875, 0.6772, 0, 0.8829, 0.6601, 0, 0.8906, 0.6441, 0, 0.8979, 0.6316, 0, 0.9046, 0.6217, 0, 0.9106, 0.6102, 0, 0.9166, 0.595, 0, 0.9229, 0.5782, 0, 0.9285, 0.5639, 0, 0.9313, 0.5571, 0, 0.9291, 0.5632, 0, 0.9226, 0.5834, 0, 0.9159, 0.6118, 0, 0.9126, 0.64, 0, 0.9137, 0.6616, 0, 0.9182, 0.6736, 0, 0.9251, 0.6767, 0, 0.933, 0.6734, 0, 0.9408, 0.6661, 0, 0.9479, 0.6568, 0, 0.9537, 0.6475, 0, 0.9575, 0.6408, 0}

local assetCache = {}
local function b64Asset(name, data)
	local hit = assetCache[name]
	if hit ~= nil then return hit or nil end
	assetCache[name] = false
	if not hasAssets or data == "" then return nil end
	ensureFolder()
	local path = "Feather/" .. name
	local ok, id = pcall(function()
		if not (isfile and isfile(path)) then writefile(path, B64.decode(data)) end
		return loadAsset(path)
	end)
	if ok and id then assetCache[name] = id return id end
	return nil
end

-- files older builds left behind
if delfile and isfile then
	for _, old in ipairs({"sheet0.png", "sheet1.png", "glowsheet.png", "glow.png", "blob.png", "wordmark.png", "logo.png", "logo_small.png"}) do
		pcall(function() if isfile("Feather/" .. old) then delfile("Feather/" .. old) end end)
	end
end

local function pathAt(p)
	local n = #WRITE_PATH / 3
	if n < 2 then return 0.5, 0.5, 0 end
	local f = math.clamp(p, 0, 1) * (n - 1)
	local i = math.min(math.floor(f), n - 2)
	local t = f - i
	local a, b = i * 3, i * 3 + 3
	return WRITE_PATH[a + 1] + (WRITE_PATH[b + 1] - WRITE_PATH[a + 1]) * t,
		WRITE_PATH[a + 2] + (WRITE_PATH[b + 2] - WRITE_PATH[a + 2]) * t,
		WRITE_PATH[a + 3] + (WRITE_PATH[b + 3] - WRITE_PATH[a + 3]) * t
end

-- mouse in the same space AbsolutePosition uses
local function mousePos()
	local m = UserInputService:GetMouseLocation()
	local inset = GuiService:GetGuiInset()
	return Vector2.new(m.X - inset.X, m.Y - inset.Y)
end

local function inside(gui, pos)
	if not (gui and gui.Parent and gui.Visible) then return false end
	local p, s = gui.AbsolutePosition, gui.AbsoluteSize
	return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
end

local function isPress(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end

local function makeDraggable(handle, target, onStart)
	local dragging, startMouse, startPos, goal, step
	handle.InputBegan:Connect(function(input)
		if not isPress(input) then return end
		dragging = true
		startMouse = UserInputService:GetMouseLocation()
		startPos = target.Position
		goal = startPos
		if onStart then onStart() end
		if not step then
			step = RunService.RenderStepped:Connect(function(dt)
				if not target.Parent then step:Disconnect() step = nil return end
				if dragging then
					local delta = UserInputService:GetMouseLocation() - startMouse
					goal = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
				local cur = target.Position
				local a = 1 - math.exp(-math.min(dt, 0.1) * 22)
				local nx = cur.X.Offset + (goal.X.Offset - cur.X.Offset) * a
				local ny = cur.Y.Offset + (goal.Y.Offset - cur.Y.Offset) * a
				target.Position = UDim2.new(goal.X.Scale, nx, goal.Y.Scale, ny)
				if not dragging and math.abs(goal.X.Offset - nx) < 0.5 and math.abs(goal.Y.Offset - ny) < 0.5 then
					target.Position = goal
					step:Disconnect()
					step = nil
				end
			end)
		end
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end)
end

local W, H, HEAD = 728, 504, 60
local SIDE_W, GAP = 196, 1
local MAIN_X = SIDE_W + GAP
local MAIN_W = W - MAIN_X
local ROW = 40
local ROW_W = MAIN_W - 36 - 24
local ITEM_W = SIDE_W - 20
local ITEM_H = 36
local KEY_SHORT = {RightShift = "RShift", LeftShift = "LShift", RightControl = "RCtrl", LeftControl = "LCtrl", RightAlt = "RAlt", LeftAlt = "LAlt", Insert = "Ins", Delete = "Del", Backquote = "`"}

function Feather:CreateWindow(opts)
	opts = opts or {}
	if opts.Accent then Theme.Accent = opts.Accent end
	if typeof(opts.Keybind) == "EnumItem" then Feather.ToggleKey = opts.Keybind end
	local gui = new("ScreenGui", {Name = HttpService:GenerateGUID(false), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
	hudParent(gui)
	local conns = {}
	local function track(c) table.insert(conns, c) return c end

	-- shrink a little on small screens so nothing hangs off the edge
	local cam = workspace.CurrentCamera
	local view = cam and cam.ViewportSize or Vector2.new(1920, 1080)
	local fit = math.clamp(math.min((view.Y - 70) / H, (view.X - 40) / W), 0.55, 1)

	local root = new("Frame", {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0.5, -math.floor(H * fit / 2)), Size = UDim2.fromOffset(W, H), BackgroundTransparency = 1, Visible = false, Parent = gui})
	local rootScale = new("UIScale", {Scale = fit, Parent = root})
	-- one sheet of glass: tabs down the left, the open tab on the right, a thin line between them.
	-- panel only exists to fade it, and is a hair bigger so the outline is not cut off
	local panel = new("CanvasGroup", {BackgroundTransparency = 1, GroupTransparency = 1, Position = UDim2.fromOffset(-3, -3), Size = UDim2.new(1, 6, 1, 6), Parent = root})
	local glass = math.clamp(tonumber(opts.Transparency) or 0.06, 0, 0.6)
	local function island(x, w)
		local isle = new("CanvasGroup", {BackgroundColor3 = Theme.bg, BackgroundTransparency = glass, Position = UDim2.fromOffset(x + 3, 3), Size = UDim2.new(0, w, 1, -6), Parent = panel}, {corner(15)})
		local edge = outline(isle, 15, Color3.new(1, 1, 1), 0)
		new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(74, 74, 82), Color3.fromRGB(34, 34, 39)), Parent = edge})
		new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 150), ZIndex = 0, Parent = isle}, {new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(0.95, 1)})})
		return isle
	end
	local isle = island(0, W)
	-- the sidebar is the same window, just a shade darker
	local sideIsle = new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.78, BorderSizePixel = 0, Size = UDim2.new(0, SIDE_W, 1, 0), Parent = isle})
	new("Frame", {BackgroundColor3 = Theme.line, BackgroundTransparency = 0.15, BorderSizePixel = 0, Position = UDim2.fromOffset(SIDE_W, 0), Size = UDim2.new(0, 1, 1, 0), Parent = isle})
	local mainIsle = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(MAIN_X, 0), Size = UDim2.new(0, MAIN_W, 1, 0), Parent = isle})

	-- popups live above everything so cards and scrolling never cut them off
	local overlay = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 200, Parent = gui})
	local openPopup
	local hideSearch
	local function closePopup()
		if hideSearch then hideSearch() end
		local p = openPopup
		if not p then return end
		openPopup = nil
		go(p.frame, 0.12, {GroupTransparency = 1})
		task.delay(0.13, function()
			if not (openPopup and openPopup.frame == p.frame) then p.frame.Visible = false end
		end)
		if p.onClose then p.onClose() end
	end
	local function showPopup(frame, anchor, owner, width, height, onClose)
		if openPopup and openPopup.frame == frame then closePopup() return false end
		closePopup()
		local base, area = overlay.AbsolutePosition, overlay.AbsoluteSize
		local ap, as = anchor.AbsolutePosition - base, anchor.AbsoluteSize
		local x = math.clamp(ap.X + as.X - width, 8, math.max(8, area.X - width - 8))
		local y = ap.Y + as.Y + 6
		if y + height > area.Y - 8 then y = math.max(8, ap.Y - height - 6) end
		frame.Position = UDim2.fromOffset(x, y)
		frame.GroupTransparency = 1
		frame.Visible = true
		local sc = frame:FindFirstChildOfClass("UIScale") or new("UIScale", {Parent = frame})
		sc.Scale = 0.96
		go(sc, 0.22, {Scale = 1})
		go(frame, 0.16, {GroupTransparency = 0})
		openPopup = {frame = frame, owner = owner, onClose = onClose}
		return true
	end
	track(UserInputService.InputBegan:Connect(function(input)
		if not openPopup or not isPress(input) then return end
		local pos = Vector2.new(input.Position.X, input.Position.Y)
		if not (inside(openPopup.frame, pos) or inside(openPopup.owner, pos)) then closePopup() end
	end))

	-- one row is lit at a time, and it lets go as soon as the mouse is really off it
	local hovered
	local function setHover(row)
		if hovered == row then return end
		if hovered then go(hovered, 0.25, {BackgroundColor3 = Theme.panel}) end
		hovered = row
		if row then go(row, 0.15, {BackgroundColor3 = Theme.raised}) end
	end
	track(UserInputService.InputChanged:Connect(function(input)
		if hovered and input.UserInputType == Enum.UserInputType.MouseMovement and not inside(hovered, Vector2.new(input.Position.X, input.Position.Y)) then setHover(nil) end
	end))

	-- left island: brand up top, tabs in the middle, whoever is playing at the bottom
	local sideHead = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, HEAD), ZIndex = 4, Parent = sideIsle})
	local hasTitle = (opts.Title or "") ~= ""
	local headLogo = new("ImageLabel", {BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, ImageColor3 = Theme.text, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 1), Size = UDim2.fromOffset(38, 21), Visible = false, Parent = sideHead})
	local headWord = new("ImageLabel", {BackgroundTransparency = 1, ImageColor3 = Theme.text, Position = UDim2.fromOffset(60, hasTitle and 11 or 17), Size = UDim2.fromOffset(81, 29), Visible = false, Parent = sideHead})
	local headText = label({Text = opts.Name or "Feather", Font = BOLD, TextSize = 16, Position = UDim2.fromOffset(18, hasTitle and 14 or 20), Size = UDim2.fromOffset(SIDE_W - 32, 20), Parent = sideHead})
	local titleLabel = label({Text = opts.Title or "", Font = REG, TextSize = 10, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(63, 39), Size = UDim2.fromOffset(SIDE_W - 72, 12), Parent = sideHead})
	do
		local word = b64Asset("word4.png", WORD_B64)
		local quill = b64Asset("quill4.png", LOGO_B64)
		if word then headWord.Image = word headWord.Visible = true headText.Visible = false end
		if quill then headLogo.Image = quill headLogo.Visible = true end
		if not word then titleLabel.Position = UDim2.fromOffset(18, 36) end
	end
	new("Frame", {BackgroundColor3 = Theme.line, BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromOffset(14, HEAD), Size = UDim2.fromOffset(SIDE_W - 28, 1), Parent = sideIsle})

	-- everything below the top strips is pinned from the top with a fixed height, so minimizing just slides the bottom edge up over it
	local showProfile = opts.Profile ~= false
	local NAV_TOP = HEAD + 9
	local NAV_H = H - NAV_TOP - (showProfile and 62 or 10)
	-- tabs are placed by hand instead of a list layout so the highlight can slide between them
	local nav = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(0, NAV_TOP), Size = UDim2.fromOffset(SIDE_W, NAV_H), CanvasSize = UDim2.new(), ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.Y, Parent = sideIsle})
	-- the highlight: a soft sheet of light that is brightest by the marker on its left
	local glide = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 4), Size = UDim2.fromOffset(ITEM_W, ITEM_H), ZIndex = 0, Parent = nav}, {corner(10), new("UIGradient", {Transparency = NumberSequence.new(0.86, 0.965)})})
	local glideStroke = stroke(Color3.new(1, 1, 1), 1)
	glideStroke.Parent = glide
	local glideBar = new("Frame", {BackgroundColor3 = Theme.Accent, BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(3, 16), Parent = glide}, {corner(2)})
	table.insert(Feather._accentHooks, function(c) glideBar.BackgroundColor3 = c end)
	local navY = 4

	local keyChip, keyText
	local function refreshKey()
		if not keyChip then return end
		local k = Feather.ToggleKey
		local name = k and (KEY_SHORT[k.Name] or string.sub(k.Name, 1, 7)) or "None"
		local w = math.ceil(textSize(name, 10, BOLD).X) + 14
		keyText.Text = name
		keyChip.Size = UDim2.fromOffset(w, 20)
	end
	Feather._keyHook = refreshKey
	if showProfile then
		local py = H - 54
		new("Frame", {BackgroundColor3 = Theme.line, BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromOffset(14, py), Size = UDim2.fromOffset(SIDE_W - 28, 1), Parent = sideIsle})
		local face = new("ImageLabel", {BackgroundColor3 = Theme.hover, Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=48&h=48", Position = UDim2.fromOffset(14, py + 12), Size = UDim2.fromOffset(30, 30), Parent = sideIsle}, {corner(15)})
		local ring = stroke(Theme.line, 0)
		ring.Parent = face
		new("Frame", {BackgroundColor3 = Theme.good, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 1, 1, 1), Size = UDim2.fromOffset(9, 9), ZIndex = 2, Parent = face}, {corner(5), stroke(Color3.fromRGB(8, 8, 10), 0, 2)})
		label({Text = LocalPlayer.DisplayName, Font = BOLD, TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(53, py + 12), Size = UDim2.fromOffset(SIDE_W - 53 - 66, 15), Parent = sideIsle})
		label({Text = "@" .. LocalPlayer.Name, Font = REG, TextSize = 10, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(53, py + 28), Size = UDim2.fromOffset(SIDE_W - 53 - 66, 12), Parent = sideIsle})
		-- the key that brings the menu back, so nobody has to remember it
		keyChip = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromOffset(SIDE_W - 14, py + 17), Size = UDim2.fromOffset(40, 20), Parent = sideIsle}, {corner(6), stroke(Theme.line, 0)})
		keyText = label({Text = "", Font = BOLD, TextSize = 10, TextColor3 = Theme.sub, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = keyChip})
		refreshKey()
	end

	-- right island: what is open, the window buttons, then the page itself
	local header = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, HEAD), ZIndex = 4, Parent = mainIsle})
	local headTile = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 18, 0.5, 0), Size = UDim2.fromOffset(32, 32), Parent = header}, {corner(10), stroke(Theme.line, 0)})
	local tabTitle = label({Text = "", Font = BOLD, TextSize = 16, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(61, 20), Size = UDim2.new(1, -(61 + 96 + 158), 0, 20), Parent = header})
	local tabHint = label({Text = "", Font = REG, TextSize = 11, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(61, 34), Size = UDim2.new(1, -(61 + 96 + 158), 0, 13), Parent = header})
	local headRule = new("Frame", {BackgroundColor3 = Theme.line, BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromOffset(18, HEAD), Size = UDim2.new(1, -36, 0, 1), Parent = mainIsle})
	local function setHint(text)
		tabHint.Text = text
		tabTitle.Position = UDim2.fromOffset(61, text == "" and 20 or 12)
	end

	local function headerButton(x, icon, hot)
		local b = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, x, 0.5, 0), Size = UDim2.fromOffset(28, 28), Parent = header}, {corner(9)})
		local bs = stroke(Theme.line, 0)
		bs.Parent = b
		local img = makeIcon(b, icon, 14, Theme.sub)
		img.AnchorPoint = Vector2.new(0.5, 0.5)
		img.Position = UDim2.fromScale(0.5, 0.5)
		b.MouseEnter:Connect(function() go(b, 0.15, {BackgroundColor3 = Theme.hover}) go(bs, 0.15, {Color = hot or Theme.dim}) go(img, 0.15, {ImageColor3 = hot or Theme.text}) end)
		b.MouseLeave:Connect(function() go(b, 0.25, {BackgroundColor3 = Theme.raised}) go(bs, 0.25, {Color = Theme.line}) go(img, 0.25, {ImageColor3 = Theme.sub}) end)
		return b
	end
	local closeBtn = headerButton(-16, "x", Theme.bad)
	local minBtn = headerButton(-50, "minus")

	local body = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, HEAD + 1), Size = UDim2.fromOffset(MAIN_W, H - HEAD - 1), ClipsDescendants = true, Parent = mainIsle})
	new("Frame", {BackgroundColor3 = Theme.bg, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 20), ZIndex = 5, Parent = body}, {new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(1, 0.15)})})

	local Window = {tabs = {}, _rows = {}, _active = nil, _order = 0, _category = nil}

	-- a tab is just an icon and a name until it is open, then the light slides in behind it
	local function paintTab(t, instant)
		local on = Window._active == t
		local lit = on or t.hover
		local d = instant and 0 or 0.25
		go(t._icon, d, {ImageColor3 = lit and Theme.text or Theme.sub})
		go(t._label, d, {TextColor3 = lit and Theme.text or Theme.sub, Position = UDim2.fromOffset((t.hover and not on) and 43 or 40, 0)})
		go(t._arrow, d, {ImageTransparency = on and 0.45 or 1})
		t._label.Font = on and BOLD or FONT
	end

	local function pageHint(tab)
		if tab.desc then return tostring(tab.desc) end
		return ""
	end

	local function selectTab(tab)
		if Window._active == tab then return end
		closePopup()
		setHover(nil)
		local old = Window._active
		Window._active = tab
		if old then
			old.host.Visible = false
			old._headIcon.Visible = false
			paintTab(old)
		end
		tab.host.Visible = true
		tab.host.GroupTransparency = 1
		tab.host.Position = UDim2.fromOffset(0, 10)
		go(tab.host, 0.35, {GroupTransparency = 0, Position = UDim2.fromOffset(0, 0)})
		tab._headIcon.Visible = true
		tab._headIcon.ImageTransparency = 1
		go(tab._headIcon, 0.35, {ImageTransparency = 0})
		tabTitle.Text = tab.name
		setHint(pageHint(tab))
		tabTitle.TextTransparency = 1
		tabHint.TextTransparency = 1
		go(tabTitle, 0.35, {TextTransparency = 0})
		go(tabHint, 0.45, {TextTransparency = 0})
		local d = old and 0.4 or 0
		go(glide, d, {Position = UDim2.fromOffset(10, tab.y), BackgroundTransparency = 0})
		go(glideStroke, d, {Transparency = 0.9})
		go(glideBar, d, {BackgroundTransparency = 0})
		paintTab(tab)
	end

	-- small heading between groups of tabs, with a line running off to the right of it
	function Window:Category(name)
		Window._category = name
		name = tostring(name)
		navY += (navY > 4) and 9 or 2
		local w = math.ceil(textSize(name, 10, BOLD).X)
		local head = label({Text = name, Font = BOLD, TextSize = 10, TextColor3 = Theme.dim, Position = UDim2.fromOffset(16, navY), Size = UDim2.fromOffset(w + 2, 14), Parent = nav})
		new("Frame", {BackgroundColor3 = Theme.line, BackgroundTransparency = 0.45, BorderSizePixel = 0, Position = UDim2.fromOffset(16 + w + 8, navY + 7), Size = UDim2.fromOffset(math.max(SIDE_W - 16 - w - 8 - 14, 0), 1), Parent = nav})
		navY += 19
		nav.CanvasSize = UDim2.fromOffset(0, navY + 6)
		return head
	end

	function Window:Tab(tabOpts)
		tabOpts = tabOpts or {}
		local name = tostring(tabOpts.Name or "Tab")
		local category = tabOpts.Category
		if category and category ~= Window._category then Window:Category(category) end

		local host = new("CanvasGroup", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = body})
		-- pages of a tab are plain words in a row, and a little line slides under the open one
		local pageBar = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(20, 5), Size = UDim2.new(1, -40, 0, 30), Visible = false, Parent = host})
		local pageRule = new("Frame", {BackgroundColor3 = Theme.line, BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromOffset(18, 36), Size = UDim2.new(1, -36, 0, 1), Visible = false, Parent = host})
		local pick = new("Frame", {BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Position = UDim2.fromOffset(20, 35), Size = UDim2.fromOffset(0, 2), ZIndex = 2, Visible = false, Parent = host}, {corner(1)})
		table.insert(Feather._accentHooks, function(c) pick.BackgroundColor3 = c end)
		local pageHost = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, Parent = host})
		new("Frame", {BackgroundColor3 = Theme.bg, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 10), ZIndex = 5, Parent = pageHost}, {new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(0.15, 1)})})
		local segX = 0

		local y = navY
		navY += ITEM_H + 3
		nav.CanvasSize = UDim2.fromOffset(0, navY + 6)
		local btn = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Position = UDim2.fromOffset(10, y), Size = UDim2.fromOffset(ITEM_W, ITEM_H), Parent = nav})
		local iconImg = makeIcon(btn, tabOpts.Icon or "square", 16, Theme.sub)
		iconImg.AnchorPoint = Vector2.new(0, 0.5)
		iconImg.Position = UDim2.new(0, 14, 0.5, 0)
		local btnLabel = label({Text = name, TextSize = 13, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(40, 0), Size = UDim2.new(1, -66, 1, 0), Parent = btn})
		local arrow = makeIcon(btn, "chevron-right", 13, Theme.text)
		arrow.AnchorPoint = Vector2.new(1, 0.5)
		arrow.Position = UDim2.new(1, -9, 0.5, 0)
		arrow.ImageTransparency = 1
		local headIcon = makeIcon(headTile, tabOpts.Icon or "square", 16, Theme.text)
		headIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		headIcon.Position = UDim2.fromScale(0.5, 0.5)
		headIcon.Visible = false
		local tab = {name = name, desc = tabOpts.Description, y = y, host = host, btn = btn, _icon = iconImg, _label = btnLabel, _arrow = arrow, _headIcon = headIcon, hover = false, pages = {}, _activePage = nil}
		btn.MouseEnter:Connect(function() tab.hover = true paintTab(tab) end)
		btn.MouseLeave:Connect(function() tab.hover = false paintTab(tab) end)

		local function movePick(instant)
			local pg = tab._activePage
			if not pg then return end
			local pos, size = UDim2.fromOffset(20 + pg.x, 35), UDim2.fromOffset(pg.w, 2)
			if instant then
				pick.Position = pos
				pick.Size = size
			else
				go(pick, 0.35, {Position = pos, Size = size})
			end
		end

		local function selectPage(page)
			if tab._activePage == page then return end
			closePopup()
			setHover(nil)
			local had = tab._activePage ~= nil
			tab._activePage = page
			if Window._active == tab then setHint(pageHint(tab)) end
			for _, p in ipairs(tab.pages) do
				local on = p == page
				p.scroller.Visible = on
				go(p._label, 0.2, {TextColor3 = on and Theme.text or Theme.sub})
				if p._icon then go(p._icon, 0.2, {ImageColor3 = on and Theme.text or Theme.sub}) end
			end
			movePick(not had)
			if had then
				page.scroller.Position = UDim2.fromOffset(0, 8)
				go(page.scroller, 0.3, {Position = UDim2.fromOffset(0, 0)})
			end
		end

		function tab:Page(pageOpts)
			pageOpts = pageOpts or {}
			local scroller = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.dim, ScrollBarImageTransparency = 0.3, ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false, Parent = pageHost}, {
				new("UIListLayout", {Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder}),
				new("UIPadding", {PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 18), PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 22)}),
			})
			track(scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
				closePopup()
				setHover(nil)
			end))

			local pageName = tostring(pageOpts.Name or "Page")
			local segText = math.ceil(textSize(pageName, 12, FONT).X) + 2
			local segW = segText + (pageOpts.Icon and 20 or 0)
			local seg = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Position = UDim2.fromOffset(segX, 0), Size = UDim2.fromOffset(segW, 30), Parent = pageBar})
			local pageIcon
			if pageOpts.Icon then
				pageIcon = makeIcon(seg, pageOpts.Icon, 14, Theme.sub)
				pageIcon.AnchorPoint = Vector2.new(0, 0.5)
				pageIcon.Position = UDim2.fromScale(0, 0.5)
			end
			local segLabel = label({Text = pageName, TextSize = 12, TextColor3 = Theme.sub, Position = UDim2.fromOffset(pageOpts.Icon and 20 or 0, 0), Size = UDim2.new(0, segText, 1, 0), Parent = seg})

			local page = {name = pageName, x = segX, w = segW, scroller = scroller, _seg = seg, _label = segLabel, _icon = pageIcon}
			page._select = function() selectPage(page) end
			segX += segW + 20
			table.insert(tab.pages, page)
			seg.MouseButton1Click:Connect(function() selectPage(page) end)
			seg.MouseEnter:Connect(function() if tab._activePage ~= page then go(segLabel, 0.15, {TextColor3 = Theme.text}) end end)
			seg.MouseLeave:Connect(function() if tab._activePage ~= page then go(segLabel, 0.2, {TextColor3 = Theme.sub}) end end)
			if #tab.pages > 1 then
				pageBar.Visible = true
				pageRule.Visible = true
				pick.Visible = true
				pageHost.Position = UDim2.fromOffset(0, 43)
				pageHost.Size = UDim2.new(1, 0, 1, -43)
				if Window._active == tab then setHint(pageHint(tab)) end
			end

			local groups = 0
			local function addGroup(name)
				groups += 1
				-- each group keeps its own rows together no matter what order a script fills them in
				local box = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = groups, Parent = scroller}, {new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder})})
				if name and name ~= "" then
					local head = label({Text = tostring(name), Font = BOLD, TextSize = 11, TextColor3 = Theme.sub, Size = UDim2.new(1, 0, 0, 15), LayoutOrder = 0, Parent = box})
					new("UIPadding", {PaddingLeft = UDim.new(0, 3), Parent = head})
				end

				local Group = {}
				local order = 0

				-- reserve is the room the control on the right needs, so long text wraps instead of running under it
				local function baseRow(o, reserve, cfg)
					o = o or {}
					cfg = cfg or {}
					order += 1
					local leftX = o.Icon and 27 or 0
					local textW = ROW_W - leftX - (reserve or 0)
					local hasDesc = o.Description ~= nil and o.Description ~= ""
					local descH = 0
					if hasDesc then descH = math.min(math.ceil(textSize(o.Description, 11, REG, textW).Y), 40) end
					local height = cfg.height or ROW
					if cfg.top then
						height += hasDesc and descH + 3 or 0
					elseif hasDesc then
						height = math.max(height, 11 + 16 + 3 + descH + 11)
					end
					local row = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.panel, Size = UDim2.new(1, 0, 0, height), LayoutOrder = order, Parent = box}, {corner(10)})
					local rowStroke = stroke(Theme.line, 0.25)
					rowStroke.Parent = row
					if o.Name and o.Name ~= "" then table.insert(Window._rows, {name = tostring(o.Name), tab = tab, page = page, row = row, stroke = rowStroke}) end
					if not cfg.plain then row.MouseEnter:Connect(function() setHover(row) end) end
					local content = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -24, 1, 0), Parent = row})
					if o.Icon then
						local ic = makeIcon(content, o.Icon, 16, Theme.sub)
						ic.AnchorPoint = Vector2.new(0, 0.5)
						ic.Position = cfg.top and UDim2.fromOffset(0, 19) or UDim2.new(0, 0, 0.5, 0)
					end
					local split = hasDesc or cfg.top
					label({Text = o.Name or "", TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(leftX, split and 11 or 0), Size = UDim2.fromOffset(textW, split and 16 or height), Parent = content})
					if hasDesc then
						label({Text = o.Description, Font = REG, TextSize = 11, TextColor3 = Theme.sub, TextWrapped = true, TextTruncate = Enum.TextTruncate.AtEnd, TextYAlignment = Enum.TextYAlignment.Top, Position = UDim2.fromOffset(leftX, 30), Size = UDim2.fromOffset(textW, descH), Parent = content})
					end
					return content, row, hasDesc and descH + 3 or 0
				end

				function Group:Toggle(o)
					local content, row = baseRow(o, 54)
					local state = o.Default and true or false
					local sw = new("Frame", {BackgroundColor3 = Theme.line, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(38, 22), Parent = content}, {corner(11)})
					local knob = new("Frame", {BackgroundColor3 = Theme.sub, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 0), Size = UDim2.fromOffset(16, 16), Parent = sw}, {corner(8)})
					local control = {}
					local function apply(v, fire, instant)
						state = v and true or false
						local d = instant and 0 or 0.26
						go(sw, d, {BackgroundColor3 = state and Theme.Accent or Theme.line})
						go(knob, d, {Position = UDim2.new(0, state and 19 or 3, 0.5, 0), BackgroundColor3 = state and Theme.onAccent or Theme.sub})
						if fire and o.Callback then task.spawn(o.Callback, state) end
					end
					row.MouseButton1Click:Connect(function() apply(not state, true) end)
					function control:Set(v) apply(v, true) end
					function control:Get() return state end
					apply(state, false, true)
					table.insert(Feather._accentHooks, function() apply(state, false, true) end)
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return state end, set = function(v) apply(v, true) end} end
					if state and o.Callback then task.defer(o.Callback, true) end
					return control
				end

				function Group:Slider(o)
					local content, _, extra = baseRow(o, 96, {top = true, height = 56})
					local dec = o.Decimals or 0
					local minV, maxV = o.Min or 0, o.Max or 100
					local value = math.clamp(o.Default or minV, minV, maxV)
					local valLabel = label({Text = "", Font = BOLD, TextSize = 12, TextColor3 = Theme.sub, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 11), Size = UDim2.fromOffset(90, 16), Parent = content})
					local hit = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 31 + extra), Size = UDim2.new(1, 0, 0, 20), Parent = content})
					local bar = new("Frame", {BackgroundColor3 = Theme.line, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 4), Parent = hit}, {corner(2)})
					local fill = new("Frame", {BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Size = UDim2.fromScale(0, 1), Parent = bar}, {corner(2)})
					local dot = new("Frame", {BackgroundColor3 = Theme.Accent, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(12, 12), Parent = bar}, {corner(7)})
					table.insert(Feather._accentHooks, function(c) fill.BackgroundColor3 = c dot.BackgroundColor3 = c end)
					local control, dragging = {}, false
					local function apply(v, fire, glide)
						v = math.clamp(round(tonumber(v) or minV, dec), minV, maxV)
						local changed = v ~= value
						value = v
						local frac = (value - minV) / math.max(maxV - minV, 1e-6)
						local d = glide and 0.12 or 0
						go(fill, d, {Size = UDim2.fromScale(frac, 1)})
						go(dot, d, {Position = UDim2.fromScale(frac, 0.5)})
						valLabel.Text = tostring(value) .. (o.Suffix or "")
						if fire and changed and o.Callback then task.spawn(o.Callback, value) end
					end
					local function fromX(x)
						local frac = math.clamp((x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
						apply(minV + frac * (maxV - minV), true, true)
					end
					hit.InputBegan:Connect(function(i)
						if not isPress(i) then return end
						dragging = true
						go(dot, 0.15, {Size = UDim2.fromOffset(16, 16)})
						go(valLabel, 0.15, {TextColor3 = Theme.text})
						fromX(i.Position.X)
					end)
					track(UserInputService.InputChanged:Connect(function(i)
						if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then fromX(i.Position.X) end
					end))
					track(UserInputService.InputEnded:Connect(function(i)
						if dragging and isPress(i) then
							dragging = false
							go(dot, 0.25, {Size = UDim2.fromOffset(12, 12)})
							go(valLabel, 0.25, {TextColor3 = Theme.sub})
						end
					end))
					function control:Set(v)
						local before = value
						apply(v, false, true)
						if value ~= before and o.Callback then task.spawn(o.Callback, value) end
					end
					function control:Get() return value end
					local start = value
					value = nil
					apply(start, false)
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return value end, set = function(v) control:Set(v) end} end
					return control
				end

				function Group:Button(o)
					local text = o.ButtonText or "Run"
					local bw = math.max(66, math.ceil(textSize(text, 12, BOLD).X) + 30)
					local content = baseRow(o, bw + 14)
					local primary = o.Primary == true
					local btn = new("TextButton", {Text = text, Font = BOLD, TextSize = 12, TextColor3 = primary and Theme.onAccent or Theme.text, AutoButtonColor = false, BackgroundColor3 = primary and Theme.Accent or Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(bw, 28), Parent = content}, {corner(8)})
					local bs = stroke(Theme.line, primary and 1 or 0)
					bs.Parent = btn
					local sc = new("UIScale", {Parent = btn})
					local over = false
					local function rest(d)
						if primary then
							go(btn, d, {BackgroundTransparency = over and 0.14 or 0})
						else
							go(btn, d, {BackgroundColor3 = over and Theme.hover or Theme.raised})
							go(bs, d, {Color = over and Theme.dim or Theme.line})
						end
					end
					if primary then table.insert(Feather._accentHooks, function(c) btn.BackgroundColor3 = c end) end
					btn.MouseEnter:Connect(function() over = true rest(0.15) end)
					btn.MouseLeave:Connect(function() over = false rest(0.25) go(sc, 0.25, {Scale = 1}) end)
					btn.MouseButton1Down:Connect(function() go(sc, 0.1, {Scale = 0.94}) end)
					btn.MouseButton1Up:Connect(function() go(sc, 0.3, {Scale = 1}) end)
					btn.MouseButton1Click:Connect(function()
						if not primary then
							-- quick flash on the outline so a click always feels like it landed
							bs.Color = Theme.text
							rest(0.5)
						end
						if o.Callback then task.spawn(o.Callback) end
					end)
					return {}
				end

				function Group:HoldButton(o)
					order += 1
					local row = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = order, Parent = box})
					local btn = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.panel, Size = UDim2.fromScale(1, 1), Parent = row}, {corner(10), stroke(Theme.bad, 0.5)})
					local clip = new("CanvasGroup", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = btn}, {corner(10)})
					local fillHold = new("Frame", {BackgroundColor3 = Theme.bad, BackgroundTransparency = 0.3, Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, Parent = clip})
					label({Text = o.Name or "Hold", Font = BOLD, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = btn})
					local holding, fired = false, false
					btn.MouseButton1Down:Connect(function()
						if holding then return end
						holding, fired = true, false
						local t0 = os.clock()
						local dur = o.Duration or 1
						task.spawn(function()
							while holding and not fired do
								local p = (os.clock() - t0) / dur
								fillHold.Size = UDim2.fromScale(math.clamp(p, 0, 1), 1)
								if p >= 1 then
									fired = true
									if o.Callback then task.spawn(o.Callback) end
								end
								RunService.RenderStepped:Wait()
							end
						end)
					end)
					local function release()
						if not holding then return end
						holding = false
						go(fillHold, fired and 0.5 or 0.25, {Size = UDim2.fromScale(0, 1)})
					end
					btn.MouseButton1Up:Connect(release)
					btn.MouseLeave:Connect(release)
					return {}
				end

				function Group:Dropdown(o)
					local content, row = baseRow(o, 162)
					local multi = o.Multi
					local selected = {}
					if o.Default then
						if type(o.Default) == "table" then for _, v in ipairs(o.Default) do selected[v] = true end
						else selected[o.Default] = true end
					end
					local options = o.Options or {}
					local function displayText()
						local list = {}
						for _, opt in ipairs(options) do if selected[opt] then table.insert(list, tostring(opt)) end end
						if #list == 0 then return o.Placeholder or "None" end
						return table.concat(list, ", ")
					end
					local box = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(150, 28), Parent = content}, {corner(9), stroke(Theme.line, 0)})
					local boxText = label({Text = displayText(), TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -34, 1, 0), Parent = box})
					local chev = makeIcon(box, "chevron-down", 14, Theme.sub)
					chev.AnchorPoint = Vector2.new(1, 0.5)
					chev.Position = UDim2.new(1, -9, 0.5, 0)

					local popup = new("CanvasGroup", {BackgroundColor3 = Theme.panel, Visible = false, Size = UDim2.fromOffset(170, 40), Parent = overlay}, {corner(11)})
					outline(popup, 11, Theme.line, 0)
					local list = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.dim, Parent = popup}, {
						new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}),
						new("UIPadding", {PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5)}),
					})
					local empty = label({Text = "Nothing here yet", TextSize = 12, TextColor3 = Theme.dim, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 28), LayoutOrder = 0, Visible = false, Parent = list})
					local items = {}
					local popH = 40
					local control = {}
					local function current()
						if multi then
							local l = {}
							for _, opt in ipairs(options) do if selected[opt] then table.insert(l, opt) end end
							return l
						end
						for _, opt in ipairs(options) do if selected[opt] then return opt end end
						return nil
					end
					local function fire()
						boxText.Text = displayText()
						if o.Callback then task.spawn(o.Callback, current()) end
					end
					local function paint()
						for opt, it in pairs(items) do
							local on = selected[opt] == true
							go(it.btn, 0.15, {BackgroundTransparency = on and 0 or 1})
							it.tick.Visible = on
							it.text.TextColor3 = on and Theme.text or Theme.sub
						end
					end
					local function rebuild()
						for _, it in pairs(items) do it.btn:Destroy() end
						items = {}
						for idx, opt in ipairs(options) do
							local b = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.hover, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), LayoutOrder = idx, Parent = list}, {corner(7)})
							local t = label({Text = tostring(opt), TextSize = 12, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(9, 0), Size = UDim2.new(1, -34, 1, 0), Parent = b})
							local tick = makeIcon(b, "check", 13, Theme.text)
							tick.AnchorPoint = Vector2.new(1, 0.5)
							tick.Position = UDim2.new(1, -8, 0.5, 0)
							items[opt] = {btn = b, tick = tick, text = t}
							b.MouseEnter:Connect(function() if not selected[opt] then go(b, 0.12, {BackgroundTransparency = 0.5}) end end)
							b.MouseLeave:Connect(function() if not selected[opt] then go(b, 0.15, {BackgroundTransparency = 1}) end end)
							b.MouseButton1Click:Connect(function()
								if multi then
									selected[opt] = (not selected[opt]) or nil
								elseif selected[opt] and o.AllowNone then
									selected = {}
								else
									selected = {[opt] = true}
								end
								paint()
								fire()
								if not multi then closePopup() end
							end)
						end
						empty.Visible = #options == 0
						popH = math.max(math.min(#options, 6), 1) * 30 + 8
						popup.Size = UDim2.fromOffset(170, popH)
						paint()
					end
					rebuild()
					local function toggle()
						local opened = showPopup(popup, box, row, 170, popH, function() go(chev, 0.2, {Rotation = 0}) end)
						if opened then go(chev, 0.2, {Rotation = 180}) end
					end
					row.MouseButton1Click:Connect(toggle)
					function control:Set(v)
						selected = {}
						if type(v) == "table" then for _, x in ipairs(v) do selected[x] = true end elseif v ~= nil then selected[v] = true end
						paint()
						fire()
					end
					function control:Get() return current() end
					function control:Refresh(newOptions, keep)
						options = newOptions or {}
						if not keep then selected = {} end
						rebuild()
						boxText.Text = displayText()
					end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return control:Get() end, set = function(v) control:Set(v) end} end
					return control
				end

				function Group:Segmented(o)
					local opts2 = o.Options or {}
					local count = math.max(#opts2, 1)
					local width = math.min(230, count * 68)
					local content = baseRow(o, width + 12)
					local holder = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(width, 28), Parent = content}, {corner(9), stroke(Theme.line, 0)})
					local slider = new("Frame", {BackgroundColor3 = Theme.Accent, Size = UDim2.new(1 / count, -4, 1, -4), Position = UDim2.fromOffset(2, 2), Parent = holder}, {corner(7)})
					table.insert(Feather._accentHooks, function(c) slider.BackgroundColor3 = c end)
					local value = o.Default or opts2[1]
					local buttons = {}
					local control = {}
					local function paint(instant)
						for idx, opt in ipairs(opts2) do
							local on = opt == value
							if on then
								local target = UDim2.new((idx - 1) / count, 2, 0, 2)
								if instant then slider.Position = target else go(slider, 0.3, {Position = target}) end
							end
							go(buttons[opt], instant and 0 or 0.2, {TextColor3 = on and Theme.onAccent or Theme.sub})
						end
					end
					for idx, opt in ipairs(opts2) do
						local b = new("TextButton", {Text = tostring(opt), Font = BOLD, TextSize = 11, TextColor3 = Theme.sub, AutoButtonColor = false, BackgroundTransparency = 1, Position = UDim2.new((idx - 1) / count, 0, 0, 0), Size = UDim2.new(1 / count, 0, 1, 0), ZIndex = 2, Parent = holder})
						buttons[opt] = b
						b.MouseButton1Click:Connect(function()
							if value == opt then return end
							value = opt
							paint()
							if o.Callback then task.spawn(o.Callback, value) end
						end)
					end
					paint(true)
					function control:Set(v)
						if buttons[v] == nil then return end
						value = v
						paint()
						if o.Callback then task.spawn(o.Callback, v) end
					end
					function control:Get() return value end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return value end, set = function(v) control:Set(v) end} end
					return control
				end

				function Group:Input(o)
					local content, row = baseRow(o, 162)
					local box = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(150, 28), Parent = content}, {corner(9)})
					local boxStroke = stroke(Theme.line, 0)
					boxStroke.Parent = box
					local tb = new("TextBox", {BackgroundTransparency = 1, Text = tostring(o.Default or ""), PlaceholderText = o.Placeholder or "", Font = FONT, TextSize = 12, TextColor3 = Theme.text, PlaceholderColor3 = Theme.dim, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, ClipsDescendants = true, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), Parent = box})
					row.MouseButton1Click:Connect(function() tb:CaptureFocus() end)
					tb.Focused:Connect(function() go(boxStroke, 0.15, {Color = Theme.sub}) end)
					tb.FocusLost:Connect(function()
						go(boxStroke, 0.25, {Color = Theme.line})
						if o.Callback then task.spawn(o.Callback, tb.Text) end
					end)
					local control = {}
					function control:Get() return tb.Text end
					function control:Set(v) tb.Text = tostring(v or "") end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return tb.Text end, set = function(v) tb.Text = tostring(v or "") end} end
					return control
				end

				function Group:Keybind(o)
					local content, row = baseRow(o, 106)
					local key = o.Default
					local btn = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(94, 28), Parent = content}, {corner(9)})
					local btnStroke = stroke(Theme.line, 0)
					btnStroke.Parent = btn
					local text = label({Text = key and key.Name or "None", Font = BOLD, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.fromScale(1, 1), Parent = btn})
					local listening = false
					local function show()
						text.Text = listening and "press a key" or (key and key.Name or "None")
						text.TextColor3 = listening and Theme.sub or Theme.text
						go(btnStroke, 0.2, {Color = listening and Theme.sub or Theme.line})
					end
					row.MouseButton1Click:Connect(function()
						listening = not listening
						Feather._binding = listening
						show()
					end)
					track(UserInputService.InputBegan:Connect(function(input, gp)
						if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
						if listening then
							listening = false
							if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then key = nil else key = input.KeyCode end
							show()
							if o.ChangedCallback then task.spawn(o.ChangedCallback, key) end
							if Feather._keyHook then task.defer(Feather._keyHook) end
							-- let this press finish before anything is allowed to react to the new key
							task.defer(function() Feather._binding = false end)
							return
						end
						if gp or Feather._binding or not key or not o.Callback then return end
						if input.KeyCode == key then task.spawn(o.Callback, key) end
					end))
					local control = {}
					function control:Get() return key end
					function control:Set(k) key = k show() end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return key and key.Name end, set = function(v) local ok, kc = pcall(function() return Enum.KeyCode[v] end) if ok and kc then control:Set(kc) if o.ChangedCallback then task.spawn(o.ChangedCallback, kc) end if Feather._keyHook then task.defer(Feather._keyHook) end end end} end
					return control
				end

				function Group:Colorpicker(o)
					local content, row = baseRow(o, 50)
					local color = o.Default or Theme.Accent
					local swatch = new("Frame", {BackgroundColor3 = color, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(36, 22), Parent = content}, {corner(7), stroke(Theme.line, 0)})
					local popup = new("CanvasGroup", {BackgroundColor3 = Theme.panel, Visible = false, Size = UDim2.fromOffset(190, 158), Parent = overlay}, {corner(12)})
					outline(popup, 12, Theme.line, 0)
					local sv = new("ImageButton", {AutoButtonColor = false, BackgroundColor3 = Color3.fromHSV(0, 1, 1), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 104), Parent = popup}, {corner(7)})
					new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), Parent = sv}, {corner(7), new("UIGradient", {Transparency = NumberSequence.new(0, 1)})})
					new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), Parent = sv}, {corner(7), new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(1, 0)})})
					local svDot = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromOffset(10, 10), AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 3, Parent = sv}, {corner(5), stroke(Color3.new(0, 0, 0), 0.3)})
					local hue = new("ImageButton", {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), Position = UDim2.fromOffset(10, 124), Size = UDim2.new(1, -20, 0, 14), Parent = popup}, {corner(5), new("UIGradient", {Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))})})})
					local hueDot = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromOffset(5, 18), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), ZIndex = 3, Parent = hue}, {corner(2), stroke(Color3.new(0, 0, 0), 0.3)})
					local h, s, v = color:ToHSV()
					local control = {}
					local function apply(fire)
						color = Color3.fromHSV(h, s, v)
						swatch.BackgroundColor3 = color
						sv.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
						svDot.Position = UDim2.fromScale(s, 1 - v)
						hueDot.Position = UDim2.fromScale(h, 0.5)
						if fire and o.Callback then task.spawn(o.Callback, color) end
					end
					local draggingSV, draggingH = false, false
					sv.InputBegan:Connect(function(i) if isPress(i) then draggingSV = true end end)
					hue.InputBegan:Connect(function(i) if isPress(i) then draggingH = true end end)
					track(UserInputService.InputEnded:Connect(function(i) if isPress(i) then draggingSV, draggingH = false, false end end))
					track(RunService.RenderStepped:Connect(function()
						if not (draggingSV or draggingH) then return end
						local m = mousePos()
						if draggingSV then
							s = math.clamp((m.X - sv.AbsolutePosition.X) / math.max(sv.AbsoluteSize.X, 1), 0, 1)
							v = 1 - math.clamp((m.Y - sv.AbsolutePosition.Y) / math.max(sv.AbsoluteSize.Y, 1), 0, 1)
						else
							h = math.clamp((m.X - hue.AbsolutePosition.X) / math.max(hue.AbsoluteSize.X, 1), 0, 1)
						end
						apply(true)
					end))
					row.MouseButton1Click:Connect(function() showPopup(popup, swatch, row, 190, 158) end)
					apply(false)
					function control:Set(c)
						if typeof(c) == "table" and c.R then c = Color3.new(c.R, c.G, c.B) end
						if typeof(c) ~= "Color3" then return end
						h, s, v = c:ToHSV()
						apply(true)
					end
					function control:Get() return color end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return {R = color.R, G = color.G, B = color.B} end, set = function(c) control:Set(c) end} end
					return control
				end

				function Group:Info(o)
					local content = baseRow({Name = o.Name, Icon = o.Icon}, 200, {plain = true, height = 36})
					local styleColor = ({accent = Theme.text, success = Theme.good, error = Theme.bad, warning = Theme.warn, mono = Theme.sub})[o.Style] or Theme.sub
					local val = label({Text = tostring(o.Value or ""), Font = o.Style == "mono" and Enum.Font.Code or FONT, TextSize = 12, TextColor3 = styleColor, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(190, 16), Parent = content})
					local control = {}
					function control:Set(v)
						v = tostring(v)
						if val.Text == v then return end
						val.Text = v
						val.TextTransparency = 0.6
						go(val, 0.3, {TextTransparency = 0})
					end
					return control
				end

				function Group:Paragraph(o)
					order += 1
					local title = o.Title or o.Name
					local top = title and 30 or 11
					local row = new("Frame", {BackgroundColor3 = Theme.panel, Size = UDim2.new(1, 0, 0, 40), LayoutOrder = order, Parent = box}, {corner(10), stroke(Theme.line, 0.25)})
					if title then label({Text = title, TextSize = 13, Position = UDim2.fromOffset(12, 11), Size = UDim2.fromOffset(ROW_W, 16), Parent = row}) end
					local t = label({Text = "", Font = REG, TextSize = 12, TextColor3 = Theme.sub, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Position = UDim2.fromOffset(12, top), Size = UDim2.fromOffset(ROW_W, 14), Parent = row})
					local function set(v)
						v = tostring(v or "")
						local hgt = math.ceil(textSize(v, 12, REG, ROW_W).Y)
						t.Text = v
						t.Size = UDim2.fromOffset(ROW_W, hgt)
						row.Size = UDim2.new(1, 0, 0, top + hgt + 12)
					end
					set(o.Content)
					return {Set = function(_, v) set(v) end}
				end

				function Group:Label(text)
					order += 1
					local row = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 20), LayoutOrder = order, Parent = box})
					local t = label({Text = tostring(text or ""), TextSize = 12, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(3, 0), Size = UDim2.new(1, -6, 1, 0), Parent = row})
					return {Set = function(_, v) t.Text = tostring(v) end}
				end

				return Group
			end

			function page:Group(gopts) if type(gopts) == "table" then return addGroup(gopts.Name) end return addGroup(gopts) end
			function page:Section(name) return addGroup(name) end

			if #tab.pages == 1 then selectPage(page) end
			return page
		end

		btn.MouseButton1Click:Connect(function() selectTab(tab) end)
		table.insert(Window.tabs, tab)
		if #Window.tabs == 1 then selectTab(tab) else paintTab(tab, true) end
		return tab
	end

	function Window:SetTitle(t) titleLabel.Text = tostring(t or "") end

	makeDraggable(header, root, closePopup)
	makeDraggable(sideHead, root, closePopup)

	-- show / hide / minimize
	local visible, minimized, ready, unloaded = false, false, false, false
	local function openWindow()
		if ready then return end
		ready = true
		visible = true
		root.Visible = true
		rootScale.Scale = fit * 0.965
		go(rootScale, 0.7, {Scale = fit})
		go(panel, 0.5, {GroupTransparency = 0})
		nav.Position = UDim2.fromOffset(-12, NAV_TOP)
		go(nav, 0.8, {Position = UDim2.fromOffset(0, NAV_TOP)})
		refreshKey()
		Window:SetWatermark(true)
		local t = Window._active
		if t then
			t.host.GroupTransparency = 1
			t.host.Position = UDim2.fromOffset(0, 16)
			go(t.host, 0.7, {GroupTransparency = 0, Position = UDim2.fromOffset(0, 0)})
		end
	end
	-- minimizing folds the whole menu into a little feather button. drag it anywhere, click it to get the menu back
	local bubble = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.bg, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(54, 54), Visible = false, ZIndex = 2, Parent = gui}, {corner(27)})
	local bubbleStroke = stroke(Color3.fromRGB(70, 70, 78), 1)
	bubbleStroke.Parent = bubble
	local bubbleScale = new("UIScale", {Scale = 0.6, Parent = bubble})
	local bubbleIcon
	do
		local quill = b64Asset("quill4.png", LOGO_B64)
		if quill then
			bubbleIcon = new("ImageLabel", {BackgroundTransparency = 1, Image = quill, ImageColor3 = Theme.text, ImageTransparency = 1, ScaleType = Enum.ScaleType.Fit, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(32, 18), Parent = bubble})
		else
			bubbleIcon = makeIcon(bubble, "feather", 22, Theme.text)
			bubbleIcon.AnchorPoint = Vector2.new(0.5, 0.5)
			bubbleIcon.Position = UDim2.fromScale(0.5, 0.5)
			bubbleIcon.ImageTransparency = 1
		end
	end
	local function showBubble(on)
		if on then bubble.Visible = true end
		go(bubble, 0.3, {BackgroundTransparency = on and glass or 1})
		go(bubbleStroke, 0.3, {Transparency = on and 0 or 1})
		go(bubbleIcon, 0.3, {ImageTransparency = on and 0 or 1})
		go(bubbleScale, on and 0.45 or 0.25, {Scale = on and 1 or 0.6}, on and Enum.EasingStyle.Back or nil)
		if not on then task.delay(0.3, function() if bubble.BackgroundTransparency > 0.95 then bubble.Visible = false end end) end
	end
	local function showPanel(on)
		if on then root.Visible = true end
		go(rootScale, on and 0.4 or 0.3, {Scale = on and fit or fit * 0.94})
		go(panel, on and 0.3 or 0.24, {GroupTransparency = on and 0 or 1})
	end

	local function setVisible(v)
		if visible == v or not ready then return end
		visible = v
		closePopup()
		setHover(nil)
		if minimized then
			showBubble(v)
			return
		end
		if v then refreshKey() end
		showPanel(v)
		if not v then task.delay(0.26, function() if not visible then root.Visible = false end end) end
	end
	local function setMinimized(v)
		if minimized == v then return end
		minimized = v
		closePopup()
		setHover(nil)
		if v then
			-- the button turns up where the logo was sitting
			local origin = overlay.AbsolutePosition
			local at = headLogo.AbsolutePosition - origin + headLogo.AbsoluteSize / 2
			bubble.Position = UDim2.fromOffset(at.X, at.Y)
			showPanel(false)
			task.delay(0.26, function() if minimized then root.Visible = false end end)
			showBubble(true)
		else
			showBubble(false)
			refreshKey()
			showPanel(true)
		end
	end
	-- a drag should not count as a click
	local pressAt
	bubble.MouseButton1Down:Connect(function() pressAt = UserInputService:GetMouseLocation() end)
	bubble.MouseEnter:Connect(function() go(bubbleStroke, 0.15, {Color = Theme.sub}) end)
	bubble.MouseLeave:Connect(function() go(bubbleStroke, 0.25, {Color = Color3.fromRGB(70, 70, 78)}) end)
	bubble.MouseButton1Click:Connect(function()
		local now = UserInputService:GetMouseLocation()
		if pressAt and (now - pressAt).Magnitude > 6 then return end
		setMinimized(false)
	end)
	makeDraggable(bubble, bubble)

	-- search: type a few letters, pick a result, land on that option
	local searchBox = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -86, 0.5, 0), Size = UDim2.fromOffset(150, 28), Parent = header}, {corner(9)})
	local searchStroke = stroke(Theme.line, 0)
	searchStroke.Parent = searchBox
	local searchIcon = makeIcon(searchBox, "search", 13, Theme.dim)
	searchIcon.AnchorPoint = Vector2.new(0, 0.5)
	searchIcon.Position = UDim2.new(0, 9, 0.5, 0)
	local searchInput = new("TextBox", {BackgroundTransparency = 1, Text = "", PlaceholderText = "Search", Font = FONT, TextSize = 12, TextColor3 = Theme.text, PlaceholderColor3 = Theme.dim, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, ClipsDescendants = true, Position = UDim2.fromOffset(29, 0), Size = UDim2.new(1, -37, 1, 0), Parent = searchBox})
	local results = new("CanvasGroup", {BackgroundColor3 = Theme.panel, Visible = false, Size = UDim2.fromOffset(250, 40), Parent = overlay}, {corner(11)})
	outline(results, 11, Theme.line, 0)
	local resultList = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = results}, {
		new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}),
		new("UIPadding", {PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5)}),
	})
	hideSearch = function() results.Visible = false end

	local function jumpTo(r)
		searchInput.Text = ""
		searchInput:ReleaseFocus()
		results.Visible = false
		if minimized then setMinimized(false) end
		selectTab(r.tab)
		r.page._select()
		task.spawn(function()
			-- give the page a couple of frames to lay out before measuring where the row ended up
			RunService.RenderStepped:Wait()
			RunService.RenderStepped:Wait()
			local sc = r.page.scroller
			local y = r.row.AbsolutePosition.Y - sc.AbsolutePosition.Y + sc.CanvasPosition.Y - 60
			go(sc, 0.35, {CanvasPosition = Vector2.new(0, math.max(y, 0))})
			r.stroke.Color = Theme.text
			r.stroke.Transparency = 0
			task.wait(0.6)
			go(r.stroke, 0.9, {Color = Theme.line, Transparency = 0.25})
		end)
	end

	local function runSearch()
		for _, c in ipairs(resultList:GetChildren()) do
			if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
		end
		local q = string.lower(searchInput.Text)
		if q == "" then results.Visible = false return end
		local found = {}
		for _, r in ipairs(Window._rows) do
			local at = string.find(string.lower(r.name), q, 1, true)
			if at then table.insert(found, {r = r, at = at}) end
		end
		table.sort(found, function(a, b)
			if a.at ~= b.at then return a.at < b.at end
			return a.r.name < b.r.name
		end)
		local count = math.min(#found, 6)
		if count == 0 then
			label({Text = "Nothing matches", TextSize = 12, TextColor3 = Theme.dim, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 30), Parent = resultList})
		end
		for i = 1, count do
			local r = found[i].r
			local where = r.tab.name .. (#r.tab.pages > 1 and ("  /  " .. r.page.name) or "")
			local b = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.hover, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = i, Parent = resultList}, {corner(8)})
			label({Text = r.name, TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(10, 5), Size = UDim2.new(1, -20, 0, 15), Parent = b})
			label({Text = where, Font = REG, TextSize = 10, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(10, 20), Size = UDim2.new(1, -20, 0, 12), Parent = b})
			b.MouseEnter:Connect(function() go(b, 0.12, {BackgroundTransparency = 0}) end)
			b.MouseLeave:Connect(function() go(b, 0.15, {BackgroundTransparency = 1}) end)
			b.MouseButton1Click:Connect(function() jumpTo(r) end)
		end
		local origin = overlay.AbsolutePosition
		local ap, as = searchBox.AbsolutePosition - origin, searchBox.AbsoluteSize
		results.Position = UDim2.fromOffset(ap.X + as.X - 250, ap.Y + as.Y + 6)
		results.Size = UDim2.fromOffset(250, count == 0 and 40 or count * 40 + 8)
		if not results.Visible then
			results.GroupTransparency = 1
			results.Visible = true
			go(results, 0.15, {GroupTransparency = 0})
		end
	end
	track(searchInput:GetPropertyChangedSignal("Text"):Connect(runSearch))
	searchBox.MouseButton1Click:Connect(function() searchInput:CaptureFocus() end)
	searchInput.Focused:Connect(function()
		go(searchStroke, 0.15, {Color = Theme.sub})
		go(searchIcon, 0.15, {ImageColor3 = Theme.text})
		runSearch()
	end)
	searchInput.FocusLost:Connect(function()
		go(searchStroke, 0.25, {Color = Theme.line})
		go(searchIcon, 0.25, {ImageColor3 = Theme.dim})
		-- wait a beat so a click on a result still lands
		task.delay(0.2, function() if not searchInput:IsFocused() then results.Visible = false end end)
	end)

	-- status pill at the top of the screen. it stays up while the menu is hidden, so its easy to tell the script is still running
	local mark
	if opts.Watermark ~= false then
		mark = new("Frame", {BackgroundColor3 = Theme.bg, BackgroundTransparency = glass, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, -44), Size = UDim2.fromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X, Visible = false, Parent = gui}, {
			corner(10), stroke(Theme.line, 0),
			new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder}),
			new("UIPadding", {PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 12)}),
		})
		local quill = b64Asset("quill4.png", LOGO_B64)
		if quill then new("ImageLabel", {BackgroundTransparency = 1, Image = quill, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(24, 13), LayoutOrder = 1, Parent = mark}) end
		local function cell(order, text, color, font)
			if order > 2 then new("Frame", {BackgroundColor3 = Theme.line, BorderSizePixel = 0, Size = UDim2.fromOffset(1, 12), LayoutOrder = order * 2 - 1, Parent = mark}) end
			return label({Text = text, Font = font, TextSize = 11, TextColor3 = color, Size = UDim2.fromOffset(0, 16), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = order * 2, Parent = mark})
		end
		cell(2, opts.Name or "Feather", Theme.text, BOLD)
		local fpsCell = cell(3, "-- fps", Theme.sub, FONT)
		local pingCell = cell(4, "-- ms", Theme.sub, FONT)
		local timeCell = cell(5, os.date("%H:%M"), Theme.sub, FONT)
		local frames, since = 0, os.clock()
		track(RunService.RenderStepped:Connect(function()
			frames += 1
			local now = os.clock()
			if now - since < 0.5 then return end
			fpsCell.Text = tostring(math.floor(frames / (now - since) + 0.5)) .. " fps"
			frames, since = 0, now
			local ok, ping = pcall(function() return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() end)
			pingCell.Text = (ok and type(ping) == "number") and (tostring(math.floor(ping + 0.5)) .. " ms") or "-- ms"
			timeCell.Text = os.date("%H:%M")
		end))
	end
	function Window:SetWatermark(on)
		if not mark then return end
		if on then mark.Visible = true end
		go(mark, 0.45, {Position = UDim2.new(1, -14, 0, on and 14 or -44)})
		if not on then task.delay(0.46, function() if mark.Position.Y.Offset < 0 then mark.Visible = false end end) end
	end

	minBtn.MouseButton1Click:Connect(function() setMinimized(not minimized) end)
	closeBtn.MouseButton1Click:Connect(function() Feather:Unload() end)
	track(UserInputService.InputBegan:Connect(function(input, gp)
		if gp or Feather._binding then return end
		if Feather.ToggleKey and input.KeyCode == Feather.ToggleKey then setVisible(not visible) end
	end))

	function Feather:Unload()
		if unloaded then return end
		unloaded = true
		closePopup()
		go(rootScale, 0.3, {Scale = fit * 0.95})
		go(panel, 0.26, {GroupTransparency = 1})
		task.delay(0.3, function()
			for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
			pcall(function() gui:Destroy() end)
			if Feather._notifs then pcall(function() Feather._notifs.Parent:Destroy() end) end
			Feather._notifs = nil
		end)
		Feather._binding = false
		rawset(Feather, "_keyHook", nil)
		if getgenv then getgenv().__FeatherUnload = nil end
		if Feather.OnUnload then pcall(Feather.OnUnload) end
	end
	if getgenv then getgenv().__FeatherUnload = function() pcall(function() gui:Destroy() end) end end

	-- intro: the quill writes the name stroke by stroke, then the word glides up into the header as the window opens
	local function intro()
		local atlasId = b64Asset("write4.png", ATLAS_B64)
		local wordId = b64Asset("word4.png", WORD_B64)
		local glowId = b64Asset("glow4.png", GLOW_B64)
		local blobId = b64Asset("blob4.png", BLOB_B64)
		local quillId = b64Asset("quill4.png", LOGO_B64)

		local layer = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 300, Parent = gui})
		-- the backdrop is one big button: click anywhere and the intro hurries to the end
		local cover = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(4, 4, 6), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Parent = layer})
		local skip = false
		cover.MouseButton1Click:Connect(function() skip = true end)
		local function pause(t)
			local t0 = os.clock()
			while not skip and os.clock() - t0 < t do RunService.RenderStepped:Wait() end
		end
		go(cover, 0.6, {BackgroundTransparency = 0.04}, Enum.EasingStyle.Sine)
		local hint = label({Text = "click to skip", Font = REG, TextSize = 11, TextColor3 = Theme.dim, TextTransparency = 1, TextXAlignment = Enum.TextXAlignment.Center, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -40), Size = UDim2.fromOffset(200, 16), ZIndex = 3, Parent = layer})
		task.delay(1.4, function() if not skip then go(hint, 0.8, {TextTransparency = 0.3}) end end)

		local MARGIN = 220
		local group = new("CanvasGroup", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, -14), Size = UDim2.fromOffset(WORD_W + MARGIN * 2, WORD_H + MARGIN * 2), BackgroundTransparency = 1, GroupTransparency = 1, ZIndex = 2, Parent = layer})
		local stage = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(MARGIN, MARGIN), Size = UDim2.fromOffset(WORD_W, WORD_H), Parent = group})

		if not (atlasId and wordId) then
			-- no file access on this executor, so just fade the name in and out
			label({Text = opts.Name or "Feather", Font = BOLD, TextSize = 46, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = stage})
			go(group, 0.6, {GroupTransparency = 0})
			pause(1.5)
			go(group, 0.45, {GroupTransparency = 1})
			go(hint, 0.3, {TextTransparency = 1})
			go(cover, 0.6, {BackgroundTransparency = 1})
			task.wait(0.3)
			openWindow()
			task.wait(0.6)
			layer:Destroy()
			return
		end

		if blobId then
			new("ImageLabel", {BackgroundTransparency = 1, Image = blobId, ImageTransparency = 0.88, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(WORD_W + 400, WORD_H + 280), Parent = stage})
		end
		local glow, glowGrad
		if glowId then
			glow = new("ImageLabel", {BackgroundTransparency = 1, Image = glowId, ImageTransparency = 0.3, Position = UDim2.fromOffset(-GLOW_PAD, -GLOW_PAD), Size = UDim2.fromOffset(WORD_W + GLOW_PAD * 2, WORD_H + GLOW_PAD * 2), Parent = stage})
			glowGrad = new("UIGradient", {Offset = Vector2.new(-0.75, 0), Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.38, 0), NumberSequenceKeypoint.new(0.62, 1), NumberSequenceKeypoint.new(1, 1)}), Parent = glow})
		end

		local ink = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = stage})
		local tiles = {}
		for i = 1, #WRITE_TILES, 7 do
			local w, h = WRITE_TILES[i + 2], WRITE_TILES[i + 3]
			local img = new("ImageLabel", {BackgroundTransparency = 1, Image = atlasId, ImageTransparency = 1, ImageRectOffset = Vector2.new(WRITE_TILES[i], WRITE_TILES[i + 1]), ImageRectSize = Vector2.new(w, h), Position = UDim2.fromOffset(WRITE_TILES[i + 4], WRITE_TILES[i + 5]), Size = UDim2.fromOffset(w, h), Parent = ink})
			tiles[#tiles + 1] = {img = img, k = WRITE_TILES[i + 6]}
		end
		local wordImg = new("ImageLabel", {BackgroundTransparency = 1, Image = wordId, ImageTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = stage})
		-- a thin rule and the byline sit under the word once it is written
		local rule = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 1, 10), Size = UDim2.fromOffset(0, 1), Parent = stage})
		local byline
		if (opts.Title or "") ~= "" then
			byline = label({Text = opts.Title, Font = REG, TextSize = 13, TextColor3 = Theme.sub, TextTransparency = 1, TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, 0, 1, 28), Size = UDim2.new(1, 0, 0, 18), Parent = stage})
		end

		local sx, sy = pathAt(0)
		local BASE_TILT = -6
		local pivot = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(sx * WORD_W + 30, sy * WORD_H - 46), Size = UDim2.fromOffset(2, 2), Rotation = BASE_TILT - 12, ZIndex = 5, Parent = stage})
		local nib
		if blobId then
			nib = new("ImageLabel", {BackgroundTransparency = 1, Image = blobId, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(1, 1), Size = UDim2.fromOffset(34, 34), Parent = pivot})
		end
		local pen
		if quillId then
			local PEN_W = 150
			pen = new("ImageLabel", {BackgroundTransparency = 1, Image = quillId, Rotation = 180, AnchorPoint = Vector2.new(1 - QUILL_TIP.X, 1 - QUILL_TIP.Y), Position = UDim2.fromOffset(1, 1), Size = UDim2.fromOffset(PEN_W, math.floor(PEN_W / LOGO_ASPECT)), Parent = pivot})
		else
			pen = makeIcon(pivot, "feather", 44, Color3.new(1, 1, 1))
			pen.AnchorPoint = Vector2.new(0.08, 0.92)
			pen.Position = UDim2.fromOffset(1, 1)
		end
		pen.ImageTransparency = 1

		-- specks of light that fall off the nib while it is on the page
		local sparks = {}
		local function spark(px, py)
			if not blobId then return end
			local sp
			for _, c in ipairs(sparks) do if c.life <= 0 then sp = c break end end
			if not sp then
				if #sparks >= 28 then return end
				sp = {life = 0, img = new("ImageLabel", {BackgroundTransparency = 1, Image = blobId, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 4, Parent = stage})}
				sparks[#sparks + 1] = sp
			end
			sp.x, sp.y = px, py
			sp.vx, sp.vy = (math.random() - 0.5) * 50, 10 + math.random() * 30
			sp.span = 0.45 + math.random() * 0.45
			sp.life = sp.span
			sp.size = 5 + math.random() * 8
		end
		local function stepSparks(dt)
			for _, sp in ipairs(sparks) do
				if sp.life > 0 then
					sp.life -= dt
					sp.x += sp.vx * dt
					sp.y += sp.vy * dt
					sp.vy += 70 * dt
					local k = math.max(sp.life / sp.span, 0)
					local size = sp.size * (0.45 + 0.55 * k)
					sp.img.Position = UDim2.fromOffset(sp.x, sp.y)
					sp.img.Size = UDim2.fromOffset(size, size)
					sp.img.ImageTransparency = 1 - 0.8 * k
				end
			end
		end

		-- give the images a moment to actually load so nothing pops in half way through
		local loaded = false
		task.spawn(function()
			pcall(function() ContentProvider:PreloadAsync({wordImg, tiles[1] and tiles[1].img or wordImg, pen}) end)
			loaded = true
		end)
		local waited = os.clock()
		repeat task.wait() until loaded or os.clock() - waited > 1
		pause(0.2)

		go(group, 0.6, {GroupTransparency = 0}, Enum.EasingStyle.Sine)
		go(pen, 0.5, {ImageTransparency = 0})
		go(pivot, 0.75, {Position = UDim2.fromOffset(sx * WORD_W, sy * WORD_H), Rotation = BASE_TILT})
		pause(0.75)

		local DUR = 2.9
		local first = 1
		local p, sparkAt = 0, 0
		local tilt, reveal, lastX = BASE_TILT, 0, sx
		local last = os.clock()
		while true do
			local now = os.clock()
			local dt = math.clamp(now - last, 1 / 500, 0.1)
			last = now
			p = math.min(p + dt / DUR * (skip and 14 or 1), 1)

			-- each piece of ink fades up as the nib passes over it
			for i = first, #tiles do
				local a = (p * WRITE_BINS - tiles[i].k + 0.8) / 2.4
				if a <= 0 then break end
				tiles[i].img.ImageTransparency = 1 - math.min(a, 1)
				if a >= 1 and i == first then first += 1 end
			end

			local x, y, lift = pathAt(p)
			pivot.Position = UDim2.fromOffset(x * WORD_W, y * WORD_H - lift * 12)
			-- the feather trails the hand a little, and tips back when it comes off the page
			local vx = (x - lastX) * WORD_W / dt
			lastX = x
			local want = BASE_TILT - math.clamp(vx * 0.011, -7, 7) - lift * 5
			tilt += (want - tilt) * (1 - math.exp(-dt * 9))
			pivot.Rotation = tilt
			if nib then nib.ImageTransparency = 0.2 + lift * 0.8 end
			if glowGrad then
				local gx = (GLOW_PAD + x * WORD_W) / (WORD_W + GLOW_PAD * 2)
				if gx > reveal then reveal += (gx - reveal) * (1 - math.exp(-dt * 7)) end
				glowGrad.Offset = Vector2.new(reveal - 0.5, 0)
			end
			sparkAt += dt
			if lift < 0.15 and sparkAt > 0.032 and not skip then
				sparkAt = 0
				spark(x * WORD_W, y * WORD_H)
			end
			stepSparks(dt)

			if p >= 1 then break end
			RunService.RenderStepped:Wait()
		end

		wordImg.ImageTransparency = 0
		ink:Destroy()
		if glow and glowGrad then
			go(glowGrad, 0.5, {Offset = Vector2.new(0.75, 0)}, Enum.EasingStyle.Sine)
			go(glow, 0.5, {ImageTransparency = 0.05}, Enum.EasingStyle.Sine)
			task.delay(0.5, function() go(glow, 0.9, {ImageTransparency = 0.4}, Enum.EasingStyle.Sine) end)
		end
		-- the ink settles a shade darker while the quill finishes up
		local DIM = Color3.fromRGB(196, 196, 202)
		go(wordImg, 0.4, {ImageColor3 = DIM}, Enum.EasingStyle.Sine)

		-- carries the nib from where it is to a spot, hopping off the page on the way if asked, and keeps the sparks falling
		local penX, penY = pathAt(1)
		penX, penY = penX * WORD_W, penY * WORD_H
		local function movePen(tx, ty, dur, hop, each)
			local fx, fy = penX, penY
			local t0 = os.clock()
			local prev = t0
			while true do
				local now = os.clock()
				local dt = math.clamp(now - prev, 1 / 500, 0.1)
				prev = now
				local a = skip and 1 or math.clamp((now - t0) / dur, 0, 1)
				local e = TweenService:GetValue(a, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
				penX, penY = fx + (tx - fx) * e, fy + (ty - fy) * e
				local lift = hop * math.sin(math.pi * a)
				pivot.Position = UDim2.fromOffset(penX, penY - lift)
				if nib then nib.ImageTransparency = math.clamp(0.2 + lift / 12, 0.2, 1) end
				if each then each(e, dt) end
				stepSparks(dt)
				if a >= 1 then break end
				RunService.RenderStepped:Wait()
			end
		end

		-- it drops under the word and pulls a line across, like finishing a signature
		local RULE_W = 190
		local ruleX, ruleY = (WORD_W - RULE_W) / 2, WORD_H + 10
		rule.AnchorPoint = Vector2.new(0, 0)
		rule.Position = UDim2.fromOffset(ruleX, ruleY)
		new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.14, 0), NumberSequenceKeypoint.new(0.86, 0), NumberSequenceKeypoint.new(1, 1)}), Parent = rule})
		go(pivot, 0.3, {Rotation = BASE_TILT})
		movePen(ruleX, ruleY, 0.36, 16)
		rule.BackgroundTransparency = 0.5
		local sparkGap = 0
		movePen(ruleX + RULE_W, ruleY, 0.5, 0, function(e, dt)
			rule.Size = UDim2.fromOffset(RULE_W * e, 1)
			sparkGap += dt
			if sparkGap > 0.03 and not skip then
				sparkGap = 0
				spark(penX, penY)
			end
		end)
		rule.Size = UDim2.fromOffset(RULE_W, 1)

		-- then it lifts away and comes to rest upright beside the word, while a glint runs across the ink
		if byline then go(byline, 0.8, {TextTransparency = 0.1, Position = UDim2.new(0, 0, 1, 20)}) end
		if nib then
			go(nib, 0.3, {ImageTransparency = 1})
			nib = nil
		end
		go(pivot, 0.6, {Rotation = 0}, Enum.EasingStyle.Sine)
		local shine
		if not skip then
			wordImg.ImageColor3 = Color3.new(1, 1, 1)
			shine = new("UIGradient", {Rotation = 18, Offset = Vector2.new(-1, 0), Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, DIM), ColorSequenceKeypoint.new(0.38, DIM), ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(0.62, DIM), ColorSequenceKeypoint.new(1, DIM)}), Parent = wordImg})
			go(shine, 0.9, {Offset = Vector2.new(1, 0)}, Enum.EasingStyle.Sine)
		end
		movePen(WORD_W + 30, WORD_H * 0.46, 0.65, 0)
		task.spawn(function()
			local t0 = os.clock()
			while os.clock() - t0 < 0.9 do
				local dt = RunService.RenderStepped:Wait()
				stepSparks(type(dt) == "number" and dt or 1 / 60)
			end
			for _, sp in ipairs(sparks) do sp.img:Destroy() end
		end)
		pause(0.25)
		if shine then
			shine:Destroy()
			wordImg.ImageColor3 = DIM
		end
		go(wordImg, 0.35, {ImageColor3 = Color3.new(1, 1, 1)}, Enum.EasingStyle.Sine)
		pause(0.4)

		-- hand both over to the menu: copies of the word and the quill fly to where the small ones sit while everything else fades
		root.Visible = true
		rootScale.Scale = fit
		headWord.ImageTransparency = 1
		headLogo.ImageTransparency = 1
		pivot.Rotation = 0
		RunService.RenderStepped:Wait()
		local origin = layer.AbsolutePosition
		local fromPos, fromSize = wordImg.AbsolutePosition - origin, wordImg.AbsoluteSize
		local fly = new("ImageLabel", {BackgroundTransparency = 1, Image = wordId, Position = UDim2.fromOffset(fromPos.X, fromPos.Y), Size = UDim2.fromOffset(fromSize.X, fromSize.Y), ZIndex = 5, Parent = layer})
		wordImg.Visible = false
		local flyPen, penPos, penSize
		if quillId then
			penPos, penSize = pen.AbsolutePosition - origin, pen.AbsoluteSize
			flyPen = new("ImageLabel", {BackgroundTransparency = 1, Image = quillId, Rotation = 180, Position = UDim2.fromOffset(penPos.X, penPos.Y), Size = UDim2.fromOffset(penSize.X, penSize.Y), ZIndex = 6, Parent = layer})
			pen.Visible = false
		end
		go(group, 0.4, {GroupTransparency = 1}, Enum.EasingStyle.Sine)
		go(hint, 0.3, {TextTransparency = 1})
		go(cover, 0.85, {BackgroundTransparency = 1}, Enum.EasingStyle.Sine)
		task.delay(0.1, openWindow)
		local FLY = 0.9
		local t0 = os.clock()
		while true do
			local a = math.clamp((os.clock() - t0) / FLY, 0, 1)
			local e = TweenService:GetValue(a, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
			local toPos, toSize = headWord.AbsolutePosition - origin, headWord.AbsoluteSize
			fly.Position = UDim2.fromOffset(fromPos.X + (toPos.X - fromPos.X) * e, fromPos.Y + (toPos.Y - fromPos.Y) * e)
			fly.Size = UDim2.fromOffset(fromSize.X + (toSize.X - fromSize.X) * e, fromSize.Y + (toSize.Y - fromSize.Y) * e)
			if flyPen then
				-- the quill turns right way up on the way, and lands as the logo
				local lp, ls = headLogo.AbsolutePosition - origin, headLogo.AbsoluteSize
				flyPen.Position = UDim2.fromOffset(penPos.X + (lp.X - penPos.X) * e, penPos.Y + (lp.Y - penPos.Y) * e)
				flyPen.Size = UDim2.fromOffset(penSize.X + (ls.X - penSize.X) * e, penSize.Y + (ls.Y - penSize.Y) * e)
				flyPen.Rotation = 180 + 180 * e
			end
			if a >= 1 then break end
			RunService.RenderStepped:Wait()
		end
		headWord.ImageTransparency = 0
		fly:Destroy()
		if flyPen then
			headLogo.ImageTransparency = 0
			flyPen:Destroy()
		else
			go(headLogo, 0.5, {ImageTransparency = 0})
		end
		task.wait(0.3)
		layer:Destroy()
	end

	task.spawn(function()
		-- let the script that called us finish adding its tabs first
		task.wait()
		if opts.Intro ~= false then
			local ok, err = pcall(intro)
			if not ok then warn("[Feather] intro stopped early: " .. tostring(err)) end
		end
		if unloaded then return end
		-- whatever happened above, end up with a clean window on screen
		for _, child in ipairs(gui:GetChildren()) do
			if child ~= root and child ~= overlay and child ~= mark and child ~= bubble then child:Destroy() end
		end
		headWord.ImageTransparency = 0
		headLogo.ImageTransparency = 0
		openWindow()
	end)

	return Window
end


return Feather
