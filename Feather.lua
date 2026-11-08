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
local WORDMARK_B64 = "iVBORw0KGgoAAAANSUhEUgAAAbcAAACcCAYAAAD8i+WqAAAi90lEQVR4nO2dB7QdVdXH9wHpnYQaivQmvfcmXQEBpfMhRQREENRPykdTpClIESkKgkrvCEioUkKRFkIPCS0QIBACpEBI8v/WXu7Hurnce2fvmTN35s7s31pvwYL35uwzM2fOOfvs/d9EjuM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4juM4Tq8SijbASQbA9ES0KBEtTESLENEAIlqAiOYnonmIqB8RzUFEsxHRTET0DSKaTESfE9E4IhpJRG8T0XNE9CgR3RdC4P/nOI5TSXxyK9cEthQRLSP/7PtZnIgWJKJpIjY3hoguJaKTQgifRryu4zhOKfDJrcsA4F3V0kS0YsPP8kS0GBFN22Vz3iSijUIIb3W5XcdxnFzxyS1HAMxIRKsQ0RpEtCYRrUxEyxER79LKwqAQwvpFG+E4jhMTn9wiAmBZItpAJrI1ZVfGO7Wys3wI4aWijXAcx4lFL3x4y+xeXE0msw3ln/2pN+FzPZ/cHMepDD65KQEQxK34bfnhCW1mqgYfFm2A4zhOTNwt2QEAHHa/FRFtLj+9ujPrxCgiWiiEMLFoQxzHcWLhO7cmAHAu2b5EtJMEg1SdE31icxynavjkJgDgiewEIto+ck5ZmTkrhHBB0UY4juPEpvZuSQB8bnYGER1Sk/sxXpRKTg8h3Fy0MY7jOHlQh495WwDMRUT/IqK1qLx8RkTDJeH6TZHReld++LxsNBF9QkRfhBAmFW2s4+QBgCXZhU5Em4ms3F+J6JQQAsvMOc7XqPvk9k8i2q5oO3hiIqLXiOhl+Rna9xNC4AnMcWoLgC2J6EYimqXpf/0jhLBXQWY5Jae2kxuA9YjokS43O4WIXiGiwUT0QsPPMF+BOk7bs/CHW0xsfWwdQrjL753TTJ0DSti9kTcfENGDRPQ4ET1JRE+FENjN6DhOAgBmJaLrOkxszGFE5JOb8zXqPLnloe/Iavt3c0kZIvq3S1o5TibOJiI+a+vECn6PnVbUeXIbEuk678vh9h0iQuxBHY6TEQCbEtEBil+t8zfMcb4OgGkBPI5sfAKAxZEdx4kEgBkAvKocg+wpcRynuSQNgGMADE4xsU0CsIXfUceJC4BjDePwUL//jtMGAFemmNz4INtxnMjydwDGKcfgZwD6+QNwnBYA2CbFxHaZ30zHiQ+Aqwzj8DR/Bo7TJtQYwJvGie1pqbDtOE5EAKxvGIcfAJjbH4DjtADAucaJbQwALuzpOE5EAEwD4EnDWNzTH4DjtADAOgAmGye3nf1mOk58AOxvGIcD/Rk4TgsATA/geePE5qVhHCcHAMwO4D3lOBzv3hPHaQOAE4wTG0+EM/kNdZz4ADjTMBb/15+B47QAwHIAvjAMps89Udtx8itlYxiPnI/qiiSO0wyAAOAR2DjS76Tj5AOAW5XjkM/H1/bn4DgtYDUD48R2H0+IfjMdJz6s8GMYi+f5M3CcFgAYIFqQWvh3F/Gb6TjxYfcigBeUY3EEB534c3CcFgC4CTb29RvpOKXwouzoz8FxWgBgB+PEdqvfSKeX4GheACcDeFvEBs4pa4QvgDkAjFKOxZuLttdxSgmA2WTAa/kIwPxF2+04RrHhIW3OjKfr4dB/FlD2owHHaQWA82FjL7+TTq/AH38Ab3R4n39BJQLAYpJeo+GYou11nFLCocNGia3birbZcYxeiVY7tkYGlemOArhWORa5WOkMRdvrOGWNxrIUIeVzigWLtttxtAC4sZcqVQNY1zAety7aXscpJQCOho0DirbZcbSwDJXyvT6iLHcVwKNKm28s2lbHKSUAlhCBVS33Fm2z42gBsBGASYr3+lMAc5XhzgLYzRBEsmjR9jpOKQFwl2Fic5Vxp2cA0B/AO8p3+wQqAXx2BuB1pc3HFm2v45QSALvDRqmiyRwnQRv1DuV7zekvM/eYC3WoB5E4TgsAzAlgpGFiewrAtH4znV4AwFG9puohO00O1tKwTdH2Ok4pAfAnw+DnM4vVirbZcTTwu2ooDXNNWe4qgD8obb6jaFsdp5QAWMeY0/b7om12HA0AZgHwsvK95orW/UqUsK2ZkL8EsGzR9jpOWXPanjVMbG/yB6Noux1HA4BLlO/1lDK59gBcqbT7nKJtdZxSAuDnsLF90TY7jgYA3zO812eXzI3Kk61Gy3Xuou11nLJq6401fABcZdzpCQAsAOBDQ3DU9FQSANyjtPsnRdvqOL1epp5xlXGnZwBwp/K95mTtJakkANhKafeLfKRQtL2OU4U6bUcXbbPjaABwsOG93rssdxXANIbzb9ePdJxmOEE1odRHM6+UyW3jOAnycWN7LeyfAbCP0u7bi7bVcUoJgNNgozRRZI6ToELyoPKdfrcs2pENMlsciZyEh/47TisALAdgomFi8zptTk8A4HDDe/2dDnlxawHYD8DpAG4A8CSAEaKlygIGH4tKP0cazxjJ9iOVdl8Qoz3H6USgHgTA/US0ifLXvySib4UQXs3QHhdNXIyIFieibxLRwkQ0gIi4/lt/IuKk2dmJiD8SfEA+kYjGEtH7RDSUiB4joutDCMPS2uBUHwD8fg0hIo0m5FUhhD3k3VyFiNYmorWIaHUiWpqIpjE0/TQRbRxCGJvB9tmIaLiMh05wG0uGEHhsOI7TB4C9YEOdIApgPgCbcXgygPMADBQ3iyZfJwleLZ/kT9KJED7PXA7gYQCfIw7HZXkyAE5UtnO8vwFON+ipnRuAOYjoFSKaT/knnxDREiGEj5quw+ok3yKilYhoZfl3/umGbNFGIYSHutCO00MA2JeILivQhEdDCOul+UOR+xou3otOvCe7tnHpTHQcPb2WY3KKYWJjTucJHMCWRLQqEa0mLpwljW6bmGxFRD65Oc2Tw+8KviWWcdXM0YqJjTnRJzbHaS3nYxFGZkahfPzRH67T9G5fXPRLCWBQmqcCYACACYrrv+TlpZxuUtTuJQ3nprA36XC7CPwg3fkKAGsQ0f4luCVXp/w7PkPTRFv+KoQwOWUbjlNNUgSRlJlNi76fTnkA8FDRLySAK1hZJIXtS0rOWhLuhne6TukDSiT441UJu+91OOR6jRACijbEKQZxzXHIPueobS+BTN2Eg6zekhSVZ4norhDCE2lL2hDR7opfXTeEwOkwjtM1eiGg5LiKTGyvEdHOPrHVC04vISIuxMnuxw05n4yI5uxC0xNlMcWTyn9kIhseQvg8xsUBcKTxropfvcEnNqcIQtk19ojoBSLiRNVeZAIRDSaia4noohDC+KINcnJNwF5TdmI8mS3FaShENGuX7jm/W48S0b+J6EEiejzWRNYKALfIzrMTfMa2QgiB03ccp6uUfed2doET2wRxhw6Vf7K6yLtENJKIPpCPyTgZwN8QO2douKf895/5Tq0Wk9qFRLRFl5v+QnZl9xHR/TKZ8W6tW0EwmoK/l/rE5hRFaXdukpt2V5eaG0NEfO7wlOy0+GeoR3c5Ce8o50s+nDFHzAJ7Me6UcfFICIEXUIXUmSOipHI1bNtSIYR3umSW45R/5yaH7nkltXIwx4uSSM1unMd5Z+Y7LCcFZ+Q8sXHwx70yof0rhDCCCgYAq5ho6rCd5xObUySl3LkBOJCILo50uSlymH6/TGgPhRBGR7q2UyAA5pQPLQdqrCRnXPzfOKz9Q3Ep30NEfwshvJVD+6NyyqVk23cmokEhhElUIgDwZLuZYlJeLITwcZfMcpzyA2BWACMz5u2wGsL5AHYqU70rJ1q9s225jJGh7NFEeR9mivkMAAxFPuxHJQTARkr7jy3aVscpHQB+neJjMBrAdQAOAMDlaJwKAmAXAM8jPYMBLFhQ7TUtg3gCpxLCuzaF/e9LbqrjOH0AWEiKKVo+BOu6Zt3UAFhdilDeCuBlmfy/APAWgKsAfLuX3joAK0dU8ngGwMwRbTsT8eCySCzsXTr4rE3Zh8OpRlRtrOUJgG8AOATAMCkltifVBalRpYVrrLHSv/Pfeze3VEJ+QXn/bpUSQqUFwHRcA08p8WTht5HtXBXAJfJx48XZJwAeAXAqgIvyqD3YbQDcpbCfP+gzZJxAz5N3mMWY3wNwIYAFqERUcazlDYD1AQxpcW/2oqojq3NLUdDLi7a5DHAFZC4AKR9UK4/HPoeKBbuXxb48+BTAjF1aqb6mtOn9sn4AAayt7MOBKc9QdwXwdMK9KXwhW9WxlifsouZFW4eKLuMqf5QE4A7DizKh8jdEAYC9I5T1OZVKBoDNAXyAHhew5gKkBnsOppIC4HaF/cN5p53iObObWMPIIoPDqjrW+gCwiOya35AJhyfjHSkDPMbEBZkEV3ypJgA2rMpL0sUX8U7E4bNu7GK0iE+ez57yJld3CJ8DG6IpX+FdHpUQPgNU9mFfYw24a1M8M9aZ7SpVHmt9ADiiQ02+/VLucP9k8MT9i6qKnE9o4dWTpupvJZH0hjRukU6U4tAbwCnoHjvm3Jd9ymJLFiQKOYlXNUFd4oL8UYb3t6sfwSqPNYbPR7myQ4K9LPhuLSptTZH5GVURADsYb8RPqIbI+c1ZyIcfFty3aQD8Gd1lyZx3bbwbQy/XOgOwbIezkkb2VkZC353xmQ3sUr8rO9b64B0kLxYU9qoT8QEcBuBz4/142urO7gnko9YqgqYd7A+enmoGgH4AHkR+FJY0LKt568T2ubi1fgBgKT6oB9BfzkX47CeJXGWsAOxh6Mva1NvRy0OTdm0SMPIxsnNyF/pc2bHWtPhiEQQNN1ICfBYK4KYU9+L1skXCFuW6YfanGqrOG3YBadmuwP5xqLcW3kX8pVMwkfj77yvqAFsWbC8q+8NlY0oJgG8qUzDanrXxQlSUYWLA5zdL59znSo+1PgBcbLjnXFg3yQ3JOWtWWIxhIaoixjBpyO+W8tA9LwCsKWHQebNYQf37jcHGEdoIR5ngWIKtHavn2CfeTWopPLy9HcpJaVi7MQlgUQBPIB7X5dzfSo+1PgD81GArl3JK8lBYRDf6uK/Ssoi8PTfekH2oRoiOH0dXWXgOwEGyAuX8kkMVf1OI0jzvwg39YnWSfsbrr9UmWmtozi5WfgYabqaSIi5ezUfroA4h/h8hHqz4sVSO/a30WOsDwAYGQQReHM7awa15BtJxYaU3KbJr05yN9PGyJhqrKgDYTHJNtHBO2A9baRIqRKgvKaB/3zYMslvSJL8CWKbDB3bjnPq1Y0V2bScr7H+3lRqJ6LvGVpQ5Mce+VnqsNamqsIKMBo4QXYban69pAlGa4YXmkVR1ZABY2I1qAhdpNW71b+YXt8P1kgbc5gUoj2iTYW9Ks6jhStEJO4cHcurbf7TPjEqK7EI0u66ft9i1no74DM4riKzqY60RQ8AHT0I7tLnG8ikrYXBVjj2o6oheIEfJaGH9Nq7PVXnEbTDe8MIcoQi/7sTQbirQS4CBVlLrgTQJrxziD+BDxQA2uTkV7W6FauzaOKE3iTF8rtmUL3U94sNjYYWc+lnpsdYIq98Y7vmv21xja5GtQ4rI5sKDaLqCJHFaSMyhqQIAVjKES3+sWQWyokOZcgZF3kcbSTV7ykhF7eQZ9QzHULXgLir3cYHGdXVm004va/5aO36cUz8rP9aaol7HKvt6R6uNBGuGpnQ188Smqdre+8jg4Vw1La9X+vBR4AgqOcPQwB+fZRXXnCthB/NeN6WADDubMWknHpHu0jAhpqvLKB9XGoWKZliSTGH/l32pGFwJXcpOaeBV/28NgSY35dTHyo+1Jlfxvcq+DmuOYJS/T6saxN6RH2SwnT0wR/ECpydym41CsswhVHEAzGvwY7+hDSVWJEYfmn/vphr87ygHxPYp25hT4Y7M5cNpEP1+hkqMUsT42ob39lllv68AMJ8h9WNEp7OtDP2r/FhrsuvHyr5yQM1KLY4Q/o70/G+Gb8XFTco4/y71JkdcRp1yj5p5v4wiozmcPz6svB9vc+6Q8rrbKaJPu/ayKPTr+vhdhjZOg57tIru4tJT2UF0iWDVsAmAeZUX0N/vcUrJjaifO28jkPCo21GWsNdg1n3hBNBzQYqHIZ95p+Wea80Ve2HbYVe9KZQXALsYb9CuqOAb1Bn5JVzTIByVFbW2Rf+/M7sghaQtdsoSPITjghZgH+wD+pmz3zTKvPpXh3S9KSLlmx3ZNY306lnFS3qdTcupf5cdaysLP1zf93YLKhQti1WcDML9ULS+9JmdLADxluEFjylq4sQDpMT7j2MywO+a8sE78I//eTSXO+poySXflDO1YJJ52idi/BSWSTkNpc3wAfEvZB64s/qQiiOCgFkndGp7IYwFQh7HWour1FOUO9atzNtlda+qvdeIPBjs5Gfwnih0m//85qYxIGKmF06jCSI0s7U7jKMN1z1CcZXRN9obDivOu0yV5czw5anisgGRniPpFaRdrAC5T9oM/hklHCeu1CCLT7AT4GS6fQ99qMdaaJt1nlf39bsPfLSc2d0IzYW6gtHMLg2h+rrUXMyEHgjCsngZQRZGcIK2w7g0Rg3WmdDNST7QFNeUvXswSDQXgAujZKPIZjjbq7o9UUuRsRrs46MSQVudUUgZFw7E59K0WYy2lrOF1TeLHoxTKLBoXfEtlk6ZdpTaCMzc3dUxBUgtXUoUxqDi8o135AdhG8YE6K//eTWWTJtKKPwIbZmhjgKF+1G2R+/d96FmOSoph99mJx1q9q3ImNVpZ0ysPd2QtxlqDbTMpdl998loLNCSzj1G4ixdXRjx/LcIdwMwAdjekjfSGBw/A1cYOdSyx0MuImO8k5X3Y2hCtlfSBfzxtsEYaWHVf6cL4c8Z2zlHey8mxlS4UZXX6uIdKipyJ8oo8C/d2ENjV7KonZjlvrftYa7LvWGV/j5Hf31ihq3mdTJqspwnl87xMctROlLpxVlHqyUmKMIUDYBFjZvsgqijiIuFIPQ1/UV7zu4pVJOfrzJd/D6ey6x7l6nGejO608UWUSwGwBPTsTCXFWJmhFQ+0E7XmiEPl5JK6ACmAbQGc0ByRWKex1lTJQSOPNUImq/UVyiVn90UWs7IOugMrwmxLZQfA740d+z5VFBaaVd4DVnDor/wwTVRMILlo80VQ6/hlxnYsJTei1m8DcJKyXQ6wmI5KiuFAvxWPttuxybXvVSoQpan4wJJftzdda/26jbWU4+FHXP1dMREe33T9NLqSVlhEYEkqO1Iwkh84DHlAlSxrI0mRmrOHRD09CZ/lFVUSvMrcsnu9NO3ahmdx3chZjtbVcXfk/gVDuPTpVFIkWi0tL3YKzQbwPeV1vpfCblbOuL/FtY6u21hrUl7RlO0ZydGsijO2n7W453lzXlHu3LzUxRv5BVUUw8H2kE4VEAy1lCYUocQtAyd3pQ6j3t134vXwqwN4LUvHbLsh4fVMSYr+VYbE9+adj5aRndQ7xCU4LC8B6Q7nrIfXaayl9JBdrdD2bJmPaax5Z4HdpFtRr2Bc3UIOaaOWICkLUgpDIzuETrqKCdI0jYyLEYYsrp+T5BzhXY1CgFKF4uUsJYzko6P1CLweu1ySIWH8kZjtNkh9Netn3mdVXBFRWk3ATzPjk1y87G5WXGeiRpDYKHW1Tp3GWtNix1K6J9VRgbihYzJZqnKXMzk74aDXwt+oohhWVYM6VJS+QXmNT2PkcolSQfN5zJTGc402f9ModtqOPbu4a0sl3pqwaNOEWkcX/RZ3W7u218kpytT07ERzUrPwODvloqbdhDNCXIi1GGtNf8+7+BicGqnihgbOe16DehERzrQwlapBVZCoJK3/f6qtOZd94bL0hnDmV2IoPEj9p7esA4BzexQ2vppx19bPcLDNUbrzpr4Rrdvn3YF2hdyviyoi6xnPwtMEB5wdqV7f2DTPhaWsOlzz5DqNtYa/nyNSoMdFirZ48TAwYzv3F3k2SZEemGYF38dzVFEModbPNOwMWIfvVqPb6LYY8k5yMD3MWnBRzlk0dbp+mtE+yyr1lixtZaw8EDthfMsObX1qqZ7BzwB2HklKspa0H43SyW9T9H/XDtebIO9tLcZa0zWOQXZu0QbyiZTaCYbip5DE73O0YtSlxnCg28fBVFFEeUHDcbL65DMiC5PkZcusci8qAo8ntLVQio9PH5+lqa6dUvmf2SnTDWltg1az738itjlLwntxieFaQXbP1ryjxPIvnC+muNYnVr1FOUcbnSTUW5ex1pSAz0VQs/AE25LSg3KoeOhGSMzEF3Ie/KxUhPiFqFNFPfMuDFnBJ2mUNX/wZqMKwm4L5MtzsfzW4nK4JW2yqzKqLJO+ohw+a/kwdvVeWWlPUbpDo7kkAZzboa3JlsCMFGfhqtxT0RHViDWckEIE+L6EybJ/ncZaw3UOytin4bHd9pWGD5xj+3p7FQ5mQD5MFFmbaMnBAC5NaHN0nxZdm1Wc5qzCFPTQ1MbSRqWbiwp8t++N2Oa6CS7+y43Xu9NwD9XXT5iAGycikztPUh0SA4bqMtaarqMVhG7nyi4s4bwnMejt9bEaVRQADyE+t8UuC8LVr7NEySlVyIdntPEm432KrsgO4OJu1m2TxNlOElLjk1xXLSTDLGdLKjFhKV46LrYIruRMdlrQvNq3O6/LWFOewSYxuei8vJ5DQlotg2cwVRQZ8NrIKw0PaUODc6i3dnHCNfgjkERi5FeH629kvFcf5qQwr5WqWrFLckpHG6+niWY1J7+LQG4SfB6zoMHW/h2iCKeKeKzTWIuQgM/8PHbfKo+hMGVLiZcqIUmgMXgwtsJGg43HK9p/tJMChuwuNKv2jVPaOI3ozVlQB1gYw+c1EcAjI7W3ZcJC8QWLq0wCGDgwJHrZKQmLT+IK4zMfqM2LrctYa0pbSJOAz1yVR/8qjbyQSSutZl92akX4siMRWWmZIDlNq+Ro328UdgxLekZKKarxGSSiDk5x/8x6hQo7NlW2fXWEtuZLiIKblCJp+0DD/eOzsfkj76rVZax4l59wrVGNYsd1GWsREvAHp4mMrD3sIjDe6JuqfNMkFNbKk6Jm3j9Hu4JSCPZ9jS4igP/LK8BCohO1Sbl9TM5DzsdQTfrICM9nYGwxZkMKgyq/ylivTX38AGA3xfV+UMexJtecybgD74P/ZvG8+lppUhQkbavrVgUAvGRYTXEi5hJdsGk6ZXXsj7UrWaXv3yy1lPKdYp5I01akjziyVBVXRv0Nse6CjULPT2vzkiSknT/MUSZ8iQxN0oW8pq5jTa6rLRjazO759riicGKuMbn2/TwO/MuEUqlhbBftmctQQFTt8lLqLB6Ywl4uDJmGM8w3R2dPqxIrrUitXCE1tjpFB36eJlglQbaqmU1yqACxiOJayyjyY99tlT9Yl7Em134Mdq7Lr7cVRxkK3sjvqMLI4T3KMuA4yVepSmGd2Di/TcOmRnv7SRh6aVaokvCaxKgM159HcWZ9RMrraj7+5qMCyf9K4iVlAjjXcuzElOZq23Uaa3LtlWHnvTxdr5XHsKrtY2WqMCITpWFK3sVZWV1CKaw62nLo37DT0GA6rE9Qb0iKEsslMVVZRuWxlNeeVpEfensa2SdDcvNEawVkUXZP4u+K9CHNwuHMOo81o2u8Nsc/uQJggFEk+QWqOLJ607JSTjbMYpCreifNpABgF+X11QfZnB7S4TpXJUxuE3PKb2M3k4Y7Ul4/6TmNSLP6loCG15S2/zFFdLSmEvqFHa6xmrJm2sPtnmuNxtpMiurZpoWFk4BEHFk4tuo31eg+ODWH9jc2iOPy730zZTuHx5zcJOK2XTIuf0hXTWjn3TT9UNi1uLKf16S4dpKq+6S0QSqs0qK0e5xG7inlpNKyYCuAA5T5ke91Sv6u0VjbGzbGcEpJ7P7WCoMSdx+VD0c1fAwhAzyKK40/Agk1v5p5OotwqjIxFRq1B3FxdnLpsML4CgntPJ+2Lwm2JbWb6uBeuThIrSZhCJFPk1qwA/QcL2kdvMP5jiRLa+AAmnUT7KjLWHsANg6J0c/aImK2Fh6lGiByQBbeBrBwhvbmlcRXzUq4j+v5Y9Ol2ma/VISqd3K5PCt1pDbI48xL0c81slR3bnPNX+aZEC5BOZpAEl5QzJ3jrj0LeyvsqPxYkwncokjyn8qUmSkKZQJvI4dRDZDzCEsxv770iD2N5ynrSg0tSxrGFHluoUsisMwbrQa39OGQhI8wn+euqSzXkhiZl7KffDakYUJSKoDIlV2ct5qEoSBpKlcdgFOQLyrdzDqMNQAnGdrk8bJ6lvac/9705w03fVKdfMAG10urJN2TZZeymLhyppOV+OpcBFM+jrwCtfJpzOgp46AbJHlRM8jqdzdlzs5phgCWMTEm7TZafsjq4pPnx3XBkhiV1X2v1OMcl1YCjwuEIj/OMdpS2bEmE6smmtQkvOwkJ11auKtON1Sh6N5tHreGeiv6eETONg9uLDgKYOciIuIkV8zC+QCWk13aPJKQfr3StTQ2TZh4k70rKu08O0Mb3Mc8uCCFLZUda8aKGJ9pNUHrQlrf7M7G388sKNtjmCPncmIyEZ1CROuHEF6LfO1c3IDCBCLaM4QwseG/faz4u51iGxJC4OTs0YY/OZSIXiSiL4joAyK6VcZL0q5yEhF9P4SQVUJsL8XvfElEWcQUPqX4nCf3zkqVx5rafUpEZ4YQ3ovUbn2R1YmWL9McWtcwkjQ27M7YIMf+zZuh9EYSP2zR3irKWm6z5tBXTcJyFiZrAiiUbqwktQ9zBe8W7ewbuf8nZLSncmNNXKQfGfLnXPE/UkkOy0dtINUQANugGCZKRFfuL3tKrbskLmrT1qzKopSX5tDPpHy0LPDib49Idq7dDZUgqeodAw733ydCvys31rhatsGO/WK3X0v4ZTS+AD+imsJFGtFdWAptuS72TxuVp2VgJ5URwwr9pJhqJXyGktMulSNFo7lSOaBF0ebdkdp6ImPf37LqK9ZprAH4q9IODlLy0P8YGJMXJ2dJXux1JAIrj91NK7dI18taiHDtB5H6wPdp9kjpB5Bo3pjRoRZ1fShdqJvFss8QwbxtpLayVMC+IfZRRZXGmuR1flxUcd7aYkwBeIBqjmgTWhUGYMghO6QxqrCA/u0foR+PacrFSJSudQf1dCtF+RT9XDhF8dROiemppJg62De/suJzKHDC54lhu1jtV3WsAdhcadMzeaS/1BbjAFdX9a0yEhZ+qvLMSJs3tmdZ6uJJqHtabrScWbBAcZ6JwQltb2koIdPOk3F+Tmc0GkmsoyK3OSOAKxXtviYTw4wx26/qWANwltI2V/2PiUFpnFfYA6I23uOITuE1chBthSsO/yavsi4R3JN3pwgmOMq68hTZN4tSROP7aC722aL976ZQxYB4PDpqJWa067CE9sfnFbUMYGtZpLwuz5Vd1U9xLp3sQrp+JtTLY00SzJN4sgjbKo3h4LalIrjzVWIwF3m9XD4CH8qOYJKoG7D76F4A54pSQmI146KRFfNpyo/JTexiLCCB/KSIH85HDW7RXfP+wHP6RIIdf6Ea0mtjTVyrGtd7bu7d2sLnF8pBHdUF4vQGImV0iuRCjpGPyEdSl4tXw0tHyufioAQrl8Xp5VRuSo5qe0W0JcfLuRJH0h3HupQx21OE53f6KK7aLVuc9ADYRPEe10KEvhAUh7YTrTWiHCeFK9SqK/j7Kt9l2Z204oqibXNMFb07MUVTRsrJJibbqRKvC3g6uSPh3zcbJrdoeVVlRCo2XyqBK31cn4dqi5MPUoGgE2f5vc8ZyaBvVdeIfdhz5d2+4zS4KA+Ws5ROq91j6nLHRBqN1e4XLdoWJ9XZNQe0tOLqskRIVx5RIL9OynRwBNm1ncrCO06O7yLLcx0E4HbR2mPX+CdckYIj9vzOO72CFCjl7+pICX7hoCSX2HIcx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3Ecx3GoLvw/grWeZMUktrIAAAAASUVORK5CYII="

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
local Feather = {Theme = Theme, ToggleKey = Enum.KeyCode.RightShift, Flags = {}, _windows = {}, _notifs = nil, OnUnload = false, Unload = function(_self) end}

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
local GLOW_B64 = "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"
local BLOB_B64 = "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAFmklEQVR42u1b2ZLjNgwEKXqOrc3/f+qMLZHIi1SF9AIgKFOzSWZdpRJ9SFY3ToJgYmb6zq9M3/xVvvj/UvB3/H8hIHXAJwNwgs/4v0RAMs4aCRYBDN9JQvjfSoAEnJzPPFNAqUvwl2hFuQC49t7TCo0ABhKQjGlElAngo4emCRYJFgHa8RQJZaLU0x5WtbGlCZ4G4NFgPCV6lIlSz51zjwQLfAP1b/u4zdCGMgF8BrDae/lbyxQkCJR226+V4JP47rQmlCfAW8AzES0GCbnjB1DqDcZVXN/Ec2lE8EwCLPAaaBxnRRM8DUDJy0OCrUAEnSGhTAC/iLM11rRAS4Q06VcFcHWc6RAJoxrgAbcOiwSNAA38sp+P66UZWES0WRoQkf6y30cba2TkjglI8BXA544J4Tj1iCiD4JMi9SLORXmvEZANAM0gYNuPHEimGCKGawojGqBJH8HegAiPhAQSYgf8cc0WiCBsTKiGNCAqfQR/AyJuDgkWAQi+ZzpW+pwjplCCji8Ztr8AeDw0rYgQsCngczB8Zhg3ZSbpEpAG4j6q+gH8Bc6SiEXxA6j+GxGtgoSHYs9a3pCBAFacJkdNQPMBlndH8PJAIkqHgEP6ZQeuSd5KlpAQnHtwVAOok/JqPkAj4RXIOH6zGARUkHyGwq2XJco5QwJNsIoqvxCQOmaQjBxAqrgE/ypIeAXfIMFJ6a/7oYVLDbzMFOUzNgXDLySUAfX3ssCiOENJwhtog/QFBLb/ANUnJzWWmeKiJE1dMygn5vy5Ew4LqP2bOCQJGgEPQY4FvkCIXBTw1vN3fYBVyR0hwdKAdyDhBgSsYB5WdNgU8JEZp6oFpVPOtub/yZkToFN8ARLeBQmSgAcR3Q2zWI3MMjvPZVWh/uEHyoka/2hyJJ3iOxH92M8v4v8P218E+E2Av+1nT+p5sAId8gGRAmgOJEoWCbf93isRfezjKiLBQ0mecgd8ZF3idD2g5x+8KbPUhnci+rmbBRHRp9CEF5ErLIGqUuoszgzVA6IXpgARlnYc5vFGRH+Je9whP8gBr372ufnP8rihARysprKxjhcpbB6O7VNc/ylS4NbJ8dn5/9HnDvsAa+EhAroKx3ZkeR9C7aUTPL5fxXURMqzFldNlcQ4sVLbOxEQmLo/d7u8i1G1KGPzYf3MQcVxfnf/hwCoRny2JWTdqgRoehjKZ4VUnEUISVmEe1dAMJIGiS2VFaUrgzkIFO+A3OFaR4GhpL352kPApSFiV+1oksGMqKinF6Mzg4IpNNSRvVX6kE7QmQ0jCvaMJteMjyNOIEqiwjoBfhD1rVZ8Kaa83HT5IeCg+YZSEIR+AnRiWZ1+M6q1X85Ma0iuI3AURUgNWwxR6ESNUFdbAs7Nml6Fun40CZgPbj5TEHqANUgtWxx9wJ1zyqAY0KDM1KD5sndI1FjPWYFF0FZLXIsLmRAbNGQ6tC1hmUI08f+tUbquI+6NlcSTCc4aSiFDnSAn26TRoTEAykkGAlPx2YmEEiVidsNgGs8ZuIsRKT04ywFOndI01vJGlMSRheyI5GkqFcd1ea05IHeIs8KOLo5uhFZuj/u1sGLSIaAC8OtdoIXPG8nhVVH8LhsDh/gBWHi45PXqWJGc0SCAZ2nhY+mcmQ83p9/UyxmdaZDwyolPmp3uEuNOA1ANfJzVJWWOLgCltctzpwkIAGZar68Q2uWqMT0n/jAZoJGBzQhbjKxolrYLIMPjRTlGNBIZlLGxMmNkqywPA+apeYTYaE7E1Rfb2zmqWts6nwZ/tFscuLFlrz0pDQqNr2uWn7Bs4u1/A+qOmNCNcvWGCf8eGiZ42XLVlhmjibpFZe4ZYmUYnaFR8ZtOUVd6esmkqXbB1dta2OU8r5j3sxXuHz26cpK/aOJm+ePP0t9s6+9uA0Z/d47HX3ya4ucJF+l37AAAAAElFTkSuQmCC"
local LOGO_URL = "https://raw.githubusercontent.com/aIbums/opensrc/main/Minimalist%20White%20Feather%20Logo.png"
local QUILL_TIP = Vector2.new(0.8935, 0.0225)
local LOGO_ASPECT = 1774 / 887
local WM_W, WM_H = 439, 156
local GLOW_PAD = 40
local WRITE_TRACE = {0.859, 0.835, 0.808, 0.762, 0.703, 0.633, 0.572, 0.515, 0.462, 0.413, 0.364, 0.304, 0.247, 0.201, 0.16, 0.128, 0.118, 0.11, 0.103, 0.097, 0.092, 0.088, 0.085, 0.082, 0.079, 0.078, 0.081, 0.203, 0.324, 0.453, 0.569, 0.672, 0.647, 0.618, 0.577, 0.545, 0.521, 0.505, 0.495, 0.492, 0.505, 0.532, 0.572, 0.568, 0.56, 0.539, 0.504, 0.449, 0.428, 0.401, 0.368, 0.333, 0.306, 0.313, 0.327, 0.377, 0.419, 0.449, 0.445, 0.429, 0.374, 0.321, 0.269, 0.223, 0.188, 0.269, 0.35, 0.435, 0.518, 0.596, 0.567, 0.544, 0.527, 0.515, 0.513, 0.546, 0.582, 0.631, 0.665, 0.687, 0.667, 0.638, 0.594, 0.563, 0.553, 0.547, 0.546, 0.545, 0.541, 0.528, 0.537, 0.551, 0.569, 0.59, 0.607, 0.609}

local assetCache = {}

local function b64Asset(name, data)
	if assetCache[name] ~= nil then return assetCache[name] or nil end
	assetCache[name] = false
	if not hasAssets or data == "" then return nil end
	ensureFolder()
	local path = "Feather/" .. name
	if not (isfile and isfile(path)) then pcall(writefile, path, B64.decode(data)) end
	local ok, id = pcall(loadAsset, path)
	if ok and id then assetCache[name] = id return id end
	return nil
end

local function urlAsset(name, url)
	if assetCache[name] ~= nil then return assetCache[name] or nil end
	assetCache[name] = false
	if not hasAssets then return nil end
	ensureFolder()
	local path = "Feather/" .. name
	if not (isfile and isfile(path)) then
		local ok, body = pcall(function() return game:HttpGet(url) end)
		if not ok or type(body) ~= "string" or #body < 200 then return nil end
		pcall(writefile, path, body)
	end
	local ok, id = pcall(loadAsset, path)
	if ok and id then assetCache[name] = id return id end
	return nil
end

local function getLogo() return urlAsset("logo.png", LOGO_URL) end

local function traceAt(p)
	local n = #WRITE_TRACE
	if n == 0 then return 0.5 end
	local f = math.clamp(p, 0, 1) * (n - 1) + 1
	local i = math.floor(f)
	local j = math.min(i + 1, n)
	local t = f - i
	return WRITE_TRACE[i] + (WRITE_TRACE[j] - WRITE_TRACE[i]) * t
end

local function inside(gui, pos)
	if not (gui and gui.Parent and gui.Visible) then return false end
	local p, s = gui.AbsolutePosition, gui.AbsoluteSize
	return pos.X >= p.X and pos.X <= p.X + s.X and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
end

local function makeDraggable(handle, target, onStart)
	local dragging, startMouse, startPos, goal, step
	handle.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
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
				local a = 1 - math.exp(-math.min(dt, 0.1) * 20)
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

local W, H, HEAD = 440, 500, 54

function Feather:CreateWindow(opts)
	opts = opts or {}
	if opts.Accent then Theme.Accent = opts.Accent end
	local gui = new("ScreenGui", {Name = HttpService:GenerateGUID(false), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
	hudParent(gui)
	local conns = {}
	local function track(c) table.insert(conns, c) return c end

	local root = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.fromOffset(W, H), BackgroundTransparency = 1, Visible = false, Parent = gui})
	local rootScale = new("UIScale", {Scale = 0.96, Parent = root})
	local panel = new("CanvasGroup", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.bg, GroupTransparency = 1, Parent = root}, {corner(16), stroke(Theme.line, 0)})

	-- popups live above everything so cards and scrolling never cut them off
	local overlay = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 200, Parent = gui})
	local openPopup
	local function closePopup()
		if not openPopup then return end
		local p = openPopup
		openPopup = nil
		p.frame.Visible = false
		if p.onClose then p.onClose() end
	end
	local function showPopup(frame, anchor, width, onClose)
		if openPopup and openPopup.frame == frame then closePopup() return end
		closePopup()
		frame.Parent = overlay
		local ap, as = anchor.AbsolutePosition, anchor.AbsoluteSize
		frame.Position = UDim2.fromOffset(ap.X + as.X - width, ap.Y + as.Y + 6)
		frame.Visible = true
		openPopup = {frame = frame, anchor = anchor, onClose = onClose}
		local sc = frame:FindFirstChild("PopScale") or new("UIScale", {Name = "PopScale", Parent = frame})
		sc.Scale = 0.94
		go(sc, 0.2, {Scale = 1}, Enum.EasingStyle.Back)
	end
	track(UserInputService.InputBegan:Connect(function(input)
		if not openPopup then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local pos = UserInputService:GetMouseLocation()
		if not (inside(openPopup.frame, pos) or inside(openPopup.anchor, pos)) then closePopup() end
	end))

	-- header
	local header = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, HEAD), Parent = panel})
	local brand = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 0), Size = UDim2.new(0, 200, 1, 0), Parent = header}, {new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})})
	local headLogo = new("ImageLabel", {BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(34, 17), LayoutOrder = 1, Visible = false, Parent = brand})
	local headWord = new("ImageLabel", {BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, ImageColor3 = Theme.text, Size = UDim2.fromOffset(86, 31), LayoutOrder = 2, Visible = false, Parent = brand})
	local headText = label({Text = opts.Name or "Feather", Font = BOLD, TextSize = 17, Size = UDim2.fromOffset(120, 30), LayoutOrder = 2, Parent = brand})
	task.spawn(function()
		local wm = getWordmark()
		if wm and headWord.Parent then headWord.Image = wm headWord.Visible = true headText.Visible = false end
		local logo = getLogo()
		if logo and headLogo.Parent then headLogo.Image = logo headLogo.Visible = true end
	end)
	local titleLabel = label({Text = opts.Title or "", TextSize = 12, TextColor3 = Theme.sub, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -90, 0.5, 0), Size = UDim2.fromOffset(150, 16), TextTruncate = Enum.TextTruncate.AtEnd, Parent = header})
	local headLine = new("Frame", {BackgroundColor3 = Theme.line, Size = UDim2.new(1, -32, 0, 1), Position = UDim2.new(0, 16, 1, -1), BorderSizePixel = 0, Parent = header})

	local function headerButton(x, icon)
		local b = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, x, 0.5, 0), Size = UDim2.fromOffset(30, 30), Parent = header}, {corner(9), stroke(Theme.line, 0)})
		local img = makeIcon(b, icon, 15, Theme.sub)
		img.AnchorPoint = Vector2.new(0.5, 0.5)
		img.Position = UDim2.fromScale(0.5, 0.5)
		b.MouseEnter:Connect(function() go(b, 0.15, {BackgroundColor3 = Theme.hover}) go(img, 0.15, {ImageColor3 = Theme.text}) end)
		b.MouseLeave:Connect(function() go(b, 0.2, {BackgroundColor3 = Theme.raised}) go(img, 0.2, {ImageColor3 = Theme.sub}) end)
		return b
	end
	local closeBtn = headerButton(-14, "x")
	local minBtn = headerButton(-50, "minus")

	local body = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, HEAD), Size = UDim2.new(1, 0, 1, -HEAD - 64), Parent = panel})

	local tabbar = new("Frame", {BackgroundColor3 = Theme.panel, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), Size = UDim2.new(1, -24, 0, 46), Parent = panel}, {corner(15), stroke(Theme.line, 0)})
	local tabRow = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = tabbar}, {new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder})})

	local Window = {tabs = {}, _active = nil}

	local function selectTab(tab)
		if Window._active == tab then return end
		closePopup()
		for _, t in ipairs(Window.tabs) do
			local on = t == tab
			if on then
				t.host.Visible = true
				t.host.Position = UDim2.fromOffset(0, 10)
				go(t.host, 0.3, {Position = UDim2.fromOffset(0, 0)})
			else
				t.host.Visible = false
			end
			go(t.pill, 0.22, {BackgroundTransparency = on and 0 or 1})
			go(t._icon, 0.22, {ImageColor3 = on and Theme.onAccent or Theme.sub})
		end
		Window._active = tab
	end

	function Window:Tab(tabOpts)
		tabOpts = tabOpts or {}
		local host = new("Frame", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = body})
		local pillRow = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, -32, 0, 30), Position = UDim2.fromOffset(16, 10), Visible = false, Parent = host}, {new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder})})
		local pageHost = new("Frame", {BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 10), Size = UDim2.new(1, 0, 1, -10), Parent = host})

		local pill = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.Accent, BackgroundTransparency = 1, Size = UDim2.fromOffset(46, 34), LayoutOrder = #Window.tabs + 1, Parent = tabRow}, {corner(11)})
		local iconImg = makeIcon(pill, tabOpts.Icon or "circle", 18, Theme.sub)
		iconImg.AnchorPoint = Vector2.new(0.5, 0.5)
		iconImg.Position = UDim2.fromScale(0.5, 0.5)
		local tab ={host = host, pill = pill, _icon = iconImg, pages = {}, _activePage = nil}
		pill.MouseLeave:Connect(function() if Window._active ~= tab then go(iconImg, 0.2, {ImageColor3 = Theme.sub}) end end)
		pill.MouseEnter:Connect(function() if Window._active ~= tab then go(iconImg, 0.15, {ImageColor3 = Theme.text}) end end)
		table.insert(Feather._accentHooks, function(c) pill.BackgroundColor3 = c end)

		local function selectPage(page)
			if tab._activePage == page then return end
			closePopup()
			for _, p in ipairs(tab.pages) do
				local on = p == page
				p.scroller.Visible = on
				go(p._pill, 0.2, {BackgroundColor3 = on and Theme.hover or Theme.raised})
				go(p._label, 0.2, {TextColor3 = on and Theme.text or Theme.sub})
				if p._icon then go(p._icon, 0.2, {ImageColor3 = on and Theme.text or Theme.sub}) end
			end
			tab._activePage = page
		end

		function tab:Page(pageOpts)
			pageOpts = pageOpts or {}
			local scroller = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.dim, ScrollBarImageTransparency = 0.2, ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false, Parent = pageHost}, {new("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}), new("UIPadding", {PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 14)})})
			track(scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(closePopup))

			local pillBtn = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, Size = UDim2.fromOffset(0, 28), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = #tab.pages + 1, Parent = pillRow}, {corner(9), new("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 11)}), new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder})})
			local pageIcon
			if pageOpts.Icon then
				pageIcon = makeIcon(pillBtn, pageOpts.Icon, 14, Theme.sub)
				pageIcon.LayoutOrder = 1
			end
			local pl = label({Text = pageOpts.Name or "Page", Font = BOLD, TextSize = 12, TextColor3 = Theme.sub, Size = UDim2.fromOffset(0, 28), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = 2, Parent = pillBtn})

			local page = {scroller = scroller, _pill = pillBtn, _label = pl, _icon = pageIcon}
			table.insert(tab.pages, page)
			pillBtn.MouseButton1Click:Connect(function() selectPage(page) end)
			if #tab.pages > 1 then
				pillRow.Visible = true
				pageHost.Position = UDim2.fromOffset(0, 48)
				pageHost.Size = UDim2.new(1, 0, 1, -48)
			end

			local function addGroup(name)
				local card = new("Frame", {BackgroundColor3 = Theme.panel, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = #scroller:GetChildren(), Parent = scroller}, {corner(12), stroke(Theme.line, 0)})
				local inner = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = card}, {new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}), new("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14)})})
				if name and name ~= "" then
					label({Text = name, Font = BOLD, TextSize = 12, TextColor3 = Theme.sub, Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 0, Parent = inner})
				end

				local Group = {}
				local order = 1
				local function baseRow(o, height)
					o = o or {}
					local row = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, height or 40), LayoutOrder = order, Parent = inner})
					order += 1
					local leftX = 0
					if o.Icon then
						local ic = makeIcon(row, o.Icon, 16, Theme.sub)
						ic.AnchorPoint = Vector2.new(0, 0.5)
						ic.Position = UDim2.new(0, 0, 0, 20)
						leftX = 26
					end
					local hasDesc = o.Description and o.Description ~= ""
					label({Text = o.Name or "", Font = BOLD, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(leftX, hasDesc and 5 or 0), Size = UDim2.new(1, -(leftX + 140), 0, hasDesc and 16 or 40), Parent = row})
					if hasDesc then
						label({Text = o.Description, TextSize = 11, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(leftX, 22), Size = UDim2.new(1, -(leftX + 140), 0, 13), Parent = row})
					end
					return row
				end

				function Group:Toggle(o)
					local row = baseRow(o)
					local state = o.Default and true or false
					local track_ = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.line, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0, 20), Size = UDim2.fromOffset(40, 22), Parent = row}, {corner(11)})
					local knob = new("Frame", {BackgroundColor3 = Theme.sub, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(3, 11), Size = UDim2.fromOffset(16, 16), Parent = track_}, {corner(8)})
					local control = {}
					local function apply(v, fire, instant)
						state = v and true or false
						local t = instant and 0 or 0.22
						go(track_, t, {BackgroundColor3 = state and Theme.Accent or Theme.line})
						go(knob, t, {Position = UDim2.fromOffset(state and 21 or 3, 11), BackgroundColor3 = state and Theme.bg or Theme.sub}, Enum.EasingStyle.Back)
						if fire and o.Callback then task.spawn(o.Callback, state) end
					end
					track_.MouseButton1Click:Connect(function() apply(not state, true) end)
					function control:Set(v) apply(v, true) end
					function control:Get() return state end
					apply(state, false, true)
					table.insert(Feather._accentHooks, function() apply(state, false, true) end)
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return state end, set = function(v) apply(v, true) end} end
					if state and o.Callback then task.defer(o.Callback, true) end
					return control
				end

				function Group:Slider(o)
					local row = baseRow({Name = o.Name, Icon = o.Icon}, 50)
					local dec = o.Decimals or 0
					local minV, maxV = o.Min or 0, o.Max or 100
					local value = o.Default or minV
					local valLabel = label({Text = "", Font = BOLD, TextSize = 12, TextColor3 = Theme.sub, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(100, 30), Parent = row})
					local bar = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.line, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, -8), Size = UDim2.new(1, 0, 0, 6), Parent = row}, {corner(3)})
					local fill = new("Frame", {BackgroundColor3 = Theme.Accent, Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, Parent = bar}, {corner(3)})
					local dot = new("Frame", {BackgroundColor3 = Theme.Accent, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(12, 12), Parent = bar}, {corner(6)})
					table.insert(Feather._accentHooks, function(c) fill.BackgroundColor3 = c dot.BackgroundColor3 = c end)
					local control, dragging = {}, false
					local function apply(v, fire)
						value = math.clamp(round(v, dec), minV, maxV)
						local frac = (value - minV) / math.max(maxV - minV, 1e-6)
						fill.Size = UDim2.fromScale(frac, 1)
						dot.Position = UDim2.fromScale(frac, 0.5)
						valLabel.Text = tostring(value) .. (o.Suffix or "")
						if fire and o.Callback then task.spawn(o.Callback, value) end
					end
					local function fromMouse()
						local m = UserInputService:GetMouseLocation()
						local frac = math.clamp((m.X - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
						apply(minV + frac * (maxV - minV), true)
					end
					bar.InputBegan:Connect(function(i)
						if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
							dragging = true
							go(dot, 0.15, {Size = UDim2.fromOffset(15, 15)})
							fromMouse()
						end
					end)
					track(UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then fromMouse() end end))
					track(UserInputService.InputEnded:Connect(function(i)
						if dragging and (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then
							dragging = false
							go(dot, 0.2, {Size = UDim2.fromOffset(12, 12)})
						end
					end))
					function control:Set(v) apply(v, true) end
					function control:Get() return value end
					apply(value, false)
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return value end, set = function(v) apply(v, true) end} end
					return control
				end

				function Group:Button(o)
					local row = baseRow(o)
					local btn = new("TextButton", {Text = o.ButtonText or "Run", Font = BOLD, TextSize = 12, TextColor3 = Theme.onAccent, AutoButtonColor = false, BackgroundColor3 = Theme.Accent, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0, 20), Size = UDim2.fromOffset(80, 28), Parent = row}, {corner(8)})
					local sc = new("UIScale", {Parent = btn})
					table.insert(Feather._accentHooks, function(c) btn.BackgroundColor3 = c end)
					btn.MouseEnter:Connect(function() go(btn, 0.15, {BackgroundTransparency = 0.15}) end)
					btn.MouseLeave:Connect(function() go(btn, 0.2, {BackgroundTransparency = 0}) go(sc, 0.2, {Scale = 1}) end)
					btn.MouseButton1Down:Connect(function() go(sc, 0.1, {Scale = 0.94}) end)
					btn.MouseButton1Up:Connect(function() go(sc, 0.25, {Scale = 1}, Enum.EasingStyle.Back) end)
					btn.MouseButton1Click:Connect(function() if o.Callback then task.spawn(o.Callback) end end)
					return {}
				end

				function Group:HoldButton(o)
					local row = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 42), LayoutOrder = order, Parent = inner})
					order += 1
					local btn = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, Position = UDim2.fromOffset(0, 4), Size = UDim2.new(1, 0, 0, 34), ClipsDescendants = true, Parent = row}, {corner(9), stroke(Theme.bad, 0.4)})
					local fillHold = new("Frame", {BackgroundColor3 = Theme.bad, BackgroundTransparency = 0.25, Size = UDim2.fromScale(0, 1), BorderSizePixel = 0, Parent = btn}, {corner(9)})
					label({Text = o.Name or "Hold", Font = BOLD, TextSize = 12, TextColor3 = Theme.text, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = btn})
					local holding, fired = false, false
					btn.MouseButton1Down:Connect(function()
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
					local function release() holding = false if not fired then go(fillHold, 0.25, {Size = UDim2.fromScale(0, 1)}) end end
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
					local options = o.Options or {}
					local function displayText()
						local list = {}
						for _, opt in ipairs(options) do if selected[opt] then table.insert(list, opt) end end
						if #list == 0 then return o.Placeholder or "None" end
						return table.concat(list, ", ")
					end
					local box = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0, 20), Size = UDim2.fromOffset(150, 28), Parent = row}, {corner(8), stroke(Theme.line, 0)})
					local boxText = label({Text = displayText(), TextSize = 12, TextColor3 = Theme.text, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -32, 1, 0), Parent = box})
					local chev = makeIcon(box, "chevron-down", 14, Theme.sub)
					chev.AnchorPoint = Vector2.new(1, 0.5)
					chev.Position = UDim2.new(1, -9, 0.5, 0)

					local popup = new("Frame", {BackgroundColor3 = Theme.panel, Visible = false, Size = UDim2.fromOffset(170, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = overlay}, {corner(10), stroke(Theme.line, 0)})
					local list = new("ScrollingFrame", {BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.None, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.dim, Parent = popup}, {new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}), new("UIPadding", {PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5)})})
					local items = {}
					local control = {}
					local function fire()
						boxText.Text = displayText()
						if o.Callback then
							if multi then
								local l = {}
								for _, opt in ipairs(options) do if selected[opt] then table.insert(l, opt) end end
								task.spawn(o.Callback, l)
							else
								local one
								for _, opt in ipairs(options) do if selected[opt] then one = opt break end end
								task.spawn(o.Callback, one)
							end
						end
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
							local t = label({Text = opt, TextSize = 12, TextColor3 = Theme.sub, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(9, 0), Size = UDim2.new(1, -34, 1, 0), Parent = b})
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
						list.Size = UDim2.new(1, 0, 0, math.min(#options, 6) * 30 + 10)
						paint()
					end
					rebuild()
					box.MouseButton1Click:Connect(function()
						showPopup(popup, box, 170, function() go(chev, 0.2, {Rotation = 0}) end)
						if openPopup and openPopup.frame == popup then go(chev, 0.2, {Rotation = 180}) end
					end)
					function control:Set(v)
						selected = {}
						if type(v) == "table" then for _, x in ipairs(v) do selected[x] = true end elseif v ~= nil then selected[v] = true end
						paint()
						fire()
					end
					function control:Get()
						if multi then
							local l = {}
							for _, opt in ipairs(options) do if selected[opt] then table.insert(l, opt) end end
							return l
						end
						for _, opt in ipairs(options) do if selected[opt] then return opt end end
						return nil
					end
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
					local row = baseRow({Name = o.Name, Icon = o.Icon, Description = o.Description})
					local opts2 = o.Options or {}
					local width = math.min(220, #opts2 * 66)
					local holder = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0, 20), Size = UDim2.fromOffset(width, 28), Parent = row}, {corner(8), stroke(Theme.line, 0)})
					local slider = new("Frame", {BackgroundColor3 = Theme.Accent, Size = UDim2.new(1 / math.max(#opts2, 1), -4, 1, -4), Position = UDim2.fromOffset(2, 2), Parent = holder}, {corner(6)})
					table.insert(Feather._accentHooks, function(c) slider.BackgroundColor3 = c end)
					local value = o.Default or opts2[1]
					local buttons = {}
					local control = {}
					local function paint(instant)
						for idx, opt in ipairs(opts2) do
							local on = opt == value
							if on then
								local target = UDim2.new((idx - 1) / #opts2, 2, 0, 2)
								if instant then slider.Position = target else go(slider, 0.25, {Position = target}) end
							end
							go(buttons[opt], 0.2, {TextColor3 = on and Theme.onAccent or Theme.sub})
						end
					end
					for idx, opt in ipairs(opts2) do
						local b = new("TextButton", {Text = opt, Font = BOLD, TextSize = 11, TextColor3 = Theme.sub, AutoButtonColor = false, BackgroundTransparency = 1, Position = UDim2.new((idx - 1) / #opts2, 0, 0, 0), Size = UDim2.new(1 / #opts2, 0, 1, 0), ZIndex = 2, Parent = holder})
						buttons[opt] = b
						b.MouseButton1Click:Connect(function()
							value = opt
							paint()
							if o.Callback then task.spawn(o.Callback, value) end
						end)
					end
					paint(true)
					function control:Set(v) value = v paint() if o.Callback then task.spawn(o.Callback, v) end end
					function control:Get() return value end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return value end, set = function(v) control:Set(v) end} end
					return control
				end

				function Group:Input(o)
					local row = baseRow(o)
					local box = new("Frame", {BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0, 20), Size = UDim2.fromOffset(150, 28), Parent = row}, {corner(8)})
					local boxStroke = stroke(Theme.line, 0)
					boxStroke.Parent = box
					local tb = new("TextBox", {BackgroundTransparency = 1, Text = o.Default or "", PlaceholderText = o.Placeholder or "", Font = FONT, TextSize = 12, TextColor3 = Theme.text, PlaceholderColor3 = Theme.dim, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), Parent = box})
					tb.Focused:Connect(function() go(boxStroke, 0.15, {Color = Theme.sub}) end)
					tb.FocusLost:Connect(function()
						go(boxStroke, 0.2, {Color = Theme.line})
						if o.Callback then task.spawn(o.Callback, tb.Text) end
					end)
					local control = {}
					function control:Get() return tb.Text end
					function control:Set(v) tb.Text = tostring(v or "") end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return tb.Text end, set = function(v) tb.Text = tostring(v or "") end} end
					return control
				end

				function Group:Keybind(o)
					local row = baseRow(o)
					local key = o.Default
					local btn = new("TextButton", {Text = key and key.Name or "None", Font = BOLD, TextSize = 12, TextColor3 = Theme.text, AutoButtonColor = false, BackgroundColor3 = Theme.raised, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0, 20), Size = UDim2.fromOffset(92, 28), Parent = row}, {corner(8), stroke(Theme.line, 0)})
					local listening = false
					btn.MouseButton1Click:Connect(function()
						listening = true
						btn.Text = "press a key"
						btn.TextColor3 = Theme.sub
					end)
					track(UserInputService.InputBegan:Connect(function(input)
						if not listening or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
						listening = false
						if input.KeyCode == Enum.KeyCode.Escape then
							key = nil
						else
							key = input.KeyCode
						end
						btn.Text = key and key.Name or "None"
						btn.TextColor3 = Theme.text
						if o.ChangedCallback then task.spawn(o.ChangedCallback, key) end
					end))
					if o.Callback then
						track(UserInputService.InputBegan:Connect(function(input, gp)
							if gp or listening or not key then return end
							if input.KeyCode == key then task.spawn(o.Callback, key) end
						end))
					end
					local control = {}
					function control:Get() return key end
					function control:Set(k) key = k btn.Text = k and k.Name or "None" end
					if o.Flag then Feather.Flags[o.Flag] = {get = function() return key and key.Name end, set = function(v) local ok, kc = pcall(function() return Enum.KeyCode[v] end) if ok and kc then control:Set(kc) end end} end
					return control
				end

				function Group:Colorpicker(o)
					local row = baseRow(o)
					local color = o.Default or Theme.Accent
					local swatch = new("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = color, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0, 20), Size = UDim2.fromOffset(36, 22), Parent = row}, {corner(7), stroke(Theme.line, 0)})
					local popup = new("Frame", {BackgroundColor3 = Theme.panel, Visible = false, Size = UDim2.fromOffset(190, 158), Parent = overlay}, {corner(12), stroke(Theme.line, 0), pad(10)})
					local sv = new("ImageButton", {AutoButtonColor = false, BackgroundColor3 = Color3.fromHSV(0, 1, 1), Size = UDim2.new(1, 0, 0, 104), Parent = popup}, {corner(7)})
					new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), Parent = sv}, {corner(7), new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})})})
					new("Frame", {BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), Parent = sv}, {corner(7), new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})})})
					local svDot = new("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromOffset(10, 10), AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 3, Parent = sv}, {corner(5), stroke(Color3.new(0, 0, 0), 0.3)})
					local hue = new("ImageButton", {AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), Position = UDim2.new(0, 0, 0, 114), Size = UDim2.new(1, 0, 0, 14), Parent = popup}, {corner(5), new("UIGradient", {Color = ColorSequence.new({
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
					sv.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSV = true end end)
					hue.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingH = true end end)
					track(UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSV, draggingH = false, false end end))
					track(RunService.RenderStepped:Connect(function()
						if not (draggingSV or draggingH) then return end
						local m = UserInputService:GetMouseLocation()
						if draggingSV then
							s = math.clamp((m.X - sv.AbsolutePosition.X) / math.max(sv.AbsoluteSize.X, 1), 0, 1)
							v = 1 - math.clamp((m.Y - sv.AbsolutePosition.Y) / math.max(sv.AbsoluteSize.Y, 1), 0, 1)
						else
							h = math.clamp((m.X - hue.AbsolutePosition.X) / math.max(hue.AbsoluteSize.X, 1), 0, 1)
						end
						apply(true)
					end))
					swatch.MouseButton1Click:Connect(function() showPopup(popup, swatch, 190) end)
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
					local row = baseRow({Name = o.Name, Icon = o.Icon})
					local styleColor = ({accent = Theme.text, success = Theme.good, error = Theme.bad, warning = Theme.warn, mono = Theme.sub})[o.Style] or Theme.sub
					local val = label({Text = tostring(o.Value or ""), Font = o.Style == "mono" and Enum.Font.Code or BOLD, TextSize = 12, TextColor3 = styleColor, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0, 20), Size = UDim2.fromOffset(170, 16), Parent = row})
					local control = {}
					function control:Set(v)
						v = tostring(v)
						if val.Text == v then return end
						val.Text = v
						val.TextTransparency = 0.6
						go(val, 0.25, {TextTransparency = 0})
					end
					return control
				end

				function Group:Paragraph(o)
					local box = new("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = order, Parent = inner}, {new("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 6)})})
					order += 1
					local t = label({Text = o.Content or "", TextSize = 12, TextColor3 = Theme.sub, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = box})
					return {Set = function(_, v) t.Text = tostring(v) end}
				end

				function Group:Label(text)
					local t = label({Text = text or "", TextSize = 12, TextColor3 = Theme.text, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = order, Parent = inner})
					order += 1
					return {Set = function(_, v) t.Text = tostring(v) end}
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

	makeDraggable(header, root, closePopup)

	-- show / hide / minimize
	local visible = false
	local minimized = false
	local function openWindow()
		visible = true
		root.Visible = true
		rootScale.Scale = 0.94
		go(rootScale, 0.55, {Scale = 1}, Enum.EasingStyle.Back)
		go(panel, 0.4, {GroupTransparency = 0})
	end
	local function setVisible(v)
		if visible == v then return end
		visible = v
		closePopup()
		if v then
			root.Visible = true
			go(rootScale, 0.45, {Scale = 1}, Enum.EasingStyle.Back)
			go(panel, 0.3, {GroupTransparency = 0})
		else
			go(rootScale, 0.28, {Scale = 0.95})
			go(panel, 0.25, {GroupTransparency = 1})
			task.delay(0.26, function() if not visible then root.Visible = false end end)
		end
	end
	local function setMinimized(v)
		minimized = v
		closePopup()
		go(root, 0.4, {Size = UDim2.fromOffset(W, v and HEAD or H)})
		go(headLine, 0.25, {BackgroundTransparency = v and 1 or 0})
		if v then
			body.Visible = false
			tabbar.Visible = false
		else
			task.delay(0.15, function()
				if not minimized then
					body.Visible = true
					tabbar.Visible = true
				end
			end)
		end
	end

	closeBtn.MouseButton1Click:Connect(function() Feather:Unload() end)
	minBtn.MouseButton1Click:Connect(function() setMinimized(not minimized) end)
	track(UserInputService.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == Feather.ToggleKey then setVisible(not visible) end
	end))

	local unloaded = false
	function Feather:Unload()
		if unloaded then return end
		unloaded = true
		closePopup()
		go(rootScale, 0.3, {Scale = 0.92})
		go(panel, 0.28, {GroupTransparency = 1})
		task.delay(0.3, function()
			for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
			pcall(function() gui:Destroy() end)
			if Feather._notifs then pcall(function() Feather._notifs.Parent:Destroy() end) end
			Feather._notifs = nil
		end)
		if getgenv then getgenv().__FeatherUnload = nil end
		if Feather.OnUnload then pcall(Feather.OnUnload) end
	end
	if getgenv then getgenv().__FeatherUnload = function() pcall(function() gui:Destroy() end) end end

	-- intro: dark backdrop, the quill writes the cursive name with a glow, then the window opens
	task.spawn(function()
		local cover = new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(5, 5, 7), BackgroundTransparency = 1, ZIndex = 300, Parent = gui})
		go(cover, 0.45, {BackgroundTransparency = 0.05})

		local wmId = getWordmark()
		local glowId = b64Asset("glow.png", GLOW_B64)
		local blobId = b64Asset("blob.png", BLOB_B64)
		local logoId = getLogo()

		local IW = 340
		local IH = math.floor(IW * WM_H / WM_W + 0.5)
		local scale = IW / WM_W
		local group = new("CanvasGroup", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 6), Size = UDim2.fromOffset(IW + 300, IH + 240), BackgroundTransparency = 1, GroupTransparency = 1, ZIndex = 301, Parent = cover})
		local groupScale = new("UIScale", {Scale = 0.97, Parent = group})
		local stage = new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(IW, IH), BackgroundTransparency = 1, Parent = group})

		local function revealGradient(parent)
			return new("UIGradient", {
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.46, 0),
					NumberSequenceKeypoint.new(0.54, 1), NumberSequenceKeypoint.new(1, 1),
				}),
				Offset = Vector2.new(-0.6, 0),
				Parent = parent,
			})
		end

		local glowImg, glowGrad
		if glowId then
			local gw, gh = (WM_W + GLOW_PAD * 2) * scale, (WM_H + GLOW_PAD * 2) * scale
			glowImg = new("ImageLabel", {BackgroundTransparency = 1, Image = glowId, ImageColor3 = Color3.new(1, 1, 1), ImageTransparency = 0.45, ScaleType = Enum.ScaleType.Stretch, Position = UDim2.fromOffset(-GLOW_PAD * scale, -GLOW_PAD * scale), Size = UDim2.fromOffset(gw, gh), Parent = stage})
			glowGrad = revealGradient(glowImg)
		end
		local wordImg, wordGrad
		if wmId then
			wordImg = new("ImageLabel", {BackgroundTransparency = 1, Image = wmId, ImageColor3 = Color3.new(1, 1, 1), ScaleType = Enum.ScaleType.Stretch, Size = UDim2.fromOffset(IW, IH), Parent = stage})
		else
			wordImg = label({Text = opts.Name or "Feather", Font = Enum.Font.GothamBlack, TextSize = 46, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromOffset(IW, IH), Parent = stage})
		end
		wordGrad = revealGradient(wordImg)

		-- the quill pivots around its tip so it can tilt without the tip sliding off the ink
		local pivot = new("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(2, 2), Position = UDim2.fromOffset(0, IH * traceAt(0)), ZIndex = 5, Parent = stage})
		local tipGlow
		if blobId then
			tipGlow = new("ImageLabel", {BackgroundTransparency = 1, Image = blobId, ImageColor3 = Color3.new(1, 1, 1), ImageTransparency = 0.25, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(1, 1), Size = UDim2.fromOffset(30, 30), Parent = pivot})
		end
		local pen
		local PEN_W = 118
		if logoId then
			pen = new("ImageLabel", {BackgroundTransparency = 1, Image = logoId, ImageColor3 = Color3.new(1, 1, 1), ScaleType = Enum.ScaleType.Stretch, Rotation = 180, AnchorPoint = Vector2.new(1 - QUILL_TIP.X, 1 - QUILL_TIP.Y), Position = UDim2.fromOffset(1, 1), Size = UDim2.fromOffset(PEN_W, PEN_W / LOGO_ASPECT), Parent = pivot})
		else
			pen = makeIcon(pivot, "feather", 40, Color3.new(1, 1, 1))
			pen.AnchorPoint = Vector2.new(0.05, 0.95)
			pen.Position = UDim2.fromOffset(1, 1)
		end
		pen.ImageTransparency = 1

		task.wait(0.35)
		go(group, 0.45, {GroupTransparency = 0})
		go(groupScale, 0.6, {Scale = 1}, Enum.EasingStyle.Back)
		go(pen, 0.35, {ImageTransparency = 0})
		task.wait(0.3)

		local dur = 2.1
		local t0 = os.clock()
		while true do
			local t = math.clamp((os.clock() - t0) / dur, 0, 1)
			local p = t * 0.75 + (t * t * (3 - 2 * t)) * 0.25
			local ty = traceAt(p)
			local jitter = math.sin(os.clock() * 38) * 0.9
			pivot.Position = UDim2.fromOffset(p * IW, ty * IH + jitter)
			local slope = (traceAt(p + 0.02) - traceAt(p - 0.02)) / 0.04
			pivot.Rotation = math.clamp(slope * 9, -14, 14) + math.sin(os.clock() * 7) * 2
			wordGrad.Offset = Vector2.new(p - 0.5, 0)
			if glowGrad then
				local gx = (GLOW_PAD + p * WM_W) / (WM_W + GLOW_PAD * 2)
				glowGrad.Offset = Vector2.new(gx - 0.5, 0)
			end
			if tipGlow then
				tipGlow.ImageTransparency = 0.2 + math.abs(math.sin(os.clock() * 9)) * 0.25
			end
			if t >= 1 then break end
			RunService.RenderStepped:Wait()
		end
		wordGrad.Offset = Vector2.new(0.6, 0)
		if glowGrad then glowGrad.Offset = Vector2.new(0.6, 0) end

		-- lift the quill off the paper and let the glow breathe once
		go(pivot, 0.55, {Position = pivot.Position + UDim2.fromOffset(26, -34), Rotation = -18})
		go(pen, 0.5, {ImageTransparency = 1})
		if tipGlow then go(tipGlow, 0.4, {ImageTransparency = 1}) end
		if glowImg then
			go(glowImg, 0.35, {ImageTransparency = 0.12})
			task.delay(0.35, function() if glowImg.Parent then go(glowImg, 0.6, {ImageTransparency = 0.5}) end end)
		end
		task.wait(0.85)

		go(groupScale, 0.5, {Scale = 1.04})
		go(group, 0.45, {GroupTransparency = 1})
		go(cover, 0.55, {BackgroundTransparency = 1})
		task.wait(0.2)
		openWindow()
		task.wait(0.4)
		cover:Destroy()
	end)

	return Window
end

return Feather
