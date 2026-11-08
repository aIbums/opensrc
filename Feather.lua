-- Feather UI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

local ICONS = {
	["activity"] = {"M22 12h-2.48a2 2 0 0 0-1.93 1.46l-2.35 8.36a.25.25 0 0 1-.48 0L9.24 2.18a.25.25 0 0 0-.48 0l-2.35 8.36A2 2 0 0 1 4.49 12H2"},
	["bell"] = {"M10.268 21a2 2 0 0 0 3.464 0", "M3.262 15.326A1 1 0 0 0 4 17h16a1 1 0 0 0 .74-1.673C19.41 13.956 18 12.499 18 8A6 6 0 0 0 6 8c0 4.499-1.411 5.956-2.738 7.326"},
	["blend"] = {"M 8.0 9.0 a 7.0 7.0 0 1 0 14.0 0 a 7.0 7.0 0 1 0 -14.0 0", "M 2.0 15.0 a 7.0 7.0 0 1 0 14.0 0 a 7.0 7.0 0 1 0 -14.0 0"},
	["box"] = {"M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z", "m3.3 7 8.7 5 8.7-5", "M12 22V12"},
	["check"] = {"M20 6 9 17l-5-5"},
	["chevron-down"] = {"m6 9 6 6 6-6"},
	["circle-user"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M 9.0 10.0 a 3.0 3.0 0 1 0 6.0 0 a 3.0 3.0 0 1 0 -6.0 0", "M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662"},
	["cog"] = {"M11 10.27 7 3.34", "m11 13.73-4 6.93", "M12 22v-2", "M12 2v2", "M14 12h8", "m17 20.66-1-1.73", "m17 3.34-1 1.73", "M2 12h2", "m20.66 17-1.73-1", "m20.66 7-1.73 1", "m3.34 17 1.73-1", "m3.34 7 1.73 1", "M 10.0 12.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "M 4.0 12.0 a 8.0 8.0 0 1 0 16.0 0 a 8.0 8.0 0 1 0 -16.0 0"},
	["crosshair"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M 22 12 L 18 12", "M 6 12 L 2 12", "M 12 6 L 12 2", "M 12 22 L 12 18"},
	["download"] = {"M12 15V3", "M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4", "m7 10 5 5 5-5"},
	["eye"] = {"M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0", "M 9.0 12.0 a 3.0 3.0 0 1 0 6.0 0 a 3.0 3.0 0 1 0 -6.0 0"},
	["feather"] = {"M14.086 18.412A2 2 0 0112.67 19H5v-7.672a2 2 0 01.586-1.414L11.75 3.75a6 6 0 118.49 8.49z", "M16 8 2 22", "M17.488 15H9"},
	["folder"] = {"M20 20a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2h-7.9a2 2 0 0 1-1.69-.9L9.6 3.9A2 2 0 0 0 7.93 3H4a2 2 0 0 0-2 2v13a2 2 0 0 0 2 2Z"},
	["footprints"] = {"M4 16v-2.38C4 11.5 2.97 10.5 3 8c.03-2.72 1.49-6 4.5-6C9.37 2 10 3.8 10 5.5c0 3.11-2 5.66-2 8.68V16a2 2 0 1 1-4 0Z", "M20 20v-2.38c0-2.12 1.03-3.12 1-5.62-.03-2.72-1.49-6-4.5-6C14.63 6 14 7.8 14 9.5c0 3.11 2 5.66 2 8.68V20a2 2 0 1 0 4 0Z", "M16 17h4", "M4 13h4"},
	["gauge"] = {"m12 14 4-4", "M3.34 19a10 10 0 1 1 17.32 0"},
	["heart"] = {"M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5"},
	["house"] = {"M15 21v-8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v8", "M3 10a2 2 0 0 1 .709-1.528l7-6a2 2 0 0 1 2.582 0l7 6A2 2 0 0 1 21 10v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"},
	["infinity"] = {"M6 16c5 0 7-8 12-8a4 4 0 0 1 0 8c-5 0-7-8-12-8a4 4 0 1 0 0 8"},
	["info"] = {"M 2.0 12.0 a 10.0 10.0 0 1 0 20.0 0 a 10.0 10.0 0 1 0 -20.0 0", "M12 16v-4", "M12 8h.01"},
	["keyboard"] = {"M10 8h.01", "M12 12h.01", "M14 8h.01", "M16 12h.01", "M18 8h.01", "M6 8h.01", "M7 16h10", "M8 12h.01", "M 4.0 4.0 h 16.0 a 2.0 2.0 0 0 1 2.0 2.0 v 12.0 a 2.0 2.0 0 0 1 -2.0 2.0 h -16.0 a 2.0 2.0 0 0 1 -2.0 -2.0 v -12.0 a 2.0 2.0 0 0 1 2.0 -2.0 z"},
	["layers"] = {"M12.83 2.18a2 2 0 0 0-1.66 0L2.6 6.08a1 1 0 0 0 0 1.83l8.58 3.91a2 2 0 0 0 1.66 0l8.58-3.9a1 1 0 0 0 0-1.83z", "M2 12a1 1 0 0 0 .58.91l8.6 3.91a2 2 0 0 0 1.65 0l8.58-3.9A1 1 0 0 0 22 12", "M2 17a1 1 0 0 0 .58.91l8.6 3.91a2 2 0 0 0 1.65 0l8.58-3.9A1 1 0 0 0 22 17"},
	["map-pin"] = {"M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0", "M 9.0 10.0 a 3.0 3.0 0 1 0 6.0 0 a 3.0 3.0 0 1 0 -6.0 0"},
	["minus"] = {"M5 12h14"},
	["palette"] = {"M12 22a1 1 0 0 1 0-20 10 9 0 0 1 10 9 5 5 0 0 1-5 5h-2.25a1.75 1.75 0 0 0-1.4 2.8l.3.4a1.75 1.75 0 0 1-1.4 2.8z", "M 13.0 6.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0", "M 17.0 10.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0", "M 6.0 12.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0", "M 8.0 7.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0"},
	["person-standing"] = {"M 11.0 5.0 a 1.0 1.0 0 1 0 2.0 0 a 1.0 1.0 0 1 0 -2.0 0", "m9 20 3-6 3 6", "m6 8 6 2 6-2", "M12 10v4"},
	["power"] = {"M12 2v10", "M18.4 6.6a9 9 0 1 1-12.77.04"},
	["radar"] = {"M19.07 4.93A10 10 0 0 0 6.99 3.34", "M4 6h.01", "M2.29 9.62A10 10 0 1 0 21.31 8.35", "M16.24 7.76A6 6 0 1 0 8.23 16.67", "M12 18h.01", "M17.99 11.66A6 6 0 0 1 15.77 16.67", "M 10.0 12.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "m13.41 10.59 5.66-5.66"},
	["ruler"] = {"M21.3 15.3a2.4 2.4 0 0 1 0 3.4l-2.6 2.6a2.4 2.4 0 0 1-3.4 0L2.7 8.7a2.41 2.41 0 0 1 0-3.4l2.6-2.6a2.41 2.41 0 0 1 3.4 0Z", "m14.5 12.5 2-2", "m11.5 9.5 2-2", "m8.5 6.5 2-2", "m17.5 15.5 2-2"},
	["save"] = {"M15.2 3a2 2 0 0 1 1.4.6l3.8 3.8a2 2 0 0 1 .6 1.4V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z", "M17 21v-7a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v7", "M7 3v4a1 1 0 0 0 1 1h7"},
	["scan-eye"] = {"M3 7V5a2 2 0 0 1 2-2h2", "M17 3h2a2 2 0 0 1 2 2v2", "M21 17v2a2 2 0 0 1-2 2h-2", "M7 21H5a2 2 0 0 1-2-2v-2", "M 11.0 12.0 a 1.0 1.0 0 1 0 2.0 0 a 1.0 1.0 0 1 0 -2.0 0", "M18.944 12.33a1 1 0 0 0 0-.66 7.5 7.5 0 0 0-13.888 0 1 1 0 0 0 0 .66 7.5 7.5 0 0 0 13.888 0"},
	["scan-line"] = {"M3 7V5a2 2 0 0 1 2-2h2", "M17 3h2a2 2 0 0 1 2 2v2", "M21 17v2a2 2 0 0 1-2 2h-2", "M7 21H5a2 2 0 0 1-2-2v-2", "M7 12h10"},
	["settings"] = {"M9.671 4.136a2.34 2.34 0 0 1 4.659 0 2.34 2.34 0 0 0 3.319 1.915 2.34 2.34 0 0 1 2.33 4.033 2.34 2.34 0 0 0 0 3.831 2.34 2.34 0 0 1-2.33 4.033 2.34 2.34 0 0 0-3.319 1.915 2.34 2.34 0 0 1-4.659 0 2.34 2.34 0 0 0-3.32-1.915 2.34 2.34 0 0 1-2.33-4.033 2.34 2.34 0 0 0 0-3.831A2.34 2.34 0 0 1 6.35 6.051a2.34 2.34 0 0 0 3.319-1.915", "M 9.0 12.0 a 3.0 3.0 0 1 0 6.0 0 a 3.0 3.0 0 1 0 -6.0 0"},
	["skull"] = {"m12.5 17-.5-1-.5 1h1z", "M15 22a1 1 0 0 0 1-1v-1a2 2 0 0 0 1.56-3.25 8 8 0 1 0-11.12 0A2 2 0 0 0 8 20v1a1 1 0 0 0 1 1z", "M 14.0 12.0 a 1.0 1.0 0 1 0 2.0 0 a 1.0 1.0 0 1 0 -2.0 0", "M 8.0 12.0 a 1.0 1.0 0 1 0 2.0 0 a 1.0 1.0 0 1 0 -2.0 0"},
	["sliders-horizontal"] = {"M10 5H3", "M12 19H3", "M14 3v4", "M16 17v4", "M21 12h-9", "M21 19h-5", "M21 5h-7", "M8 10v4", "M8 12H3"},
	["spline"] = {"M 17.0 5.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "M 3.0 19.0 a 2.0 2.0 0 1 0 4.0 0 a 2.0 2.0 0 1 0 -4.0 0", "M5 17A12 12 0 0 1 17 5"},
	["square"] = {"M 5.0 3.0 h 14.0 a 2.0 2.0 0 0 1 2.0 2.0 v 14.0 a 2.0 2.0 0 0 1 -2.0 2.0 h -14.0 a 2.0 2.0 0 0 1 -2.0 -2.0 v -14.0 a 2.0 2.0 0 0 1 2.0 -2.0 z"},
	["swords"] = {"m13 19 6-6", "M14.5 17.5 3.586 6.586A2 2 0 013 5.172V3h2.172a2 2 0 011.414.586L17.5 14.5", "m14.828 6.172 2.586-2.586A2 2 0 0118.828 3H21v2.172a2 2 0 01-.586 1.414l-2.586 2.586", "m16 16 4 4", "m19 21 2-2", "m5 14 4 4", "m5 21-2-2", "M7.5 16.5 4 20"},
	["tag"] = {"M12.586 2.586A2 2 0 0 0 11.172 2H4a2 2 0 0 0-2 2v7.172a2 2 0 0 0 .586 1.414l8.704 8.704a2.426 2.426 0 0 0 3.42 0l6.58-6.58a2.426 2.426 0 0 0 0-3.42z", "M 7.0 7.5 a 0.5 0.5 0 1 0 1.0 0 a 0.5 0.5 0 1 0 -1.0 0"},
	["upload"] = {"M12 3v12", "m17 8-5-5-5 5", "M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"},
	["user"] = {"M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2", "M 8.0 7.0 a 4.0 4.0 0 1 0 8.0 0 a 4.0 4.0 0 1 0 -8.0 0"},
	["users"] = {"M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2", "M16 3.128a4 4 0 0 1 0 7.744", "M22 21v-2a4 4 0 0 0-3-3.87", "M 5.0 7.0 a 4.0 4.0 0 1 0 8.0 0 a 4.0 4.0 0 1 0 -8.0 0"},
	["wind"] = {"M12.8 19.6A2 2 0 1 0 14 16H2", "M17.5 8a2.5 2.5 0 1 1 2 4H2", "M9.8 4.4A2 2 0 1 1 11 8H2"},
	["wrench"] = {"M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.106-3.105c.32-.322.863-.22.983.218a6 6 0 0 1-8.259 7.057l-7.91 7.91a1 1 0 0 1-2.999-3l7.91-7.91a6 6 0 0 1 7.057-8.259c.438.12.54.662.219.984z"},
	["x"] = {"M18 6 6 18", "m6 6 12 12"},
}
local WORDMARK_B64 = "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"

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
		while i <= n do
			c = string.sub(d, i, i)
			if c >= "0" and c <= "9" then i += 1
			elseif c == "." then i += 1
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

-- / icon assets (rasterize once, tint in UI) \ --
local Icon = {cache = {}, tess = {}}
local hasAssets = (writefile ~= nil) and ((getcustomasset ~= nil) or (getsynasset ~= nil))
local loadAsset = getcustomasset or getsynasset

local function ensureFolder()
	if makefolder and isfolder then
		pcall(function() if not isfolder("Feather") then makefolder("Feather") end end)
		pcall(function() if not isfolder("Feather/icons") then makefolder("Feather/icons") end end)
	end
end

function Icon.get(name, size)
	if not (hasAssets and ICONS[name]) then return nil end
	local key = name .. "_" .. size
	if Icon.cache[key] then return Icon.cache[key] end
	local segs = Icon.tess[name]
	if not segs then
		segs = {}
		for _, d in ipairs(ICONS[name]) do tessPath(d, segs) end
		Icon.tess[name] = segs
	end
	local path = "Feather/icons/" .. key .. ".png"
	local ok, id
	if isfile and isfile(path) then
		ok, id = pcall(loadAsset, path)
	else
		local scale = size / 24
		local half, aa = 1.0, 0.9 / scale
		local png = PNG.encode(size, size, function(x, y)
			local px, py = (x + 0.5) / scale, (y + 0.5) / scale
			local best = 1e9
			for _, s in ipairs(segs) do
				local dd = distSeg(px, py, s)
				if dd < best then best = dd end
			end
			return math.clamp((half - best) / aa + 0.5, 0, 1)
		end)
		ensureFolder()
		local wrote = pcall(writefile, path, png)
		if wrote then ok, id = pcall(loadAsset, path) end
	end
	if ok and id then Icon.cache[key] = id return id end
	return nil
end

local wordmarkAsset
local function getWordmark()
	if wordmarkAsset ~= nil then return wordmarkAsset end
	wordmarkAsset = false
	if hasAssets and WORDMARK_B64 ~= "" then
		ensureFolder()
		local path = "Feather/wordmark.png"
		if not (isfile and isfile(path)) then pcall(writefile, path, B64.decode(WORDMARK_B64)) end
		local ok, id = pcall(loadAsset, path)
		if ok and id then wordmarkAsset = id end
	end
	return wordmarkAsset
end

-- / theme (white) \ --
local Theme = {
	Accent = Color3.fromRGB(40, 40, 40),
	bg = Color3.fromRGB(252, 252, 253),
	panel = Color3.fromRGB(255, 255, 255),
	raised = Color3.fromRGB(246, 246, 248),
	hover = Color3.fromRGB(238, 238, 241),
	line = Color3.fromRGB(228, 228, 232),
	text = Color3.fromRGB(28, 28, 32),
	sub = Color3.fromRGB(128, 128, 136),
	dim = Color3.fromRGB(176, 176, 184),
	onAccent = Color3.fromRGB(255, 255, 255),
	good = Color3.fromRGB(70, 180, 110),
	bad = Color3.fromRGB(226, 80, 80),
	warn = Color3.fromRGB(230, 170, 60),
}
local FONT = Enum.Font.GothamMedium
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
	task.spawn(function()
		local id = Icon.get(name, math.max(48, size * 2))
		if id and holder.Parent then holder.Image = id end
	end)
	return holder
end

local function round(n, decimals)
	local m = 10 ^ (decimals or 0)
	return math.floor(n * m + 0.5) / m
end

-- / library \ --
local Feather = {Theme = Theme, ToggleKey = Enum.KeyCode.RightShift, Flags = {}, _windows = {}, _notifs = nil}

local function hudParent(gui)
	local ok = pcall(function() gui.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
	if not ok or not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end

if getgenv then
	if getgenv().__FeatherUnload then pcall(getgenv().__FeatherUnload) end
end

-- / notifications \ --
local function notifRoot()
	if Feather._notifs and Feather._notifs.Parent then return Feather._notifs end
	local gui = new("ScreenGui", {Name = HttpService:GenerateGUID(false), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 1000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
	hudParent(gui)
	local holder = new("Frame", {
		AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -16), Size = UDim2.new(0, 300, 1, -32),
		BackgroundTransparency = 1, Parent = gui,
	}, {new("UIListLayout", {Padding = UDim.new(0, 8), VerticalAlignment = Enum.VerticalAlignment.Bottom, HorizontalAlignment = Enum.HorizontalAlignment.Right, SortOrder = Enum.SortOrder.LayoutOrder})})
	Feather._notifs = holder
	return holder
end

function Feather:Notify(opts)
	opts = opts or {}
	local holder = notifRoot()
	local accent = ({success = Theme.good, error = Theme.bad, warning = Theme.warn, info = Theme.Accent})[opts.Type] or Theme.Accent
	local card = new("Frame", {BackgroundColor3 = Theme.panel, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Parent = holder}, {corner(12), stroke(Theme.line, 0.2)})
	new("Frame", {BackgroundColor3 = accent, Size = UDim2.new(0, 3, 1, -16), Position = UDim2.fromOffset(0, 8), BorderSizePixel = 0, Parent = card}, {corner(2)})
	local inner = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, -16, 0, 0), Position = UDim2.fromOffset(14, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = card}, {pad(12)})
	new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = inner})
	label({Text = opts.Title or "Notice", Font = BOLD, TextSize = 13, Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 1, Parent = inner})
	label({Text = opts.Content or "", TextSize = 12, TextColor3 = Theme.sub, TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 2, Parent = inner})
	card.BackgroundTransparency = 1
	go(card, 0.25, {BackgroundTransparency = 0})
	local life = opts.Duration or 4
	task.delay(life, function()
		if card.Parent then
			go(card, 0.25, {BackgroundTransparency = 1})
			go(card, 0.25, {Position = card.Position + UDim2.fromOffset(30, 0)})
			task.delay(0.26, function() card:Destroy() end)
		end
	end)
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
local function makeDraggable(handle, target)
	local dragging, startInput, startPos, goal, step
	handle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		dragging = true
		startInput = input.Position
		startPos = target.Position
		goal = startPos
		if not step then
			step = RunService.RenderStepped:Connect(function(dt)
				if not target.Parent then step:Disconnect() step = nil return end
				if dragging then
					local m = UserInputService:GetMouseLocation()
					local delta = Vector2.new(m.X, m.Y) - startInput
					if input.UserInputType == Enum.UserInputType.Touch then delta = input.Position - startInput end
					goal = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
				local cur = target.Position
				local a = 1 - math.exp(-math.min(dt, 0.1) * 20)
				target.Position = UDim2.new(goal.X.Scale, cur.X.Offset + (goal.X.Offset - cur.X.Offset) * a, goal.Y.Scale, cur.Y.Offset + (goal.Y.Offset - cur.Y.Offset) * a)
			end)
		end
		startInput = UserInputService:GetMouseLocation()
		if input.UserInputType == Enum.UserInputType.Touch then startInput = input.Position end
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end)
end

local W, H = 430, 480

function Feather:CreateWindow(opts)
	opts = opts or {}
	if opts.Accent then Theme.Accent = opts.Accent end
	local gui = new("ScreenGui", {Name = HttpService:GenerateGUID(false), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
	hudParent(gui)

	local root = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(W, H), BackgroundTransparency = 1, Visible = false, Parent = gui})
	local shellScale = new("UIScale", {Scale = 0.96, Parent = root})
	local panel = new("CanvasGroup", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.bg, GroupTransparency = 1, Parent = root}, {corner(16), stroke(Theme.line, 0)})

	-- header
	local header = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 52), Parent = panel})
	local wm = getWordmark()
	if wm then
		new("ImageLabel", {BackgroundTransparency = 1, Image = wm, ImageColor3 = Theme.text, ScaleType = Enum.ScaleType.Fit, Position = UDim2.fromOffset(18, 14), Size = UDim2.fromOffset(84, 30), Parent = header})
	else
		label({Text = opts.Name or "Feather", Font = BOLD, TextSize = 17, Position = UDim2.fromOffset(18, 0), Size = UDim2.new(0, 160, 1, 0), Parent = header})
	end
	local titleLabel = label({Text = opts.Title or "", TextSize = 12, TextColor3 = Theme.sub, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -86, 0.5, 0), Size = UDim2.fromOffset(180, 16), Parent = header})
	new("Frame", {BackgroundColor3 = Theme.line, Size = UDim2.new(1, -36, 0, 1), Position = UDim2.new(0, 18, 1, -1), BorderSizePixel = 0, Parent = header})

	local function headerButton(x, icon)
		local b = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, x, 0.5, 0), Size = UDim2.fromOffset(28, 28), Parent = header}, {corner(8), stroke(Theme.line, 0.1)})
		makeIcon(b, icon, 15, Theme.sub).Position = UDim2.fromOffset(6.5, 6.5)
		b.MouseEnter:Connect(function() go(b, 0.15, {BackgroundColor3 = Theme.hover}) end)
		b.MouseLeave:Connect(function() go(b, 0.2, {BackgroundColor3 = Theme.raised}) end)
		return b
	end
	local closeBtn = headerButton(-14, "x")
	local minBtn = headerButton(-48, "minus")

	-- body (holds the active tab's page pills + page content)
	local body = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 52), Size = UDim2.new(1, 0, 1, -52 - 62), Parent = panel})

	-- bottom tab bar
	local tabbar = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), Size = UDim2.new(1, -24, 0, 44), Parent = panel}, {corner(14)})
	new("Frame", {BackgroundColor3 = Theme.raised, Size = UDim2.fromScale(1, 1), BorderSizePixel = 0, Parent = tabbar}, {corner(14), stroke(Theme.line, 0.2)})
	local tabRow = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = tabbar}, {new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6)})})

	local Window = {tabs = {}, _active = nil}

	local function selectTab(tab)
		if Window._active == tab then return end
		for _, t in ipairs(Window.tabs) do
			local on = t == tab
			t.host.Visible = on
			go(t.pill, 0.2, {BackgroundTransparency = on and 0 or 1})
			t._icon.ImageColor3 = on and Theme.onAccent or Theme.sub
			if t._text then t._text.TextColor3 = on and Theme.onAccent or Theme.sub end
		end
		Window._active = tab
	end

	function Window:Tab(tabOpts)
		tabOpts = tabOpts or {}
		local host = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = body})
		local pillRow = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, -36, 0, 30), Position = UDim2.fromOffset(18, 6), Parent = host}, {new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), VerticalAlignment = Enum.VerticalAlignment.Center})})
		local pageHost = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 40), Size = UDim2.new(1, 0, 1, -40), Parent = host})

		local pill = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.Accent, BackgroundTransparency = 1, Size = UDim2.fromOffset(44, 34), Parent = tabRow}, {corner(10)})
		local iconImg = makeIcon(pill, tabOpts.Icon or "circle", 18, Theme.sub)
		iconImg.AnchorPoint = Vector2.new(0.5, 0.5)
		iconImg.Position = UDim2.fromScale(0.5, 0.5)

		local tab = {host = host, pill = pill, _icon = iconImg, pages = {}, _pageHost = pageHost, _pillRow = pillRow, _activePage = nil}
		Feather._accentHooks[#Feather._accentHooks + 1] = function(c) pill.BackgroundColor3 = c end

		local function selectPage(page)
			if tab._activePage == page then return end
			for _, p in ipairs(tab.pages) do
				local on = p == page
				p.scroller.Visible = on
				go(p._pill, 0.2, {BackgroundColor3 = on and Theme.raised or Theme.panel})
				p._label.TextColor3 = on and Theme.text or Theme.sub
			end
			tab._activePage = page
		end

		function tab:Page(pageOpts)
			pageOpts = pageOpts or {}
			local scroller = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.dim, ScrollBarImageTransparency = 0.3, ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false, Parent = pageHost}, {new("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}), new("UIPadding", {PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 18), PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 14)})})

			local pillBtn = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.panel, Size = UDim2.fromOffset(0, 28), AutomaticSize = Enum.AutomaticSize.X, Parent = pillRow}, {corner(9), stroke(Theme.line, 0.3), new("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)}), new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), VerticalAlignment = Enum.VerticalAlignment.Center})})
			if pageOpts.Icon then
				local pi = makeIcon(pillBtn, pageOpts.Icon, 14, Theme.sub)
				pi.LayoutOrder = 1
			end
			local pl = label({Text = pageOpts.Name or "Page", Font = BOLD, TextSize = 12, TextColor3 = Theme.sub, Size = UDim2.fromOffset(0, 28), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = 2, Parent = pillBtn})

			local page = {scroller = scroller, _pill = pillBtn, _label = pl}
			table.insert(tab.pages, page)
			pillBtn.MouseButton1Click:Connect(function() selectPage(page) end)
			pillRow.Visible = #tab.pages > 1

			-- group / section
			local function addGroup(name)
				local card = new("Frame", {BackgroundColor3 = Theme.panel, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = #scroller:GetChildren(), Parent = scroller}, {corner(12), stroke(Theme.line, 0.2)})
				local inner = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = card}, {new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}), new("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)})})
				if name and name ~= "" then
					label({Text = string.upper(name), Font = BOLD, TextSize = 10, TextColor3 = Theme.sub, Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 0, Parent = inner})
				end

				local Group = {}
				local order = 1
				local function baseRow(o)
					o = o or {}
					local row = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = order, Parent = inner})
					order += 1
					local leftX = 0
					if o.Icon then
						makeIcon(row, o.Icon, 17, Theme.sub).Position = UDim2.fromOffset(0, 10)
						leftX = 26
					end
					local tHeight = (o.Description and o.Description ~= "") and 15 or 38
					label({Text = o.Name or "", Font = BOLD, TextSize = 13, Position = UDim2.fromOffset(leftX, o.Description and 5 or 0), Size = UDim2.new(1, leftX + 120, 0, tHeight), Parent = row})
					if o.Description and o.Description ~= "" then
						label({Text = o.Description, TextSize = 11, TextColor3 = Theme.sub, Position = UDim2.fromOffset(leftX, 21), Size = UDim2.new(1, -(leftX + 120), 0, 13), Parent = row})
					end
					return row
				end

				function Group:Toggle(o)
					local row = baseRow(o)
					local state = o.Default or false
					local track = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.line, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(40, 22), Parent = row}, {corner(11)})
					local knob = new("Frame", {BackgroundColor3 = Theme.panel, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(3, 11), Size = UDim2.fromOffset(16, 16), Parent = track}, {corner(8)})
					local control = {}
					local function apply(v, fire)
						state = v and true or false
						go(track, 0.2, {BackgroundColor3 = state and Theme.Accent or Theme.line})
						go(knob, 0.2, {Position = UDim2.fromOffset(state and 21 or 3, 11)}, Enum.EasingStyle.Back)
						if fire and o.Callback then task.spawn(o.Callback, state) end
					end
					track.MouseButton1Click:Connect(function() apply(not state, true) end)
					function control:Set(v) apply(v, true) end
					function control:Get() return state end
					apply(state, false)
					if o.Flag then Feather.Flags[o.Flag] = {value = state, get = function() return state end, set = function(v) apply(v, true) end} end
					if o.Default then task.defer(function() if o.Callback then o.Callback(true) end end) end
					return control
				end

				function Group:Slider(o)
					local row = baseRow(o)
					row.Size = UDim2.new(1, 0, 0, 46)
					local dec = o.Decimals or 0
					local minV, maxV = o.Min or 0, o.Max or 100
					local value = o.Default or minV
					local valLabel = label({Text = "", TextSize = 12, TextColor3 = Theme.sub, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 2), Size = UDim2.fromOffset(90, 15), Parent = row})
					local bar = new("Frame", {BackgroundColor3 = Theme.line, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, -6), Size = UDim2.new(1, 0, 0, 6), Parent = row}, {corner(3)})
					local fill = new("Frame", {BackgroundColor3 = Theme.Accent, Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, Parent = bar}, {corner(3)})
					local control, dragging = {}, false
					local function apply(v, fire)
						value = math.clamp(round(v, dec), minV, maxV)
						local frac = (value - minV) / math.max(maxV - minV, 1e-6)
						fill.Size = UDim2.fromScale(frac, 1)
						valLabel.Text = tostring(value) .. (o.Suffix or "")
						if fire and o.Callback then task.spawn(o.Callback, value) end
					end
					local function fromX(px)
						local frac = math.clamp((px - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
						apply(minV + frac * (maxV - minV), true)
					end
					bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true fromX(i.Position.X) end end)
					UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then fromX(i.Position.X) end end)
					UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
					function control:Set(v) apply(v, true) end
					function control:Get() return value end
					apply(value, false)
					if o.Flag then Feather.Flags[o.Flag] = {value = value, get = function() return value end, set = function(v) apply(v, true) end} end
					return control
				end

				function Group:Button(o)
					local row = baseRow(o)
					local btn = new("TextButton", {Text = o.ButtonText or "Run", Font = BOLD, TextSize = 12, TextColor3 = Theme.onAccent, AutoButtonColor = false, BackgroundColor3 = Theme.Accent, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(78, 28), Parent = row}, {corner(8)})
					btn.MouseEnter:Connect(function() go(btn, 0.15, {BackgroundTransparency = 0.12}) end)
					btn.MouseLeave:Connect(function() go(btn, 0.2, {BackgroundTransparency = 0}) end)
					btn.MouseButton1Click:Connect(function() if o.Callback then task.spawn(o.Callback) end end)
					return {}
				end

				function Group:HoldButton(o)
					local row = baseRow(o)
					local btn = new("TextButton", {Text = o.Name or "Hold", Font = BOLD, TextSize = 12, TextColor3 = Theme.onAccent, AutoButtonColor = false, BackgroundColor3 = Theme.bad, Size = UDim2.new(1, 0, 0, 34), Parent = row}, {corner(9)})
					btn.Position = UDim2.fromOffset(0, 2)
					row.Size = UDim2.new(1, 0, 0, 40)
					local fillHold = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.78, Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, Parent = btn}, {corner(9)})
					local holding, fired
					btn.MouseButton1Down:Connect(function()
						holding, fired = true, false
						local t0 = os.clock()
						local dur = o.Duration or 1
						task.spawn(function()
							while holding and not fired do
								local p = (os.clock() - t0) / dur
								fillHold.Size = UDim2.fromScale(math.clamp(p, 0, 1), 1)
								if p >= 1 then fired = true if o.Callback then task.spawn(o.Callback) end end
								RunService.RenderStepped:Wait()
							end
						end)
					end)
					local function release() holding = false go(fillHold, 0.2, {Size = UDim2.fromScale(0, 1)}) end
					btn.MouseButton1Up:Connect(release)
					btn.MouseLeave:Connect(release)
					return {}
				end

				function Group:Dropdown(o)
					local row = baseRow(o)
					local multi = o.Multi
					local selected = {}
					if o.Default then
						if type(o.Default) == "table" then for _, v in ipairs(o.Default) do selected[v] = true end
						else selected[o.Default] = true end
					end
					local function displayText()
						local list = {}
						for k in pairs(selected) do table.insert(list, k) end
						table.sort(list)
						if #list == 0 then return o.Placeholder or "None" end
						return table.concat(list, ", ")
					end
					local box = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(150, 28), Parent = row}, {corner(8), stroke(Theme.line, 0.2)})
					local boxText = label({Text = displayText(), TextSize = 12, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -30, 1, 0), Parent = box})
					makeIcon(box, "chevron-down", 14, Theme.sub).Position = UDim2.new(1, -20, 0.5, -7)
					local popup = new("Frame", {BackgroundColor3 = Theme.panel, Visible = false, ZIndex = 20, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 1, 4), Size = UDim2.new(0, 150, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = box}, {corner(8), stroke(Theme.line, 0), new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}), new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4)})})
					local control = {}
					local function fire()
						boxText.Text = displayText()
						if o.Callback then
							if multi then
								local list = {} for k in pairs(selected) do table.insert(list, k) end
								task.spawn(o.Callback, list)
							else
								task.spawn(o.Callback, (next(selected)))
							end
						end
					end
					local function rebuild(options)
						for _, c in ipairs(popup:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
						for idx, opt in ipairs(options) do
							local item = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26), ZIndex = 21, LayoutOrder = idx, Parent = popup}, {corner(6)})
							label({Text = opt, TextSize = 12, Position = UDim2.fromOffset(8, 0), Size = UDim2.new(1, -16, 1, 0), ZIndex = 21, Parent = item})
							local tick = makeIcon(item, "check", 13, Theme.Accent)
							tick.Position = UDim2.new(1, -20, 0.5, -6.5)
							tick.ZIndex = 21
							local function paint() tick.Visible = selected[opt] == true item.BackgroundTransparency = selected[opt] and 0 or 1 end
							paint()
							item.MouseButton1Click:Connect(function()
								if multi then selected[opt] = (not selected[opt]) or nil
								else selected = {[opt] = true} end
								for _, c in ipairs(popup:GetChildren()) do if c:IsA("TextButton") then c.BackgroundTransparency = 1 end end
								for _, c in ipairs(popup:GetChildren()) do
									if c:IsA("TextButton") then
										local lbl = c:FindFirstChildOfClass("TextLabel")
										local img = c:FindFirstChildOfClass("ImageLabel")
										if lbl and img then img.Visible = selected[lbl.Text] == true c.BackgroundTransparency = selected[lbl.Text] and 0 or 1 end
									end
								end
								if not multi then popup.Visible = false end
								fire()
							end)
						end
					end
					rebuild(o.Options or {})
					box.MouseButton1Click:Connect(function() popup.Visible = not popup.Visible end)
					function control:Set(v) selected = {} if type(v) == "table" then for _, x in ipairs(v) do selected[x] = true end elseif v then selected[v] = true end rebuild(o.Options or {}) fire() end
					function control:Get() if multi then local l = {} for k in pairs(selected) do table.insert(l, k) end return l else return (next(selected)) end end
					function control:Refresh(options) o.Options = options rebuild(options) end
					if o.Flag then Feather.Flags[o.Flag] = {get = control.Get, set = control.Set} end
					return control
				end

				function Group:Segmented(o)
					local row = baseRow(o)
					row.Size = UDim2.new(1, 0, 0, 44)
					local holder = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 2), Size = UDim2.fromOffset(math.min(210, (#(o.Options or {}) * 64)), 26), Parent = row}, {corner(8), new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder})})
					local value = o.Default or (o.Options and o.Options[1])
					local buttons = {}
					local control = {}
					local function paint()
						for opt, b in pairs(buttons) do
							local on = opt == value
							go(b, 0.2, {BackgroundTransparency = on and 0 or 1})
							b.TextColor3 = on and Theme.onAccent or Theme.sub
						end
					end
					for idx, opt in ipairs(o.Options or {}) do
						local b = new("TextButton", {Text = opt, Font = BOLD, TextSize = 11, TextColor3 = Theme.sub, AutoButtonColor = false, BackgroundColor3 = Theme.Accent, BackgroundTransparency = 1, Size = UDim2.new(1 / #o.Options, 0, 1, 0), LayoutOrder = idx, Parent = holder}, {corner(7)})
						buttons[opt] = b
						b.MouseButton1Click:Connect(function() value = opt paint() if o.Callback then task.spawn(o.Callback, value) end end)
					end
					paint()
					function control:Set(v) value = v paint() if o.Callback then task.spawn(o.Callback, v) end end
					function control:Get() return value end
					if o.Flag then Feather.Flags[o.Flag] = {get = control.Get, set = control.Set} end
					return control
				end

				function Group:Input(o)
					local row = baseRow(o)
					local box = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(150, 28), Parent = row}, {corner(8), stroke(Theme.line, 0.2)})
					local tb = new("TextBox", {BackgroundTransparency = 1, Text = o.Default or "", PlaceholderText = o.Placeholder or "", Font = FONT, TextSize = 12, TextColor3 = Theme.text, PlaceholderColor3 = Theme.dim, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), Parent = box})
					local control = {}
					tb.FocusLost:Connect(function() if o.Callback then task.spawn(o.Callback, tb.Text) end end)
					function control:Get() return tb.Text end
					function control:Set(v) tb.Text = v end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return tb.Text end, set = function(v) tb.Text = v end} end
					return control
				end

				function Group:Keybind(o)
					local row = baseRow(o)
					local key = o.Default
					local btn = new("TextButton", {Text = key and key.Name or "None", Font = BOLD, TextSize = 12, TextColor3 = Theme.sub, AutoButtonColor = false, BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(90, 28), Parent = row}, {corner(8), stroke(Theme.line, 0.2)})
					local listening = false
					btn.MouseButton1Click:Connect(function() listening = true btn.Text = "..." end)
					UserInputService.InputBegan:Connect(function(input, gp)
						if not listening then return end
						if input.UserInputType == Enum.UserInputType.Keyboard then
							listening = false key = input.KeyCode btn.Text = key.Name
							if o.ChangedCallback then task.spawn(o.ChangedCallback, key) end
						end
					end)
					return {Get = function() return key end, Set = function(_, k) key = k btn.Text = k and k.Name or "None" end}
				end

				function Group:Colorpicker(o)
					local row = baseRow(o)
					local color = o.Default or Theme.Accent
					local swatch = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = color, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(34, 22), Parent = row}, {corner(7), stroke(Theme.line, 0.1)})
					local popup = new("Frame", {BackgroundColor3 = Theme.panel, Visible = false, ZIndex = 30, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 1, 6), Size = UDim2.fromOffset(180, 150), Parent = swatch}, {corner(10), stroke(Theme.line, 0), pad(8)})
					local sv = new("ImageButton", {AutoButtonColor = false, BackgroundColor3 = Color3.fromHSV(0, 1, 1), Size = UDim2.new(1, 0, 0, 104), ZIndex = 31, Parent = popup}, {corner(6)})
					new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), ZIndex = 31, Parent = sv}, {corner(6), new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})})})
					new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), ZIndex = 31, Parent = sv}, {corner(6), new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})})})
					local svDot = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromOffset(8, 8), AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 32, Parent = sv}, {corner(4), stroke(Color3.new(0, 0, 0), 0.4)})
					local hue = new("ImageButton", {AutoButtonColor = false, Position = UDim2.new(0, 0, 0, 112), Size = UDim2.new(1, 0, 0, 14), ZIndex = 31, Parent = popup}, {corner(5)})
					local hueGrad = new("UIGradient", {Parent = hue, Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))})})
					local hueDot = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromOffset(4, 16), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), ZIndex = 32, Parent = hue}, {corner(2), stroke(Color3.new(0, 0, 0), 0.4)})
					local h, s, v = Color3.toHSV(color)
					local control = {}
					local function apply(fire)
						color = Color3.fromHSV(h, s, v)
						swatch.BackgroundColor3 = color
						sv.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
						svDot.Position = UDim2.fromScale(s, 1 - v)
						hueDot.Position = UDim2.fromScale(h, 0.5)
						if fire and o.Callback then task.spawn(o.Callback, color) end
					end
					local draggingSV, draggingH
					sv.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSV = true end end)
					hue.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingH = true end end)
					UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSV, draggingH = false, false end end)
					UserInputService.InputChanged:Connect(function(i)
						if i.UserInputType ~= Enum.UserInputType.MouseMovement then return end
						local m = UserInputService:GetMouseLocation()
						if draggingSV then
							s = math.clamp((m.X - sv.AbsolutePosition.X) / sv.AbsoluteSize.X, 0, 1)
							v = 1 - math.clamp((m.Y - sv.AbsolutePosition.Y) / sv.AbsoluteSize.Y, 0, 1)
							apply(true)
						elseif draggingH then
							h = math.clamp((m.X - hue.AbsolutePosition.X) / hue.AbsoluteSize.X, 0, 1)
							apply(true)
						end
					end)
					swatch.MouseButton1Click:Connect(function() popup.Visible = not popup.Visible end)
					apply(false)
					function control:Set(c) h, s, v = Color3.toHSV(c) apply(true) end
					function control:Get() return color end
					if o.Flag then Feather.Flags[o.Flag] = {get = control.Get, set = control.Set} end
					return control
				end

				function Group:Info(o)
					local row = baseRow({Name = o.Name, Icon = o.Icon})
					local styleColor = ({accent = Theme.Accent, success = Theme.good, error = Theme.bad, mono = Theme.sub})[o.Style] or Theme.text
					local val = label({Text = tostring(o.Value or ""), Font = o.Style == "mono" and Enum.Font.Code or BOLD, TextSize = 12, TextColor3 = styleColor, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(180, 16), Parent = row})
					return {Set = function(_, v) val.Text = tostring(v) end}
				end

				function Group:Paragraph(o)
					local box = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order, Parent = inner})
					order += 1
					label({Text = o.Content or "", TextSize = 12, TextColor3 = Theme.sub, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = box})
					return {}
				end

				function Group:Label(text)
					label({Text = text or "", TextSize = 12, TextColor3 = Theme.text, Size = UDim2.new(1, 0, 0, 20), LayoutOrder = order, Parent = inner})
					order += 1
					return {}
				end

				return Group
			end

			function page:Group(gopts) if type(gopts) == "string" then return addGroup(gopts) end return addGroup(gopts and gopts.Name) end
			function page:Section(name) return addGroup(name) end

			if #tab.pages == 1 then selectPage(page) end
			return page
		end

		pill.MouseButton1Click:Connect(function() selectTab(tab) end)
		table.insert(Window.tabs, tab)
		if #Window.tabs == 1 then selectTab(tab) end
		return tab
	end

	function Window:SetTitle(t) titleLabel.Text = t end

	makeDraggable(header, root)

	-- open / close
	local function openWindow()
		root.Visible = true
		shellScale.Scale = 0.96
		go(shellScale, 0.5, {Scale = 1}, Enum.EasingStyle.Back)
		go(panel, 0.35, {GroupTransparency = 0})
	end

	local hidden = false
	local function setHidden(v)
		hidden = v
		go(shellScale, 0.3, {Scale = v and 0.96 or 1}, v and Enum.EasingStyle.Quint or Enum.EasingStyle.Back)
		go(panel, 0.28, {GroupTransparency = v and 1 or 0})
		task.delay(0.28, function() if hidden == v then root.Visible = not v end end)
	end
	closeBtn.MouseButton1Click:Connect(function() Feather:Unload() end)
	minBtn.MouseButton1Click:Connect(function() setHidden(not hidden) end)
	UserInputService.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == Feather.ToggleKey then setHidden(not hidden) end
	end)

	function Feather:Unload()
		pcall(function() gui:Destroy() end)
		if Feather._notifs then pcall(function() Feather._notifs.Parent:Destroy() end) end
		if getgenv then getgenv().__FeatherUnload = nil end
	end
	if getgenv then getgenv().__FeatherUnload = function() pcall(gui.Destroy, gui) end end

	-- intro: dark backdrop, feather writes the cursive name, fades to white ui
	task.spawn(function()
		local cover = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(10, 10, 12), BackgroundTransparency = 1, ZIndex = 50, Parent = gui})
		go(cover, 0.4, {BackgroundTransparency = 0})
		local wmId = getWordmark()
		local holder = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromOffset(300, 120), BackgroundTransparency = 1, ZIndex = 51, Parent = cover})
		local reveal = new("Frame", {BackgroundTransparency = 1, ClipsDescendants = true, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 0, 1, 0), ZIndex = 51, Parent = holder})
		if wmId then
			new("ImageLabel", {BackgroundTransparency = 1, Image = wmId, ImageColor3 = Color3.new(1, 1, 1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(300, 120), ZIndex = 51, Parent = reveal})
		else
			label({Text = "Feather", Font = Enum.Font.GothamBlack, TextSize = 40, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromOffset(300, 120), ZIndex = 51, Parent = reveal})
		end
		local pen = makeIcon(holder, "feather", 34, Color3.new(1, 1, 1))
		pen.ZIndex = 52
		pen.AnchorPoint = Vector2.new(0.5, 0.5)
		pen.Position = UDim2.fromScale(0, 0.32)
		local t0 = os.clock()
		local dur = 1.5
		while os.clock() - t0 < dur do
			local p = (os.clock() - t0) / dur
			reveal.Size = UDim2.new(p, 0, 1, 0)
			pen.Position = UDim2.fromScale(p, 0.32)
			RunService.RenderStepped:Wait()
		end
		reveal.Size = UDim2.new(1, 0, 1, 0)
		pen.Position = UDim2.fromScale(1, 0.32)
		task.wait(0.35)
		go(pen, 0.3, {ImageTransparency = 1})
		openWindow()
		go(cover, 0.5, {BackgroundTransparency = 1})
		go(holder, 0.4, {Position = UDim2.fromScale(0.5, 0.45)})
		for _, d in ipairs(reveal:GetDescendants()) do if d:IsA("ImageLabel") or d:IsA("TextLabel") then go(d, 0.4, {ImageTransparency = 1, TextTransparency = 1}) end end
		task.wait(0.55)
		cover:Destroy()
	end)

	Feather._accentHooks[#Feather._accentHooks + 1] = function(c)
		for _, inst in ipairs(gui:GetDescendants()) do
			if inst:GetAttribute("FeatherAccent") then inst.BackgroundColor3 = c end
		end
	end

	return Window
end


return Feather
