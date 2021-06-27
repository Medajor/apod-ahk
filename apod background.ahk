#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#include <JSON> 


;-----------------Please change these two per the readme!!!!---------------------

filepath := "C:\Users\hirsh\Pictures\apod.jpg"
EndPoint := "https://api.nasa.gov/planetary/apod?api_key=BmEpfiDDjJ0NF7B480RurPgntQrbBc3kGUdOHLnS"

;---------------------------------------------------------------------------------

IniRead, API_Key   ,Auth.ini,API, Key


HTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
HTTP.Open("GET",EndPoint)
HTTP.Send()
Response := HTTP.ResponseText
;MsgBox, 0, , %Response%
parsed := JSON.load(Response)
url := parsed.hdurl
UrlDownloadToFile, url, filepath
DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, filepath, UInt, 2)


SetTimer, check, 10800000	

check:
	HTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	HTTP.Open("GET",EndPoint)
	HTTP.Send()
	Response := HTTP.ResponseText
	;MsgBox, 0, , %Response%
	parsed := JSON.load(Response)
	url := parsed.hdurl
	UrlDownloadToFile, url, filepath
	DllCall("SystemParametersInfo", UInt, 0x14, UInt, 0, Str, filepath, UInt, 2)
return


