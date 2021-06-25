#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#include <JSON> 


IniRead, API_Key   ,Auth.ini,API, Key


EndPoint := "https://api.nasa.gov/planetary/apod?api_key=BmEpfiDDjJ0NF7B480RurPgntQrbBc3kGUdOHLnS"
HTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
HTTP.Open("GET",EndPoint)
HTTP.Send()
Response := HTTP.ResponseText
;MsgBox, 0, , %Response%
parsed := JSON.load(Response)
url := parsed.hdurl
UrlDownloadToFile, %url%, C:\Users\hirsh\Pictures\apod.jpg
DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, "C:\Users\hirsh\Pictures\apod.jpg", UInt, 2)


SetTimer, check, 10800000	

check:
	EndPoint := "https://api.nasa.gov/planetary/apod?api_key=BmEpfiDDjJ0NF7B480RurPgntQrbBc3kGUdOHLnS"
	HTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	HTTP.Open("GET",EndPoint)
	HTTP.Send()
	Response := HTTP.ResponseText
	;MsgBox, 0, , %Response%
	parsed := JSON.load(Response)
	url := parsed.hdurl
	UrlDownloadToFile, %url%, C:\Users\hirsh\Pictures\apod.jpg
	DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, "C:\Users\hirsh\Pictures\apod.jpg", UInt, 2)
return


