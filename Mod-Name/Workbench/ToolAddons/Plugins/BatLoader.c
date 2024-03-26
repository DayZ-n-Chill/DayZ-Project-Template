//  This is taken from the DayZTools.c in the Core Scripts.  
class DayZTool: WorkbenchPlugin
{
	void RunDayZBat(string filepath, bool wait = false)
	{
		if (filepath.Length() < 2) return;
		
		filepath.Replace("\\", "/");
		
		if (filepath[1] != ":")
		{
			string cwd;
			Workbench.GetCwd(cwd);
			filepath = cwd + "/" + filepath;
		}
		
		int index = filepath.IndexOf("/");
		int last_index = index;
		
		while(index != -1)
		{
			last_index = index;
			index = filepath.IndexOfFrom(last_index + 1, "/");
		}
		
		if (last_index == -1) return;
		
		string path = filepath.Substring(0, last_index);
		string bat = filepath.Substring(last_index + 1, filepath.Length() - last_index - 1);
		/*Print(filepath);
		Print(path);
		Print(bat);*/
		// Made it so that you can access other drives. 
		Workbench.RunCmd("cmd /c \"chdir /D " + path + " & call " + bat + "\"", wait);
	}
	
	override void Configure() 
	{
		Workbench.ScriptDialog("Mission directory","", this);
	}
	
	[ButtonAttribute("OK")]
	void DialogOk()
	{
	}
};

static string g_ModFolder;
static string ModFolder()
{
	g_ModFolder = "P:/Mod-Name/";	
	return g_ModFolder;
}

static string g_ServerFolder;
static string serverFolder()
{                     
	g_ServerFolder = "E:/2024 Projects/DayZ Projects/DayZ-Project-Template/";	
	return g_ServerFolder;
}
