// Cherno Server 
[WorkbenchPluginAttribute("Run: Cherno ", "Starts Cherno Dev Server", "ctrl+1", "", {"ResourceManager","ScriptEditor"})]
class RunCherno: DayZTool
{
	[Attribute("E:/2024 Projects/DayZ Projects/DayZ-Project-Template/Servers/Cherno/StartServer.bat", "", "Starts Livonia Server", "")]
    string BatchFile;

    override void Run() {
        RunDayZBat(BatchFile, true);
    }
}

// Livonia Server 
[WorkbenchPluginAttribute("Run: Livonia ", "Starts Livonia Dev Server", "ctrl+2", "", {"ResourceManager","ScriptEditor"})]
class RunLivonia: DayZTool
{	
	[Attribute("E:/2024 Projects/DayZ Projects/DayZ-Project-Template/Servers/Livonia/StartServer.bat", "", "Starts Livonia Server", "")]
    string BatchFile;
    
	override void Run()
    {
      RunDayZBat(BatchFile, true);
    }
}

// Run Server with Selection
[WorkbenchPluginAttribute("Run: Select Server", "Starts a selected DayZ Server", "ctrl+3", "", {"ResourceManager", "ScriptEditor"})]
class RunServer: DayZTool
{

    [Attribute("ValuesHere", "combobox", "Select Server", "", "")]
	int serverSelection;
	

}
