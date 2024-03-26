// Cherno Server 
[WorkbenchPluginAttribute("Run: Cherno ", "Starts Cherno Dev Server", "ctrl+1", "", {"ResourceManager","ScriptEditor"})]
class RunCherno: DayZTool
{
    string BatchFile;
    void RunCherno() {
		 BatchFile = "E:/2024 Projects/DayZ Projects/DayZ-Project-Template/Servers/Cherno/StartServer.bat";
    }
    override void Run() {
        RunDayZBat(BatchFile, true);
    }
}

// Livonia Server 
[WorkbenchPluginAttribute("Run: Livonia ", "Starts Livonia Dev Server", "ctrl+2", "", {"ResourceManager","ScriptEditor"})]
class RunLivonia: DayZTool
{
    string BatchFile;
    void RunLivonia() {
		 BatchFile = "E:/2024 Projects/DayZ Projects/DayZ-Project-Template/Servers/Livonia/StartServer.bat";
    }
    override void Run() {
        RunDayZBat(BatchFile, true);
    }
}
