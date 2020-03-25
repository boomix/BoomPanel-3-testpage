#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "boomix"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <boompanel3>
#include <json>

#pragma newdecls required


public Plugin myinfo = 
{
	name = "Testpage",
	author = PLUGIN_AUTHOR,
	description = "Test page for plugin developers",
	version = PLUGIN_VERSION,
	url = "https://boompanel.com"
};

public void OnPluginStart()
{
	RegAdminCmd("sm_loadcmd", CMD_LoadCMD, ADMFLAG_BAN);
	RegAdminCmd("sm_testpagecmd", CMD_TestPageCMD, ADMFLAG_BAN);
}

public void BoomPanel3_OnPluginLoad() 
{
	BoomPanel3_RegisterPlugin("Test page", "testpage/index.html", "fa-check", true, ADMFLAG_BAN);
}

public void OnAllPluginsLoaded() 
{
	BoomPanel3_OnPluginLoad();
}

public Action CMD_LoadCMD(int client, int args)
{
	int webclient = BoomPanel3_GetSocketID(); 
	BoomPanel3_SendNotification(webclient, BP3_NOTIFICATION_SUCCESS, "Load success", "sm_loadcmd executed successfully");
}

public Action CMD_TestPageCMD(int client, int args)
{
	//Always get websocket client first
	int webclient = BoomPanel3_GetSocketID(); 

	JSON_Object data = new JSON_Object();
	data.SetString("stringname", "This is string name is coming from Sourcemod testpage.sp");

	BoomPanel3_ReturnDataObject(webclient, "dataname", data);

	return Plugin_Handled;
}